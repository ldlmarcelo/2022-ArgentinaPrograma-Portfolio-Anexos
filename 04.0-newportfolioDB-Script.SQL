-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portfolio` DEFAULT CHARACTER SET utf8 ;
USE `portfolio` ;

-- -----------------------------------------------------
-- Table `portfolio`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(8) NOT NULL,
  `password` VARCHAR(45) NULL,
  `rol` INT(1) NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`contacto` (
  `idcontacto` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idcontacto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona` (
  `idpersona` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apeliido` VARCHAR(45) NOT NULL,
  `edad` INT(2) NOT NULL,
  `domicilio` VARCHAR(45) NULL,
  `profesion` VARCHAR(10) NULL,
  `foto` VARCHAR(45) NULL,
  `usuario_idusuario` INT NOT NULL,
  `acerca_de` VARCHAR(45) NULL,
  `contacto_idcontacto` INT NOT NULL,
  PRIMARY KEY (`idpersona`),
  INDEX `fk_persona_usuario_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_persona_contacto1_idx` (`contacto_idcontacto` ASC) VISIBLE,
  CONSTRAINT `fk_persona_usuario`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `portfolio`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_contacto1`
    FOREIGN KEY (`contacto_idcontacto`)
    REFERENCES `portfolio`.`contacto` (`idcontacto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`experiencia_laboral` (
  `idexperiencia_laboral` INT NOT NULL,
  `empresa` VARCHAR(45) NOT NULL,
  `actual` TINYBLOB NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idexperiencia_laboral`),
  INDEX `fk_experiencia_laboral_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_laboral_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `portfolio`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`educacion` (
  `ideducacion` INT NOT NULL,
  `institucion` VARCHAR(45) NULL,
  `fecha_inicio` DATE NULL,
  `fecha_fin` DATE NULL,
  `descripcion` VARCHAR(45) NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`ideducacion`),
  INDEX `fk_educacion_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `portfolio`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`hard_skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`hard_skill` (
  `idhard_skill` INT NOT NULL,
  `tecnologia` VARCHAR(45) NOT NULL,
  `porcentaje` INT NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idhard_skill`),
  INDEX `fk_hard_skill_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_hard_skill_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `portfolio`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`soft_skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`soft_skill` (
  `idsoft_skill` INT NOT NULL,
  `habilidad` VARCHAR(45) NOT NULL,
  `porcentaje` INT NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idsoft_skill`),
  INDEX `fk_soft_skill_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_soft_skill_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `portfolio`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`redes_sociales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`redes_sociales` (
  `idredes_sociales` INT NOT NULL,
  `link_red` VARCHAR(45) NOT NULL,
  `contacto_idcontacto` INT NOT NULL,
  PRIMARY KEY (`idredes_sociales`),
  INDEX `fk_redes_sociales_contacto1_idx` (`contacto_idcontacto` ASC) VISIBLE,
  CONSTRAINT `fk_redes_sociales_contacto1`
    FOREIGN KEY (`contacto_idcontacto`)
    REFERENCES `portfolio`.`contacto` (`idcontacto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`proyecto` (
  `idproyecto` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `link` VARCHAR(45) NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idproyecto`),
  INDEX `fk_proyecto_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_proyecto_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `portfolio`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`footer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`footer` (
  `idfooter` INT NOT NULL,
  `datos_anexos` VARCHAR(45) NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idfooter`),
  INDEX `fk_footer_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_footer_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `portfolio`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
