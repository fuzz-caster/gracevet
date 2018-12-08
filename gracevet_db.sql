-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Dec 08, 2018 at 04:01 AM
-- Server version: 8.0.3-rc-log
-- PHP Version: 7.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gracevet_db`
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
(72, 2, 44, '[{\"nama\":\"Natif\",\"type\":\"text\",\"value\":\"asasasasas\"},{\"nama\":\"Centrifuse\",\"type\":\"text\",\"value\":\"sdsdsdsd\"}]'),
(73, 5, 44, '[{\"nama\":\"Faal Ginjal(Creat)\",\"type\":\"text\",\"value\":\"sdsdsd\"},{\"nama\":\"Faal Ginjal(BUN)\",\"type\":\"number\",\"value\":\"5\"},{\"type\":\"text\",\"name\":\"\",\"nama\":\"Faal Hati(SGPT/ALT)\",\"value\":\"ssdsd\"},{\"type\":\"text\",\"name\":\"\",\"nama\":\"Faal Hati(SGOT/AST)\",\"value\":\"sdsdsd\"},{\"type\":\"text\",\"name\":\"\",\"nama\":\"Faal Hati(Bilirubun Total)\",\"value\":\"sdsdsd\"},{\"type\":\"text\",\"name\":\"\",\"nama\":\"Faal Hati(Bilirubun dir.)\",\"value\":\"sdssd\"},{\"type\":\"text\",\"name\":\"\",\"nama\":\"Faal Hati(Bilirubun indir.)\",\"value\":\"ssdsd\"},{\"type\":\"text\",\"name\":\"\",\"nama\":\"lain-lain\",\"value\":null}]');

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
(4, 'Kucing', 21, NULL),
(6, 'Ular', 0, NULL),
(7, 'Anjing 2', 4, '2018-02-02 00:00:00'),
(8, 'A', 1, '2018-11-05 00:34:00'),
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
-- Table structure for table `obat`
--

CREATE TABLE `obat` (
  `id` int(11) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `satuan` varchar(250) NOT NULL,
  `harga` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `obat`
--

INSERT INTO `obat` (`id`, `nama`, `satuan`, `harga`) VALUES
(1, 'Paracetamol', 'Tablet', 1000),
(2, 'Vhff', 'Tablet', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `pasien`
--

CREATE TABLE `pasien` (
  `id` int(11) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `jk` smallint(1) NOT NULL,
  `tatto_chip` varchar(250) DEFAULT NULL,
  `signalemen` varchar(250) NOT NULL,
  `lahir` date NOT NULL,
  `total_kunjungan` int(11) NOT NULL DEFAULT '0',
  `kunj_terakhir` datetime DEFAULT NULL,
  `id_ras` int(11) NOT NULL,
  `tipe_norek` enum('GA','GB','GC','GD') DEFAULT 'GA',
  `norek` int(11) DEFAULT NULL,
  `temp_pemilik_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pasien`
--

INSERT INTO `pasien` (`id`, `nama`, `jk`, `tatto_chip`, `signalemen`, `lahir`, `total_kunjungan`, `kunj_terakhir`, `id_ras`, `tipe_norek`, `norek`, `temp_pemilik_id`) VALUES
(1, 'asas', 1, NULL, 'dsdsd', '2011-10-10', 0, NULL, 5, 'GA', 1, 33),
(6, 'sssd', 1, NULL, 'sdsd', '2018-10-02', 1, NULL, 5, 'GA', 2, 1),
(7, 'sss', 1, NULL, 'ssdsd', '2018-10-03', 0, NULL, 5, 'GC', 3, 3);

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
(1, 'Egi', 'tte', 'yy', 16, NULL),
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
(32, 'Jordan', 'Oesapa', 'sdsdsd', 4, '2018-11-07 16:30:00'),
(33, 'Jordan', 'Oesapa', 'sdsdsd', 1, '2018-09-05 00:00:00'),
(34, 'sdsdsd', 'sdsds', '', 1, '0000-00-00 00:00:00'),
(35, 'sdsdsd', 'sdsds', '', 1, '2018-11-01 00:00:00'),
(36, 'sdsdsd', 'sdsds', '', 1, '2018-11-01 00:00:00'),
(37, 'sdsdsd', 'sdsds', '', 1, '2018-11-01 00:00:00'),
(38, 'sdsd', 'sdsdsd', 'sdsdsd', 1, '2018-11-05 00:34:00'),
(39, 'fhfhf', 'mmhmh', 'hthth', 1, '2018-11-07 16:30:00'),
(40, 'hshskwhws`ss', 'khkh', 'mbmbmb', 0, NULL),
(41, 'sdsd', 'sdsd', 'sdsd', 0, NULL),
(42, 'sdsd', 'sdsd', 'sdsd', 0, NULL),
(43, 'sdsd', 'sdsd', 'sdsd', 0, NULL),
(44, 'sdsd', 'sdsd', 'sdsd', 0, NULL),
(45, 'sdsd', 'sdsd', 'sdsd', 0, NULL),
(46, 'sdsd', 'sdsd', 'sdsd', 0, NULL),
(47, 'sdsd', 'sdsd', 'sdsd', 0, NULL),
(48, 'sdsd', 'sdsd', 'sdsd', 0, NULL),
(49, 'sdsd', 'sdsd', 'sdsd', 0, NULL),
(50, 'sdsd', 'sdsd', 'sdsd', 0, NULL),
(51, 'sdsd', 'sdsd', 'sdsd', 0, NULL),
(52, 'sdsd', 'sdsd', 'sdsd', 0, NULL),
(53, 'sdsd', 'sdsd', 'sdsd', 0, NULL),
(54, 'sdsd', 'sdsd', 'sdsd', 0, NULL),
(55, 'Antus', 'Oesapa', '089232', 0, NULL),
(56, 'asasssd', 'sdsdsd', 'sdsd', 0, NULL),
(57, 'hfhfh', 'fhfh', 'hfh', 0, NULL),
(58, 'Bai', 'Oepura', '', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `penyakit`
--

CREATE TABLE `penyakit` (
  `id` int(11) NOT NULL,
  `nama` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penyakit`
--

INSERT INTO `penyakit` (`id`, `nama`) VALUES
(1, 'A'),
(8, 'Depresi 1');

-- --------------------------------------------------------

--
-- Table structure for table `pen_khusus`
--

CREATE TABLE `pen_khusus` (
  `id` int(11) NOT NULL,
  `id_tipe_pen_khusus` int(11) NOT NULL,
  `id_rekam_medik` int(11) NOT NULL,
  `deskripsi` text NOT NULL,
  `total_penggunaan` int(11) NOT NULL DEFAULT '0',
  `penggunaan_terakhir` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pen_khusus`
--

INSERT INTO `pen_khusus` (`id`, `id_tipe_pen_khusus`, `id_rekam_medik`, `deskripsi`, `total_penggunaan`, `penggunaan_terakhir`) VALUES
(16, 2, 44, 'I\'m trying to open a URL in a new tab, as opposed to a popup window. I\'ve seen related questions where the responses would look something like:\n\n', 0, NULL),
(17, 3, 44, 'The Kalkaua coinage is a set of silver coins of the Kingdom of Hawaii dated 1883. They were designed by Charles E. Barber, Chief Engraver of the United States Bureau of the Mint, and were struck at the San Francisco Mint. The issued coins are a dime, quarter dollar, half dollar, and dollar (pictured). No immediate action had been taken after the 1880 act authorizing the coins, but King  was interested, and government officials saw a way to get out of a financial bind by getting coins issued in exchange for government bonds. ', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `perawatan`
--

CREATE TABLE `perawatan` (
  `id` int(11) NOT NULL,
  `rm_id` int(11) NOT NULL,
  `waktu` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `keterangan` text,
  `nxm` int(11) DEFAULT NULL,
  `pxm` int(11) DEFAULT NULL,
  `toc` text,
  `tipe` enum('RAWAT','KELUAR') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `perawatan`
--

INSERT INTO `perawatan` (`id`, `rm_id`, `waktu`, `keterangan`, `nxm`, `pxm`, `toc`, `tipe`) VALUES
(5, 22, '2018-11-11 22:38:00', 'The internal v-form component makes it easy to add validation to form inputs. All input components have a rules prop which takes an array of functions. Whenever the value of an input is changed, each function in the array will receive the new value. If a function returns false or a string, validation has failed.', 5, 5, 'sddsd', 'RAWAT'),
(6, 22, '2018-11-12 10:38:00', 'The internal v-form component makes it easy to add validation to form inputs. All input components have a rules prop which takes an array of functions. Whenever the value of an input is changed, each function in the array will receive the new value. If a function returns false or a string, validation has failed.', 5, 5, 'sddsd', 'RAWAT'),
(7, 22, '2018-11-12 09:41:00', 'The internal v-form component makes it easy to add validation to form inputs. All input components have a rules prop which takes an array of functions. Whenever the value of an input is changed, each function in the array will receive the new value. If a function returns false or a string, validation has failed.', 5, 5, 'sddsd', 'RAWAT'),
(8, 22, '2018-11-11 21:42:00', 'The internal v-form component makes it easy to add validation to form inputs. All input components have a rules prop which takes an array of functions. Whenever the value of an input is changed, each function in the array will receive the new value. If a function returns false or a string, validation has failed.', 5, 5, 'sddsd', 'RAWAT'),
(9, 22, '2018-11-12 08:43:00', 'Vee-validate is another validation plugin that allows you to check your forms. One caveat is that you must add the type=\"checkbox\" to properly validate a v-checkbox when using the value prop.', 5, 5, 'sddsd', 'RAWAT'),
(10, 22, '2018-11-14 08:55:00', 'Sudah Sehat', 0, 0, '', 'KELUAR'),
(11, 22, '2018-11-12 09:14:00', 'lulu', 3, 3, 'ululu', 'RAWAT'),
(13, 26, '2018-11-06 13:12:00', 'llljljlj', 4, 0, 'gkkhk', 'RAWAT'),
(14, 26, '2018-11-06 16:12:00', 'llljljlj', 4, 0, 'gkkhk', 'RAWAT'),
(15, 41, '2018-11-14 14:46:00', 'Bagus', 0, 0, '', 'RAWAT'),
(16, 41, '2018-11-07 17:12:00', 'llsj sksk skhs ', 3, 3, 'khkkh', 'RAWAT');

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
(5, 'C', 21, NULL, 4),
(6, 'Bulldog 1', 1, '2018-11-05 00:34:00', 8);

-- --------------------------------------------------------

--
-- Table structure for table `rekam_medik`
--

CREATE TABLE `rekam_medik` (
  `id` int(11) NOT NULL,
  `pasien_id` int(11) NOT NULL,
  `pemilik_id` int(11) NOT NULL,
  `penyakit_id` int(11) DEFAULT NULL,
  `tanggal` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `berat` double(10,5) NOT NULL DEFAULT '1.00000',
  `tipe_norek` enum('GA','GB','GC','GD') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `freq_n` double(10,5) NOT NULL DEFAULT '1.00000',
  `freq_p` double(10,5) NOT NULL DEFAULT '1.00000',
  `freq_t` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `mth` text COLLATE utf8mb4_unicode_ci,
  `mulut` text COLLATE utf8mb4_unicode_ci,
  `kul_rambut` text COLLATE utf8mb4_unicode_ci,
  `kelenjar_limfe` text COLLATE utf8mb4_unicode_ci,
  `pernapasan` text COLLATE utf8mb4_unicode_ci,
  `peredaran_darah` text COLLATE utf8mb4_unicode_ci,
  `pencernaan` text COLLATE utf8mb4_unicode_ci,
  `kelamin_perkencingan` text COLLATE utf8mb4_unicode_ci,
  `ang_gerak` text COLLATE utf8mb4_unicode_ci,
  `diagnosa` text COLLATE utf8mb4_unicode_ci,
  `prognosis` text COLLATE utf8mb4_unicode_ci,
  `terapi` text COLLATE utf8mb4_unicode_ci,
  `norek` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rekam_medik`
--

INSERT INTO `rekam_medik` (`id`, `pasien_id`, `pemilik_id`, `penyakit_id`, `tanggal`, `berat`, `tipe_norek`, `freq_n`, `freq_p`, `freq_t`, `mth`, `mulut`, `kul_rambut`, `kelenjar_limfe`, `pernapasan`, `peredaran_darah`, `pencernaan`, `kelamin_perkencingan`, `ang_gerak`, `diagnosa`, `prognosis`, `terapi`, `norek`) VALUES
(22, 1, 32, 2, '2018-11-30 03:11:00', 1.00000, 'GB', 1.00000, 1.00000, 1, '', '', '', '', '', '', '', '', '', '', '', '', '5'),
(23, 6, 38, 2, '2018-11-30 03:11:00', 1.00000, 'GB', 1.00000, 1.00000, 1, '', '', '', '', '', '', '', '', '', '', '', '', '5'),
(24, 7, 39, 2, '2018-11-30 03:11:00', 1.00000, 'GB', 1.00000, 1.00000, 1, '', '', '', '', '', '', '', '', '', '', '', '', '5'),
(25, 6, 32, 2, '2018-11-30 03:11:00', 1.00000, 'GB', 1.00000, 1.00000, 1, '', '', '', '', '', '', '', '', '', '', '', '', '5'),
(32, 6, 2, 2, '2018-11-30 03:11:00', 1.00000, 'GB', 1.00000, 1.00000, 1, '', '', '', '', '', '', '', '', '', '', '', '', '5'),
(33, 7, 32, 2, '2018-11-30 03:11:00', 1.00000, 'GB', 1.00000, 1.00000, 1, '', '', '', '', '', '', '', '', '', '', '', '', '5'),
(42, 1, 56, 6, '2018-11-30 06:22:00', 41.00000, 'GA', 1.00000, 1.00000, 1, 'sdsdsdsd sdsd', 'sdsdds', 'ddf', 'dfdf', 'dfdfdf', 'dfdfdf', 'dfdf', '', '', '', '', '', '1'),
(43, 1, 57, 7, '2018-12-04 06:02:00', 1.00000, 'GA', 1.00000, 1.00000, 1, '', '', '', '', '', '', '', '', '', '', '', '', '1'),
(44, 1, 33, 8, '2018-12-05 02:50:00', 1.00000, 'GA', 1.00000, 1.00000, 1, 'Often you may want to have your table resize dynamically with the page. Typically this is done by assigning width:100% in your CSS, but this presents a problem for Javascript since it can be very hard to get that relative size rather than the absolute pixels. As such, if you apply the width attribute to the HTML table tag or inline width style ', 'Often you may want to have your table resize dynamically with the page. Typically this is done by assigning width:100% in your CSS, but this presents a problem for Javascript since it can be very hard to get that relative size rather than the absolute pixels. As such, if you apply the width attribute to the HTML table tag or inline width style ', 'Often you may want to have your table resize dynamically with the page. Typically this is done by assigning width:100% in your CSS, but this presents a problem for Javascript since it can be very hard to get that relative size rather than the absolute pixels. As such, if you apply the width attribute to the HTML table tag or inline width style ', 'Often you may want to have your table resize dynamically with the page. Typically this is done by assigning width:100% in your CSS, but this presents a problem for Javascript since it can be very hard to get that relative size rather than the absolute pixels. As such, if you apply the width attribute to the HTML table tag or inline width style ', 'Often you may want to have your table resize dynamically with the page. Typically this is done by assigning width:100% in your CSS, but this presents a problem for Javascript since it can be very hard to get that relative size rather than the absolute pixels. As such, if you apply the width attribute to the HTML table tag or inline width style ', 'Often you may want to have your table resize dynamically with the page. Typically this is done by assigning width:100% in your CSS, but this presents a problem for Javascript since it can be very hard to get that relative size rather than the absolute pixels. As such, if you apply the width attribute to the HTML table tag or inline width style ', 'Often you may want to have your table resize dynamically with the page. Typically this is done by assigning width:100% in your CSS, but this presents a problem for Javascript since it can be very hard to get that relative size rather than the absolute pixels. As such, if you apply the width attribute to the HTML table tag or inline width style ', 'Often you may want to have your table resize dynamically with the page. Typically this is done by assigning width:100% in your CSS, but this presents a problem for Javascript since it can be very hard to get that relative size rather than the absolute pixels. As such, if you apply the width attribute to the HTML table tag or inline width style ', 'Often you may want to have your table resize dynamically with the page. Typically this is done by assigning width:100% in your CSS, but this presents a problem for Javascript since it can be very hard to get that relative size rather than the absolute pixels. As such, if you apply the width attribute to the HTML table tag or inline width style ', 'Often you may want to have your table resize dynamically with the page. Typically this is done by assigning width:100% in your CSS, but this presents a problem for Javascript since it can be very hard to get that relative size rather than the absolute pixels. As such, if you apply the width attribute to the HTML table tag or inline width style ', 'Often you may want to have your table resize dynamically with the page. Typically this is done by assigning width:100% in your CSS, but this presents a problem for Javascript since it can be very hard to get that relative size rather than the absolute pixels. As such, if you apply the width attribute to the HTML table tag or inline width style ', 'Often you may want to have your table resize dynamically with the page. Typically this is done by assigning width:100% in your CSS, but this presents a problem for Javascript since it can be very hard to get that relative size rather than the absolute pixels. As such, if you apply the width attribute to the HTML table tag or inline width style ', '1');

-- --------------------------------------------------------

--
-- Table structure for table `resep`
--

CREATE TABLE `resep` (
  `id` int(11) NOT NULL,
  `id_rm` int(11) NOT NULL,
  `id_obat` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(2, 'Feses', '[{\"nama\":\"Natif\",\"type\":\"string\"},{\"nama\":\"Centrifuse\",\"type\":\"string\"}]', 0, NULL),
(3, 'Kulit', '[{\"nama\":\"Kerokan\",\"type\":\"string\"},{\"nama\":\"Wood Lamp\",\"type\":\"string\"}]', 0, NULL),
(4, 'Darah (Hematologi Lengkap)', '[{\"nama\":\"RBC\",\"type\":\"string\"},{\"nama\":\"Hb\",\"type\":\"number\"},{\"type\":\"string\",\"name\":\"\",\"nama\":\"PCV\"},{\"type\":\"string\",\"name\":\"\",\"nama\":\"Platelet\"},{\"type\":\"string\",\"name\":\"\",\"nama\":\"Leukosit\"},{\"type\":\"string\",\"name\":\"\",\"nama\":\"Neutrofil\"},{\"type\":\"string\",\"name\":\"\",\"nama\":\"Eosinofil\"},{\"type\":\"string\",\"name\":\"\",\"nama\":\"Basofit\"},{\"type\":\"string\",\"name\":\"\",\"nama\":\"Limsofit\"},{\"type\":\"string\",\"name\":\"\",\"nama\":\"Monosit\"}]', 0, NULL),
(5, 'Kimiawi Darah', '[{\"nama\":\"Faal Ginjal(Creat)\",\"type\":\"string\"},{\"nama\":\"Faal Ginjal(BUN)\",\"type\":\"number\"},{\"type\":\"string\",\"name\":\"\",\"nama\":\"Faal Hati(SGPT/ALT)\"},{\"type\":\"string\",\"name\":\"\",\"nama\":\"Faal Hati(SGOT/AST)\"},{\"type\":\"string\",\"name\":\"\",\"nama\":\"Faal Hati(Bilirubun Total)\"},{\"type\":\"string\",\"name\":\"\",\"nama\":\"Faal Hati(Bilirubun dir.)\"},{\"type\":\"string\",\"name\":\"\",\"nama\":\"Faal Hati(Bilirubun indir.)\"},{\"type\":\"string\",\"name\":\"\",\"nama\":\"lain-lain\"}]', 0, NULL);

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
(2, 'Rontgen', 0, NULL),
(3, 'USG', 0, NULL);

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
-- Indexes for table `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_ras` (`id_ras`),
  ADD KEY `norek` (`norek`),
  ADD KEY `temp_pemilik_id` (`temp_pemilik_id`);

--
-- Indexes for table `pemilik`
--
ALTER TABLE `pemilik`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `penyakit`
--
ALTER TABLE `penyakit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pen_khusus`
--
ALTER TABLE `pen_khusus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tipe_pen_khusus` (`id_tipe_pen_khusus`),
  ADD KEY `id_rekam_medik` (`id_rekam_medik`);

--
-- Indexes for table `perawatan`
--
ALTER TABLE `perawatan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rm_id` (`rm_id`);

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
  ADD KEY `pemilik_id` (`pemilik_id`),
  ADD KEY `penyakit_id` (`penyakit_id`);

--
-- Indexes for table `resep`
--
ALTER TABLE `resep`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_rm` (`id_rm`),
  ADD KEY `id_obat` (`id_obat`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `jenis_hewan`
--
ALTER TABLE `jenis_hewan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `obat`
--
ALTER TABLE `obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `pemilik`
--
ALTER TABLE `pemilik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `penyakit`
--
ALTER TABLE `penyakit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `pen_khusus`
--
ALTER TABLE `pen_khusus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `perawatan`
--
ALTER TABLE `perawatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `ras`
--
ALTER TABLE `ras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `rekam_medik`
--
ALTER TABLE `rekam_medik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `resep`
--
ALTER TABLE `resep`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  ADD CONSTRAINT `pasien_ibfk_1` FOREIGN KEY (`id_ras`) REFERENCES `ras` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pasien_ibfk_2` FOREIGN KEY (`temp_pemilik_id`) REFERENCES `pemilik` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
