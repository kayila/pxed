all: kpxe efi

ipxe:
	git clone git://git.ipxe.org/ipxe.git

ipxe/src/bin/%: ipxe
	$(MAKE) -C ipxe/src bin/$(@F) EMBED=../../bootstrap/checktftp.ipxe

ipxe/src/bin-x86_64-efi/%: ipxe
	$(MAKE) -C ipxe/src bin-x86_64-efi/$(@F) EMBED=../../bootstrap/checktftp.ipxe

.PHONY: kpxe
kpxe: ipxe/src/bin/undionly.kpxe
	cp ipxe/src/bin/undionly.kpxe /tmp/files/undionly.kpxe

.PHONY: efi
efi: ipxe/src/bin-x86_64-efi/ipxe.efi
	cp ipxe/src/bin-x86_64-efi/ipxe.efi /tmp/files/ipxe.efi

.PHONY: usb
usb: ipxe/src/bin/ipxe.usb
	cp ipxe/src/bin/ipxe.usb /tmp/files/ipxe.usb

clean:
	$(MAKE) -C ipxe/src clean
	rm -rf ipxe/src/bin/*
	rm -rf ipxe/src/bin-x86_64-efi/*

veryclean:
	rm -rf ipxe

.PHONY: clean veryclean all
