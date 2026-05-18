actionCard(skip) :-
    !,actionSkip.
actionCard(reverse) :-
    !,actionReverse.
actionCard(drawTwo) :-
    !,actionDrawTwo.
actionCard(wild) :-
    !,actionWild.
actionCard(wildDrawFour) :-
    !,actionDrawFour.
actionCard(_).


actionSkip :-
    retractall(isSkip(_)),
    asserta(isSkip(1)).

actionReverse :-
    arah(kiri),!,
    retractall(arah(_)),
    asserta(arah(kanan)),
    retractall(isReverse(_)),
    asserta(isReverse(1)).
actionReverse :-
    arah(kanan),!,
    retractall(arah(_)),
    asserta(arah(kiri)),
    retractall(isReverse(_)),
    asserta(isReverse(1)).

actionDrawTwo :-
    retractall(isDrawTwo(_)),
    asserta(isDrawTwo(1)).

actionWild :-
    write('Silakan memilih warna merah/kuning/hijau/biru!'),
    nl,
    inputWarna.


actionDrawFour.


inputWarna:-
    read(Warna),
    retractall(warna(_)),
    asserta(warna(Warna)),
    format('Warna ~w telah dipilih!',[Warna]).