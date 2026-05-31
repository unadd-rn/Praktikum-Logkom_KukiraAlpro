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
actionCard(mimic):-
	!,actionMimic.
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

actionMimic:-
	lastAction(kartu(Warna, Jenis)),
	giliran(Pemain),
	selisihAction(Selisih),
	write('Menelusuri riwayat permainan'),
	nl,
	format('~nKartu aksi terakhir yang dimainkan: ~w (oleh ~w, ~w giliran lalu)~n', [kartu(Warna, Jenis), Pemain, Selisih]),
	format('~nKartu mimic menyalin efek ~w~n', LastActionCard),
	actionCard(Jenis).

actionDrawFour :-
    giliran(Pemain),
    kartuPemain(Pemain,Kartu),
    topKartu(Top),
    validasiListNonHitam(Kartu,Top),
    write('Silakan memilih warna merah/kuning/hijau/biru!'),
    nl,
    inputWarna,
    retractall(isDrawFour(_)),
    asserta(isDrawFour(1)).


inputWarna:-
    read(Warna),
    retractall(warna(_)),
    asserta(warna(Warna)),
    format('Warna ~w telah dipilih!',[Warna]).

cekActionHelper(Kartu):-
	retractall(lastAction(_)),
	asserta(lastAction(Kartu)).

cekAction(kartu(Warna, Jenis), 0):-
	kartu(_, skip),
	!,
	retractall(isActionAlready(_)),
	asserta(isActionAlready(1)),
	Num is 0,
	retractall(selisihAction(_)),
	asserta(selisihAction(Num)),
	cekActionHelper(kartu(Warna, Jenis)).
cekAction(kartu(Warna, Jenis), 0):-
	kartu(_, reverse),
	!,
	retractall(isActionAlready(_)),
	asserta(isActionAlready(1)),
	Num is 0,
	retractall(selisihAction(_)),
	asserta(selisihAction(Num)),
	cekActionHelper(kartu(Warna, Jenis)).
cekAction(kartu(Warna, Jenis), 0):-
	kartu(_, drawTwo),
	!,
	retractall(isActionAlready(_)),
	asserta(isActionAlready(1)),
	Num is 0,
	retractall(selisihAction(_)),
	asserta(selisihAction(Num)),
	cekActionHelper(kartu(Warna, Jenis)).
cekAction(kartu(Warna, Jenis), 0):-
	kartu(_, reverse),
	!,
	retractall(isActionAlready(_)),
	asserta(isActionAlready(1)),
	Num is 0,
	retractall(selisihAction(_)),
	asserta(selisihAction(Num)),
	cekActionHelper(kartu(Warna, Jenis)).
cekAction(kartu(Warna, Jenis), 0):-
	kartu(_, wild),
	!,
	retractall(isActionAlready(_)),
	asserta(isActionAlready(1)),
	Num is 0,
	retractall(selisihAction(_)),
	asserta(selisihAction(Num)),
	cekActionHelper(kartu(Warna, Jenis)).
cekAction(kartu(Warna, Jenis), 0):-
	kartu(_, wildDrawFour),
	!,
	retractall(isActionAlready(_)),
	asserta(isActionAlready(1)),
	Num is 0,
	retractall(selisihAction(_)),
	asserta(selisihAction(Num)),
	cekActionHelper(kartu(Warna, Jenis)).
cekAction(kartu(Warna, Jenis), Num):-
	isActionAlready(1),
	!,
	selisihAction(Prev),
	Num is Prev + 1,
	retractall(selisihAction(_)),
	asserta(selisihAction(Num)),
	cekActionHelper(kartu(Warna, Jenis)).
cekAction(kartu(Warna, Jenis), 1):-
	isActionAlready(0),
	!,
	Num is 1,
	retractall(selisihAction(_)),
	asserta(selisihAction(Num)),
	cekActionHelper(kartu(Warna, Jenis)).