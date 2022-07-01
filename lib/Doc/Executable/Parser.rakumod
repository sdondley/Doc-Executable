use v6.d;
unit module Doc::Executable::Parser;
use Doc::Executable::Subroutines;
#use Grammar::Debugger;

grammar Parser {
    token TOP { \s* <section>+ }
    regex section { <header>? <intro>? <code-block>+ }
    token intro { (. <!code-delimiter>)+ . }
    token header { <.header-char> <(<header-text>)> }
    token header-char { '#*' \s* }
    token header-text { \N* }
    token code-block { <.code-delimiter> <(.*?)> <.code-delimiter> }
    token code-delimiter { \s* ^^ '##' \h* \n* }
    token newline { \n }
}

class Actions {
    method TOP($/) {
        my @sections;
        for $<section> -> $section {
            my %section;
            my $header = $section<header><header-text> ?? $section<header><header-text>.Str.trim !! '';
            my $intro =  $section<intro> ?? $section<intro>.Str.trim !! '';
            $intro = $intro.subst(/^^ '#*' \s*/, '');
            %section<meta> = [ $header, $intro ];
            %section<code> = $section.made;
            push @sections, %section;
        }
        make @sections;
    }

    method section($/) {

        if $<code-block> {
            my @blocks;
            for $<code-block> -> $block {
                push @blocks, $block.made;
            }
            make @blocks;
        }
    }

    method code-block($/) {
        my @subsections =  $/.Str.split(/\s+ '#*' \s*/);
        for @subsections[1..*-1] <-> $text {
            $text = $text.subst(/^^ '#' \s* / , '');
        }
        make @subsections;
    }
}

sub parse-file(Str:D $path) is export {
    my $file = slurp $path;
    return Parser.parse($file, actions => Actions.new ).made;
}

sub eval-file(@parsed) is export {
    for @parsed -> $section {
        my $heading = $section<meta>[0] || '';
        my $intro = $section<meta>[1] || '';
        say $heading.uc ~ "\n" if $heading && !$intro;
        say $heading.uc if $heading && $intro;
        say $intro ~ "\n" if $intro;
        for $section<code>.Array {
            die "Failed parse example from, check the file's syntax." if $_.^name eq 'Any';
            das |$_>>.trim;
        }
    }

}
