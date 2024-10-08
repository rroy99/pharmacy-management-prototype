/*
SQLyog Community v13.1.7 (64 bit)
MySQL - 10.4.28-MariaDB : Database - dbapotek
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dbapotek` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `dbapotek`;

/*Table structure for table `apoteker` */

DROP TABLE IF EXISTS `apoteker`;

CREATE TABLE `apoteker` (
  `idapoteker` char(10) NOT NULL,
  `namaapoteker` varchar(30) DEFAULT NULL,
  `jeniskelamin` varchar(30) DEFAULT NULL,
  `tempatlahir` varchar(30) DEFAULT NULL,
  `tanggallahir` date DEFAULT NULL,
  `alamat` varchar(30) DEFAULT NULL,
  `nohp` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idapoteker`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `apoteker` */

insert  into `apoteker`(`idapoteker`,`namaapoteker`,`jeniskelamin`,`tempatlahir`,`tanggallahir`,`alamat`,`nohp`,`email`) values 
('101','susi s.farm','Perempuan','padang','2002-06-17','padang','tiban','0823467851277'),
('102','tuti s.farm','Perempuan','manado','2003-01-15','manado','marina','08365465645');

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `idcustomer` char(10) NOT NULL,
  `namacustomer` varchar(50) DEFAULT NULL,
  `jeniskelamin` varchar(20) DEFAULT NULL,
  `tanggallahir` date DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `nohp` varchar(12) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idcustomer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `customer` */

insert  into `customer`(`idcustomer`,`namacustomer`,`jeniskelamin`,`tanggallahir`,`alamat`,`nohp`,`email`) values 
('001','roy','Laki-Laki','1999-02-28','sekupang','082344511197','roy@gmail.com'),
('002','robin','Laki-Laki','2000-01-20','tiban','089927664576','robin@gmaill.com'),
('003','nur','Perempuan','2001-01-14','bengkong','082344585691','nur@gmail.com'),
('004','tina','Perempuan','2002-01-19','patam','084543362266','tina@gmail.com'),
('005','sindi','Perempuan','2024-01-01','baloi','083565356767','sindi@gmail.com');

/*Table structure for table `obat` */

DROP TABLE IF EXISTS `obat`;

CREATE TABLE `obat` (
  `kodeobat` char(10) NOT NULL,
  `namaobat` varchar(20) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL,
  `hargajual` int(11) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `tglproduksi` date DEFAULT NULL,
  `tglexpired` date DEFAULT NULL,
  PRIMARY KEY (`kodeobat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `obat` */

insert  into `obat`(`kodeobat`,`namaobat`,`harga`,`hargajual`,`stock`,`type`,`tglproduksi`,`tglexpired`) values 
('01A','PANADOL',12000,15000,150,'PACK','2023-01-05','2024-01-13'),
('01B','KOMIX',13000,16000,100,'PACK','2024-01-04','2025-01-03');

/*Table structure for table `penjualan` */

DROP TABLE IF EXISTS `penjualan`;

CREATE TABLE `penjualan` (
  `idpenjualan` int(11) NOT NULL AUTO_INCREMENT,
  `tglpenjualan` date DEFAULT NULL,
  `penjualan_idcustomer` char(10) DEFAULT NULL,
  `penjualan_idapoteker` char(10) DEFAULT NULL,
  `penjualan_kodeobat` char(10) DEFAULT NULL,
  `penjualan_jumlah` int(11) DEFAULT NULL,
  `penjualan_totalbayar` int(11) DEFAULT NULL,
  PRIMARY KEY (`idpenjualan`),
  KEY `po_idcustomer` (`penjualan_idcustomer`),
  KEY `po_idapoteker` (`penjualan_idapoteker`),
  KEY `po_kodeobat` (`penjualan_kodeobat`),
  CONSTRAINT `penjualan_ibfk_1` FOREIGN KEY (`penjualan_idcustomer`) REFERENCES `customer` (`idcustomer`),
  CONSTRAINT `penjualan_ibfk_2` FOREIGN KEY (`penjualan_idapoteker`) REFERENCES `apoteker` (`idapoteker`),
  CONSTRAINT `penjualan_ibfk_3` FOREIGN KEY (`penjualan_kodeobat`) REFERENCES `obat` (`kodeobat`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `penjualan` */

insert  into `penjualan`(`idpenjualan`,`tglpenjualan`,`penjualan_idcustomer`,`penjualan_idapoteker`,`penjualan_kodeobat`,`penjualan_jumlah`,`penjualan_totalbayar`) values 
(32,'2024-01-16','001','101','01A',10,150000),
(33,'2024-01-16','004','101','01A',10,150000),
(34,'2024-01-17','004','101','01A',20,150000),
(35,'2024-01-16','001','102','01A',5,75000);

/*Table structure for table `po` */

DROP TABLE IF EXISTS `po`;

CREATE TABLE `po` (
  `idorder` int(11) NOT NULL AUTO_INCREMENT,
  `tglpo` date DEFAULT NULL,
  `po_idsupplier` char(10) DEFAULT NULL,
  `po_idapoteker` char(10) DEFAULT NULL,
  `po_kodeobat` char(10) DEFAULT NULL,
  `po_jumlah` int(11) DEFAULT NULL,
  `po_totalbayar` int(11) DEFAULT NULL,
  PRIMARY KEY (`idorder`),
  KEY `penjualan_idsupplier` (`po_idsupplier`),
  KEY `penjualan_idapoteker` (`po_idapoteker`),
  KEY `penjualan_kodeobat` (`po_kodeobat`),
  CONSTRAINT `po_ibfk_1` FOREIGN KEY (`po_idsupplier`) REFERENCES `supplier` (`idsupplier`),
  CONSTRAINT `po_ibfk_2` FOREIGN KEY (`po_idapoteker`) REFERENCES `apoteker` (`idapoteker`),
  CONSTRAINT `po_ibfk_3` FOREIGN KEY (`po_kodeobat`) REFERENCES `obat` (`kodeobat`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `po` */

insert  into `po`(`idorder`,`tglpo`,`po_idsupplier`,`po_idapoteker`,`po_kodeobat`,`po_jumlah`,`po_totalbayar`) values 
(5,'2024-01-16','201','101','01A',6,90000),
(6,'2024-01-16','201','101','01A',40,600000),
(7,'2024-01-16','201','101','01A',10,150000),
(8,'2024-01-16','201','102','01A',5,60000),
(9,'2024-01-16','201','102','01A',5,60000),
(10,'2024-01-16','201','102','01A',5,60000),
(11,'2024-01-16','201','102','01B',30,390000);

/*Table structure for table `supplier` */

DROP TABLE IF EXISTS `supplier`;

CREATE TABLE `supplier` (
  `idsupplier` char(10) NOT NULL,
  `namasupplier` varchar(30) DEFAULT NULL,
  `alamatsupplier` varchar(30) DEFAULT NULL,
  `teleponsupplier` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idsupplier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `supplier` */

insert  into `supplier`(`idsupplier`,`namasupplier`,`alamatsupplier`,`teleponsupplier`) values 
('201','PT ENSEVAL TBK','BATAM CENTER','0222333667');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`) values 
(1,'roy','12345'),
(2,'robin','123'),
(4,'cuy','666'),
(5,'bro','111'),
(6,'bray','333'),
(7,'pak luki','3333'),
(8,'sohib','555'),
(9,'pren','777'),
(10,'roland','888');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
