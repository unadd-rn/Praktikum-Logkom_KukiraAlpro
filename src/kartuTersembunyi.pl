sembunyikanKartu(Idx) :-
    isStart(0),!,
    write('Permainan belum dimulai!'),
    fail.
sembunyikanKartu(Idx) :-
    isDrawTwo(1),!,
    write('Kamu tidak bisa menyembunyikan kartu pada giliran ini. Silakan ambil kartu!'),nl,
    fail.
sembunyikanKartu(Idx) :-
    isDrawFour(1),!,
    write('Kamu tidak bisa menyembunyikan kartu pada giliran ini. Silakan ambil kartu!'),nl,
    fail.
sembunyikanKartu(Idx) :-
    isStart(1),
    giliran(Pemain),
    kartuPemain(Pemain,List),
    count_list(List,X),
    X<2,!,
    write('Kamu tidak bisa menyembunyiakn kartu yang tersisa tinggal 1!'),nl,
    fail.
sembunyikanKartu(Idx) :-
    isStart(1),
    giliran(Pemain),
    kartuPemain(Pemain,List),
    kartuTersembunyi(Pemain,Tersembunyi),
    count_list(List,X),
    X>1,!,
    chooseCard(Idx, List, Kartu, Sisa),
    appendList(Tersembunyi,[Kartu],ListBaru),
    retractall(kartuTersembunyi(Pemain,_)),
    asserta(kartuTersembunyi(Pemain,ListBaru)),
    format('Kartu ~w berhasil disembunyian!~n', [Kartu]),
    nextTurn.

isInList(X,[]) :- fail.
isInList(X,[X|_]).
isInList(X,[_|T]) :-
    isInList(X,T).

tampilkanKartu :-
    isStart(0),!,
    write('Permainan belum dimulai!'),nl,
    fail.
tampilkanKartu :-
    isDrawTwo(1),!,
    write('Kamu tidak bisa menampilkan kartu pada giliran ini. Silakan ambil kartu!'),nl,
    fail.
tampilkanKartu :-
    isDrawFour(1),!,
    write('Kamu tidak bisa menampilkan kartu pada giliran ini. Silakan ambil kartu!'),nl,
    fail.
tampilkanKartu :-
    isStart(1),
    giliran(Pemain),
    retractall(kartuTersembunyi(Pemain,_)),
    asserta(kartuTersembunyi(Pemain,[])),
    format('Semua kartu tersembunyi ~w berhasil ditampilkan!~n', [Pemain]),
    nextTurn.