# Configuration

RELEASE ?= bullseye

ARCH ?= amd64

# Internal stuff you can ignore.

CACHE_BASE_DIR=./cache
CACHE_DIR=${CACHE_BASE_DIR}/${RELEASE}

URL_PREFIX := https://deb.debian.org/debian/dists/${RELEASE}/main
URL_SUFFIX := current/images/netboot/netboot.tar.gz

TARGET_BASE_DIR=./target
TARGET_DIR=${TARGET_BASE_DIR}/images/${RELEASE}

MENU_DIR=${TARGET_BASE_DIR}/entries

.PHONY: all
all: installer-amd64

# amd64 targets
${CACHE_DIR}/installer-amd64.netboot.tar.gz:
	mkdir -p ${CACHE_DIR}
	-wget ${URL_PREFIX}/installer-amd64/${URL_SUFFIX} -O ${CACHE_DIR}/installer-amd64.netboot.tar.gz -nc

${MENU_DIR}:
	mkdir -p ${MENU_DIR}
	cp debian.php ${MENU_DIR}

export MENU_ENTRY_BODY

.PHONY: installer-amd64
installer-amd64: ${CACHE_DIR}/installer-amd64.netboot.tar.gz
	mkdir -p ${TARGET_DIR}
	tar -xf ${CACHE_DIR}/installer-amd64.netboot.tar.gz -vz -C ${TARGET_DIR}
	mkdir -p ${MENU_DIR}
	printf "$$MENU_ENTRY_BODY" > ${MENU_DIR}/debian-${RELEASE}-${ARCH}.php

.PHONY: clean
clean:
	rm -rf ${TARGET_DIR} ${MENU_DIR}/debian-${RELEASE}-${ARCH}.php

.PHONY: veryclean
veryclean:
	rm -rf ${TARGET_BASE_DIR}

.PHONY: cleancache
cleancache:
	rm -rf ${CACHE_DIR}

.PHONY: verycleancache
verycleancache:
	rm -rf ${CACHE_BASE_DIR}


define MENU_ENTRY_BODY
<?php
	$$entries[] = array(
	  "key" => "debian-${RELEASE}-${ARCH}",
	  "title" => "Install Debian ${RELEASE} ${ARCH}",
	  "body" => <<<BODY
set 210:string http://$${next-server}/
set 209:string images/${RELEASE}/debian-installer/${ARCH}/pxelinux.cfg/default
chain /images/${RELEASE}/pxelinux.0
BODY
  );
?>
endef

define newline

endef
