all: kpxe

ipxe:
	git clone git://git.ipxe.org/ipxe.git

ipxe/src/bin/undionly.kpxe: ipxe
	$(MAKE) -C ipxe/src bin/undionly.kpxe EMBED=../../bootstrap/checktftp.ipxe

kpxe: ipxe/src/bin/undionly.kpxe
	cp ipxe/src/bin/undionly.kpxe ../files/undionly.kpxe

clean:
	$(MAKE) -C ipxe/src clean
	rm -rf ipxe/src/bin/*

veryclean:
	rm -rf ipxe

.PHONY: kpxe clean veryclean all
