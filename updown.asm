.model small

.code
call clear
mov al, 0

up:
    call set
    add al, 01h
    cmp al, 100
    je down
    push ax
    push ax
    call dispLen
    call delay
    pop ax
    jmp up

down:
    call set
    sub al, 01h
    cmp al, 0
    je exit
    push ax
    call dispLen
    call delay
    pop ax
    jmp down

exit:
    mov ah, 4ch
    int 21h

clear proc
    mov ah, 06h
    mov bh, 07h
    mov cx, 0
    mov dx, 184Fh
    int 10h
    ret
    clear endp

set proc
    push ax
    mov ah, 02h
    mov bh, 00
    mov dx, 0C28h
    int 10h
    pop ax
    ret
    set endp

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

delay proc
    mov cx, 0FFh

    L1: mov dx, 0FFh
    L2: dec dx
        jnz L2
        loop L1

    ret
    delay endp

End
