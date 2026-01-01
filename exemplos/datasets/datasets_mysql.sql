-- MySQL dataset script
SET FOREIGN_KEY_CHECKS=0; DROP TABLE IF EXISTS pedidos; DROP TABLE IF EXISTS clientes; DROP TABLE IF EXISTS cidades; SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE cidades (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  uf CHAR(2) NOT NULL
) ENGINE=InnoDB;
CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(255) UNIQUE,
  cidade_id INT,
  ativo TINYINT(1) DEFAULT 1,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (cidade_id) REFERENCES cidades(id)
) ENGINE=InnoDB;
CREATE TABLE pedidos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT,
  total DECIMAL(10,2) CHECK (total >= 0),
  status VARCHAR(20),
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
) ENGINE=InnoDB;
INSERT INTO cidades (id, nome, uf) VALUES (1, 'Rio de Janeiro', 'RJ');
INSERT INTO cidades (id, nome, uf) VALUES (2, 'São Paulo', 'SP');
INSERT INTO cidades (id, nome, uf) VALUES (3, 'Belo Horizonte', 'MG');
INSERT INTO cidades (id, nome, uf) VALUES (4, 'Curitiba', 'PR');
INSERT INTO cidades (id, nome, uf) VALUES (5, 'Recife', 'PE');
INSERT INTO cidades (id, nome, uf) VALUES (6, 'Salvador', 'BA');
INSERT INTO cidades (id, nome, uf) VALUES (7, 'Porto Alegre', 'RS');
INSERT INTO cidades (id, nome, uf) VALUES (8, 'Brasília', 'DF');
INSERT INTO cidades (id, nome, uf) VALUES (9, 'Manaus', 'AM');
INSERT INTO cidades (id, nome, uf) VALUES (10, 'Fortaleza', 'CE');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (1, 'Francis Faria', 'francis.faria@example.com', 2, 1, '2025-05-21 07:00:00');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (2, 'Ana Silva', 'ana.silva@example.com', 4, 1, '2025-02-22 21:00:00');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (3, 'João Souza', 'joão.souza@example.com', 9, 1, '2025-10-30 13:00:00');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (4, 'Maria Oliveira', 'maria.oliveira@example.com', 1, 1, '2025-02-17 06:00:00');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (5, 'Carlos Santos', 'carlos.santos@example.com', 4, 1, '2025-10-15 06:00:00');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (6, 'Beatriz Almeida', 'beatriz.almeida@example.com', 9, 0, '2025-04-23 14:00:00');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (7, 'Rafael Costa', 'rafael.costa@example.com', 10, 1, '2025-01-04 05:00:00');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (8, 'Fernanda Lima', 'fernanda.lima@example.com', 7, 1, '2025-05-23 04:00:00');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (9, 'Paulo Henrique', 'paulo.henrique@example.com', 4, 1, '2025-02-22 02:00:00');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (10, 'Luiza Rocha', 'luiza.rocha@example.com', 7, 1, '2025-07-03 11:00:00');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (11, 'Gustavo Nogueira', 'gustavo.nogueira@example.com', 10, 1, '2025-01-23 23:00:00');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (12, 'Camila Ferreira', 'camila.ferreira@example.com', 8, 1, '2025-07-13 02:00:00');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (13, 'Bruno Ribeiro', 'bruno.ribeiro@example.com', 9, 1, '2025-11-18 19:00:00');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (14, 'Patrícia Gomes', 'patrícia.gomes@example.com', 6, 1, '2025-12-27 02:00:00');
INSERT INTO clientes (id, nome, email, cidade_id, ativo, criado_em) VALUES (15, 'Marcos Vinícius', 'marcos.vinícius@example.com', 1, 1, '2025-05-29 02:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (1, 1, 1306.4, 'pago', '2025-08-21 20:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (2, 1, 1259.46, 'aberto', '2025-07-01 06:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (3, 2, 1067.64, 'pago', '2025-02-06 19:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (4, 2, 970.72, 'pago', '2025-05-06 05:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (5, 2, 720.28, 'pago', '2025-11-24 22:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (6, 3, 368.44, 'pago', '2025-01-29 07:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (7, 3, 1241.61, 'pago', '2025-07-25 08:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (8, 3, 145.97, 'cancelado', '2025-10-18 22:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (9, 3, 506.28, 'pago', '2025-07-22 20:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (10, 3, 715.34, 'pago', '2025-05-07 23:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (11, 4, 831.52, 'pago', '2025-08-08 18:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (12, 4, 629.13, 'pago', '2025-03-12 16:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (13, 4, 765.6, 'pago', '2025-02-26 04:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (14, 4, 959.8, 'pago', '2025-08-05 19:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (15, 4, 142.12, 'pago', '2025-08-28 16:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (16, 5, 1458.06, 'pago', '2025-01-06 21:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (17, 5, 1095.05, 'pago', '2025-10-02 08:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (18, 5, 1164.47, 'pago', '2025-05-31 13:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (19, 6, 707.9, 'cancelado', '2025-05-15 16:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (20, 6, 1154.85, 'pago', '2025-02-24 20:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (21, 7, 1270.42, 'pago', '2025-04-12 04:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (22, 7, 592.18, 'aberto', '2025-09-29 00:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (23, 7, 918.47, 'pago', '2025-02-27 11:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (24, 8, 397.21, 'pago', '2025-10-18 02:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (25, 8, 174.2, 'pago', '2025-02-05 17:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (26, 8, 1160.46, 'aberto', '2025-09-01 17:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (27, 9, 434.33, 'pago', '2025-08-05 06:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (28, 9, 1396.92, 'pago', '2025-12-20 06:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (29, 10, 628.54, 'pago', '2025-07-11 14:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (30, 10, 1354.44, 'pago', '2025-05-07 07:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (31, 10, 142.84, 'aberto', '2025-10-11 07:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (32, 11, 369.32, 'aberto', '2025-11-20 01:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (33, 11, 381.97, 'cancelado', '2025-06-19 02:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (34, 11, 795.53, 'pago', '2025-09-06 06:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (35, 11, 831.89, 'pago', '2025-10-20 18:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (36, 11, 735.37, 'pago', '2025-07-28 06:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (37, 12, 190.55, 'pago', '2025-08-05 13:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (38, 13, 1302.56, 'aberto', '2025-12-01 20:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (39, 13, 192.71, 'pago', '2025-06-23 03:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (40, 13, 410.55, 'aberto', '2025-08-18 04:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (41, 13, 661.73, 'pago', '2025-05-08 02:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (42, 14, 1221.63, 'pago', '2025-02-20 01:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (43, 14, 995.61, 'pago', '2025-01-08 02:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (44, 14, 1393.23, 'pago', '2025-03-27 13:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (45, 14, 754.18, 'pago', '2025-07-25 01:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (46, 15, 599.51, 'cancelado', '2025-05-16 14:00:00');
INSERT INTO pedidos (id, cliente_id, total, status, criado_em) VALUES (47, 15, 463.61, 'pago', '2025-10-12 21:00:00');
