-- CONSTRUÇÂO DO BANCO DE DADOS
drop database if exists Hospital;
create database Hospital;

use Hospital;

CREATE TABLE if not exists `paciente` (
	`id` int NOT NULL AUTO_INCREMENT,
	`nome` varchar(500) NOT NULL,
	`RG` varchar(9) NOT NULL UNIQUE,
	`CPF` varchar(14) NOT NULL UNIQUE,
	`e-mail` varchar(255) NOT NULL UNIQUE,
	`data_nascimento` DATE NOT NULL,
	`convenio_fk` int,
	PRIMARY KEY (`id`)
);

CREATE TABLE `medico` (
	`id` int NOT NULL AUTO_INCREMENT,
	`nome` varchar(500) NOT NULL,
	`RG` varchar(9) NOT NULL UNIQUE,
	`CPF` varchar(14) NOT NULL UNIQUE,
	`e-mail` varchar(255) NOT NULL UNIQUE,
	`data_nascimento` DATE NOT NULL,
	`CRE` varchar(11) NOT NULL UNIQUE,
	`credencial` varchar(30) NOT NULL UNIQUE,
	`ocupacao` varchar(50) NOT NULL DEFAULT 'especialista',
	`especialidade_fk` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `especialista` (
	`id` int NOT NULL AUTO_INCREMENT,
	`nome_especialidade` varchar(50) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `consulta` (
	`id` int NOT NULL AUTO_INCREMENT,
	`data_hora_realizacao` DATETIME NOT NULL,
	`especialidade_procurada` varchar(50) NOT NULL,
	`valor` DECIMAL(10, 2) NOT NULL,
	`medico_fk` int NOT NULL,
	`paciente_fk` int NOT NULL,
	PRIMARY KEY (`id`), 
    FOREIGN KEY (`paciente_fk`) REFERENCES `paciente` (`id`),
	FOREIGN KEY (`medico_fk`) REFERENCES `medico` (`id`)
);

CREATE TABLE `endereco` (
	`id` int NOT NULL AUTO_INCREMENT,
	`rua` varchar(500) NOT NULL,
	`bairro` varchar(50) NOT NULL,
	`cidade` varchar(50) NOT NULL,
	`estado` varchar(20) NOT NULL,
	`pais` varchar(50) NOT NULL,
	`CEP` varchar(8) NOT NULL,
	`medico_fk` int NOT NULL,
	`paciente_fk` int NOT NULL,
	PRIMARY KEY (`id`),
    FOREIGN KEY (`paciente_fk`) REFERENCES `paciente` (`id`),
	FOREIGN KEY (`medico_fk`) REFERENCES `medico` (`id`)
);

CREATE TABLE `telefone` (
	`id` int NOT NULL AUTO_INCREMENT,
	`ddd` varchar(2) NOT NULL,
	`numero` varchar(9) NOT NULL,
	`medico_fk` int NOT NULL,
	`paciente_fk` int NOT NULL,
	PRIMARY KEY (`id`),
    FOREIGN KEY (`paciente_fk`) REFERENCES `paciente` (`id`),
	FOREIGN KEY (`medico_fk`) REFERENCES `medico` (`id`)
);

CREATE TABLE `convenio` (
	`id` int NOT NULL AUTO_INCREMENT,
	`nome` varchar(500) NOT NULL,
	`CNPJ` varchar(20) NOT NULL UNIQUE,
	`tempo_carencia` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `receita` (
	`id` int NOT NULL AUTO_INCREMENT,
	`medicamentos` varchar(100) NOT NULL,
	`quantidade` INT NOT NULL,
	`orientacoes` varchar(5000) NOT NULL,
	`relatorio` TEXT NOT NULL,
	`consulta_fk` int not null,
	PRIMARY KEY (`id`),
	foreign key (`consulta_fk`) references `consulta` (`id`)
);

CREATE TABLE `internacao` (
	`id` int NOT NULL AUTO_INCREMENT,
	`data_entrada` DATE NOT NULL,
	`data_prevista_alta` DATE NOT NULL,
	`data_efetiva_alta` DATE NOT NULL,
	`descricao_procedimentos` TEXT NOT NULL,
	`paciente_fk` int NOT NULL,
	`medico_fk` int NOT NULL,
	`quarto_fk` int NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`paciente_fk`) REFERENCES `paciente` (`id`),
	FOREIGN KEY (`medico_fk`) REFERENCES `medico` (`id`)
);

/*
CREATE TABLE `controle_enfermeiro_plantao` (
	`id` int NOT NULL AUTO_INCREMENT,
	`data_hora` DATETIME NOT NULL,
	`enfermeiro_fk` int NOT NULL,
	`internacao_fk` int NOT NULL,
	PRIMARY KEY (`id`), 
    foreign key (`internacao_fk`) references `internacao` (`id`)
);
*/

CREATE TABLE `quarto` (
	`id` int NOT NULL AUTO_INCREMENT,
	`numero` varchar(4) NOT NULL,
	`tipo_fk` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `enfermeiro` (
	`id` int NOT NULL AUTO_INCREMENT,
	`nome` varchar(500) NOT NULL,
	`CPF` varchar(14) NOT NULL,
	`CRE` varchar(11) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `tipoQuarto` (
	`id` int NOT NULL AUTO_INCREMENT,
	`valor_diario` INT NOT NULL,
	`descricao` varchar(5000) NOT NULL,
	PRIMARY KEY (`id`)
);

/* Create Table `Plantao` (
	`id` int NOT NULL AUTO_INCREMENT,
	`data_hora` DATETIME NOT NULL,
	`enfermeiro_fk` int not null,
	`internacao_fk` int not null,
    PRIMARY KEY (`id`),
	Foreign key (`enfermeiro_fk`) REFERENCES `enfermeiro` (`id`),
	Foreign key (`internacao_fk`) REFERENCES `internacao` (`id`)
); */

Create Table `Plantao` (
	`id` int NOT NULL AUTO_INCREMENT,
	`data` DATE NOT NULL,
	`hora` TIME NOT NULL,
	`enfermeiro_fk` int not null,
	`internacao_fk` int not null,
    PRIMARY KEY (`id`),
	Foreign key (`enfermeiro_fk`) REFERENCES `enfermeiro` (`id`),
	Foreign key (`internacao_fk`) REFERENCES `internacao` (`id`)
);

ALTER TABLE `paciente` ADD CONSTRAINT `paciente_fk_convenio` FOREIGN KEY (`convenio_fk`) REFERENCES `convenio`(`id`) on delete cascade on update cascade;
ALTER TABLE `medico` ADD CONSTRAINT `medico_fk_especialidade` FOREIGN KEY (`especialidade_fk`) REFERENCES `especialista`(`id`) on delete cascade on update cascade;
ALTER TABLE `internacao` ADD CONSTRAINT `internacao_fk_quarto` FOREIGN KEY (`quarto_fk`) REFERENCES `quarto`(`id`) on delete cascade on update cascade;
-- ALTER TABLE `controle_enfermeiro_plantao` ADD CONSTRAINT `controle_enfermeiro_plantao_fk_enfermeiro` FOREIGN KEY (`enfermeiro_fk`) REFERENCES `enfermeiro`(`id`) on delete cascade on update cascade;

/*
CREATE INDEX `index_tipoQuarto` ON `tipoQuarto` (`id`, `valor_diario`); 
ALTER TABLE `tipoQuarto` DROP INDEX `index_tipoQuarto`;
*/

-- INCLUSÂO DE DADOS

-- especializações
insert into `especialista` (`nome_especialidade`) values ("Clínico Geral"),("Aprendizagem"),("Cirurgiã Plástica"),("Cardiologista"),("Neurologista"),("Dermatologista"),("Pediatria"),("Psicologo"),("Otorrinolaringologia"),("Oftalmologista"),("Ginecologista"),("Urologista"), ("Endocrinologista"), ("Gastrenterologia");


-- medicos
insert into `medico` (`nome`, `RG`, `CPF`, `e-mail`, `data_nascimento`, `CRE`, `credencial`, `ocupacao`, `especialidade_fk`)
VALUES
("Dr. Marcos Oliveira", "1234567", "123.456.789-00", "marcosoliveira@gmail.com", "1980-01-01", "SP-528456", "567890", "Generalista", 1),
("Dra. Fernanda Souza", "9876543", "987.654.321-00", "fernandasouza@hotmail.com", "1985-06-05", "RJ-987654", "345678", "Residente", 2),
("Dr. Gabriel Mendes", "4567891", "456.789.123-00", "lucasmendes@yahoo.com", "1976-12-03", "MG-456789", "234567", "Especialista", 3),
("Dra. Juliana Almeida", "2345678", "234.567.890-00", "julianaalmeida@gmail.com", "1990-09-25", "RS-234567", "789012", "Especialista", 4),
("Dr. Rafael Santos", "3456789", "345.678.901-00", "rafaelsantos@hotmail.com", "1982-02-14", "BA-345678", "123456", "Especialista", 5),
("Dra. Ana Paula Costa", "7890123", "789.012.345-00", "anapaulacosta@yahoo.com.br", "1975-03-07", "GO-789012", "678901", "Especialista", 6),
("Dr. Gustavo Vieira", "5678901", "567.890.123-00", "gustavovieira@gmail.com", "1988-11-22", "SC-567890", "456789", "Especialista", 7),
("Dra. Patrícia Lima", "4567890", "456.789.012-00", "patricialima@hotmail.com", "1979-10-12", "PB-456789", "347478", "Especialista", 8),
("Dr. Alexandre Silva", "1234568", "853.456.789-01", "alexandresilva@yahoo.com.br", "1987-06-17", "DF-123456", "901234", "Especialista", 9),
("Dr. João da Silva", "1278567", "987.474.321-00", "joaosilva@gmail.com", "1980-02-10", "SP-875486", "987654321", "Generalista", 1), 
('Dr. Gabriel Augusto', "2228563", "487.574.351-11", 'gabriel.augusto@gmail.com', "1000-06-17", "DF-873456", "881234", "Especialista", 2),
("Dr. Andresa Silva", "1287768", "123.456.789-01", "andresasilva@yahoo.com.br", "1977-06-17", "SP-123456", "701234", "Especialista", 14);


-- convenios
insert into `convenio` (`nome`, `CNPJ`, `tempo_carencia`)
VALUES
("ConvSaude", "09.665.697/0001-05", "2023-05-07 15:30:00"),
("LifeCare", "15.264.478/0001-89", "2023-05-08 08:45:23"),
("TopCare", "22.321.115/0001-25", "2023-05-09 12:15:00"),
("SOS Saúde", "10.543.332/0001-00", "2023-05-10 18:00:05"),
("Bradesco Saúde", "60.715.273/0001-91", "2023-05-11 09:20:37"),
("Unimed", "02.352.763/0001-21", "2023-05-12 14:10:00"),
("Amil", "29.309.127/0001-79", "2023-05-13 19:55:11"),
("Intermédica", "45.088.348/0001-53", "2023-05-14 10:05:00"),
("Convenio ABC", "60.409.075/0001-76", "2023-05-15 13:30:45"),
("Convenio XYZ", "29.978.814/0001-87", "2023-05-16 17:20:00"),
("Convenio DEF", "33.045.760/0001-06", "2023-05-17 11:00:15");


-- pacientes
insert into `paciente` (`nome`, `RG`, `CPF`, `e-mail`, `data_nascimento`, `convenio_fk`)
VALUES ("Julieu Da Silva", "857857489", "378.786.858-30", "julimeudejuliete@gmail.com", "1995-03-07", 3), 
("Juliete Julieta", "854888489", "378.786.877-30", "julietejulieta@gmail.com", "1995-03-10", 3),
("Maria das Graças", "987654321", "123.456.789-10", "maria.gracas@gmail.com", "1978-10-15", 2),
("João Carlos", "123456789", "987.654.321-00", "joaocarlos@hotmail.com", "1990-05-20", 1),
("Fernanda Oliveira", "852963741", "456.789.123-45", "fernanda.oliveira@gmail.com", "1985-02-10", 4),
("Gabriel Santos", "369852147", "789.456.123-87", "gabriel.santos@gmail.com", "2014-11-30", 5),
("Pedro Henrique", "654123987", "147.258.369-00", "pedrohenrique@gmail.com", "2015-09-22", 6),
("Larissa Silva", "987777321", "246.135.790-11", "larissa.silva@hotmail.com", "2016-06-14", null),
("Marcos Antônio", "123789456", "159.753.246-00", "marcosantonio@hotmail.com", "1982-12-05", 4),
("Jéssica Costa", "456789123", "478.963.123-44", "jessica.costa@gmail.com", "1998-07-23", 1),
("Lucas dos Santos", "789456123", "357.951.246-87", "lucas.santos@hotmail.com", "1994-01-18", 3),
("Paula Pereira", "888963741", "369.852.147-11", "paula.pereira@gmail.com", "1987-08-28", 5),
("Rafaela Souza", "963258741", "147.852.369-00", "rafaela.souza@gmail.com", "1996-04-08", Null),
("Maurício Oliveira", "144489456", "369.258.741-11", "mauricio.oliveira@hotmail.com", "1975-11-01", NULL),
("Luiza Santos", "987456123", "147.852.369-99", "luiza.santos@hotmail.com", "1991-03-16", 2),
("Felipe Castro", "456123789", "369.258.741-22", "felipe.castro@gmail.com", "1999-09-11", 3);


-- consultas
insert into `consulta` (`data_hora_realizacao`, `especialidade_procurada`, `valor`, `medico_fk`, `paciente_fk`)
VALUES ("2023-08-05 08:30:00", "Dermatologia", 1100.00, 6, 1), 
("2018-06-15 08:30:00", "Cardiologia", 1500.00, 4, 2),
("2018-07-02 10:15:00", "Pediatria", 1200.00, 7, 3),
("2019-08-12 14:00:00", "Oftalmologia", 800.00, 10, 7),
("2019-09-23 11:30:00", "Otorrinolaringologia", 1000.00, 9, 6),
("2019-10-09 09:45:00", "Neurologia", 1300.00, 5, 4),
("2019-11-05 13:00:00", "Cardiologia", 900.00, 4, 9),
("2019-12-01 10:30:00", "Pediatria", 600.00, 7, 9),
("2020-01-08 14:45:00", "Psicologia", 950.00, 8, 9),
("2020-02-02 16:00:00", "Dermatologia", 1100.00, 6, 12),
("2020-03-20 09:30:00", "Pediatria", 1200.00, 7, 11),
("2020-04-10 10:15:00", "Oftalmologia", 800.00, 10, 15),
("2020-05-17 11:30:00", "Otorrinolaringologia", 1000.00, 9, 14),
("2020-06-19 09:45:00", "Neurologia", 1300.00, 5, 13),
("2020-07-25 13:00:00", "Cardiologia", 900.00, 4, 14),
("2020-08-21 10:30:00", "Pediatria", 600.00, 7, 13),
("2020-09-15 14:45:00", "Psicologia", 950.00, 8, 10),
("2020-10-10 16:00:00", "Dermatologia", 1100.00, 6, 11),
("2020-11-18 09:30:00", "Pediatria", 1200.00, 7, 12),
("2020-12-03 10:15:00", "Oftalmologia", 800.00, 10, 15),
("2021-01-01 11:30:00", "Otorrinolaringologia", 1000.00, 9, 16);

-- tipo do quarto
INSERT INTO tipoQuarto 
(`valor_diario`, `descricao`)
VALUES
(195.00, 'Apartamento'),
(105.00, 'Quarto duplo'),
(59.99, 'Enfermaria');

-- quarto
INSERT INTO Quarto 
(`numero`, `tipo_fk`)
VALUES
('7-A', 1),
('3-B', 2),
('4-C', 3),
('8-A', 1),
('5-B', 2),
('8-A', 1),
('6-C', 3),
('9-A', 1),
('1-B', 2),
('2-B', 2),
('1-C', 3);

-- internaçao
INSERT INTO internacao 
(`data_entrada`, `data_prevista_alta`, `data_efetiva_alta`, `descricao_procedimentos`, `paciente_fk`, `medico_fk`, `quarto_fk`) 
VALUES
('2019-07-15', '2020-01-10', '2020-01-12', 'Procedimento 1', 11, 11, 3),
('2016-09-22', '2017-03-18', '2017-03-20', 'Procedimento 2', 2, 2, 2),
('2018-05-03', '2018-11-28', '2018-11-30', 'Procedimento 3', 5, 3, 3),
('2017-02-14', '2017-08-10', '2017-08-12', 'Procedimento 4', 5, 5, 2),
('2015-11-27', '2016-05-23', '2016-05-25', 'Procedimento 5', 3, 4, 1),
('2020-10-19', '2021-04-15', '2021-04-17', 'Procedimento 7', 7, 6, 2),
('2016-07-08', '2017-01-03', '2017-01-05', 'Procedimento 2', 7, 8, 1);

-- enfermeiro
INSERT INTO enfermeiro
(`nome`, `CPF`, `CRE`)
VALUES 
("João da Silva", "123.456.789-10", "ABC12345678"),
("Maria Santos", "987.654.321-10", "DEF45678901"),
("Pedro Almeida", "555.555.555-10", "GHI78901234"),
("Ana Oliveira", "111.222.333-10", "JKL01234567"),
("Carlos Souza", "444.444.444-10", "MNO34567890"),
("Lúcia Pereira", "777.888.999-10", "PQR67890123"),
("Mariana Fernandes", "222.333.444-10", "VWX90123456"),
("Rafaela Santos", "555.666.777-10", "YZA78901234"),
("Gabriel Oliveira", "888.999.000-10", "BCD34567890"),
("Fernando Costa", "666.666.666-10", "STU90123456");
-- vares chares kk varchar

/* -- platão
INSERT INTO Plantao
(`data_hora`, `enfermeiro_fk`, `internacao_fk`)
VALUES 
("2019-07-15 08:30:00", 1, 1),
("2019-07-15 16:30:00", 2, 1),
("2019-07-15 24:30:00", 3, 1),

('2016-09-22 08:30:00', 2, 2),
('2016-09-22 16:30:00', 3, 2),
('2016-09-22 24:30:00', 4, 2),

('2018-05-03 08:30:00', 3, 3),
('2018-05-03 16:30:00', 4, 3),
('2018-05-03 24:30:00', 5, 3),

('2017-02-14 08:30:00', 4, 4),
('2017-02-14 16:30:00', 5, 4),
('2017-02-14 24:30:00', 6, 4),

('2015-11-27 08:30:00', 5, 5),
('2015-11-27 16:30:00', 9, 5),
('2015-11-27 24:30:00', 8, 5),

('2020-10-19 08:30:00', 6, 6),
('2020-10-19 16:30:00', 7, 6),
('2020-10-19 24:30:00', 1, 6),

('2016-07-08 08:30:00', 7, 7),
('2016-07-08 16:30:00', 8, 7),
('2016-07-08 24:30:00', 10, 7); */

-- platão
INSERT INTO Plantao
(`data`, `hora`, `enfermeiro_fk`, `internacao_fk`)
VALUES 
("2019-07-15", "08:30:00", 1, 1),
("2019-07-15", "16:30:00", 2, 1),
("2019-07-15", "24:30:00", 3, 1),

('2016-09-22','08:30:00', 2, 2),
('2016-09-22','16:30:00', 3, 2),
('2016-09-22','24:30:00', 4, 2),

('2018-05-03','08:30:00', 3, 3),
('2018-05-03','16:30:00', 4, 3),
('2018-05-03','24:30:00', 5, 3),

('2017-02-14','08:30:00', 4, 4),
('2017-02-14','16:30:00', 5, 4),
('2017-02-14','24:30:00', 6, 4),

('2015-11-27','08:30:00', 5, 5),
('2015-11-27','16:30:00', 9, 5),
('2015-11-27','24:30:00', 8, 5),

('2020-10-19','08:30:00', 6, 6),
('2020-10-19','16:30:00', 7, 6),
('2020-10-19','24:30:00', 1, 6),

('2016-07-08','08:30:00', 7, 7),
('2016-07-08','16:30:00', 8, 7),
('2016-07-08','24:30:00', 10, 7);

INSERT INTO `receita` (`medicamentos`, `quantidade`, `orientacoes`, `relatorio`, `consulta_fk`) VALUES ('Paracetamol', 2, 'Tomar 1 comprimido de 500mg a cada 6 horas', 'Paciente apresentando sintomas de febre e dor de cabeça', 1),
('Dipirona', 1, 'Tomar 1 comprimido de 1g a cada 8 horas', 'Paciente com quadro de dor intensa', 2),
('Ibuprofeno', 3, 'Tomar 1 comprimido de 200mg a cada 8 horas', 'Paciente com inflamação nas articulações', 3),
('Amoxicilina', 2, 'Tomar 1 comprimido de 500mg a cada 12 horas', 'Paciente com infecção respiratória', 4),
('Omeprazol', 1, 'Tomar 1 comprimido de 20mg antes das refeições', 'Paciente com sintomas de azia e má digestão', 5),
('Sinvastatina', 1, 'Tomar 1 comprimido de 10mg antes de dormir', 'Paciente com colesterol alto', 6),
('Dexametasona', 2, 'Aplicar uma pomada fina na área afetada duas vezes ao dia', 'Paciente com dermatite', 7);

-- ALTERAÇÃO DE DADOS

-- adicionando coluna
ALTER TABLE `medico` 
add column `em_atividade` varchar(20) default "Ativo";


-- adicionando dados na coluna adicionada
update `medico` 
set em_atividade = 'Ativo'
where id = 1;
update `medico` set em_atividade = 'Inativo' where id = 2;
update `medico` set em_atividade = 'Ativo' where id = 3;
update `medico` set em_atividade = 'Ativo' where id = 4;
update `medico` set em_atividade = 'Inativo' where id = 5;
update `medico` set em_atividade = 'Ativo' where id = 6;
update `medico` set em_atividade = 'Inativo' where id = 7;
update `medico` set em_atividade = 'Ativo' where id = 8;

-- CONSULTANDO DADOS

-- 1º - A media do valor das consulta onde existem convenio em 2020
select *, ROUND(AVG(c.valor), 2) as valor_medio_consulta from `consulta` c 
JOIN `paciente` p 
ON c.paciente_fk = p.id
where year(`data_hora_realizacao`) = 2020 
HAVING p.convenio_fk IS NOT NULL;
-- Depois todos os dados dos pacientes com convenio de 2020
select * from `consulta` c 
JOIN `paciente` p 
ON c.paciente_fk = p.id
where year(`data_hora_realizacao`) = 2020 
GROUP BY c.id
HAVING p.convenio_fk IS NOT NULL
ORDER BY c.id ASC;


-- 2º - Todos os dados das internações que tiveram data de alta maior que a data prevista para a alta
SELECT *
FROM `internacao`
WHERE data_efetiva_alta > data_prevista_alta
ORDER BY data_prevista_alta ASC;


-- 3º - Receituário completo da primeira consulta registrada com receituário associado
select r.* from `consulta` c 
inner join `receita` r 
on r.consulta_fk = c.id
group by r.id 
order by c.id asc
limit 1;


-- 4º - Todos os dados da consulta de maior valor e também da de menor valor (ambas as consultas não foram realizadas sob convênio)
select * from consulta c inner join paciente p on c.paciente_fk = p.id where p.convenio_fk is null order by c.valor desc limit 1;
select * from consulta c inner join paciente p on c.paciente_fk = p.id where p.convenio_fk is null order by c.valor asc limit 1;


-- 5º - Todos os dados das internações em seus respectivos quartos, calculando o total da internação a partir do valor de diária do quarto e o número de dias entre a entrada e a alta
select i.*, tq.valor_diario, DATEDIFF(i.data_efetiva_alta, i.data_entrada) as num_dias, 
FORMAT((DATEDIFF(i.data_efetiva_alta, i.data_entrada) * tq.valor_diario), 2) as total_internacao 
from internacao i 
inner join quarto q on i.quarto_fk = q.id 
inner join tipoQuarto tq on q.tipo_fk = tq.id;


-- 6º - Data, procedimento e número de quarto de internações em quartos do tipo “apartamento”
SELECT i.data_entrada, i.descricao_procedimentos, q.numero, i.quarto_fk, tq.descricao
FROM internacao i
INNER JOIN Quarto q ON i.quarto_fk = q.id
INNER JOIN tipoQuarto tq ON q.tipo_fk = tq.id
WHERE q.tipo_fk = 1;


-- 7º - Nome do paciente, data da consulta e especialidade de todas as consultas em que os pacientes eram menores de 18 anos na data da consulta e cuja especialidade não seja “pediatria”, ordenando por data de realização da consulta
SELECT p.nome, DATE(c.data_hora_realizacao) AS Data_Consulta, c.especialidade_procurada
FROM paciente p
INNER JOIN consulta c ON c.paciente_fk = p.id
WHERE TIMESTAMPDIFF(YEAR, p.data_nascimento, CURDATE()) < 18 AND c.especialidade_procurada <> 'pediatria'
ORDER BY c.data_hora_realizacao;


-- 8º - Nome do paciente, nome do médico, data da internação e procedimentos das internações realizadas por médicos da especialidade “gastroenterologia”, que tenham acontecido na “enfermaria”
select p.nome as paciente, m.nome as medico , i.data_entrada, i.descricao_procedimentos, q.id
from internacao i
inner join medico m 
on m.id = i.medico_fk
inner join paciente p
on p.id = i.paciente_fk
inner join quarto q
on q.id = i.quarto_fk
where q.tipo_fk = 3 and m.especialidade_fk = 14;


-- 9º - Os nomes dos médicos, suas credenciais e a quantidade de consultas que cada um realizou
select m.nome as medico, m.credencial, count(c.medico_fk) as 'Qntd de consultas' 
from medico m inner join consulta c 
on c.medico_fk = m.id group by c.medico_fk;


-- 10º - Todos os médicos que tenham "Gabriel" no nome
select * from medico where nome like '%Gabriel%';


-- 11º - Os nomes, CREs e número de internações de enfermeiros que participaram de mais de uma internação
select e.nome as enfermeiro, e.CRE, COUNT(p.enfermeiro_fk) as participaramDeMaisDe1 
from enfermeiro e inner join plantao p on p.enfermeiro_fk = e.id 
group by e.id having participaramDeMaisDe1 > 1;

