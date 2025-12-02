-- =============================================
-- Projeto: Streaming
-- Descrição: Projeto de banco de dados relacional para um sistema de streaming de vídeos
-- Autores: Matheus Marques, Wesley Freitas, Isaque Silva
-- Data: 02/12/2025
-- =============================================
DROP DATABASE IF EXISTS streaming;
CREATE DATABASE IF NOT EXISTS streaming;
USE streaming;

-- Tabela de assinantes
CREATE TABLE IF NOT EXISTS assinantes (
	id_assinante INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha_hash VARCHAR(256) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_registro TIMESTAMP NOT NULL
);

DESCRIBE assinantes;

CREATE TABLE IF NOT EXISTS perfis (
	id_perfil INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_assinante INT NOT NULL, FOREIGN KEY (id_assinante) REFERENCES assinantes(id_assinante) ON DELETE CASCADE,
    nome_perfil VARCHAR(50) NOT NULL,
    avatar VARCHAR(255),
    restricao_idade INT DEFAULT 0
);

DESCRIBE perfis;

CREATE TABLE IF NOT EXISTS conteudos (
	id_conteudo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    titulo VARCHAR(255) NOT NULL UNIQUE,
    sinopse VARCHAR(1000) NOT NULL,
    ano_lancamento INT NOT NULL,
    duracao_minutos INT NULL,
    classificacao_indicativa VARCHAR(10) NOT NULL,
    tipo VARCHAR(10) NOT NULL
);

DESCRIBE conteudos;

CREATE TABLE IF NOT EXISTS generos (
	id_genero INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_genero VARCHAR(50) NOT NULL
);

DESCRIBE generos;

CREATE TABLE IF NOT EXISTS conteudos_generos (
	id_conteudo INT NOT NULL, FOREIGN KEY (id_conteudo) REFERENCES conteudos(id_conteudo) ON DELETE CASCADE,
    id_genero INT NOT NULL, FOREIGN KEY (id_genero) REFERENCES generos(id_genero) ON DELETE CASCADE,
    PRIMARY KEY (id_conteudo, id_genero)
);

CREATE TABLE IF NOT EXISTS sessoes_assistidas (
	id_sessao INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	id_perfil INT NOT NULL, FOREIGN KEY (id_perfil) REFERENCES perfis(id_perfil),
	id_conteudo INT NOT NULL, FOREIGN KEY (id_conteudo) REFERENCES conteudos(id_conteudo),
	data_hora_inicio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	tempo_assistido INT NOT NULL,
	finalizado TINYINT NOT NULL DEFAULT 0
);

SHOW TABLES;
    
INSERT INTO assinantes (nome, email, senha_hash, data_nascimento) VALUES
	('Gabriel Santos', 'gabrielsantos@gmail.com', SHA2('Gabriel1234#', 256), '1997-03-16'),
    ('Everton Silva', 'evertonsilva@gmail.com', SHA2('Ev3rt0n1@00', 256), '1982-08-15'),
    ('Maria Clara', 'mariaclara@gmail.com', SHA2('Maria019232', 256), '2005-05-21'),
    ('Joao Pedro', 'joaopedro@gmail.com', SHA2('Joao#07', 256), '2000-07-10'),
    ('Larissa Ferreira', 'larissaferreira@gmail.com', SHA2('Lar1@123', 256), '2006-04-09'),
    ('Sofia Mendes', 'sofia.mendes@email.com', SHA2('Sofia456', 256), '1992-11-03'),
	('Ricardo Almeida', 'ricardo.a@email.com', SHA2('Rico987', 256), '1978-01-22'),
	('Camila Souza', 'camilasouza@email.com', SHA2('Camila55', 256), '2003-12-19'),
	('Felipe Guedes', 'felipe.guedes@email.com', SHA2('Felipe777', 256), '1990-06-08'),
	('Patricia Lima', 'patricia.lima@email.com', SHA2('Pati111', 256), '1985-09-28'),
	('Vitor Hugo', 'vitor.hugo@email.com', SHA2('V1t0r0102', 256), '2004-02-14'),
	('Juliana Paes', 'ju.paes@email.com', SHA2('JuPaes', 256), '1998-04-30'),
	('Lucas Rocha', 'lucas.rocha@email.com', SHA2('Lucas123#', 256), '1996-10-11'),
	('Renata Costa', 'renata.costa@email.com', SHA2('Rena@23', 256), '1980-07-01'),
	('Gustavo Oliveira', 'gustavo.o@email.com', SHA2('Gus10', 256), '2002-03-25');

INSERT INTO perfis (id_assinante, nome_perfil, restricao_idade) VALUES
	(1, 'Gabriel', 18),
    (1, 'Yasmin', 18),
    (2, 'Everton', 18),
    (2, 'Geovana', 18),
    (2, 'Marcos', 18),
    (3, 'Maria', 18),
    (4, 'Joao', 18),
    (5, 'Larissa', 18),
    (6, 'Sofia', 18),
    (6, 'Manuela kids', 12),
    (7, 'Ricardo', 18),
    (7, 'Mariana', 18),
    (8, 'Camila', 18),
    (9, 'Felipe', 18),
    (9, 'Fernanda', 18),
    (10, 'Patricia', 18),
    (11, 'Vitor', 18),
    (12, 'Juliana', 18),
    (13, 'Lucas', 18),
    (14, 'Renata', 18),
    (15, 'Gustavo', 18);
    
INSERT INTO conteudos (titulo, sinopse, ano_lancamento, duracao_minutos, classificacao_indicativa, tipo) VALUES

	-- Filmes
	('O Código da Sombra', 'Um hacker descobre uma conspiração global.', 2023, 115, '16', 'Filme'),   
	('A Última Fronteira', 'A jornada épica de uma nave em busca de um novo lar.', 2021, 140, '14', 'Filme'), 
	('A Herança Perdida', 'Comédia de erros sobre uma família em crise.', 2024, 95, 'L', 'Filme'),        
	('A Ilha dos Desaparecidos', 'Um suspense psicológico em uma ilha isolada.', 2020, 120, '18', 'Filme'),  
	('O Segredo do Farol', 'Documentário sobre a história dos faróis no Brasil.', 2018, 55, 'L', 'Filme'),   

	-- Séries
	('Guardiões do Abismo', 'Série de fantasia medieval com dragões e magia.', 2022, NULL, '14', 'Série'), 
	('A Revolta de Gaia', 'Ficção científica sobre uma inteligência artificial rebelde.', 2023, NULL, '16', 'Série'), -- ID 7
	('Rua da Esperança', 'Drama familiar que acompanha os moradores de um bairro simples.', 2019, NULL, '10', 'Série'), -- ID 8
	('Patrulha Estelar', 'Animação para crianças sobre exploradores espaciais.', 2024, NULL, 'L', 'Série'),  
	('A Lei do Rio', 'Série policial sobre crimes na zona portuária.', 2021, NULL, '18', 'Série');         
    
INSERT INTO generos (nome_genero) VALUES
('Ficção Científica'), 
('Aventura'),         
('Comédia'),         
('Documentário'),     
('Fantasia'),          
('Ação'),           
('Terror'),        
('Romance'),          
('Drama'),           
('Animação');        

INSERT INTO conteudos_generos (id_conteudo, id_genero) VALUES
	
-- Conteúdo 1: O Código da Sombra (Ação, Drama)
	(1, 6), 
    (1, 9), 

-- Conteúdo 2: A Última Fronteira (Ficção Científica, Aventura)
	(2, 1), 
	(2, 2), 

-- Conteúdo 3: A Herança Perdida (Comédia, Romance)
	(3, 3), 
	(3, 8), 

-- Conteúdo 4: A Ilha dos Desaparecidos (Terror, Drama)
	(4, 7), 
	(4, 9), 

-- Conteúdo 5: O Segredo do Farol (Documentário)
	(5, 4), 

-- Conteúdo 6: Guardiões do Abismo (Fantasia, Aventura)
	(6, 5), 
	(6, 2), 

-- Conteúdo 7: A Revolta de Gaia (Ficção Científica, Ação)
	(7, 1), 
	(7, 6), 

-- Conteúdo 8: Rua da Esperança (Drama, Romance)
	(8, 9), 
	(8, 8), 

-- Conteúdo 9: Patrulha Estelar (Animação, Aventura)
	(9, 10), 
	(9, 2), 

-- Conteúdo 10: A Lei do Rio (Ação, Drama)
	(10, 6), 
	(10, 9);
	
INSERT INTO sessoes_assistidas (id_perfil, id_conteudo, tempo_assistido, finalizado) VALUES
-- Perfil 1 (Gabriel) - Assinante 1
(1, 1, 115, 1),  -- O Código da Sombra (Finalizado)
(1, 7, 40, 0),   -- A Revolta de Gaia (Parcial)

-- Perfil 2 (Yasmin) - Assinante 1
(2, 3, 95, 1),   -- A Herança Perdida (Finalizado)
(2, 1, 10, 0),   -- O Código da Sombra (Parcial)

-- Perfil 3 (Everton) - Assinante 2
(3, 2, 140, 1),  -- A Última Fronteira (Finalizado)
(3, 10, 35, 0),  -- A Lei do Rio (Parcial)

-- Perfil 4 (Geovana) - Assinante 2
(4, 8, 50, 0),   -- Rua da Esperança (Parcial)
-- Perfil 5 (Marcos) - Assinante 2
(5, 5, 55, 1),   -- O Segredo do Farol (Finalizado)

-- Perfil 6 (Maria) - Assinante 3
(6, 6, 80, 0),   -- Guardiões do Abismo (Parcial)
-- Perfil 7 (Joao) - Assinante 3
(7, 4, 120, 1), -- A Ilha dos Desaparecidos (Finalizado)

-- Perfil 8 (Larissa) - Assinante 4
(8, 2, 70, 0),  -- A Última Fronteira (Parcial)
-- Perfil 9 (Sofia) - Assinante 5
(9, 9, 30, 1),  -- Patrulha Estelar (Finalizado)

-- Perfil 10 (Manuela kids) - Assinante 5
(10, 9, 15, 0), -- Patrulha Estelar (Parcial)
-- Perfil 11 (Ricardo) - Assinante 6
(11, 7, 90, 0), -- A Revolta de Gaia (Parcial)

-- Perfil 12 (Mariana) - Assinante 6
(12, 3, 50, 0), -- A Herança Perdida (Parcial)

-- Perfil 14 (Felipe) - Assinante 8
(14, 1, 115, 1),-- O Código da Sombra (Finalizado)
-- Perfil 16 (Patricia) - Assinante 10
(16, 6, 90, 0), -- Guardiões do Abismo (Parcial)

-- Perfil 18 (Vitor) - Assinante 11
(18, 9, 25, 1), -- Patrulha Estelar (Finalizado)
-- Perfil 21 (Gustavo) - Assinante 15
(21, 8, 100, 1);-- Rua da Esperança (Finalizado)

-- CRIAÇÃO DA VIEW

CREATE VIEW vw_historico_detalhado AS
SELECT
    a.nome AS nome_assinante,
    p.nome_perfil,
    c.titulo AS conteudo_assistido,
    sa.tempo_assistido,
    sa.finalizado,
    sa.data_hora_inicio
FROM sessoes_assistidas sa
JOIN perfis p ON sa.id_perfil = p.id_perfil
JOIN assinantes a ON p.id_assinante = a.id_assinante
JOIN conteudos c ON sa.id_conteudo = c.id_conteudo
ORDER BY sa.data_hora_inicio DESC;

-- Objetivo: mostrar o tempo total assistido por perfil.
SELECT
    p.nome_perfil,
    SUM(sa.tempo_assistido) AS total_minutos_assistidos
FROM sessoes_assistidas sa
JOIN perfis p ON sa.id_perfil = p.id_perfil
GROUP BY p.nome_perfil
ORDER BY total_minutos_assistidos DESC;

-- Objetivo: Identificar o Top 3 conteúdos mais populares (com base na contagem de sessões assistidas).
SELECT
    c.titulo,
    COUNT(sa.id_sessao) AS total_sessoes
FROM sessoes_assistidas sa
JOIN conteudos c ON sa.id_conteudo = c.id_conteudo
GROUP BY c.titulo
ORDER BY total_sessoes DESC
LIMIT 3;

-- Objetivo: Listar todos os Filmes que pertencem ao gênero 'Ação' e que foram lançados após 2022.
SELECT
    c.titulo,
    c.ano_lancamento,
    g.nome_genero
FROM conteudos c
JOIN conteudos_generos cg ON c.id_conteudo = cg.id_conteudo
JOIN generos g ON cg.id_genero = g.id_genero
WHERE g.nome_genero = 'Ação' 
  AND c.tipo = 'Filme' 
  AND c.ano_lancamento > 2022;

-- Objetivo: Encontrar o nome dos Assinantes que possuem mais de um perfil com restrição de idade (perfis "kids").
SELECT
    a.nome AS nome_assinante,
    COUNT(p.id_perfil) AS perfis_restritos
FROM assinantes a
JOIN perfis p ON a.id_assinante = p.id_assinante
WHERE p.restricao_idade < 18 -- Filtra perfis com restrição de idade
GROUP BY a.nome
HAVING COUNT(p.id_perfil) >= 1; -- Filtra assinantes que possuem mais de um perfil restrito

-- Objetivo: Exibir o histórico de visualização do Perfil 'Gabriel', mostrando se o conteúdo foi finalizado ou não, usando a VIEW.
SELECT 
    conteudo_assistido, 
    tempo_assistido, 
    CASE WHEN finalizado = 1 THEN 'Sim' ELSE 'Não' END AS concluido,
    data_hora_inicio
FROM vw_historico_detalhado
WHERE nome_perfil = 'Gabriel'
ORDER BY data_hora_inicio DESC;
