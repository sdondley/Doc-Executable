use v6.d;
unit module Doc::Executable::Resources;

sub resources is export {
    return %?RESOURCES;
}

sub distribution is export {
    return $?DISTRIBUTION;
}

sub meta is export {
    $*PROGRAM.parent.('META6.json');
}


class Resources is export {
    has $.root;
    has @.directories;
    has @.files;

    class Resource {
        has $.name;
        has $.path;
        has $.parent;
        has $.depth;
    }

    class directory is Resource {
        has @.subdirs;
        has @.files;
    }

    # TODO Replace this class with new method of getting resources
    class file is Resource {
        use Doc::Executable::Subroutines;
        use Doc::Executable::Parser;
        method parse() {
            my @parsed = parse-file self.path.Str;
            die "Failed parse examples from self.file" if @parsed.^name eq 'Any';
            for @parsed -> $section {
                my $heading = $section<meta>[0] || '';
                my $intro = $section<meta>[1] || '';
                say $heading.uc ~ "\n" if $heading && !$intro;
                say $heading.uc if $heading && $intro;
                say $intro ~ "\n" if $intro;
                for $section<code>.Array {
                    die "Failed parse examples from self.file, check it's syntax." if $_.^name eq 'Any';
                    das |$_>>.trim;
                }
            }
        }
    }

    multi sub trait_mod:<is>(Method $obj, Bool :$path-checked) {
        $obj.wrap: -> $inv, $path, |c {
            if $path.starts-with: $inv.root {
                callsame;
            } else {
                callwith $inv, $inv.root ~ $path, |c;
            }
        }
    }

    sub dir-content($path) {
        return dir $?DISTRIBUTION.content($path);
    }

    method recurse(Str:D $cur-path, Int:D $depth, Str $parent? ) {
        my $dir = directory.new(path => $cur-path, :$depth, :$parent, name => $cur-path.IO.basename);
        @.directories.push($dir);

        my $has-file;
        my $has-dir;
        for dir-content($cur-path).Array -> $path {
            # check to make sure there are no other directories that have both a file and directory
            $has-file = True if $path.f;
            $has-dir = True if $path.d;
            if $has-file && $has-dir {
                die "Topic directories can only contain only files or directories, not both.";
            }
            if $path.d {
                $dir.subdirs.push($path.Str);
                self.recurse($path.Str, $depth + 1, $dir.path.Str  )
            } else {
                if ($depth < 1) {
                    die "Do not place files into the example root directory";
                }
                my $file = file.new(:$path, :$depth, parent => $cur-path, name => $path.IO.basename);
                $dir.files.push($file);
                @.files.push($file);
            }
        }
    }

    method list-lessons() { self.lessons.sort>>.say }
    method list-topics() { self.topics.sort>>.say }
    method topics() { @.directories.map: { .name if .depth == 1}; }

    method lessons() {
        @.files.map: { .name }
    }

    multi method parse-lesson(Str:D $name) {
        self.lesson-get($name).parse;
    }

    method lesson-from-path(Str:D $path) is path-checked {
        (self.files.grep: { .path.Str eq $path })[0] ||
        die "There is no lesson for path $path";
    }

    method has-separator(Str:D $path) {
        (IO::Spec::Unix.splitpath($path))[1] ?? True !! False;
    }

    method lesson-get(Str:D $resource) {
        if !self.has-separator($resource) {
            if self.lesson-is-unique($resource) {
                my @lesson = @.files.grep: { .name eq $resource };
                return @lesson[0];
            } else {
                die "'$resource' is not a unique name."
            }
        }
        return self.lesson-from-path($resource);
    }

    method lesson-is-unique(Str:D $name) {
        (@.files.grep: { .name eq $name }).elems == 1 ?? True !! False;
    }

    method resource-exists(Str:D $path) is path-checked {
        return 'lesson' if self.is-file($path);
        return 'topic' if self.is-dir($path);
        return False;
    }

    method topic-contains-lessons(Str:D $path) is path-checked {

    }

    method is-file(Str:D $path) is path-checked {
        return True if @.files.map: { .path eq $path };
    }

    method is-dir(Str:D $path) is path-checked {
        return True if @.directories.map: { .path eq $path };
    }

    method get-name($path) is path-checked {
        @.directories.map: { .name if .path eq $path };
    }

    submethod BUILD(Str:D $dir = 'resources/examples/') {
        $!root = $dir;
        self.recurse($dir, 0, $dir);
        #self.build-topics();
    }

    method new(Str:D $dir = 'resources/examples/') {
        self.bless(root => $dir);
    }
}


