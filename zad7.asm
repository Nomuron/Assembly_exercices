org 	100h

mov ah, 02h
mov dh, 0x0C
mov dl, 0x20
int 10h

mov dx, tekst
mov ah, 9
int 21h

mov ah, 02h
mov dh, 0x00
mov dl, 0x22
int 10h

mov ax, 0x4C00
int 21h

tekst db "Patryk Klimek", 0Ah, 0Dh, "$"
