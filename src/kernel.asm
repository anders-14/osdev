org 0x1000

    jmp main

    ; Include files
    %include "./include/print_string.asm"
    %include "./include/print_hex.asm"

main:
    mov ah, 0x00            ; Argument for int 10, set video mode
    mov al, 0x03            ; Set screen to 80x25 16bit color
    int 0x10

    mov ah, 0x0b            ; Argument for int 10, set color pallete
    mov bh, 0x00            ; Select background color
    mov bl, 0x01            ; Set background color blue
    int 0x10

    mov si, welcome_message
    call print_string

echo_loop:
    xor ax, ax              ; Make ax = 0, faster than moving 0 into ax

    int 0x16                ; Get ready for keyboard input, ascii into al, scancode into ah
    cmp al, "Q"             ; Halt on Q
    je halt

    mov ah, 0x0E
    int 0x10                ; Print char typed

    cmp al, 13              ; Compare typed char to CR
    jne .not_newline        ; If not CR -> skip
    mov al, 10              ; Else print LF
    int 0x10

.not_newline
    jmp echo_loop

halt:
    mov si, halt_string
    call print_string
    hlt

welcome_message:        db "Welcome to Anders OS",13,10,0
halt_string:            db 13,10,"Halting the os...",0 

    ; Sector padding
    times 512-($-$$) db 0
