
CREATE TABLE `SaStash` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `coords_props` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `Heading` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `props` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



ALTER TABLE `SaStash`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

ALTER TABLE `SaStash`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;








CREATE TABLE `SaStashIni` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `SaStashIni`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);


ALTER TABLE `SaStashIni`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;
