ASM = nasm
SRC_DIR = src
BIN_DIR = bin

# Create final binary
$(BIN_DIR)/os.bin: $(BIN_DIR)/temp.bin
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd if=$(BIN_DIR)/temp.bin of=$@ conv=notrunc
	rm -f $(BIN_DIR)/*[!os].bin

$(BIN_DIR)/temp.bin: $(BIN_DIR)/boot.bin $(BIN_DIR)/kernel.bin
	cat $^ > $@

$(BIN_DIR)/boot.bin: $(SRC_DIR)/boot.asm $(BIN_DIR)
	nasm -f bin -o $@ $<

$(BIN_DIR)/kernel.bin: $(SRC_DIR)/kernel.asm
	nasm -f bin -o $@ $<

$(BIN_DIR):
	mkdir -p $@

# Run os in qemu
run:
	qemu-system-i386 -drive format=raw,file=$(BIN_DIR)/os.bin,media=disk

# Clean build directory
clean:
	rm -f $(BIN_DIR)/*

