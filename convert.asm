.model small

.data
msg1 db "Enter a string: $"
msg2 db "Resultant string is $"
str1 db 20 dup("$")
str2 db 20 dup("$")
len1 dw 0

.code
mov ax, @data
mov ds, ax

lea dx, msg1
call disp

mov cx, 0
lea si, str1
call read
mov len1, cx

lea si, str1
lea di, str2

next:
    mov al, [si]
    cmp al, 'A'
    jb close
    cmp al, 'Z'
    ja lower
    add al, 20h
    jmp close

lower:
    cmp al, 'a'
    jb close
    cmp al, 'z'
    ja close
    sub al, 20h

close:
    mov [di], al
    inc si
    inc di
    dec cx
    jnz next

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

