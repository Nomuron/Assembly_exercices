org 100h

input1 db 20
	   db 0
	   times 22 db "$"

mov ah, 0Ah
mov dx, input1
int 21h

mov ah, 09h
mov dx, input1+12
int 21h

mov ax, 0x4C00
int 21h
