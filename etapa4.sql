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
-- Table `portfolio`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona` (
  `p_id` INT NOT NULL,
  `p_nombre` VARCHAR(45) NULL,
  `p_apellido` VARCHAR(45) NULL,
  `p_domicilio` VARCHAR(45) NULL,
  `p_nacimiento` DATE NULL,
  `p_telefono` VARCHAR(12) NULL,
  `p_sobreMi` VARCHAR(200) NULL,
  PRIMARY KEY (`p_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`empleo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`empleo` (
  `e_id` INT NOT NULL,
  `e_nombreTipo` VARCHAR(45) NULL,
  PRIMARY KEY (`e_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`experiencia_laboral` (
  `el_id` INT NOT NULL,
  `el_nombreEmpresa` VARCHAR(45) NULL,
  `el_esTrabajoActual` TINYINT NULL,
  `el_fechaInicio` DATE NULL,
  `el_fechaFin` DATE NULL,
  `el_descripcion` VARCHAR(200) NULL,
  `persona_p_id` INT NOT NULL,
  `empleo_e_id` INT NOT NULL,
  PRIMARY KEY (`el_id`, `persona_p_id`, `empleo_e_id`),
  INDEX `fk_experiencia_laboral_persona_idx` (`persona_p_id` ASC) VISIBLE,
  INDEX `fk_experiencia_laboral_empleo1_idx` (`empleo_e_id` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_laboral_persona`
    FOREIGN KEY (`persona_p_id`)
    REFERENCES `portfolio`.`persona` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiencia_laboral_empleo1`
    FOREIGN KEY (`empleo_e_id`)
    REFERENCES `portfolio`.`empleo` (`e_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`educacion` (
  `edu_id` INT NOT NULL,
  `edu_tituloCarrera` VARCHAR(45) NULL,
  `edu_nombreInstitucion` VARCHAR(45) NULL,
  `edu_fechaInicio` DATE NULL,
  `edu_fechaFin` DATE NULL,
  `persona_p_id` INT NOT NULL,
  PRIMARY KEY (`edu_id`, `persona_p_id`),
  INDEX `fk_educacion_persona1_idx` (`persona_p_id` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`persona_p_id`)
    REFERENCES `portfolio`.`persona` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`localidad_establecimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`localidad_establecimiento` (
  `le_id` INT NOT NULL,
  `le_nombreLocalidad` VARCHAR(45) NULL,
  `educacion_edu_id` INT NOT NULL,
  `educacion_persona_p_id` INT NOT NULL,
  PRIMARY KEY (`le_id`, `educacion_edu_id`, `educacion_persona_p_id`),
  INDEX `fk_localidad_establecimiento_educacion1_idx` (`educacion_edu_id` ASC, `educacion_persona_p_id` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_establecimiento_educacion1`
    FOREIGN KEY (`educacion_edu_id` , `educacion_persona_p_id`)
    REFERENCES `portfolio`.`educacion` (`edu_id` , `persona_p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`tipo_estudio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`tipo_estudio` (
  `te_id` INT NOT NULL,
  `te_nombreTipo` VARCHAR(45) NULL,
  `educacion_edu_id` INT NOT NULL,
  `educacion_persona_p_id` INT NOT NULL,
  PRIMARY KEY (`te_id`, `educacion_edu_id`, `educacion_persona_p_id`),
  INDEX `fk_tipo_estudio_educacion1_idx` (`educacion_edu_id` ASC, `educacion_persona_p_id` ASC) VISIBLE,
  CONSTRAINT `fk_tipo_estudio_educacion1`
    FOREIGN KEY (`educacion_edu_id` , `educacion_persona_p_id`)
    REFERENCES `portfolio`.`educacion` (`edu_id` , `persona_p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`estado` (
  `state_id` INT NOT NULL,
  `state_nombreTipo` VARCHAR(45) NULL,
  `educacion_edu_id` INT NOT NULL,
  `educacion_persona_p_id` INT NOT NULL,
  PRIMARY KEY (`state_id`, `educacion_edu_id`, `educacion_persona_p_id`),
  INDEX `fk_estado_educacion1_idx` (`educacion_edu_id` ASC, `educacion_persona_p_id` ASC) VISIBLE,
  CONSTRAINT `fk_estado_educacion1`
    FOREIGN KEY (`educacion_edu_id` , `educacion_persona_p_id`)
    REFERENCES `portfolio`.`educacion` (`edu_id` , `persona_p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`foto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`foto` (
  `f_id` INT NOT NULL,
  `f_nombreFoto` VARCHAR(45) NULL,
  `f_rutaFoto` VARCHAR(200) NULL,
  `persona_p_id` INT NOT NULL,
  PRIMARY KEY (`f_id`, `persona_p_id`),
  INDEX `fk_foto_persona1_idx` (`persona_p_id` ASC) VISIBLE,
  CONSTRAINT `fk_foto_persona1`
    FOREIGN KEY (`persona_p_id`)
    REFERENCES `portfolio`.`persona` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`habilidad_blanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`habilidad_blanda` (
  `hb_id` INT NOT NULL,
  `hb_tipoHabilidad` VARCHAR(45) NULL,
  `persona_p_id` INT NOT NULL,
  PRIMARY KEY (`hb_id`, `persona_p_id`),
  INDEX `fk_habilidad_blanda_persona1_idx` (`persona_p_id` ASC) VISIBLE,
  CONSTRAINT `fk_habilidad_blanda_persona1`
    FOREIGN KEY (`persona_p_id`)
    REFERENCES `portfolio`.`persona` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`habilidad_dura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`habilidad_dura` (
  `hd_id` INT NOT NULL,
  `hd_tipoHabilidad` VARCHAR(45) NULL,
  `persona_p_id` INT NOT NULL,
  PRIMARY KEY (`hd_id`, `persona_p_id`),
  INDEX `fk_habilidad_dura_persona1_idx` (`persona_p_id` ASC) VISIBLE,
  CONSTRAINT `fk_habilidad_dura_persona1`
    FOREIGN KEY (`persona_p_id`)
    REFERENCES `portfolio`.`persona` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`foto_proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`foto_proyecto` (
  `fp_id` INT NOT NULL,
  `fp_nombreFoto` VARCHAR(45) NULL,
  `fp_rutaFoto` VARCHAR(45) NULL,
  PRIMARY KEY (`fp_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`proyecto` (
  `pro_id` INT NOT NULL,
  `pro_nombre` VARCHAR(45) NULL,
  `pro_fechaCreacion` DATE NULL,
  `pro_descripcion` VARCHAR(200) NULL,
  `pro_link` VARCHAR(45) NULL,
  `persona_p_id` INT NOT NULL,
  `foto_proyecto_fp_id` INT NOT NULL,
  PRIMARY KEY (`pro_id`, `persona_p_id`, `foto_proyecto_fp_id`),
  INDEX `fk_proyecto_persona1_idx` (`persona_p_id` ASC) VISIBLE,
  INDEX `fk_proyecto_foto_proyecto1_idx` (`foto_proyecto_fp_id` ASC) VISIBLE,
  CONSTRAINT `fk_proyecto_persona1`
    FOREIGN KEY (`persona_p_id`)
    REFERENCES `portfolio`.`persona` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proyecto_foto_proyecto1`
    FOREIGN KEY (`foto_proyecto_fp_id`)
    REFERENCES `portfolio`.`foto_proyecto` (`fp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`idioma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`idioma` (
  `i_id` INT NOT NULL,
  `i_nombreIdioma` VARCHAR(45) NULL,
  `persona_p_id` INT NOT NULL,
  PRIMARY KEY (`i_id`, `persona_p_id`),
  INDEX `fk_idioma_persona1_idx` (`persona_p_id` ASC) VISIBLE,
  CONSTRAINT `fk_idioma_persona1`
    FOREIGN KEY (`persona_p_id`)
    REFERENCES `portfolio`.`persona` (`p_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
