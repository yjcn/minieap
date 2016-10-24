SELECTED_IF_IMPL := \
	sockraw \
	libpcap

SELECTED_PACKET_PLUGIN := \
	printer \
	rjv3

COMMON_MODULES := \
	util \
	.

LDFLAGS := -lpcap

TOP_DIR := $(shell pwd)

OBJ_DIR := $(TOP_DIR)/build/obj

COMMON_CFLAGS := -I$(TOP_DIR) -I$(TOP_DIR)/util

export CC OBJ_DIR TOP_DIR COMMON_CFLAGS

SUB_DIRS := \
	$(addprefix if_impl/, $(SELECTED_IF_IMPL)) \
	$(addprefix packet_plugin/, $(SELECTED_PACKET_PLUGIN)) \
	$(addprefix ./, $(COMMON_MODULES))

minieap: makedir $(addsuffix _build,$(SUB_DIRS))
	$(CC) $(LDFLAGS) -o build/minieap $(wildcard $(OBJ_DIR)/*.o)

.PHONY: clean
clean: $(addsuffix _clean,$(SUB_DIRS))

.PHONY: makedir
makedir:
	mkdir -p build/obj

$(addsuffix _build,$(SUB_DIRS)):
	$(MAKE) -C $(@:_build=) -f minieap.mk

$(addsuffix _clean,$(SUB_DIRS)):
	$(MAKE) -C $(@:_clean=) -f minieap.mk clean
