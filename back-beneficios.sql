-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_restaurante` DEFAULT CHARACTER SET utf8 ;
USE `db_restaurante` ;

-- -----------------------------------------------------
-- Table `mydb`.`tb_empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurante`.`tb_empresa` (
  `codigo_empresa` INT NOT NULL,
  `nome_empresa` VARCHAR(45) NULL,
  `uf_sede_empresa` VARCHAR(2) NULL,
  PRIMARY KEY (`codigo_empresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_beneficio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurante`.`tb_beneficio` (
  `codigo_funcionario` INT NOT NULL,
  `email_funcionario` VARCHAR(45) NULL,
  `codigo_beneficio` INT NULL,
  `codigo_empresa` INT NULL,
  `tipo_beneficio` INT NULL,
  `valor_beneficio` INT NULL,
  PRIMARY KEY (`codigo_funcionario`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
