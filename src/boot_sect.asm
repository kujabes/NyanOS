;
; A boot sector that enters 32-bit protected mode
;
[org 0x7c00]

mov bp, 0x9000                  ; Set the stack for 16-bit real mode
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

call switch_to_pm               ; We should never return from here

jmp $

%include "gdt-pm.asm"
%include "print-rm.asm"
%include "print-pm.asm"
%include "switch-pm.asm"

[bits 32]

BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm        ; Use our 32-bit printing 

    jmp $                       ; Hang

MSG_REAL_MODE: 
    db "Started in 16-bit real mode", 0

MSG_PROT_MODE:
    db "Successfully landed in 32-bit protected mode", 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55