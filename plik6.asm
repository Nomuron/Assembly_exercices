SECTION .data
SECTION .text
org 100h

mov dx, 0 ; w dx odkladka sie reszta z dzielenia
mov ax, 20161 ; liczba do dzielenia - nr indeksu 20161
mov cx, 40 ; dzielnik - 40
div cx ; polecenie dzielenia ax, przez cx
add dx, 5 ; do dx trafila reszta z dzielenia, dodajemy 5 (czyli modulo + 5)

push dx ; odkladamy wartosc dx do stosu pamieci (odkladamy ja na pozniej)


; tu bedziemy liczyc ile znakow trzeba odjac od centrum ekranu zeby wypisac na srodku
mov ax, dx ; jako liczbe do dzielenia - przenosimy wartosc dx, ktora zawiera nasze modulo + 5
mov dx, 0 ; w dx odklada sie reszta z dzielenia, zerujemy
mov cx, 2 ; jako dzielnik - dajemy 2 - dzielimy nasza liczbe przez dwa - czyli np dla 6 znakow, od srodka odejmujemy 3 znaki
div cx ; wykonujemy dzielenie

mov dx, 40 ; bedziemy pracowac w trybie graficznym 80x25 [80 kolumn, 25 wierszy, 80/2=40]
	   ; do dx przenosimy wiec wartosc 39 - bedzie sluzyl do wskazania centrum
sub dx, ax ; nastepnie odejmujemy wynik dzielenia ilosci znakow przez 2 od dx

mov ah, 00h ; dla int10h, ah=00h, ustawienie trybu graficznego
mov al, 03h ; al = tryb graficzny->tekstowy, 80x25
int 10h ; wywolanie przerwania 

mov ah, 02h ; dla int10h, ah 02h - umieszczenie kursora
mov bh, 0 ; bh - numer ekranu 'roboczego', standardowo 0
mov dh, 12 ; dh - ilosc wierszy do przeskoczenia [25/2->12,5->12]
	   ; dl - ilosc kolumn do przeskoczenia, dl - dolny zakres dx, a w dx mamy to co wczesniej ustatlilismy wiec nie deklarujemy jej tutaj
int 10h ; wywolanie przerwania



petla:
	pop dx ; nasze wczesniejsze dane ze stosu zrzucamy do dx
	
	mov ah, 09h ; dla int10h tryb do wrzucenia znaku na pozycji kursora
	mov al, 0x23 ; znak do wrzucenia
	mov bh, 0 ; numer ekranu
	mov bl, 0x04 ; kolor czcionki
	mov cx, 1 ; ilosc powtorzen znaku [ma byc w petli wiec tylko jeden]
	int 10h ; przerwanie
	
	push dx ; zrzucamy spowrotem nasze dx do stosu
	mov ah, 03h ; tryb 03h - zwraca pozycje kursora do DH i DL
	int 10h ; przerwanie
	
	add dl, 0x01 ; do DL [kolumny] dodajemy 1 - zmieniamy pozycje kursora na nastepny znak
	mov ah, 02h ; wywolujemy 02h - ustaw pozycje kursora, pozycja wg DH i DL 
	int 10h ; przerwanie
	
	pop dx ; pobieramy spowrotem nasze dx
	dec dx ; zmniejszamy dx o 1
	push dx ; zrzucamy dx do stosu
	cmp dx,0 ; porownujemy czy nasze dx doszło do 0
	ja petla ; jesli nie do wracamy do pocztaku petli

mov ah, 02h ; tryb do przesuwania kursora
mov bh, 0 ; ekran 0
mov dh, 23 ; 23 wiersz
int 10h ; wprzerwanie

mov ah, 4Ch ; dla 21h - zakonczenie programu
int 21h ; przerwanie
