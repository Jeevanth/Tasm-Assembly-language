.model small

print macro value
    mov al, value
    call disp
    call disp_dot
endm

.data
day db 0
date db 0
month db 0
year dw 0
msg db "Monday$", "Tuesday$", "Wednesday$", "Thursday$", "Friday$", "Saturday$"   , "Sunday$"
lookup db 0, 0, 7, 15, 25, 34, 41, 50

.code
mov ax, @data
mov ds, ax

mov ah, 2ah
int 21h

mov day, al
mov date, dl
mov month, dh
mov year, cx

print date
print month

mov ax, year
mov cl, 100
div cl
push ax

call disp
pop ax
print ah

lea bx, lookup
mov al, day
xlat
mov ah, 0
lea dx, msg
add dx, ax
mov ah, 09h
int 21h

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
