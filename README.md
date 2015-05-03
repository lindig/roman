
# Roman - convert roman numerals to integer

This repository provides an OCaml module and minimal command line tool to
convert modern roman numerals to integer and vice versa:

    $ roman mmxv
    2015
    $ roman -i 1234
    mccxxxiv

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

This little exercise was prompted by an article [Radikale
Objektorientierung: Teil 2: Verhalten prinzipiengeleitet
verfeinern](http://www.sigs-datacom.de/fachzeitschriften/objektspektrum) in
OBJEKTspektrum issue 2/12015 that used conversion of roman numerals as an
example for OO design. The [code from that article is available on
GitHub](https://github.com/ralfw/TheArchitectsNapkinBlog).

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
`roman.mll` where it is encoded as a regular expression:

    (M|MM|MMM)?
    (D?(C|CC|CCC)?|CD|CM)?
    (L?(X|XX|XXX)?|XL|XC)?
    (V?(I|II|III)?|IV|IX)?

# Author

Christian Lindig <lindig@gmail.com>

# License

This code is licensed under the BSD 2-clause license.


