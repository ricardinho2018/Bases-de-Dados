USE `agencia`;

DROP PROCEDURE IF EXISTS AtualizarHorarioDetetive;
DROP PROCEDURE IF EXISTS AtualizarCaso;
DROP PROCEDURE IF EXISTS AtualizarObservacoesEvidencia;
DROP PROCEDURE IF EXISTS AdicionarDetetiveCaso;
DROP PROCEDURE IF EXISTS RemoverDetetiveCaso;
DROP PROCEDURE IF EXISTS insert_administrador;
DROP PROCEDURE IF EXISTS insert_cliente;
DROP PROCEDURE IF EXISTS insert_caso;
DROP PROCEDURE IF EXISTS insert_detetive;
DROP PROCEDURE IF EXISTS insert_detetive_caso;
DROP PROCEDURE IF EXISTS insert_suspeito;
DROP PROCEDURE IF EXISTS insert_evidencia;
DROP PROCEDURE IF EXISTS insert_cadeia_de_custodia;

-- ---------------------------------------------------
-- Procedure "Insere um Admin na tabla"
-- ---------------------------------------------------  
DELIMITER //
CREATE PROCEDURE insert_administrador (
  IN p_email VARCHAR(45),
  IN p_password VARCHAR(25),
  IN p_nome VARCHAR(45)
)
BEGIN
  INSERT INTO `agencia`.`Administrador` (`email`, `pass`, `nome`) 
	VALUES (p_email, p_password, p_nome);
END //
DELIMITER ;

-- ---------------------------------------------------
-- Procedure "Insere um  na tabela"
-- ---------------------------------------------------  
DELIMITER //
CREATE PROCEDURE insert_cliente (
  IN p_password VARCHAR(225),
  IN p_nome VARCHAR(45),
  IN p_idade INT,
  IN p_email VARCHAR(45),
  IN p_telefone VARCHAR(15),
  IN p_idAdmin INT
)
BEGIN
  INSERT INTO `agencia`.`Cliente` (`password`, `nome`, `idade`, `email`, `telefone`, `idAdmin`) 
	VALUES (p_password, p_nome, p_idade, p_email, p_telefone, p_idAdmin);
END //
DELIMITER ;

-- ---------------------------------------------------
-- Procedure "Insere um Caso na tabela"
-- --------------------------------------------------- 
DELIMITER //
CREATE PROCEDURE insert_caso (
  IN p_titulo VARCHAR(45),
  IN p_data_a DATE,
  IN p_data_f DATE,
  IN p_descricao VARCHAR(100),
  IN p_observacoes VARCHAR(1000),
  IN p_status VARCHAR(15),
  IN p_especialidade VARCHAR(45),
  IN p_idAdmin INT,
  IN p_idCliente INT
)
BEGIN
  INSERT INTO `agencia`.`Caso` (`titulo`, `data_a`, `data_f`, `descricao`, `observacoes`, `status`, `especialidade`, `idAdmin`, `idCliente`) 
	VALUES (p_titulo, p_data_a, p_data_f, p_descricao, IF(p_observacoes = '', NULL, p_observacoes), p_status, p_especialidade, p_idAdmin, p_idCliente);

END //
DELIMITER ;

-- ---------------------------------------------------
-- Procedure "Insere um detetive na tabela"
-- --------------------------------------------------- 
DELIMITER //
CREATE PROCEDURE insert_detetive (
  IN p_data_reg DATE,
  IN p_nome VARCHAR(45),
  IN p_password VARCHAR(225),
  IN p_idade INT,
  IN p_telefone VARCHAR(15),
  IN p_email VARCHAR(45),
  IN p_morada VARCHAR(45),
  IN p_especialidade VARCHAR(25),
  IN p_horario VARCHAR(500),
  IN p_idAdmin INT
)
BEGIN
  INSERT INTO `agencia`.`Detetive` (`data_reg`, `nome`, `password`, `idade`, `telefone`, `email`, `morada`, `especialidade`, `horario`, `idAdmin`) 
  VALUES (p_data_reg, p_nome, p_password, p_idade, p_telefone, p_email, p_morada, p_especialidade, p_horario, p_idAdmin);
  
END //
DELIMITER ;

-- ---------------------------------------------------
-- Procedure "Insere um detetive-caso na tabela"
-- --------------------------------------------------- 
DELIMITER //
CREATE PROCEDURE insert_detetive_caso (
  IN p_idCaso INT,
  IN p_id_detetive INT
)
BEGIN
  INSERT INTO `agencia`.`Detetive_Caso` (`idCaso`, `id_detetive`) 
  VALUES (p_idCaso, p_id_detetive);
END //
DELIMITER ;

-- ---------------------------------------------------
-- Procedure "Insere um suspeito na tabela"
-- --------------------------------------------------- 
DELIMITER //
CREATE PROCEDURE insert_suspeito (
  IN p_nome VARCHAR(45),
  IN p_idade INT,
  IN p_telefone VARCHAR(15),
  IN p_nif VARCHAR(15)
)
BEGIN
  INSERT INTO `agencia`.`Suspeito` (`nome`, `idade`, `telefone`, `nif`) 
  VALUES (p_nome, p_idade, p_telefone, p_nif);
  
END //
DELIMITER ;

-- ---------------------------------------------------
-- Procedure "Insere uma evidencia na tabela"
-- --------------------------------------------------- 
DELIMITER //
CREATE PROCEDURE insert_evidencia (
  IN p_descricao VARCHAR(100),
  IN p_tipo VARCHAR(500),
  IN p_notas VARCHAR(100),
  IN p_data DATE,
  IN p_localizacao VARCHAR(45),
  IN p_id_caso INT,
  IN p_id_suspeito INT
)
BEGIN
  INSERT INTO `agencia`.`Evidencia` (`descricao`, `tipo`, `notas`, `data`, `localizacao`, `id_caso`, `id_suspeito`) 
  VALUES (p_descricao, p_tipo, IF(p_notas = '', NULL, p_notas), p_data, p_localizacao, p_id_caso, p_id_suspeito);
  
END //
DELIMITER ;

-- ---------------------------------------------------
-- Procedure "Insere uma  cadeia de custodia na tabela"
-- --------------------------------------------------- 
DELIMITER //
CREATE PROCEDURE insert_cadeia_de_custodia (
  IN p_tipo VARCHAR(100),
  IN p_descricao VARCHAR(45),
  IN p_data DATE,
  IN p_id_evidencia INT
)
BEGIN
  INSERT INTO `agencia`.`Cadeia_de_custodia` (`tipo`, `descricao`, `data`, `id_evidencia`) 
  VALUES (p_tipo, p_descricao, p_data, p_id_evidencia);
  
END //
DELIMITER ;


-- ---------------------------------------------------
-- Procedure "Atulizar o Horario do Detetive"
-- ---------------------------------------------------  
DELIMITER //
CREATE PROCEDURE AtualizarHorarioDetetive(IN detetive_id INT, IN novo_horario VARCHAR(45))
BEGIN
  UPDATE Detetive
  SET horario = novo_horario
	WHERE id_detetive = detetive_id;
END //
DELIMITER ;


-- ---------------------------------------------------
-- Procedure "Atualizar o Caso"
-- --------------------------------------------------- 
DELIMITER //
CREATE PROCEDURE AtualizarCaso(
	IN caso_id INT, 
    IN novo_status VARCHAR(15), 
    IN novas_observacoes VARCHAR(1000)
)
BEGIN
  UPDATE Caso
  SET status = novo_status, observações = novas_observacoes
	WHERE idCaso = caso_id;
END //
DELIMITER ;

-- ---------------------------------------------------
-- Procedure "Atulizar Observacoes e Evidencias"
-- --------------------------------------------------- 
DELIMITER //
CREATE PROCEDURE AtualizarObservacoesEvidencia(
	IN evidencia_id INT, 
    IN novas_observacoes VARCHAR(45)
)
BEGIN
  UPDATE Evidencia
  SET notas = novas_observacoes
	WHERE id_Evidencia = evidencia_id;
END //
DELIMITER ;

-- ---------------------------------------------------
-- Procedure "Adicionar Detetives ao Caso"
-- --------------------------------------------------- 
DELIMITER //
CREATE PROCEDURE AdicionarDetetiveCaso(
	IN caso_id INT, 
    IN detetive_id INT
)
BEGIN
  INSERT INTO Detetive_Caso (idCaso, id_detetive)
	VALUES (caso_id, detetive_id);
END//
DELIMITER ;

-- ---------------------------------------------------
-- Procedure "Remover Detetives de um Caso"
-- --------------------------------------------------- 
DELIMITER //
CREATE PROCEDURE RemoverDetetiveCaso(
	IN caso_id INT, 
    IN detetive_id INT
)
BEGIN
  DELETE FROM Detetive_Caso
	WHERE idCaso = caso_id AND id_detetive = detetive_id;
END //
DELIMITER ;