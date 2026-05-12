use_module(library(random)).

/*kartu angka*/
kartu(merah,0).
kartu(merah,1).
kartu(merah,2).
kartu(merah,3).
kartu(merah,4).
kartu(merah,5).
kartu(merah,6).
kartu(merah,7).
kartu(merah,8).
kartu(merah,9).

kartu(kuning,0).
kartu(kuning,1).
kartu(kuning,2).
kartu(kuning,3).
kartu(kuning,4).
kartu(kuning,5).
kartu(kuning,6).
kartu(kuning,7).
kartu(kuning,8).
kartu(kuning,9).

kartu(hijau,0).
kartu(hijau,1).
kartu(hijau,2).
kartu(hijau,3).
kartu(hijau,4).
kartu(hijau,5).
kartu(hijau,6).
kartu(hijau,7).
kartu(hijau,8).
kartu(hijau,9).

kartu(biru,0).
kartu(biru,1).
kartu(biru,2).
kartu(biru,3).
kartu(biru,4).
kartu(biru,5).
kartu(biru,6).
kartu(biru,7).
kartu(biru,8).
kartu(biru,9).

/*kartu skip*/
kartu(merah,skip).
kartu(kuning,skip).
kartu(hijau,skip).
kartu(biru,skip).

/*kartu reverse*/
kartu(merah,reverse).
kartu(kuning,reverse).
kartu(hijau,reverse).
kartu(biru,reverse).

/*kartu draw two*/
kartu(merah,drawTwo).
kartu(kuning,drawTwo).
kartu(hijau,drawTwo).
kartu(biru,drawTwo).

/*kartu wild*/
kartu(hitam,wild).

/*kartu wild draw four*/
kartu(hitam,wildDrawFour).

:- dynamic(namaPemain/1).
:- dynamic(jumlahPemain/1).
:- dynamic(kartuDiscardTop/1).
:- dynamic(suksesor/2).




startGame :-
    retractall(namaPemain(_)),
    retractall(jumlahPemain(_)),
    retractall(kartuDiscardTop(_)),
    retractall(suksesor(_,_)),
    inputJumlah(N),
    inputNama(N, 1, NamaPemain),
    findall(X, namaPemain(X), ListPemain),
    
    acakList(ListPemain, UrutanPemain),
    % print(UrutanPemain),
    write('Urutan pemain: '),
    printList(UrutanPemain),!,
    faktaSuksesor(UrutanPemain), nl,
    jalanPertama(A),
    write('Setiap pemain mendapatkan 7 kartu acak.'), nl,
    write('Kartu discard top: '), topCard, nl,
    format('Giliran ~w.', [A]). 

    % random_card(ListPemain, Pemain, NewHand),

printList([H]) :- 
    write(H), 
    write('.').
printList([H|T]):-
    T\=[],
    write(H), 
    write(' - '),
    printList(T).
    
    


inputJumlah(Jumlah):-
    write('Masukkan jumlah pemain: '), read(Cobajumlah),
    (
        integer(Cobajumlah),
        Cobajumlah >= 2, 
        Cobajumlah =< 4
    -> 
        Jumlah = Cobajumlah,
        assertz(jumlahPemain(Jumlah))  
    ;
        write('Mohon masukkan angka antara 2-4.'),
        inputJumlah(Jumlah)
    ).

inputNama(0, _, []).

inputNama(N, Urut, Hasil) :-
    N > 0,
    % Pengurang is N - 1, 
    
    format('Masukkan nama pemain ~w : ', [Urut]), 
    read(Nama),
    (
        \+namaPemain(Nama)
    -> 
        assertz(namaPemain(Nama)), 
        N1 is N - 1,
        Urut1 is Urut+1,
        inputNama(N1, Urut1, T),
        Hasil =  [Nama|T]
    ;
        write('Nama sudah digunakan.'),
        % N1 is N,
        inputNama(N, Urut, Hasil)

        ).

faktaSuksesor([_]).
faktaSuksesor([Awal, H|T]):-
    assertz(suksesor(Awal, H)),
    faktaSuksesor([H|T]).


acakList([], []).
acakList(List, [Card|Sisa]) :-
    random_card(List, Card, NewList), 
    % faktaSuksesor(Card, Sisa),
    acakList(NewList, Sisa).  

random_card([Card], Card, []).
random_card(Hand, Card, NewHand) :-
    count_list(Hand, Len),
    random(0, Len, Index),
    pick_at_index(Hand, Index, Card, NewHand).

count_list([], 0).
count_list([_|T], N) :-
    count_list(T, N1),
    N is N1 + 1.

pick_at_index([H|T], 0, H, T) :- !.
pick_at_index([H|T], I, Card, [H|Rest]) :-
    I1 is I - 1,
    pick_at_index(T, I1, Card, Rest).


kartuBantingan(_, Y):-
    kartu(_,Y),
    Y \== skip,
    Y \== reverse,
    Y \== wild,
    Y \== wildDrawFour,
    Y \== drawTwo.

topCard:-
    findall(kartu(X, Y), kartu(X, Y), ListKartu), 
    random_card(ListKartu, kartu(Warna,Angka), _),
    kartuBantingan(Warna, Angka), !,    
    assertz(kartuDiscardTop(Warna, Angka)),
    write(Warna), write('-'), write(Angka).

jalanPertama(A):-
    suksesor(A,_),
    \+suksesor(_, A).
    








    