#### Choose/Add your modules here ####
PLUGIN_MODULES := \
	if_impl_libpcap \
	if_impl_sockraw \
	packet_plugin_printer \
	packet_plugin_rjv3

# If your platform does not provide ifaddrs, add your own implementation here
#PLUGIN_MODULES += ifaddrs

#### Common bits ####
APPEND := $(shell pwd)/append.mk
COMMON_C_INCLUDES := . util
COMMON_MODULES := \
	util \
	main

BUILD_MODULES := $(PLUGIN_MODULES) $(COMMON_MODULES)

minieap: $(BUILD_MODULES)
	$(CC) -o minieap \
        $(foreach objs,$(addsuffix _LDFLAGS,$(BUILD_MODULES)),$($(objs))) \
        $(foreach objs,$(addsuffix _PRIV_OBJS,$(BUILD_MODULES)),$($(objs)))

.PHONY: clean
clean: $(addsuffix _clean,$(BUILD_MODULES))

define my-dir
$(dir $(lastword $(MAKEFILE_LIST)))
endef

MK_LIST := $(shell find . -name minieap.mk)
include $(MK_LIST)
