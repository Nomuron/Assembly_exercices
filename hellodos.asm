; przykladowy program wyswietlajacy tekst na ekranie

org     100h      ; Wszystkie adresy wygenerowane w trakcie asemblacji powinny byc przesuniete o 100h ze wzgledu na sposob uruchamiania programow typu .com

;; ponizsza czesc ustawi w rejestrach parametry dla przerwania 21h (przerwanie DOS-a)
mov dx, tekst      ; teraz zapisujemy adres etykiety tekst do rejestru DX
mov ah, 9          ; ustawiamy AH (czyli bardziej znaczacy bajt rejestru AX) - numer funkcji przerwania 21h
int 0x21           ; wywolujemy przerwanie 21h.

; Wg dokumentacji przerwania 21: jesli ustawilismy AH na 9, to przerwanie
; to wypisze tekst z adresu wskazywanego przez DX

mov ax, 0x4C00     ; AH ustawiamy na 4Ch.
int 0x21           ; Przerwanie dosowe, jesli dostanie w rejestrze AH
                  ; wartosc 4Ch, wtedy uzna, ze aktualny program ma sie
                  ; zakonczyc

; ponizej jest etykieta, a dalej, zestaw danych.
; PAMIETAJ: Etykiety (z reguly) sie nie zachowuja w programie po
; kompilacji. Zobacz kod wynikowy (nigdize nie znajdziesz slowa 'tekst')
tekst db "Witaj okrutny swiecie!",0Ah,0Dh,"$"    ; to jest napis do pokazania
