.model small
.data
str1 db 20 dup("$")
str2 db 20 dup("$")
msg1 db "Enter a string: $"
msg2 db "Copied String is $"

.code
mov ax, @data
mov ds, ax
mov es, ax

lea dx, msg1
call disp

mov cx, 0
lea si, str1
call read

lea si, str1
lea di, str2

rep movsb

lea dx, msg2
call disp

lea dx, str2
call disp

mov ah, 4ch
int 21h

disp proc
    mov ah, 09h
    int 21h
    ret
    disp endp

read proc
    repeat:
        mov ah, 01h
        int 21h
        cmp al, 0Dh
        jz exit
        mov [si], al
        inc si
        inc cx
        jmp repeat

    exit:
        ret
        read endp

End
