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
pago BIT NOT NULL, /*check S ou N*/
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
CONSTRAINT fk_ConsultaTipoServico_TipoServico FOREIGN KEY (idConsulta) REFERENCES tiposervico (idTipoServico) 
)

