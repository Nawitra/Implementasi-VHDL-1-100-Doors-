# Implementasi-VHDL-1-100-Doors

Proyek Perancangan Sistem Digital Modul 9

Kelompok A7 

Abdul Fattah Ismail / 1806200255

Farid Muhammad Rahman / 1806148662

Natalia Kristian / 1806200103

Vernando Wijaya Putra / 1806200280


Proyek ini adalah sebuah program dengan 100 pintu yang bisa dibuka dan ditutup dengan pattern tertentu,
pada awalnya semua pintu dalam kondisi tertutup dan ketika user mengklik 1 step maka user akan
mengunjungi pintu yang pertama dan step berikutnya adalah pintu berikutnya yang merupakan pintu berikutnya
untuk putaran pertama user akan mengunjungi semua pintu satu-persatu, setelah user mengunjungi pintu ke-100
maka user akan kembali ke pintu pertama dan pintu berikutnya adalah pintu yang berkelipatan 2 terus sampai
pintu ke-100 lagi sehingga kembali ke pintu pertama dengan user hanya bisa mengunjungi pintu berkelipatan 3
dan seterusnya. Jika pintu yang dikunjungi user dalam kondisi tertutup, maka setelah dikunjungi pintu akan
berubah kondisi menjadi kondisi terbuka dan sebaliknya.


Gambaran cara kerja program ini adalah sebagai berikut :

1. User akan start dari pintu 1
2. User menjalankan 1 step dan user akan mengunjungi pintu 1 dan mengubah kondisi dari pintu 1
   Note :       Jika pintu dalam kondisi terbuka maka setelah user mengunjungi pintu tersebut maka kondisinya
                akan berubah menjadi pintu yang tertutup, sedangkan jika pintu tersebut dalam kondisi tertutup
                maka kondisi pintu tersebut akan berubah menjadi pintu dengan kondisi terbuka dan seterusnya.
3. User akan melanjutkan mengunjungi pintu-pintu dengan kelipatan 1 sampai menuju pintu ke-100
4. User akan dikembalikan ke pintu 1 (belum dikunjungi) dan user hanya bisa mengunjungi pintu berkelipatan 2
5. Ketika user menjalan 1 step pada putaran ke 2 maka setelah user akan mengunjungi pintu 2, 4, 6, 8, ... dst
6. User akan melanjutkan mengunjungi pintu-pintu dengan kelipatan 2 sampai menuju pintu ke-100
7. Kegiatan ini akan berulang dan kelipatan maksimal adalah 5.
