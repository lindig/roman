
# Roman - convert roman numerals to integer

This repository provides an OCaml module and minimal command line tool to
convert modern roman numerals to integer:

    $ ./roman mmxv
    mmxv = 2015

# Build

    $ make
    $ make PREFIX=$(HOME) install 

The implementation is in `roman.mll` and uses the ocamllex to build an
automaton for recognising roman numerals. To use as a module, simply copy
`roman.mll` and `roman.mli` into your own project. (I didn't bother yet to
pack it up for Opam.)

# Syntax

For the syntax of roman numerals recognised by the module, take a look at
`roman.mll` where it is encoded as a regular expression.

# Author

Christian Lindig <lindig@gmail.com>

# License

This code is in the public domain.


