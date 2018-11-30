-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 05, 2018 at 01:14 PM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gracevet-db2`
--

-- --------------------------------------------------------

--
-- Table structure for table `hasil_lab`
--

CREATE TABLE `hasil_lab` (
  `id` int(11) NOT NULL,
  `id_tipe_hasil_lab` int(11) NOT NULL,
  `id_rekam_medik` int(11) NOT NULL,
  `struktur` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hasil_lab`
--

INSERT INTO `hasil_lab` (`id`, `id_tipe_hasil_lab`, `id_rekam_medik`, `struktur`) VALUES
(6, 2, 11, '[{\"nama\":\"A\",\"type\":\"text\",\"value\":\"asasas\"},{\"nama\":\"B\",\"type\":\"number\",\"value\":\"2.3\"}]'),
(7, 3, 11, '[{\"nama\":\"A\",\"type\":\"text\",\"value\":\"BBBCCC\"},{\"nama\":\"B\",\"type\":\"number\",\"value\":\"10.2\"}]'),
(8, 2, 12, '[{\"nama\":\"A\",\"type\":\"text\",\"value\":\"asasas\"},{\"nama\":\"B\",\"type\":\"number\",\"value\":\"2.3\"}]'),
(9, 3, 12, '[{\"nama\":\"A\",\"type\":\"text\",\"value\":\"BBBCCC\"},{\"nama\":\"B\",\"type\":\"number\",\"value\":\"10.2\"}]'),
(10, 2, 12, ''),
(11, 3, 12, ''),
(12, 2, 13, '[{\"nama\":\"A\",\"type\":\"text\",\"value\":\"asasas\"},{\"nama\":\"B\",\"type\":\"number\",\"value\":\"2.3\"}]'),
(13, 3, 13, '[{\"nama\":\"A\",\"type\":\"text\",\"value\":\"BBBCCC\"},{\"nama\":\"B\",\"type\":\"number\",\"value\":\"10.2\"}]'),
(14, 2, 13, 'Stopping the time'),
(15, 3, 13, 'Build the dream'),
(16, 2, 14, '[{\"nama\":\"A\",\"type\":\"text\",\"value\":\"asasas\"},{\"nama\":\"B\",\"type\":\"number\",\"value\":\"2.3\"}]'),
(17, 3, 14, '[{\"nama\":\"A\",\"type\":\"text\",\"value\":\"BBBCCC\"},{\"nama\":\"B\",\"type\":\"number\",\"value\":\"10.2\"}]'),
(18, 2, 14, 'Stopping the time'),
(19, 3, 14, 'Build the dream'),
(20, 2, 15, '[{\"nama\":\"A\",\"type\":\"text\",\"value\":\"top\"},{\"nama\":\"B\",\"type\":\"number\",\"value\":\"2.34\"}]'),
(21, 2, 16, '[{\"nama\":\"A\",\"type\":\"text\",\"value\":\"top\"},{\"nama\":\"B\",\"type\":\"number\",\"value\":\"2.34\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `jenis_hewan`
--

CREATE TABLE `jenis_hewan` (
  `id` int(11) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `total_kunjungan` int(11) NOT NULL DEFAULT '0',
  `kunj_terakhir` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jenis_hewan`
--

INSERT INTO `jenis_hewan` (`id`, `nama`, `total_kunjungan`, `kunj_terakhir`) VALUES
(4, 'Kucing', 16, '2018-09-05 00:00:00'),
(6, 'Ular', 0, NULL),
(7, 'Anjing 2', 4, '2018-02-02 00:00:00'),
(8, 'A', 0, NULL),
(10, 'C', 0, NULL),
(11, 'Edited', 0, NULL),
(13, 'JH2', 0, NULL),
(14, 'JH', 0, NULL),
(15, 'JH3', 0, NULL),
(16, 'JH4', 0, NULL),
(17, 'JH5', 0, NULL),
(18, 'JH6', 0, NULL),
(19, 'JH7', 0, NULL),
(20, 'JH8', 0, NULL),
(21, 'JH9', 0, NULL),
(22, 'JH10', 0, NULL),
(23, 'JH11', 0, NULL),
(24, 'JH12', 0, NULL),
(25, 'JH13', 0, NULL),
(26, 'JH14', 0, NULL),
(27, 'JH15', 0, NULL),
(28, 'JH16', 0, NULL),
(29, 'JH17', 0, NULL),
(30, 'JH18', 0, NULL),
(31, 'JH19', 0, NULL),
(32, 'JH20', 0, NULL),
(33, 'llll', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pasien`
--

CREATE TABLE `pasien` (
  `id` int(11) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `jk` smallint(1) NOT NULL,
  `signalemen` varchar(250) NOT NULL,
  `lahir` date NOT NULL,
  `total_kunjungan` int(11) NOT NULL DEFAULT '0',
  `kunj_terakhir` datetime DEFAULT NULL,
  `id_ras` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pasien`
--

INSERT INTO `pasien` (`id`, `nama`, `jk`, `signalemen`, `lahir`, `total_kunjungan`, `kunj_terakhir`, `id_ras`) VALUES
(1, 'asas', 1, 'dsdsd', '2018-10-10', 0, '2018-10-27 03:13:00', 5),
(6, 'sssd', 1, 'sdsd', '2018-10-02', 0, NULL, 5),
(7, 'sss', 1, 'ssdsd', '2018-10-03', 0, NULL, 5),
(8, 'Foobar', 1, 'asasasas', '2018-07-10', 0, NULL, 6),
(9, 'asaas', 1, '--', '2018-11-01', 0, NULL, 5),
(10, 'asaas', 1, '--', '2018-11-01', 0, NULL, 5),
(11, 'asaas', 1, '--', '2018-11-01', 0, NULL, 5),
(12, 'asaas', 1, '--', '2018-11-01', 0, NULL, 5),
(13, 'asaas', 1, '--', '2018-11-01', 0, NULL, 5),
(14, 'asaas', 1, '--', '2018-11-01', 0, NULL, 5),
(15, 'asaas', 1, '--', '2018-11-01', 0, NULL, 5),
(16, 'asaas', 1, '--', '2018-11-01', 0, NULL, 5),
(17, 'asaas', 1, '--', '2018-11-01', 0, NULL, 5),
(18, 'asaas', 1, '--', '2018-11-01', 1, '0000-00-00 00:00:00', 5),
(19, 'asaas', 1, '--', '2018-11-01', 1, '0000-00-00 00:00:00', 5),
(20, 'asaas', 1, '--', '2018-11-01', 1, '0000-00-00 00:00:00', 5),
(21, 'asaas', 1, '--', '2018-11-01', 1, '0000-00-00 00:00:00', 5),
(22, 'asaas', 1, '--', '2018-11-01', 1, '0000-00-00 00:00:00', 5),
(23, 'asaas', 1, '--', '2018-11-01', 1, '0000-00-00 00:00:00', 5),
(24, 'asaas', 1, '--', '2018-11-01', 1, '0000-00-00 00:00:00', 5),
(25, 'asaas', 1, '--', '2018-11-01', 1, '0000-00-00 00:00:00', 5),
(26, 'asaas', 1, '--', '2018-11-01', 1, '0000-00-00 00:00:00', 5),
(27, 'asaas', 1, '--', '2018-11-01', 1, '0000-00-00 00:00:00', 5),
(28, 'asaas', 1, '--', '2018-11-01', 1, '0000-00-00 00:00:00', 5),
(29, 'asaas', 1, '--', '2018-11-01', 1, '0000-00-00 00:00:00', 5),
(30, 'asaas', 1, '--', '2018-11-01', 1, '0000-00-00 00:00:00', 5),
(31, 'asaas', 1, '--', '2018-11-01', 1, '0000-00-00 00:00:00', 5),
(32, 'Foobar', 1, '--', '2018-02-06', 1, '2018-09-05 00:00:00', 5),
(33, 'Foobar', 1, '--', '2018-02-06', 1, '2018-09-05 00:00:00', 5);

-- --------------------------------------------------------

--
-- Table structure for table `pemilik`
--

CREATE TABLE `pemilik` (
  `id` int(11) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `alamat` varchar(250) NOT NULL,
  `no_telp` varchar(250) NOT NULL,
  `total_kunjungan` int(11) NOT NULL DEFAULT '0',
  `kunj_terakhir` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pemilik`
--

INSERT INTO `pemilik` (`id`, `nama`, `alamat`, `no_telp`, `total_kunjungan`, `kunj_terakhir`) VALUES
(1, 'Egi', 'tte', 'yy', 17, NULL),
(2, 'asas osas', 'sas', 'asas', 0, NULL),
(3, 'Feri', 'aa', 'aa', 0, NULL),
(4, 'sdsd', 'dsdsd', 'ssd', 0, NULL),
(5, 'sdsd', 'dsdsd', 'ssd', 0, NULL),
(6, 'kh', 'hf', 'hfhf', 0, NULL),
(7, 'P1', 'a', '09323', 0, NULL),
(8, 'P1', 'a', '09323', 0, NULL),
(9, 'P1', 'a', '09323', 0, NULL),
(10, 'P1', 'a', '09323', 0, NULL),
(11, 'P1', 'a', '09323', 0, NULL),
(12, 'P1', 'a', '09323', 0, NULL),
(13, 'P1', 'a', '09323', 0, NULL),
(14, 'P1', 'a', '09323', 0, NULL),
(15, 'P1', 'a', '09323', 0, NULL),
(16, 'P1', 'a', '09323', 0, NULL),
(17, 'P1', 'a', '09323', 0, NULL),
(18, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(19, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(20, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(21, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(22, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(23, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(24, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(25, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(26, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(27, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(28, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(29, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(30, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(31, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(32, 'Jordan', 'Oesapa', 'sdsdsd', 1, '2018-09-05 00:00:00'),
(33, 'Jordan', 'Oesapa', 'sdsdsd', 1, '2018-09-05 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `pen_khusus`
--

CREATE TABLE `pen_khusus` (
  `id` int(11) NOT NULL,
  `id_tipe_pen_khusus` int(11) NOT NULL,
  `id_rekam_medik` int(11) NOT NULL,
  `deskripsi` varchar(250) NOT NULL,
  `total_penggunaan` int(11) NOT NULL DEFAULT '0',
  `penggunaan_terakhir` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ras`
--

CREATE TABLE `ras` (
  `id` int(11) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `total_kunjungan` int(11) NOT NULL DEFAULT '0',
  `kunj_terakhir` datetime DEFAULT NULL,
  `id_jenis_hewan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ras`
--

INSERT INTO `ras` (`id`, `nama`, `total_kunjungan`, `kunj_terakhir`, `id_jenis_hewan`) VALUES
(4, 'B12', 0, NULL, 7),
(5, 'C', 16, '2018-09-05 00:00:00', 4),
(6, 'Bulldog 1', 0, NULL, 8);

-- --------------------------------------------------------

--
-- Table structure for table `rekam_medik`
--

CREATE TABLE `rekam_medik` (
  `id` int(11) NOT NULL,
  `pasien_id` int(11) NOT NULL,
  `pemilik_id` int(11) NOT NULL,
  `tanggal` datetime NOT NULL,
  `berat` double(10,5) NOT NULL DEFAULT '1.00000',
  `tipe_norek` enum('GA','GB','GC','GD') COLLATE utf8mb4_unicode_ci NOT NULL,
  `freq_n` double(10,5) NOT NULL DEFAULT '1.00000',
  `freq_p` double(10,5) NOT NULL DEFAULT '1.00000',
  `freq_t` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `mth` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mulut` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kul_rambut` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kelenjar_limfe` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pernapasan` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `peredaran_darah` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pencernaan` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kelamin_perkencingan` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ang_gerak` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diagnosa` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prognosis` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terapi` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `norek` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rekam_medik`
--

INSERT INTO `rekam_medik` (`id`, `pasien_id`, `pemilik_id`, `tanggal`, `berat`, `tipe_norek`, `freq_n`, `freq_p`, `freq_t`, `mth`, `mulut`, `kul_rambut`, `kelenjar_limfe`, `pernapasan`, `peredaran_darah`, `pencernaan`, `kelamin_perkencingan`, `ang_gerak`, `diagnosa`, `prognosis`, `terapi`, `norek`) VALUES
(1, 18, 18, '0000-00-00 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, NULL, NULL, '', '', '', '', '', '', '', '', '', '', 'asasasasasas'),
(2, 19, 19, '0000-00-00 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, NULL, NULL, '', '', '', '', '', '', '', '', '', '', 'asasasasasas'),
(3, 20, 20, '0000-00-00 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, '', '', '', '', '', '', '', '', '', '', '', '', 'asasasasasas'),
(4, 21, 21, '0000-00-00 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, '', '', '', '', '', '', '', '', '', '', '', '', 'asasasasasas'),
(5, 22, 22, '0000-00-00 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, '', '', '', '', '', '', '', '', '', '', '', '', 'asasasasasas'),
(6, 23, 23, '0000-00-00 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, '', '', '', '', '', '', '', '', '', '', '', '', 'asasasasasas'),
(7, 24, 24, '0000-00-00 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, '', '', '', '', '', '', '', '', '', '', '', '', 'asasasasasas'),
(8, 25, 25, '0000-00-00 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, '', '', '', '', '', '', '', '', '', '', '', '', 'asasasasasas'),
(9, 26, 26, '0000-00-00 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, '', '', '', '', '', '', '', '', '', '', '', '', 'asasasasasas'),
(10, 27, 27, '0000-00-00 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, '', '', '', '', '', '', '', '', '', '', '', '', 'asasasasasas'),
(11, 28, 28, '0000-00-00 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, '', '', '', '', '', '', '', '', '', '', '', '', 'asasasasasas'),
(12, 29, 29, '0000-00-00 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, '', '', '', '', '', '', '', '', '', '', '', '', 'asasasasasas'),
(13, 30, 30, '0000-00-00 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, '', '', '', '', '', '', '', '', '', '', '', '', 'asasasasasas'),
(14, 31, 31, '0000-00-00 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, '', '', '', '', '', '', '', '', '', '', '', '', 'asasasasasas'),
(15, 32, 32, '2018-09-05 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, '', '', '', '', '', '', '', '', '', '', '', '', '10-90-001'),
(16, 33, 33, '2018-09-05 00:00:00', 0.00000, 'GA', 0.00000, 0.00000, 0, '', '', '', '', '', '', '', '', '', '', '', '', '10-90-001');

-- --------------------------------------------------------

--
-- Table structure for table `tipe_hasil_lab`
--

CREATE TABLE `tipe_hasil_lab` (
  `id` int(11) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `struktur` text NOT NULL,
  `total_penggunaan` int(11) NOT NULL DEFAULT '0',
  `penggunaan_terakhir` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipe_hasil_lab`
--

INSERT INTO `tipe_hasil_lab` (`id`, `nama`, `struktur`, `total_penggunaan`, `penggunaan_terakhir`) VALUES
(2, 'A', '[{\"nama\":\"A\",\"type\":\"string\"},{\"nama\":\"B\",\"type\":\"number\"}]', 0, NULL),
(3, 'B', '[{\"nama\":\"A\",\"type\":\"string\"},{\"nama\":\"B\",\"type\":\"number\"}]', 0, NULL),
(4, 'C', '[{\"nama\":\"A\",\"type\":\"string\"},{\"nama\":\"B\",\"type\":\"number\"}]', 0, NULL),
(5, 'D', '[{\"nama\":\"A\",\"type\":\"string\"},{\"nama\":\"B\",\"type\":\"number\"}]', 0, NULL),
(6, 'E', '[{\"nama\":\"A\",\"type\":\"string\"},{\"nama\":\"B\",\"type\":\"number\"}]', 0, NULL),
(7, 'F', '[{\"nama\":\"A\",\"type\":\"string\"},{\"nama\":\"B\",\"type\":\"number\"}]', 0, NULL),
(8, 'G', '[{\"nama\":\"A\",\"type\":\"string\"},{\"nama\":\"B\",\"type\":\"number\"}]', 0, NULL),
(9, 'H', '[{\"nama\":\"A\",\"type\":\"string\"},{\"nama\":\"B\",\"type\":\"number\"}]', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tipe_pen_khusus`
--

CREATE TABLE `tipe_pen_khusus` (
  `id` int(11) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `total_penggunaan` int(11) NOT NULL DEFAULT '0',
  `penggunaan_terakhir` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipe_pen_khusus`
--

INSERT INTO `tipe_pen_khusus` (`id`, `nama`, `total_penggunaan`, `penggunaan_terakhir`) VALUES
(2, 'X-ray', 0, NULL),
(3, 'sdsdsd', 0, NULL),
(4, 'sdsdsd', 0, NULL),
(5, 'sdsdsd', 0, NULL),
(6, 'sdsdsd', 0, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hasil_lab`
--
ALTER TABLE `hasil_lab`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tipe_hasil_lab` (`id_tipe_hasil_lab`),
  ADD KEY `id_rekam_medik` (`id_rekam_medik`);

--
-- Indexes for table `jenis_hewan`
--
ALTER TABLE `jenis_hewan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_ras` (`id_ras`);

--
-- Indexes for table `pemilik`
--
ALTER TABLE `pemilik`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pen_khusus`
--
ALTER TABLE `pen_khusus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tipe_pen_khusus` (`id_tipe_pen_khusus`),
  ADD KEY `id_rekam_medik` (`id_rekam_medik`);

--
-- Indexes for table `ras`
--
ALTER TABLE `ras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_jenis_hewan` (`id_jenis_hewan`);

--
-- Indexes for table `rekam_medik`
--
ALTER TABLE `rekam_medik`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pasien_id` (`pasien_id`),
  ADD KEY `pemilik_id` (`pemilik_id`);

--
-- Indexes for table `tipe_hasil_lab`
--
ALTER TABLE `tipe_hasil_lab`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tipe_pen_khusus`
--
ALTER TABLE `tipe_pen_khusus`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hasil_lab`
--
ALTER TABLE `hasil_lab`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `jenis_hewan`
--
ALTER TABLE `jenis_hewan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `pemilik`
--
ALTER TABLE `pemilik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `pen_khusus`
--
ALTER TABLE `pen_khusus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ras`
--
ALTER TABLE `ras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `rekam_medik`
--
ALTER TABLE `rekam_medik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `tipe_hasil_lab`
--
ALTER TABLE `tipe_hasil_lab`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tipe_pen_khusus`
--
ALTER TABLE `tipe_pen_khusus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `hasil_lab`
--
ALTER TABLE `hasil_lab`
  ADD CONSTRAINT `hasil_lab_ibfk_1` FOREIGN KEY (`id_tipe_hasil_lab`) REFERENCES `tipe_hasil_lab` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `hasil_lab_ibfk_2` FOREIGN KEY (`id_rekam_medik`) REFERENCES `rekam_medik` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pasien`
--
ALTER TABLE `pasien`
  ADD CONSTRAINT `pasien_ibfk_1` FOREIGN KEY (`id_ras`) REFERENCES `ras` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pen_khusus`
--
ALTER TABLE `pen_khusus`
  ADD CONSTRAINT `pen_khusus_ibfk_1` FOREIGN KEY (`id_tipe_pen_khusus`) REFERENCES `tipe_pen_khusus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pen_khusus_ibfk_2` FOREIGN KEY (`id_rekam_medik`) REFERENCES `rekam_medik` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ras`
--
ALTER TABLE `ras`
  ADD CONSTRAINT `ras_ibfk_1` FOREIGN KEY (`id_jenis_hewan`) REFERENCES `jenis_hewan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rekam_medik`
--
ALTER TABLE `rekam_medik`
  ADD CONSTRAINT `rekam_medik_ibfk_1` FOREIGN KEY (`pasien_id`) REFERENCES `pasien` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rekam_medik_ibfk_2` FOREIGN KEY (`pemilik_id`) REFERENCES `pemilik` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
