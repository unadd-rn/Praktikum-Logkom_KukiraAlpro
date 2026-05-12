


startGame :-
    isStart(0),
    retractall(namaPemain(_)),
    retractall(jumlahPemain(_)),
    retractall(topKartu(_)),
    retractall(suksesor(_,_)),
    retractall(giliran(_)),
    retractall(kartuPemain(_,_)),
    retractall(urutanPemain(_)),
    retractall(isStart(_)),
    asserta(isStart(1)),
    inputJumlah(N),
    inputNama(N, 1, _NamaPemain),
    findall(X, namaPemain(X), ListPemain),
    
    acakList(ListPemain, UrutanPemain),
    % print(UrutanPemain),
    write('Urutan pemain: '),
    printList(UrutanPemain),!,
    faktaSuksesor(UrutanPemain), nl,
    asserta(urutanPemain(UrutanPemain)),
    jalanPertama(A),
    asserta(giliran(A)),
    deck(Deck),
    bagiKePemain(UrutanPemain,Deck),
    write('Setiap pemain mendapatkan 7 kartu acak.'), nl,
    write('Kartu discard top: '),
    topCard, nl,
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
    deck(Deck),
    randomKartu(Deck, kartu(Warna,Angka)),
    kartuBantingan(Warna, Angka), !,    
    assertz(topKartu(kartu(Warna,Angka))),
    write(Warna), write('-'), write(Angka).
topCard:-
    topCard.

jalanPertama(A):-
    suksesor(A,_),
    \+suksesor(_, A).
    
