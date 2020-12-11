all: pxeoverlay

pxeoverlay: ubuntu-installer dban
	mkdir -p pxeoverlay
	cp start.ipxe pxeoverlay/
	cp start.php pxeoverlay/
	cp -rv ./*/target/* pxeoverlay/

memtest:
	$(MAKE) -C memtest

ubuntu-installer:
	$(MAKE) -C ubuntu-installer

dban:
	$(MAKE) -C dban

clean:
	# $(MAKE) -C memtest clean
	$(MAKE) -C ubuntu-installer clean
	$(MAKE) -C dban clean
	rm -rf pxeoverlay

.PHONY: memtest ubuntu-installer dban clean all pxeoverlay
