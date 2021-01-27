org 100h

mov ah, 02h
mov dh, 0x0C
mov dl, 0x20
int 10h

mov ah, 0Ch
mov al, 01h
mov dx, 0x0C
mov cx, 0x20
int 10h

mov ax, 0x4C00
int 21h
