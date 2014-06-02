-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.6.13-enterprise-commercial-advanced-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `candidato`
--

DROP TABLE IF EXISTS `candidato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `candidato` (
  `idCandidato` int(11) NOT NULL AUTO_INCREMENT,
  `CURP` varchar(25) DEFAULT NULL,
  `RFC` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Tecnologia` varchar(200) DEFAULT NULL,
  `PalabrasClave` varchar(200) DEFAULT NULL,
  `Persona_idPersona` int(11) NOT NULL,
  `Reclutador_idReclutador` int(11) NOT NULL,
  `Fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCandidato`),
  KEY `fk_Candidato_Persona1_idx` (`Persona_idPersona`),
  KEY `fk_Candidato_Reclutador1_idx` (`Reclutador_idReclutador`),
  CONSTRAINT `fk_Candidato_Persona1` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Candidato_Reclutador1` FOREIGN KEY (`Reclutador_idReclutador`) REFERENCES `reclutador` (`idReclutador`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidato`
--

LOCK TABLES `candidato` WRITE;
/*!40000 ALTER TABLE `candidato` DISABLE KEYS */;
INSERT INTO `candidato` VALUES (68,'SADA920615HDFRRU91','SADA920615HDF','andres@gmail.com','111111111','tec1, tec2, tec3, tec4, tec5, tec6, tec7','clave1, clave2, clave3, clave4, clave5',131,3,'2014-04-14 14:01:35'),(69,'PECN920414MDFRRY01','PECN920414MDF','nay@gmail.com','74100258','tec1, tec2, tec3','clave1, clave2, clave3',132,53,'2014-04-14 14:02:36'),(70,'SIRR920715HDFRRY01','SIRR920715HDF','rafa@gmail.com','78543298','aaaaa\naaaaaa\naaaaaaa\naaaaaaaa\naaaaaaaaa\naaaaaaaaaa','bb\nbbb\nbbbb\nbbbbb\nbbbbbb\nbbbbbbb',133,55,'2014-04-14 14:05:59'),(71,'ANCE911224HDFJSO98','ANCE911224HDS','jemma@gmail.com','96856956','www\nwwww\nwwwww\nwwwwww','rrrrrrrrr\nrrrrrr\nrrr',134,55,'2014-04-14 14:07:56'),(72,'AGGR900617HCHMLI91','AGGR900617HCH','ricardo@gmail.com','14-12-51-23','tecnologia, tecnologia2, tecnologia3, tecnologia4, tecnologia5','pc1, pc2, pc3',137,53,'2014-04-29 15:30:28'),(73,'RUGD880512HCOKDY73','RUGD880512HCO','dani@gmail.com','5555555555','aaaaaaaaaaaaa','ccccccccccccc',138,53,'2014-04-29 14:43:39'),(74,'BASA920517HEMHTU12','BASA920517HEM','beto@gmail.com','77889965','papapa','mamama',139,55,'2014-04-14 14:47:31'),(75,'MASV124578HDFUTK91','MASV124578HDF','vick@gmail.coom','10102230','tec1, tec2, tec3','clave1, clave2, clave3',140,3,'2014-04-14 14:49:35'),(76,'BEBJ921122HDFPWO91','BEBJ921122HDF','juan@gmail.com','00212351','aaaaaaa','bbb\nmmmmmmm\nnnnnnnn\nddddddddd',141,53,'2014-04-14 14:51:34'),(77,'DAZC920426MVEKSU92','DAZC920426MVE','cin@gmail.com','12111210001','tskk,. asd, aksk, alslsls, lslsl','papapa, skksks, jdjdjjd, fjfjf',142,53,'2014-04-14 14:53:24'),(78,'GUED911021MDFKTG94','GUED911021MDF','dahli@aol.fr','23555656941','asñs, sksksk, skksks, slslsls, ksksks, ahhhh','tengo sssssssssssss, sssiii, alal',143,53,'2014-04-14 14:56:19'),(79,'MOBI920365MDFRRJ82','MOBI920365MDF','itzel@gmail.com','14141012','azaza\nasdsa\nfdg','gfdg\ndfgfdhg\nb vvn\nfgfgh',144,3,'2014-04-14 15:00:51'),(81,'BUHC870452MDFRRU84','BUHC870452MDS','carmen@gmail.com','110023200','asas','assssssssss',146,53,'2014-04-14 16:27:49'),(83,'BARJ930324MDFJJR82','BARJ930324MDF','joana@gmail.cpom','45213336598','sadas','aaaaaaaaaaa',148,53,'2014-04-14 16:29:34'),(84,'HESC920124HDFRUI87','HESC920124HDF','charly@gmail.com','7778995564','hola, dasldla.. as','asdk, aksk, aksks',149,53,'2014-04-14 16:30:29'),(85,'RERI920518HFERRT87','RERI920518HFE','irving@gmail.com','0445589632156','tecA, tecB, tecC, tecD, tecE, tecF','claveA, claveB, claveC, claveD',158,53,'2014-04-29 14:43:57'),(87,'PECN920414MFGRRT67','PECN920414MFG','xime@aol.de','78945621','asdadd','dddddddddd',160,53,'2014-04-22 16:22:05'),(88,'LOAX880517MDRGGT81','LOAX880517MDR','xime@gmail.com','4141445523','T1, T2, T3. T4','P1, P2, P3, P4',161,53,'2014-04-29 13:35:44'),(89,'PECI901003HDFRRY01','PECI901003HDF','heytunolosabess@hotmail.com','11487855','tec1, tec2','pal1, pal2',162,53,'2014-04-29 13:41:28'),(90,'PECN920414MDFRRY02','PECN920414PSO','naye_ddino@hotmail.com','525529036317','function (a){var c,d,e,f=this[0];if(!arguments.length){if(f)return c=p.valHooks[f.type]||p.valHooks[f.nodeName.toLowerCase()],c','ssadasdasd',163,3,'2014-05-02 15:55:46');
/*!40000 ALTER TABLE `candidato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidato_has_tecnologia`
--

DROP TABLE IF EXISTS `candidato_has_tecnologia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `candidato_has_tecnologia` (
  `idTecnologia` int(11) NOT NULL,
  `idCandidato` int(11) NOT NULL,
  KEY `fk_idTecnologia_idx` (`idTecnologia`),
  KEY `fk_idCandidatoa_idx` (`idCandidato`),
  CONSTRAINT `fk_idTecnologia_idx` FOREIGN KEY (`idTecnologia`) REFERENCES `tecnologia` (`idTecnologia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_idCandidatoa_idx` FOREIGN KEY (`idCandidato`) REFERENCES `candidato` (`idCandidato`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidato_has_tecnologia`
--

LOCK TABLES `candidato_has_tecnologia` WRITE;
/*!40000 ALTER TABLE `candidato_has_tecnologia` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidato_has_tecnologia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persona` (
  `idPersona` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(20) DEFAULT NULL,
  `ApePaterno` varchar(20) DEFAULT NULL,
  `ApeMaterno` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idPersona`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (37,'ANA','LÓPEZ',''),(102,'KARLA AZUCENA','JUÁREZ','NÚÑEZ'),(106,'JUAN','TELLEZ','ROSAS'),(131,'ANDRÉS ARTURO','SÁNCHEZ','DORANTES'),(132,'NAYELLI VALERIA','PÉREZ','CORONA'),(133,'RAFAEL','SILVA','REYES'),(134,'JESÚS EMMANUEL','ÁNGELES','CAMACHO'),(137,'RICARDO','AGUILAR','GRAJEDA'),(138,'DANIEL','RUGELES',''),(139,'ALBERTO','BARRADAS','SPEZZIA'),(140,'VÍCTOR','MARTÍNEZ','SÁNCHEZ'),(141,'JUAN','BECERRA','BECERRA'),(142,'CINTHYA','DEL ÁNGEL','ZUVIRIE'),(143,'DAHLIA','GUERRI',''),(144,'ITZEL IRAIS','MONTIEL','BERNAL'),(146,'CARMEN LUCÍA','BUSTILLO','HERNÁNDEZ'),(148,'JOANA','BARRAGAN',''),(149,'CARLOS','HERNÁNDEZ','SALDAÑA'),(158,'IRVING','RIVERA','REYES'),(160,'XIMENA TONANTZIN','ECHEVERRÍA','MIJARES'),(161,'XIMENA','LÓPEZ','ARAUJO'),(162,'ISRAEL','PEREZ','CORONA'),(163,'SDDF','DSFSDF','DSFSDF');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reclutador`
--

DROP TABLE IF EXISTS `reclutador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reclutador` (
  `idReclutador` int(11) NOT NULL AUTO_INCREMENT,
  `Usuario` varchar(20) DEFAULT NULL,
  `Password` varchar(20) DEFAULT NULL,
  `Persona_idPersona` int(11) NOT NULL,
  `Admin` int(11) NOT NULL,
  PRIMARY KEY (`idReclutador`),
  KEY `fk_Reclutador_Persona_idx` (`Persona_idPersona`),
  CONSTRAINT `fk_Reclutador_Persona` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reclutador`
--

LOCK TABLES `reclutador` WRITE;
/*!40000 ALTER TABLE `reclutador` DISABLE KEYS */;
INSERT INTO `reclutador` VALUES (3,'ana','ana123',37,1),(53,'karla','karla123',102,0),(55,'atellez18','50815081',106,1);
/*!40000 ALTER TABLE `reclutador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tecnologia`
--

DROP TABLE IF EXISTS `tecnologia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tecnologia` (
  `idTecnologia` int(11) NOT NULL AUTO_INCREMENT,
  `nombreTecnologia` varchar(50) DEFAULT NULL,
  `descripcionTecnologia` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`idTecnologia`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tecnologia`
--

LOCK TABLES `tecnologia` WRITE;
/*!40000 ALTER TABLE `tecnologia` DISABLE KEYS */;
INSERT INTO `tecnologia` VALUES (1,'JAVA','lenguaje de programación orientado a objetos'),(2,'C  ','Lenguaje'),(4,'C#','laslalslas'),(5,'RUBY','ksdfkdslfksdlkdfjskldjf'),(6,'PYTHON','kasa ksjdj kasjd'),(7,'COBOL','ksdjksdjksd'),(8,'PROLOG','kjfdksjfksdkjfkdsjfkjdsf'),(9,'PERL','ksdjfkjdfkjsdf'),(10,'HASKELL','aslkdlksaldklskdlsad'),(11,'XML','ksajdkajdkajsd'),(12,'JAVASCRIPT','kasjdkasjdkasd'),(13,'LOGO','kasjdkajsdkjasaaaaaaaaaaa'),(15,'ENSAMBLADOR I86','asdasdasd'),(16,'LISP','ksjkjkjsakjdkajskjdasd');
/*!40000 ALTER TABLE `tecnologia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'mydb'
--
/*!50003 DROP PROCEDURE IF EXISTS `buscarUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarUsuario`(in usuario varchar(20))
begin
	SELECT COUNT(*) From Reclutador as r where r.usuario=usuario;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultaCandidato` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultaCandidato`(in curp varchar(25))
begin
select p.Nombre, p.ApePaterno, p.ApeMaterno, 
	c.curp, c.rfc, c.email, c.telefono, c.tecnologia,c.PalabrasClave, c.Fecha, pr.Nombre as NombreR, pr.ApePaterno as ApePaternoR, pr.ApeMaterno as ApeMaternoR
	from Persona as p, Candidato as c, Reclutador as r, Persona as pr
	where c.curp = curp
	and p.idPersona = c.Persona_idPersona 
	and c.Reclutador_idReclutador = r.idReclutador 
	and r.Persona_idPersona = pr.idPersona;
commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultarCandidato` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarCandidato`(
	in idRe INT
	)
begin
	SELECT Nombre, ApePaterno, ApeMaterno From Persona as c, Reclutador as r 
	where p.idPersona=r.Persona_idPersona and r.idReclutador=idRE;
	COMMIT;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultarCandidatos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarCandidatos`(in idReclu INT)
begin
select p.nombre as nombreCandidato, 
	p.ApePaterno as ApePaternoCandidato, 
	p.ApeMaterno as ApeMaternoCandidato, 
	c.idCandidato,
	c.CURP, 
	c.RFC,
	c.Telefono,
	c.Email,
	c.PalabrasClave,
	c.Tecnologia,
	c.Reclutador_idReclutador,
	c.Fecha,
	r.idReclutador,
	rp.Nombre as nombreReclutador,
	rp.ApePaterno as ApePaternoReclutador,
	rp.ApeMaterno as ApeMaternoReclutador
from Persona as p, Candidato as c, Reclutador as r, Persona as rp
where p.idPersona = c.Persona_idPersona and r.idReclutador=idReclu and r.idReclutador=c.Reclutador_idReclutador
and rp.idPersona=r.Persona_idPersona;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultarCandidatosAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarCandidatosAdmin`()
begin
select p.nombre as nombreCandidato, 
	p.ApePaterno as ApePaternoCandidato, 
	p.ApeMaterno as ApeMaternoCandidato, 
	c.idCandidato,
	c.CURP, 
	c.RFC,
	c.Telefono,
	c.Email,
	c.PalabrasClave,
	c.Tecnologia,
	c.Reclutador_idReclutador,
	c.Fecha,
	r.idReclutador,
	rp.Nombre as nombreReclutador,
	rp.ApePaterno as ApePaternoReclutador,
	rp.ApeMaterno as ApeMaternoReclutador
from Persona as p, Candidato as c, Reclutador as r, Persona as rp
where p.idPersona = c.Persona_idPersona and r.idReclutador=c.Reclutador_idReclutador
and rp.idPersona=r.Persona_idPersona;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultarReclutador` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarReclutador`(
	in idRe INT
	)
begin
	SELECT p.Nombre, p.ApePaterno, p.ApeMaterno From Persona as p, Reclutador as r 
	where p.idPersona=r.Persona_idPersona and r.idReclutador=idRE;
	COMMIT;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ConsultarReclutadores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarReclutadores`()
begin
	SELECT idReclutador, Usuario, Password, Admin,Nombre, ApePaterno, ApeMaterno From Reclutador,Persona where Reclutador.Persona_idPersona=Persona.idPersona;
	COMMIT;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EditarCandidato` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EditarCandidato`(
	in idCandidato int,
	in nombre varchar(20),
	in paterno varchar(20),
	in materno varchar(20),
	in CURP varchar(25),
  	in RFC varchar(20),
  	in Email varchar(30),
  	in Telefono varchar(20),
  	in Tecnologia varchar(200),
  	in PalabrasClave varchar(200),
  	in idReclutador INT
	)
begin
	update Candidato as c, Persona as p set c.CURP=CURP, c.RFC=RFC, c.email = Email, 
	c.Telefono=Telefono, c.Tecnologia=Tecnologia, c.PalabrasClave=PalabrasClave,
	p.Nombre = nombre, p.ApePaterno=paterno, p.ApeMaterno = materno
	where p.idPersona = c.Persona_idPersona and c.idCandidato=idCandidato;
	COMMIT;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `editarNombreAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `editarNombreAdmin`( 
in id INT, 
IN nom VARCHAR(20),
IN pa VARCHAR(20),
IN ma VARCHAR(20)
)
begin
	declare idPer INT;
	set idPer = (SELECT Persona_idPersona From Reclutador where idReclutador=id);
	update Persona set Nombre = nom, ApePaterno = pa, ApeMaterno = ma where idPersona=idPer;
commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `editarPassAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `editarPassAdmin`( 
in id INT, 
IN pass VARCHAR(20), 
IN passActual VARCHAR(20),
out res INT
)
begin
	update Reclutador set Password = pass where idReclutador=id  and binary Password=passActual;
	SET RES=(SELECT ROW_COUNT());
commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EditarReclutador` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EditarReclutador`(
	in idReclutador int,
	in nombre varchar(20),
	in paterno varchar(20),
	in materno varchar(20),
	in pass varchar(25),
  	in usu varchar(20),
  	in ad int
	)
begin
	update Reclutador as r, Persona as p set r.Usuario=usu, r.Password=pass, r.Admin=ad,
	p.Nombre = nombre, p.ApePaterno=paterno, p.ApeMaterno = materno
	where p.idPersona = r.Persona_idPersona and r.idReclutador=idReclutador;
	COMMIT;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `editarSesionReclutador` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `editarSesionReclutador`( 
in id INT, 
IN pass VARCHAR(20), 
IN passActual VARCHAR(20),
OUT res INT)
begin
update Reclutador set Password = pass where idReclutador=id  and binary Password=passActual;
SET RES=(SELECT ROW_COUNT());
commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarCandidato` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarCandidato`(
  	in idCandidato INT
	)
begin
	delete p, c from Persona as p inner join Candidato as c where p.idPersona=c.Persona_idPersona and c.idCandidato=idCandidato;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarReclutador` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarReclutador`(
	out res INT,
  	in idReclu INT
	)
begin
	declare existe INT;
	set existe = (SELECT COUNT(*) From Candidato as c where Reclutador_idReclutador=idReclu );
	set res = 0;
	IF (existe = 0) then
		delete p, r from Persona as p inner join Reclutador as r where p.idPersona=r.Persona_idPersona and r.idReclutador=idReclu;
		set res=1;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `NuevoCandidato` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `NuevoCandidato`(
	in nombre varchar(20),
	in paterno varchar(20),
	in materno varchar(20),
	in CURP varchar(25),
  	in RFC varchar(20),
  	in Email varchar(30),
  	in Telefono varchar(20),
  	in Tecnologia varchar(200),
  	in PalabrasClave varchar(200),
  	in idReclutador INT,
  	out idCan INT
	)
begin
	declare idPer INT;
	declare existe INT;
	set existe = (SELECT COUNT(*) From Candidato as c where c.CURP=CURP);
	IF (existe = 0) then
		insert into Persona values(0,nombre,paterno,materno);
		set idPer = (SELECT MAX(idPersona) AS idPersona FROM Persona);
		if not idPer is null then
			insert into Candidato values (0 , CURP, RFC, Email, Telefono, Tecnologia, PalabrasClave, idPer, idReclutador, CURRENT_TIMESTAMP );
			set idCan = (SELECT MAX(idCandidato) AS idCandidato FROM Candidato);
		end if;
	end if;
	COMMIT;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `NuevoReclutador` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `NuevoReclutador`(
	in nombre varchar(20),
	in paterno varchar(20),
	in materno varchar(20),
	in usuario varchar(20),
  	in pass varchar(20),
  	in adm INT
	)
begin
	declare idPer INT;
	insert into Persona values(0,nombre,paterno,materno);
	set idPer = (SELECT MAX(idPersona) AS idPersona FROM Persona);
	if not idPer is null then
		insert into Reclutador values (0 , usuario, pass, idPer,adm);
	end if;
	COMMIT;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `verificarCurp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `verificarCurp`(
	in CURP varchar(25)
	)
begin
	SELECT Reclutador_idReclutador From Candidato as c where c.CURP=CURP;
	COMMIT;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-05-02 12:08:43
