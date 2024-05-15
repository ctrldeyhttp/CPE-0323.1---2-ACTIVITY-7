dosseg
.model small
.stack 100h
.data
    prompt db 'Enter password (10 characters): $'
    correct_password db '1234567890'  ; Example correct password
    entered_password db 11 DUP('$')   ; One extra byte for null terminator
    correct_msg db 13, 10, 'Password is CORRECT!$'
    incorrect_msg db 13, 10, 'Password is INCORRECT!$'
.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt for password
    lea dx, prompt
    mov ah, 09h
    int 21h

    ; Read 10 characters and display as stars
    mov cx, 10
    lea di, entered_password
    
read_loop:
    mov ah, 08h     ; Read character without echo
    int 21h
    mov [di], al    ; Store the character in entered_password
    mov dl, '*'     ; Replace the typed character with '*'
    mov ah, 02h
    int 21h
    inc di
    loop read_loop

    ; Null-terminate the entered password
    mov byte ptr [di], '$'

    ; Compare entered password with correct password
    lea si, entered_password
    lea di, correct_password
    mov cx, 10
compare_loop:
    lodsb            ; Load byte from entered_password into AL
    cmp al, [di]     ; Compare AL with byte in correct_password
    jne incorrect    ; If not equal, jump to incorrect
    inc di
    loop compare_loop

    ; If all characters matched, display correct message
    jmp display_msg

incorrect:
    lea dx, incorrect_msg
    mov ah, 09h
    int 21h

    mov ax, 4c00h
    int 21h
    

display_msg:
    lea dx, correct_msg
    mov ah, 09h
    int 21h

    ; Exit program
    mov ax, 4c00h
    int 21h

main endp
end main