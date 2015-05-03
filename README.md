
# Roman - convert roman numerals to integer

This repository provides an OCaml module and minimal command line tool to
convert modern roman numerals to integer:

    $ ./roman mmxv
    mmxv = 2015
    $ ./roman mcmxcix
    mcmxcix = 1999
    $ ./roman mdcccl
    mdcccl = 1850

The module accepts the syntax for [modern roman
numerals](http://en.wikipedia.org/wiki/Roman_numerals) as defined by
Wikipedia and detects illegal syntax like the following:

    im 
    xcc  
    ic
    imm
    mxm
    viiii
    ivi

# Build and Test

    $ make
    $ make test
    $ make PREFIX=$(HOME) install 

The implementation is in `roman.mll` and uses ocamllex to build an
automaton for recognising roman numerals. To use as a module, simply copy
`roman.mll` and `roman.mli` into your own project. (I didn't bother yet to
pack it up for Opam.)

# Syntax

For the syntax of roman numerals recognised by the module, take a look at
`roman.mll` where it is encoded as a regular expression.

# Author

Christian Lindig <lindig@gmail.com>

# License

This code is licensed under the BSD 2-clause license.


