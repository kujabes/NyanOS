; Load DH sectors to ES:BX from drive DL
disk_load:
    push dx         ; Store DX on the stack so later we can recall how many sectors were request to be read
                    ; even if DX is altered in the meantime.

    mov ah, 0x02    ; BIOS read sector function
    mov al, dh      ; Read DH sectors
    mov ch, 0x00    ; Select cylinder 0
    mov dh, 0x00    ; Select head 0
    mov cl, 0x02    ; Start reading from the second sector

    int 0x13        ; BIOS interrupt

    jc disk_error   ; Jump if error (carry flag set)

    pop dx          ; Restore DX from the stack
    cmp dh, al      ; Make sure we read the correct amount of sectors
    jne disk_error
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string


jmp $

DISK_ERROR_MSG:
    db "Disk read error!", 0