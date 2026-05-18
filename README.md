# Laporan Tugas Praktikum — Linux Ubuntu Server

**Nama**  : Zahran Hilal Ramadhan  
**Prodi** : Teknik Informatika  

---

## Catatan Pengerjaan

Pengerjaan tugas praktikum individu ini dilakukan menggunakan Linux Ubuntu Server melalui VirtualBox. Selain itu, saya juga menggunakan terminal lokal atau PowerShell untuk melakukan transfer file dari local machine menuju Ubuntu Server menggunakan `scp` maupun `rsync`.

---

## Kesulitan

Dalam pengerjaan tugas praktikum ini, saya mengalami cukup banyak kesulitan karena seluruh proses dilakukan melalui terminal, berbeda dengan IDE atau text editor biasa. Akibatnya, typo maupun kesalahan spasi menjadi sangat sensitif dan sering menyebabkan error saat menjalankan command.

Pada awal pengerjaan, saya juga mengalami masalah di mana file yang telah dibuat sering menghilang. Hal tersebut membuat proses pengerjaan cukup terhambat selama beberapa hari karena tugas tidak menunjukkan perkembangan yang berarti. Setelah melakukan pengecekan lebih lanjut, saya menyadari bahwa Ubuntu Server belum terpasang dengan optimal karena saya hanya memberikan alokasi storage sebesar 1GB pada VirtualBox. Masalah tersebut akhirnya teratasi setelah kapasitas storage ditingkatkan dari 1GB menjadi 10GB.

---

## Refleksi

Dari pengalaman mengerjakan tugas praktikum ini, saya menyadari bahwa pengerjaan teknis berbasis terminal membutuhkan ketelitian dan pemahaman dasar yang baik terhadap sistem Linux. Meskipun AI dapat membantu dalam memberikan contoh command maupun script, pemahaman dasar tetap diperlukan agar pengguna dapat mengetahui fungsi command yang dijalankan serta mampu melakukan debugging ketika terjadi error.

Selain itu, praktikum ini juga memberikan pengalaman baru dalam memahami workflow Linux server, proses transfer file, serta penggunaan tools command line untuk data processing.

---

# Dokumentasi

<img width="1920" height="1080" alt="SSH connect to local" src="https://github.com/user-attachments/assets/89ade106-2320-40a1-8510-3a4b379f2c56" />

**SSH Connect from Ubuntu Server to Local**

---

<img width="1920" height="1080" alt="test scp + sha256" src="https://github.com/user-attachments/assets/199b31ac-4171-4962-8a0d-aa65a0f61bdf" />

**SCP Data Transfer from Local to Ubuntu Server**

> Note: Saya lebih sering menggunakan `scp` karena syntax-nya lebih sederhana dibandingkan `rsync`. Selain itu, file dan folder praktikum dibuat di luar Ubuntu Server sehingga proses transfer folder secara langsung menggunakan `scp` terasa lebih praktis.

---

<img width="1920" height="1080" alt="test rsync + sha256" src="https://github.com/user-attachments/assets/8e203c3b-480e-4189-9b94-f62b9e86f187" />

**Rsync Data Transfer from Local to Ubuntu Server**

> Note: Secara teknis, `rsync` lebih unggul untuk project berskala besar karena hanya mentransfer perubahan file yang terjadi tanpa perlu mengirim ulang seluruh folder. Namun, karena kebutuhan tugas ini masih sederhana, saya lebih memilih menggunakan `scp` yang lebih cepat dan mudah digunakan.
