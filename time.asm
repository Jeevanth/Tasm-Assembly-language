.model small

.data
hour db 0
min db 0
sec db 0

.code
mov ax, @data
mov ds, ax

mov ah, 2ch
int 21h
mov hour, ch
mov min, cl
mov sec, dh

mov al, hour
call disp
call disp_dot

mov al, min
call disp
call disp_dot

mov al, sec
call disp

mov ah, 4ch
int 21h

disp proc
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
    disp endp

disp_dot proc
    mov dl, '/'
    mov ah, 02h
    int 21h
    ret
    disp_dot endp

end
