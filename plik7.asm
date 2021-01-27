SECTION .data
tekst	db 20		; maksymalna liczba znaków do pobrania
	db 0		; tu dostaniemy, ile znaków pobrano
	times 22 db 0	; miejsce na dane


SECTION .text
org 100h

getInput:
	; pobranie tekstu na wejsciu - 0ah, int21h
	mov	ah, 0ah	; funkcja pobierania danych z klawiatury
	mov	dx, tekst	; bufor na dane
	int	21h		; pobierz dane

changeDisplayMode:
	; ustawienie trybu graficznego
	mov ah, 00h ; dla int10h, ah=00h, ustawienie trybu graficznego
	mov al, 03h ; al = tryb graficzny->tekstowy, 80x25
	int 10h ; wywolanie przerwania 
	
	; przewiniecie ekranu aby wypelnic kolorem tla
	mov ah, 06h ; tryb przewijania
	mov al, 00h ; wyczysc caly ekran
	mov cl, 0; lewy gorny rog
	mov ch, 0; lewy gorny 
	mov dh, 24; prawy dolny rog
	mov dl, 79; prawy dolny rog
	mov bh, 4Fh; kolor tla i tekstu: czerwoen tlo, bialy tekst
	int 10h ; przerwanie
	
setUpCursor:
	; tu bedziemy liczyc ile znakow trzeba odjac od centrum ekranu zeby wypisac na srodku
	mov ax, 0 ; zerujemy ax - czyli ah=0 al=0
	mov al, [tekst+1] ; wskazujemy na 'pierwszy' bajt z tekstu [czyli glugosc tekstu], zapisujemy do al zeby nie przekraczac dlugosci jednego bajta
	mov dx, 0 ; w dx odklada sie reszta z dzielenia, zerujemy
	mov cx, 2 ; jako dzielnik - dajemy 2 - dzielimy nasza liczbe przez dwa - czyli np dla 6 znakow, od srodka odejmujemy 3 znaki
	div cx ; wykonujemy dzielenie
	mov dx, 40 ; w dx wpisujemy 40 - czyli polowe ekranu
	sub dx, ax ; odejmemy polowe dlugosci tekstu od 40
	

	mov ah, 02h ; dla int10h, ah 02h - umieszczenie kursora
	mov bh, 0 ; bh - numer ekranu 'roboczego', standardowo 0
	mov dh, 24 ; dh - ilosc wierszy do przeskoczenia
	int 10h ; przerwanie

	mov bx,tekst+2 ; do bx szczytujemy tekst
	push bx ; przerzucamy zawartosc bx na stos pamieci
	
checkLetter: 
	; sprawdzamy literki - duze A, male A lub znaki biale
	cmp byte [bx], 0x61
	jae lowerCase
	
	cmp byte [bx], 0x41
	jae upperCase

	cmp byte [bx], 0x00
	jae skipChar
	
	jmp nextLetter

fixChar:
	; poprawiamy 'dziwne' znaki biale na spacje
	mov byte [bx], 0x20
	jmp nextLetter
	
skipChar:
	; pomijamy 'dziwne' znaki biale, jesli beda do naprawy do naprawiamy w fixchar-zmieniamiy na spacje, jesli nie sa do naprawy to je wyswietlamy
	cmp byte [bx], 0x1f
	jbe fixChar
	
	jmp nextLetter

	
upperCase:
	; blok do obslugi duzych liter, jesli litera jest w zakresie duzych liter od A do Z, to dodajemy 0x20 [hex] i zmieniamy na male
	; jak nie to nic z nia nie robimy i wyswietlamy
	cmp byte [bx], 0x5a
	ja nextLetter
	
	add byte [bx], 0x20
	jmp nextLetter
	

lowerCase:
	; blok do obslugi malych liter, jesli litera jest w zakresie malych od a do z, to odejmujemy 0x20 [hex] i zmieniamy na duza
	; jak nie to z nic z nia nie robimy i wyswietlamy
	cmp byte [bx], 0x7a
	ja nextLetter
	
	sub byte [bx], 0x20
	jmp nextLetter


nextLetter:
	; blok do obslugi wyswietlania kolejnych liter i przechodzenia do nastpnej litery w tekscie
	; ze stosu scigamy nasz obecny tekst
	pop dx
	
	; nasz ostatni znak z [bx] wyswietlamy w aktualnej pozycji kursora
	mov ah, 09h ; dla int10h tryb do wrzucenia znaku na pozycji kursora
	mov al, [bx] ; znak do wrzucenia, musimy go tu wrzucic zanim zmienimy BH i BL nizej
	mov bh, 0 ; numer ekranu
	mov bl, 4Fh ; kolor czcionkir	
	mov cx, 1 ; ilosc powtorzen znaku [ma byc w petli wiec tylko jeden]
	int 10h ; przerwanie
	
	push dx ; zrzucamy spowrotem nasze dx do stosu - poniewaz DH i DL beda za chwile obslugiwane przez drugie przerwanie
	; pobieramy aktualna pozycje kursora, bedzie ona zapisana w DH i DL
	mov ah, 03h ; tryb 03h - zwraca pozycje kursora do DH i DL
	int 10h ; przerwanie
	
	; do DL dodajemy 1 - przesuwamy o jedna pozycje w prawo
	; DH - bez zmian, to pozycja wiersza, jest zadeklarowana przez poprzednie przerwanie
	add dl, 0x01 ; do DL [kolumny] dodajemy 1 - zmieniamy pozycje kursora na nastepny znak
	mov ah, 02h ; wywolujemy 02h - ustaw pozycje kursora, pozycja wg DH i DL 
	int 10h ; przerwanie

	; tekst ze stosu zrzucamy spowrotem do rejestru bx
	pop bx
	; inkrementujemy bx zeby dostac sie do nastepnej litery [mysl o tym tak jakby przesuwac tekst w lewo za pomocą DELETE]
	inc bx
	; przesuniety tekst wrzucamy na stos
	push bx
	
	; sprawdzamy czy obecny znak w [bx] = 0, jesli tak to mamy koniec tekstu, wtedy idziemy do end, a jak nie to sprawdzamy kolejna litere
	; za pomoca bloku checkLetter
	cmp byte [bx], 0
	jnz checkLetter
	jmp end

end:
	;ustawiamy kursors na ostatnim wierszu, na poczatku
	mov ah, 02h ; dla int10h, ah 02h - umieszczenie kursora
	mov bh, 0 ; bh - numer ekranu 'roboczego', standardowo 0
	mov dh, 24 ; dh - ilosc wierszy do przeskoczenia
	mov dl, 0
	int 10h
	; czekamy na stukniecie w klawiature przez uzytkownika
	mov ah, 07h
	int 21h
	; konczymy program
	mov ah, 4Ch
	int 21h
