gdt_start:

gdt_null:                   ; Define the null descriptor
    dd 0x0 
    dd 0x0

gdt_code:                   ; Code segment descriptor
    dw 0xffff               ; Limit (0-15)
    dw 0x0                  ; Base (0-15)
    db 0x0                  ; Base (16-23)
    db 10011010b            ; 1st flags (present)1 (privilege)00 (descriptor type)1
                            ; Type flags (code)1 (conforming)0 (readable)1 (accessed)0

    db 11001111b            ; 2nd flags (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0
                            ; Limit (16-19)
    db 0x0                  ; Base (24-31)

gdt_data:                   ; Data segment descriptor
                            ; The same as code segment except for type flags.
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b            ; Type flags (code)0 (expand down)0 (writable)1 (accessed)0
    db 11001111b
    db 0x0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1          ; Size of the GDT, always one less of the true size
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start