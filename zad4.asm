org		100h

mov dx, tekst
mov ah, 9
int 21h

mov ax, 0x4C00
int 21h

tekst db "I ", 3, 0, "asembler!", 0, 1, 0, 2, "$"
