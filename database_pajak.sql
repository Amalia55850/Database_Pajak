-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 02, 2025 at 08:50 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database_pajak`
--

-- --------------------------------------------------------

--
-- Table structure for table `jenispajak`
--

CREATE TABLE `jenispajak` (
  `Kode_Jenis` varchar(10) NOT NULL,
  `Nama_Pajak` varchar(100) DEFAULT NULL,
  `Tarif_Dasar` decimal(10,2) DEFAULT NULL,
  `Kategori` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kpp`
--

CREATE TABLE `kpp` (
  `Kode_KPP` varchar(10) NOT NULL,
  `Nama_KPP` varchar(100) DEFAULT NULL,
  `Wilayah` varchar(50) DEFAULT NULL,
  `Alamat` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `Id_Pegawai` varchar(10) NOT NULL,
  `Nama` varchar(100) DEFAULT NULL,
  `Jabatan` varchar(50) DEFAULT NULL,
  `Kode_KPP` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `Id_Pembayaran` varchar(15) NOT NULL,
  `Id_SPT` varchar(15) DEFAULT NULL,
  `Id_Pegawai` varchar(10) NOT NULL,
  `Nomor_Bukti` varchar(30) DEFAULT NULL,
  `Tanggal_Bayar` date DEFAULT NULL,
  `Jumlah` decimal(15,2) DEFAULT NULL,
  `Metode` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sanksi`
--

CREATE TABLE `sanksi` (
  `Id_Denda` varchar(15) NOT NULL,
  `Id_SPT` varchar(15) DEFAULT NULL,
  `Jenis_Sanksi` varchar(50) DEFAULT NULL,
  `Nominal` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spt`
--

CREATE TABLE `spt` (
  `Id_SPT` varchar(15) NOT NULL,
  `NPWP` varchar(20) DEFAULT NULL,
  `Kode_Jenis` varchar(10) DEFAULT NULL,
  `Tahun` int(11) DEFAULT NULL,
  `Bulan` int(11) DEFAULT NULL,
  `Nominal` decimal(15,2) DEFAULT NULL,
  `Status` enum('Lengkap','Terlambat') DEFAULT NULL,
  `Jatuh_Tempo` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wajibpajak`
--

CREATE TABLE `wajibpajak` (
  `NPWP` varchar(20) NOT NULL,
  `Nama` varchar(100) NOT NULL,
  `Alamat` text DEFAULT NULL,
  `Jenis_WP` varchar(20) DEFAULT NULL,
  `NIK` varchar(20) DEFAULT NULL,
  `No_Akta` varchar(30) DEFAULT NULL,
  `Tanggal_Daftar` date DEFAULT NULL,
  `Status` enum('Aktif','Nonaktif') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jenispajak`
--
ALTER TABLE `jenispajak`
  ADD PRIMARY KEY (`Kode_Jenis`);

--
-- Indexes for table `kpp`
--
ALTER TABLE `kpp`
  ADD PRIMARY KEY (`Kode_KPP`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`Id_Pegawai`),
  ADD KEY `Kode_KPP` (`Kode_KPP`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`Id_Pembayaran`),
  ADD KEY `Id_SPT` (`Id_SPT`),
  ADD KEY `idx_pegawai` (`Id_Pegawai`);

--
-- Indexes for table `sanksi`
--
ALTER TABLE `sanksi`
  ADD PRIMARY KEY (`Id_Denda`),
  ADD KEY `Id_SPT` (`Id_SPT`);

--
-- Indexes for table `spt`
--
ALTER TABLE `spt`
  ADD PRIMARY KEY (`Id_SPT`),
  ADD KEY `NPWP` (`NPWP`),
  ADD KEY `Kode_Jenis` (`Kode_Jenis`);

--
-- Indexes for table `wajibpajak`
--
ALTER TABLE `wajibpajak`
  ADD PRIMARY KEY (`NPWP`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD CONSTRAINT `pegawai_ibfk_1` FOREIGN KEY (`Kode_KPP`) REFERENCES `kpp` (`Kode_KPP`);

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`Id_SPT`) REFERENCES `spt` (`Id_SPT`),
  ADD CONSTRAINT `pembayaran_ibfk_2` FOREIGN KEY (`Id_Pegawai`) REFERENCES `pegawai` (`Id_Pegawai`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sanksi`
--
ALTER TABLE `sanksi`
  ADD CONSTRAINT `sanksi_ibfk_1` FOREIGN KEY (`Id_SPT`) REFERENCES `spt` (`Id_SPT`);

--
-- Constraints for table `spt`
--
ALTER TABLE `spt`
  ADD CONSTRAINT `spt_ibfk_1` FOREIGN KEY (`NPWP`) REFERENCES `wajibpajak` (`NPWP`),
  ADD CONSTRAINT `spt_ibfk_2` FOREIGN KEY (`Kode_Jenis`) REFERENCES `jenispajak` (`Kode_Jenis`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
