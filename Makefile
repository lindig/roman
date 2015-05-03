#
#

OCB	= ocamlbuild
PREFIX	= $(HOME)

all:
	$(OCB) main.native
	mv main.native roman

test:	all
	./roman -test
	./roman mmxv
	./roman mcmxcix
	./roman mdcccl
	./roman xxxx || true
	./roman im || true


clean:
	$(OCB) -clean
	rm -f roman

install: all
	install roman $(PREFIX)/bin

