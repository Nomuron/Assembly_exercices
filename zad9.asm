org 100h

mov ah, 3Ah
mov dx, filepath
int 21h

mov ax, 0x4C00
int 21h

filepath db "siema123", 0
