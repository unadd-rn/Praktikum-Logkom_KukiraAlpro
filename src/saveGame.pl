bikinNama(In, Out) :-
    name(In, L1),
    name('.txt', L2),
    appendList(L1, L2, L3),
    name(Out, L3).

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
    
    urutanPemain(U),
    giliran(G),
    topKartu(Top),
    warna(W),
    arah(A),
    
    format(S, "urutan_pemain:~w.~n", [U]),
    format(S, "giliran:'~w'.~n", [G]),
    
    Top = kartu(WTop, JTop),
    format(S, "discard_top:~w-~w.~n", [WTop, JTop]),
    format(S, "warna_aktif:~w.~n", [W]),
    format(S, "arah_permainan:~w.~n", [A]),
    
    cekUni(U, LUni),
    format(S, "status_UNI:~w.~n", [LUni]),
    
    tulisKartu(S, U),
    
    write(S, 'selesai.'), nl(S),
    close(S),
    format("Game disimpan di ~w.~n", [File]).

saveGame :-
    isStart(1), !,
    write('Tidak bisa save saat ini!'), nl.
saveGame :-
    write('Game belum mulai!'), nl.