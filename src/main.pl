:- include('randomCard.pl').
:- include('Kartu.pl').
:- include('Turn.pl').
:- include('aksiPendukung.pl').
:- include('startGame.pl').

:- dynamic(namaPemain/1).
:- dynamic(jumlahPemain/1).
:- dynamic(topKartu/1).
:- dynamic(suksesor/2).
:- dynamic(giliran/1).
:- dynamic(kartuPemain/2).
:- dynamic(urutanPemain/1).
:- dynamic(isStart/1). 


isStart(0).


