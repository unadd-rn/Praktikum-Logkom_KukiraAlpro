# Praktikum Prolog : Game Uni G18 KukiraAlpro

Praktikum ini mengembangkan Game UNI berbasis terminal yang menyediakan beberapa fitur utama seperti startGame, mainkanKartu, ambilKartu, tangkap, Uni, tantang, load dan save game, dan lainnya. Kartu yang diimplementasikan terdapat kartu yang biasa ditemukan di game kartu biasa, kartu skip, kartu reverse, kartu wild, dan kartu draw. Program ini juga mengimplementasikan beberapa fitur tambahan seperti god's hand, sembunyikan kartu, dan kartu mimic. 

Program diimplementasikan dengan prolog dan memanfaatkan berbagai implementasi Prolog seperti rekurens, list, cut, fail, loop, dan file processing.

## How to Play!

### Aturan Dasar
1. Setiap permainan akan dimulai dengan 7 kartu acak. Tujuan game ini adalah mengahabiskan seluruh kartu yang dimiliki
2. Kartu hanya bisa dibuang (discard) jika kartu cocok dengan kartu di top
3. Kartu cocok jika warna, angka, atau jenis sama
4. Kartu Hitam/Wild dapat dikeluarkan kapan saja tanpa melihat top
5. Have fun!

### Run Program
Untuk menjalankan program di GNU Prolog jalankan:
```bash
consult main.pl
```
Untuk memulai game jalankan:
```bash
| ?- startGame.
```
Untuk mengecek kartu dan status permainan jalankan:
```bash
| ?- lihatKartu.
| ?- cekInfo.
```
Untuk membuang kartu jika cocok atau mengambil kartu jika tidak ada yang cocok jalankan:
```bash
| ?- mainkanKartu(Idx).
| ?- ambilKartu.
```
Jika ingin melanjutkan game di lain hari jalankan:
```bash
| ?- saveGame.
```
Dan untuk memuat game lagi jalankan:
```bash
| ?- loadGame.
```

## Fitur

| Fitur | Deskripsi |
|-------|-----------|
| startGame | Memulai game |
| mainkanKartu(Idx) | Memainkan kartu |
| ambilKartu | Mengambil kartu |
| Uni | Menghindari penalti saat kartu akan sisa 1 |
| Tangkap | Memberi penalti jika pemain tidak menyebut Uni |
| actionCard | Kartu skip, reverse, draw, wild |
| endGame | Mengakhiri game dan menampilkan scoreboard |
| saveGame | Menyimpan game ke file .txt |
| loadGame | Membuka game dari file .txt |
| aksiPendukung | lihatCommand, lihatKartu, cekInfo |
| exit | Mengakhiri game tanpa pemenang |
| God's Hand | Memindahkan kartu acak ke pemain lain |
| Mimic | Action card yang menyalin action kartu paling atas |
| sembunyikanKartu(Idx) | Menyembunyikan kartu dari pemain lain |
| tampilkanKartu | Menampilkan kartu yang disembunyikan |

## Pembagian Tugas

| Nama | NIM | Tugas |
|------|-----|-------|
| Pasaribu Fritz T.A.M | 13525105 | mekanisme turn, actionCard, kartu tersembunyi, integrasi total |
| Gede Pranajayanta S. | 13525099 | startGame, wildDrawFour, tantang, mimic |
| Edbert Fernando | 13525111 | Deck, pembagian kartu, uni, tangkap, god's hand |
| Nadia Aulia Syafarani | 13525122 | aksiPendukung, endGame, save & load game |
