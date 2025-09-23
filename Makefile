# Makefile for building static library lib/libmyutils.a and bin/client_static

CC = gcc
CFLAGS = -Iinclude -Wall -g

SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
LIB_DIR = lib

# utility sources (to be archived into static library)
UTIL_SRCS = $(SRC_DIR)/mystrfunctions.c $(SRC_DIR)/myfilefunctions.c
UTIL_OBJS = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(UTIL_SRCS))

# main program
MAIN_SRC = $(SRC_DIR)/main.c
MAIN_OBJ = $(OBJ_DIR)/main.o

LIB_NAME = libmyutils.a
LIB = $(LIB_DIR)/$(LIB_NAME)
TARGET = $(BIN_DIR)/client_static

.PHONY: all clean

all: $(TARGET)

# link main with static library
$(TARGET): $(MAIN_OBJ) $(LIB)
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $(MAIN_OBJ) -L$(LIB_DIR) -lmyutils

# build library from utility object files
$(LIB): $(UTIL_OBJS)
	@mkdir -p $(LIB_DIR)
	ar rcs $@ $^
	ranlib $@

# generic rule to compile .c -> .o
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR)/*.o $(BIN_DIR)/client_static $(LIB_DIR)/$(LIB_NAME)
