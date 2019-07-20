USE `pear`;

-- Dumpar struktur för tabell pear.users_characters
CREATE TABLE IF NOT EXISTS `users_characters` (
  `characterId` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `firstname` varchar(150) COLLATE utf8mb4_bin NOT NULL,
  `lastname` varchar(150) COLLATE utf8mb4_bin NOT NULL,
  `dateofbirth` varchar(150) COLLATE utf8mb4_bin NOT NULL,
  `lastdigits` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`characterId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumpar data för tabell pear.users_characters: ~0 rows (ungefär)
/*!40000 ALTER TABLE `users_characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_characters` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
