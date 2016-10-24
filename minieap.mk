# Makefile for interface implementation: libpcap

LOCAL_PATH := $(call my-dir)

LOCAL_SRC_FILES := $(subst $(LOCAL_PATH)/,,$(wildcard $(LOCAL_PATH)/*.c))
LOCAL_C_INCLUDES :=
LOCAL_CFLAGS :=
LOCAL_LDFLAGS :=
LOCAL_MODULE := main

include $(APPEND)
