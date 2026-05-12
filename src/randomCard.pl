
randomKartu(Deck, Kartu) :-
    random(0, 54, Idx),
    getElmt(Deck, Idx, Kartu).

getElmt([H|_], 0, H) :- !.
getElmt([_|T], I, Kartu) :-
    I1 is I - 1,
    getElmt(T, I1, Kartu).

cetakTanganPemain([]).
cetakTanganPemain([Pemain|Sisa]):-
    kartuPemain(Pemain,Kartu),
    write('Kartu '),write(Pemain),write(': '),write(Kartu),nl,
    cetakTanganPemain(Sisa).

bagiNKartu(0,_,[]).
bagiNKartu(N,Deck,[Kartu|TanganSisa]) :-
    N>0,
    randomKartu(Deck,Kartu),
    N1 is N-1,
    bagiNKartu(N1,Deck,TanganSisa).

bagiKePemain([],_).
bagiKePemain([Pemain|SisaPemain],Deck):-
    bagiNKartu(7,Deck,TanganPemain),
    assertz(kartuPemain(Pemain,TanganPemain)),
    bagiKePemain(SisaPemain,Deck).

/*
tesBagiKartu :-
    retractall(tanganPemain(_,_)),
    ListPemain=['Prana','Unad','Fritz'],
    write('Daftar Pemain:'), write(ListPemain),nl,


    bagiKePemain(ListPemain,JumlahKartu),nl,
    cetakTanganPemain(ListPemain).

*/