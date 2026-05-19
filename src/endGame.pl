nilaiKartu(kartu(_, J), N) :- number(J), N is J.
nilaiKartu(kartu(_, skip), 10).
nilaiKartu(kartu(_, reverse), 10).
nilaiKartu(kartu(_, drawTwo), 10).
nilaiKartu(kartu(_, wild), 20).
nilaiKartu(kartu(_, wildDrawFour), 20).
nilaiKartu(kartu(_, mimic), 20).

hitungPoin([], 0).
hitungPoin([H|T], Total) :-
    nilaiKartu(H, N),
    hitungPoin(T, Rest),
    Total is N + Rest.

insertUrut(X, [], [X]).
insertUrut(Poin-Nama, [Poin2-Nama2|T], [Poin-Nama, Poin2-Nama2|T]) :-
    Poin =< Poin2.
insertUrut(Poin-Nama, [Poin2-Nama2|T], [Poin2-Nama2|Sisa]) :-
    Poin > Poin2,
    insertUrut(Poin-Nama, T, Sisa).

sorting([],[]).
sorting([H|T], Bener) :-
    sorting(T, SisaBener),
    insertUrut(H, SisaBener, Bener).

scoreBoard([], _, []).
scoreBoard([Nama|T], Pemenang, Sisa) :-
    Nama = Pemenang, !,
    scoreBoard(T, Pemenang, Sisa).
scoreBoard([Nama|T], Pemenang, Sisa) :-
    kartuPemain(Nama, Kartu),
    hitungPoin(Kartu, Poin),
    scoreBoard(T, Pemenang, Sisa).

cetakScoreboard([], _).
cetakScoreboard([Poin-Nama|T], Rank) :-
    format("~w. ~w - ~w poin~n", [Rank, Nama, Poin]),
    Rank1 is Rank + 1,
    cetakScoreboard(T, Rank1).

endGame :-
    % kartuPemain(_, []),
    giliran(Pemenang),
    urutanAwal(U),
    write('GAME OVER!!!'), nl,
    format("1. ~w - 0 poin~n", [Pemenang]),
    scoreBoard(U, Pemenang, ListPoin),
    sorting(ListPoin, Terurut),
    cetakScoreboard(Terurut, 2).