org     100h               ; Program typu COM - na poczatek
code:                      ; etykieta, wymyslilem sobie ze tak nazwe poczatek programu
jmp start                  ; przeskakuje do etykiety start (nie chce aby wykonal sie tekst ponizej)
tekst db "Witaj okrutny swiecie!",0Ah,0Dh, "dupa",0Ah,0Dh, "$"    ; to jest napis do pokazania
start:                     ; etykieta opisujaca poczatek
	mov ax, cs         ; kopiujemy rejestr CS (code segment) do ax
	mov ds, ax         ; aby za jego posrednictwem zapisac go do DS (data segment)
	mov dx, tekst      ; teraz zapisujemy adres etykiety tekst do rejestru DX
	mov ah, 9          ; ustawiamy AH (czyli bardziej znaczacy bajt rejestru AX)
	int 0x21           ; wywolujemy przerwanie 21h - przerwanie dosowe - 

	mov ax, 0x4C00     ; dosowi mowimy ze juz konczymy
	int 0x21           ; i wywolanie przerwania w zwiazku z tym

absolute code              ; adresowanie absolutne - zwiazane z tym ze robimy plik .com

