USE `pear`;

-- Dumpar struktur för tabell pear.users_characters
CREATE TABLE IF NOT EXISTS `users_characters` (
  `steamHex` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `characterId` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `firstname` varchar(150) COLLATE utf8mb4_bin NOT NULL,
  `lastname` varchar(150) COLLATE utf8mb4_bin NOT NULL,
  `dateofbirth` varchar(150) COLLATE utf8mb4_bin NOT NULL,
  `lastdigits` int(4) NOT NULL DEFAULT '0',
  `cash` bigint(20) NOT NULL DEFAULT '0',
  `bank` bigint(20) NOT NULL DEFAULT '0',
  `job` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'unemployed',
  `timeCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`characterId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

