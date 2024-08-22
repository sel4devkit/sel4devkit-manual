################################################################################
# Makefile
################################################################################

#===========================================================
# Check
#===========================================================
ifndef FORCE
    EXP_INFO := sel4devkit-maaxboard-microkit-docker-dev-env 1 *
    CHK_PATH_FILE := /check.mk
    ifeq ($(wildcard ${CHK_PATH_FILE}),)
        HALT := TRUE
    else
        include ${CHK_PATH_FILE}
    endif
    ifdef HALT
        $(error Expected Environment Not Found: ${EXP_INFO})
    endif
endif

#===========================================================
# Layout
#===========================================================
DEP_PATH := dep
SRC_PATH := src
TMP_PATH := tmp
OUT_PATH := out

DEP_MDB_PATH := ${DEP_PATH}/mdbook

#===========================================================
# Usage
#===========================================================
.PHONY: usage
usage:
	@echo "usage: make <target> [FORCE=TRUE]"
	@echo ""
	@echo "<target> is one off:"
	@echo "get"
	@echo "all"
	@echo "publish"
	@echo "clean"

#===========================================================
# Target
#===========================================================
.PHONY: get
get: dep-get

.PHONY: dep-get
dep-get:
	make -C ${DEP_MDB_PATH} get

.PHONY: all
all: dep-all ${OUT_PATH}/book

.PHONY: dep-all
dep-all:
	make -C ${DEP_MDB_PATH} all

${TMP_PATH}:
	mkdir ${TMP_PATH}

${OUT_PATH}:
	mkdir ${OUT_PATH}

.PHONY: always_rebuild
always_rebuild:

${OUT_PATH}/book: always_rebuild ${DEP_MDB_PATH}/out/mdbook | ${OUT_PATH}
	${DEP_MDB_PATH}/out/mdbook build ${SRC_PATH} --dest-dir ../${OUT_PATH}/book

.PHONY: publish
publish: ${OUT_PATH}/book | ${TMP_PATH}
	rm -rf ${TMP_PATH}/sel4devkit.github.io
	git -C ${TMP_PATH} clone --branch "main" "git@github.com:sel4devkit/sel4devkit.github.io.git" sel4devkit.github.io
	rsync --checksum --recursive --delete-after --exclude ".git" ${OUT_PATH}/book/ ${TMP_PATH}/sel4devkit.github.io
	git -C ${TMP_PATH}/sel4devkit.github.io add --all
	git -C ${TMP_PATH}/sel4devkit.github.io commit -m "Publish."
	git -C ${TMP_PATH}/sel4devkit.github.io push

.PHONY: clean
clean:
	make -C ${DEP_MDB_PATH} clean
	rm -rf ${TMP_PATH}
	rm -rf ${OUT_PATH}

################################################################################
# End of file
################################################################################
