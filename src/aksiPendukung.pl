

lihatCommand :-
    write('!!!COMMANDS!!!'),nl,
    write('mainkanKartu(Index)'),nl,
    write('ambilKartu'),nl,
    write('tantang'),nl,
    write('uni(Index)'),nl,
    write('tangkap(Nama)'),nl,
    write('lihatCommand'),nl,
    write('lihatKartu'),nl,
    write('cekInfo'),nl,
    write('endGame'),nl,
    write('saveGame'),nl,
    write('loadGame'),nl.

lihatKartu :-
    giliran(N),
    kartuPemain(N, K),
    write('kartu kamu:'),nl,
    cetak(K, 1).

cetak([], _).
cetak([kartu(W,J)|T], N) :-
    format("~w. ~w ~w~n", [N, W, J]),
    N1 is N + 1,
    cetak(T, N1).

cekInfo :-
    topKartu(Atas),
    urutanPemain(U),
    format("kartu atas: ~w~n", [Atas]),
    format("urutan: ~w~n", [U]),
    write(' '),nl,
    write('kartu tiap pemain:'),nl,
    infoP(U).

infoP([]).
infoP([Nama|T]) :-
    kartuPemain(Nama, K),
    length(K, Jml),
    format("~w: ~w kartu~n", [Nama, Jml]),
    infoP(T).