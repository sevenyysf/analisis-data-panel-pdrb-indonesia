# Analisis Regresi Data Panel pada Faktor-Faktor yang Berkaitan dengan PDRB di 10 Provinsi Indonesia Tahun 2021--2024

Repositori ini berisi paper, data, dan kode R untuk analisis **regresi
data panel** pada PDRB ADHK 2010 dengan variabel Pendapatan Asli Daerah
(PAD), Tingkat Partisipasi Angkatan Kerja (TPAK), Rata-Rata Lama
Sekolah, dan persentase panjang jalan kondisi baik di 10 provinsi
Indonesia selama tahun 2021--2024.

📄 **Paper:**
[`paper/Project Data Panel.pdf`](paper/Project%20Data%20Panel.pdf)

------------------------------------------------------------------------

## Ringkasan

Penelitian ini menggunakan data panel dari 10 provinsi selama empat
tahun pengamatan (2021--2024). Analisis dilakukan untuk melihat hubungan
PAD, TPAK, Rata-Rata Lama Sekolah, dan kondisi infrastruktur jalan
dengan PDRB ADHK 2010.

Tahapan analisis yang dilakukan:

1.  eksplorasi data dan statistik deskriptif,
2.  pembentukan data panel dengan `Provinsi` sebagai cross-section dan
    `Tahun` sebagai time series,
3.  estimasi Common Effect Model (CEM), Fixed Effect Model (FEM), dan
    Random Effect Model (REM),
4.  pemilihan model menggunakan uji Chow, Lagrange Multiplier, dan
    Hausman,
5.  pengujian dan interpretasi hasil model.

### Hasil utama

  -----------------------------------------------------------------------
  Tahap                               Hasil
  ----------------------------------- -----------------------------------
  Struktur data                       Balanced panel, 10 provinsi, 4
                                      tahun, 40 observasi

  Uji LM                              p-value = 1,874 × 10⁻⁸; mengarah
                                      pada REM dibanding CEM

  Uji Hausman                         p-value = 0,5452; REM dipilih
                                      dibanding FEM

  Model terpilih                      Random Effect Model (REM)

  PAD                                 Koefisien = 56,172; p-value \<
                                      0,001 (signifikan positif)

  Rata-Rata Lama Sekolah              Koefisien = 175.450; p-value =
                                      0,0077 (signifikan positif)

  TPAK                                p-value = 0,5346 (tidak signifikan)

  Infrastruktur jalan kondisi baik    p-value = 0,1843 (tidak signifikan)
  -----------------------------------------------------------------------

PAD dan Rata-Rata Lama Sekolah memiliki hubungan positif dan signifikan
dengan PDRB ADHK 2010 pada model REM. Sementara itu, TPAK dan persentase
panjang jalan kondisi baik tidak signifikan pada taraf 5%.

------------------------------------------------------------------------

## Struktur Repositori

``` text
.
├── paper/
│   └── Project Data Panel.pdf
├── data/
│   └── Data_Pertumbuhan_Ekonomi.csv
├── R/
│   └── Data Panel Pertumbuhan Ekonomi.R
└── README.md
```

------------------------------------------------------------------------

## Data

Data yang digunakan merupakan data sekunder tahun 2021--2024 pada 10
provinsi di Indonesia, yaitu DKI Jakarta, Jawa Barat, Jawa Tengah, Jawa
Timur, Kalimantan Timur, Bali, Sumatera Utara, Sumatera Barat, Sulawesi
Utara, dan Sulawesi Selatan.

  -----------------------------------------------------------------------
  Variabel                Keterangan              Satuan
  ----------------------- ----------------------- -----------------------
  PDRB ADHK 2010          Produk Domestik         Miliar rupiah
                          Regional Bruto atas     
                          dasar harga konstan     
                          2010                    

  Pendapatan Asli Daerah  Pendapatan Asli Daerah  Miliar rupiah
                          (PAD)                   

  Tingkat Partisipasi     Tingkat Partisipasi     \%
  Angkatan Kerja          Angkatan Kerja (TPAK)   

  Rata-Rata Lama Sekolah  Rata-rata lama sekolah  Tahun
                          penduduk                

  Persentase              Persentase panjang      \%
  Infrastruktur Panjang   jalan dalam kondisi     
  Jalan Kondisi Baik      baik                    
  -----------------------------------------------------------------------

### Sumber data

Data diperoleh dari beberapa sumber berikut:

-   **Badan Pusat Statistik (BPS):** PDRB ADHK 2010, TPAK, dan Rata-Rata
    Lama Sekolah.
-   **Direktorat Jenderal Perimbangan Keuangan (DJPK):** Pendapatan Asli
    Daerah.
-   **Kementerian Pekerjaan Umum (PU):** persentase panjang jalan
    kondisi baik.

Tautan sumber: - [BPS](https://www.bps.go.id/) - [DJPK -- Data
APBD](https://djpk.kemenkeu.go.id/portal/data/apbd) - [Satu Data PU --
Kemantapan Jalan
Provinsi](https://data.pu.go.id/dataset/kemantapan-jalan-provinsi)

------------------------------------------------------------------------

## Cara Menjalankan

### Prasyarat

-   [R](https://cran.r-project.org/)
-   [RStudio](https://posit.co/download/rstudio-desktop/) (opsional)
-   Paket R: `plm`, `dplyr`, dan `ggplot2`, serta paket lain yang
    digunakan pada script.

### Langkah

``` bash
git clone https://github.com/<username>/<nama-repo>.git
cd <nama-repo>
```

Buka file `R/Data Panel Pertumbuhan Ekonomi.R` melalui RStudio, kemudian
jalankan script dari awal sampai akhir. Jika script meminta memilih
file, pilih dataset `data/Data_Pertumbuhan_Ekonomi.csv`.

------------------------------------------------------------------------

## Metode

-   **CEM (Common Effect Model):** mengasumsikan tidak ada perbedaan
    intersep antarprovinsi maupun waktu.
-   **FEM (Fixed Effect Model):** mengakomodasi perbedaan karakteristik
    antarprovinsi melalui efek tetap.
-   **REM (Random Effect Model):** mengakomodasi perbedaan karakteristik
    antarprovinsi melalui efek acak.
-   **Uji Chow:** membandingkan CEM dan FEM.
-   **Uji Hausman:** membandingkan FEM dan REM.
-   **Uji Lagrange Multiplier:** membandingkan CEM dan REM.

Berdasarkan hasil pengujian yang dilaporkan, model yang digunakan adalah
Random Effect Model (REM).

------------------------------------------------------------------------

## Penulis

Siti Khalilah, Pretri Seveny Yasyaf, dan Stefanie Aurelia Clarissa
Harisusanti.

Program Studi S1 Statistika, Fakultas Matematika dan Ilmu Pengetahuan
Alam, Universitas Padjadjaran.

------------------------------------------------------------------------

**Catatan:** Variabel dependen dalam model adalah nilai PDRB ADHK 2010,
bukan laju pertumbuhan PDRB dalam bentuk persentase.
