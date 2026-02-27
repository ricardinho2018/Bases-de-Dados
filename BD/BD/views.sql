USE `agencia`;

DROP VIEW IF EXISTS DetetivesPorEspecialidade;
DROP VIEW IF EXISTS DetetivesPorHorario;
DROP VIEW IF EXISTS DetetivesPorCaso;
DROP VIEW IF EXISTS DetetivesLivresPorHorario;
DROP VIEW IF EXISTS CasoPorCliente;
DROP VIEW IF EXISTS EvidenciasPorCaso;
DROP VIEW IF EXISTS DetetivesLivresPorEspecialidadeHorario;
DROP VIEW IF EXISTS SuspeitosPorEvidencia;
DROP VIEW IF EXISTS CadeiaCustodiaPorEvidencia;
DROP VIEW IF EXISTS SuspeitosPorCaso;
DROP VIEW IF EXISTS CadeiaCustodiaPorCaso;

-- ---------------------------------------------------
-- View " Detetive por Especialidade"
-- ---------------------------------------------------  
CREATE VIEW DetetivesPorEspecialidade AS
    SELECT * 
    FROM Detetive
        WHERE especialidade = 'Criminal';


-- ---------------------------------------------------
-- View "Detetives por Horario"
-- ---------------------------------------------------  
CREATE VIEW DetetivesPorHorario AS
	SELECT * 
	FROM Detetive
		WHERE horario = 'Segunda-feira a Sexta-feira, das 08h15 às 17h15';


-- ---------------------------------------------------
-- View Detetives por Caso"
-- ---------------------------------------------------  
CREATE VIEW DetetivesPorCaso AS
	SELECT D.*
	FROM Detetive D
		JOIN Detetive_Caso DC ON D.id_detetive = DC.id_detetive
			WHERE DC.idCaso = '3';


-- ---------------------------------------------------
-- View "Evidencias por Caso"
-- ---------------------------------------------------      
CREATE VIEW EvidenciasPorCaso AS
	SELECT * 
	FROM Evidencia
		WHERE id_caso = '11';

-- ---------------------------------------------------
-- View "Caso por Cliente"
-- --------------------------------------------------- 
CREATE VIEW CasoPorCliente AS
	SELECT C.*
    FROM Caso C
		WHERE C.idCliente = '13';
		

-- ---------------------------------------------------
-- View "Suspeitos por Evidencia"
-- --------------------------------------------------- 
CREATE VIEW SuspeitosPorEvidencia AS
	SELECT S.*
	FROM Suspeito S
		JOIN Evidencia E ON S.id_suspeito = E.id_suspeito
			WHERE E.id_Evidencia = '10';


-- ---------------------------------------------------
-- View "Cadeia de Custodia por evidencia"
-- --------------------------------------------------- 
CREATE VIEW CadeiaCustodiaPorEvidencia AS
	SELECT * 
	FROM `Cadeia_de_custodia`
		WHERE id_evidencia = '9';


-- ---------------------------------------------------
-- View "Suspeito por Caso"
-- --------------------------------------------------- 
CREATE VIEW SuspeitosPorCaso AS
	SELECT DISTINCT S.*
	FROM Suspeito S
		JOIN Evidencia E ON S.id_suspeito = E.id_suspeito
			WHERE E.id_caso = '5';


-- ---------------------------------------------------
-- View "Cadeira de Custodia por Caso"
-- --------------------------------------------------- 
CREATE VIEW CadeiaCustodiaPorCaso AS
	SELECT CC.*
	FROM `Cadeia_de_custodia` CC
		JOIN Evidencia E ON CC.id_evidencia = E.id_Evidencia
			WHERE E.id_caso = '3';
