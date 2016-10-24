LOCAL_SRC_FILES := $(wildcard *.c) $(wildcard rjv3_hashes/*.c)
LOCAL_OBJ_FILES := $(LOCAL_SRC_FILES:.c=.o)
LOCAL_CFLAGS := -Irjv3_hashes

.PHONY: all
all: $(LOCAL_OBJ_FILES)

$(LOCAL_OBJ_FILES):
	$(CC) -c $(@:.o=.c) $(COMMON_CFLAGS) $(LOCAL_CFLAGS) -o $(OBJ_DIR)/$(notdir $@)

.PHONY: clean
clean:
	rm -f $(addprefix $(OBJ_DIR)/, $(LOCAL_OBJ_FILES))
