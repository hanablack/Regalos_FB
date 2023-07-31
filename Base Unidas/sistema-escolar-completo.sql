-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-08-2022 a las 20:35:10
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
-- Base de datos: `sistema-escolar`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualiza_usuarios` (IN `p_id_usuario` INT, IN `p_nombre` VARCHAR(100), IN `p_usuario` VARCHAR(100), IN `p_clave` VARCHAR(100), IN `p_rol` INT, IN `p_estado` INT)   IF p_id_usuario = 0 THEN
    INSERT INTO usuarios( nombre,usuario,clave,rol,estado)
    VALUES (p_nombre,p_usuario,p_clave,p_rol,p_estado);
 
ELSEIF p_clave IS NULL OR p_clave = '' THEN
	UPDATE usuarios
    SET nombre = p_nombre,usuario = p_usuario,rol = p_rol,estado = p_estado
    WHERE usuario_id = p_id_usuario; 
    
ELSE
	UPDATE usuarios
    SET nombre = p_nombre,usuario = p_usuario,clave = p_clave,rol = p_rol,estado = p_estado
	WHERE usuario_id = p_id_usuario;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `alumno_notas` (IN `p_id_grupo` INT, IN `p_id_alumno` INT)   IF p_id_alumno = 0 THEN
	SELECT n.id_alumno,a.nombre_alumno,p.id_grupo,m.nombre_materia,sum(puntaje)as nota FROM `notas` n 
    join( SELECT * from alumnos) a
    on n.id_alumno = a.alumno_id
    join (SELECT * from usuario_materia) p
    on n.id_grupo = p.id_grupo
    join (SELECT * from materias) m
    on p.materia_id = m.materia_id
    WHERE p.id_grupo = p_id_grupo and p.estadopm = 1 and a.estado = 1
    GROUP by n.id_alumno,p.id_grupo;	
ELSE
	SELECT n.id_alumno,a.nombre_alumno,p.id_grupo,m.nombre_materia,sum(puntaje)as nota FROM `notas` n 
    join( SELECT * from alumnos) a
    on n.id_alumno = a.alumno_id
    join (SELECT * from usuario_materia) p
    on n.id_grupo = p.id_grupo
    join (SELECT * from materias) m
    on p.materia_id = m.materia_id
    WHERE p.id_grupo = p_id_grupo and a.alumno_id= p_id_alumno and p.estadopm = 1 and  a.estado = 1
    GROUP by n.id_alumno,p.id_grupo;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mis_grupos` (IN `p_id_usuario` INT)   IF p_id_usuario = 0 THEN
SELECT pm.id_grupo,p.nombre,g.nombre_grado,a.nombre_aula,pm.materia_id,m.nombre_materia,pe.nombre_periodo,pm.estadopm
FROM usuario_materia AS pm
INNER JOIN grados AS g
ON pm.grado_id = g.grado_id
INNER JOIN aulas AS a
ON pm.aula_id = a.aula_id
INNER JOIN usuario AS p
ON pm.usuario_id = p.usuario_id
INNER JOIN materias AS m
ON pm.materia_id = m.materia_id 
INNER JOIN periodos AS pe
ON pm.periodo_id = pe.periodo_id ;
ELSE
SELECT pm.id_grupo,p.nombre,g.nombre_grado,a.nombre_aula,pm.materia_id,m.nombre_materia,pe.nombre_periodo,pm.estadopm
FROM usuario_materia AS pm
INNER JOIN grados AS g
ON pm.grado_id = g.grado_id
INNER JOIN aulas AS a
ON pm.aula_id = a.aula_id
INNER JOIN usuario AS p
ON  pm.usuario_id = p.usuario_id
INNER JOIN materias AS m
ON pm.materia_id = m.materia_id
INNER JOIN periodos AS pe
ON pm.periodo_id = pe.periodo_id
WHERE pm.usuario_id = p_id_usuario ;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mi_contenido` (IN `p_id_grupo` INT)   SELECT * FROM contenidos as c 
INNER JOIN usuario_materia as pm 
ON c.id_grupo = pm.id_grupo
where pm.id_grupo = p_id_grupo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `nuevo_usuario` (IN `p_nombre` VARCHAR(50), IN `p_usuario` VARCHAR(50), IN `p_clave` VARCHAR(50), IN `p_rol` INT, IN `p_estado` INT)   INSERT INTO usuarios (nombre,usuario,clave,rol,estado) VALUES (p_nombre,p_usuario,p_clave,p_rol,p_estado)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividad`
--

CREATE TABLE `actividad` (
  `actividad_id` int(11) NOT NULL,
  `nombre_actividad` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `actividad`
--

INSERT INTO `actividad` (`actividad_id`, `nombre_actividad`, `estado`) VALUES
(4, 'Paseo para el parque central', 1),
(5, 'Recreo', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnos`
--

CREATE TABLE `alumnos` (
  `alumno_id` int(11) NOT NULL,
  `nombre_alumno` varchar(100) NOT NULL,
  `image` varchar(50) COLLATE utf8_bin NOT NULL,
  `edad` int(11) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `cedula` varchar(20) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `telefono` bigint(20) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `fecha_nac` date NOT NULL,
  `fecha_registro` date NOT NULL,
  `about` text DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `fees` int(255) DEFAULT NULL,
  `branch` varchar(255) DEFAULT NULL,
  `balance` float DEFAULT NULL,
   `user_id` int(11) NOT NULL,
  `estado` bit(1) NOT NULL DEFAULT b'1'  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `alumnos`
--

INSERT INTO `alumnos` (`alumno_id`, `nombre_alumno`,`image`, `edad`, `direccion`, `cedula`, `clave`, `telefono`, `correo`, `fecha_nac`, `fecha_registro`, `about`, `contact`, `fees`, `branch`, `balance`,`user_id`, `estado`) VALUES
(1, 'Ysaura Vasquez', '1658473038.jpg',15, 'Villa Olga', '12345', '$2y$10$d//If6OfoUqqx1LJWGusEuUrNZyWnSBkGiGTt7WmppUpLi6mH9s9e', 1234, 'A@gmail.com', '2007-01-01', '2022-07-14', 'Excelente estudiante recomendado', '3162345871', 1000000, '2', 700000,1, b'1'),
(2, 'Fabio Rodriguez','1658473038.jpg', 15, 'V', '1234', '$2y$10$e6yZY0yOU6fDueEFpYGIi.og/H5XdJjOUM3HDMZG7504tXftnrbIG', 1234, 'F@gmail.com', '2007-01-01', '2022-07-14', 'Estudiante es migrado de otro colegio, noticias excelentes.', '3154678143', 1200000, '1', 1080000,1, b'1'),
(7, 'Juan Fernandez', '1658473026.jpeg',15, 'Villa Olga', '45454545', '$2y$10$WICjwK..M2TO3gk1VW5im.kQHzF1D8a1hOmyyk5GUPKMAw/ryU6zW', 8096768989, '1@gmail.com', '2022-07-17', '2022-07-17', 'Realizara pagos en cuotas de 1000', '8099908989', 16000, '7', 15000,1, b'1'),
(9, 'benjamin', '1658473026.jpeg',18, 'Villa olga', '12345678', '$2y$10$VwBWeyhZIfQICbFDD6Gqfuyrf6wkzb80cnX5gZ0V4ZeSsFshPI4hK', 8096768989, '1@gmail.com', '2022-07-19', '2022-07-19', 'Realizara los pagos de 1000', '7878787788', 20000, '7', 10000,1, b'0'),
(10, 'Juan pablo', '1658473017.jpg',12, 'Villa olga', '123456789', '$2y$10$eeR8pW1iN5ucbt6dH8oD3.qXTAW6dlXOVbxPkuJLwob/sl6glNrke', 8096768989, '1@gmail.com', '2022-07-20', '2022-07-20', 'Primero A', '7878787788', 20000, '7', 19000,1, b'0'),
(11, 'Liam ', '1658473017.jpg',12, 'Padres las casas', 'liam', '$2y$10$bPWi5eL4Q97zv1rO17Tbm.dOXB.UYM.n/FyKXNwdUR/x4l.PzXT/O', 8096768989567, '1@gmail.com', '2022-07-24', '2022-07-24', 'Primero A', '7878787788', 20000, '7', 19000,1, b'1'),
(12, 'Radame Rodríguez ', '1658548238.png',15, 'Avenidad Estrella sadhala', '010203', '$2y$10$uPMfDLnNOY9FNNJzo5LTDu1yJzx0SZXT0sO0KqhOdjqzRseV7wIL.', 9999999999, '1@gmail.com', '2022-07-27', '2022-07-27', 'Primero A', '7878787788', 20000, '7', 19000,4, b'1'),
(13, 'benjamin maria','1658473026.jpeg', 15, 'josem aria  ', '12458765412', '$2y$10$64ssqB9OO9Hlq.ud9x5gm.jy82xl9MNULFehmU/YjItYz90JfKrp.', 8098862235, 'benjamin@gmail.com', '2022-08-19', '2022-08-09', '', '', 0, '', 0,4, b'1'),
(14, 'Ysaura Vasquez', '1658473074.jpg',15, 'Villa Olga', '12345', '$2y$10$d//If6OfoUqqx1LJWGusEuUrNZyWnSBkGiGTt7WmppUpLi6mH9s9e', 1234, 'A@gmail.com', '2007-01-01', '2022-07-14', 'Excelente estudiante recomendado', '3162345871', 1000000, '2', 700000,4, b'1'),
(15, 'Fabio Rodriguez', '1658482335.png',15, 'V', '1234', '$2y$10$e6yZY0yOU6fDueEFpYGIi.og/H5XdJjOUM3HDMZG7504tXftnrbIG', 1234, 'F@gmail.com', '2007-01-01', '2022-07-14', 'Estudiante es migrado de otro colegio, noticias excelentes.', '3154678143', 1200000, '1', 1080000,4, b'1'),
(16, 'Juan Fernandez', '1658548238.png',15, 'Villa Olga', '45454545', '$2y$10$WICjwK..M2TO3gk1VW5im.kQHzF1D8a1hOmyyk5GUPKMAw/ryU6zW', 8096768989, '1@gmail.com', '2022-07-17', '2022-07-17', 'Realizara pagos en cuotas de 1000', '8099908989', 16000, '7', 15000,4, b'1'),
(17, 'benjamin', '1658480068.png',18, 'Villa olga', '12345678', '$2y$10$VwBWeyhZIfQICbFDD6Gqfuyrf6wkzb80cnX5gZ0V4ZeSsFshPI4hK', 8096768989, '1@gmail.com', '2022-07-19', '2022-07-19', 'Realizara los pagos de 1000', '7878787788', 20000, '7', 10000,4, b'0'),
(18, 'Juan pablo', '1658482335.png',12, 'Villa olga', '123456789', '$2y$10$eeR8pW1iN5ucbt6dH8oD3.qXTAW6dlXOVbxPkuJLwob/sl6glNrke', 8096768989, '1@gmail.com', '2022-07-20', '2022-07-20', 'Primero A', '7878787788', 20000, '7', 19000,4, b'0'),
(19, 'Liam ', '1658473074.jpg',12, 'Padres las casas', 'liam', '$2y$10$bPWi5eL4Q97zv1rO17Tbm.dOXB.UYM.n/FyKXNwdUR/x4l.PzXT/O', 8096768989567, '1@gmail.com', '2022-07-24', '2022-07-24', 'Primero A', '7878787788', 20000, '7', 19000, 4,b'1'),
(20, 'Radame Rodríguez ', '1658473017.jpg',15, 'Avenidad Estrella sadhala', '010203', '$2y$10$uPMfDLnNOY9FNNJzo5LTDu1yJzx0SZXT0sO0KqhOdjqzRseV7wIL.', 9999999999, '1@gmail.com', '2022-07-27', '2022-07-27', 'Primero A', '7878787788', 20000, '7', 19000,4, b'1'),
(21, 'benjamin maria', '1658480068.png',15, 'josem aria  ', '12458765412', '$2y$10$64ssqB9OO9Hlq.ud9x5gm.jy82xl9MNULFehmU/YjItYz90JfKrp.', 8098862235, 'benjamin@gmail.com', '2022-08-19', '2022-08-09', '', '', 0, '', 0,4, b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno_usuario`
--


CREATE TABLE `team` (
  `idgrupo` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_bin NOT NULL,
  `favorito` tinyint(1) NOT NULL,
  `idusuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `team`
--

INSERT INTO `team` (`idgrupo`, `nombre`, `favorito`, `idusuario`) VALUES
(1, 'PRIMERO DE PRIMARIA', 1, 1),
(2, 'SEGUNDO DE PRIMARIA', 1, 3),
(3, 'TERCERO DE PRIMARIA', 1, 1),
(4, 'CUARTO DE PRIMARIA', 1, 1),
(5, 'QUINTO DE PRIMARIA', 1, 1),
(6, 'SEXTO DE PRIMARIA', 1, 1),
(10, 'PRIMERO-A', 1, 3),
(11, 'PROGRAMACION 3', 1, 4),
(12, 'HISTORIA 1', 1, 5),
(13, 'HISTORIA 2', 1, 5),
(14, 'HISTORIA 3', 1, 9),
(15, 'TERCERO B', 1, 3),
(16, 'HISTORIA DOMINICANA 2', 1, 9),
(17, 'HISTORIA DOMINICANA 3', 1, 9),
(18, 'HISTORIA BASICA', 1, 9),
(19, 'PROYECTO INTEGRADOR 1', 1, 6),
(20, 'COMPUCTACION GRAFICA', 0, 6),
(21, 'MUSICA CLASICA', 1, 10),
(22, 'MATEMATICAS DISCRETA', 1, 11),
(23, 'BIOLOGIA', 0, 11),
(24, 'TUTORIA DE BIOLOGIA', 0, 11);








CREATE TABLE `alumno_usuario` (
  `ap_id` int(11) NOT NULL,
  `alumno_id` int(11) NOT NULL,
  `id_grupo` int(11) NOT NULL,
  `periodo_id` int(11) NOT NULL,
  `estadop` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `alumno_usuario`
--

INSERT INTO `alumno_usuario` (`ap_id`, `alumno_id`, `id_grupo`, `periodo_id`, `estadop`) VALUES
(1, 2, 1, 4, 1),
(2, 1, 2, 4, 1),
(4, 1, 3, 4, 1),
(5, 2, 3, 4, 1),
(6, 1, 4, 4, 1),
(7, 7, 5, 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aulas`
--

CREATE TABLE `aulas` (
  `aula_id` int(11) NOT NULL,
  `nombre_aula` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `aulas`
--

INSERT INTO `aulas` (`aula_id`, `nombre_aula`, `estado`) VALUES
(6, 'A-1', 1),
(7, 'A-2', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `branch`
--

CREATE TABLE `branch` (
  `id` int(255) NOT NULL,
  `branch` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `detail` text NOT NULL,
  `delete_status` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `branch`
--

INSERT INTO `branch` (`id`, `branch`, `address`, `detail`, `delete_status`) VALUES
(1, 'Banco Falabella', 'Calle 54 N 35 23', 'Excelente banco no cobra por cuota de manejo ni por sacar el dinero de cajeros automáticos.', '1'),
(2, 'Banco Colpatria', 'Calle 88 N 123 - 12', 'Excelente bancos, tampoco cobra cuota de manejo, ni por sacar dinero de sus cajero automáticos.', '1'),
(3, 'Bancolombia', 'Calle 34 N 18 - 14', 'Es el banco que tiene más personas en Colombia, tiene cajeros y sucursales en todas partes, pero tiene cargos en sus cuentas, por movimientos y por cuota de manejo.', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificaciones`
--

CREATE TABLE `calificaciones` (
  `calificacion_id` int(11) NOT NULL,
  `alumno_id` int(11) NOT NULL,
  `materia_id` int(11) NOT NULL,
  `periodo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idcliente` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(200) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idcliente`, `nombre`, `telefono`, `direccion`) VALUES
(1, 'Ana Lopez', '978645132', 'Trujillo - Perú'),
(2, 'Maria sanchez', '974561234', 'Trujillo - Perú'),
(4, 'Nuevo Cliente', '97877789', 'Av. san martin n° 342'),
(6, 'Registro de Cliente', '978978', 'Av. Libertad'),
(7, 'Ysaura Vasquez', '809', 'ysaura'),
(8, 'Fabio Rodriguez', '123', 'fabio'),
(9, 'Diogenes', '123', 'diogenes'),
(10, 'Liam', '11', 'liam'),
(11, 'Radame Rodríguez ', '12', '010203');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `nombre`, `telefono`, `email`, `direccion`) VALUES
(1, 'Sistema Escolar', '8092220909', 'sistema1@gmail.com', 'Santiago de los Caballeros');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenidos`
--

CREATE TABLE `contenidos` (
  `contenido_id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `material` varchar(255) NOT NULL,
  `id_grupo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `contenidos`
--

INSERT INTO `contenidos` (`contenido_id`, `titulo`, `descripcion`, `material`, `id_grupo`) VALUES
(10, 'Hoja de presentacion', 'Pasas para elaborar la hoja de presentacion, se abjunta archivo.', '../../../uploads/6853/abcd.pdf', 5),
(11, 'PRIMERRA EVALUACION: TEMA 1: Hojas de Presentacion', 'Como hacer una hoja de presentacion, se abjunta archivo.', '../../../uploads/3295/pdf.pdf', 4),
(13, 'Historia de la Republica Dominicana', 'Definir todo', '../../../uploads/5709/abcd.pdf', 3),
(14, 'Informe de Naturales', 'Realizar el informe y leer el documneto', '../../../uploads/8602/Algoritmo de polígonos regulares 1.pdf', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_permisos`
--

CREATE TABLE `detalle_permisos` (
  `id` int(11) NOT NULL,
  `id_permiso` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_permisos`
--

INSERT INTO `detalle_permisos` (`id`, `id_permiso`, `id_usuario`) VALUES
(63, 1, 16),
(64, 2, 16),
(65, 3, 16),
(66, 4, 16),
(67, 5, 16),
(68, 6, 16),
(84, 1, 1);




INSERT INTO `detalle_permisos` (`id`, `id_usuario`, `id_permiso`) VALUES
(70, 5, 11),
(71, 5, 12),
(72, 5, 13),
(85, 7, 11),
(86, 7, 12),
(83, 7, 13),
(91, 12, 11),
(92,12, 12),
(93, 12, 13),
(97, 1, 11),
(98, 1, 12),
(99, 1, 13),
(103, 6, 11),
(104, 6, 12),
(105, 6, 13),
(106, 13, 11),
(107, 13, 12),
(108, 13, 13),
(109, 11, 11),
(110, 11, 12),
(111, 11, 13),
(118, 4, 11),
(119, 4, 12),
(120, 4, 13),
(124, 3, 11),
(125, 3, 12),
(126, 3, 13);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_temp`
--

CREATE TABLE `detalle_temp` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `descuento` decimal(10,2) NOT NULL DEFAULT 0.00,
  `precio_venta` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `id` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_venta` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `descuento` decimal(10,2) NOT NULL DEFAULT 0.00,
  `precio` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`id`, `id_producto`, `id_venta`, `cantidad`, `descuento`, `precio`, `total`) VALUES
(15, 7, 8, 1, '0.00', '500.00', '500.00'),
(20, 7, 12, 500, '0.00', '1500.00', '750000.00'),
(21, 10, 13, 1, '0.00', '500.00', '500.00'),
(22, 10, 14, 1, '0.00', '500.00', '500.00'),
(23, 8, 15, 1, '0.00', '1000.00', '1000.00'),
(24, 12, 16, 1, '0.00', '200.00', '200.00'),
(25, 7, 16, 1, '0.00', '1500.00', '1500.00'),
(26, 9, 16, 2, '0.00', '500.00', '1000.00'),
(27, 12, 17, 1, '0.00', '200.00', '200.00'),
(28, 7, 17, 1, '0.00', '1500.00', '1500.00'),
(29, 9, 17, 2, '100.00', '500.00', '900.00'),
(30, 12, 18, 1, '0.00', '200.00', '200.00'),
(31, 7, 18, 1, '0.00', '1500.00', '1500.00'),
(32, 11, 18, 2, '700.00', '500.00', '300.00'),
(33, 12, 19, 1, '0.00', '200.00', '200.00'),
(34, 7, 19, 1, '0.00', '1500.00', '1500.00'),
(35, 9, 19, 2, '200.00', '500.00', '800.00'),
(36, 13, 20, 1, '0.00', '1000.00', '1000.00'),
(37, 13, 21, 1, '0.00', '1000.00', '1000.00'),
(38, 7, 22, 1, '0.00', '1500.00', '1500.00'),
(39, 7, 23, 1, '0.00', '1500.00', '1500.00'),
(40, 12, 23, 1, '0.00', '200.00', '200.00'),
(41, 7, 24, 1, '50.00', '1500.00', '1450.00'),
(42, 9, 25, 3, '0.00', '500.00', '1500.00'),
(43, 9, 26, 3, '500.00', '500.00', '1000.00'),
(44, 7, 27, 3, '-1000.00', '1500.00', '5500.00'),
(45, 7, 28, 1, '0.00', '1500.00', '1500.00'),
(46, 12, 28, 1, '-50.00', '200.00', '250.00'),
(47, 9, 28, 2, '700.00', '500.00', '300.00'),
(48, 9, 29, 3, '-450.00', '500.00', '1950.00'),
(49, 10, 30, 5, '-1100.00', '500.00', '8700.00'),
(50, 10, 31, 5, '-1000.00', '500.00', '3500.00'),
(51, 11, 32, 2, '500.00', '500.00', '500.00'),
(52, 7, 33, 1, '0.00', '1500.00', '1500.00'),
(53, 9, 33, 2, '200.00', '500.00', '800.00'),
(54, 7, 34, 1, '0.00', '1500.00', '1500.00'),
(55, 9, 34, 3, '0.00', '500.00', '1500.00'),
(56, 12, 35, 1, '0.00', '200.00', '200.00'),
(57, 9, 36, 2, '-500.00', '500.00', '1500.00'),
(58, 9, 37, 2, '500.00', '500.00', '500.00'),
(59, 14, 38, 3, '500.00', '1000.00', '2500.00'),
(60, 14, 39, 1, '-500.00', '1000.00', '1500.00'),
(61, 7, 40, 1, '500.00', '1500.00', '1000.00'),
(62, 15, 41, 1, '400.00', '1000.00', '600.00'),
(63, 15, 42, 1, '-500.00', '1000.00', '1500.00'),
(64, 15, 43, 1, '200.00', '1000.00', '800.00'),
(65, 7, 44, 1, '0.00', '1500.00', '1500.00'),
(66, 7, 45, 1, '500.00', '1500.00', '1000.00'),
(67, 12, 46, 1, '0.00', '200.00', '200.00'),
(68, 7, 46, 1, '0.00', '1500.00', '1500.00'),
(69, 9, 46, 3, '500.00', '500.00', '1000.00'),
(70, 13, 47, 1, '-700.00', '1000.00', '1700.00'),
(71, 9, 48, 4, '200.00', '500.00', '1800.00'),
(72, 15, 49, 1, '100.00', '1000.00', '900.00'),
(73, 7, 50, 1, '1000.00', '1500.00', '500.00'),
(74, 9, 50, 2, '0.00', '500.00', '1000.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones`
--

CREATE TABLE `evaluaciones` (
  `evaluacion_id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `fecha` date NOT NULL,
  `porcentaje` varchar(100) NOT NULL,
  `materia_id` int(11) NOT NULL,
  `periodo_id` int(11) NOT NULL,
  `contenido_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ev_entregadas`
--

CREATE TABLE `ev_entregadas` (
  `ev_entregada_id` int(11) NOT NULL,
  `evaluacion_id` int(11) NOT NULL,
  `alumno_id` int(11) NOT NULL,
  `material` varchar(255) NOT NULL,
  `observacion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fees_transaction`
--

CREATE TABLE `fees_transaction` (
  `id` int(255) NOT NULL,
  `stdid` varchar(255) NOT NULL,
  `paid` int(255) NOT NULL,
  `submitdate` datetime NOT NULL,
  `transcation_remark` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `fees_transaction`
--

INSERT INTO `fees_transaction` (`id`, `stdid`, `paid`, `submitdate`, `transcation_remark`) VALUES
(11, '10', 100000, '2020-08-20 00:00:00', 'Estudiante Generado para posible intercambio con colegio Alemán'),
(12, '10', 100000, '2020-08-20 00:00:00', 'Pagado por adelantado'),
(13, '10', 100000, '2020-08-20 00:00:00', 'Pago adelantado'),
(14, '11', 0, '2020-08-21 00:00:00', 'En la semana que viene el estudiante promete realizar el primer pago.'),
(15, '11', 120000, '2020-08-21 00:00:00', 'Pudo realizar el pago antes de lo acordado.'),
(16, '12', 100, '2022-07-30 00:00:00', 'Nada'),
(17, '12', 900, '2022-07-25 00:00:00', 'Nada'),
(18, '12', 200, '2022-07-25 00:00:00', ''),
(19, '12', 200, '2022-07-25 00:00:00', ''),
(20, '12', 400, '2022-07-25 00:00:00', ''),
(21, '12', 150, '2022-07-25 00:00:00', ''),
(22, '13', 100, '2022-07-26 00:00:00', ''),
(23, '13', 900, '2022-07-26 00:00:00', ''),
(24, '14', 500, '2022-07-26 00:00:00', ''),
(25, '14', 9500, '2022-07-26 00:00:00', ''),
(26, '15', 0, '2022-07-26 00:00:00', ''),
(27, '15', 2000, '2022-07-26 00:00:00', ''),
(28, '15', 800, '2022-07-26 00:00:00', 'Pago mes de julio'),
(29, '15', 7200, '2022-07-26 00:00:00', 'Pago mes de julio'),
(30, '15', 2000, '2022-07-26 00:00:00', 'Pago mes de agosto'),
(31, '15', 7200, '2022-07-26 00:00:00', 'pago de julio'),
(32, '12', 50, '2022-07-26 00:00:00', 'Pago del mes de Julio'),
(33, '15', 400, '2022-07-27 00:00:00', 'Pago del mes de agosto'),
(34, '16', 500, '2022-07-27 00:00:00', 'Primera mensualidad--Mes de julio'),
(35, '16', 500, '2022-07-27 00:00:00', 'segunda mensualidad ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grados`
--

CREATE TABLE `grados` (
  `grado_id` int(11) NOT NULL,
  `nombre_grado` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `grados`
--

INSERT INTO `grados` (`grado_id`, `nombre_grado`, `estado`) VALUES
(7, 'Primero-A', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias`
--

CREATE TABLE `materias` (
  `materia_id` int(11) NOT NULL,
  `nombre_materia` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `materias`
--

INSERT INTO `materias` (`materia_id`, `nombre_materia`, `estado`) VALUES
(1, 'Proyecto integrador', 1),
(2, 'Programacion', 1),
(3, 'Historia', 1),
(4, 'Naturales', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas`
--

CREATE TABLE `notas` (
  `id_nota` int(11) NOT NULL,
  `id_alumno` int(11) NOT NULL,
  `id_grupo` int(11) NOT NULL,
  `id_segmento` int(11) NOT NULL,
  `puntaje` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `notas`
--

INSERT INTO `notas` (`id_nota`, `id_alumno`, `id_grupo`, `id_segmento`, `puntaje`) VALUES
(2, 1, 4, 2, 28),
(3, 1, 4, 3, 28),
(5, 1, 4, 5, 5),
(6, 2, 1, 1, 28),
(7, 2, 1, 2, 28),
(8, 2, 1, 3, 28),
(9, 2, 1, 4, 2),
(10, 2, 1, 5, 6),
(15, 1, 3, 1, 30),
(16, 1, 3, 2, 20),
(17, 1, 3, 3, 28),
(18, 1, 3, 4, 3),
(19, 1, 3, 5, 3),
(20, 7, 5, 1, 26),
(21, 7, 5, 2, 20),
(22, 7, 5, 3, 22),
(23, 7, 5, 4, 2),
(24, 7, 5, 5, 2),
(27, 1, 4, 1, 24),
(28, 1, 4, 4, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id_pago` int(11) NOT NULL,
  `id_alumno` int(11) NOT NULL,
  `contacto` varchar(50) NOT NULL,
  `metodo` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `monto` float NOT NULL,
  `remark` varchar(100) NOT NULL,
  `about` varchar(100) NOT NULL,
  `estado` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `periodos`
--

CREATE TABLE `periodos` (
  `periodo_id` int(11) NOT NULL,
  `nombre_periodo` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `periodos`
--

INSERT INTO `periodos` (`periodo_id`, `nombre_periodo`, `estado`) VALUES
(4, 'Enero-Abril', 1),
(5, 'Mayo-Agosto', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id`, `nombre`) VALUES
(1, 'configuración'),
(2, 'usuarios'),
(3, 'clientes'),
(4, 'productos'),
(5, 'ventas'),
(6, 'nueva_venta'),
(11, 'Escritorio'),
(12, 'Grupos'),
(13, 'Acceso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `codproducto` int(11) NOT NULL,
  `codigo` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `existencia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`codproducto`, `codigo`, `descripcion`, `precio`, `existencia`) VALUES
(7, '1', 'Inscripcion', '1500.00', 486),
(8, '2', 'Reinscripcion', '1000.00', 19),
(9, '3', 'Mensualidad [Primaria A]', '500.00', 8),
(10, '4', 'Mensualidad [Primaria B]', '500.00', 8),
(11, '5', 'Mensualidad [Secundaria A]', '500.00', 15),
(12, '6', 'Admision', '200.00', 92),
(13, '7', 'Paseo al parque central', '1000.00', 4),
(14, '8', 'Mensualidad [Secundaria B]', '1000.00', 8),
(15, '123', 'paseo a un parque', '1000.00', 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usuario_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `cedula` varchar(20) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `telefono` bigint(20) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `nivel_est` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`


--

INSERT INTO `usuario` (`usuario_id`, `nombre`, `direccion`, `cedula`, `clave`, `telefono`, `correo`, `nivel_est`, `estado`) VALUES
(5, 'Juan pablo', 'Villa olga', 'fabio1', '$2y$10$SmxcP5w3GWUVecOVVxBUr.P19icFClvLKrpZqF2kF3QHJYrzvfcSi', 123, 'Juan@gmail.com', 'Licenciado en ciencias Naturales', 1),
(6, 'Samuel Perez', 'San  jose', 'samuel', '$2y$10$A5VPI6gbHHYNDS5z.nL31.zU6pfeho7a6qN/hurAkaGDW52IbuZmy', 34543, 'sanjose@gmail.com', 'Licenciado en ciencias Sociales', 1),
(7, 'Alejandro', 'San pedro ', '1234', '$2y$10$IWcZKPVtZLOEf7r8B2rKy.opLbHiHv.D9B3414pUGhNsOVnjAs506', 8096768989, 'Alejandro@gmail.com', 'Ingeniero en software', 1),
(9, 'Nachely', 'Villa olga', '12345', '$2y$10$WmkCd5m7MN8jXJ1k0bf/1.ScLdms5uRURwWWCXCprRxD0hlQC7j12', 8096768989, '1@gmail.com', 'Licenciado en ciencias Naturales', 1),
(10, 'Ramon', 'Villa Olga', 'ramon1', '$2y$10$VKej0WdRWGx1mcsOHHPo8uBRO3Fy.UBJNau1XQYPOwCMKvXED5PxK', 8096768989, '1@gmail.com', 'Usuario de esducacion fisica', 1),
(11, 'Nachely 17', 'Villa Olga', 'nachely', '$2y$10$NTj3d3q.Whd0d1zjEbrsZeEEWYkf.m8pMYxWq0FbdAyfLV8/CBuRe', 8096768989, '1@gmail.com', 'Ingeniero en software', 1),
(12, 'Luis Peralta', 'Villa olga', 'luis1', '$2y$10$WdgNGtUn4OqsrEqfP/ssJ.RrAGb5/7b1EQJclsvfhIYRtBbSAn6BG', 8096768989, '1@gmail.com', 'Licenciado en ciencias Sociales', 1),
(13, 'Fabio Rodriguez', 'Villa olga', 'fabio2', '$2y$10$JB89uKIcgBUpGoQOruMtI.QSKjbSgRgEe27SJS6qBty/9Y5RULG/2', 8096768989, '1@gmail.com', 'Licenciado en ciencias Naturales', 1),
(15, 'gior', 'Villa olga', 'gior', '$2y$10$2AOZicZHFF0kjE9b3JHq7OgGCx8Vp6kJI.tEUlZIFZFD3fgXxm.jS', 1, '1@gmail.com', 'Usuario de Historia', 1),
(16, 'Martha Perez', 'Padres las casas', 'martha', '$2y$10$XeMg6RsEBQQRZRmhNw.HjedpDAyF.lqu/oplCGX15QG.ZcxPhAjsy', 8096768989567, '1@gmail.com', 'Matematicas', 1),
(17, 'Rafael', 'Villa olga', 'rafael', '$2y$10$IeaDEE8F//OLEpZUg2252u65wVGCkyvQZt4mzqNiFg/GohaGgReVm', 1, '1@gmail.com', 'Alto', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_materia`
--

CREATE TABLE `usuario_materia` (
  `id_grupo` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `grado_id` int(11) NOT NULL,
  `aula_id` int(11) NOT NULL,
  `materia_id` int(11) NOT NULL,
  `periodo_id` int(11) NOT NULL,
  `estadopm` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario_materia`
--

INSERT INTO `usuario_materia` (`id_grupo`, `usuario_id`, `grado_id`, `aula_id`, `materia_id`, `periodo_id`, `estadopm`) VALUES
(1, 5, 7, 6, 4, 4, 1),
(2, 6, 7, 7, 4, 4, 1),
(3, 6, 7, 6, 3, 4, 0),
(4, 11, 7, 6, 1, 4, 1),
(5, 11, 7, 6, 2, 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `rol_id` int(11) NOT NULL,
  `nombre_rol` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`rol_id`, `nombre_rol`) VALUES
(1, 'Administrador'),
(2, 'Asistente'),
(3, 'usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `segmentos`
--

CREATE TABLE `segmentos` (
  `id_segmento` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `maximo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `segmentos`
--

INSERT INTO `segmentos` (`id_segmento`, `nombre`, `maximo`) VALUES
(1, 'Pimer Parcial', 30),
(2, 'Segundo Parcial', 30),
(3, 'Tercer Parcial', 30),
(4, 'Participacion', 5),
(5, 'Asistencia', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `usuario_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `usuario` varchar(100) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `rol` int(11) NOT NULL,
  `emailid` varchar(255) NOT NULL,
  `lastlogin` datetime NOT NULL,
  `cargo` varchar(20) DEFAULT NULL,
  `imagen` varchar(50) NOT NULL,
  `condicion` tinyint(4) NOT NULL DEFAULT 1,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usuario_id`, `nombre`,  `tipo_documento`, `num_documento`,`usuario`, `clave`, `rol`, `emailid`, `lastlogin`,`imagen`, `condicion`, `estado`) VALUES
(1, 'Luis Noguera','CEDULA', '72154871', 'admin', '$2y$10$H8pSRwBlnJ5k58hER5DYFuhO6u3eWx58D3D097GuW9AbNdGXAQPHi', 1, 'hola@cweb.com', '0000-00-00 00:00:00', '1658471284.jpeg', 1, 1),
(2, 'Andres Martinez','CEDULA', '72152871', 'andres1', '$2y$10$NRNhbzPgwxb8TKqrVqZopu7Pwe.9eJVtK7srAcJWSSAtGXKv03nx.', 1, '13@gmail.com', '2022-07-26 23:35:07','1658471270.jpg', 1, 1),
(3, 'Juan pabloo','DNI', '122343', 'juan1', '$2y$10$LiKqd3unErTShpSUWd0FueSc2gBBdIJ5CSNOH/XUtQhF3ohaQVSBe', 1, '1444@gmail.com', '2022-07-26 23:35:07', '1658471270.jpg', 1, 1),
(4, 'Nachely Rodríguez','CEDULA', '72154871', 'nachely', '$2y$10$o4z97T7CXO5hfGhAhnS0D.cgI8qIiWYsHRHAdU8uIkyAC8tz8LJnW', 1, 'hol5555a@cweb.com', '0000-00-00 00:00:00', '1658570762.png', 1, 1),
(5, 'Fabio 21 Diogenes', 'DNI', '123423423', 'fabio145', '$2y$10$Xb9CT3TFYK7z33mYXLvDZOpbEbFGHCcqR8WNsbAjjf/6UaSwsXRUm', 1, 'hola666@cweb.com', '0000-00-00 00:00:00', '1658471270.jpg', 1, 2),
(6, 'Diogenes Núñez', 'DNI', '1234324', 'Diogenes1', '$2y$10$HYa6YYkQJaBb1L7q/cg8h.j5Jm/p/mO1WizR1xjnCswr3ZkX3KvE6', 2, 'hol7788a@cweb.com', '0000-00-00 00:00:00', '1658476173.png', 1, 1),
(7, 'Ysaura Vasquez', 'DNI', '1512', 'ysaura1', '$2y$10$bRd0cKKByiFzdJa3LQ0uf.j/Q9wGfivNZHiJL7ktUOrAgCBq1d2WG', 1, 'hol7799a@cweb.com', '0000-00-00 00:00:00', '1658474722.png', 1, 1),
(10, 'Pedro Rodriguez', 'DNI', '1636734', 'pedro1', '$2y$10$/LnJDSL.HV4OrSsH2jEaV.BGVsDs3avS32zX2eVf9GuWqEUMTkzqq', 2, 'hol7107a@cweb.com', '0000-00-00 00:00:00', '1658474722.png', 1, 1),
(11, 'Hilari rosio', 'CEDULA', '123235735', 'hilari1', '$2y$10$D.lS7CtVEbdM4XGj9.hLVera3i0IpXoOKGUDRat5Mk26aFMa2fXO.', 1, 'hol7711a@cweb.com', '0000-00-00 00:00:00', '1658471284.jpeg', 1, 1),
(12, 'Dahiana hirata', 'CEDULA', '1247453', 'dahi1', '$2y$10$bFAfukJBl9wl2GqbsW6jMO1CgkIIaFCO4ZyIO6h2QaWeWBDu57zvW', 1, 'hol7712a@cweb.com', '0000-00-00 00:00:00', '1658481768.png', 0, 1),
(13, 'Nayely silveriio', 'CEDULA', '124745a143', 'nayely1', '$2y$10$kZFt0o/vb/EI2GoqHEoN8eQjmLojb0tLUlqa95TJppI4eRTTy.Pfy', 1, 'hol7137a@cweb.com', '0000-00-00 00:00:00', '1658481024.png', 1, 2),
(14, 'Cesilio Martinez', 'CEDULA', '145745723', 'Cesilio', '$2y$10$vUIgtqnaVyKckRouDuO3KeUgEXytMxNrRgbI0yQForzM2TvP5xM76', 1, 'hol7147a@cweb.com', '0000-00-00 00:00:00', '1658476173.png', 1, 1),
(15, 'ConfiguroWeb', 'CEDULA', '1234543', 'configuroweb', '4b67deeb9aba04a5b54632ad19934f26', 1, 'hola@cweb.com', '0000-00-00 00:00:00', '1658481768.png', 0, 1),
(16, 'Nachely Rodriguez', 'CEDULA', '123423423', 'nachely', '$2y$10$H8pSRwBlnJ5k58hER5DYFuhO6u3eWx58D3D097GuW9AbNdGXAQPHi', 1, '1@gmail.com', '2022-07-26 23:35:07', '1658481024.png', 1, 1);

-- --------------------------------------------------------
CREATE TABLE `block` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `team_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



INSERT INTO `block` (`id`, `name`, `team_id`) VALUES
(7, 'Historia', 1),
(8, 'Matematicas', 1),
(9, 'Naturales', 1),
(10, 'TAREA 1', 12),
(11, 'TAREA 2', 12),
(12, 'TAREA 3', 12),
(13, 'CALIFICACION FINAL', 12),
(14, 'TAREA 1', 15),
(15, 'TAREA 2', 15),
(16, 'TAREA 3', 15),
(17, 'TAREA 1: REALIZAR UN RESUMEN', 16),
(18, 'TAREA 2: REDACTAR UN INFORME', 16),
(19, 'TAREA  1', 19),
(20, 'TAREA 2', 19),
(21, 'TAREA 4:  REDACTAR UN INFORME', 15),
(22, 'TAREA 1', 22),
(23, 'EXPOSICIONES', 22),
(24, 'INFORMES', 22),
(25, 'TAREA 5: INFORME FINAL', 15),
(26, 'ACTIVIDAD #6', 15);


CREATE TABLE `calification` (
  `id` int(11) NOT NULL,
  `val` double DEFAULT NULL,
  `alumn_id` int(11) NOT NULL,
  `block_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `behavior` (
  `id` int(11) NOT NULL,
  `kind_id` int(11) DEFAULT NULL,
  `date_at` date NOT NULL,
  `alumn_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `behavior`
--

CREATE TABLE `assistance` (
  `id` int(11) NOT NULL,
  `kind_id` int(11) DEFAULT NULL,
  `date_at` date NOT NULL,
  `alumn_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `assistance`
--

INSERT INTO `assistance` (`id`, `kind_id`, `date_at`, `alumn_id`, `team_id`) VALUES
(14, 1, '2022-07-21', 1, 1),
(15, 3, '2022-07-21', 2, 1),
(16, 1, '2022-07-21', 7, 1),
(17, 4, '2022-07-22', 9, 12),
(18, 2, '2022-07-22', 10, 12),
(19, 3, '2022-07-22', 11, 15),
(20, 1, '2022-07-22', 12, 15),
(21, 2, '2022-07-22', 13, 15),
(22, 3, '2022-07-22', 14, 16),
(23, 1, '2022-07-22', 15, 16),
(24, 1, '2022-07-22', 16, 15),
(25, 3, '2022-07-22', 17, 19),
(26, 1, '2022-07-23', 16, 15),
(27, 1, '2022-07-23', 11, 15),
(28, 4, '2022-07-23', 12, 15),
(29, 3, '2022-07-23', 13, 15),
(30, 3, '2022-07-24', 18, 22),
(31, 1, '2022-07-25', 16, 15),
(32, 2, '2022-07-25', 11, 15),
(33, 3, '2022-07-25', 12, 15),
(34, 4, '2022-07-25', 13, 15);

CREATE TABLE `alumn_team` (
  `id` int(11) NOT NULL,
  `alumn_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `alumn_team`
--

INSERT INTO `alumn_team` (`id`, `alumn_id`, `team_id`) VALUES
(17, 1, 1),
(18, 2, 1),
(19, 3, 1),
(20, 4, 2),
(21, 10, 12),
(22, 11, 12),
(23, 12, 15),
(24, 13, 15),
(25, 14, 15),
(26, 15, 16),
(27, 16, 16),
(28, 5, 15),
(29, 6, 19),
(30, 7, 22);


INSERT INTO `behavior` (`id`, `kind_id`, `date_at`, `alumn_id`, `team_id`) VALUES
(4, 5, '2022-07-21', 1, 1),
(5, 3, '2022-07-21', 2, 1),
(6, 2, '2022-07-21', 7, 1),
(7, 1, '2022-07-22', 4, 12),
(8, 4, '2022-07-22', 10, 12),
(9, 5, '2022-07-22', 11, 15),
(10, 1, '2022-07-22', 12, 15),
(11, 3, '2022-07-22', 13, 15),
(12, 3, '2022-07-22', 14, 16),
(13, 1, '2022-07-22', 15, 16),
(14, 3, '2022-07-22', 16, 19),
(15, 3, '2022-07-24', 17, 22),
(16, 3, '2022-07-25', 18, 15),
(17, 3, '2022-07-25', 11, 15),
(18, 2, '2022-07-25', 12, 15),
(19, 2, '2022-07-25', 13, 15);


--
-- Volcado de datos para la tabla `calification`
--

INSERT INTO `calification` (`id`, `val`, `alumn_id`, `block_id`) VALUES
(11, 100, 1, 7),
(12, 100, 1, 8),
(13, 100, 1, 9),
(14, 79, 7, 7),
(15, 80, 7, 7),
(16, 20, 2, 10),
(17, 20, 9, 10),
(18, 20, 2, 11),
(19, 20, 9, 11),
(20, 20, 2, 12),
(21, 20, 9, 12),
(22, 60, 2, 13),
(23, 60, 9, 13),
(24, 10, 10, 14),
(25, 8, 12, 14),
(26, 10, 11, 14),
(27, 0, 14, 17),
(28, 15, 13, 17),
(29, 15, 14, 18),
(30, 10, 13, 18),
(31, 23, 10, 15),
(32, 23, 12, 15),
(33, 24, 11, 15),
(34, 10, 10, 16),
(35, 9, 12, 16),
(36, 6, 11, 16),
(37, 100, 17, 19),
(38, 89, 17, 20),
(39, 76, 15, 14),
(40, 70, 15, 15),
(41, 78, 15, 16),
(42, 80, 15, 21),
(43, 56, 10, 21),
(44, 89, 12, 21),
(45, 100, 11, 21),
(46, 20, 16, 22),
(47, 10, 15, 25),
(48, 10, 10, 25),
(49, 6, 12, 25),
(50, 10, 11, 25),
(51, 89, 15, 26),
(52, 89, 10, 26),
(53, 70, 12, 26),
(54, 70, 11, 26);

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `id_cliente`, `total`, `id_usuario`, `fecha`) VALUES
(1, 1, '16300.00', 1, '2021-08-09 21:01:45'),
(2, 1, '12000.00', 1, '2021-08-09 21:05:02'),
(3, 1, '9140.00', 1, '2021-08-09 21:10:23'),
(4, 1, '23550.00', 1, '2021-08-10 01:09:24'),
(5, 2, '5500.00', 1, '2021-08-10 01:25:27'),
(6, 1, '10430.00', 1, '2021-08-10 21:27:09'),
(7, 1, '8990.00', 16, '2021-08-10 21:31:50'),
(8, 2, '500.00', 16, '2022-07-23 07:29:23'),
(12, 7, '750000.00', 16, '2022-07-23 08:39:09'),
(13, 7, '500.00', 16, '2022-07-23 09:20:56'),
(14, 8, '500.00', 16, '2022-07-23 09:24:55'),
(15, 7, '1000.00', 16, '2022-07-23 09:36:20'),
(16, 8, '2700.00', 1, '2022-07-23 09:58:33'),
(17, 8, '2600.00', 1, '2022-07-23 10:16:39'),
(18, 9, '2000.00', 1, '2022-07-23 10:32:17'),
(19, 10, '2500.00', 1, '2022-07-24 10:54:51'),
(20, 10, '1000.00', 1, '2022-07-24 10:58:52'),
(21, 2, '1000.00', 1, '2022-07-24 10:59:17'),
(22, 8, '1500.00', 1, '2022-07-25 06:36:20'),
(23, 4, '1700.00', 1, '2022-07-25 08:09:11'),
(24, 8, '1450.00', 1, '2022-07-25 08:42:37'),
(25, 7, '1500.00', 1, '2022-07-25 08:49:31'),
(26, 7, '1000.00', 1, '2022-07-25 09:03:48'),
(27, 7, '5500.00', 1, '2022-07-25 09:08:25'),
(28, 7, '2050.00', 1, '2022-07-25 09:23:49'),
(29, 7, '1950.00', 1, '2022-07-25 09:27:02'),
(30, 7, '8700.00', 1, '2022-07-25 09:31:06'),
(31, 8, '3500.00', 1, '2022-07-25 09:32:19'),
(32, 7, '500.00', 1, '2022-07-25 09:33:17'),
(33, 10, '2300.00', 1, '2022-07-25 09:46:25'),
(34, 10, '3000.00', 1, '2022-07-25 09:47:48'),
(35, 8, '200.00', 13, '2022-07-25 10:02:00'),
(36, 8, '1500.00', 1, '2022-07-25 23:42:18'),
(37, 8, '500.00', 1, '2022-07-25 23:43:55'),
(38, 9, '2500.00', 13, '2022-07-26 00:04:34'),
(39, 9, '1500.00', 13, '2022-07-26 00:05:33'),
(40, 7, '1000.00', 1, '2022-07-26 04:59:33'),
(41, 8, '600.00', 13, '2022-07-26 05:32:16'),
(42, 8, '1500.00', 13, '2022-07-26 05:33:29'),
(43, 8, '800.00', 13, '2022-07-26 05:50:48'),
(44, 8, '1500.00', 13, '2022-07-26 22:14:09'),
(45, 1, '1000.00', 13, '2022-07-27 02:46:27'),
(46, 8, '2700.00', 13, '2022-07-27 21:02:00'),
(47, 10, '1700.00', 13, '2022-07-27 21:21:30'),
(48, 10, '1800.00', 13, '2022-07-28 02:50:50'),
(49, 8, '900.00', 13, '2022-07-28 03:00:39'),
(50, 11, '1500.00', 13, '2022-07-28 03:16:16');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividad`
--
ALTER TABLE `actividad`
  ADD PRIMARY KEY (`actividad_id`);

--
-- Indices de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD PRIMARY KEY (`alumno_id`),
  ADD KEY `user_id` (`user_id`) USING BTREE;

--
-- Indices de la tabla `alumno_usuario`
--
ALTER TABLE `alumno_usuario`
  ADD PRIMARY KEY (`ap_id`),
  ADD KEY `alumno_id` (`alumno_id`),
  ADD KEY `proceso_id` (`id_grupo`),
  ADD KEY `periodo_id` (`periodo_id`);

--
-- Indices de la tabla `aulas`
--
ALTER TABLE `aulas`
  ADD PRIMARY KEY (`aula_id`);

--
-- Indices de la tabla `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`id`);


--
-- Indices de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD PRIMARY KEY (`calificacion_id`),
  ADD KEY `alumno_id` (`alumno_id`),
  ADD KEY `materia_id` (`materia_id`),
  ADD KEY `periodo_id` (`periodo_id`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idcliente`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `contenidos`
--
ALTER TABLE `contenidos`
  ADD PRIMARY KEY (`contenido_id`),
  ADD KEY `pm_id` (`id_grupo`);

--
-- Indices de la tabla `detalle_permisos`
--
ALTER TABLE `detalle_permisos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_permiso` (`id_permiso`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `detalle_temp`
--
ALTER TABLE `detalle_temp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_venta` (`id_venta`);

--
-- Indices de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD PRIMARY KEY (`evaluacion_id`),
  ADD KEY `materia_id` (`materia_id`),
  ADD KEY `periodo_id` (`periodo_id`),
  ADD KEY `contenido_id` (`contenido_id`);

--
-- Indices de la tabla `ev_entregadas`
--
ALTER TABLE `ev_entregadas`
  ADD PRIMARY KEY (`ev_entregada_id`),
  ADD KEY `evaluacion_id` (`evaluacion_id`),
  ADD KEY `alumno_id` (`alumno_id`);

--
-- Indices de la tabla `fees_transaction`
--
ALTER TABLE `fees_transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `grados`
--
ALTER TABLE `grados`
  ADD PRIMARY KEY (`grado_id`);

--
-- Indices de la tabla `materias`
--
ALTER TABLE `materias`
  ADD PRIMARY KEY (`materia_id`);

--
-- Indices de la tabla `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`id_nota`),
  ADD KEY `id_alumno` (`id_alumno`),
  ADD KEY `id_segmento` (`id_segmento`),
  ADD KEY `id_grupo` (`id_grupo`) USING BTREE;

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `id_alumno` (`id_alumno`);

--
-- Indices de la tabla `periodos`
--
ALTER TABLE `periodos`
  ADD PRIMARY KEY (`periodo_id`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id`);



ALTER TABLE `team`
  ADD PRIMARY KEY (`idgrupo`),
  ADD KEY `team_ibfk_1` (`idusuario`);


--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`codproducto`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usuario_id`);

--
-- Indices de la tabla `usuario_materia`
--
ALTER TABLE `usuario_materia`
  ADD PRIMARY KEY (`id_grupo`),
  ADD KEY `grado_id` (`grado_id`),
  ADD KEY `aula_id` (`aula_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `materia_id` (`materia_id`),
  ADD KEY `periodo_id` (`periodo_id`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `segmentos`
--
ALTER TABLE `segmentos`
  ADD PRIMARY KEY (`id_segmento`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuario_id`),
  ADD KEY `rol` (`rol`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividad`
--
ALTER TABLE `actividad`
  MODIFY `actividad_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  MODIFY `alumno_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `alumno_usuario`
--
ALTER TABLE `alumno_usuario`
  MODIFY `ap_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `aulas`
--
ALTER TABLE `aulas`
  MODIFY `aula_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `branch`
--
ALTER TABLE `branch`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  MODIFY `calificacion_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idcliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `contenidos`
--
ALTER TABLE `contenidos`
  MODIFY `contenido_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `detalle_permisos`
--
ALTER TABLE `detalle_permisos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT de la tabla `detalle_temp`
--
ALTER TABLE `detalle_temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  MODIFY `evaluacion_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ev_entregadas`
--
ALTER TABLE `ev_entregadas`
  MODIFY `ev_entregada_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `fees_transaction`
--
ALTER TABLE `fees_transaction`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `grados`
--
ALTER TABLE `grados`
  MODIFY `grado_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `materias`
--
ALTER TABLE `materias`
  MODIFY `materia_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `notas`
--
ALTER TABLE `notas`
  MODIFY `id_nota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `periodos`
--
ALTER TABLE `periodos`
  MODIFY `periodo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `codproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usuario_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `usuario_materia`
--
ALTER TABLE `usuario_materia`
  MODIFY `id_grupo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `rol_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuario_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

ALTER TABLE `alumn_team`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alumn_id` (`alumn_id`),
  ADD KEY `team_id` (`team_id`);

--
-- Indices de la tabla `assistance`
--
ALTER TABLE `assistance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alumn_id` (`alumn_id`),
  ADD KEY `team_id` (`team_id`);

--
-- Indices de la tabla `behavior`
--
ALTER TABLE `behavior`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alumn_id` (`alumn_id`),
  ADD KEY `team_id` (`team_id`);

--
-- Indices de la tabla `block`
--
ALTER TABLE `block`
  ADD PRIMARY KEY (`id`),
  ADD KEY `team_id` (`team_id`);

--
-- Indices de la tabla `calification`
--
ALTER TABLE `calification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alumn_id` (`alumn_id`),
  ADD KEY `block_id` (`block_id`);






--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- Restricciones para tablas volcadas
--

ALTER TABLE `alumnos`
  ADD CONSTRAINT `alumn_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE;


--
-- Filtros para la tabla `alumno_usuario`
--
ALTER TABLE `alumno_usuario`
  ADD CONSTRAINT `alumno_usuario_ibfk_1` FOREIGN KEY (`alumno_id`) REFERENCES `alumnos` (`alumno_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `alumno_usuario_ibfk_2` FOREIGN KEY (`id_grupo`) REFERENCES `usuario_materia` (`id_grupo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `contenidos`
--
ALTER TABLE `contenidos`
  ADD CONSTRAINT `contenidos_ibfk_1` FOREIGN KEY (`id_grupo`) REFERENCES `usuario_materia` (`id_grupo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_permisos`
--
ALTER TABLE `detalle_permisos`
  ADD CONSTRAINT `detalle_permisos_ibfk_1` FOREIGN KEY (`id_permiso`) REFERENCES `permisos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_permisos_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_temp`
--
ALTER TABLE `detalle_temp`
  ADD CONSTRAINT `detalle_temp_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`codproducto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_temp_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`codproducto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD CONSTRAINT `evaluaciones_ibfk_1` FOREIGN KEY (`materia_id`) REFERENCES `materias` (`materia_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluaciones_ibfk_2` FOREIGN KEY (`periodo_id`) REFERENCES `periodos` (`periodo_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluaciones_ibfk_3` FOREIGN KEY (`contenido_id`) REFERENCES `contenidos` (`contenido_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ev_entregadas`
--
ALTER TABLE `ev_entregadas`
  ADD CONSTRAINT `ev_entregadas_ibfk_1` FOREIGN KEY (`evaluacion_id`) REFERENCES `evaluaciones` (`evaluacion_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ev_entregadas_ibfk_2` FOREIGN KEY (`alumno_id`) REFERENCES `alumnos` (`alumno_id`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `alumn_team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `assistance`
--
ALTER TABLE `assistance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `behavior`
--
ALTER TABLE `behavior`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;


ALTER TABLE `team`
  MODIFY `idgrupo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;


ALTER TABLE `alumn_team`
  ADD CONSTRAINT `alumn_team_ibfk_1` FOREIGN KEY (`alumn_id`) REFERENCES `alumnos` (`alumno_id`),
  ADD CONSTRAINT `alumn_team_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `team` (`idgrupo`);

--
-- Filtros para la tabla `assistance`
--
ALTER TABLE `assistance`
  ADD CONSTRAINT `assistance_ibfk_1` FOREIGN KEY (`alumn_id`) REFERENCES `alumnos` (`alumno_id`),
  ADD CONSTRAINT `assistance_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `team` (`idgrupo`);

--
-- Filtros para la tabla `behavior`
--
ALTER TABLE `behavior`
  ADD CONSTRAINT `behavior_ibfk_1` FOREIGN KEY (`alumn_id`) REFERENCES `alumnos` (`alumno_id`),
  ADD CONSTRAINT `behavior_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `team` (`idgrupo`);

--
-- Filtros para la tabla `block`
--
ALTER TABLE `block`
  ADD CONSTRAINT `block_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `team` (`idgrupo`);

--
-- Filtros para la tabla `calification`
--
ALTER TABLE `calification`
  ADD CONSTRAINT `calification_ibfk_1` FOREIGN KEY (`alumn_id`) REFERENCES `alumnos` (`alumno_id`),
  ADD CONSTRAINT `calification_ibfk_2` FOREIGN KEY (`block_id`) REFERENCES `block` (`id`);

--
-- Filtros para la tabla `team`
--
ALTER TABLE `team`
  ADD CONSTRAINT `team_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`usuario_id`);


--
-- AUTO_INCREMENT de la tabla `block`
--
ALTER TABLE `block`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `calification`
--
ALTER TABLE `calification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;




--
-- Filtros para la tabla `notas`
--
ALTER TABLE `notas`
  ADD CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumnos` (`alumno_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `notas_ibfk_2` FOREIGN KEY (`id_grupo`) REFERENCES `usuario_materia` (`id_grupo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `notas_ibfk_3` FOREIGN KEY (`id_segmento`) REFERENCES `segmentos` (`id_segmento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumnos` (`alumno_id`);

--
-- Filtros para la tabla `usuario_materia`
--
ALTER TABLE `usuario_materia`
  ADD CONSTRAINT `usuario_materia_ibfk_1` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`aula_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuario_materia_ibfk_2` FOREIGN KEY (`grado_id`) REFERENCES `grados` (`grado_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuario_materia_ibfk_3` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuario_materia_ibfk_4` FOREIGN KEY (`materia_id`) REFERENCES `materias` (`materia_id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol`) REFERENCES `rol` (`rol_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`idcliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
