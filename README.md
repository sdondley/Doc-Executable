[![Actions Status](https://github.com/sdondley/Doc-Executable/actions/workflows/test.yml/badge.svg)](https://github.com/sdondley/Doc-Executable/actions)

Doc::Executable
===============

Doc::Executable - executes a menu for selecting "executable" Raku tutorials in this distribution which are parsed and executed as Raku code.

SYNOPSIS
========

From the command line:

```raku
docexec
```

GOALS
=====

The goal of `Doc::Executable` is to make it easy to write plain text Raku tutorials containing code snippets with accompanying explanations.

DESCRIPTION
===========

The `docexec` command displays a navigable menu on the command line to allow users to select a parseable text file. The text file contains example Raku code along with explanations accompanying each bit of code. Once parsed, the resultant file is run as Raku code with the output showing the results of the code along with the descriptions for how the code works.

This module is in its early development stages and admittedly has limited use, allowing only for the execution of an entire code example file at once. Also, it can only load and execute files packaged in this distribution.

Executable docs? Why?
---------------------

Anyone who has looked at code documentation has seen embedded code examples like this to illustrate how code works:

```raku
(1, 2, 3).shift;      # Error Cannot call 'shift' on an immutable 'List'
(1, 2, 3).unshift(0); # Error Cannot call 'unshift' on an immutable 'List'
```

Often you want to fiddle with the code so you have to break out the electronic scissors and tediously copy and paste the code into a file and then execute it.

So the idea behind a executable doc is to allow you to easily place your collection of code snippets into a single file where they can be more easily edited and to standarize how the examples are output when executed.

A single executable doc example looks like this:

```raku
##
say 1, 2;
say (1, 2);
#* To pass Lists to a function, be sure to use parentheses
#* Without parentheses, the two elements are treated as separate parameters to the 'say' function
# A List is passed with parentheses which gives a different output.
##
```

This plain text file is written with your favorite text editor.

After getting parsed and executed by this module, it outputs:

    To pass Lists to a function, be sure to use parentheses:

    say 1, 2;
    say (1, 2);

    Output:
    12
    (1 2)

    Without parentheses, the two elements are treated as separate parameters to the 'say' function
    A List is passed with parentheses which gives a different output..

And now this output can be exported to your favorite online tutorial.

ROADMAP
=======

As mentioned, the module in it's current state is rather limited and is more just a proof of concept. Future ideas for improving this distribution include:

  * Adding more executable docs

  * Documentation for creating new executable doc text files

  * Allow users to open a file outside of the distro.

  * Allow users to add their own library of executable documents.

  * Permit execution of on example at a time instead of the whole file.

  * Templates for output (e.g. for HTML or markdown)

  * Search examples by keyword

  * Editing of executable documents

Other suggestion on how to make this module more useful are welcome.

AUTHOR
======

Steve Dondley <s@dondley.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Steve Dondley

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

