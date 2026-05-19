% Ini aku tambahin soalnya takutnya if else ga bole
coba(Goal) :- Goal, !.
coba(_).

/* Predikat Umum */
appendList([],H,H).
appendList([H|T],X,[H|T1]) :-
    appendList(T,X,T1).

/* Validasi Kartu */
kartuValid(kartu(Warna,_), kartu(Warna,_)).
kartuValid(kartu(_,Jenis), kartu(_,Jenis)).
kartuValid(kartu(hitam,_),_).
kartuValid(_,kartu(hitam,_)).

/*Validasi Non Hitam*/
validasiListNonHitam([], _).

validasiListNonHitam([H|T], Top):-
    validasiNonHitam(H, Top),
    validasiListNonHitam(T, Top).
validasiNonHitam(kartu(Warna,_), kartu(Warna,_)):-
    retractall(bisaNonHitam(_)),
    asserta(bisaNonHitam(1)), !.
validasiNonHitam(kartu(_,Jenis), kartu(_,Jenis)):-
    retractall(bisaNonHitam(_)),
    asserta(bisaNonHitam(1)), !.
validasiNonHitam(kartu(_,_), kartu(_,_)).

/* Mekanisme pilih kartu */
chooseCard(1, [Kartu|T], Kartu, T).

chooseCard(N, [H|T], Kartu, [H|T1]) :-
    N > 1,
    N1 is N-1,
    chooseCard(N1, T, Kartu, T1).

/* Mekanisme ganti giliran */
nextTurn:-
    isSkip(1),!,
    urutanPemain([H|T]),
    appendList(T,[H], UrtanBaru),
    retractall(urutanPemain(_)),
    asserta(urutanPemain(UrtanBaru)),
    UrtanBaru = [NextPemain|_],
    retractall(giliran(_)),
    asserta(giliran(NextPemain)),
    format('~nGiliran ~w di-SKIP!~n', [NextPemain]),
    retractall(isSkip(_)),
    asserta(isSkip(0)),
    nextTurn.
nextTurn:-
    isReverse(0),!,
    urutanPemain([H|T]),
    appendList(T,[H], UrtanBaru),
    retractall(urutanPemain(_)),
    asserta(urutanPemain(UrtanBaru)),
    UrtanBaru = [NextPemain|_],
    retractall(giliran(_)),
    asserta(giliran(NextPemain)),
    format('~nGiliran ~w.~n', [NextPemain]).
nextTurn:-
    isReverse(1),
    urutanPemain([H|T]),
    appendList(T,[H], UrtanBaru),
    reverseList(UrtanBaru,UrutanReverse),
    retractall(urutanPemain(_)),
    asserta(urutanPemain(UrutanReverse)),
    retractall(isReverse(_)),
    asserta(isReverse(0)),
    nextTurn.

/* Mekanisme mainkanKartu */
mainkanKartu(_) :-
    isStart(0),!,
    write('Permainan belum dimulai!'),
    fail.
mainkanKartu(_) :-
    isDrawTwo(1),!,
    write('Kamu tidak bisa memainkan kartu pada giliran ini! Silakan gunakan command ambilKartu!'),
    fail.
mainkanKartu(_) :-
    isDrawFour(1),!,
    write('Kamu tidak bisa memainkan kartu pada giliran ini! Silakan gunakan command ambilKartu!'),
    fail.
mainkanKartu(Idx) :-
    isStart(1),
    giliran(Pemain),
    kartuPemain(Pemain,List),
    topKartu(Top),
    chooseCard(Idx, List, Kartu, Sisa),!,
    validasiTop(Kartu),
    retract(kartuPemain(Pemain,_)),
    asserta(kartuPemain(Pemain, Sisa)),
    retract(topKartu(_)),
    asserta(topKartu(Kartu)),
    format('~w memainkan kartu: ~w.~n', [Pemain,Kartu]),
    topKartu(kartu(Warna,Jenis)),
    retractall(warna(_)),
    asserta(warna(Warna)),
    retractall(jenis(_)),
    asserta(jenis(Jenis)),
    actionCard(Jenis),
    nextTurn, 
    coba(endGame).
mainkanKartu(_) :-
    isStart(1),
    write('Index tidak valid!'),
    nl.

validasiTop(kartu(hitam,_)).
validasiTop(kartu(Warna,_)) :-
    warna(W),
    Warna = W.
validasiTop(kartu(_,Jenis)) :-
    jenis(J),
    Jenis = J,
    J \= drawTwo,
    J \= wildDrawFour.
validasiTop(_Kartu) :-
    write('Kartu yang dimainkan tidak valid!'),
    fail.

/*Tantang*/
tantang :-
    isStart(1),
    isDrawFour(0),!,
    write('Tidak ada yang menggunakan kartu Wild Draw Four, kamu tidak bisa menggunakan perintah ini!').
tantang:-
    isStart(1),
    bisaNonHitam(1),!, %gak boleh, pemain sebelumnya kena 4
    giliran(Pemain),
    urutanPemain(T),
    pemainSebelumnya(T, PemainSebelumnya),
    write('Tantangan dilakukan!'), nl,
    format('~nMemeriksa kartu ~w.~n', [PemainSebelumnya]), nl,
    deck(Deck),
    kartuPemain(PemainSebelumnya,List),
    bagiNKartu(4, Deck, HasilDrawFour),
    appendList(List, HasilDrawFour, ListBaru),
    format('~nTantangan berhasil ~w mendapatkan 4 kartu. .~n', [PemainSebelumnya]), nl,
    retract(kartuPemain(PemainSebelumnya,_)),
    assertz(kartuPemain(PemainSebelumnya,ListBaru)),
    retractall(isDrawFour(_)),
    asserta(isDrawFour(0)),
    retractall(bisaNonHitam(_)),
    asserta(bisaNonHitam(0)),
    nextTurn.

tantang:-
    isStart(1),
    bisaNonHitam(0),!,
    giliran(Pemain),
    urutanPemain(T),
    pemainSebelumnya(T, PemainSebelumnya),
    write('Tantangan dilakukan!'),
    format('~nMemeriksa kartu ~w.~n', [PemainSebelumnya]),
    giliran(Pemain),
    deck(Deck),
    kartuPemain(Pemain,List),
    bagiNKartu(6, Deck, HasilDrawFour),
    appendList(List, HasilDrawFour, ListBaru),
    format('~nTantangan gagal ~w mendapatkan 6 kartu. .~n', [Pemain]), nl,
    retract(kartuPemain(Pemain,_)),
    assertz(kartuPemain(Pemain,ListBaru)),
    retractall(isDrawFour(_)),
    asserta(isDrawFour(0)),
    retractall(bisaNonHitam(_)),
    asserta(bisaNonHitam(0)),
    nextTurn.
        
pemainSebelumnya([T], T).
pemainSebelumnya([_|T], Last):-
    pemainSebelumnya(T,Last).
    
/* Mekanisme Uni */
uni(Idx) :-
    isStart(1),
    giliran(Pemain),
    kartuPemain(Pemain,List),
    count_list(List,2),
    chooseCard(Idx,List,Kartu,Sisa),!,
    validasiTop(Kartu),
    retract(kartuPemain(Pemain,_)),
    asserta(kartuPemain(Pemain,Sisa)),
    retract(topKartu(_)),
    asserta(topKartu(Kartu)),
    retractall(sudahUni(Pemain)),
    assertz(sudahUni(Pemain)),
    format('~w memainkan kartu: ~w.~n', [Pemain,Kartu]),
    format('~w menyerukan UNI!~n',[Pemain]),nl,
    nextTurn.

uni(_) :-
    isStart(1),
    giliran(Pemain),
    format('Gagal menyerukan UNI, ~w mendapatkan penalti 1 kartu.~n',[Pemain]),
    kartuPemain(Pemain,List),
    deck(Deck),
    randomKartu(Deck,Penalti),
    appendList(List,[Penalti],ListBaru),
    retract(kartuPemain(Pemain,_)),
    asserta(kartuPemain(Pemain,ListBaru)),
    nextTurn.

/* Mekanisme Tangkap*/
tangkap(Target) :-
    isStart(1),
    giliran(Pemain),
    Target == Pemain, !,
    write('Tidak bisa menangkap diri sendiri.'),nl.

tangkap(Target) :-
    isStart(1),
    namaPemain(Target),
    kartuPemain(Target,List),
    count_list(List,1),
    \+sudahUni(Target),!,
    format('~w tertangkap tidak menyerukan UNI.~n', [Target]),
    format('~w mendapatkan 2 kartu penalti.~n',[Target]),

    deck(Deck),
    randomKartu(Deck,Kartu1),
    randomKartu(Deck,Kartu2),
    appendList(List,[Kartu1],Temp),
    appendList(Temp,[Kartu2],ListBaru),

    retract(kartuPemain(Target,_)),
    asserta(kartuPemain(Target,ListBaru)),
    retractall(sudahUni(Target)),
    nextTurn.

tangkap(_) :-
    isStart(1),
    giliran(Pemain),
    format('Gagal melakukan tangkap, ~w mendapat penalti 1 kartu.~n', [Pemain]),

    kartuPemain(Pemain,List),
    deck(Deck),
    randomKartu(Deck,Penalti),
    appendList(List,[Penalti],ListBaru),

    retract(kartuPemain(Pemain,_)),
    asserta(kartuPemain(Pemain,ListBaru)),
    nextTurn.

/* Mekanisme ambilKartu */
ambilKartu :-
    isStart(0),!,
    write('Permainan belum dimulai!'),
    fail.
ambilKartu :-
    isStart(1),
    isDrawTwo(1),!,
    giliran(Pemain),
    format('~w harus mengambil 2 kartu!~n', [Pemain]),
    deck(Deck),
    kartuPemain(Pemain,Kartu),
    bagiNKartu(2,Deck,Hasil),
    appendList(Kartu,Hasil,NewKartu),
    retractall(kartuPemain(Pemain,_)),
    asserta(kartuPemain(Pemain,NewKartu)),
    retractall(isDrawTwo(_)),
    asserta(isDrawTwo(0)),
    nextTurn.
ambilKartu :-
    isStart(1),
    isDrawFour(1),!,
    giliran(Pemain),
    format('~w harus mengambil 4 kartu!~n', [Pemain]),
    deck(Deck),
    kartuPemain(Pemain,List),
    bagiNKartu(4, Deck, HasilDrawFour),
    appendList(List, HasilDrawFour, ListBaru),
    retractall(kartuPemain(Pemain,_)),
    assertz(kartuPemain(Pemain,ListBaru)),
    retractall(isDrawFour(_)),
    asserta(isDrawFour(0)),
    retractall(bisaNonHitam(_)),
    asserta(bisaNonHitam(0)),
    nextTurn.
ambilKartu :-
    isStart(1),
    giliran(Pemain),
    deck(Deck),
    kartuPemain(Pemain,List),
    randomKartu(Deck, Kartu),
    appendList(List,[Kartu], List1),
    retract(kartuPemain(Pemain,_)),
    asserta(kartuPemain(Pemain,List1)),
    format('~w mendapatkan kartu: ~w.~n', [Pemain,Kartu]),
    nextTurn,
    coba(endGame). 

exit :-
    isStart(1),!,
    retract(isStart(1)),
    asserta(isStart(0)).

reverseList([],[]).
reverseList([H],[H]).
reverseList([H|T],NewList) :-
    reverseList(T,L1),
    appendList(L1,[H],NewList).