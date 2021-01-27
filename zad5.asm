org 	100H

mov dl, "P"
mov ah, 02h
int 21h

mov ax, 0x4C00
int 21h
