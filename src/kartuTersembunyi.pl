sembunyikanKartu(Idx) :-
    isStart(0),!,
    write('Permainan belum dimulai!'),
    fail.
sembunyikanKartu(Idx) :-
    isDrawTwo(1),!,
    write('Kamu tidak bisa menyembunyikan kartu pada giliran ini. Silakan ambil kartu!'),
    fail.
sembunyikanKartu(Idx) :-
    isDrawFour(1),!,
    write('Kamu tidak bisa menyembunyikan kartu pada giliran ini. Silakan ambil kartu!'),
    fail.
sembunyikanKartu(Idx) :-
    isStart(1),
    giliran(Pemain),
    kartuPemain(Pemain,List),
    count_list(List,X),
    X<2,!,
    write('Kamu tidak bisa menyembunyiakn kartu yang tersisa tinggal 1!'),
    fail.
sembunyikanKartu(Idx) :-
    isStart(1),
    giliran(Pemain),
    kartuPemain(Pemain,List),
    kartuTersembunyi(Pemain,Tersembunyi),
    count_list(List,1),!,
    chooseCard(Idx, List, Kartu, Sisa),
    retractall(kartuPemain(Pemain,_)),
    asserta(kartuPemain(Pemain,Sisa)),
    appendList(Tersembunyi,[Kartu],ListBaru),
    retractall(kartuTersembunyi(Pemain,_)),
    asserta(kartuTersembunyi(Pemain,ListBaru)),
    format('Kartu ~w berhasil disembunyian!', [Kartu]),
    nextTurn.

