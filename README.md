# Analisis Data Panel: Faktor-Faktor yang Berkaitan dengan PDRB Provinsi di Indonesia

Repository ini berisi dokumentasi, dataset, dan kode analisis untuk
proyek akhir mata kuliah **Ekonometrika**. Penelitian menggunakan
regresi data panel untuk menganalisis hubungan Pendapatan Asli Daerah
(PAD), Tingkat Partisipasi Angkatan Kerja (TPAK), Rata-Rata Lama Sekolah
(RLS), dan kualitas infrastruktur jalan dengan PDRB ADHK 2010 pada
sejumlah provinsi di Indonesia selama periode 2021--2024.

## Gambaran Umum

Pertumbuhan dan aktivitas ekonomi antarprovinsi dapat berbeda karena
kapasitas fiskal daerah, kondisi ketenagakerjaan, kualitas sumber daya
manusia, serta infrastruktur. Proyek ini mengkaji faktor-faktor tersebut
menggunakan data panel, yaitu gabungan data cross-section dan time
series.

**Cakupan data:** - Unit cross-section: 10 provinsi di Indonesia. -
Periode pengamatan: 2021--2024. - Jumlah observasi: 40 (panel
seimbang). - Variabel dependen: PDRB Atas Dasar Harga Konstan (ADHK)
2010. - Variabel independen: PAD, TPAK, RLS, dan persentase panjang
jalan dalam kondisi baik.

> **Catatan interpretasi:** variabel dependen yang digunakan dalam
> dataset dan model adalah nilai PDRB ADHK 2010, bukan laju pertumbuhan
> PDRB dalam bentuk persentase. Oleh karena itu, hasil estimasi dalam
> repository ini diinterpretasikan sebagai hubungan variabel penjelas
> dengan tingkat/nilai PDRB ADHK 2010.

## Tujuan Penelitian

1.  Menganalisis hubungan Pendapatan Asli Daerah (PAD) dengan PDRB ADHK
    2010.
2.  Menganalisis hubungan Tingkat Partisipasi Angkatan Kerja (TPAK)
    dengan PDRB ADHK 2010.
3.  Menganalisis hubungan Rata-Rata Lama Sekolah (RLS) dengan PDRB ADHK
    2010.
4.  Menganalisis hubungan persentase panjang jalan dalam kondisi baik
    dengan PDRB ADHK 2010.
5.  Membandingkan pendekatan Common Effect Model (CEM), Fixed Effect
    Model (FEM), dan Random Effect Model (REM) untuk menentukan model
    data panel yang digunakan.

## Variabel Penelitian

  -----------------------------------------------------------------------
  Peran                   Variabel                Keterangan
  ----------------------- ----------------------- -----------------------
  Identitas               Provinsi                Unit cross-section

  Waktu                   Tahun                   Periode 2021--2024

  Dependen (Y)            PDRB ADHK 2010          Produk Domestik
                                                  Regional Bruto atas
                                                  dasar harga konstan
                                                  2010

  Independen (X1)         PAD                     Pendapatan Asli Daerah

  Independen (X2)         TPAK                    Tingkat Partisipasi
                                                  Angkatan Kerja

  Independen (X3)         RLS                     Rata-Rata Lama Sekolah

  Independen (X4)         Infrastruktur jalan     Persentase panjang
                                                  jalan dalam kondisi
                                                  baik

  Variabel tambahan       Dummy Tahun             Variabel dummy tahun
                                                  yang tersedia di
                                                  dataset; penggunaannya
                                                  perlu mengikuti
                                                  spesifikasi model pada
                                                  script
  -----------------------------------------------------------------------

## Metode Analisis

Analisis dilakukan menggunakan bahasa pemrograman **R**, dengan tahapan
umum sebagai berikut:

1.  Memuat dataset dan memeriksa tipe data.
2.  Melakukan eksplorasi dan statistik deskriptif.
3.  Menyusun data panel dengan `Provinsi` sebagai unit cross-section dan
    `Tahun` sebagai indeks waktu.
4.  Mengestimasi tiga model regresi data panel:
    -   **Common Effect Model (CEM)**
    -   **Fixed Effect Model (FEM)**
    -   **Random Effect Model (REM)**
5.  Melakukan pengujian pemilihan model, meliputi uji Chow, uji Lagrange
    Multiplier (LM), dan uji Hausman sesuai ketersediaan implementasi
    pada script.
6.  Melakukan pemeriksaan diagnostik model dan menginterpretasikan hasil
    estimasi.

Berdasarkan hasil yang dilaporkan dalam naskah proyek, model yang
dipilih adalah **Random Effect Model (REM)**. Pada hasil estimasi REM
yang disajikan, PAD dan RLS memiliki koefisien positif dan signifikan
pada taraf 5%, sedangkan TPAK dan persentase infrastruktur jalan tidak
signifikan pada taraf tersebut. Interpretasi ini mengikuti hasil pada
laporan dan bukan klaim hubungan sebab-akibat.

## Struktur Repository

``` text
Data-Panel-Pertumbuhan-Ekonomi/
├── paper/
│   └── Project Data Panel.pdf
├── data/
│   └── Data_Pertumbuhan_Ekonomi.csv
├── R/
│   └── Data Panel Pertumbuhan Ekonomi.R
└── README.md
```

**Keterangan folder:** - `paper/` --- laporan/naskah proyek akhir
Ekonometrika dalam format PDF. - `data/` --- dataset yang digunakan
dalam analisis. - `R/` --- script R untuk pengolahan data, estimasi
model, dan analisis.

## Sumber Data

Dataset merupakan data sekunder yang dihimpun dari beberapa sumber
berikut sebagaimana dicantumkan dalam laporan proyek:

-   **Badan Pusat Statistik (BPS)** --- PDRB ADHK 2010, TPAK, dan
    Rata-Rata Lama Sekolah.
-   **Direktorat Jenderal Perimbangan Keuangan (DJPK), Kementerian
    Keuangan** --- Pendapatan Asli Daerah.
-   **Kementerian Pekerjaan Umum (PU)** --- persentase/kemantapan jalan
    provinsi.

Tautan sumber yang dicantumkan dalam laporan: - PDRB:
https://www.bps.go.id/ - TPAK: https://www.bps.go.id/ - Rata-Rata Lama
Sekolah: https://www.bps.go.id/ - PAD:
https://djpk.kemenkeu.go.id/portal/data/apbd - Infrastruktur jalan:
https://data.pu.go.id/dataset/kemantapan-jalan-provinsi

## Tools dan Packages

-   R
-   `plm` --- estimasi regresi data panel.
-   `dplyr` --- pengelolaan dan transformasi data.
-   `ggplot2` --- visualisasi data.

Package tambahan dapat digunakan sesuai kebutuhan yang tercantum di
dalam script R.

## Cara Menjalankan

1.  Clone atau unduh repository ini.
2.  Buka project/folder repository melalui RStudio.
3.  Pastikan R dan package yang diperlukan telah terpasang.
4.  Buka file `R/Data Panel Pertumbuhan Ekonomi.R`.
5.  Jalankan script sesuai urutan analisis.
6.  Ketika diminta memilih file, arahkan ke
    `data/Data_Pertumbuhan_Ekonomi.csv`.

Contoh instalasi package utama:

``` r
install.packages(c("plm", "dplyr", "ggplot2"))
```

## Tim Penyusun

Proyek akhir mata kuliah Ekonometrika --- Program Studi S1 Statistika,
Fakultas Matematika dan Ilmu Pengetahuan Alam, Universitas Padjadjaran.

-   Siti Khalilah --- 140610240062
-   Pretri Seveny Yasyaf --- 140610240080
-   Stefanie Aurelia Clarissa Harisusanti --- 140610240096

## Catatan

README ini disusun berdasarkan struktur folder yang ditunjukkan dan isi
laporan proyek. Pastikan nama file di repository sama dengan nama yang
dituliskan pada bagian **Struktur Repository** dan **Cara Menjalankan**.
Jika nama file berbeda, sesuaikan path-nya.

Hasil analisis juga perlu dibaca dengan memperhatikan cakupan data yang
terdiri dari 10 provinsi dan 4 periode waktu, sehingga generalisasi
hasil ke seluruh provinsi atau periode lain perlu dilakukan secara
hati-hati.
