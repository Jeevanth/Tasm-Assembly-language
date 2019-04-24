.model small

.data
msg1 db "Enter the Character: $"
n db ?

.code
mov ax, @data
mov ds, ax

lea dx, msg1
mov ah, 09h     ;    display msg1
int 21h

mov ah, 01h         ; read character
int 21h
mov n, al

call clear
call set

mov ah, 0
mov al, n
call dispLen

mov ah, 08h
int 21h

mov ah, 4ch
int 21h

clear proc
    mov ah, 06h
    mov bh, 07h
    mov cx, 0
    mov dx, 184fh
    int 10h
    ret
    clear endp

set proc
    mov ah, 2
    mov bh, 0
    mov dx, 0C28h
    int 10h
    ret
    set endp

dispLen proc
    aam
    add ax, 3030h
    push ax
    cmp ah, 39h
    jbe two
    push ax
    mov dl, 31h
    mov ah, 02h
    int 21h
    pop ax
    sub ah, 10
    two:
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
