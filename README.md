# Implementasi-VHDL-1-Military-Tactics

Proyek Perancangan Sistem Digital Modul 9

Kelompok A7 

Abdul Fattah Ismail / 1806200255

Farid Muhammad Rahman / 1806148662

Natalia Kristian / 1806200103

Vernando Wijaya Putra / 1806200280


Proyek ini adalah sebuah program dengan menggunakan finite state machine, user dapat memainkan program ini dengan
berbagai strategi untuk mengalahkan lawan, user akan bermain sebagai army sedangkan lawan akan dinamakan sebagai
bandit, masing-masing army dan bandit memiliki force yang secara random akan ditambahkan atau dikurangi ke total
force yang dimiliki masing-masing force. State yang dimiliki adalah Plan sebagai starting awal program, dimana
user akan secara bebas memasukkan input kepada army dan bandit, dengan kedua input ini akan menentukan state berikutnya.
State Attack adalah state dimana user army atau bandit menyerang, strategi user diuji dari setiap state. Jika army
menang maka user akan diarahkan ke state Win dan otomatis mengarah ke state Stop dimana program berhenti secara
otomatis, ketika bandit menang atau army kalah maka user akan diantarkan ke state Retreat dan kemudian kembali ke
state Plan dimana permainan kembali keawal dan user dapat melanjutkan permainan. Setiap state memiliki table truth
yang berbeda-beda sehingga direkomendasikan untuk membaca truth table terlebih dahulu dan kemudian memainkan program ini
sebagai test untuk menguji strategi user.


Gambaran cara kerja program ini adalah sebagai berikut :

1. User diarahkan untuk mengisi value dari army dan bandit
2. Program akan mengarahkan user ke state baru dimana user diperbolehkan untuk melakukan ubah value dari tindakan
   army ataupun bandit.
3. Program memiliki fitur AF (Army Force) dan BF (Bandit Force) dimana kedua value ini mempengaruhi hasil variable En.
4. Penentuan state berikutnya dipengaruhi oleh value army, bandit, dan enable.
5. User jika mencapai state Retreat maka user tidak berhasil memenangkan permainan dan kembali ke state Plan.
6. User jika mencapai state Win maka user berhasil memenangkan permainan dan diarahkan ke state Stop.
