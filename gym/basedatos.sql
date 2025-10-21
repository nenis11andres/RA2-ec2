-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 08-05-2025 a las 21:12:01
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Base de datos: `gymnasio`
--
CREATE DATABASE IF NOT EXISTS `gymnasio` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `gymnasio`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividad`
--

CREATE TABLE `actividad` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `actividad`
--

INSERT INTO `actividad` (`id`, `nombre`) VALUES
(1, 'Spinning'),
(2, 'Yoga'),
(3, 'Pilates'),
(4, 'Zumba'),
(5, 'Baile'),
(6, 'Aquaeróbic'),
(7, 'Entrenamiento funcional'),
(8, 'CrossFit');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clase`
--

CREATE TABLE `clase` (
  `id` int(11) NOT NULL,
  `actividad_id` int(11) DEFAULT NULL,
  `dia` varchar(255) NOT NULL,
  `hora` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clase`
--

INSERT INTO `clase` (`id`, `actividad_id`, `dia`, `hora`) VALUES
(1, 1, 'lunes', 9),
(2, 1, 'Martes', 10),
(3, 1, 'lunes', 19),
(4, 1, 'Martes', 20),
(5, 1, 'Miércoles', 9),
(6, 1, 'Miércoles', 19),
(7, 1, 'Jueves', 10),
(8, 1, 'Jueves', 20),
(9, 1, 'Viernes', 8),
(10, 1, 'Viernes', 18),
(11, 2, 'Lunes', 10),
(12, 2, 'Lunes', 16),
(13, 2, 'Martes', 12),
(14, 2, 'Martes', 18),
(15, 2, 'Miércoles', 8),
(16, 2, 'Miércoles', 18),
(17, 2, 'Jueves', 10),
(18, 2, 'Jueves', 16),
(19, 2, 'Viernes', 12),
(20, 2, 'Viernes', 18),
(21, 8, 'lunes', 16),
(22, 3, 'viernes', 10),
(23, 6, 'jueves', 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20250506184917', '2025-05-06 18:49:23', 90);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE `reserva` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `clase_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `reserva`
--

INSERT INTO `reserva` (`id`, `usuario_id`, `clase_id`) VALUES
(1, 1, 7),
(2, 2, 9),
(5, 1, 22),
(6, 1, 23),
(7, 2, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(180) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`roles`)),
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `username`, `roles`, `password`) VALUES
(1, 'pepe', '[]', '$2y$13$AMgKt.ug1JamEtxftjaMh.YZ2OtNHjIKX.E8HzQrPfVWWIuEaJ3/.'),
(2, 'ana', '[]', '$2y$13$vfEsxC7M.3aL4hEoO0I.Q.z3GMkhYjfAEHC2ByXkoZpAJh.lyMc7m'),
(3, 'juan', '[]', '$2y$13$SwbpZZ2iT7jLmMcucY1j7uZnw6oe6B3hJq5U/L2Q5FEZjC77uz.cq');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividad`
--
ALTER TABLE `actividad`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clase`
--
ALTER TABLE `clase`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_199FACCE6014FACA` (`actividad_id`);

--
-- Indices de la tabla `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indices de la tabla `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Indices de la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_188D2E3BDB38439E` (`usuario_id`),
  ADD KEY `IDX_188D2E3B9F720353` (`clase_id`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_IDENTIFIER_USERNAME` (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividad`
--
ALTER TABLE `actividad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `clase`
--
ALTER TABLE `clase`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reserva`
--
ALTER TABLE `reserva`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clase`
--
ALTER TABLE `clase`
  ADD CONSTRAINT `FK_199FACCE6014FACA` FOREIGN KEY (`actividad_id`) REFERENCES `actividad` (`id`);

--
-- Filtros para la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `FK_188D2E3B9F720353` FOREIGN KEY (`clase_id`) REFERENCES `clase` (`id`),
  ADD CONSTRAINT `FK_188D2E3BDB38439E` FOREIGN KEY (`usuario_id`) REFERENCES `user` (`id`);
COMMIT;
