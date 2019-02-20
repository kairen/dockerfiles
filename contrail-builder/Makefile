IMAGE = contrail-builder
PKG_PATH := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))pkg
KEY_PATH = $(HOME)/.ssh/id_rsa

.PHONY: all build run

all: build

build:
	echo -e "\033[34m*** Build $(1) ***\033[0m"; \
	docker build -t $(IMAGE) .

run:
	docker run -it --rm -v $(KEY_PATH):/root/.ssh/id_rsa \
	  -e VERSION=3.2.3.x \
		-e CONTRAIL_BRANCH=R3.2.3.x \
	  -v $(PKG_PATH):/tmp/packages \
		$(IMAGE)
