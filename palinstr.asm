.model small

.data
msg1 db "Enter a string : $"
msg2 db 10,13,"Reversed string is : $"
msg3 db 10,13,"Length of the string is : $"
msg4 db 10,13,"String is Palindrome$"
msg5 db 10,13,"String is not a Palindrome$"

str1 db 20 dup('$')
str2 db 20 dup('$')
len  dw 00h

.code
mov ax, @data
mov ds, ax
mov es, ax

lea dx, msg1
call dispStr

lea si, str1
mov cx, 0
call readStr
mov len, cx

lea dx, msg3
call dispStr

mov ax, len
call dispLen

lea si, str1
mov cx, len
lea di, str2
add di, cx
dec di

back:
    cld
    lodsb
    std
    stosb
    Loop back

lea dx, msg2
call dispStr

lea dx, str2
call dispStr

lea si, str1
lea di, str2
mov cx, len
cld
repe cmpsb
jnz not_palin
lea dx, msg4
jmp print

not_palin:
    lea dx, msg5

print: call dispStr

mov ah, 4ch
int 21h

dispStr proc
    mov ah, 09h
    int 21h
    ret
    dispStr endp

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

readStr proc
    next:
        mov ah, 01h
        int 21h
        cmp al, 0Dh
        je exit
        mov [si], al
        inc si
        inc cx
        jmp next

    exit:
        ret
        readStr endp
end
