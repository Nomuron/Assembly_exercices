org 100h

mov ah, 01h
int 21h

cmp al, 5Ah
jle rowne
jg wieksze

rowne:
  mov dx, ro
jmp dalej
wieksze:
  mov dx, wi
jmp dalej
dalej:
mov ah, 9
int 21h
mov ax, 4C00h
int 0x21

ro db "wielka litera", 0Ah, 0Dh, "$"
wi db "mniejsza litera", 0Ah, 0Dh, "$"
