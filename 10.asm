org 100h  

mov ax, 0b800h  
mov es, ax  
mov ah, 13h  
mov al, 00h  
mov bl, 04h  
mov bh, 00h 
mov dh, 00h
mov dl, 00h
mov cx, 01h

mov byte [es:bp], '8'

int 10h

mov ah, 13h
mov al, 00h
mov bl, 04h
mov bh, 00h
mov dh, 00h
mov dl, 01h
mov cx, 01h

mov byte [es:bp], 03h

int 10h

mov ah, 13h
mov al, 00h
mov bl, 0fh
mov bh, 00h
mov dh, 00h
mov dl, 02h
mov cx, 01h

mov byte [es:bp], '9'

int 10h

mov ah, 13h
mov al, 00h
mov bl, 0fh
mov bh, 00h
mov dh, 00h
mov dl, 03h
mov cx, 01h

mov byte [es:bp], 05h

int 10h

mov ah, 13h
mov al, 00h
mov bl, 0fh
mov bh, 00h
mov dh, 00h
mov dl, 04h
mov cx, 01h

mov byte [es:bp], 'Q'

int 10h

mov ah, 13h
mov al, 00h
mov bl, 0fh
mov bh, 00h
mov dh, 00h
mov dl, 05h
mov cx, 01h

mov byte [es:bp], 06h

int 10h

mov ax, 0b800h  
mov es, ax  
mov ah, 13h  
mov al, 00h  
mov bl, 04h  
mov bh, 00h 
mov dh, 00h
mov dl, 06h
mov cx, 01h

mov byte [es:bp], '6'

int 10h

mov ah, 13h
mov al, 00h
mov bl, 04h
mov bh, 00h
mov dh, 00h
mov dl, 07h
mov cx, 01h

mov byte [es:bp], 04h

int 10h

mov ah, 13h
mov al, 00h
mov bl, 0fh
mov bh, 00h
mov dh, 00h
mov dl, 08h
mov cx, 01h

mov byte [es:bp], '2'

int 10h

mov ah, 13h
mov al, 00h
mov bl, 0fh
mov bh, 00h
mov dh, 00h
mov dl, 09h
mov cx, 01h

mov byte [es:bp], 05h

int 10h

mov ax, 0x4C00
int 21h
