# Database_Pajak
Tax SQL Database

# Deskripsi
Database ini dibuat sebagai tugas UAS dengan topik sistem pelaporan dan pembayaran pajak. Sistem ini dirancang untuk mencatat data wajib pajak, jenis pajak, pelaporan pajak (SPT), pembayaran pajak, sanksi/denda, pegawai KPP, dan informasi kantor pelayanan pajak. Struktur dan relasi dirancang agar mencerminkan proses yang umum terjadi dalam sistem perpajakan.

# Penjelasan Tabel
## 1. Tabel 'wajibpajak'
- 'NPWP' (varchar) – Primary key
- 'Nama' (varchar) – Nama wajib pajak
- 'Alamat' (text) – Alamat lengkap
- 'Jenis_WP' (varchar) – Jenis wajib pajak (Pribadi / Badan Usaha)
- 'NIK' (varchar) – Nomor induk kependudukan (jika pribadi)
- 'No_Akta' (varchar) – Nomor akta pendirian (jika badan usaha)
- 'Tanggal_Daftar' (date) – Tanggal terdaftar
- 'Status' (enum) – Aktif / Nonaktif

## 2. Tabel 'jenispajak'
- 'Kode_Jenis' (varchar) – Primary key
- 'Nama_Pajak' (varchar) – Nama jenis pajak (misal: PPN, PPh)
- 'Tarif_Dasar' (decimal) – Tarif pajak dasar (%)
- 'Kategori' (varchar) – Kategori pajak

## 3. Tabel 'spt'
- 'Id_SPT' (varchar) – Primary key
- 'NPWP' (varchar) – Foreign key ke 'wajibpajak'
- 'Kode_Jenis' (varchar) – Foreign key ke 'jenispajak'
- 'Tahun' (int) – Tahun pelaporan
- 'Bulan' (int) – Bulan pelaporan
- 'Nominal' (decimal) – Jumlah nominal pajak
- 'Status' (enum) – Lengkap / Terlambat
- 'Jatuh_Tempo' (date) – Batas waktu pelaporan

### 4. Tabel 'sanksi'
- 'Id_Denda' (varchar) – Primary key
- 'Id_SPT' (varchar) – Foreign key ke 'spt'
- 'Jenis_Sanksi' (varchar) – Jenis pelanggaran
- 'Nominal' (decimal) – Jumlah denda

## 5. Tabel 'pembayaran'
- 'Id_Pembayaran' (varchar) – Primary key
- 'Id_SPT' (varchar) – Foreign key ke 'spt'
- 'Id_Pegawai' (varchar) – Foreign key ke 'pegawai'
- 'Nomor_Bukti' (varchar) – Nomor bukti transaksi
- 'Tanggal_Bayar' (date) – Tanggal pembayaran
- 'Jumlah' (decimal) – Nominal pembayaran
- 'Metode' (varchar) – Metode pembayaran (Tunai, Transfer, dll)

## 6. Tabel 'pegawai'
- 'Id_Pegawai' (varchar) – Primary key
- 'Nama' (varchar) – Nama pegawai
- 'Jabatan' (varchar) – Jabatan pegawai (Kasir / Admin / Lainnya)
- 'Kode_KPP' (varchar) – Foreign key ke 'kpp'

## 7. Tabel 'kpp'
- 'Kode_KPP' (varchar) – Primary key
- 'Nama_KPP' (varchar) – Nama kantor pelayanan pajak
- 'Wilayah' (varchar) – Wilayah cakupan KPP
- 'Alamat' (text) – Lokasi alamat lengkap

# Relasi dan Kardinalitas
1. **WajibPajak – SPT (One-to-Many / 1:N)**  
**Relasi:** Melaporkan  
Satu wajib pajak dapat melaporkan banyak SPT, tetapi satu SPT hanya dimiliki oleh satu wajib pajak.

2. **JenisPajak – SPT (One-to-Many / 1:N)**  
**Relasi:** Dikategorikan Sebagai  
Satu jenis pajak dapat digunakan pada banyak SPT, tetapi satu SPT hanya terkait dengan satu jenis pajak.

3. **SPT – Pembayaran (One-to-Many / 1:N)**  
**Relasi:** Dibayar Oleh  
Satu SPT dapat memiliki beberapa pembayaran (misalnya cicilan), tetapi satu pembayaran hanya terkait dengan satu SPT.

4. **SPT – Sanksi (One-to-Many / 1:N)**  
**Relasi:** Dikenai  
Satu SPT bisa dikenai lebih dari satu sanksi, tetapi satu sanksi hanya berlaku untuk satu SPT.

5. **KPP – Pegawai (One-to-Many / 1:N)**  
**Relasi:** Memiliki  
Satu kantor pelayanan pajak memiliki banyak pegawai, tetapi satu pegawai hanya bekerja di satu KPP.

6. **Pegawai – Pembayaran (One-to-Many / 1:N)**  
**Relasi:** Memproses  
Satu pegawai (kasir) dapat memproses banyak pembayaran, tetapi satu pembayaran hanya diproses oleh satu pegawai.

# Cara Import Database
## Menggunakan phpMyAdmin
1. Buka [http://localhost/phpmyadmin](http://localhost/phpmyadmin)
2. Klik menu **"New"**, lalu buat database baru (misal: 'database_pajak')
3. Klik database tersebut → tab **"Import"**
4. Pilih file 'database_pajak.sql'
5. Klik **Go**
6. Tunggu hingga muncul pesan sukses

## Alternatif (Command Line)
'''bash
mysql -u root -p database_pajak < database_pajak.sql
