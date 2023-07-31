-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-08-2022 a las 08:47:35
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sis_school`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumn`
--

CREATE TABLE `alumn` (
  `id` int(11) NOT NULL,
  `image` varchar(50) COLLATE utf8_bin NOT NULL,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  `lastname` varchar(50) COLLATE utf8_bin NOT NULL,
  `email` varchar(255) COLLATE utf8_bin NOT NULL,
  `address` varchar(60) COLLATE utf8_bin NOT NULL,
  `phone` varchar(60) COLLATE utf8_bin NOT NULL,
  `c1_fullname` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `c1_address` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `c1_phone` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `c1_note` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `c2_fullname` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `c2_address` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `c2_phone` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `c2_note` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `alumn`
--

INSERT INTO `alumn` (`id`, `image`, `name`, `lastname`, `email`, `address`, `phone`, `c1_fullname`, `c1_address`, `c1_phone`, `c1_note`, `c2_fullname`, `c2_address`, `c2_phone`, `c2_note`, `is_active`, `created_at`, `user_id`) VALUES
(28, '1658473038.jpg', 'FABIO', 'RODRÍGUEZ', '1@gmail.com', 'VILLA OLGA', '8095555555', '', '', '', '', NULL, NULL, NULL, NULL, 1, NULL, 1),
(29, '1658473026.jpeg', 'YSAURA', 'VASQUE', '1@gmail.com', 'Villa Olga', '809676898956', '', '', '', '', NULL, NULL, NULL, NULL, 1, NULL, 1),
(30, '1658473017.jpg', 'Diogenes', 'NUNEZ', '1@gmail.com', 'Villa Olga', '809676898956', '', '', '', '', NULL, NULL, NULL, NULL, 1, NULL, 1),
(31, '1658473074.jpg', 'LUIS', 'NOGUERA', '1@gmail.com', 'Padres las casas', '809676898956', '', '', '', '', NULL, NULL, NULL, NULL, 1, NULL, 1),
(32, '1658476504.jpg', 'FABIO', 'RODRÍGUEZ', '1@gmail.com', 'Villa olga', '8096768989567', '', '', '', '', NULL, NULL, NULL, NULL, 1, NULL, 5),
(33, '1658476541.jpeg', 'YSAURA', 'RODRÍGUEZ', '1@gmail.com', 'Villa olga', '8096768989567', '', '', '', '', NULL, NULL, NULL, NULL, 1, NULL, 5),
(34, '1658480007.png', 'YSAURA', 'VASQUEZ', '1@gmail.com', 'Padres las casas', '8096768989567', '', '', '', '', NULL, NULL, NULL, NULL, 1, NULL, 3),
(35, '1658480068.png', 'FABIO', 'VASQUEZ', '1@gmail.com', 'Padres las casas', '8096768989567', '', '', '', '', NULL, NULL, NULL, NULL, 1, NULL, 3),
(36, '1658480118.png', 'JULIO', 'PERALTA', '1@gmail.com', 'Padres las casas', '8096768989567', '', '', '', '', NULL, NULL, NULL, NULL, 1, NULL, 3),
(37, '1658482290.png', 'FABIO', 'RODRÍGUEZ', '1@gmail.com', 'Padres las casas', '8096768989567', '', '', '', '', NULL, NULL, NULL, NULL, 1, NULL, 9),
(38, '1658482335.png', 'MARIA', 'GONZALES', '1@gmail.com', 'Padres las casas', '8096768989567', '', '', '', '', NULL, NULL, NULL, NULL, 1, NULL, 9),
(39, '1658548238.png', 'RAMON', 'PEREZ', '1@gmail.com', 'Padres las casas', '8095555555', '', '', '', '', NULL, NULL, NULL, NULL, 1, NULL, 3),
(40, '1658550512.png', 'JUAN', 'RODRÍGUEZ', '1@gmail.com', 'PADRES LAS CASAS', '8095555555', '', '', '', '', NULL, NULL, NULL, NULL, 1, NULL, 6),
(41, '1658659282.png', 'LUIS', 'NOGUERA', '1@gmail.com', 'Padres las casas', '1', '', '', '', '', NULL, NULL, NULL, NULL, 1, NULL, 11);

-- --------------------------------------------------------

--
ALTER TABLE `alumn`
  ADD PRIMARY KEY (`id`),
 

--
-- Indices de la tabla `alumn_team`
--

--
-- Indices de la tabla `permiso`


--
-- Indices de la tabla `team`
--
-- Indices de la tabla `usuario`
--
--
-- Indices de la tabla `usuario_permiso`
--

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumn`
--
--
-- AUTO_INCREMENT de la tabla `alumn_team`
--
--
-- AUTO_INCREMENT de la tabla `permiso`
--
--
-- AUTO_INCREMENT de la tabla `team`
--
--
-- AUTO_INCREMENT de la tabla `usuario`
--
--
-- AUTO_INCREMENT de la tabla `usuario_permiso`
--FY `idusuario_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumn`
--
--
-- Filtros para la tabla `alumn_team`
--
--
-- Filtros para la tabla `usuario_permiso`

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
