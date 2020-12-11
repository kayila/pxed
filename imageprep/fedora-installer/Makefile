# Configuration

FEDORA_RELEASE ?= 33

# Internal stuff you can ignore.

URL_PREFIX := https://dl.fedoraproject.org/pub/fedora/linux/releases/${FEDORA_RELEASE}/Everything
URL_SUFFIX := os/isolinux

TARGET_DIR=./target

FEDORA_DIR_PART=fedora-installer/${FEDORA_RELEASE}

IMAGES_DIR=${TARGET_DIR}/images/${FEDORA_DIR_PART}
ENTRY_DIR=${TARGET_DIR}/entries

all: amd64

${ENTRY_DIR}:
	mkdir -p ${ENTRY_DIR}
	cp fedora.php ${ENTRY_DIR}

amd64: ${ENTRY_DIR}
	mkdir -p ${IMAGES_DIR}/$(@F)
	wget ${URL_PREFIX}/x86_64/${URL_SUFFIX}/initrd.img -O ${IMAGES_DIR}/amd64/initrd.img
	wget ${URL_PREFIX}/x86_64/${URL_SUFFIX}/vmlinuz -O ${IMAGES_DIR}/amd64/vmlinuz
	chmod ugo+r ${IMAGES_DIR}/amd64/initrd.img ${IMAGES_DIR}/amd64/vmlinuz

clean:
	rm -rf ${TARGET_DIR} ${ENTRY_DIR}

.PHONY: all amd64 clean
