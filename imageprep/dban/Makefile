# Actual useful variables

IMAGE=dban.bzi

# Internal bullshit you can ignore.

TARGET_DIR=./target

IMAGES_DIR=${TARGET_DIR}/images
ENTRY_DIR=${TARGET_DIR}/entries

${IMAGES_DIR}/${IMAGE}: dirs
	cp ${IMAGE} ${IMAGES_DIR}/${IMAGE}
	chmod ugo+r ${IMAGES_DIR}/${IMAGE}
	cp dban.php ${ENTRY_DIR}/

dirs:
	mkdir -p ${IMAGES_DIR}
	mkdir -p ${ENTRY_DIR}


# misc things

clean:
	rm -rf ${TARGET_DIR}

.PHONY: clean
