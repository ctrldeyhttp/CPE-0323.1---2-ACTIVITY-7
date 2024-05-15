dosseg
.model small
.stack
.data
    msg1 db 13, 10, "Enter a two-digit number: $"  
    msg3 db 13, 10, "Decimal: $"  
    msg_hex db 13, 10, "Hexadecimal: $"  
    msg_bin db 13, 10, "Binary: $"  
    msg_oct db 13, 10, "Octal: $"  
    num1 db ?
    num2 db ?
    sum db ?
    res db 5 DUP('$')
    res_hex db 3 DUP('$')  ; Buffer for hexadecimal result
    res_bin db 9 DUP('$')  ; Buffer for binary result
    res_oct db 3 DUP('$')  ; Buffer for octal result
.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt for the two-digit number
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; Accept the two-digit number
    mov ah, 01h
    int 21h
    sub al, '0'
    mov num1, al

    mov ah, 01h
    int 21h
    sub al, '0'
    mov num2, al

    ; Calculate the sum
    mov al, num1
    mov ah, 0
    mov cl, 10
    mul cl
    add al, num2
    mov sum, al

    ; Display the sum in decimal
    lea dx, msg3
    mov ah, 09h
    int 21h

    ; Convert sum to ASCII and display
    mov si, offset res
    mov ax, 00
    mov al, sum
    call convert_to_ascii

    ; Display the result
    lea dx, res
    mov ah, 09h
    int 21h

    ; Convert sum to hexadecimal
    mov ax, 00
    mov al, sum
    mov si, offset res_hex
    call convert_to_hex
    lea dx, msg_hex
    mov ah, 09h
    int 21h
    lea dx, res_hex
    mov ah, 09h
    int 21h

    ; Convert sum to binary
    mov ax, 00
    mov al, sum
    mov si, offset res_bin
    call convert_to_binary
    lea dx, msg_bin
    mov ah, 09h
    int 21h
    lea dx, res_bin
    mov ah, 09h
    int 21h

    ; Convert sum to octal
    mov ax, 00
    mov al, sum
    mov si, offset res_oct
    call convert_to_octal
    lea dx, msg_oct
    mov ah, 09h
    int 21h
    lea dx, res_oct
    mov ah, 09h
    int 21h

    ; Exit program
    mov ax, 4c00h
    int 21h

main endp

convert_to_ascii proc near
    push ax
    push bx
    push cx
    push dx
    push si

    mov cx, 0
    mov bx, 10  ; Base 10
rpt1:
    mov dx, 0
    div bx
    add dl, '0'
    push dx
    inc cx
    cmp ax, 10
    jge rpt1
    add al, '0'
    mov [si], al
rpt2:
    pop ax
    inc si
    mov [si], al
    loop rpt2
    inc si
    mov al, '$'
    mov [si], al

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
convert_to_ascii endp

convert_to_hex proc near
    push ax
    push bx
    push cx
    push dx
    push si

    mov cx, 0
    mov bx, 16  ; Base 16
rpt1_hex:
    mov dx, 0
    div bx
    add dl, '0'
    cmp dl, '9'
    jbe skip_add_hex
    add dl, 7  ; Adjust for A-F characters
skip_add_hex:
    push dx
    inc cx
    cmp ax, 16
    jge rpt1_hex
    add al, '0'
    mov [si], al
rpt2_hex:
    pop ax
    inc si
    mov [si], al
    loop rpt2_hex
inc si
    mov al, '$'
    mov [si], al

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
convert_to_hex endp

convert_to_binary proc near
    push ax
    push bx
    push cx
    push dx
    push si

    mov cx, 0
    mov bx, 2  ; Base 2
rpt1_bin:
    mov dx, 0
    div bx
    add dl, '0'
    push dx
    inc cx
    cmp ax, 2
    jge rpt1_bin
    add al, '0'
    mov [si], al
rpt2_bin:
    pop ax
    inc si
    mov [si], al
    loop rpt2_bin
    inc si
    mov al, '$'
    mov [si], al

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
convert_to_binary endp

convert_to_octal proc near
    push ax
    push bx
    push cx
    push dx
    push si

    mov cx, 0
    mov bx, 8  ; Base 8
rpt1_oct:
    mov dx, 0
    div bx
    add dl, '0'
    push dx
    inc cx
    cmp ax, 8
    jge rpt1_oct
    add al, '0'
    mov [si], al
rpt2_oct:
    pop ax
    inc si
    mov [si], al
    loop rpt2_oct
    inc si
    mov al, '$'
    mov [si], al

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
convert_to_octal endp
end main
