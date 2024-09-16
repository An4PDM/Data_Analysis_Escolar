CREATE DATABASE IF NOT EXISTS analise_escola;
USE analise_escola;

SELECT * FROM Regulacao_Cursos;
SELECT * FROM Regulacao_Escolas;

-- Selecionando unidade de ensino em São Paulo
SELECT UNIDADE_DE_ENSINO, MUNICIPIO FROM Regulacao_Escolas 
WHERE MUNICIPIO LIKE '%são paulo%';

-- Tipos de sistema de ensino no BD
SELECT NOME_SISTEMA_DE_ENSINO
FROM Regulacao_Escolas
GROUP BY NOME_SISTEMA_DE_ENSINO;

-- Todas as infos de uma escola presente nas duas tabelas
SELECT * FROM Regulacao_Escolas re
INNER JOIN Regulacao_Cursos rc ON
re.UNIDADE_DE_ENSINO=rc.UNIDADE_DE_ENSINO
WHERE re.UNIDADE_DE_ENSINO LIKE '%Agenor de Campos%';

-- Quantidade de universidade por UFs
SELECT COUNT(UF) AS 'Quantidade', UF 
FROM Regulacao_Escolas
WHERE UNIDADE_DE_ENSINO LIKE '%Universidade%' OR '%Faculldade%'
GROUP BY UF;

-- Análise de persistência de dados
SELECT * FROM Regulacao_Escolas
WHERE UF = 'AP' 
AND UNIDADE_DE_ENSINO LIKE '%UNIVERSIDADE%' OR '%FACULDADE%';

-- Criando views
CREATE VIEW Duração_de_cursos AS
SELECT CURSO, 
       EIXO_TECNOLOGICO, 
       CARGA_HORARIA_CURSO AS Carga_Horaria, 
       CASE
       WHEN CARGA_HORARIA_CURSO <= 800 THEN 'Baixa duração'
       WHEN CARGA_HORARIA_CURSO >800 THEN 'Longa duração'
       END Duração
       FROM Regulacao_Cursos;
	   
SELECT * FROM Duração_de_cursos;
DROP VIEW Duração_de_cursos;


CREATE VIEW Tipos_de_dependencia_adm AS
SELECT NOME_DEPENDENCIA_ADMINISTRATIVA AS Tipos_de_dependencia
FROM Regulacao_Escolas
GROUP BY NOME_DEPENDENCIA_ADMINISTRATIVA;

SELECT * FROM Tipos_de_dependencia_adm;
DROP VIEW Tipos_de_dependencia_adm;





