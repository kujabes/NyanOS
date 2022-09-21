; 
; Simple boot sector string-printing function
;

; We expect the parameter to be in the 'bx' register.
print_string:
    mov ah, 0x0e
print:
    mov al, [bx]
    int 0x10
    add bx, 0x01 ; Move address up by 1
    cmp al, 0 ; Check if 0
    jg print ; If greater, keep printing
    ret ; Else return