% ini biar jalan aja
:- dynamic giliran/1.
:- dynamic kartuPemain/2.
:- dynamic topKartu/1.
:- dynamic urutanPemain/1.

giliran(aaa).
urutanPemain([aaa, bbb]).
topKartu(kartu(merah, 5)).

kartuPemain(aaa, [kartu(merah,3), kartu(kuning,7), kartu(hitam,wild)]).
kartuPemain(bbb, [kartu(biru,2), kartu(hijau,skip)]).

lihatCommand :-
    writeln('!!!COMMANDS!!!'),
    writeln('mainkanKartu(Index)'),
    writeln('ambilKartu'),
    writeln('tantang'),
    writeln('uni(Index)'),
    writeln('tangkap(Nama)'),
    writeln('lihatCommand'),
    writeln('lihatKartu'),
    writeln('cekInfo'),
    writeln('endGame'),
    writeln('saveGame'),
    writeln('loadGame').

lihatKartu :-
    giliran(N),
    kartuPemain(N, K),
    writeln('kartu kamu:'),
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
    writeln(' '),
    writeln('kartu tiap pemain:'),
    infoP(U).

infoP([]).
infoP([Nama|T]) :-
    kartuPemain(Nama, K),
    length(K, Jml),
    format("~w: ~w kartu~n", [Nama, Jml]),
    infoP(T).