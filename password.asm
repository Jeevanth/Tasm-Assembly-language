.model small
.data
pass db "password$"
len dw ($-pass)
msg1 db 10, 13, "Enter the password: $"
msg2 db 10, 13, "Wrong password! Try again$"
msg3 db 10, 13, "You are authorized person$"
str1 db 20 dup("$")

.code
mov ax, @data
mov ds, ax
mov es, ax

dec len
next:
    lea dx, msg1
    call disp
    mov cx, 0
    lea si, str1
    call read

    cmp cx, len
    jnz error

    lea si, str1
    lea di, pass
    repe cmpsb
    jnz error

    jmp exit

    error:
        lea dx, msg2
        call disp
        jmp next

exit:
    lea dx, msg3
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
        cmp al, 0dh
        jz ed
        mov [si], al
        inc si
        inc cx
        jmp repeat
    ed:
        ret
        read endp
End
