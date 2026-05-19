:- include('randomCard.pl').
:- include('Kartu.pl').
:- include('Turn.pl').
:- include('aksiPendukung.pl').
:- include('startGame.pl').
:- include('actionCard.pl').
:- include('endGame.pl').

:- dynamic(namaPemain/1).
:- dynamic(jumlahPemain/1).
:- dynamic(topKartu/1).
:- dynamic(suksesor/2).
:- dynamic(giliran/1).
:- dynamic(kartuPemain/2).
:- dynamic(urutanPemain/1).
:- dynamic(urutanAwal/1).
:- dynamic(isStart/1). 
:- dynamic(isSkip/1). 
:- dynamic(isReverse/1). 
:- dynamic(isDrawTwo/1). 
:- dynamic(isDrawFour/1).
:- dynamic(isWild/1).
:- dynamic(arah/1).
:- dynamic(warna/1).
:- dynamic(jenis/1).
:- dynamic(sudahUni/1).

isStart(0).
isSkip(0).
isReverse(0).
isWild(0).
isDrawTwo(0).
isDrawFour(0).
arah(kanan).


