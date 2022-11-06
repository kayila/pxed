all: build-if-needed imageprep/pxeoverlay

.PHONY: check
check:
	docker images --format '{{.Repository}}' | grep -q '^pxed$$'

.PHONY: imageprep/pxeoverlay
imageprep/pxeoverlay:
	$(MAKE) -C imageprep

.PHONY: build-if-needed
build-if-needed:
	$(MAKE) check 2>/dev/null || $(MAKE) build

.PHONY: build
build:
	(cd docker && docker build . -t pxed)

.PHONY: kpxeprep
kpxeprep:
	(cd kpxeprep && ./build.sh)

.PHONY: demo
demo: all
	docker run -it --rm -p 80:80 -p 69:69/udp --name pxed pxed

.PHONY: run-once
run-once: all
	docker run -it --rm -p 80:80 -p 69:69/udp -v $(shell pwd)/imageprep/pxeoverlay:/tftpboot/pxe:z --name pxed pxed

.PHONY: run
run: all
	docker run -d --restart=always -p 80:80 -p 69:69/udp -v $(shell pwd)/imageprep/pxeoverlay:/tftpboot/pxe:z --name pxed pxed

.PHONY: clean
clean:
	docker rmi pxed || true
	$(MAKE) -C imageprep clean

