# Define the compiler
CC = gcc

# Define the source file and the output binary
SRC = ovfl.c
OUT = ovfl

# Default target to build the application
all: $(OUT)

# Rule to build the output binary from the source file
$(OUT): $(SRC)
	$(CC) -o $(OUT) $(SRC)

# Clean target to remove the compiled binary
clean:
	rm -f $(OUT)

# Phony targets to avoid conflicts with files named "all" or "clean"
.PHONY: all clean
