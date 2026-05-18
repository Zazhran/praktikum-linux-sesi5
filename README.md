#Laporan Tugas Praktikum: Linux Ubuntu Server

**Nama** : Zahran Hilal Ramadhan
**Prodi** : Teknik Informatika

### Catatan pengerjaan
Pengerjaan tugas praktikum individu ini menggunakan Linux Ubuntu Server dengan menggunakan VirtualBox. Lalu, menggunakan local terminal atau Power Shell untuk mengerjakan transfer dari local menuju server menggunakan scp atau rsync.

### Kesulitan
Dalam pengerjaan tugas praktikum ini saya merasa sangat kesulitan karena proses codingnya dilakukan dalam bentuk terminal tidak seperti IDE ataupun notepad, sehingga typo bahkan spasi jauh lebih sensitif dan sudah tidak terhitung jari berapa kali saya typo hanya karena spasi.
Pada saat awal awal, saya menemukan kesulitan dimana file yang telah saya buat pasti menghilang dan itu membuat saya cukup stress dua hari karena tugasnya tidak ada kemajuan sama sekali. Hingga saatnya saya sadar ternyata saya belum  sepenuhnya install ubuntu servernya karena saya hanya memberikan 1GB space pada saat pembuatan server di virtualbox. Masalah tersebut teratasi dengan menambahkan space dari 1GB menjadi 10GB.

## Refleksi
Dari pengalaman saya mengerjakan tugas praktikum ini, dapat saya ambil pelajaran bahwa pengerjaan teknis seperti ini membutuhkan kejelian yang tinggi, meskipun bisa saja kita menyuruh AI untuk programnya, namun kita juga perlu mengetahui bagaimana basic dari ubuntu, dan siapa lagi selain kita yang akan mengetiknya


##Dokumentasi 

<img width="1920" height="1080" alt="SSH connect to local" src="https://github.com/user-attachments/assets/89ade106-2320-40a1-8510-3a4b379f2c56" />
**SSH Connect from ubuntu server to local**

<img width="1920" height="1080" alt="test scp + sha256" src="https://github.com/user-attachments/assets/199b31ac-4171-4962-8a0d-aa65a0f61bdf" />
**.scp Data transfer from local to ubuntu server**
Note : Lebih praktis menggunakan .scp karena syntaxnya yang tidak seribet rsync, dan kebetulan saya membuat folder dan filenya diluar ubuntu server, jadi saya langsung transfer folder dengan menggunakan .scp

<img width="1920" height="1080" alt="test rsync + sha256" src="https://github.com/user-attachments/assets/8e203c3b-480e-4189-9b94-f62b9e86f187" />
**-rsync Data transfer from local to ubuntu server**
Note : Secara teknis -rsync lebih diunggulkan karena kelebihannya yang menguntungkan project besar, karena ketika terjadi perubahan rsync akan compare dan tidak perlu mentransfer keseluruhannya berulang ulang. Karena itulah saya lebih prefer menggunakan .scp karena secara fungsi sudah terpenuhi, dan karena cakupannya hanya baru sebatas tugas.

