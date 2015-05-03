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
	for i in $$(seq 1 3999); do ./roman -test $i > /dev/null; done
	echo "test passed"

clean:
	$(OCB) -clean
	rm -f roman

install: all
	install roman $(PREFIX)/bin

