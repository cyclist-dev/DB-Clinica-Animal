/*Criar tabela com unique*/
CREATE TABLE cliente (
idCliente INT PRIMARY KEY AUTO_INCREMENT, 
nomeCliente VARCHAR(50) NOT NULL,
cpf CHAR(11) NOT NULL UNIQUE,
celular CHAR(11) NOT NULL,
email VARCHAR(50) NOT NULL,
cidade VARCHAR(50) NOT NULL,
estado CHAR(2) NOT NULL,
cep CHAR(8),
tipoLogradouro VARCHAR (15) NOT NULL,
nomeLogradouro VARCHAR (50) NOT NULL,
numero VARCHAR (6) NOT NULL,
complemento VARCHAR(30)
)

DROP TABLE cliente /*Exclui a Tabela ~cliente~*/

CREATE TABLE contatoTelefonico (
idContatoTelefonico INT PRIMARY KEY,
idCliente INT NOT NULL,/*foreign key*/
ddi VARCHAR(5) NOT NULL,
ddd VARCHAR(5) NOT NULL,
numero CHAR(9) NOT NULL 
/*Constraint é usada aqui quando há chaves secundárias (outras PK)*/
)

/*Altera a tabela anterior "contatoTelefonico" adicionando a chave
"idCliente" (caso não tenha adicionado na primeira vez)*/
ALTER TABLE contatoTelefonico
ADD CONSTRAINT fk_contatoTelefonico_Cliente 
FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)

/*Criando a tabela com o FK*/
CREATE TABLE Animal(
idAnimal INT PRIMARY KEY AUTO_INCREMENT,
idCliente INT NOT NULL,
nomeAnimal VARCHAR(50) NOT NULL,
especie VARCHAR(50) NOT NULL,
raca VARCHAR(50) NOT NULL,
peso DECIMAL(5,2),
porte CHAR(1), 
sexo CHAR(1),
anoNascimento INT NOT NULL,
/*Algumas CONSTRAINTs são dispensáveis mas muitas vezes é importante adicionar
para garantir a eficiência de alguns dados*/
CONSTRAINT ck_sexoAnimal CHECK (sexo='M' OR sexo='F'),
CONSTRAINT ck_porteAnimal CHECK (porte IN ('PP', 'P' 'M', 'G', 'GG')),
CONSTRAINT fk_Animal_Cliente FOREIGN KEY(idCliente) REFERENCES cliente(idCliente)
)

DROP TABLE Veterinario

CREATE TABLE Veterinario(
idVeterinario INT PRIMARY KEY AUTO_INCREMENT,
nomeVeterinario VARCHAR(50) NOT NULL,
crm VARCHAR(20) NOT NULL UNIQUE,
celular CHAR(11) NOT NULL,
especialidade VARCHAR(50)
) 

CREATE TABLE Consulta(
idConsulta INT PRIMARY KEY AUTO_INCREMENT,
idAnimal INT NOT NULL,
idVeterinario INT NOT NULL,
dataHora DATETIME NOT NULL,
pago VARCHAR(50) NOT NULL, /*check S ou N*/
formaPgto VARCHAR(50),
qtdVezes TINYINT,
valorTotal DECIMAL(10,2) NOT NULL,
valorPago DECIMAL(10,2) NOT NULL,
CONSTRAINT ck_pago CHECK (pago='sim' OR pago='nao'),
CONSTRAINT fk_Consulta_Veterinario FOREIGN KEY (idVeterinario) REFERENCES veterinario (idVeterinario),
CONSTRAINT fk_Consulta_Animal FOREIGN KEY (idAnimal) REFERENCES animal (idAnimal)
)

CREATE TABLE tipoServico(
idTipoServico INT PRIMARY KEY AUTO_INCREMENT,
nomeServico VARCHAR(50) NOT NULL,
valor DECIMAL(10,2) NOT NULL
)

CREATE TABLE ConsultaTipoServico(
idConsultaTipoServico INT PRIMARY KEY AUTO_INCREMENT,
idConsulta INT NOT NULL, 
idTipoServico INT NOT NULL,
valorServico DECIMAL(10,2),
CONSTRAINT fk_ConsultaTipoServico_Consulta FOREIGN KEY (idConsulta) REFERENCES consulta (idConsulta),
CONSTRAINT fk_ConsultaTipoServico_TipoServico FOREIGN KEY (idTipoServico) REFERENCES tiposervico (idTipoServico) 
)

SHOW TABLES; /*mostra as tabelas criadas no bd*/

SELECT * FROM cliente /*busca dados de uma tabela especifica*/

SELECT nomeCliente, celular, email FROM cliente /*busca de dados*/

INSERT INTO cliente  /*inserir dados em determinada tabela*/
(nomeCliente, cpf, email, cidade, estado, cep, tipoLogradouro, nomeLogradouro, numero, complemento)
VALUES
('Neymar Santos Filho', '88544722166', 'mininuney@mail.com', 'Santos', 'SP', '32145220', 'Avenida',
'dos Milionarios', '10', 'null'),
('Erico Schwarzenegger', '05533229960', 'schwarzenegger@mail.com', 'Trindade', 'RJ', '21065901', 'Rua',
 'das Lagrimas', '74', 'cima'), 
('Lisbeth Shneider', '03848122200', 'jonasbob@mail.com', 'Belfort Roxo', 'RJ', '26350001', 'Rua',
 'das Bandeiras', '1288', 'APT53'), 
('Katy Perry da Silva', '11112002300', 'dasilva@mail.com', 'Cubatao', 'SP', '12345220', 'Avenida',
'9 de Abril', '2300', 'SALA7')
/*atualizar dado em determinada tabela*/

UPDATE cliente 
SET celular= '11935144776'
WHERE idcliente= '11'

UPDATE cliente 
SET celular= '13996676861'
WHERE idcliente= '10'

UPDATE cliente 
SET celular='11955558748',
   email='meninoney@mail.com'
WHERE idcliente='11'   


/*buscando com filtros*/
SELECT nomeCliente, email, cidade, estado FROM cliente
WHERE cidade='Cubatao' OR cidade='santos'

SELECT nomeCliente, email, cidade, estado FROM cliente
WHERE estado='SP'

/*busca ordenada*/
SELECT nomeCliente, cidade FROM cliente
ORDER BY nomeCliente DESC 

SELECT nomeCliente, cidade FROM cliente
ORDER BY nomeCliente ASC  

SELECT nomeCliente, cidade FROM cliente
ORDER BY nomeCliente  /*Padrão ASC (A-Z)*/

SELECT nomeCliente, estado FROM cliente
WHERE estado='sp'
ORDER BY nomeCliente

/*excluir dados de determinada tabela*/
DELETE FROM cliente
WHERE cidade='cubatao'

DELETE FROM cliente
WHERE idCliente>6 AND idCliente<10

INSERT INTO animal (idCliente, nomeAnimal, especie, raca, peso, porte, sexo, anoNascimento)
VALUES 
(1, 'Marolas', 'cachorro', 'pinscher', 4.1, 'P', 'F', 2017),
(2, 'Lili', 'cachorro', 'SRD', 12.1, 'M', 'M', 2021),
(3, 'Yoruichi', 'gato', 'SRD', 7.5, 'G', 'M', 2020),
(4, 'Rukia', 'gato', 'SRD', 7.8, 'G', 'M', 2017);

SELECT consulta.dataHora,
      a.nomeAnimal,
      c.nomeCliente,
      veterinario.nomeVeterinario,
      tiposervico.nomeServico
FROM cliente c
INNER JOIN animal a
ON c.idCliente = a.idCliente
INNER JOIN consulta
ON a.idAnimal = consulta.idAnimal
INNER JOIN veterinario 
ON consulta.idVeterinario = veterinario.idVeterinario     
INNER JOIN consultaTipoServico
ON consultaTipoServico.idConsulta = consulta.idConsulta
INNER JOIN tipoServico
ON tiposervico.idTipoServico = consultaTipoServico.idTipoServico


SELECT veterinario.nomeVeterinario,
      consulta.dataHora,
      animal.nomeAnimal
FROM veterinario 
LEFT JOIN consulta
ON veterinario.idVeterinario = consulta.idVeterinario
LEFT JOIN animal
ON animal.idAnimal = consulta.idAnimal

SELECT COUNT (idConsulta) FROM consulta

/*Trazer o serviço mais caro da clínica*/
SELECT MAX(valor) FROM tiposervico  
 
/*Trazer o serviço mais barato da clínica*/
SELECT MIN(valor) FROM tiposervico
 
/*Trazer a média dos valores dos serviços */
SELECT AVG(valor) AS 'Média de valores' FROM tiposervico
 
/*Trazer o faturamento bruto da clínica*/
SELECT SUM(valorservico) AS 'Faturamento' FROM consultatiposervico

/*Trazer a quantidade de consultas que ocorreram com 
cada animalzinho 
Ex.: Bidu --------- 3 consultas 
   Penélope ----- 2 consultas*/
     
SELECT nomeAnimal, COUNT(idConsulta) AS 'Qtd de Consultas'
FROM consulta LEFT JOIN animal
INNER JOIN animal
ON consulta.idAnimal = animal.idAnimal
GROUP BY nomeAnimal




