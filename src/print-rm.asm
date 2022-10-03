
[bits 32]

; Define some constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f                 ; Color byte for each character

; Prints a null-terminated string pointed to by EDX
print_string_pm:
    pusha                               ; Save registers
    mov edx, VIDEO_MEMORY               ; Save the start address of video memory to edx

print_string_pm_loop:
    mov al, [ebx]                       ; [ebx] is the address of our character
    mov ah, WHITE_ON_BLACK

    cmp al, 0                           ; Check if end of string
    je print_string_pm_done

    mov [edx], ax                       ; Store character + attribute in video memory
    add ebx, 1                          ; Next char
    add edx, 2                          ; Next video memory position

    jmp print_string_pm_loop

print_string_pm_done:
    popa                                ; Restore registers
    ret