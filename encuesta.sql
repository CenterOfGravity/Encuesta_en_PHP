-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 09, 2021 at 12:42 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `encuesta`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_by_filter` (IN `sexo` VARCHAR(20), IN `edad` VARCHAR(20), IN `salario` VARCHAR(20), IN `provincia` VARCHAR(20))  SELECT
    DISTINCT grupo_respuesta, id, id_pregunta, respuesta
FROM
    `respuestas`
WHERE
    respuesta = sexo
    or respuesta = edad
    or respuesta = salario
    or respuesta = provincia$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_preguntas_comunes` ()  Select * from preguntas WHERE id <= 4$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_preguntas_random` ()  SELECT * FROM preguntas WHERE id>=5
ORDER BY RAND()
LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_select_answer` (IN `id_par` SMALLINT(5))  BEGIN 
    select respuestas FROM preguntas WHERE id = id_par;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_resp` (IN `grupo` BIGINT(50), IN `pregunta` INT(50), IN `respuesta` VARCHAR(50))  INSERT INTO `respuestas` (`grupo_respuesta`, `id_pregunta`, `respuesta`) VALUES (grupo,pregunta,respuesta)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_preguntas` (IN `param_numero` INT(5), IN `param_pregunta` VARCHAR(200), IN `param_tipo` VARCHAR(50), IN `param_respuestas` VARCHAR(500))  BEGIN

update preguntas 

set 
    pregunta = param_pregunta, 
    tipo = param_tipo, 
    respuestas = param_respuestas 

where id = param_numero;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultar_preguntas` ()  BEGIN 
    select id, numero, pregunta, tipo, respuestas from preguntas order by id ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_preguntas` (IN `param_numero` SMALLINT(5))  BEGIN
    DELETE from preguntas where id = param_numero;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_find_by_id` (IN `id_param` INT(3))  select * from preguntas where id=id_param$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getpolls_totals` ()  BEGIN
	SELECT COUNT(DISTINCT grupo_respuesta) FROM respuestas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_by_filter` (IN `sexo` VARCHAR(20), IN `edad` VARCHAR(20), IN `salario` VARCHAR(20), IN `provincia` VARCHAR(20))  SELECT
    COUNT(DISTINCT grupo_respuesta)
FROM
    `respuestas`
WHERE
    respuesta = sexo
    or respuesta = edad
    or respuesta = salario
    or respuesta = provincia$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_preguntas` (IN `param_pregunta` VARCHAR(200), IN `param_tipo` VARCHAR(50), IN `param_respuestas` VARCHAR(500))  BEGIN 
    insert into preguntas (pregunta, tipo, respuestas) VALUES (param_pregunta, param_tipo, param_respuestas); 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `preguntas`
--

CREATE TABLE `preguntas` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `numero` int(5) NOT NULL,
  `pregunta` varchar(200) NOT NULL DEFAULT '',
  `tipo` varchar(50) NOT NULL,
  `respuestas` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `preguntas`
--

INSERT INTO `preguntas` (`id`, `numero`, `pregunta`, `tipo`, `respuestas`) VALUES
(1, 0, '¿Cuál es tu rango salarial?', 'Elección simple', '...-500,501-800,801-1000,1001-1500,1501-2000'),
(2, 0, '¿En que rango de edad te encuentras?', 'Elección simple', '...-20,21-30,31-40,41-...'),
(3, 0, '¿Sexo?', 'Elección simple', 'Masculino,Femenino'),
(4, 0, '¿Provincia de residencia?', 'Elección simple', 'Bocas del Toro,Chiriquí,Coclé,Colón,Darién,Herrera,Los Santos,Panamá,Veraguas,Emberá-Wounaan,Kuna de Madugandí,Kuna Yala,Kuna de Wargandí,Ngöbe-Buglé'),
(7, 6, '¿Eres estudiante universitario?', 'Elección binaria', 'Si,No'),
(8, 7, '¿Tienes vida propia?', 'Elección simple', 'si,no,digo que si pero no,mi mama dice que no hago nada'),
(9, 4, '¿Que tipo de comidas prefieres?', 'Elección múltiple', 'asados,herbidos,guisados,tostados'),
(21, 21, '¿te gusta el café?', 'Elección binaria', 'Si,No'),
(22, 0, '¿Estas dentro del grupo?', 'Elección múltiple', 'de vez en cuando,retiré,ahi mas o meos'),
(23, 0, 'Baby', 'Elección simple', 'te quiero wuo wuo, la vida eh un ciclo, shark tutururuturu, me rehuso a darle un beso asi que guarda'),
(27, 0, '¿Tienes Mascotas?', 'Elección binaria', 'Si,No'),
(28, 0, '¿Cuantos libros lees al mes?', 'Elección simple', '1,2,3,4,5'),
(29, 0, '¿Hacia que familia eres mas afin?', 'Elección simple', 'Mamá,Papá,Ambas'),
(30, 0, '¿En que tipo de vehículos haz viajado?', 'Elección múltiple', 'Bicicleta,Moto,Carro,Barco,Avión'),
(31, 0, '¿Que marca de celulares prefieres?', 'Elección simple', 'Iphone,Xiaomi,Samsung,Huawei'),
(32, 0, '¿Actualmente Laboras?', 'Elección binaria', 'Si,No'),
(33, 0, '¿Con que lenguajes de programación te sientes mejor?', 'Elección múltiple', 'Java,PHP,C#,.Net'),
(34, 0, '¿Que estacion del año te gusta mas?', 'Elección simple', 'Invierno,Verano'),
(35, 0, '¿Te puedes quedar despierto hasta tarde?', 'Elección simple', 'Sí,No,Depende para que'),
(36, 0, '¿Que hiciste en fiestas patrias?', 'Elección simple', 'Logré pasear,Los proyectos de la u no me dejaron hacer nada,tuve que trabajar'),
(37, 0, '¿Cuál es tu banco principal?', 'Elección simple', 'Banistmo,BG,Banco Nacional,Caja de Ahorros'),
(38, 0, '¿Cuantas llantas tiene un carro de 4 llantas?', 'Elección simple', '3,4,5,6'),
(39, 0, '¿Que ambiente prefieres?', 'Elección simple', 'Rio,Playa,Bosque,Lago'),
(42, 0, '¿Cuáles son platos típicos de panamá?', 'Elección múltiple', 'Caldo Verde,Sancocho,Bandeja Paisa,Arroz con pollo,Pupusas,Tamales,Arepas'),
(43, 0, '¿Ingredientes favoritos para una pizza?', 'Elección múltiple', 'Pollo,Aceitunas,Peperoni,Carne,Piña,Cebolla'),
(47, 0, '¿Que equipo usas actualmente?', 'Elección simple', 'PC,Laptop,Celular');

-- --------------------------------------------------------

--
-- Table structure for table `respuestas`
--

CREATE TABLE `respuestas` (
  `id` int(11) NOT NULL,
  `grupo_respuesta` bigint(50) NOT NULL,
  `id_pregunta` int(20) NOT NULL,
  `respuesta` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `respuestas`
--

INSERT INTO `respuestas` (`id`, `grupo_respuesta`, `id_pregunta`, `respuesta`) VALUES
(77, 163614390269, 1, '1501-2000'),
(78, 163614390269, 2, '21-30'),
(79, 163614390269, 3, 'Masculino'),
(80, 163614390269, 4, 'Panamá'),
(81, 163614390269, 22, 'de vez en cuando'),
(82, 163614390269, 22, 'ahi mas o meos'),
(83, 163614390269, 47, 'Laptop'),
(84, 163614390269, 23, ' la vida eh un ciclo'),
(85, 163614390269, 33, 'Java'),
(86, 163614390269, 33, '.Net'),
(87, 163614390269, 34, 'Invierno'),
(88, 163614390269, 37, 'Banistmo'),
(89, 163614390269, 38, '4'),
(90, 163614390269, 36, 'Los proyectos de la u no me dejaron hacer nada'),
(91, 163614390269, 42, 'Sancocho'),
(92, 163614390269, 42, 'Arroz con pollo'),
(93, 163614390269, 42, 'Tamales'),
(94, 163614390269, 27, 'Si'),
(95, 163614431171, 1, '1001-1500'),
(96, 163614431171, 2, '31-40'),
(97, 163614431171, 3, 'Femenino'),
(98, 163614431171, 4, 'Chiriquí'),
(99, 163614431171, 39, 'Rio'),
(100, 163614431171, 23, ' la vida eh un ciclo'),
(101, 163614431171, 43, 'Pollo'),
(102, 163614431171, 43, 'Aceitunas'),
(103, 163614431171, 43, 'Carne'),
(104, 163614431171, 47, 'PC'),
(105, 163614431171, 36, 'tuve que trabajar'),
(106, 163614431171, 38, '4'),
(107, 163614431171, 31, 'Xiaomi'),
(108, 163614431171, 32, 'Si'),
(109, 163614431171, 35, 'Depende para que'),
(110, 163614431171, 30, 'Moto'),
(111, 163614431171, 30, 'Carro'),
(112, 163614431171, 30, 'Barco'),
(113, 163614431171, 30, 'Avión'),
(114, 163614481594, 1, '1001-1500'),
(115, 163614481594, 2, '31-40'),
(116, 163614481594, 3, 'Femenino'),
(117, 163614481594, 4, 'Chiriquí'),
(118, 163614481594, 39, 'Rio'),
(119, 163614481594, 23, ' la vida eh un ciclo'),
(120, 163614481594, 43, 'Pollo'),
(121, 163614481594, 43, 'Aceitunas'),
(122, 163614481594, 43, 'Carne'),
(123, 163614481594, 47, 'PC'),
(124, 163614481594, 36, 'tuve que trabajar'),
(125, 163614481594, 38, '4'),
(126, 163614481594, 31, 'Xiaomi'),
(127, 163614481594, 32, 'Si'),
(128, 163614481594, 35, 'Depende para que'),
(129, 163614481594, 30, 'Moto'),
(130, 163614481594, 30, 'Carro'),
(131, 163614481594, 30, 'Barco'),
(132, 163614481594, 30, 'Avión');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `preguntas`
--
ALTER TABLE `preguntas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `preguntas`
--
ALTER TABLE `preguntas`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=246;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
