SHELL=/bin/bash

PYPY_VERSIONS := pypy-7.1.1 pypy3.5-6.0.0

all: clean build upload publish

BUILD_TARGETS := $(foreach pypy,$(PYPY_VERSIONS),$(pypy).zip)
UPLOAD_TARGETS := $(foreach pypy,$(PYPY_VERSIONS),upload-$(pypy))
PUBLISH_TARGETS := $(foreach pypy,$(PYPY_VERSIONS),publish-$(pypy))

.PHONY: all clean build upload publish $(UPLOAD_TARGETS) $(PUBLISH_TARGETS) shell

$(BUILD_TARGETS): %.zip:
	PYPY_VERSION="$*" ./build.sh

$(UPLOAD_TARGETS): upload-%: %.zip
	PYPY_VERSION="$*" ./upload.sh

$(PUBLISH_TARGETS): publish-% : %.zip
	PYPY_VERSION="$*" ./publish.sh

build: $(BUILD_TARGETS)

upload: $(UPLOAD_TARGETS)

publish: $(PUBLISH_TARGETS)

clean:
	rm -rf layer $(BUILD_TARGETS)

shell:
	docker run --rm -v "${PWD}":/opt lambci/lambda:build-provided sh
