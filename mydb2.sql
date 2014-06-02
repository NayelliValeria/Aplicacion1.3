SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`persona` ;

CREATE TABLE IF NOT EXISTS `mydb`.`persona` (
  `idPersona` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(20) NULL DEFAULT NULL,
  `ApePaterno` VARCHAR(20) NULL DEFAULT NULL,
  `ApeMaterno` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`idPersona`))
ENGINE = InnoDB
AUTO_INCREMENT = 163
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`reclutador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`reclutador` ;

CREATE TABLE IF NOT EXISTS `mydb`.`reclutador` (
  `idReclutador` INT(11) NOT NULL AUTO_INCREMENT,
  `Usuario` VARCHAR(20) NULL DEFAULT NULL,
  `Password` VARCHAR(20) NULL DEFAULT NULL,
  `Persona_idPersona` INT(11) NOT NULL,
  `Admin` INT(11) NOT NULL,
  PRIMARY KEY (`idReclutador`),
  INDEX `fk_Reclutador_Persona_idx` (`Persona_idPersona` ASC),
  CONSTRAINT `fk_Reclutador_Persona`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `mydb`.`persona` (`idPersona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 56
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`candidato`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`candidato` ;

CREATE TABLE IF NOT EXISTS `mydb`.`candidato` (
  `idCandidato` INT(11) NOT NULL AUTO_INCREMENT,
  `CURP` VARCHAR(25) NULL DEFAULT NULL,
  `RFC` VARCHAR(20) NULL DEFAULT NULL,
  `email` VARCHAR(30) NULL DEFAULT NULL,
  `Telefono` VARCHAR(20) NULL DEFAULT NULL,
  `Tecnologia` VARCHAR(200) NULL DEFAULT NULL,
  `PalabrasClave` VARCHAR(200) NULL DEFAULT NULL,
  `Persona_idPersona` INT(11) NOT NULL,
  `Reclutador_idReclutador` INT(11) NOT NULL,
  `Fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCandidato`),
  INDEX `fk_Candidato_Persona1_idx` (`Persona_idPersona` ASC),
  INDEX `fk_Candidato_Reclutador1_idx` (`Reclutador_idReclutador` ASC),
  CONSTRAINT `fk_Candidato_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `mydb`.`persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Candidato_Reclutador1`
    FOREIGN KEY (`Reclutador_idReclutador`)
    REFERENCES `mydb`.`reclutador` (`idReclutador`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 90
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Tecnologia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tecnologia` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Tecnologia` (
  `idTecnologia` INT NOT NULL,
  `NombreTecnologia` VARCHAR(45) NULL,
  `DescripcionTecnologia` VARCHAR(300) NULL,
  PRIMARY KEY (`idTecnologia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`candidato_has_Tecnologia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`candidato_has_Tecnologia` ;

CREATE TABLE IF NOT EXISTS `mydb`.`candidato_has_Tecnologia` (
  `idCandidato` INT(11) NOT NULL,
  `idTecnologia` INT NOT NULL,
  PRIMARY KEY (`idCandidato`, `idTecnologia`),
  INDEX `fk_candidato_has_Tecnologia_Tecnologia1_idx` (`idTecnologia` ASC),
  INDEX `fk_candidato_has_Tecnologia_candidato1_idx` (`idCandidato` ASC),
  CONSTRAINT `fk_candidato_has_Tecnologia_candidato1`
    FOREIGN KEY (`idCandidato`)
    REFERENCES `mydb`.`candidato` (`idCandidato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_candidato_has_Tecnologia_Tecnologia1`
    FOREIGN KEY (`idTecnologia`)
    REFERENCES `mydb`.`Tecnologia` (`idTecnologia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- procedure ConsultarReclutadores
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`ConsultarReclutadores`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarReclutadores`()
begin
	SELECT idReclutador, Usuario, Password, Admin,Nombre, ApePaterno, ApeMaterno From Reclutador,Persona where Reclutador.Persona_idPersona=Persona.idPersona;
	COMMIT;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure EditarCandidato
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`EditarCandidato`;

DELIMITER $$
USE `mydb`$$
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
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure EditarReclutador
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`EditarReclutador`;

DELIMITER $$
USE `mydb`$$
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
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure EliminarCandidato
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`EliminarCandidato`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarCandidato`(
  	in idCandidato INT
	)
begin
	delete p, c from Persona as p inner join Candidato as c where p.idPersona=c.Persona_idPersona and c.idCandidato=idCandidato;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure EliminarReclutador
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`EliminarReclutador`;

DELIMITER $$
USE `mydb`$$
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
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure NuevoCandidato
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`NuevoCandidato`;

DELIMITER $$
USE `mydb`$$
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
  	in idReclutador INT
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
		end if;
	end if;
	COMMIT;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure NuevoReclutador
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`NuevoReclutador`;

DELIMITER $$
USE `mydb`$$
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
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure buscarUsuario
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`buscarUsuario`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarUsuario`(in usuario varchar(20))
begin
	SELECT COUNT(*) From Reclutador as r where r.usuario=usuario;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultaCandidato
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`consultaCandidato`;

DELIMITER $$
USE `mydb`$$
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
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultarCandidato
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`consultarCandidato`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarCandidato`(
	in idRe INT
	)
begin
	SELECT Nombre, ApePaterno, ApeMaterno From Persona as c, Reclutador as r 
	where p.idPersona=r.Persona_idPersona and r.idReclutador=idRE;
	COMMIT;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultarCandidatos
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`consultarCandidatos`;

DELIMITER $$
USE `mydb`$$
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
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultarCandidatosAdmin
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`consultarCandidatosAdmin`;

DELIMITER $$
USE `mydb`$$
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
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consultarReclutador
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`consultarReclutador`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarReclutador`(
	in idRe INT
	)
begin
	SELECT p.Nombre, p.ApePaterno, p.ApeMaterno From Persona as p, Reclutador as r 
	where p.idPersona=r.Persona_idPersona and r.idReclutador=idRE;
	COMMIT;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure editarNombreAdmin
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`editarNombreAdmin`;

DELIMITER $$
USE `mydb`$$
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
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure editarPassAdmin
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`editarPassAdmin`;

DELIMITER $$
USE `mydb`$$
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
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure editarSesionReclutador
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`editarSesionReclutador`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `editarSesionReclutador`( 
in id INT, 
IN pass VARCHAR(20), 
IN passActual VARCHAR(20),
OUT res INT)
begin
update Reclutador set Password = pass where idReclutador=id  and binary Password=passActual;
SET RES=(SELECT ROW_COUNT());
commit;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure verificarCurp
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`verificarCurp`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `verificarCurp`(
	in CURP varchar(25)
	)
begin
	SELECT Reclutador_idReclutador From Candidato as c where c.CURP=CURP;
	COMMIT;
end$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
