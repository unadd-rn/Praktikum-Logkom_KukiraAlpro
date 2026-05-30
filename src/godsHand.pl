godsHand :-
    isStart(0),!,
    write('Permainan belum dimulai!'),nl.

godsHand :-
    isStart(1),
    urutanAwal(Urutan),
    semua1Kartu(Urutan),!,
    write('Gods hand gagal karena seluruh pemain hanya memiliki 1 kartu.'),nl.

godsHand :-
    isStart(1),
    random(1,101,Angka),
    godsHandChance(Angka).

godsHandChance(Angka) :-
    Angka =< 20,!,
    jalankanGodsHand,
    selesaiGodsHand.

godsHandChance(Angka) :-
    Angka > 20, !,
    write('Tuhan belum berkehendak.'),nl,
    nextTurn.

selesaiGodsHand :-
    adaYangHabis, !,
    endGame.

selesaiGodsHand :-
    nextTurn.

jalankanGodsHand :-
    urutanAwal(Urutan),
    listPemberi(Urutan,ListPemberi),
    random_card(ListPemberi,Pemberi,_),
    kartuPemain(Pemberi,TanganPemberi),
    random_card(TanganPemberi,Kartu,TanganPemberiBaru),
    listPenerima(Urutan,Pemberi,ListPenerima),
    random_card(ListPenerima,Penerima,_),
    kartuPemain(Penerima,TanganPenerima),
    appendList(TanganPenerima,[Kartu],TanganPenerimaBaru),
    retract(kartuPemain(Pemberi,_)),
    asserta(kartuPemain(Pemberi,TanganPemberiBaru)),
    retract(kartuPemain(Penerima,_)),
    asserta(kartuPemain(Penerima,TanganPenerimaBaru)),
    Kartu = kartu(Warna,Jenis),
    write('Tuhan telah berkehendak.'),nl,
    format('Kartu ~w ~w milik ~w berpindah ke tangan ~w!~n',[Warna,Jenis,Pemberi,Penerima]),
    !.


semua1Kartu([]).
semua1Kartu([Pemain|T]) :-
    kartuPemain(Pemain,Kartu),
    count_list(Kartu,1),
    semua1Kartu(T).

listPemberi([],[]).
listPemberi([Pemain|T],[Pemain|Sisa]) :-
    kartuPemain(Pemain,_),
    listPemberi(T,Sisa).

listPenerima([],_,[]).
listPenerima([Pemberi|T],Pemberi,Sisa) :- !,
    listPenerima(T,Pemberi,Sisa).

listPenerima([Pemain|T],Pemberi,[Pemain|Sisa]) :-
    listPenerima(T,Pemberi,Sisa).
    
