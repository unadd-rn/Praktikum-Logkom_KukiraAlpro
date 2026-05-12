use_module(library(random)).

deck([
    kartu(merah,0), kartu(merah,1), kartu(merah,2), kartu(merah,3), kartu(merah,4),
    kartu(merah,5), kartu(merah,6), kartu(merah,7), kartu(merah,8), kartu(merah,9),
    kartu(kuning,0), kartu(kuning,1), kartu(kuning,2), kartu(kuning,3), kartu(kuning,4),
    kartu(kuning,5), kartu(kuning,6), kartu(kuning,7), kartu(kuning,8), kartu(kuning,9),
    kartu(hijau,0), kartu(hijau,1), kartu(hijau,2), kartu(hijau,3), kartu(hijau,4),
    kartu(hijau,5), kartu(hijau,6), kartu(hijau,7), kartu(hijau,8), kartu(hijau,9),
    kartu(biru,0), kartu(biru,1), kartu(biru,2), kartu(biru,3), kartu(biru,4),
    kartu(biru,5), kartu(biru,6), kartu(biru,7), kartu(biru,8), kartu(biru,9),
    kartu(merah,skip), kartu(kuning,skip), kartu(hijau,skip), kartu(biru,skip),
    kartu(merah,reverse), kartu(kuning,reverse), kartu(hijau,reverse), kartu(biru,reverse),
    kartu(merah,drawTwo), kartu(kuning,drawTwo), kartu(hijau,drawTwo), kartu(biru,drawTwo),
    kartu(hitam,wild), kartu(hitam,wildDrawFour)
]).

:-dynamic(tanganPemain/2).

random_card(Hand, Card) :-
    random(0, 54, Index),
    pick_at_index(Hand, Index, Card).

pick_at_index([H|_], 0, H) :- !.
pick_at_index([_|T], I, Card) :-
    I1 is I - 1,
    pick_at_index(T, I1, Card).

cetakTanganPemain([]).
cetakTanganPemain([Pemain|Sisa]):-
    tanganPemain(Pemain,Kartu),
    write('Kartu '),write(Pemain),write(': '),write(Kartu),nl,
    cetakTanganPemain(Sisa).

bagi7Kartu(0,_,[]).
bagi7Kartu(N,Deck,[Kartu|TanganSisa]) :-
    N>0,
    random_card(Deck,Kartu),
    N1 is N-1,
    bagi7Kartu(N1,Deck,TanganSisa).

bagiKePemain([],_).
bagiKePemain([Pemain|SisaPemain],Deck):-
    bagi7Kartu(7,Deck,TanganPemain),
    assertz(tanganPemain(Pemain,TanganPemain)),
    bagiKePemain(SisaPemain,Deck).

tesBagiKartu :-
    retractall(tanganPemain(_,_)),
    ListPemain=['Prana','Unad','Fritz'],
    write('Daftar Pemain:'), write(ListPemain),nl,

    deck(JumlahKartu),

    bagiKePemain(ListPemain,JumlahKartu),nl,
    cetakTanganPemain(ListPemain).


