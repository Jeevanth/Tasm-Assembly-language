.model small

.data
msg1 db "Enter your name: "
str1 db 20 dup("$")

.code
mov ax, @data
mov ds, ax

lea dx, msg1
call disp

lea si, str1
call read

call clear
call set

lea dx, str1
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
        jmp repeat

    exit:
        ret
        read endp

clear proc
    mov ah, 06h
    mov bh, 07h
    mov cx, 0
    mov dx, 184Fh
    int 10h
    ret
    clear endp

set proc
    mov ah, 02h
    mov bh, 0
    mov dx, 0C28h
    int 10h
    ret
    set endp

End
