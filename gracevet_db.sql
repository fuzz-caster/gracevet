-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Aug 28, 2019 at 05:18 PM
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
(75, 2, 51, '[{\"nama\":\"Natif\",\"type\":\"text\",\"value\":\"sdsd\"},{\"nama\":\"Centrifuse\",\"type\":\"text\",\"value\":\"ssdd\"}]'),
(76, 3, 51, '[{\"nama\":\"Kerokan\",\"type\":\"text\",\"value\":\"sdsds\"},{\"nama\":\"Wood Lamp\",\"type\":\"text\",\"value\":\"ssdsd\"}]'),
(77, 4, 51, '[{\"nama\":\"RBC\",\"type\":\"text\",\"value\":\"sdsd\"},{\"nama\":\"Hb\",\"type\":\"number\",\"value\":\"4\"},{\"type\":\"text\",\"name\":\"\",\"nama\":\"PCV\",\"value\":\"sdsd\"},{\"type\":\"text\",\"name\":\"\",\"nama\":\"Platelet\",\"value\":\"sdsd\"},{\"type\":\"text\",\"name\":\"\",\"nama\":\"Leukosit\",\"value\":\"sdsd\"},{\"type\":\"text\",\"name\":\"\",\"nama\":\"Neutrofil\",\"value\":\"sdsd\"},{\"type\":\"text\",\"name\":\"\",\"nama\":\"Eosinofil\",\"value\":\"sdsd\"},{\"type\":\"text\",\"name\":\"\",\"nama\":\"Basofit\",\"value\":\"sdsd\"},{\"type\":\"text\",\"name\":\"\",\"nama\":\"Limsofit\",\"value\":\"sdsd\"},{\"type\":\"text\",\"name\":\"\",\"nama\":\"Monosit\",\"value\":\"sdsd\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `jenis_hewan`
--

CREATE TABLE `jenis_hewan` (
  `id` int(11) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `kode` varchar(20) NOT NULL,
  `total_kunjungan` int(11) NOT NULL DEFAULT '0',
  `kunj_terakhir` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jenis_hewan`
--

INSERT INTO `jenis_hewan` (`id`, `nama`, `kode`, `total_kunjungan`, `kunj_terakhir`) VALUES
(4, 'Kucing', 'GK', 10, NULL),
(6, 'Ular', 'GC', 0, NULL),
(7, 'Anjing', 'GA', 4, '2018-02-02 00:00:00');

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
  `tipe_norek` varchar(250) DEFAULT 'GA',
  `norek` int(11) DEFAULT NULL,
  `temp_pemilik_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pasien`
--

INSERT INTO `pasien` (`id`, `nama`, `jk`, `tatto_chip`, `signalemen`, `lahir`, `total_kunjungan`, `kunj_terakhir`, `id_ras`, `tipe_norek`, `norek`, `temp_pemilik_id`) VALUES
(1, 'asas', 1, NULL, 'dsdsd', '2011-10-10', 0, NULL, 5, 'GA', 1, 33),
(6, 'sssd', 1, NULL, 'sdsd', '2018-10-02', 0, NULL, 5, 'GA', 2, 1),
(7, 'sss', 1, NULL, 'ssdsd', '2018-10-03', 0, NULL, 5, 'GC', 3, 3),
(61, 'sdsd', 0, 'sdsds', 'sdsd', '2010-06-11', 0, NULL, 4, 'GA', 4, NULL),
(62, 'sdsdsd', 0, 'sdsd', 'sdsd', '2014-10-09', 0, NULL, 5, 'GA', 5, NULL);

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
(23, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(24, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(25, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(26, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(27, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(28, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(29, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(30, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(31, 'P1', 'a', '09323', 1, '0000-00-00 00:00:00'),
(32, 'Jordan', 'Oesapa', 'sdsdsd', 1, NULL),
(33, 'Jordan', 'Oesapa', 'sdsdsd', 0, NULL),
(34, 'sdsdsd', 'sdsds', '', 1, '0000-00-00 00:00:00'),
(35, 'sdsdsd', 'sdsds', '', 1, '2018-11-01 00:00:00'),
(36, 'sdsdsd', 'sdsds', '', 1, '2018-11-01 00:00:00'),
(37, 'sdsdsd', 'sdsds', '', 1, '2018-11-01 00:00:00'),
(38, 'sdsd', 'sdsdsd', 'sdsdsd', 0, NULL),
(39, 'fhfhf', 'mmhmh', 'hthth', 0, NULL),
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
(58, 'Bai', 'Oepura', '', 0, NULL),
(59, 'sdsdsd', 'sdsd', 'sdsd', 0, NULL),
(60, 'Fino', 'Oesapa', '821989812', 0, NULL);

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
(18, 2, 51, 'sdsdsdsdsd dfdffd', 0, NULL),
(19, 3, 51, 'sdsd sdsd sd sdsd', 0, NULL);

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
(16, 41, '2018-11-07 17:12:00', 'llsj sksk skhs ', 3, 3, 'khkkh', 'RAWAT'),
(17, 51, '2018-10-10 08:00:00', 'Bagus', 3, 3, 'ssjk', 'RAWAT');

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
(5, 'C', 10, NULL, 4);

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
  `anamnesis` text COLLATE utf8mb4_unicode_ci,
  `keadaan_umum` text COLLATE utf8mb4_unicode_ci,
  `terapi` text COLLATE utf8mb4_unicode_ci,
  `norek` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rekam_medik`
--

INSERT INTO `rekam_medik` (`id`, `pasien_id`, `pemilik_id`, `penyakit_id`, `tanggal`, `berat`, `tipe_norek`, `freq_n`, `freq_p`, `freq_t`, `mth`, `mulut`, `kul_rambut`, `kelenjar_limfe`, `pernapasan`, `peredaran_darah`, `pencernaan`, `kelamin_perkencingan`, `ang_gerak`, `diagnosa`, `prognosis`, `anamnesis`, `keadaan_umum`, `terapi`, `norek`) VALUES
(48, 1, 58, NULL, '2019-08-10 00:41:39', 1.00000, NULL, 1.00000, 1.00000, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(50, 61, 59, 8, '2019-08-14 11:51:00', 10.00000, 'GA', 1.00000, 1.00000, 1, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '4'),
(51, 1, 32, 1, '2019-08-28 00:50:00', 1.00000, 'GA', 1.00000, 1.00000, 1, 'Ever since the Devil breathes\nMy steps never outweighed the gravity ov hell\nSo I keep praying for rain of flaming rocks\nTo foster the symmetry ov worlds\nI had a vision ov the impenetrable darkness\nNever found on either side ov the moon\nIt wields composure ov my soul\nThat comes as one with the odium below...', 'Chant the psalm\nNon serviam\nRetrieve the pride\nWithin and without', 'Odrzucam wszelki ład, wszelką ideę\nNie ufam żadnej abstrakcji, doktrynie\nNie wierzę ani w Boga, ani w Rozum!\nDość już tych Bogów! Dajcie mi człowieka!', 'Niech będzie, jak ja, mętny, niedojrzały\nNieukończony, ciemny i niejasny\nAbym z nim tańczył! Bawił się z nim! Z nim walczył\nPrzed nim udawał! Do niego się wdzięczył!', 'I jego gwałcił, w nim się kochał, na nim\nStwarzał się wciąż na nowo, nim rósł i tak rosnąc\nSam sobie dawał ślub w kościele ludzkim!\n\n', 'I imagined the most ardent ray ov sun\nLike vulture hovering above my neck\nIt burns with fever deep within my sou', 'Erect in gloria to sin(k) into shame\nOh Lord, whence came this doubt?\nThou doth know I am all and everything', '', '', '', '', '', '', '', '1'),
(52, 62, 60, 8, '2019-08-28 14:27:00', 1.00000, 'GA', 1.00000, 1.00000, 1, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '5');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `pemilik`
--
ALTER TABLE `pemilik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `penyakit`
--
ALTER TABLE `penyakit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `pen_khusus`
--
ALTER TABLE `pen_khusus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `perawatan`
--
ALTER TABLE `perawatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `ras`
--
ALTER TABLE `ras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `rekam_medik`
--
ALTER TABLE `rekam_medik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

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
