-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 06 Jun 2023 pada 12.52
-- Versi server: 10.4.27-MariaDB
-- Versi PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `trusmi_group`
--

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `grafik_kpi`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `grafik_kpi` (
`id` int(11)
,`nama_karyawan` varchar(255)
,`sales_target` int(11)
,`sales_actual` bigint(21)
,`sales_pencapaian` decimal(30,0)
,`sales_actual_bobot` decimal(34,4)
,`report_target` int(11)
,`report_actual` bigint(21)
,`report_pencapaian` decimal(30,0)
,`report_actual_bobot` decimal(34,4)
,`kpi` decimal(35,4)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `persentase_total_kpi`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `persentase_total_kpi` (
`ontime` bigint(21)
,`late` bigint(21)
,`persentase_ontime` decimal(27,4)
,`persentase_late` decimal(27,4)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `table_karyawan`
--

CREATE TABLE `table_karyawan` (
  `id_karyawan` int(11) NOT NULL,
  `nama_karyawan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `table_karyawan`
--

INSERT INTO `table_karyawan` (`id_karyawan`, `nama_karyawan`) VALUES
(1, 'Budi'),
(2, 'Adi'),
(3, 'Rara'),
(4, 'Doni');

-- --------------------------------------------------------

--
-- Struktur dari tabel `table_kpi_marketing`
--

CREATE TABLE `table_kpi_marketing` (
  `id` int(11) NOT NULL,
  `tasklist` varchar(255) NOT NULL,
  `kpi` int(11) NOT NULL,
  `karyawan` int(11) NOT NULL,
  `deadline` date NOT NULL,
  `aktual` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `table_kpi_marketing`
--

INSERT INTO `table_kpi_marketing` (`id`, `tasklist`, `kpi`, `karyawan`, `deadline`, `aktual`) VALUES
(1, 'Tasklist 1', 1, 1, '2022-01-10', '2022-01-09'),
(2, 'Tasklist 2', 1, 1, '2022-01-10', '2022-01-08'),
(3, 'Tasklist 3', 2, 1, '2022-01-10', '2022-01-07'),
(4, 'Tasklist 4', 2, 1, '2022-01-10', '2022-01-12'),
(5, 'Tasklist 5', 1, 2, '2022-01-10', '2022-01-09'),
(6, 'Tasklist 6', 1, 2, '2022-01-10', '2022-01-12'),
(7, 'Tasklist 7', 2, 2, '2022-01-10', '2022-01-07'),
(8, 'Tasklist 8', 2, 2, '2022-01-10', '2022-01-07'),
(9, 'Tasklist 9', 1, 3, '2022-01-10', '2022-01-12'),
(10, 'Tasklist 10', 1, 3, '2022-01-10', '2022-01-09'),
(11, 'Tasklist 11', 2, 3, '2022-01-10', '2022-01-12'),
(12, 'Tasklist 12', 2, 4, '2022-01-10', '2022-01-09'),
(13, 'Tasklist 13', 1, 4, '2022-01-10', '2022-01-12');

-- --------------------------------------------------------

--
-- Struktur dari tabel `table_tipe_kpi`
--

CREATE TABLE `table_tipe_kpi` (
  `id_tipe` int(11) NOT NULL,
  `nama_tipe` varchar(100) NOT NULL,
  `target_kpi` int(11) NOT NULL,
  `bobot_kpi` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `table_tipe_kpi`
--

INSERT INTO `table_tipe_kpi` (`id_tipe`, `nama_tipe`, `target_kpi`, `bobot_kpi`) VALUES
(1, 'Sales', 2, '50'),
(2, 'Report', 2, '50');

-- --------------------------------------------------------

--
-- Struktur untuk view `grafik_kpi`
--
DROP TABLE IF EXISTS `grafik_kpi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `grafik_kpi`  AS SELECT `table_kpi_marketing`.`id` AS `id`, `table_karyawan`.`nama_karyawan` AS `nama_karyawan`, (select `table_tipe_kpi`.`target_kpi` from `table_tipe_kpi` where `table_tipe_kpi`.`id_tipe` = 1) AS `sales_target`, (select count(0) from `table_kpi_marketing` where `table_kpi_marketing`.`kpi` = 1 and `table_kpi_marketing`.`karyawan` = `table_karyawan`.`id_karyawan`) AS `sales_actual`, (select count(0) from `table_kpi_marketing` where `table_kpi_marketing`.`kpi` = 1 and `table_kpi_marketing`.`karyawan` = `table_karyawan`.`id_karyawan`) * (select `table_tipe_kpi`.`bobot_kpi` from `table_tipe_kpi` where `table_tipe_kpi`.`id_tipe` = 1) AS `sales_pencapaian`, (select count(0) from `table_kpi_marketing` where `table_kpi_marketing`.`kpi` = 1 and `table_kpi_marketing`.`karyawan` = `table_karyawan`.`id_karyawan`) * (select `table_tipe_kpi`.`bobot_kpi` from `table_tipe_kpi` where `table_tipe_kpi`.`id_tipe` = 1) / (select `table_tipe_kpi`.`target_kpi` from `table_tipe_kpi` where `table_tipe_kpi`.`id_tipe` = 1) AS `sales_actual_bobot`, (select `table_tipe_kpi`.`target_kpi` from `table_tipe_kpi` where `table_tipe_kpi`.`id_tipe` = 2) AS `report_target`, (select count(0) from `table_kpi_marketing` where `table_kpi_marketing`.`kpi` = 2 and `table_kpi_marketing`.`karyawan` = `table_karyawan`.`id_karyawan`) AS `report_actual`, (select count(0) from `table_kpi_marketing` where `table_kpi_marketing`.`kpi` = 2 and `table_kpi_marketing`.`karyawan` = `table_karyawan`.`id_karyawan`) * (select `table_tipe_kpi`.`bobot_kpi` from `table_tipe_kpi` where `table_tipe_kpi`.`id_tipe` = 2) AS `report_pencapaian`, (select count(0) from `table_kpi_marketing` where `table_kpi_marketing`.`kpi` = 2 and `table_kpi_marketing`.`karyawan` = `table_karyawan`.`id_karyawan`) * (select `table_tipe_kpi`.`bobot_kpi` from `table_tipe_kpi` where `table_tipe_kpi`.`id_tipe` = 2) / (select `table_tipe_kpi`.`target_kpi` from `table_tipe_kpi` where `table_tipe_kpi`.`id_tipe` = 2) AS `report_actual_bobot`, (select count(0) from `table_kpi_marketing` where `table_kpi_marketing`.`kpi` = 2 and `table_kpi_marketing`.`karyawan` = `table_karyawan`.`id_karyawan`) * (select `table_tipe_kpi`.`bobot_kpi` from `table_tipe_kpi` where `table_tipe_kpi`.`id_tipe` = 2) / (select `table_tipe_kpi`.`target_kpi` from `table_tipe_kpi` where `table_tipe_kpi`.`id_tipe` = 2) + (select count(0) from `table_kpi_marketing` where `table_kpi_marketing`.`kpi` = 1 and `table_kpi_marketing`.`karyawan` = `table_karyawan`.`id_karyawan`) * (select `table_tipe_kpi`.`bobot_kpi` from `table_tipe_kpi` where `table_tipe_kpi`.`id_tipe` = 1) / (select `table_tipe_kpi`.`target_kpi` from `table_tipe_kpi` where `table_tipe_kpi`.`id_tipe` = 1) AS `kpi` FROM ((`table_kpi_marketing` join `table_karyawan` on(`table_karyawan`.`id_karyawan` = `table_kpi_marketing`.`karyawan`)) join `table_tipe_kpi` on(`table_tipe_kpi`.`id_tipe` = `table_kpi_marketing`.`kpi`)) GROUP BY `table_karyawan`.`nama_karyawan` ORDER BY `table_kpi_marketing`.`id` ASC  ;

-- --------------------------------------------------------

--
-- Struktur untuk view `persentase_total_kpi`
--
DROP TABLE IF EXISTS `persentase_total_kpi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `persentase_total_kpi`  AS SELECT (select count(`table_kpi_marketing`.`aktual`) from `table_kpi_marketing` where `table_kpi_marketing`.`aktual` <= `table_kpi_marketing`.`deadline`) AS `ontime`, (select count(`table_kpi_marketing`.`aktual`) from `table_kpi_marketing` where `table_kpi_marketing`.`aktual` > `table_kpi_marketing`.`deadline`) AS `late`, (select count(`table_kpi_marketing`.`aktual`) from `table_kpi_marketing` where `table_kpi_marketing`.`aktual` <= `table_kpi_marketing`.`deadline`) / (select count(0) from `table_kpi_marketing`) * 100 AS `persentase_ontime`, (select count(`table_kpi_marketing`.`aktual`) from `table_kpi_marketing` where `table_kpi_marketing`.`aktual` > `table_kpi_marketing`.`deadline`) / (select count(0) from `table_kpi_marketing`) * 100 AS `persentase_late` FROM `table_kpi_marketing` LIMIT 0, 11  ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `table_karyawan`
--
ALTER TABLE `table_karyawan`
  ADD PRIMARY KEY (`id_karyawan`);

--
-- Indeks untuk tabel `table_kpi_marketing`
--
ALTER TABLE `table_kpi_marketing`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kpi` (`kpi`),
  ADD KEY `karyawan` (`karyawan`);

--
-- Indeks untuk tabel `table_tipe_kpi`
--
ALTER TABLE `table_tipe_kpi`
  ADD PRIMARY KEY (`id_tipe`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `table_karyawan`
--
ALTER TABLE `table_karyawan`
  MODIFY `id_karyawan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `table_kpi_marketing`
--
ALTER TABLE `table_kpi_marketing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `table_tipe_kpi`
--
ALTER TABLE `table_tipe_kpi`
  MODIFY `id_tipe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `table_kpi_marketing`
--
ALTER TABLE `table_kpi_marketing`
  ADD CONSTRAINT `table_kpi_marketing_ibfk_1` FOREIGN KEY (`karyawan`) REFERENCES `table_karyawan` (`id_karyawan`),
  ADD CONSTRAINT `table_kpi_marketing_ibfk_2` FOREIGN KEY (`kpi`) REFERENCES `table_tipe_kpi` (`id_tipe`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
