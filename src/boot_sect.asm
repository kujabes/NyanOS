;
; A boot sector that prints a string using our function
;

; Tell the assembler where we think our code will be located
[org 0x7c00] 

    mov bx, HELLO_MSG
    call print_string

    mov bx, GOODBYE_MSG
    call print_string

%include "print_string.asm"

; Data
HELLO_MSG:
    db 'Hello, World!', 0

GOODBYE_MSG:
    db 'Goodbye!', 0

; Padding and magic number
times 510-($-$$) db 0
dw 0xaa55