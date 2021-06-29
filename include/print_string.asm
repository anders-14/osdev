;; print_string.asm
;; Params:
;; si - string memory address start
print_string:
    pusha               ; Move all registers to stack to avoid unwanted behavoir
    xor ax, ax
    mov ds, ax
    mov ah, 0x0E        ; AL is passed as an argument to INT 0x10 (says to print character in AH=
    xor bh, bh          ; Set BH (page number) to zero
.loop:
    lodsb               ; Load byte from DS:SI into AL
    or al, al
    jz .done            ; If at end of string jump to done
    int 0x10            ; Print char in Al
    jmp .loop           ; Continue looping

.done:
    popa                ; Restore registers
    ret
