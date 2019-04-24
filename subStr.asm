.model small

.data
msg1 db "Enter the main string: $"
msg2 db "Enter the sub string: $"
msg3 db "Substring is found$"
msg4 db "Substring is not found$"
str1 db 20 dup("$")
str2 db 10 dup("$")
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

mov bx, len1
sub bx, len2
inc bx

lea si, str1

again:
    mov cx, len2
    push si
    lea di, str2
    repe cmpsb
    jz found
    pop si
    inc si
    dec bx
    jnz again

lea dx, msg4
jmp ed

found: lea dx, msg3

ed:
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
