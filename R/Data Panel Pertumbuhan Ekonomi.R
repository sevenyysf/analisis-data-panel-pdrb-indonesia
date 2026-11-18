## Input Data dan Konversi Tipe Data
data = read.csv(file.choose(), sep = ";",dec=",")
data$PDRB.ADHK.2010 <- as.numeric(data$PDRB.ADHK.2010)
data$Dummy.Tahun <- as.numeric(data$Dummy.Tahun)
data$Pendapatan.Asli.Daerah <- as.numeric(data$Pendapatan.Asli.Daerah) 
data$Tingkat.Partisipasi.Angkatan.Kerja <- as.numeric(data$Tingkat.Partisipasi.Angkatan.Kerja)
data$Rata.Rata.Lama.Sekolah <- as.numeric(data$Rata.Rata.Lama.Sekolah)
data$Persentase.Infrastruktur.Panjang.Jalan.Kondisi.Baik <- as.numeric(data$Persentase.Infrastruktur.Panjang.Jalan.Kondisi.Baik)
head(data)

# Statistik Deskriptif
summary(data)

## Varians dan Standar Deviasi
var(data$Tahun)
sd(data$Tahun)
var(data$Dummy.Tahun)
sd(data$Dummy.Tahun)
var(data$PDRB.ADHK.2010)
sd(data$PDRB.ADHK.2010)
var(data$Pendapatan.Asli.Daerah)
sd(data$Pendapatan.Asli.Daerah)
var(data$Tingkat.Partisipasi.Angkatan.Kerja)
sd(data$Tingkat.Partisipasi.Angkatan.Kerja)
var(data$Rata.Rata.Lama.Sekolah)
sd(data$Rata.Rata.Lama.Sekolah)
var(data$Persentase.Infrastruktur.Panjang.Jalan.Kondisi.Baik)
sd(data$Persentase.Infrastruktur.Panjang.Jalan.Kondisi.Baik)

# Cek Missing Value
colSums(is.na(data))

# Korelasi Antar-Variabel
num_data <- data[, c("PDRB.ADHK.2010","Tingkat.Partisipasi.Angkatan.Kerja","Persentase.Infrastruktur.Panjang.Jalan.Kondisi.Baik","Pendapatan.Asli.Daerah","Rata.Rata.Lama.Sekolah","Dummy.Tahun")]
cor(num_data, use = "complete.obs")

# Plot Trend Setiap Provinsi
library(ggplot2)
## Tren PDRB
ggplot(data, aes(x = Tahun, y = PDRB.ADHK.2010, group = Provinsi, color = Provinsi)) +
geom_line(size=1) +
theme_bw() +
labs(title = "Tren PDRB per Provinsi", y = "PDRB (%)")

## Tren Persentasei Infrastruktur Panjang Jalan Kondisi Baik
ggplot(data, aes(x = Tahun, y = Persentase.Infrastruktur.Panjang.Jalan.Kondisi.Baik, group = Provinsi, color = Provinsi)) +
geom_line(size=1) +
theme_bw() +
labs(title = "Tren Persentasei Infrastruktur Panjang Jalan Kondisi Baik ", y = "Jumlah Persentase")

## Tren Angkatan Kerja
ggplot(data, aes(x = Tahun, y = Tingkat.Partisipasi.Angkatan.Kerja, group = Provinsi, color = Provinsi)) +
geom_line(size=1) +
theme_bw() +
labs(title = "Tren Tingkat Partisipasi Angkatan Kerja", y = "Jumlah Partisipasi Angkatan Kerja")

## Tren Pendapatan Asli Daerah
ggplot(data, aes(x = Tahun, y = Pendapatan.Asli.Daerah, group = Provinsi, color = Provinsi)) +
geom_line(size=1) +
theme_bw() +
labs(title = "Tren Pendapatan Asli Daerah", y = "PAD")

## Tren Lama Sekolah
ggplot(data, aes(x = Tahun, y = Rata.Rata.Lama.Sekolah , group = Provinsi, color = Provinsi)) +
geom_line(size=1) +
theme_bw() +
labs(title = "Tren Nilai Rata Rata Lama Sekolah", y = "Rata-Rata Lama Sekolah")

##-- Data tidak perlu diubah karna data sudah berupa data long dengan Provinsi sebagai (ID/Cross-section) dan Tahun sebagai (Waktu/Time-series) --##
# Mendeklarasikan index data = data panel 
library(dplyr)
df <- data %>%
  rename(
   PDRB =  PDRB.ADHK.2010,
   AngkatanKerja = Tingkat.Partisipasi.Angkatan.Kerja ,
   IFST = Persentase.Infrastruktur.Panjang.Jalan.Kondisi.Baik ,
   PAD = Pendapatan.Asli.Daerah,
   LamaSekolah = Rata.Rata.Lama.Sekolah
 )

# Data Akhir
library(plm)
data_panel <- pdata.frame(df, index = c("Provinsi", "Tahun"))
head(index(data_panel))
head(data_panel)

##---Fixed Effect Model (FEM)
# Fixed Effect Individual (Provinsi)
fem_ind <- plm(
  PDRB ~ AngkatanKerja + IFST + PAD + LamaSekolah,
  index = c("Provinsi", "Tahun"),
  model = "within",
  effect = "individual",
  data = data_panel
)

# LSDV tanpa referensi (tanpa intersep)
fem_lsdv_tanpa_referensi <- plm(
  PDRB ~ AngkatanKerja + IFST + PAD + LamaSekolah - 1,
  index = c("Provinsi", "Tahun"),
  data = data_panel
)

# Menampilkan koefisien
fem_ind$coefficients
fem_lsdv_tanpa_referensi$coefficients[1:4]

# Gunakan Model Within
summary(fem_ind)

# Menampilkan nilai intersep (fixed effect) tiap provinsi
summary(fixef(fem_ind, effect = "individual"))

## -- FEM Time (Efek Tetap Waktu)
fem_time <- plm(
  PDRB ~ AngkatanKerja + IFST + PAD + LamaSekolah,
  index = c("Provinsi", "Tahun"),
  model = "within",
  effect = "time",
  data = data_panel
)

# Ringkasan output model
summary(fem_time)

# Melihat niali FEM tiap tahun
summary(fixef(fem_time, effect = "time"))

## -- FEM Two Ways (Individual + Time)
fem_2ways <- plm(
  PDRB ~ AngkatanKerja + IFST + PAD + LamaSekolah,
  index = c("Provinsi", "Tahun"),
  model = "within",
  effect = "twoways",
  data = data_panel
)

# Ringkasan output model
summary(fem_2ways)

# Melihat Intercept Efek Provinsi dan Efek Tahun dari Model Two-Ways
summary(fixef(fem_2ways, effect = "individual"))
summary(fixef(fem_2ways, effect = "time"))

## --- Random Effect Model (REM)
# REM Individual
rem_ind <- plm(
  PDRB ~ AngkatanKerja + IFST + PAD + LamaSekolah,
  index = c("Provinsi", "Tahun"),
  effect = "individual",
  model = "random",
  data = data_panel
)
summary(rem_ind)

## -- Common Effect Model (CEM)
library(plm)
cem <- plm(
  PDRB ~ AngkatanKerja + IFST + PAD + LamaSekolah,
  index = c("Provinsi", "Tahun"),
  data = data_panel,
  model = "pooling"
)
summary(cem)

# ----------------------------
# UJI PEMILIHAN MODEL TERBAIK
# ----------------------------

# Hausman Test (REM vs FEM)
phtest(fem_ind, rem_ind)

# Uji Lagrange Multiplier (CEM vs REM)
# H0: CEM adalah model yang tepat (Gunakan FEM), H1: REM adalah model yang tepat
# Efek individu dan waktu
plmtest(rem_ind,type = "bp", effect="individual")

summary(rem_ind)

##--Uji Permasalahan Data

# Uji Multikolinearitas
library(car)
vif(rem_ind)
vif(rem_ind) > 5 # Jika TRUE, maka terdapat multikolinearitas kuat

# Uji Outlier (Dilihat dari Boxplot dan Histogram)
res <- residuals(rem_ind)
boxplot(res, main = "Boxplot of Residuals")
ggplot(as.data.frame(res), aes(x = res)) +
  geom_histogram(aes(y = after_stat(density)), color = "yellow", fill =
                   "aquamarine") +
  geom_density(color= "red", linewidth = 1) + theme_minimal()


# UJI LEVERAGE UNTUK MODEL REM
# Matriks desain (X)
X <- model.matrix(rem_ind)

# Matriks hat
hat_matrix <- X %*% solve(t(X) %*% X) %*% t(X)

# Leverage adalah diagonal dari matriks hat
leverage_values <- diag(hat_matrix)

# Batas leverage
leverage_limit <- 2 * (length(coef(rem_ind)) / nrow(data))

# Observasi dengan leverage tinggi
which(leverage_values > leverage_limit)

library(ggplot2)

# Fitted values dari model REM
fitted_values <- fitted(rem_ind)

# Data frame untuk plot
data_plot <- data.frame(
  fitted = fitted_values,
  leverage = leverage_values,
  obs = 1:length(fitted_values)
)

# Hitung limit leverage
n <- nrow(data_plot)
p <- length(rem_ind$coefficients)
leverage_limit <- 2 * p / n

# Kolom highlight
data_plot$highlight <- ifelse(data_plot$leverage > leverage_limit, "High", "Low")
data_plot$highlight <- factor(data_plot$highlight, levels = c("Low", "High"))

# Plot
ggplot(data_plot, aes(x = fitted, y = leverage, color = highlight)) +
  geom_point() +
  geom_hline(yintercept = leverage_limit, color = "skyblue", linetype = "dashed") +
  geom_text(aes(label = ifelse(highlight == "High", as.character(obs), "")),
            vjust = -0.5, color = "purple") +
  labs(x = "Fitted Values",
       y = "Leverage",
       title = "Leverage vs. Fitted Values (Model REM)") +
  scale_color_manual(values = c("Low" = "maroon", "High" = "pink")) +
  theme_minimal()

# === COOK'S DISTANCE UNTUK MODEL REM ===

# Residual model REM
res <- residuals(rem_ind)

# Fitted model untuk mendapatkan X
X <- model.matrix(rem_ind)

# Leverage (hat values)
H <- X %*% solve(t(X) %*% X) %*% t(X)
h <- diag(H)

# Mean squared error (MSE)
mse <- sum(res^2) / (nrow(X) - length(coef(rem_ind)))

# Cook's Distance formula:
# D_i = (r_i^2 / p * MSE) * (h_i / (1 - h_i)^2)
p <- length(coef(rem_ind))
cooks_d <- (res^2 / (p * mse)) * (h / (1 - h)^2)
 
# Tampilkan observasi Cook's Distance tinggi
which(cooks_d > (4 / length(cooks_d)))

# Jika ingin lihat nilai Cook's Distance
cooks_d

## Hasil cook's distance tidak mendekati 1 
## Leverage tinggi muncul di 3 provinsi besar yang merupakan karakteristik fenomena ekonomi nyata 

## UJI ASUMSI KLASIK

# --- Uji Linearitas Model REM ---
library(plm)
library(lmtest)

# =============================
# 1. Model REM awal
# =============================
rem_ind <- plm(
  PDRB ~ AngkatanKerja + IFST + PAD + LamaSekolah,
  data = data_panel,
  model = "random",
  effect = "individual"
)
# =============================
# 2. Ambil fitted value dari REM
# =============================
fit <- as.numeric(fitted(rem_ind))

# Tambahkan ke data frame
data_panel$fit2 <- fit^2
data_panel$fit3 <- fit^3
# =============================
# 3. Buat model extended (dengan fit^2 dan fit^3)
# =============================
rem_ext <- plm(
  PDRB ~ AngkatanKerja + IFST + PAD + LamaSekolah + fit2 + fit3,
  data = data_panel,
  model = "random",
  effect = "individual"
)

# 4. Uji F (RESET test manual)
reset_test <- waldtest(rem_ind, rem_ext)
reset_test

## --- UJI AUTOKORELASI ---
library(plm)
pbgtest(rem_ind)

## --- Uji Homoskedastisitas ---
plmtest(rem_ind, type = "bp")
# karna tidak memenuhi asumsi maka gunakan robust SE
coeftest(rem_ind, vcov = vcovHC(rem_ind, type = "HC1"))

## Uji Signifikansi Parameter
# Simultan dan Parsial
coeftest(rem_ind, vcov = vcovHC(rem_ind, type = "HC1"))
library(car)
linearHypothesis(rem_ind,
                 c("AngkatanKerja = 0",
                   "IFST = 0",
                   "PAD = 0",
                   "LamaSekolah = 0"),
                 vcov = vcovHC(rem_ind, type = "HC1"))




