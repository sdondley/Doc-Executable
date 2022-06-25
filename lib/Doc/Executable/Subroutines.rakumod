use v6.d;

unit module Docs::Executable::Subroutines;

sub blank(Int:D $lines = 0) is export {
    (loop { say '' })[$lines];
}

sub print-description($block) {
    if $block<description> {
        $block<description> ~= ':' when $block<description>.substr(*-1) ne ':';
        $block<description>.=subst(/\. \: $$/, ':');
    }
    .say with $block<description>;
}

sub print-code($block) {
    blank when $block<line-count> != 1;
    $block<lines>>>.say;
    blank;
}

sub print-output($block) {
    my $label = $block<say> ?? "Output:\n" !! "Evaluates to: ";
    print $label;
    if ($block<line-count> == 1) {
        print-evaluation($block<lines>, $block<say>);
        return;
    }
    print-evaluation($block<lines>.join("\n"), $block<say>);
}

sub print-evaluation($code, $say) {

    if $say {
        try { $code.EVAL.gist };
    } else {
        try { say $code.EVAL.gist };
    }
    if $! { say 'ERROR!'; say $!.Str }
}

sub print-explanation($block) {
    if $block<explanation> {
        $block<explanation> ~= '.' when $block<description>.substr(*- 1) ne '.';
    }
    blank if $block<say>;
    .say with $block<explanation>;
    blank 2;
}

sub das(Str:D $code, Str $description = Str, Str $explanation = Str ) is export {
    my @lines = $code.split("\n");
    my $line-count = @lines.elems;
    my $say = ($code ~~ /^^say|\.say/) ?? True !! False;
    my %block = :@lines, :$line-count, :$description, :$explanation, :$say;
    print-description(%block);
    print-code(%block);
    print-output(%block);
    print-explanation(%block);
}


