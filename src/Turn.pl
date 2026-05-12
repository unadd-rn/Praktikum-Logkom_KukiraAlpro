

/* Predikat Umum */
appendList([],H,H).
appendList([H|T],X,[H|T1]) :-
    appendList(T,X,T1).

/* Validasi Kartu */
kartuValid(kartu(Warna,_), kartu(Warna,_)).
kartuValid(kartu(_,Jenis), kartu(_,Jenis)).
kartuValid(kartu(hitam,_),_).
kartuValid(_,kartu(hitam,_)).

/* Mekanisme pilih kartu */
chooseCard(1, [Kartu|T], Kartu, T).

chooseCard(N, [H|T], Kartu, [H|T1]) :-
    N > 1,
    N1 is N-1,
    chooseCard(N1, T, Kartu, T1).

/* Mekanisme ganti giliran */
nextTurn :-
    urutanPemain([H|T]),
    appendList(T,[H], UrtanBaru),
    retractall(urutanPemain(_)),
    asserta(urutanPemain(UrtanBaru)),
    UrtanBaru = [NextPemain|_],
    retractall(giliran(_)),
    asserta(giliran(NextPemain)),
    format('~nGiliran ~w.~n', [NextPemain]).

/* Mekanisme mainkanKartu */
mainkanKartu(_) :-
    isStart(0),!,
    write('Permainan belum dimulai!'),
    fail.
mainkanKartu(Idx) :-
    isStart(1),
    giliran(Pemain),
    kartuPemain(Pemain,List),
    topKartu(Top),
    chooseCard(Idx, List, Kartu, Sisa),!,
    validasiTop(Kartu, Top),
    retract(kartuPemain(Pemain,_)),
    asserta(kartuPemain(Pemain, Sisa)),
    retract(topKartu(_)),
    asserta(topKartu(Kartu)),
    format('~w memainkan kartu: ~w.~n', [Pemain,Kartu]),
    nextTurn.
mainkanKartu(_) :-
    isStart(1),
    write('Index tidak valid!'),
    nl.

validasiTop(Kartu, Top) :-
    kartuValid(Kartu,Top),!.
validasiTop(_Kartu,_Top) :-
    write('Kartu yang dimainkan tidak valid!'),
    fail.


/* Mekanisme ambilKartu */
ambilKartu :-
    isStart(0),!,
    write('Permainan belum dimulai!'),
    fail.
ambilKartu :-
    isStart(1),
    giliran(Pemain),
    deck(Deck),
    kartuPemain(Pemain,List),
    randomKartu(Deck, Kartu),
    appendList(List,[Kartu], List1),
    retract(kartuPemain(Pemain,_)),
    asserta(kartuPemain(Pemain,List1)),
    format('~w mendapatkan kartu: ~w.~n', [Pemain,Kartu]),
    nextTurn.
ambilKartu :-
    isStart(1),
    write('Deck sudah habis!'),
    nextTurn,
    fail.


exit :-
    isStart(1),!,
    retract(isStart(1)),
    asserta(isStart(0)).