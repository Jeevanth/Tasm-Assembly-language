.model small

.data
msg1 db "Enter x coordinate: $"
msg2 db 10, 13, "Enter y coordinate: $"
x db 0
y db 0
temp1 db 0
temp2 db 0

.code
mov ax, @data
mov ds, ax

lea dx, msg1
call disp

call read
mov x, al

lea dx, msg2
call disp

call read
mov y, al

call clear
call set

mov al, x
call dispLen

mov dl, ' '
mov ah, 02h
int 21h

mov al, y
call dispLen

mov ah, 08h
int 21h

mov ah, 4ch
int 21h

disp proc
    mov ah, 09h
    int 21h
    ret
    disp endp

read proc
    mov ah, 01h
    int 21h
    sub al, 48
    mov temp1, al

    mov ah, 01h
    int 21h
    sub al, 48
    mov temp2, al

    mov al, temp1
    mov bl, 10
    mul bl
    add al, temp2

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

clear proc
    mov ah, 06h
    mov bh, 07h
    mov cx, 00h
    mov dx, 184Fh
    int 10h
    ret
    clear endp

set proc
    mov ah, 02h
    mov bh, 00h
    mov dl, y
    mov dh, x
    int 10h
    ret
    set endp

End
