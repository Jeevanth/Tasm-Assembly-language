.model small

.data
n dw 5
res dw 0

.code
mov ax, @data
mov ds, ax

mov ax, n
call fact

mov ah, 4ch
int 21h

fact proc
    cmp ax, 01h
    jbe exit
    push ax
    dec ax
    call fact
    pop ax
    mul res
    mov res, ax
    ret

    exit:
        mov res, 01h
        ret
    fact endp

End
