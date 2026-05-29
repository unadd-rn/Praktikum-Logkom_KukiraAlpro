

lihatCommand :-
    isStart(1),
    isSkip(0),
    isDrawTwo(0),
    isDrawFour(0),
    write('!!!COMMANDS!!!'),nl,
    write('mainkanKartu(Index)'),nl,
    write('ambilKartu'),nl,
    write('uni(Index)'),nl,
    write('tangkap(Nama)'),nl,
    write('lihatCommand'),nl,
    write('lihatKartu'),nl,
    write('cekInfo'),nl,
    write('endGame'),nl,
    write('saveGame'),nl,
    write('loadGame'),nl.
lihatCommand :-
    (isSkip(1) ; isDrawTwo(1)),
    write('!!!COMMANDS!!!'),nl,
    write('ambilKartu'),nl,
    write('tangkap(Nama)'),nl,
    write('lihatCommand'),nl,
    write('lihatKartu'),nl,
    write('cekInfo'),nl,
    write('endGame'),nl,
    write('saveGame'),nl,
    write('loadGame'),nl.
lihatCommand :-
    isDrawFour(1),
    write('!!!COMMANDS!!!'),nl,
    write('ambilKartu'),nl,
    write('tantang'),nl,
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
    cetak(K, 1, N).

cetak([], _, _).
cetak([kartu(W,J)|T], N, Pemain) :-
    kartuTersembunyi(Pemain,List),
    isInList(kartu(W,J),List),!,
    format("~w. ~w ~w (Tersembunyi)~n", [N, W, J]),
    N1 is N + 1,
    cetak(T, N1, Pemain).
cetak([kartu(W,J)|T], N, Pemain) :-
    format("~w. ~w ~w~n", [N, W, J]),
    N1 is N + 1,
    cetak(T, N1, Pemain).

cekInfo :-
    topKartu(Atas),
    urutanAwal(U),
    format("kartu atas: ~w~n", [Atas]),
    format("urutan: ~w~n", [U]),
    write(' '),nl,
    write('kartu tiap pemain:'),nl,
    infoP(U).

infoP([]).
infoP([Nama|T]) :-
    kartuPemain(Nama, K),
    kartuTersembunyi(Nama, S),
    lengthList(K, X),
    lengthList(S, Y),
    Z is X-Y,
    format("~w: ~w kartu~n", [Nama, Z]),
    infoP(T).

lengthList([],0).
lengthList([H],1).
lengthList([H|T],N) :-
    lengthList(T,N1),
    N is N1+1.