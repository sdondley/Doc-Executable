unit module Doc::Executable;
use Doc::Executable::Parser;
use Distribution::Resources::Menu;

my $rsm = ResourceMenu.new(
    distribution => $?DISTRIBUTION,
    resources    => %?RESOURCES
);

sub execute is export {
    my @parsed = parse-file $rsm.execute.file-path;
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

=head1 ROADMAP

=item Documentation for creating new executable doc text files
=item Allow users to open a file outside of the distro.
=item Allow users to add their own library of executable documents.
=item Permit execution of on example at a time instead of the whole file.
=item Search examples by keyword
=item Editing of executable documents

Other suggestion on how to make this module more useful are welcome.

=head1 AUTHOR

Steve Dondley <s@dondley.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Steve Dondley

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
