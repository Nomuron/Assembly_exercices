org		100h

mov dx, tekst
mov ax, 9
int 21h

mov ax, 0x4C00
int 21h

tekst db "Patryk", 0Ah, 0Dh, "Klimek", 0Ah, 0Dh, "Zielony", 0Ah, 0Dh, "$"
