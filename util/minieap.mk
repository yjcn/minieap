# Makefile for interface implementation: libpcap

LOCAL_PATH := $(call my-dir)

LOCAL_SRC_FILES := $(filter-out ifaddrs.c, $(subst $(LOCAL_PATH)/,,$(wildcard $(LOCAL_PATH)/*.c)))
LOCAL_C_INCLUDES :=
LOCAL_CFLAGS :=
LOCAL_LDFLAGS :=
LOCAL_MODULE := util

include $(APPEND)

LOCAL_SRC_FILES := \
    ifaddrs.c
LOCAL_C_INCLUDES :=
LOCAL_CFLAGS :=
LOCAL_LDFLAGS :=
LOCAL_MODULE := ifaddrs

include $(APPEND)
