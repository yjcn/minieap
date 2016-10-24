# Makefile for interface implementation: libpcap

LOCAL_PATH := $(call my-dir)

LOCAL_SRC_FILES := if_impl_sockraw.c
LOCAL_C_INCLUDES :=
LOCAL_CFLAGS :=
LOCAL_LDFLAGS :=
LOCAL_MODULE := if_impl_sockraw

include $(APPEND)
