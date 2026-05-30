godsHand :-
    isStart(0),!,
    write('Permainan belum dimulai!'),nl.

godsHand :-
    isStart(1),!,
    random(1,101,Angka),
    godsHandChance(Angka).

godsHandChance(Angka) :-
    Angka =< 20, !, 
    jalankanGodsHand,
    nextTurn.

godsHandChance(Angka) :-
    Angka > 20, !,
    write('Tuhan belum berkehendak.'),nl,
    nextTurn.

jalankanGodsHand :-
    urutanAwal(Urutan),
    listPemberi(Urutan,ListPemberi),
    listKosong(ListPemberi), !,
    write('Gods hand gagal karena tidak ada pemain yang memiliki lebih dari 1 kartu.'),nl.

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
    format('Kartu ~w ~w milik ~w berpindah ke tangan ~w!~n',[Warna,Jenis,Pemberi,Penerima]).

listKosong([]).

listPemberi([],[]).
listPemberi([Pemain|T],[Pemain|Sisa]) :-
    kartuPemain(Pemain,Kartu),
    count_list(Kartu,Jumlah),
    Jumlah > 1, !,
    listPemberi(T,Sisa).

listPemberi([_|T],Sisa) :-
    listPemberi(T,Sisa).

listPenerima([],_,[]).
listPenerima([Pemberi|T],Pemberi,Sisa) :- !,
    listPenerima(T,Pemberi,Sisa).

listPenerima([Pemain|T],Pemberi,[Pemain|Sisa]) :-
    listPenerima(T,Pemberi,Sisa).
    
tesGodsHandKosong :-
    urutanAwal([A,B|_]),

    retractall(kartuPemain(A,_)),
    retractall(kartuPemain(B,_)),

    asserta(kartuPemain(A,[kartu(merah,1)])),
    asserta(kartuPemain(B,[kartu(biru,2)])).

