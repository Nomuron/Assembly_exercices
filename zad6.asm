org		100h

mov ah, 01h
int 21h

mov dl, al
mov ah, 02h
int 21h

mov ax, 4C00h
int 21h
