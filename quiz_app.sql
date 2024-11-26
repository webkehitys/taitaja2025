-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 26.11.2024 klo 06:44
-- Palvelimen versio: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotelli`
--
CREATE DATABASE IF NOT EXISTS `hotelli` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hotelli`;

-- --------------------------------------------------------

--
-- Rakenne taululle `asiakkaat`
--

CREATE TABLE `asiakkaat` (
  `AsiakasId` int(11) NOT NULL,
  `kayttajanimi` varchar(15) NOT NULL,
  `Etunimi` varchar(25) NOT NULL,
  `Sukunimi` varchar(35) NOT NULL,
  `Lahiosoite` varchar(50) NOT NULL,
  `Postinumero` varchar(10) NOT NULL,
  `Postitoimipaikka` varchar(25) NOT NULL,
  `Salasana` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vedos taulusta `asiakkaat`
--

INSERT INTO `asiakkaat` (`AsiakasId`, `kayttajanimi`, `Etunimi`, `Sukunimi`, `Lahiosoite`, `Postinumero`, `Postitoimipaikka`, `Salasana`) VALUES
(1, 'antagent', 'Anton', 'Agentti', 'Piilokuja 34 a 11', '84210', 'Piilopirtti', '7qmKcsmh8yVsjDA+5AOF0A=='),
(2, 'jlindroos', 'Jyri', 'Lindroos', 'Keskikatu 3', '04200', 'Riihimäki', '7XC3nVsZ5MT2dQ3WDeWGSQ=='),
(3, 'sirlindr', 'Sirpa', 'Lindroos', 'Hallintokuja 33', '00520', 'Helsinki', 'uE8bxBrhYKEw0BQdz8mh7w=='),
(4, 'eeva.tervala', 'Eeva', 'Tervala', 'Keskikatu 3', '04200', 'Kerava', 'QWlnP9okKQsMD5MyFLlQXw=='),
(5, 'hanterva', 'Hannu', 'Tervala', 'Keskikatu 3', '04200', 'Kerava', 'EPoqlQ1yMitRo+VTr7G8nw==');

-- --------------------------------------------------------

--
-- Rakenne taululle `huoneet`
--

CREATE TABLE `huoneet` (
  `HuoneenNro` int(11) NOT NULL,
  `Huonetyyppi` int(11) DEFAULT NULL,
  `Puhelin` varchar(15) NOT NULL,
  `Vapaa` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vedos taulusta `huoneet`
--

INSERT INTO `huoneet` (`HuoneenNro`, `Huonetyyppi`, `Puhelin`, `Vapaa`) VALUES
(101, 1, '101', 'Ei'),
(102, 1, '102', 'Kyllä'),
(103, 1, '103', 'Kyllä'),
(104, 1, '104', 'Kyllä'),
(105, 1, '105', '1'),
(111, 2, '111', 'Kyllä'),
(112, 2, '112', 'Kyllä'),
(113, 2, '113', 'Kyllä'),
(114, 2, '114', 'Kyllä'),
(121, 3, '121', 'Kyllä'),
(122, 3, '122', 'Kyllä'),
(431, 4, '431', 'Kyllä'),
(432, 4, '432', 'Kyllä');

-- --------------------------------------------------------

--
-- Rakenne taululle `huonekategoria`
--

CREATE TABLE `huonekategoria` (
  `KategoriaId` int(11) NOT NULL,
  `Huonetyyppi` varchar(15) NOT NULL,
  `Hinta` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vedos taulusta `huonekategoria`
--

INSERT INTO `huonekategoria` (`KategoriaId`, `Huonetyyppi`, `Hinta`) VALUES
(1, 'Yhden hengen', 120),
(2, 'Kahden hengen', 90),
(3, 'Perhe', 150),
(4, 'Sviitti', 300);

-- --------------------------------------------------------

--
-- Rakenne taululle `varaukset`
--

CREATE TABLE `varaukset` (
  `VarausId` int(11) NOT NULL,
  `HuoneenNro` int(11) NOT NULL,
  `AsiakasId` int(11) NOT NULL,
  `Sisaan` datetime NOT NULL,
  `Ulos` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vedos taulusta `varaukset`
--

INSERT INTO `varaukset` (`VarausId`, `HuoneenNro`, `AsiakasId`, `Sisaan`, `Ulos`) VALUES
(8, 102, 2, '2020-12-06 00:00:00', '2020-12-09 00:00:00'),
(9, 103, 3, '2020-12-10 00:00:00', '2020-12-11 00:00:00'),
(10, 103, 3, '2020-12-10 00:00:00', '2020-12-11 00:00:00'),
(19, 101, 1, '2020-12-06 20:55:40', '2020-12-06 20:55:40'),
(20, 111, 2, '2020-12-31 00:00:00', '2021-01-01 00:00:00'),
(21, 122, 5, '2024-02-14 00:00:00', '2024-02-18 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `asiakkaat`
--
ALTER TABLE `asiakkaat`
  ADD PRIMARY KEY (`AsiakasId`);

--
-- Indexes for table `huoneet`
--
ALTER TABLE `huoneet`
  ADD PRIMARY KEY (`HuoneenNro`),
  ADD KEY `Huonetyyppi` (`Huonetyyppi`);

--
-- Indexes for table `huonekategoria`
--
ALTER TABLE `huonekategoria`
  ADD PRIMARY KEY (`KategoriaId`);

--
-- Indexes for table `varaukset`
--
ALTER TABLE `varaukset`
  ADD PRIMARY KEY (`VarausId`),
  ADD KEY `fk_huone` (`HuoneenNro`),
  ADD KEY `AsiakasId` (`AsiakasId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `asiakkaat`
--
ALTER TABLE `asiakkaat`
  MODIFY `AsiakasId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `huonekategoria`
--
ALTER TABLE `huonekategoria`
  MODIFY `KategoriaId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `varaukset`
--
ALTER TABLE `varaukset`
  MODIFY `VarausId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Rajoitteet vedostauluille
--

--
-- Rajoitteet taululle `huoneet`
--
ALTER TABLE `huoneet`
  ADD CONSTRAINT `huoneet_ibfk_1` FOREIGN KEY (`Huonetyyppi`) REFERENCES `huonekategoria` (`KategoriaId`);

--
-- Rajoitteet taululle `varaukset`
--
ALTER TABLE `varaukset`
  ADD CONSTRAINT `fk_asiakas` FOREIGN KEY (`AsiakasId`) REFERENCES `asiakkaat` (`AsiakasId`),
  ADD CONSTRAINT `fk_huone` FOREIGN KEY (`HuoneenNro`) REFERENCES `huoneet` (`HuoneenNro`),
  ADD CONSTRAINT `varaukset_ibfk_1` FOREIGN KEY (`AsiakasId`) REFERENCES `asiakkaat` (`AsiakasId`);
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

--
-- Vedos taulusta `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('root', '{\"angular_direct\":\"direct\",\"snap_to_grid\":\"off\",\"relation_lines\":\"true\"}');

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Vedos taulusta `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"quiz_app\",\"table\":\"questions\"},{\"db\":\"quiz_app\",\"table\":\"categories\"},{\"db\":\"quiz_app\",\"table\":\"scores\"},{\"db\":\"quiz_app\",\"table\":\"teachers\"},{\"db\":\"hotelli\",\"table\":\"asiakkaat\"}]');

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Vedos taulusta `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2024-11-26 05:43:46', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"fi\"}');

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Rakenne taululle `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `quiz_app`
--
CREATE DATABASE IF NOT EXISTS `quiz_app` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `quiz_app`;

-- --------------------------------------------------------

--
-- Rakenne taululle `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `teacher_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vedos taulusta `categories`
--

INSERT INTO `categories` (`id`, `name`, `teacher_id`) VALUES
(1, 'Historia', 1),
(2, 'Maantiede', 1),
(3, 'Urheilu', 1),
(4, 'Tiede', 1),
(5, 'Taide ja viihde', 1),
(6, 'Historia', 2),
(7, 'Maantiede', 2),
(8, 'Urheilu', 2),
(9, 'PHP', 2),
(10, 'Vapaa-aika', 2),
(11, 'testi', 2),
(12, 'testus', 2);

-- --------------------------------------------------------

--
-- Rakenne taululle `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `question` text NOT NULL,
  `option_a` varchar(255) NOT NULL,
  `option_b` varchar(255) NOT NULL,
  `option_c` varchar(255) NOT NULL,
  `option_d` varchar(255) NOT NULL,
  `correct_option` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vedos taulusta `questions`
--

INSERT INTO `questions` (`id`, `category_id`, `teacher_id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_option`) VALUES
(1, 1, 1, 'Kuka oli ensimmäinen Yhdysvaltain presidentti?', 'George Washington', 'Thomas Jefferson', 'Abraham Lincoln', 'John Adams', 'A'),
(2, 1, 1, 'Missä vuonna Titanic upposi Atlantilla?', '1905', '1912', '1921', '1930', 'B'),
(3, 1, 1, 'Kuka hallitsi Ranskaa suuren osan 1800-lukua?', 'Ludvig XIV', 'Napoleon Bonaparte', 'Henrik V', 'Charles de Gaulle', 'B'),
(4, 1, 1, 'Kuka oli Neuvostoliiton ensimmäinen johtaja?', 'Vladimir Lenin', 'Josif Stalin', 'Leonid Brežnev', 'Nikita Hruštšov', 'A'),
(5, 1, 1, 'Missä vuonna Berliinin muuri murtui?', '1987', '1989', '1991', '1993', 'B'),
(6, 1, 1, 'Kuka oli Englannin kuningatar, joka hallitsi viktoriaanisella ajalla?', 'Kuningatar Viktoria', 'Kuningatar Elisabet I', 'Kuningatar Mary', 'Kuningatar Anne', 'A'),
(7, 1, 1, 'Missä sodassa käytiin kuuluisa Normandian maihinnousu?', 'Ensimmäinen maailmansota', 'Toinen maailmansota', 'Korean sota', 'Vietnamin sota', 'B'),
(8, 1, 1, 'Kuka oli viimeinen farao muinaisessa Egyptissä?', 'Tutankhamon', 'Ramses II', 'Cleopatra', 'Akhenaten', 'C'),
(9, 1, 1, 'Mikä oli ensimmäisen maailmansodan pääasiallinen syy?', 'Saksan ja Ranskan välinen konflikti', 'Assassinaatio Sarajevossa', 'Britannian ja Saksan kilpailu', 'Venäjän vallankumous', 'B'),
(10, 1, 1, 'Missä maassa alkoi teollinen vallankumous?', 'Yhdysvallat', 'Ranska', 'Britannia', 'Saksa', 'C'),
(11, 2, 1, 'Mikä on maailman suurin valtameri?', 'Atlantin valtameri', 'Tyynimeri', 'Intian valtameri', 'Jäämeri', 'B'),
(12, 2, 1, 'Mikä on maailman suurin aavikko?', 'Sahara', 'Arabian aavikko', 'Gobi', 'Kalahari', 'A'),
(13, 2, 1, 'Missä maassa sijaitsee Amazon-joki?', 'Kolumbia', 'Peru', 'Brasilia', 'Venezuela', 'C'),
(14, 2, 1, 'Mikä on maailman pienin maa pinta-alaltaan?', 'Vatikaanivaltio', 'Monaco', 'San Marino', 'Liechtenstein', 'A'),
(15, 2, 1, 'Mikä on Australian suurin kaupunki?', 'Sydney', 'Melbourne', 'Brisbane', 'Canberra', 'A'),
(16, 2, 1, 'Missä maassa Machu Picchu sijaitsee?', 'Meksiko', 'Peru', 'Chile', 'Kolumbia', 'B'),
(17, 2, 1, 'Mikä valtio omistaa Grönlannin?', 'Islanti', 'Norja', 'Tanska', 'Ruotsi', 'C'),
(18, 2, 1, 'Mikä on Yhdysvaltain pisin joki?', 'Mississippi', 'Missouri', 'Colorado', 'Ohio', 'B'),
(19, 2, 1, 'Mikä on Etelä-Afrikan pääkaupunki?', 'Pretoria', 'Cape Town', 'Johannesburg', 'Durban', 'A'),
(20, 2, 1, 'Missä maassa Eiffel-torni sijaitsee?', 'Espanja', 'Italia', 'Ranska', 'Saksa', 'C'),
(21, 3, 1, 'Kuka on voittanut eniten Grand Slam -turnauksia tenniksessä (miehet)?', 'Roger Federer', 'Rafael Nadal', 'Novak Djokovic', 'Pete Sampras', 'C'),
(22, 3, 1, 'Missä maassa pidettiin ensimmäiset modernit olympialaiset vuonna 1896?', 'Ranska', 'Kreikka', 'Iso-Britannia', 'Italia', 'B'),
(23, 3, 1, 'Mikä maa voitti jalkapallon maailmanmestaruuden vuonna 2018?', 'Brasilia', 'Saksa', 'Argentiina', 'Ranska', 'D'),
(24, 3, 1, 'Kuinka monta pelaajaa on koripallojoukkueessa kentällä kerrallaan?', '5', '6', '7', '8', 'A'),
(25, 3, 1, 'Kuka on tunnettu \"Jäämies\" F1-kuljettajana?', 'Michael Schumacher', 'Lewis Hamilton', 'Kimi Räikkönen', 'Sebastian Vettel', 'C'),
(26, 3, 1, 'Kuinka monta kultamitalia Michael Phelps voitti Pekingin olympialaisissa 2008?', '6', '7', '8', '9', 'C'),
(27, 3, 1, 'Kuka voitti ensimmäisen Tour de Francen?', 'Maurice Garin', 'Eddy Merckx', 'Bernard Hinault', 'Lance Armstrong', 'A'),
(28, 3, 1, 'Missä maassa järjestettiin vuoden 2010 jalkapallon MM-kisat?', 'Saksa', 'Etelä-Afrikka', 'Brasilia', 'Venäjä', 'B'),
(29, 3, 1, 'Kuka koripalloilija tunnetaan lempinimellä \"King James\"?', 'Michael Jordan', 'LeBron James', 'Kobe Bryant', 'Shaquille O\'Neal', 'B'),
(30, 3, 1, 'Mikä maa on voittanut eniten kriketin maailmanmestaruuksia?', 'Australia', 'Englanti', 'Intia', 'Pakistan', 'A'),
(31, 4, 1, 'Mikä alkuaine on kemialliselta merkiltään H?', 'Happi', 'Helium', 'Vety', 'Kloori', 'C'),
(32, 4, 1, 'Kuka kehitti yleisen suhteellisuusteorian?', 'Albert Einstein', 'Isaac Newton', 'Niels Bohr', 'Galileo Galilei', 'A'),
(33, 4, 1, 'Mikä on ihmiskehon suurin elin?', 'Aivot', 'Iho', 'Maksa', 'Sydän', 'B'),
(34, 4, 1, 'Mikä planeetta tunnetaan punaisena planeettana?', 'Venus', 'Mars', 'Jupiter', 'Saturnus', 'B'),
(35, 4, 1, 'Mikä on veden kemiallinen kaava?', 'H2', 'O2', 'CO2', 'H2O', 'D'),
(36, 4, 1, 'Mikä yksikkö on voiman SI-yksikkö?', 'Joule', 'Watti', 'Newton', 'Ohmi', 'C'),
(37, 4, 1, 'Kuka on DNA:n kaksoiskierremallin löytäjä yhdessä James Watsonin kanssa?', 'Rosalind Franklin', 'Francis Crick', 'Erwin Schrödinger', 'Linus Pauling', 'B'),
(38, 4, 1, 'Mikä eläin on nisäkästen joukossa ainutlaatuinen munimisensa vuoksi?', 'Nokkonokkaeläin', 'Piikkisika', 'Vyötiäinen', 'Koala', 'A'),
(39, 4, 1, 'Mikä on valon nopeus tyhjiössä?', '300,000 km/s', '150,000 km/s', '500,000 km/s', '1,000,000 km/s', 'A'),
(40, 4, 1, 'Kuka tunnetaan evoluutioteorian isänä?', 'Charles Darwin', 'Gregor Mendel', 'James Watson', 'Louis Pasteur', 'A'),
(41, 5, 1, 'Kuka ohjasi elokuvan \"Titanic\"?', 'Steven Spielberg', 'Martin Scorsese', 'James Cameron', 'George Lucas', 'C'),
(42, 5, 1, 'Mikä yhtye levytti kappaleen \"Hey Jude\"?', 'The Beatles', 'The Rolling Stones', 'The Who', 'Led Zeppelin', 'A'),
(43, 5, 1, 'Kuka näytteli pääroolin elokuvassa \"Forrest Gump\"?', 'Tom Hanks', 'Leonardo DiCaprio', 'Matt Damon', 'Brad Pitt', 'A'),
(44, 5, 1, 'Kuka sävelsi teoksen \"Eine kleine Nachtmusik\"?', 'Ludwig van Beethoven', 'Wolfgang Amadeus Mozart', 'Johann Sebastian Bach', 'Franz Schubert', 'B'),
(45, 5, 1, 'Mikä maalaus tunnetaan nimellä \"Mona Lisa\"?', 'The Scream', 'Starry Night', 'The Persistence of Memory', 'Mona Lisa', 'D'),
(46, 5, 1, 'Kuka on Harry Potter -kirjasarjan kirjoittaja?', 'J.K. Rowling', 'J.R.R. Tolkien', 'C.S. Lewis', 'George R.R. Martin', 'A'),
(47, 5, 1, 'Kuka tunnetaan maalaustaiteen \"Kuutamosonaatti\" säveltäjänä?', 'Frédéric Chopin', 'Johann Sebastian Bach', 'Ludwig van Beethoven', 'Wolfgang Amadeus Mozart', 'C'),
(48, 5, 1, 'Mikä elokuva voitti parhaan elokuvan Oscarin vuonna 2020?', '1917', 'Joker', 'Parasite', 'Once Upon a Time in Hollywood', 'C'),
(49, 5, 1, 'Kuka näytteli Iron Mania Marvelin elokuvasarjassa?', 'Robert Downey Jr.', 'Chris Evans', 'Chris Hemsworth', 'Mark Ruffalo', 'A'),
(50, 5, 1, 'Kuka on laulanut kappaleen \"Thriller\"?', 'Michael Jackson', 'Prince', 'Elton John', 'Stevie Wonder', 'A'),
(51, 6, 2, 'Missä kaupungissa Julius Caesar murhattiin?', 'Ateena', 'Rooma', 'Kartago', 'Aleksandria', 'B'),
(52, 6, 2, 'Kuka oli Ranskan viimeinen kuningas ennen Ranskan vallankumousta?', 'Ludvig XIV', 'Ludvig XV', 'Ludvig XVI', 'Napoleon', 'C'),
(53, 6, 2, 'Kuka oli tunnettu kuningatar Englannissa 1500-luvulla?', 'Elisabet I', 'Maria I', 'Viktoria', 'Anna', 'A'),
(54, 6, 2, 'Kuka johti Neuvostoliittoa toisen maailmansodan aikana?', 'Lenin', 'Trotski', 'Stalin', 'Hruštšov', 'C'),
(55, 6, 2, 'Mikä valtio hyökkäsi Puolaan vuonna 1939 aloittaen toisen maailmansodan?', 'Italia', 'Japani', 'Saksa', 'Neuvostoliitto', 'C'),
(56, 6, 2, 'Missä maassa tapahtui Teekutsujen kapina vuonna 1773?', 'Kanada', 'Yhdysvallat', 'Iso-Britannia', 'Ranska', 'B'),
(57, 6, 2, 'Kuka oli kuuluisa Kreikan sodan jumala?', 'Zeus', 'Apollo', 'Ares', 'Hermes', 'C'),
(58, 6, 2, 'Kuka oli kuuluisin farao muinaisessa Egyptissä?', 'Cleopatra', 'Tutankhamon', 'Ramses II', 'Akhenaten', 'B'),
(59, 6, 2, 'Kuka perusti Mongolivaltakunnan?', 'Kublai-kaani', 'Tamerlane', 'Genghis-kaani', 'Attila', 'C'),
(60, 6, 2, 'Missä vuosisadalla Yhdysvallat itsenäistyi?', '1600-luku', '1700-luku', '1800-luku', '1900-luku', 'B'),
(61, 6, 2, 'Kuka oli ensimmäinen Britannian kuningatar, joka hallitsi omissa nimissään?', 'Mary I', 'Elizabeth I', 'Victoria', 'Anne', 'A'),
(62, 6, 2, 'Missä kaupungissa perustettiin Yhdistyneet kansakunnat?', 'Washington D.C.', 'New York', 'San Francisco', 'Lontoo', 'C'),
(63, 6, 2, 'Mikä valtakunta tunnettiin nimellä \"Rooman vihollinen\"?', 'Egypti', 'Persia', 'Karthago', 'Kreikka', 'C'),
(64, 6, 2, 'Missä vuonna Bastilji valloitettiin Ranskan vallankumouksessa?', '1789', '1792', '1804', '1815', 'A'),
(65, 6, 2, 'Kuka oli kuuluisa matemaatikko ja fyysikko, joka keksi painovoiman?', 'Albert Einstein', 'Isaac Newton', 'Galileo Galilei', 'Nikola Tesla', 'B'),
(66, 6, 2, 'Missä vuonna Napoleon hävisi Waterloon taistelun?', '1805', '1812', '1815', '1821', 'C'),
(67, 6, 2, 'Mikä maa oli osa Kolmivaltaliittoa toisen maailmansodan aikana?', 'Ranska', 'Italia', 'Yhdysvallat', 'Kiina', 'B'),
(68, 6, 2, 'Missä vuonna avaruusajan katsotaan alkaneen Sputnikin laukaisulla?', '1953', '1957', '1961', '1969', 'B'),
(69, 6, 2, 'Mikä Egyptin faarao tunnetaan parhaiten hautakammionsa aarteista?', 'Cleopatra', 'Tutankhamon', 'Ramses II', 'Akhenaten', 'B'),
(70, 6, 2, 'Kuka oli Rooman valtakunnan ensimmäinen keisari?', 'Julius Caesar', 'Augustus', 'Nero', 'Caligula', 'B'),
(71, 7, 2, 'Missä maassa on eniten saaristoa?', 'Kanada', 'Norja', 'Filippiinit', 'Indonesia', 'A'),
(72, 7, 2, 'Mikä joki on pisin Etelä-Amerikassa?', 'Niili', 'Mississippi', 'Amazon', 'Mekong', 'C'),
(73, 7, 2, 'Mikä valtio on maailman tiheimmin asuttu?', 'Intia', 'Bangladesh', 'Kiina', 'Monaco', 'D'),
(74, 7, 2, 'Mikä on Euroopan pisin joki?', 'Tajo', 'Tonava', 'Volga', 'Elbe', 'C'),
(75, 7, 2, 'Mikä vuori on korkein Afrikassa?', 'Kilimanjaro', 'Everest', 'Elbrus', 'Aconcagua', 'A'),
(76, 7, 2, 'Mikä meri sijaitsee Italian länsipuolella?', 'Välimeri', 'Adrianmeri', 'Ionianmeri', 'Tyrrhenanmeri', 'D'),
(77, 7, 2, 'Missä maassa on eniten järviä maailmassa?', 'Suomi', 'Venäjä', 'Kanada', 'Yhdysvallat', 'C'),
(78, 7, 2, 'Mikä on Aasian suurin saari?', 'Sri Lanka', 'Sumatra', 'Honshu', 'Borneo', 'D'),
(79, 7, 2, 'Mikä on Australian pisin joki?', 'Murray', 'Darling', 'Swan', 'Lachlan', 'A'),
(80, 7, 2, 'Mikä on Islannin pääkaupunki?', 'Helsinki', 'Oslo', 'Reykjavik', 'Tukholma', 'C'),
(81, 7, 2, 'Mikä on maailman syvin järvi?', 'Baikal', 'Tanganjika', 'Kaspianmeri', 'Victoria', 'A'),
(82, 7, 2, 'Missä valtiossa sijaitsee Gizan suuri pyramidi?', 'Israel', 'Egypti', 'Jordania', 'Libanon', 'B'),
(83, 7, 2, 'Mikä on suurin valtio pinta-alaltaan?', 'Yhdysvallat', 'Kiina', 'Venäjä', 'Kanada', 'C'),
(84, 7, 2, 'Missä maassa on Machu Picchu?', 'Chile', 'Peru', 'Bolivia', 'Argentiina', 'B'),
(85, 7, 2, 'Mikä joki virtaa Pariisin läpi?', 'Rein', 'Seine', 'Tajo', 'Rhone', 'B'),
(86, 7, 2, 'Mikä valtameri ympäröi Japania?', 'Atlantti', 'Intian valtameri', 'Tyynimeri', 'Jäämeri', 'C'),
(87, 7, 2, 'Mikä on Yhdysvaltain pääkaupunki?', 'New York', 'Los Angeles', 'Washington D.C.', 'Chicago', 'C'),
(88, 7, 2, 'Mikä on maailman korkein vesiputous?', 'Iguazu-putoukset', 'Niagara-putoukset', 'Victoria-putoukset', 'Angel-putoukset', 'D'),
(89, 7, 2, 'Mikä maa on kuuluisa tulivuorestaan Fuji?', 'Kiina', 'Etelä-Korea', 'Japani', 'Thaimaa', 'C'),
(90, 7, 2, 'Mikä meri sijaitsee Saudi-Arabian länsipuolella?', 'Punainen meri', 'Välimeri', 'Persianlahti', 'Kaspianmeri', 'A'),
(91, 7, 2, 'Mikä valtio tunnetaan nimellä \"nousevan auringon maa\"?', 'Kiina', 'Etelä-Korea', 'Japani', 'Thaimaa', 'C'),
(92, 7, 2, 'Mikä on maailman kolmanneksi suurin valtameri?', 'Intian valtameri', 'Tyynimeri', 'Atlantti', 'Jäämeri', 'A'),
(93, 7, 2, 'Missä maassa sijaitsee Iguazu-putoukset?', 'Peru', 'Argentiina', 'Brasilia', 'Chile', 'C'),
(94, 7, 2, 'Mikä on Kreikan pääkaupunki?', 'Ateena', 'Rooma', 'Sofia', 'Istanbul', 'A'),
(95, 7, 2, 'Mikä joki virtaa Lontoon läpi?', 'Seine', 'Rhone', 'Thames', 'Elbe', 'C'),
(96, 7, 2, 'Mikä vuoristo sijaitsee Euroopan ja Aasian rajalla?', 'Kalliovuoret', 'Andit', 'Himalaja', 'Uralvuoret', 'D'),
(97, 7, 2, 'Mikä maa tunnetaan nimellä tulimainen maa?', 'Chile', 'Argentiina', 'Peru', 'Bolivia', 'A'),
(98, 7, 2, 'Mikä on maailman suurin trooppinen sademetsä?', 'Kongo', 'Amazon', 'Sundarbans', 'Valdivian sademetsä', 'B'),
(99, 7, 2, 'Mikä on maailman korkein saari?', 'Malesia', 'Sumatra', 'Borneo', 'Uusi-Guinea', 'D'),
(100, 7, 2, 'Mikä valtio omistaa suurimman osan Himalajaa?', 'Nepal', 'Bhutan', 'Intia', 'Kiina', 'C'),
(111, 6, 2, 'Testikysymys', '1', '2', '3', '4', 'A');

-- --------------------------------------------------------

--
-- Rakenne taululle `scores`
--

CREATE TABLE `scores` (
  `id` int(11) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `score` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vedos taulusta `scores`
--

INSERT INTO `scores` (`id`, `student_name`, `category_id`, `teacher_id`, `score`, `date`) VALUES
(1, 'Jyri', 6, 2, 1, '2024-11-12 04:44:10'),
(2, 'Jyri', 6, 2, 5, '2024-11-12 04:46:28'),
(3, 'Jyri', 6, 2, 5, '2024-11-12 04:46:46'),
(4, 'Jyri', 6, 2, 3, '2024-11-12 05:01:06'),
(5, 'Jyri', 6, 2, 5, '2024-11-12 05:03:10'),
(6, 'Jyri', 7, 2, 1, '2024-11-12 05:07:04'),
(7, 'Jyri', 4, 1, 3, '2024-11-12 05:17:16'),
(8, 'Jyri', 7, 2, 0, '2024-11-12 05:20:22'),
(9, 'Jyri', 6, 2, 6, '2024-11-12 06:44:05'),
(10, 'Jyri', 6, 2, 2, '2024-11-12 09:14:20'),
(11, 'Jyri', 1, 1, 3, '2024-11-12 10:37:48'),
(12, 'Jyri', 6, 2, 6, '2024-11-12 11:15:29'),
(13, 'Jyri', 3, 1, 3, '2024-11-12 11:39:41'),
(14, 'Jyri', 1, 1, 3, '2024-11-18 08:03:52'),
(15, 'Jyri', 7, 2, 4, '2024-11-18 08:48:37'),
(16, 'Jyri', 1, 1, 3, '2024-11-19 07:39:47'),
(17, 'Jyri', 5, 1, 8, '2024-11-19 08:47:52'),
(18, 'Jyri', 4, 1, 4, '2024-11-19 08:50:36'),
(19, 'Jyri', 7, 2, 4, '2024-11-19 09:03:57'),
(20, 'Jyri', 7, 2, 2, '2024-11-19 09:08:49'),
(21, 'Jyri', 6, 2, 3, '2024-11-19 13:12:06'),
(22, 'Jyri', 6, 2, 6, '2024-11-20 08:07:07'),
(23, 'Jyri', 7, 2, 2, '2024-11-20 08:15:54'),
(24, 'Jyri', 6, 2, 6, '2024-11-20 09:51:56'),
(25, 'sl', 3, 1, 4, '2024-11-20 14:55:44'),
(26, 'Jyri', 6, 2, 2, '2024-11-24 14:02:20'),
(27, 'Jyri', 6, 2, 2, '2024-11-24 14:02:23'),
(28, 'Jyri', 6, 2, 5, '2024-11-24 14:14:06');

-- --------------------------------------------------------

--
-- Rakenne taululle `teachers`
--

CREATE TABLE `teachers` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vedos taulusta `teachers`
--

INSERT INTO `teachers` (`id`, `username`, `password_hash`) VALUES
(1, 'Oulevi Opettaja', 'Salasana'),
(2, 'Jyri Lindroos', '$2y$10$bRtqNYay./ZXjimcgaIcQetpPBKOJQpY9QGQj3BlemRGH5sGT4QEu');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_id` (`teacher_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `teacher_id` (`teacher_id`);

--
-- Indexes for table `scores`
--
ALTER TABLE `scores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `scores`
--
ALTER TABLE `scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Rajoitteet vedostauluille
--

--
-- Rajoitteet taululle `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`);

--
-- Rajoitteet taululle `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `questions_ibfk_2` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`);

--
-- Rajoitteet taululle `scores`
--
ALTER TABLE `scores`
  ADD CONSTRAINT `scores_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`),
  ADD CONSTRAINT `scores_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
