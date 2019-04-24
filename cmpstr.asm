.model small
.data
msg1 db "Enter the first string: $"
msg2 db "Enter the second string: $"
msg3 db 10, 13, "Length of first string is $"
msg4 db 10, 13, "Length of second string is $"
msg5 db 10, 13, "Strings are equal$"
msg6 db 10, 13, "Strings are not equal$"
str1 db 20 dup("$")
str2 db 20 dup("$")
len1 dw 0
len2 dw 0

.code
mov ax, @data
mov ds, ax
mov es, ax

lea dx, msg1
call disp

mov cx, 0
lea si, str1
call read
mov len1, cx

lea dx, msg2
call disp

mov cx, 0
lea si, str2
call read
mov len2, cx

lea dx, msg3
call disp

mov ax, len1
call dispLen

lea dx, msg4
call disp

mov ax, len2
call dispLen

mov cx, len1
cmp cx, len2
jnz error

lea si, str1
lea di, str2
repe cmpsb
jnz error

lea dx, msg5
jmp ed

error: lea dx, msg6

ed: call disp

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
        jz exit
        mov [si], al
        inc si
        inc cx
        jmp repeat
    exit:
        ret
        read endp

dispLen proc
    aam
    add ax, 3030h
    push ax
    mov dl, ah
    mov ah, 02h
    int 21h
    pop ax
    mov dl, al
    mov ah, 02h
    int 21h
    ret
    dispLen endp
End
