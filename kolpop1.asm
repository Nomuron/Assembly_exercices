org 100h

mov ah, 08h
mov [char], dl
int 21h

mov ah, 09h
mov dx, char
int 21h

mov ax, 0x4C00
int 21h

char db 0
