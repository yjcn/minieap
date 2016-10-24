LOCAL_SRC_FILES := $(wildcard *.c)
LOCAL_OBJ_FILES := $(LOCAL_SRC_FILES:.c=.o)
LOCAL_CFLAGS :=

.PHONY: all
all: $(LOCAL_OBJ_FILES)

$(LOCAL_OBJ_FILES):
	$(CC) -c $(@:.o=.c) $(COMMON_CFLAGS) $(LOCAL_CFLAGS) -o $(OBJ_DIR)/$@

.PHONY: clean
clean:
	rm -f $(addprefix $(OBJ_DIR)/, $(LOCAL_OBJ_FILES))
