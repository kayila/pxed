# Actually useful variables.

UBUNTU_RELEASE=xenial-updates

# Internal bullshit you can ignore.

TARGET_DIR=./target

CACHE_DIR=./cache

UBUNTU_DIR_PART=ubuntu-installer/${UBUNTU_RELEASE}

IMAGES_DIR=${TARGET_DIR}/images/${UBUNTU_DIR_PART}
PRESEED_DIR=${TARGET_DIR}/preseed/${UBUNTU_DIR_PART}

all: amd64 arm64 i386


dirs:
	mkdir -p ${CACHE_DIR}
	mkdir -p ${IMAGES_DIR}
	mkdir -p ${PRESEED_DIR}

${IMAGES_DIR}/%: ${CACHE_DIR}/%.netboot.tar.gz
	mkdir -p $@
	mkdir -p ${PRESEED_DIR}/$(@F)
	tar xzf $< -C ${IMAGES_DIR} ./ubuntu-installer/$(@F)/initrd.gz ./ubuntu-installer/$(@F)/linux --strip-components=2
	cp $(@F).server.preseed ${PRESEED_DIR}/$(@F)/server.preseed

# amd64 targets

${CACHE_DIR}/amd64.netboot.tar.gz: dirs
	wget http://archive.ubuntu.com/ubuntu/dists/${UBUNTU_RELEASE}/main/installer-amd64/current/images/netboot/netboot.tar.gz -O ${CACHE_DIR}/amd64.netboot.tar.gz -nc || echo "Using cached amd64.netboot.tar.gz."


amd64: ${IMAGES_DIR}/amd64

# arm64 targets

${CACHE_DIR}/arm64.netboot.tar.gz: dirs
	wget http://ports.ubuntu.com/ubuntu-ports/dists/${UBUNTU_RELEASE}/main/installer-arm64/current/images/netboot/netboot.tar.gz -O ${CACHE_DIR}/arm64.netboot.tar.gz -nc || echo "Using cached arm64.netboot.tar.gz."

arm64: ${IMAGES_DIR}/arm64

# i386 targets

${CACHE_DIR}/i386.netboot.tar.gz: dirs
	wget http://archive.ubuntu.com/ubuntu/dists/${UBUNTU_RELEASE}/main/installer-i386/current/images/netboot/netboot.tar.gz -O ${CACHE_DIR}/i386.netboot.tar.gz -nc || echo "Using cached i386.netboot.tar.gz."


i386: ${IMAGES_DIR}/i386


# misc things

clean:
	rm -rf ${TARGET_DIR}

veryclean: clean
	rm -rf ${CACHE_DIR}

#target/preseed/ubuntu-installer/xenial/amd64

.PHONY: all amd64 arm64 clean veryclean
