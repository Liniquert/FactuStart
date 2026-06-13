-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: factustart
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `boleta_electronica`
--

DROP TABLE IF EXISTS `boleta_electronica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boleta_electronica` (
  `id_comprobante` int NOT NULL,
  `dni_cliente` varchar(8) DEFAULT NULL,
  `nombre_cliente` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_comprobante`),
  CONSTRAINT `boleta_electronica_ibfk_1` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobante` (`id_comprobante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boleta_electronica`
--

LOCK TABLES `boleta_electronica` WRITE;
/*!40000 ALTER TABLE `boleta_electronica` DISABLE KEYS */;
/*!40000 ALTER TABLE `boleta_electronica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `id_negocio` int NOT NULL,
  `tipo_documento` varchar(20) DEFAULT NULL,
  `numero_documento` varchar(20) DEFAULT NULL,
  `razon_social_nombre` varchar(150) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`),
  KEY `id_negocio` (`id_negocio`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`id_negocio`) REFERENCES `negocio` (`id_negocio`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,1,'DNI','47369837','jordy','malvaviscos','hliniquert18@hotmail.com','986788556','2026-06-03 23:44:31'),(2,1,'DNI','20601131278','grans s.a.c','san isidro','ventas@grans.pe','93567849','2026-06-03 23:45:24'),(3,2,'DNI','4569871','manuel','','','','2026-06-06 20:16:17'),(4,2,'DNI','258566554','lucas','','','','2026-06-07 15:22:44'),(5,6,'DNI','231546','balder','','','','2026-06-07 15:51:44'),(6,6,'RUC','2587463315465','los rosales','las calenduas 196','','','2026-06-07 15:52:22'),(7,7,'DNI','456222222','balder','','','','2026-06-09 18:10:01'),(8,6,'DNI','132156464','lucas','','','','2026-06-09 18:25:22'),(9,6,'RUC','2525444554','chocolates','san isidro','','','2026-06-09 18:25:50'),(10,6,'DNI','12555454','piero','','','','2026-06-09 18:54:32'),(11,6,'RUC','2545452222','rosas sac','lince','','','2026-06-09 18:55:19');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comprobante`
--

DROP TABLE IF EXISTS `comprobante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comprobante` (
  `id_comprobante` int NOT NULL AUTO_INCREMENT,
  `id_negocio` int NOT NULL,
  `id_cliente` int NOT NULL,
  `tipo_comprobante` varchar(20) DEFAULT NULL,
  `serie` varchar(10) DEFAULT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `fecha_emision` datetime DEFAULT CURRENT_TIMESTAMP,
  `moneda` varchar(10) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `igv` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `forma_pago` varchar(50) DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `observacion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_comprobante`),
  KEY `id_negocio` (`id_negocio`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `comprobante_ibfk_1` FOREIGN KEY (`id_negocio`) REFERENCES `negocio` (`id_negocio`),
  CONSTRAINT `comprobante_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comprobante`
--

LOCK TABLES `comprobante` WRITE;
/*!40000 ALTER TABLE `comprobante` DISABLE KEYS */;
INSERT INTO `comprobante` VALUES (1,2,1,'BOLETA','B001','00000001','2026-06-06 16:26:46','PEN',18.00,0.00,18.00,'CONTADO','EMITIDO','Comprobante generado desde FactuStart'),(2,2,1,'BOLETA','B001','00000002','2026-06-06 17:18:40','PEN',2.00,0.00,2.00,'CONTADO','EMITIDO','Comprobante generado desde FactuStart'),(3,2,1,'BOLETA','B001','00000003','2026-06-06 17:19:06','PEN',22.00,0.00,22.00,'CONTADO','EMITIDO','Comprobante generado desde FactuStart'),(4,2,1,'FACTURA','F001','00000001','2026-06-06 17:19:37','PEN',15.00,2.70,17.70,'CONTADO','EMITIDO','Comprobante generado desde FactuStart'),(5,2,3,'BOLETA','B001','00000004','2026-06-06 20:16:17','PEN',450.00,0.00,450.00,'CONTADO','EMITIDO','Comprobante generado desde FactuStart'),(6,2,4,'BOLETA','B001','00000005','2026-06-07 15:22:44','PEN',90.00,0.00,90.00,'CONTADO','EMITIDO','Comprobante generado desde FactuStart'),(7,6,5,'BOLETA','B001','00000006','2026-06-07 15:51:44','PEN',7.50,0.00,7.50,'CONTADO','EMITIDO','Comprobante generado desde FactuStart'),(8,6,6,'FACTURA','F001','00000002','2026-06-07 15:52:22','PEN',6.00,1.08,7.08,'CONTADO','EMITIDO','Comprobante generado desde FactuStart'),(9,7,7,'BOLETA','B001','00000007','2026-06-09 18:10:01','PEN',3.00,0.00,3.00,'CONTADO','EMITIDO','Comprobante generado desde FactuStart'),(10,6,8,'BOLETA','B001','00000008','2026-06-09 18:25:22','PEN',15.00,0.00,15.00,'CONTADO','EMITIDO','Comprobante generado desde FactuStart'),(11,6,9,'FACTURA','F001','00000003','2026-06-09 18:25:50','PEN',24.00,4.32,28.32,'CONTADO','EMITIDO','Comprobante generado desde FactuStart'),(12,6,10,'BOLETA','B001','00000009','2026-06-09 18:54:32','PEN',31.00,0.00,31.00,'CONTADO','EMITIDO','Comprobante generado desde FactuStart'),(13,6,11,'FACTURA','F001','00000004','2026-06-09 18:55:19','PEN',25.00,4.50,29.50,'CONTADO','EMITIDO','Comprobante generado desde FactuStart');
/*!40000 ALTER TABLE `comprobante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_comprobante`
--

DROP TABLE IF EXISTS `detalle_comprobante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_comprobante` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_comprobante` int NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `descuento` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_comprobante` (`id_comprobante`),
  CONSTRAINT `detalle_comprobante_ibfk_1` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobante` (`id_comprobante`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_comprobante`
--

LOCK TABLES `detalle_comprobante` WRITE;
/*!40000 ALTER TABLE `detalle_comprobante` DISABLE KEYS */;
INSERT INTO `detalle_comprobante` VALUES (1,1,'palo',6,3.00,0.00,18.00),(2,2,'palo',1,2.00,0.00,2.00),(3,3,'borrador',6,3.00,0.00,18.00),(4,3,'lapiz',4,1.00,0.00,4.00),(5,4,'palo',5,3.00,0.00,15.00),(6,5,'trabajos de reparacion',1,450.00,0.00,450.00),(7,6,'palo',6,15.00,0.00,90.00),(8,7,'lapiz',5,1.50,0.00,7.50),(9,8,'borrador',5,1.20,0.00,6.00),(10,9,'borrador',2,1.50,0.00,3.00),(11,10,'lapiz',1,5.00,0.00,5.00),(12,10,'borrador',5,2.00,0.00,10.00),(13,11,'palo',4,6.00,0.00,24.00),(14,12,'palo de escoba',5,6.20,0.00,31.00),(15,13,'ramo de rosa',1,20.00,0.00,20.00),(16,13,'girasoles',2,2.50,0.00,5.00);
/*!40000 ALTER TABLE `detalle_comprobante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura_electronica`
--

DROP TABLE IF EXISTS `factura_electronica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura_electronica` (
  `id_comprobante` int NOT NULL,
  `ruc_cliente` varchar(11) DEFAULT NULL,
  `razon_social_cliente` varchar(150) DEFAULT NULL,
  `direccion_fiscal_cliente` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_comprobante`),
  CONSTRAINT `factura_electronica_ibfk_1` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobante` (`id_comprobante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura_electronica`
--

LOCK TABLES `factura_electronica` WRITE;
/*!40000 ALTER TABLE `factura_electronica` DISABLE KEYS */;
/*!40000 ALTER TABLE `factura_electronica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_comprobante`
--

DROP TABLE IF EXISTS `historial_comprobante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_comprobante` (
  `id_historial` int NOT NULL AUTO_INCREMENT,
  `id_comprobante` int DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  `accion` varchar(50) DEFAULT NULL,
  `detalle` text,
  `fecha_accion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_historial`),
  KEY `id_comprobante` (`id_comprobante`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `historial_comprobante_ibfk_1` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobante` (`id_comprobante`),
  CONSTRAINT `historial_comprobante_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_comprobante`
--

LOCK TABLES `historial_comprobante` WRITE;
/*!40000 ALTER TABLE `historial_comprobante` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial_comprobante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integracion_sunat`
--

DROP TABLE IF EXISTS `integracion_sunat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `integracion_sunat` (
  `id_integracion` int NOT NULL AUTO_INCREMENT,
  `id_comprobante` int DEFAULT NULL,
  `fecha_envio` datetime DEFAULT NULL,
  `estado_sunat` varchar(30) DEFAULT NULL,
  `mensaje_validacion` text,
  `codigo_respuesta` varchar(20) DEFAULT NULL,
  `cdr_url` varchar(255) DEFAULT NULL,
  `fecha_respuesta` datetime DEFAULT NULL,
  PRIMARY KEY (`id_integracion`),
  KEY `id_comprobante` (`id_comprobante`),
  CONSTRAINT `integracion_sunat_ibfk_1` FOREIGN KEY (`id_comprobante`) REFERENCES `comprobante` (`id_comprobante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integracion_sunat`
--

LOCK TABLES `integracion_sunat` WRITE;
/*!40000 ALTER TABLE `integracion_sunat` DISABLE KEYS */;
/*!40000 ALTER TABLE `integracion_sunat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `negocio`
--

DROP TABLE IF EXISTS `negocio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `negocio` (
  `id_negocio` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `razon_social` varchar(150) DEFAULT NULL,
  `ruc` varchar(11) DEFAULT NULL,
  `direccion_fiscal` varchar(200) DEFAULT NULL,
  `correo_contacto` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `estado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_negocio`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `negocio_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `negocio`
--

LOCK TABLES `negocio` WRITE;
/*!40000 ALTER TABLE `negocio` DISABLE KEYS */;
INSERT INTO `negocio` VALUES (1,1,'FactuStart Demo','20123456789','Av. Principal 123','contacto@factustart.com','999999999','2026-06-03 23:37:17','INACTIVO'),(2,1,'20601131277','masventas','san miguel','correo@gmail.com','986755886','2026-06-04 00:08:05','INACTIVO'),(3,3,'pruebaaaa','12346785522','lima','prueba@gmail.com','369852147','2026-06-04 12:49:44','ACTIVO'),(4,4,'pasteles','12346546899','san isidro','carlos@hotmail.com','98564655','2026-06-04 21:16:22','ACTIVO'),(5,5,'luz sac','7898452133','san miguel','luz@hotmail.com','1654894616','2026-06-04 21:37:05','ACTIVO'),(6,6,'VENTAS LUCHITO S.A.C.','271593648','AV.CENTRAL 159 - SAN ISIDRO','ventasluchito@hotmail.com','986788556','2026-06-06 22:43:42','ACTIVO'),(7,1,'FactuStart Demo','20123456789','Av. Principal 123','contacto@factustart.com','999999999','2026-06-09 17:57:10','ACTIVO');
/*!40000 ALTER TABLE `negocio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recuperacion_password`
--

DROP TABLE IF EXISTS `recuperacion_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recuperacion_password` (
  `id_recuperacion` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `fecha_expiracion` datetime DEFAULT NULL,
  `usado` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_recuperacion`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `recuperacion_password_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recuperacion_password`
--

LOCK TABLES `recuperacion_password` WRITE;
/*!40000 ALTER TABLE `recuperacion_password` DISABLE KEYS */;
/*!40000 ALTER TABLE `recuperacion_password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporte_venta`
--

DROP TABLE IF EXISTS `reporte_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporte_venta` (
  `id_reporte` int NOT NULL AUTO_INCREMENT,
  `id_negocio` int DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `total_ventas` decimal(10,2) DEFAULT NULL,
  `total_comprobantes` int DEFAULT NULL,
  `fecha_generacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_reporte`),
  KEY `id_negocio` (`id_negocio`),
  CONSTRAINT `reporte_venta_ibfk_1` FOREIGN KEY (`id_negocio`) REFERENCES `negocio` (`id_negocio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporte_venta`
--

LOCK TABLES `reporte_venta` WRITE;
/*!40000 ALTER TABLE `reporte_venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporte_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `rol` varchar(30) DEFAULT 'EMPRENDEDOR',
  `estado` varchar(20) DEFAULT 'ACTIVO',
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `ultimo_acceso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Administrador FactuStart','admin@gmail.com','123456','ADMIN','ACTIVO','2026-06-03 22:13:37',NULL),(2,'liniquert','prueba@gmail.com','123456789','EMPRENDEDOR','ACTIVO','2026-06-04 09:53:27',NULL),(3,'luis','hola@gmail.com','123456','EMPRENDEDOR','ACTIVO','2026-06-04 12:49:00',NULL),(4,'carlos','carlos@hotmail.com','123456789','EMPRENDEDOR','ACTIVO','2026-06-04 21:15:50',NULL),(5,'luz','luz@hotail.com','123456','EMPRENDEDOR','ACTIVO','2026-06-04 21:36:42',NULL),(6,'liniquert herrera','hliniquert18@hotmail.com','123456789a','EMPRENDEDOR','ACTIVO','2026-06-06 22:41:48',NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-12 19:08:13
