unit module Doc::Executable;
use Doc::Executable::Parser;
use Distribution::Resources::Menu;

my $rsm = ResourceMenu.new(
        distribution => $?DISTRIBUTION,
        resources => %?RESOURCES
        );

sub execute($file?) is export {
    my $fh = open "$*TMPDIR/file", :w;
    $fh.say: "This is the contents of the file";
    $fh.close;
    my @parsed = parse-file ($file ?? $file !! $rsm.execute.file-path);
    eval-file(@parsed);
}

=begin pod

=head1 Doc::Executable

Doc::Executable - executes a menu for selecting "executable" Raku tutorials in
this distribution which are parsed and executed as Raku code.

=head1 SYNOPSIS

From the command line:
=begin code :lang<raku>
docexec
=end code

=head1 GOALS

The goal of C<Doc::Executable> is to make it easy to write plain text Raku tutorials containing
code snippets with accompanying explanations.

=head1 DESCRIPTION

The C<docexec> command displays a navigable menu on the command line to allow users to
select a parseable text file. The text file contains example Raku code along with explanations
accompanying each bit of code. Once parsed, the resultant file is run as Raku code with the output
showing the results of the code along with the descriptions for how the code works.

This module is in its early development stages and admittedly has limited use, allowing
only for the execution of an entire code example file at once. Also, it can only
load and execute files packaged in this distribution.

=head2 Executable docs? Why?

Anyone who has looked at code documentation has seen embedded code examples like this to
illustrate how code works:

=begin code :lang<raku>

(1, 2, 3).shift;      # Error Cannot call 'shift' on an immutable 'List'
(1, 2, 3).unshift(0); # Error Cannot call 'unshift' on an immutable 'List'

=end code

Often you want to fiddle with the code so you have to break out the electronic
scissors and tediously copy and paste the code into a file and then execute it.

This gets tedious.

So the idea behind a executable doc is to allow you to easily place your collection
of code snippets into a single file and easily edit them with less hassle.

A single executable doc example looks like this:

=begin code :lang<raku>

##
say 1, 2;
say (1, 2);
#* To pass Lists to a function, be sure to use parentheses
#* Without parentheses, the two elements are treated as separate parameters to the 'say' function
# A List is passed with parentheses which gives a different output.
##

=end code

This plain text file is written with your favorite text editor.

After getting parsed and executed by this module, it outputs:

=begin code
To pass Lists to a function, be sure to use parentheses:

say 1, 2;
say (1, 2);

Output:
12
(1 2)

Without parentheses, the two elements are treated as separate parameters to the 'say' function
A List is passed with parentheses which gives a different output..
=end code

And now this output can be exported to your favorite online tutorial.

=head1 ROADMAP

As mentioned, the module in it's current state is rather limited and is
more just a proof of concept. Future ideas for improving this distribution
include:

=item Adding more executable docs
=item Documentation for creating new executable doc text files
=item Allow users to open a file outside of the distro.
=item Allow users to add their own library of executable documents.
=item Permit execution of on example at a time instead of the whole file.
=item Templates for output (e.g. for HTML or markdown)
=item Search examples by keyword
=item Editing of executable documents

Other suggestion on how to make this module more useful are welcome.

=head1 AUTHOR

Steve Dondley <s@dondley.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Steve Dondley

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
