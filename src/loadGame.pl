loadGame :-
    isStart(0), !,
    write('Nama file: '), read(In),
    bikinNama(In, File),
    eksekusiLoad(File).

loadGame :-
    isStart(1), !,
    write('Gagal! Kamu tidak bisa load game saat permainan sedang berjalan!'), nl,
    write('Selesaikan game terlebih dahulu.'), nl.

eksekusiLoad(File) :-
    file_exists(File), !,
    open(File, read, S), !,

    retractall(urutanPemain(_)),
    retractall(urutanAwal(_)),
    retractall(giliran(_)),
    retractall(topKartu(_)),
    retractall(warna(_)),
    retractall(arah(_)),
    retractall(sudahUni(_)),
    retractall(kartuPemain(_,_)),
    retractall(kartuTersembunyi(_,_)),
    retractall(isStart(_)),

    bacaFile(S),
    close(S), !,
    asserta(isStart(1)),
    format("Game dimuat dari ~w.~n", [File]),
    cekSelesai.
eksekusiLoad(_) :-
    write('Gagal memuat file! Pastikan nama file benar dan ada.'), nl.

bacaFile(S) :-
    read(S, Term),
    bacaRekuren(S, Term).

bacaRekuren(_, selesai) :- !.
bacaRekuren(_, end_of_file) :- !.
bacaRekuren(S, Term) :-
    prosesTerm(Term),
    read(S, Next),
    bacaRekuren(S, Next).

prosesTerm(urutanPemain:U) :- 
    asserta(urutanPemain(U)), 
    asserta(urutanAwal(U)).
prosesTerm(giliran:G) :- 
    asserta(giliran(G)).
prosesTerm(warnaAktif:W) :- 
    asserta(warna(W)).
prosesTerm(arahPermainan:A) :- 
    asserta(arah(A)).
prosesTerm(statusUNI:L) :- 
    isiUni(L).
prosesTerm(lastAction:KAct) :- 
    setKartu(KAct,Act),
    asserta(lastAction(Act)).
prosesTerm(discardTop:W-J) :- 
    asserta(topKartu(kartu(W,J))), 
    asserta(jenis(J)).
prosesTerm(kartu(P):L) :-
    setKartu(L, K),
    assertz(kartuPemain(P, K)).
prosesTerm(kartuTersembunyi(P):L) :-
    setKartu(L,K),
    assertz(kartuTersembunyi(P, K)).
prosesTerm(_).

isiUni([]).
isiUni([P|T]) :- 
    assertz(sudahUni(P)), 
    isiUni(T).

setKartu([], []).
setKartu([W-J|T], [kartu(W,J)|R]) :-
    setKartu(T, R).

cekSelesai :-
    adaYangHabis, !,
    endGame,
    retractall(isStart(_)),
    asserta(isStart(0)).
cekSelesai :-
    giliran(G),
    format("Melanjutkan giliran ~w.~n", [G]).