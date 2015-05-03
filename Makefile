#
#

OCB	= ocamlbuild
PREFIX	= $(HOME)

all:
	$(OCB) main.native
	mv main.native roman

test:	all
	./roman -test

clean:
	$(OCB) -clean
	rm -f roman

install: all
	install roman $(PREFIX)/bin

