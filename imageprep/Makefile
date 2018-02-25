all: ubuntu-installer

pxeoverlay:
	mkdir -p pxeoverlay
	cp start.ipxe pxeoverlay/
	cp -rv ./*/target/* pxeoverlay/

memtest:
	$(MAKE) -C memtest

ubuntu-installer:
	$(MAKE) -C ubuntu-installer

clean:
	# $(MAKE) -C memtest clean
	$(MAKE) -C ubuntu-installer clean
	rm -rf pxeoverlay

.PHONY: memtest ubuntu-installer clean all pxeoverlay
