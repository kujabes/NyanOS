[bits 16]

; Switch to protected mode
switch_to_pm:
    cli                     ; Switch off interrups until we have set the protected-mode interrupt vector

    lgdt [gdt_descriptor]   ; Load our GDT, which defines our protected mode segments
    
    mov eax, cr0            ; Make the switch to protected mode
    or eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:init_pm    ; Make a far-jump (to a new segment) to our 32-bit code. Force CPU to flush pipeline

[bits 32]

; Initialize the registers and stack once in PM
init_pm:
    mov ax, DATA_SEG        ; Now in PM, our old segments are meaningless, so point our segment registers to data selectors found in GDT
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000        ; Update stack pointer to the top of free space
    mov esp, ebp

    call BEGIN_PM 

