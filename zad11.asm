org 100h

mov ah, 00h
mov al, 11h
int 10h

mov ah, 00h
int 16h

mov ah, 01h
int 10h

mov ax, 0x4C00
int 21h
