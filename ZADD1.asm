org 100h

mov ax, 0b800h  ;; wpisania adresu karty graficznej do indeksu ax
mov es, ax  ;; wpisanie zawartości ax do es
mov ah, 13h  ;; ustawienie wypisywania znaku z atrybutem
mov al, 00h  ;; ustawienie domyślnej funckji (wypisanie znaku z uwzględnieniem atrybutu)
mov bl, 1eh  ;; atrybut znaku
mov bh, 00h  ;; 
mov dh, 00h
mov dl, 28h
mov cx, 01h

mov byte [es:bp], 05h

int 10h

mov ax, 0x4C00
int 21h
