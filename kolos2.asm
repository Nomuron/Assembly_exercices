org 100h

mov ax, 0b800h
mov es, ax
mov ah, 13h
mov al, 11h
mov bl, 00h
mov bh, 00h
mov cx, 05h

int 10h

mov ax, 0x4C00
int 21h
