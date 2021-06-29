; print_hex
; Params:
; dx - hex word to print
print_hex:
    pusha                               ; Store registers to stack

    xor cx, cx                          ; Set counter to 0

.loop:
    mov ax, dx                          ; move hex word to print into ax
    and ax, 0x000F                      ; keep only the lower 4th
    ror dx, 4                           ; rotate dx 4 bits to the right, change what bits to keep

    add al, 0x30
    cmp al, 0x39                        ; compare to the number 9
    jle .move_into_hex_string
    add al, 0x07                        ; add 7 to make al equal to the letter of the hex code

.move_into_hex_string:
    mov bx, hex_string+5                ; bx = memory of last byte in hex_string
    sub bx, cx                          ; go to correct byte
    mov [bx], al                        ; mov char into hex_string at right position
    inc cx                              ; increment counter
    cmp cx, 4                           ; if at 4, we are done converting
    jl .loop                            ; else keep looping
    
    mov si, hex_string
    call print_string

.done:
    popa                                ; Restore registers
    ret

hex_string: db "0x0000",0
