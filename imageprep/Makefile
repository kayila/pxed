.PHONY: all
all: pxeoverlay

.PHONY: pxeoverlay
pxeoverlay: fedora-installer dban debian-installer # ubuntu-installer
	mkdir -p pxeoverlay
	cp start.ipxe pxeoverlay/
	cp start.php pxeoverlay/
	cp -rv ./*/target/* pxeoverlay/

.PHONY: memtest
memtest:
	$(MAKE) -C memtest

.PHONY: debian-installer
debian-installer:
	$(MAKE) -C debian-installer

.PHONY: fedora-installer
fedora-installer:
	$(MAKE) -C fedora-installer

.PHONY: ubuntu-installer
ubuntu-installer:
	$(MAKE) -C ubuntu-installer

.PHONY: dban
dban:
	$(MAKE) -C dban

.PHONY: clean
clean:
	# $(MAKE) -C memtest clean
	$(MAKE) -C fedora-installer clean
	$(MAKE) -C ubuntu-installer clean
	$(MAKE) -C dban clean
	rm -rf pxeoverlay

