:- include('Kartu.pl').
:- dynamic(isStart/1). 
:- dynamic(giliran/1).
:- dynamic(kartuPemain/2).
:- dynamic(topKartu/1).
:- dynamic(urutanPemain/1).
:- dynamic(deck/1).

isStart(0).

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
validasiTop(Kartu, Top) :-
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
    kartuPemain(Pemain,List),
    deck(Deck),
    Deck = [Kartu|Sisa],!,
    appendList(List,[Kartu], List1),
    retract(kartuPemain(Pemain,_)),
    asserta(kartuPemain(Pemain,List1)),
    retract(deck(_)),
    asserta(deck(Sisa)),
    format('~w mendapatkan kartu: ~w.~n', [Pemain,Kartu]),
    nextTurn.
ambilKartu :-
    isStart(1),
    write('Deck sudah habis!'),
    nextTurn,
    fail.



/* Sampel 4 Pemain */
startGame :-
    isStart(0),
    retractall(giliran(_)),
    retractall(kartuPemain(_,_)),
    retractall(topKartu(_)),
    retractall(urutanPemain(_)),
    retractall(deck(_)),
    retractall(isStart(_)),

    asserta(isStart(1)),
    asserta(urutanPemain([fritz, prana, edbert, unad])),
    asserta(giliran(fritz)),
    asserta(topKartu(kartu(biru,6))),

    asserta(kartuPemain(fritz, [kartu(merah,6), kartu(kuning,6), kartu(hijau,6)])),
    asserta(kartuPemain(prana, [kartu(merah,7), kartu(kuning,8), kartu(hijau,9)])),
    asserta(kartuPemain(edbert, [kartu(merah,1), kartu(kuning,2), kartu(hijau,3)])),
    asserta(kartuPemain(unad, [kartu(merah,4), kartu(kuning,5), kartu(hijau,0)])),
    asserta(deck([kartu(hitam,wildDrawFour), kartu(merah,skip), kartu(biru,drawTwo)])),

    giliran(Pemain),
    write('=========================================='),nl,
    write(' Tes Turn 4 Pemain '),nl,
    write('=========================================='),nl,
    format('Giliran: ~w.~n', [Pemain]),
    write('Silakan tentukan aksi Anda!'),nl,
    !.

exit :-
    isStart(1),!,
    retract(isStart(1)),
    asserta(isStart(0)).