.model small

.data
msg1 db "Enter a string: $"
msg2 db "Enter a character: $"
msg3 db 10, 13, "Character is present at location $"
msg4 db 10, 13, "Character is not present$"

str1 db 20 dup("$")
len1 dw 0
char db 0

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

mov ah, 01h
int 21h
mov char, al

lea di, str1
cld

repne scasb
jnz not_present

lea dx, msg3
call disp

mov ax, len1
sub ax, cx
call dispLen
jmp ed

not_present:
    lea dx, msg4
    call disp

ed:
    mov ah, 4ch
    int 21h


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

disp proc
    mov ah, 09h
    int 21h
    ret
    disp endp

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
