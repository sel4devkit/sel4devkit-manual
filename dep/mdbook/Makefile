################################################################################
# Makefile
################################################################################

#===========================================================
# Check
#===========================================================
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

#===========================================================
# Layout
#===========================================================
OUT_PATH := out

#===========================================================
# Usage
#===========================================================
.PHONY: usage
usage:
	@echo "usage: make <target>"
	@echo ""
	@echo "<target> is one off:"
	@echo "all"
	@echo "clean"

#===========================================================
# Target
#===========================================================
.PHONY: all
all: ${OUT_PATH}/mdbook

${OUT_PATH}:
	mkdir ${OUT_PATH}

${OUT_PATH}/mdbook: | ${OUT_PATH}
	curl --location "https://github.com/rust-lang/mdBook/releases/download/v0.4.40/mdbook-v0.4.40-x86_64-unknown-linux-gnu.tar.gz" --output ${OUT_PATH}/mdbook-v0.4.40-x86_64-unknown-linux-gnu.tar.gz 
	gunzip ${OUT_PATH}/mdbook-v0.4.40-x86_64-unknown-linux-gnu.tar.gz
	tar --directory ${OUT_PATH} --extract --file ${OUT_PATH}/mdbook-v0.4.40-x86_64-unknown-linux-gnu.tar

.PHONY: clean
clean:
	rm -rf ${OUT_PATH}

################################################################################
# End of file
################################################################################
