#
#

OCB	= ocamlbuild
PREFIX	= $(HOME)

all:
	$(OCB) main.native
	mv main.native roman

test:	all
	./roman -test
	! ./roman xxxx
	! ./roman im
	./roman mmxv
	echo "test passed"

clean:
	$(OCB) -clean
	rm -f roman

install: all
	install roman $(PREFIX)/bin

