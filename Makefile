all: build-if-needed imageprep/pxeoverlay

check:
	docker images --format '{{.Repository}}' | grep -q '^pxed$$'

imageprep/pxeoverlay:
	$(MAKE) -C imageprep

build-if-needed:
	$(MAKE) check 2>/dev/null || $(MAKE) build

build: files
	(cd docker && docker build . -t pxed)

kpxeprep:
	(cd kpxeprep && ./build.sh)

demo: all
	docker run -it --rm -p 80:80 -p 69:69/udp --name pxed pxed

run: all
	docker run -it --rm -p 80:80 -p 69:69/udp --name pxed -v $(shell pwd)/imageprep/pxeoverlay:/tftpboot/pxe:z pxed

clean:
	docker rmi pxed || true
	$(MAKE) -C imageprep clean

.PHONY: kpxeprep
