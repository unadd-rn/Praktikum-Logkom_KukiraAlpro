bikinNama(In, Out) :-
    name(In, L1),
    name('.txt', L2),
    appendList(L1, L2, L3),
    name(Out, L3), !.

cekUni([], []).
cekUni([P|T], [P|R]) :-
    sudahUni(P), !,
    cekUni(T, R).
cekUni([_|T], R) :-
    cekUni(T, R).

tulisKartu(_, []).
tulisKartu(S, [P|T]) :-
    kartuPemain(P, K),
    ubahKartu(K, Teks),
    format(S, "kartu('~w'):~w.~n", [P, Teks]),
    tulisKartuTersembunyi(S,P),
    tulisKartu(S, T).

ubahKartu([], []).
ubahKartu([kartu(W,J)|T], [W-J|R]) :-
    ubahKartu(T, R).

saveGame :-
    isStart(1),
    isDrawFour(0),
    isDrawTwo(0),
    isSkip(0), !,
    
    write('Nama file: '), read(In),
    bikinNama(In, File),
    open(File, write, S),
    
    urutanAwal(U),
    giliran(G),
    topKartu(Top),
    warna(W),
    arah(A),
    
    
    format(S, "urutanPemain:~w.~n", [U]),
    format(S, "giliran:'~w'.~n", [G]),
    Top = kartu(WTop, JTop),
    format(S, "discardTop:~w-~w.~n", [WTop, JTop]),
    format(S, "warnaAktif:~w.~n", [W]),
    format(S, "arahPermainan:~w.~n", [A]),
    cekUni(U, LUni),
    format(S, "statusUNI:~w.~n", [LUni]),

    tulisLastAction(S),
    
    tulisKartu(S, U),
    
    write(S, 'selesai.'), nl(S),
    close(S),
    format("Game disimpan di ~w.~n", [File]),
    retractall(isStart(_)),
    asserta(isStart(0)),
    write('Permainan dihentikan. Gunakan loadGame untuk melanjutkan nanti.'), nl.

saveGame :-
    isStart(1), !,
    write('Tidak bisa save saat ini!'), nl.
saveGame :-
    write('Game belum mulai!'), nl.

tulisKartuTersembunyi(S,P) :-
    kartuTersembunyi(P,K),!,
    ubahKartu(K,Teks),
    format(S, "kartuTersembunyi('~w'):~w.~n", [P, Teks]).
tulisKartuTersembunyi(S,P) :-
    ubahKartu([], Teks),
    format(S, "kartuTersembunyi('~w'):~w.~n", [P, Teks]).

tulisLastAction(S) :-
    isActionAlready(1),!,
    lastAction(kartu(W, J)),
    lastActionPemain(Pemain),
    selisihAction(N),
    format(S, "lastAction:[~w-~w].~n", [W, J]),
    format(S, "lastActionPemain:'~w'.~n", [Pemain]),
    format(S, "selisihAction:~w.~n", [N]),
    format(S, "isActionAlready:1.~n", []).
tulisLastAction(S) :-
    isActionAlready(0),!,
    lastAction(kartu(W, J)),
    format(S, "lastAction:[~w-~w].~n", [W, J]),
    format(S, "lastActionPemain:none.~n", []),
    format(S, "selisihAction:0.~n", []),
    format(S, "isActionAlready:0.~n", []).
