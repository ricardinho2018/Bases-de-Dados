DROP DATABASE IF EXISTS agencia;
-- -----------------------------------------------------
-- Database agencia
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS `agencia` DEFAULT CHARACTER SET utf8mb4;
USE `agencia`;

-- -----------------------------------------------------
-- Table `agencia`.`Administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia`.`Administrador` (
  `idAdmin` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `pass` VARCHAR(25) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAdmin`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `agencia`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia`.`Cliente` (
  `id_Cliente` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(255) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `idade` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `idAdmin` INT NOT NULL,
  PRIMARY KEY (`id_Cliente`),
  CONSTRAINT `fk_Cliente_Administrador`
    FOREIGN KEY (`idAdmin`)
    REFERENCES `Administrador` (`idAdmin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `agencia`.`Caso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia`.`Caso` (
  `idCaso` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `data_a` DATE NOT NULL,
  `data_f` DATE,
  `descricao` VARCHAR(100) NOT NULL,
  `observacoes` VARCHAR(1000),
  `status` VARCHAR(15) NOT NULL,
  `especialidade` VARCHAR(45) NOT NULL,
  `idAdmin` INT NOT NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idCaso`),
  CONSTRAINT `fk_Caso_Administrador`
    FOREIGN KEY (`idAdmin`)
    REFERENCES Administrador(idAdmin)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caso_Cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES Cliente(id_Cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `agencia`.`Detetive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia`.`Detetive` (
  `id_detetive` INT NOT NULL AUTO_INCREMENT,
  `data_reg` DATE NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `idade` INT NOT NULL,
  `telefone` VARCHAR(15) NULL,
  `email` VARCHAR(45) NULL,
  `morada` VARCHAR(45) NULL,
  `especialidade` VARCHAR(25) NULL,
  `horario` VARCHAR(500) NULL,
  `idAdmin` INT NOT NULL,
  PRIMARY KEY (`id_detetive`),
  CONSTRAINT `fk_Detetive_Administrador`
    FOREIGN KEY (`idAdmin`)
    REFERENCES `Administrador` (`idAdmin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `agencia`.`Detetive_Caso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia`.`Detetive_Caso` (
  `idCaso` INT NOT NULL,
  `id_detetive` INT NOT NULL,
  PRIMARY KEY (`id_detetive`, `idCaso`),
  CONSTRAINT `fk_Detetive_Caso_Detetive`
    FOREIGN KEY (`id_detetive`)
    REFERENCES `Detetive` (`id_detetive`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detetive_Caso_Caso`
    FOREIGN KEY (`idCaso`)
    REFERENCES `Caso` (`idCaso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `agencia`.`Suspeito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia`.`Suspeito` (
  `id_suspeito` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `idade` INT NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `nif` VARCHAR(15) NOT NULL, 
  PRIMARY KEY (`id_suspeito`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `agencia`.`Evidencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia`.`Evidencia` (
  `id_Evidencia` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  `tipo` VARCHAR(500) NOT NULL,
  `notas` VARCHAR(100),
  `data` DATE NOT NULL,
  `localizacao` VARCHAR(45) NOT NULL,
  `id_caso` INT NOT NULL,
  `id_suspeito` INT NOT NULL,
  PRIMARY KEY (`id_Evidencia`),
  CONSTRAINT `fk_Evidencia_Caso`
    FOREIGN KEY (`id_caso`)
    REFERENCES `Caso` (`idCaso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Evidencia_Suspeito`
    FOREIGN KEY (`id_suspeito`)
    REFERENCES `Suspeito` (`id_suspeito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `agencia`.`Cadeia_de_custodia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia`.`Cadeia_de_custodia` (
  `id_Cad` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `data` DATE NOT NULL,
  `id_evidencia` INT NOT NULL,
  PRIMARY KEY (`id_Cad`),
  CONSTRAINT `fk_Cadeia_de_custodia_Evidencia`
    FOREIGN KEY (`id_evidencia`)
    REFERENCES `Evidencia` (`id_Evidencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

