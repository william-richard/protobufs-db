SHELL := /usr/bin/env bash

PROTOC ?=./.local/protoc/bin/protoc

PROTOS_DIR ?= protos
OUTPUT ?= ./gens

SUFFIX := pb.go

FLAGS+= --go_out=$(OUTPUT) --proto_path=./$(PROTOS_DIR)

DEPS:= $(shell find $(PROTOS_DIR) -type f -name '*.proto' | sed "s/proto$$/$(SUFFIX)/")

compile: sources

sources: $(DEPS)

$(PROTOC):
	./bin/install-protoc.sh

$GOPATH/bin/protoc-gen-go:
	go get -u github.com/golang/protobuf/{proto,protoc-gen-go}

%.$(SUFFIX): %.proto $(PROTOC) $GOPATH/bin/protoc-gen-go
	mkdir -p $(OUTPUT)
	$(PROTOC) $(FLAGS) $*.proto

clean:
	-rm -rdf $(OUTPUT)

really-clean: clean
	-rm -rfv ./.local
