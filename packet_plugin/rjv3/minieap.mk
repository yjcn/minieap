# Makefile for interface implementation: libpcap

LOCAL_PATH := $(call my-dir)

LOCAL_SRC_FILES := \
    $(subst $(LOCAL_PATH)/,,$(wildcard $(LOCAL_PATH)/*.c)) \
    $(subst $(LOCAL_PATH)/,,$(wildcard $(LOCAL_PATH)/rjv3_hashes/*.c))
LOCAL_C_INCLUDES := rjv3_hashes
LOCAL_CFLAGS :=
LOCAL_LDFLAGS :=
LOCAL_MODULE := packet_plugin_rjv3

include $(APPEND)
