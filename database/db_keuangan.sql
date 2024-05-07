-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 07, 2024 at 08:25 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_keuangan`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `kode_automatis` (`kode` INT) RETURNS CHAR(7) CHARSET latin1 COLLATE latin1_swedish_ci  BEGIN
DECLARE kodebaru CHAR(7);
DECLARE urut INT;
 
SET urut = IF(kode IS NULL, 1, kode + 1);
SET kodebaru = CONCAT("TRX", LPAD(urut, 4, 0));
 
RETURN kodebaru;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `kode_automatis2` (`kode` INT) RETURNS CHAR(7) CHARSET latin1 COLLATE latin1_swedish_ci  BEGIN
DECLARE kodebaru CHAR(7);
DECLARE urut INT;
 
SET urut = IF(kode IS NULL, 1, kode + 1);
SET kodebaru = CONCAT("TRF", LPAD(urut, 4, 0));
 
RETURN kodebaru;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pemasukkan`
--

CREATE TABLE `pemasukkan` (
  `id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `keterangan` varchar(30) NOT NULL,
  `sumber` varchar(30) NOT NULL,
  `jumlah` varchar(250) NOT NULL,
  `username` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `pemasukkan`
--

INSERT INTO `pemasukkan` (`id`, `tanggal`, `keterangan`, `sumber`, `jumlah`, `username`) VALUES
(55, '2024-04-14', 'Bulanan', 'ATM', '4000000', 'cobauser1'),
(56, '2024-04-21', 'Freelance', 'Pekerjaan', '2500000', 'cobauser1'),
(57, '2024-04-09', 'shopee affiliate', 'Pekerjaan', '800000', 'cobauser1');

-- --------------------------------------------------------

--
-- Table structure for table `pengeluaran`
--

CREATE TABLE `pengeluaran` (
  `id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `keterangan` varchar(50) NOT NULL,
  `keperluan` varchar(30) NOT NULL,
  `jumlah` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `pengeluaran`
--

INSERT INTO `pengeluaran` (`id`, `tanggal`, `keterangan`, `keperluan`, `jumlah`, `username`) VALUES
(31, '2024-04-14', 'Skincare', 'Keperluan pribadi', '250000', 'cobauser1'),
(32, '2024-04-16', 'Beras', 'Makan dan Minum', '80000', 'cobauser1'),
(33, '2024-04-09', 'Token Listrik', 'Lain - lain', '150000', 'cobauser1'),
(34, '2024-04-16', 'Iuran UKM', 'Organisasi', '50000', 'cobauser1'),
(35, '2024-04-21', 'Kopi', 'Makan dan Minum', '25000', 'cobauser1'),
(36, '2024-04-17', 'Nabung', 'Lain - lain', '1000000', 'cobauser1'),
(37, '2024-04-08', 'tiket pesawat berangkat', 'Kendaraan', '500000', 'cobauser1');

-- --------------------------------------------------------

--
-- Table structure for table `rekening_keluar`
--

CREATE TABLE `rekening_keluar` (
  `id` int(11) NOT NULL,
  `kode` varchar(10) NOT NULL,
  `jumlah` varchar(255) NOT NULL,
  `aksi` varchar(10) NOT NULL DEFAULT 'keluar',
  `tanggal` date NOT NULL,
  `username` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `rekening_keluar`
--
DELIMITER $$
CREATE TRIGGER `tg_kodekeluar` BEFORE INSERT ON `rekening_keluar` FOR EACH ROW BEGIN
DECLARE s VARCHAR(8);
DECLARE i INTEGER;
 
SET i = (SELECT SUBSTRING(kode,4,4) AS Nomer
FROM rekening_keluar ORDER BY Nomer DESC LIMIT 1);
 
SET s = (SELECT kode_automatis2(i));
 
IF(NEW.kode IS NULL OR NEW.kode = '')
 THEN SET NEW.kode =s;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rekening_masuk`
--

CREATE TABLE `rekening_masuk` (
  `id` int(11) NOT NULL,
  `kode` varchar(10) NOT NULL,
  `jumlah` varchar(255) NOT NULL,
  `aksi` varchar(20) NOT NULL DEFAULT 'masuk',
  `tanggal` date NOT NULL,
  `username` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `rekening_masuk`
--
DELIMITER $$
CREATE TRIGGER `tg_kodemasuk` BEFORE INSERT ON `rekening_masuk` FOR EACH ROW BEGIN
DECLARE s VARCHAR(8);
DECLARE i INTEGER;
 
SET i = (SELECT SUBSTRING(kode,4,4) AS Nomer
FROM rekening_masuk ORDER BY Nomer DESC LIMIT 1);
 
SET s = (SELECT kode_automatis(i));
 
IF(NEW.kode IS NULL OR NEW.kode = '')
 THEN SET NEW.kode =s;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'aktif',
  `level` varchar(10) NOT NULL DEFAULT 'user',
  `no_rek` char(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `email`, `username`, `password`, `status`, `level`, `no_rek`) VALUES
(18, 'keuangancoba@gmail.com', 'userkeuangan1', '$2y$10$IA/5w9WSPIwRMap4vZOkyOXrl/YuNJRmx30Zncu0JYtOim9U3uv7K', 'aktif', 'user', '818334230925'),
(19, 'user1@gmail.com', 'cobauser1', '$2y$10$76sVevjmjWPcaf4gz8davORxlL.q00cDBjOrcx0qPhxUyqwg4frcW', 'aktif', 'user', '704656824737'),
(20, 'admin1@gmail.com', 'adminMA', '$2y$10$E5P2JdqHSFuYoZdTz47IY.tGobEMIBT1V2l698rr7Q4g7E/NdJT7.', 'aktif', 'user', '509690839236'),
(21, 'tasyauser@gmail.com', 'tasyacb1', '$2y$10$2Az50cMQx0LBEqucr3Y29.CM99T1TsnU3V.uTYRu4O81a2oo30raO', 'aktif', 'user', '675242807698'),
(22, 'userannastasya@gmail.com', 'annstsy', '$2y$10$VzmmqitIIAlYyNvvCh2S1.Se4/dwiItC9SNHuhOsBXET3vBm5K/8m', 'aktif', 'user', '135075023757');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pemasukkan`
--
ALTER TABLE `pemasukkan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_username_masuk` (`username`);

--
-- Indexes for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_username_keluar` (`username`);

--
-- Indexes for table `rekening_keluar`
--
ALTER TABLE `rekening_keluar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_username_rekening_keluar` (`username`);

--
-- Indexes for table `rekening_masuk`
--
ALTER TABLE `rekening_masuk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_username_rekening_masuk` (`username`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `username` (`username`),
  ADD KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pemasukkan`
--
ALTER TABLE `pemasukkan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `rekening_keluar`
--
ALTER TABLE `rekening_keluar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `rekening_masuk`
--
ALTER TABLE `rekening_masuk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pemasukkan`
--
ALTER TABLE `pemasukkan`
  ADD CONSTRAINT `fk_username_masuk` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD CONSTRAINT `fk_username_keluar` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rekening_keluar`
--
ALTER TABLE `rekening_keluar`
  ADD CONSTRAINT `fk_username_rekening_keluar` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rekening_masuk`
--
ALTER TABLE `rekening_masuk`
  ADD CONSTRAINT `fk_username_rekening_masuk` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
