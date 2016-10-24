SELECTED_MODULES := \
	if_impl_libpcap \
	if_impl_sockraw \
	packet_plugin_printer \
	packet_plugin_rjv3

APPEND := $(shell pwd)/append.mk
COMMON_C_INCLUDES := . util
COMMON_MODULES := \
	util \
	main

minieap: $(SELECTED_MODULES) $(COMMON_MODULES)
	$(CC) -o minieap $(foreach objs,$(addsuffix _LDFLAGS, $(SELECTED_MODULES)),$($(objs))) \
        $(foreach objs,$(addsuffix _PRIV_OBJS, $(SELECTED_MODULES)),$($(objs))) \
        $(foreach objs,$(addsuffix _PRIV_OBJS, $(COMMON_MODULES)),$($(objs)))

.PHONY: clean
clean: $(addsuffix _clean, $(SELECTED_MODULES)) $(addsuffix _clean, $(COMMON_MODULES))

define my-dir
$(dir $(lastword $(MAKEFILE_LIST)))
endef

MK_LIST := $(shell find . -name minieap.mk)
include $(MK_LIST)
