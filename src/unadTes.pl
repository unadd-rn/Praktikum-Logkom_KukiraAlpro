% ini biar jalan aja
giliran(alice).
<<<<<<< Updated upstream
namaP1(alice).
namaP2(bob).
kartuP1([]).
kartuP2([]).
=======
namaPemain1(alice).
namaPemain2(bob).
kartuPemain1([]).
kartuPemain2([]).
>>>>>>> Stashed changes
discard_top(kartu(merah, 5)).
warnaAktif(merah).
urutanPemain([alice, bob]).
jumlahPemain(2).

<<<<<<< Updated upstream
namaP3(none).
namaP4(none).
kartuP3([]).
kartuP4([]).
=======
namaPemain3(none).
namaPemain4(none).
kartuPemain3([]).
kartuPemain4([]).
>>>>>>> Stashed changes

lihatCommand :-
    writeln('!!!COMMANDS!!!'),
    writeln('mainKartu(Index)'),
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
    milik(N, K),
    writeln('kartu kamu:'),
    cetak(K, 1).

cetak([], _).
cetak([kartu(W,J)|T], N) :-
    format("~w. ~w ~w~n", [N, W, J]),
    N1 is N + 1,
    cetak(T, N1).

<<<<<<< Updated upstream
milik(N, K) :- namaP1(N), kartuP1(K), !.
milik(N, K) :- namaP2(N), kartuP2(K), !.
milik(N, K) :- namaP3(N), kartuP3(K), !.
milik(N, K) :- namaP4(N), kartuP4(K), !.
=======
milik(N, K) :- namaPemain1(N), kartuPemain1(K), !.
milik(N, K) :- namaPemain2(N), kartuPemain2(K), !.
milik(N, K) :- namaPemain3(N), kartuPemain3(K), !.
milik(N, K) :- namaPemain4(N), kartuPemain4(K), !.
>>>>>>> Stashed changes

cekInfo :-
    discard_top(Atas),
    warnaAktif(W),
    urutanPemain(U),
    format("kartu atas: ~w~n", [Atas]),
    format("warna aktif: ~w~n", [W]),
    format("urutan: ~w~n", [U]),
    writeln('kartu tiap pemain yey'),
    jumlahPemain(N),
    infoP(1, N).

infoP(I, N) :- I > N, !.
infoP(I, N) :-
    milikI(I, Nama, K),
    Nama \= none,
    length(K, Jml),
    format("~w: ~w kartu~n", [Nama, Jml]),
    I1 is I + 1,
    infoP(I1, N).
infoP(I, N) :-
    milikI(I, none, _), !,
    I1 is I + 1,
    infoP(I1, N).

<<<<<<< Updated upstream
milikI(1, N, K) :- namaP1(N), kartuP1(K).
milikI(2, N, K) :- namaP2(N), kartuP2(K).
milikI(3, N, K) :- namaP3(N), kartuP3(K).
milikI(4, N, K) :- namaP4(N), kartuP4(K).
=======
milikI(1, N, K) :- namaPemain1(N), kartuPemain1(K).
milikI(2, N, K) :- namaPemain2(N), kartuPemain2(K).
milikI(3, N, K) :- namaPemain3(N), kartuPemain3(K).
milikI(4, N, K) :- namaPemain4(N), kartuPemain4(K).
>>>>>>> Stashed changes
