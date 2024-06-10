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
-- -----------------------------------------------------
-- Schema db_restaurante
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_restaurante
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_restaurante` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db_restaurante` ;

-- -----------------------------------------------------
-- Table `db_restaurante`.`dim_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurante`.`dim_cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `cpf_cliente` VARCHAR(14) NOT NULL,
  `nome_cliente` VARCHAR(150) NOT NULL,
  `email_cliente` VARCHAR(45) NULL DEFAULT NULL,
  `telefone_cliente` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 128
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`dim_ano`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurante`.`dim_ano` (
  `id_ano` INT NOT NULL AUTO_INCREMENT,
  `ano` VARCHAR(4) NULL,
  PRIMARY KEY (`id_ano`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dim_dia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurante`.`dim_dia` (
  `id_dia` INT NOT NULL AUTO_INCREMENT,
  `dia` VARCHAR(2) NULL,
  PRIMARY KEY (`id_dia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dim_mes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurante`.`dim_mes` (
  `id_mes` INT NOT NULL AUTO_INCREMENT,
  `mes` VARCHAR(2) NULL,
  PRIMARY KEY (`id_mes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`fato_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurante`.`fato_pedido` (
  `valor_total` DOUBLE NOT NULL,
  `valor_unitario` DOUBLE NOT NULL,
  `quatidade_pedido` VARCHAR(45) NOT NULL,
  `dim_cliente_id_cliente` INT NOT NULL,
  `id_fato` INT NOT NULL AUTO_INCREMENT,
  `dim_ano_id_ano` INT NOT NULL,
  `dim_dia_id_dia` INT NOT NULL,
  `dim_mes_id_mes` INT NOT NULL,
  `num_pessoa_mesa` INT NULL,
  INDEX `fk_fato_pedido_dim_cliente_idx` (`dim_cliente_id_cliente` ASC) VISIBLE,
  PRIMARY KEY (`id_fato`),
  INDEX `fk_fato_pedido_dim_ano1_idx` (`dim_ano_id_ano` ASC) VISIBLE,
  INDEX `fk_fato_pedido_dim_dia1_idx` (`dim_dia_id_dia` ASC) VISIBLE,
  INDEX `fk_fato_pedido_dim_mes1_idx` (`dim_mes_id_mes` ASC) VISIBLE,
  CONSTRAINT `fk_fato_pedido_dim_cliente`
    FOREIGN KEY (`dim_cliente_id_cliente`)
    REFERENCES `db_restaurante`.`dim_cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_pedido_dim_ano1`
    FOREIGN KEY (`dim_ano_id_ano`)
    REFERENCES `db_restaurante`.`dim_ano` (`id_ano`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_pedido_dim_dia1`
    FOREIGN KEY (`dim_dia_id_dia`)
    REFERENCES `db_restaurante`.`dim_dia` (`id_dia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_pedido_dim_mes1`
    FOREIGN KEY (`dim_mes_id_mes`)
    REFERENCES `db_restaurante`.`dim_mes` (`id_mes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `db_restaurante` ;

-- -----------------------------------------------------
-- Table `db_restaurante`.`tb_mesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurante`.`tb_mesa` (
  `codigo_mesa` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `num_pessoa_mesa` INT NOT NULL DEFAULT '1',
  `data_hora_entrada` DATETIME NULL DEFAULT NULL,
  `data_hora_saida` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`codigo_mesa`),
  INDEX `fk_cliente_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `db_restaurante`.`dim_cliente` (`id_cliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 16384
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_restaurante`.`tb_tipo_prato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurante`.`tb_tipo_prato` (
  `codigo_tipo_prato` INT NOT NULL AUTO_INCREMENT,
  `nome_tipo_prato` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo_tipo_prato`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_restaurante`.`tb_prato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurante`.`tb_prato` (
  `codigo_prato` INT NOT NULL AUTO_INCREMENT,
  `codigo_tipo_prato` INT NOT NULL,
  `nome_prato` VARCHAR(45) NOT NULL,
  `preco_unitario_prato` DOUBLE NOT NULL,
  PRIMARY KEY (`codigo_prato`),
  INDEX `fk_tipo_prato_idx` (`codigo_tipo_prato` ASC) VISIBLE,
  CONSTRAINT `fk_tipo_prato`
    FOREIGN KEY (`codigo_tipo_prato`)
    REFERENCES `db_restaurante`.`tb_tipo_prato` (`codigo_tipo_prato`))
ENGINE = InnoDB
AUTO_INCREMENT = 1024
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_restaurante`.`tb_situacao_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurante`.`tb_situacao_pedido` (
  `codigo_situacao_pedido` INT NOT NULL AUTO_INCREMENT,
  `nome_situacao_pedido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo_situacao_pedido`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_restaurante`.`tb_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurante`.`tb_pedido` (
  `codigo_mesa` INT NOT NULL,
  `codigo_prato` INT NOT NULL,
  `quantidade_pedido` VARCHAR(45) NOT NULL,
  `codigo_situacao_pedido` INT NOT NULL,
  INDEX `fk_situacao_pedido_idx` (`codigo_situacao_pedido` ASC) VISIBLE,
  INDEX `fk_mesa_idx` (`codigo_mesa` ASC) VISIBLE,
  INDEX `fk_prato_idx` (`codigo_prato` ASC) VISIBLE,
  CONSTRAINT `fk_mesa`
    FOREIGN KEY (`codigo_mesa`)
    REFERENCES `db_restaurante`.`tb_mesa` (`codigo_mesa`),
  CONSTRAINT `fk_prato`
    FOREIGN KEY (`codigo_prato`)
    REFERENCES `db_restaurante`.`tb_prato` (`codigo_prato`),
  CONSTRAINT `fk_situacao_pedido`
    FOREIGN KEY (`codigo_situacao_pedido`)
    REFERENCES `db_restaurante`.`tb_situacao_pedido` (`codigo_situacao_pedido`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
