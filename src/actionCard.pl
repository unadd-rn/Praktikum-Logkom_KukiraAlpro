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


actionSkip.

actionReverse.

actionDrawTwo :-
    retractall(isDrawTwo(_)),
    asserta(isDrawTwo(1)).

actionWild.

actionDrawFour.