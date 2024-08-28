#SCHEMA seria equivalente ao database
CREATE SCHEMA CLUBE_DO_LIVRO;

#Cria a tabela livros com as caracteristicas dentro, INT é numero inteiro, Varchar é caracteres e Decimal é numeros (numeros, casas decimais)

CREATE TABLE LIVROS (
ID_LIVRO INT NOT NULL,
NOME_LIVRO VARCHAR(100) NOT NULL,
AUTORIA VARCHAR(100) NOT NULL,
EDITORA VARCHAR(100) NOT NULL,
CATEGORIA VARCHAR(100) NOT NULL,
PREÇO DECIMAL(5,2) NOT NULL,
PRIMARY KEY (ID_LIVRO)
);

CREATE TABLE ESTOQUE (
    ID_LIVRO INT NOT NULL,
    QTD_ESTOQUE INT NOT NULL,
 PRIMARY KEY (ID_LIVRO)
);

CREATE TABLE VENDAS (
	ID_PEDIDOS INT NOT NULL,
	ID_VENDEDOR INT NOT NULL,
	ID_LIVRO INT NOT NULL,
	QND_VENDIDA INT NOT NULL,
	DATA_VENDA DATE NOT NULL,
PRIMARY KEY (ID_VENDEDOR, ID_PEDIDOS)
);

CREATE TABLE VENDEDORES (
    ID_VENDEDOR INT NOT NULL,
    NOME_VENDEDOR VARCHAR(255) NOT NULL,
 PRIMARY KEY (ID_VENDEDOR)
);

# Adiciona uma chave estrangeira na tabela vendedores referenciando o ID vendedor da tabela vendas, on delete e on update, da erro caso nao exista um na tabela do outro
#ALTER TABLE VENDAS ADD CONSTRAINT CE_VENDEDORES_VENDAS
#FOREIGN KEY (ID_VENDEDOR)
#REFERENCES VENDAS (ID_VENDEDOR)
#ON DELETE NO ACTION
#ON UPDATE NO ACTION;

ALTER TABLE ESTOQUE ADD CONSTRAINT CE_ESTOQUE_LIVROS
FOREIGN KEY (ID_LIVRO) 
REFERENCES LIVROS (ID_LIVRO)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

#Anulando as chaves estrangeiras
SET FOREIGN_KEY_CHECKS = 0;

#Adicionando dentro da tabela livros um livro
INSERT INTO LIVROS VALUES(
1,
"Percy_Jackson_e_o_ladrao_de_Raios",
"Rick_Riordan",
"Intrínseca",
"Aventura",
"34.65");

#inserindo multiplas linhas na tabela

INSERT INTO LIVROS VALUES(
2, 'A Volta ao mundo em 80 dias', 'Aluísio de Azevedo', 'Panda Books', 'Romance', '47.80'),
(3, 'O Cortiço', 'Aluísio de Azevedo', 'Panda Books', 'Romance', '47.80'),
(4, 'Dom Casmurro', 'Machado de Assís', 'Via Leitura', 'Romance', '48');

INSERT INTO LIVROS VALUES
(5,    'Memórias Póstumas de Brás Cubas',    'Machado de Assis',    'Antofágica',    'Romance',    45),
(6,    'Quincas Borba',                 'Machado de Assis',    'L&PM Editores', 'Romance',    48.5),
(7,    'Ícaro',                             'Gabriel Pedrosa',     'Ateliê',          'Poesia',    36),
(8,    'Os Lusíadas',                     'Luís Vaz de Camões',  'Montecristo',   'Poesia',    18.79),
(9,    'Outros Jeitos de Usar a Boca',    'Rupi Kaur',          'Planeta',          'Poesia',    34.8);

INSERT INTO VENDEDORES VALUES
(1,'Paula Rabelo'),
(2,'Juliana Macedo'),
(3,'Roberto Barros'),
(4,'Barbara Jales');

INSERT INTO VENDAS 
VALUES 
(1, 3, 7, 1, '2020-11-02'),
(2, 4, 8, 2, '2020-11-02'),
(3, 4, 4, 3, '2020-11-02'),
(4, 1, 7, 1, '2020-11-03'),
(5, 1, 6, 3, '2020-11-03'),
(6, 1, 9, 2, '2020-11-04'),
(7, 4, 1, 3, '2020-11-04'),
(8, 1, 5, 2, '2020-11-05'),
(9, 1, 2, 1, '2020-11-05'),
(10, 3, 8, 2, '2020-11-11'),
(11, 1, 1, 4, '2020-11-11'),
(12, 2, 10, 10, '2020-11-11'),
(13, 1, 12, 5, '2020-11-18'),
(14, 2, 4, 1, '2020-11-25'),
(15, 3, 13, 2,'2021-01-05'),
(16, 4, 13, 1, '2021-01-05'),
(17, 4, 4, 3, '2021-01-06'),
(18, 2, 12, 2, '2021-01-06');

INSERT INTO ESTOQUE 
VALUES
(1,  7),
(2,  10),
(3,  2),
(8,  4),
(10, 5),
(11, 3),
(12, 3);

#Adicionado fora de ordem
INSERT INTO LIVROS 
( CATEGORIA, AUTORIA, NOME_LIVRO, EDITORA, ID_LIVRO, PREÇO)
VALUES
('Biografia', 'Anne Frank', 'Diário de Anne Frank', 'Pé Da Letra', 12, 34.90);

#Inserindo valores fora de ordem
INSERT INTO LIVROS 
(CATEGORIA, AUTORIA, NOME_LIVRO, EDITORA, ID_LIVRO, PREÇO)
VALUES
('Biografia' ,	'Malala Yousafzai', 'Eu sou Malala'       , 'Companhia das Letras', 10, 22.32),
('Biografia' ,	'Michelle Obama'  , 'Minha história'      , 'Objetiva'            ,	13,	57.90);

#######       Código Extra      ########
# Excluindo uma tabela
# DROP TABLE VENDEDORES;

#Selecionando informações da tabela LIVROS 
SELECT * FROM LIVROS;

#Apelidando campo
SELECT ID_LIVRO AS "Código do Livro" FROM LIVROS;

#Fazendo um filtro
SELECT * FROM LIVROS
WHERE CATEGORIA = 'BIOGRAFIA';

SELECT * FROM LIVROS
WHERE CATEGORIA = 'ROMANCE' AND PREÇO <48;

SELECT * FROM LIVROS
WHERE CATEGORIA = 'POESIA' AND NOT (AUTORIA = 'Luís Vaz de Camões' OR AUTORIA = 'Gabriel Pedrosa');

SELECT NOME_LIVRO FROM LIVROS WHERE NOME_LIVRO LIKE '%CA%';

SELECT * FROM VENDAS;

SELECT DISTINCT ID_LIVRO FROM VENDAS
WHERE ID_VENDEDOR = 1
ORDER BY ID_LIVRO;

#Excluindo 

SELECT * FROM LIVROS;

DELETE FROM LIVROS WHERE ID_LIVRO = 8;

SELECT * FROM LIVROS;

#Alterar o valor dos livros para 10% de desconto

UPDATE LIVROS SET PREÇO = 0.9*PREÇO;

SET SQL_SAFE_UPDATES = 0;

#sELECIONANDO INFORMAÇÕES ESPECIFICAS DAS TABELAS

SELECT VENDAS.ID_VENDEDOR, VENDEDORES.NOME_VENDEDOR, SUM(VENDAS.QND_VENDIDA) AS 'VENDAS'
FROM VENDAS, VENDEDORES  # Declara a origem dos dados
WHERE VENDAS.ID_VENDEDOR = VENDEDORES.ID_VENDEDOR # Relaciona os dois, somando
GROUP BY VENDAS.ID_VENDEDOR; #Por pessoa

#Inner Join é juntar as duas tabelas

SELECT VENDAS.ID_VENDEDOR, VENDEDORES.NOME_VENDEDOR, SUM(VENDAS.QND_VENDIDA) AS 'VENDAS'
FROM VENDAS INNER JOIN VENDEDORES  # Declara a origem dos dados
ON VENDAS.ID_VENDEDOR = VENDEDORES.ID_VENDEDOR # Relaciona os dois, somando
GROUP BY VENDAS.ID_VENDEDOR; #Por pessoa

SELECT MAX(QND_VENDIDA) FROM VENDAS
GROUP BY(ID_VENDEDOR);

# Será que todos os livros da nossa base de dados foram vendidos?
#LEFT JOIN E RIGHT JOIN
SELECT VENDAS.ID_LIVRO,
	   LIVROS.NOME_LIVRO,
	   VENDAS.QND_VENDIDA
FROM LIVROS RIGHT JOIN VENDAS
ON LIVROS.ID_LIVRO = VENDAS.ID_LIVRO

#SELECT <CAMPOS>
#FROM TABELA_A
#INNER JOIN TABELA_B
#ON TABELA_A.CAMPO = TABELA_B.CAMPO