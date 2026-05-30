loadGame :-
    write('Nama file: '), read(In),
    bikinNama(In, File),
    
    catch((
        open(File, read, S),
        
        % Reset total data lama
        retractall(urutanPemain(_)),
        retractall(giliran(_)),
        retractall(topKartu(_)),
        retractall(warna(_)),
        retractall(arah(_)),
        retractall(sudahUni(_)),
        retractall(kartuPemain(_,_)),
        retractall(isStart(_)),
        
        bacaFile(S),
        close(S),
        
        asserta(isStart(1)),
        format("Game dimuat dari ~w.~n", [File]),
        giliran(G),
        format("Giliran ~w.~n", [G])
    ), _, (
        write('File tidak ditemukan!'), nl
    )).

bacaFile(S) :-
    read(S, Term),
    bacaRekuren(S, Term).

bacaRekuren(_, selesai) :- !.
bacaRekuren(S, Term) :-
    prosesTerm(Term),
    read(S, Next),
    bacaRekuren(S, Next).

prosesTerm(urutan_pemain:U) :- asserta(urutanPemain(U)).
prosesTerm(giliran:G) :- asserta(giliran(G)).
prosesTerm(warna_aktif:W) :- asserta(warna(W)).
prosesTerm(arah_permainan:A) :- asserta(arah(A)).
prosesTerm(status_UNI:L) :- isiUni(L).
prosesTerm(discard_top:W-J) :- asserta(topKartu(kartu(W,J))), asserta(jenis(J)).
prosesTerm(kartu(P):L) :-
    setKartu(L, K),
    assertz(kartuPemain(P, K)).

isiUni([]).
isiUni([P|T]) :- 
    assertz(sudahUni(P)), 
    isiUni(T).

setKartu([], []).
setKartu([W-J|T], [kartu(W,J)|R]) :-
    setKartu(T, R).