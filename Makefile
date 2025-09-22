CC = gcc
CFLAGS = -Wall -Iinclude
SRC = $(wildcard src/*.c)
OBJ = $(SRC:src/%.c=obj/%.o)
BIN = bin/client

all: $(BIN)

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

obj/%.o: src/%.c
	@mkdir -p obj
	@mkdir -p bin
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf obj/*.o bin/client
