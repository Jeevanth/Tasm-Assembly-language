.model small

.data
str1 db "a.txt",0
str2 db "b.txt",0
msg1 db "Created Successfully$"
msg2 db "Error in creation$"
msg3 db 10, 13, "Deleted Successfully$"
msg4 db 10, 13, "Error in deletion$"

.code
mov ax, @data
mov ds, ax

lea dx, str1
mov cl, 0
mov ah, 3ch
int 21h
jc error1

lea dx, msg1
call disp
jmp L1

error1:
    lea dx, msg2
    call disp

L1:
lea dx, str2
mov ah, 41h
int 21h
jc error2

lea dx, msg3
call disp
jmp L2

error2:
    lea dx, msg4
    call disp

L2:
    mov ah, 4ch
    int 21h

disp proc
    mov ah, 09h
    int 21h
    ret
    disp endp

End
