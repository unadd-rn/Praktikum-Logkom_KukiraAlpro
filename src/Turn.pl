% Ini aku tambahin soalnya takutnya if else ga bole
coba(Goal) :- Goal, !.
coba(_).

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
nextTurn:-
    isSkip(1),!,
    urutanPemain([H|T]),
    appendList(T,[H], UrtanBaru),
    retractall(urutanPemain(_)),
    asserta(urutanPemain(UrtanBaru)),
    UrtanBaru = [NextPemain|_],
    retractall(giliran(_)),
    asserta(giliran(NextPemain)),
    format('~nGiliran ~w di-SKIP!~n', [NextPemain]),
    retractall(isSkip(_)),
    asserta(isSkip(0)),
    nextTurn.
nextTurn:-
    isReverse(0),!,
    urutanPemain([H|T]),
    appendList(T,[H], UrtanBaru),
    retractall(urutanPemain(_)),
    asserta(urutanPemain(UrtanBaru)),
    UrtanBaru = [NextPemain|_],
    retractall(giliran(_)),
    asserta(giliran(NextPemain)),
    format('~nGiliran ~w.~n', [NextPemain]).
nextTurn:-
    isReverse(1),
    urutanPemain([H|T]),
    appendList(T,[H], UrtanBaru),
    reverseList(UrtanBaru,UrutanReverse),
    retractall(urutanPemain(_)),
    asserta(urutanPemain(UrutanReverse)),
    retractall(isReverse(_)),
    asserta(isReverse(0)),
    nextTurn.

/* Mekanisme mainkanKartu */
mainkanKartu(_) :-
    isStart(0),!,
    write('Permainan belum dimulai!'),
    fail.
mainkanKartu(_) :-
    isDrawTwo(1),!,
    write('Kamu tidak bisa memainkan kartu pada giliran ini! Silakan gunakan command ambilKartu!'),
    fail.
mainkanKartu(Idx) :-
    isStart(1),
    giliran(Pemain),
    kartuPemain(Pemain,List),
    topKartu(Top),
    chooseCard(Idx, List, Kartu, Sisa),!,
    validasiTop(Kartu),
    retract(kartuPemain(Pemain,_)),
    asserta(kartuPemain(Pemain, Sisa)),
    retract(topKartu(_)),
    asserta(topKartu(Kartu)),
    format('~w memainkan kartu: ~w.~n', [Pemain,Kartu]),
    topKartu(kartu(Warna,Jenis)),
    retractall(warna(_)),
    asserta(warna(Warna)),
    retractall(jenis(_)),
    asserta(jenis(Jenis)),
    actionCard(Jenis),
    nextTurn, 
    coba(endGame).
mainkanKartu(_) :-
    isStart(1),
    write('Index tidak valid!'),
    nl.

validasiTop(kartu(hitam,_)).
validasiTop(kartu(Warna,_)) :-
    warna(W),
    Warna = W.
validasiTop(kartu(_,Jenis)) :-
    jenis(J),
    Jenis = J.
validasiTop(_Kartu) :-
    write('Kartu yang dimainkan tidak valid!'),
    fail.


/* Mekanisme ambilKartu */
ambilKartu :-
    isStart(0),!,
    write('Permainan belum dimulai!'),
    fail.
ambilKartu :-
    isStart(1),
    isDrawTwo(1),!,
    giliran(Pemain),
    format('~w harus mengambil 2 kartu!~n', [Pemain]),
    deck(Deck),
    kartuPemain(Pemain,Kartu),
    bagiNKartu(2,Deck,Hasil),
    appendList(Kartu,Hasil,NewKartu),
    retractall(kartuPemain(Pemain,_)),
    asserta(kartuPemain(Pemain,NewKartu)),
    retractall(isDrawTwo(_)),
    asserta(isDrawTwo(0)),
    nextTurn. 

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
    nextTurn,
    coba(endGame). 

exit :-
    isStart(1),!,
    retract(isStart(1)),
    asserta(isStart(0)).

reverseList([],[]).
reverseList([H],[H]).
reverseList([H|T],NewList) :-
    reverseList(T,L1),
    appendList(L1,[H],NewList).