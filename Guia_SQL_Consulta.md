# 📙 Guia Rápido de SQL (Consulta/Manipulação) — Comentado

> Referência única com exemplos e notas de compatibilidade (MySQL, PostgreSQL, SQL Server), toda comentada.

## Índice resumido
- Conceitos básicos
- SELECT
- Filtros e ordenação
- Agregação
- GROUP BY / HAVING
- JOINs
- Subconsultas
- CRUD
- DDL
- Constraints
- Índices
- Views
- Transações
- DCL
- Funções úteis
- Dicas por SGBD

## SELECT
```sql
-- Todas as colunas
SELECT * FROM clientes;

-- Colunas específicas
SELECT id, nome, email FROM clientes;

-- Alias (AS) para melhorar leitura
SELECT nome AS cliente, email AS contato FROM clientes;

-- Limitar resultados por SGBD
SELECT * FROM clientes LIMIT 10;  -- MySQL/PostgreSQL
SELECT TOP 10 * FROM clientes;    -- SQL Server
```

## Filtros e ordenação
```sql
-- WHERE com múltiplas condições (AND/OR)
SELECT * FROM clientes WHERE cidade = 'Rio de Janeiro' AND ativo = TRUE;

-- IN/BETWEEN/LIKE
SELECT * FROM pedidos WHERE status IN ('aberto','pago');
SELECT * FROM pedidos WHERE total BETWEEN 100 AND 500;
SELECT * FROM clientes WHERE nome LIKE 'Fran%'; -- começa com "Fran"

-- Nulos
SELECT * FROM clientes WHERE telefone IS NULL;
SELECT * FROM clientes WHERE telefone IS NOT NULL;

-- Ordenação combinada
SELECT * FROM clientes ORDER BY nome ASC, criado_em DESC;
```

## Agregação e HAVING
```sql
-- Métricas comuns
SELECT COUNT(*) AS total_clientes FROM clientes;
SELECT AVG(total) AS ticket_medio FROM pedidos;
SELECT SUM(total) AS receita FROM pedidos WHERE status = 'pago';
SELECT MIN(total) AS menor, MAX(total) AS maior FROM pedidos;

-- Filtro por grupo (HAVING)
SELECT cliente_id, SUM(total) AS gasto
FROM pedidos
GROUP BY cliente_id
HAVING SUM(total) > 1000; -- mostra apenas clientes com gasto > 1000
```

## JOINs
```sql
-- INNER JOIN / LEFT JOIN / RIGHT JOIN / FULL OUTER JOIN
SELECT c.id, c.nome, p.id AS pedido_id, p.total
FROM clientes c
INNER JOIN pedidos p ON p.cliente_id = c.id;

SELECT c.id, c.nome, p.id AS pedido_id, p.total
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id;

SELECT c.id, c.nome, p.id AS pedido_id, p.total
FROM clientes c
RIGHT JOIN pedidos p ON p.cliente_id = c.id; -- se suportado

SELECT c.id, c.nome, p.id AS pedido_id, p.total
FROM clientes c
FULL OUTER JOIN pedidos p ON p.cliente_id = c.id; -- PostgreSQL/SQL Server

-- Várias condições de junção
SELECT *
FROM pedidos p
JOIN clientes c ON c.id = p.cliente_id
JOIN cidades ci ON ci.id = c.cidade_id;
```

## Subconsultas e EXISTS
```sql
-- IN com subconsulta
SELECT * FROM clientes WHERE id IN (
  SELECT cliente_id FROM pedidos WHERE total > 500
);

-- Correlacionada
SELECT c.id, c.nome,
 (SELECT COUNT(*) FROM pedidos p WHERE p.cliente_id = c.id) AS pedidos
FROM clientes c;

-- EXISTS: retorna clientes com pelo menos um pedido > 500
SELECT * FROM clientes c
WHERE EXISTS (
  SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id AND p.total > 500
);
```

## CRUD e UPSERT
```sql
-- INSERT/UPDATE/DELETE básicos
INSERT INTO clientes (nome, email, cidade)
VALUES ('Francis', 'francis@example.com', 'Rio de Janeiro');

UPDATE clientes
SET email = 'francis.n@example.com'
WHERE id = 1;

DELETE FROM clientes
WHERE id = 1; -- SEM WHERE apaga todos os registros

-- UPSERT por SGBD
-- PostgreSQL
INSERT INTO clientes (id, nome, email)
VALUES (1, 'Francis', 'f@example.com')
ON CONFLICT (id) DO UPDATE SET email = EXCLUDED.email;

-- MySQL
INSERT INTO clientes (id, nome, email)
VALUES (1, 'Francis', 'f@example.com')
ON DUPLICATE KEY UPDATE email = VALUES(email);
```

## DDL, Constraints e Índices
```sql
-- CREATE TABLE com tipos e defaults
CREATE TABLE clientes (
  id SERIAL PRIMARY KEY,        -- PostgreSQL
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE,
  cidade VARCHAR(100),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ALTER TABLE: adicionar coluna / modificar tipo
ALTER TABLE clientes ADD COLUMN ativo BOOLEAN DEFAULT TRUE;

-- DROP TABLE
DROP TABLE IF EXISTS clientes;

-- Tabela 'pedidos' com CHECK e FK
CREATE TABLE pedidos (
  id SERIAL PRIMARY KEY,
  cliente_id INT NOT NULL,
  total NUMERIC(10,2) CHECK (total >= 0),
  status VARCHAR(20) CHECK (status IN ('aberto','pago','cancelado')),
  CONSTRAINT fk_cliente
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Índices
CREATE INDEX idx_clientes_email ON clientes(email);
CREATE INDEX idx_pedidos_cliente_status ON pedidos(cliente_id, status);
```

## Views, Transações e DCL
```sql
-- View para relatório de clientes e pedidos
CREATE VIEW vw_clientes_pedidos AS
SELECT c.id, c.nome, COUNT(p.id) AS total_pedidos,
       COALESCE(SUM(p.total),0) AS gasto
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nome;

-- Transação simples de débito/crédito
BEGIN; -- ou START TRANSACTION (MySQL)
UPDATE contas SET saldo = saldo - 100 WHERE id = 1;
UPDATE contas SET saldo = saldo + 100 WHERE id = 2;
COMMIT; -- ROLLBACK para desfazer

-- DCL: criar usuário e conceder SELECT
-- PostgreSQL
CREATE USER analista WITH PASSWORD 'senha_forte';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO analista;

-- MySQL
CREATE USER 'analista'@'%' IDENTIFIED BY 'senha_forte';
GRANT SELECT ON banco.* TO 'analista'@'%';
FLUSH PRIVILEGES;
```

## Funções Úteis e Dicas por SGBD
```sql
-- Texto e datas
SELECT UPPER(nome), LOWER(email), CONCAT(nome, ' <', email, '>') FROM clientes;
SELECT NOW() AS agora, CURRENT_DATE AS hoje; -- PostgreSQL/MySQL
SELECT DATE_PART('year', NOW()) AS ano_atual; -- PostgreSQL
SELECT YEAR(NOW()) AS ano_atual;             -- MySQL/SQL Server

-- Nulos
SELECT COALESCE(telefone, 'sem telefone') FROM clientes;
```

- LIMIT (PostgreSQL/MySQL) vs TOP (SQL Server)
- Auto incremento: SERIAL/GENERATED, AUTO_INCREMENT, IDENTITY
- FULL OUTER JOIN nativo em PostgreSQL/SQL Server; no MySQL, simule com UNION
```
