org 0x7C00
bits 16

    jmp start

    %include "./include/read_disk.asm"

start:
    ; Setup memory to load kernel into
    mov bx, 0x100
    mov es, bx
    mov bx, 0x00
    
    mov dh, 0x01                    ; number of sectors to read
    call read_disk

    jmp 0x0100:0x0000               ; jump to kernel at 0x100:0x0 = 0x1000

    ; Sector padding
    times 510-($-$$) db 0
    ; Magic boot number
    db 0x55
    db 0xAA
