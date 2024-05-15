TITLE proc1.asm
.model small
.stack 100h
.data
.code
main proc
mov ax,@data
mov ds,ax
xor al,al
mov cx,16 
lp1: push ax
call out1hex
call pcrlf
pop ax
inc al
loop lp1
Mov ax, 4c00h
Int 21h
Main endp

Out1hex proc 
And al,0fh 
Cmp al,9 
Ja ischar
Add al,30h 
Jmp printit
Ischar: add al,37h 
Printit: Mov dl,al
Mov ah,2
Int 21h 
Ret
Out1hex endp

Pcrlf proc
Mov dl,0ah 
Mov ah,2
Int 21h 
Mov dl,0dh 
Mov ah,2
Int 21h
Ret
Pcrlf endp
End main
