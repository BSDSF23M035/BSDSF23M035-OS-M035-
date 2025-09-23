# Compiler and flags
CC = gcc
CFLAGS = -Iinclude -Wall -g

# Directories
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
LIB_DIR = lib

# Utility sources
UTIL_SRCS = $(SRC_DIR)/mystrfunctions.c $(SRC_DIR)/myfilefunctions.c
UTIL_OBJS = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(UTIL_SRCS))

# Main source
MAIN_SRC = $(SRC_DIR)/main.c
MAIN_OBJ = $(OBJ_DIR)/main.o

# Libraries
STATIC_LIB = $(LIB_DIR)/libmyutils.a
DYNAMIC_LIB = $(LIB_DIR)/libmyutils.so

# Executables
STATIC_TARGET = $(BIN_DIR)/client_static
DYNAMIC_TARGET = $(BIN_DIR)/client_dynamic

.PHONY: all clean install

# Default target builds both static and dynamic executables
all: $(STATIC_TARGET) $(DYNAMIC_TARGET)

# --------------------------
# Static executable
# --------------------------
$(STATIC_TARGET): $(MAIN_OBJ) $(STATIC_LIB)
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $(MAIN_OBJ) -L$(LIB_DIR) -lmyutils

# --------------------------
# Dynamic executable
# --------------------------
$(DYNAMIC_TARGET): $(MAIN_OBJ) $(DYNAMIC_LIB)
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $(MAIN_OBJ) -L$(LIB_DIR) -lmyutils

# --------------------------
# Static library
# --------------------------
$(STATIC_LIB): $(UTIL_OBJS)
	@mkdir -p $(LIB_DIR)
	ar rcs $@ $^
	ranlib $@

# --------------------------
# Dynamic library
# --------------------------
$(DYNAMIC_LIB): $(UTIL_OBJS)
	@mkdir -p $(LIB_DIR)
	$(CC) -shared -fPIC -o $@ $^

# --------------------------
# Compile .c -> .o
# --------------------------
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) -fPIC $(CFLAGS) -c $< -o $@

# --------------------------
# Clean
# --------------------------
clean:
	rm -rf $(OBJ_DIR)/*.o $(BIN_DIR)/* $(LIB_DIR)/*

# --------------------------
# Install target
# --------------------------
install: all
	@echo "Installing client executables and man page..."
	sudo cp $(BIN_DIR)/client_static /usr/local/bin/client_static
	sudo cp $(BIN_DIR)/client_dynamic /usr/local/bin/client_dynamic
	sudo cp man/man3/mycat.1 /usr/local/share/man/man3/
	sudo mandb
	@echo "Installation complete. You can now run 'client_static', 'client_dynamic' and 'man mycat'."
