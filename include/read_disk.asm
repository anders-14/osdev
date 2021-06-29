;; Params:
;; dh - number of sectors to read
;; ES:BX - buffer to write data into
read_disk:
    mov al, dh                      ; move argument into correct register

    mov dh, 0x00                    ; head number
    mov dl, 0x80                    ; drive number
    mov ch, 0x00                    ; cylinder number
    mov cl, 0x02                    ; sector number 1 = boot

    mov ah, 0x02                    ; int 0x13 function to call, read disk
    int 0x13

    jc read_disk                    ; carry flag is set on error, try again

    ret
