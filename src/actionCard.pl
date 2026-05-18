actionCard(Jenis) :-
    Jenis is skip,!,
    actionSkip.
actionCard(Jenis) :-
    Jenis is reverse,!,
    actionReverse.
actionCard(Jenis) :-
    Jenis is drawTwo,!,
    actionDrawTwo.
actionCard(Jenis) :-
    Jenis is wild,!,
    actionWild.
actionCard(Jenis) :-
    Jenis is wildDrawFour,!,
    actionDrawFour.
actionCard(_).


actionSkip :-
    retractall(isSkip(_)),
    asserta(isSkip(1)).

actionReverse.

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