.model small

.data
msg1 db "Enter a string: $"
msg2 db "Readed string is $"
str1 db 20 dup("$")

.code
include read.mac
include print.mac

mov ax, @data
mov ds, ax

lea dx, msg1
call disp

mov cx, 0
lea si, str1

next:
    read_ch
    cmp al, 0Dh
    jz exit
    mov [si], al
    inc si
    inc cx
    jmp next

exit:
    lea dx, msg2
    call disp

lea si, str1

repeat:
    mov dl, [si]
    print_ch
    inc si
    loop repeat

mov ah, 4ch
int 21h

disp proc
    mov ah, 09h
    int 21h
    ret
    disp endp

End
