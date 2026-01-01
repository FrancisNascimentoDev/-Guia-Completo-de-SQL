# 📘 Guia Completo de SQL — Do Zero ao Intermediário

Aprenda SQL desde os primeiros comandos até consultas intermediárias, JOINs, funções, DDL, DML e muito mais. Este README integra dois materiais em um único guia organizado e profissional.

---
## 📑 Índice
1. [Introdução ao SQL](#introdução-ao-sql)
2. [Conceitos Fundamentais](#conceitos-fundamentais)
3. [Consultas Básicas (SELECT)](#consultas-básicas-select)
4. [Filtros, Ordenação e LIKE](#filtros-ordenação-e-like)
5. [Funções de Agregação](#funções-de-agregação)
6. [Agrupamento e HAVING](#agrupamento-e-having)
7. [JOINs — União de Tabelas](#joins)
8. [Subconsultas](#subconsultas)
9. [CRUD — INSERT, UPDATE e DELETE](#crud)
10. [DDL — CREATE, ALTER e DROP](#ddl)
11. [Constraints](#constraints)
12. [Índices](#índices)
13. [Views](#views)
14. [Transações](#transações)
15. [Controle de Acesso (DCL)](#controle-de-acesso)
16. [Funções Úteis](#funções-úteis)
17. [Diferenças entre SGBDs](#diferenças-entre-sgbds)

---
# Introdução ao SQL
SQL (Structured Query Language) é usado para consultar, manipular e gerenciar dados em bancos de dados relacionais.

Você usa SQL para:
- Buscar informações
- Filtrar e ordenar
- Agrupar e calcular métricas
- Criar tabelas e estruturas
- Controlar permissões

---
# Conceitos Fundamentais
- **Tabela** → conjunto de colunas e linhas
- **Linha/Registro** → item armazenado
- **Coluna/Campo** → tipo de dado
- **PK — Primary Key** → identificador único
- **FK — Foreign Key** → referência a outra tabela
- **Schema** → agrupamento lógico de objetos

---
# Consultas Básicas (SELECT)
## Selecionar tudo
```sql
SELECT * FROM clientes;
```
## Selecionar colunas específicas
```sql
SELECT nome, email FROM clientes;
```
## Renomear colunas
```sql
SELECT nome AS cliente, email AS contato FROM clientes;
```
## Limitar resultados
**MySQL / PostgreSQL**
```sql
SELECT * FROM clientes LIMIT 10;
```
**SQL Server**
```sql
SELECT TOP 10 * FROM clientes;
```

---
# Filtros, Ordenação e LIKE
## WHERE — filtros básicos
```sql
SELECT * FROM clientes
WHERE cidade = 'Rio de Janeiro';
```
## Operadores úteis
```sql
WHERE idade > 18;
WHERE status IN ('aberto','pago');
WHERE total BETWEEN 100 AND 500;
WHERE telefone IS NULL;
```
## LIKE — busca textual
```sql
SELECT * FROM clientes
WHERE nome LIKE 'Fran%';
```
## ORDER BY
```sql
SELECT * FROM clientes
ORDER BY nome ASC, criado_em DESC;
```

---
# Funções de Agregação
```sql
SELECT COUNT(*) FROM clientes;
SELECT AVG(total) FROM pedidos;
SELECT SUM(total) FROM pedidos WHERE status = 'pago';
SELECT MIN(total), MAX(total) FROM pedidos;
```

---
# Agrupamento e HAVING
## GROUP BY
```sql
SELECT cidade, COUNT(*) AS qtd
FROM clientes
GROUP BY cidade
ORDER BY qtd DESC;
```
## HAVING — filtro após agrupamento
```sql
SELECT cliente_id, SUM(total) AS gasto
FROM pedidos
GROUP BY cliente_id
HAVING SUM(total) > 1000;
```

---
# JOINs — União de Tabelas
## INNER JOIN — somente correspondências
```sql
SELECT c.id, c.nome, p.id AS pedido_id, p.total
FROM clientes c
INNER JOIN pedidos p ON p.cliente_id = c.id;
```
## LEFT JOIN — todos da tabela esquerda
```sql
SELECT c.id, c.nome, p.id AS pedido_id, p.total
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id;
```
## RIGHT JOIN — quando disponível
```sql
SELECT c.id, c.nome, p.id AS pedido_id, p.total
FROM clientes c
RIGHT JOIN pedidos p ON p.cliente_id = c.id;
```
## FULL OUTER JOIN *(PostgreSQL / SQL Server)*
```sql
SELECT c.id, c.nome, p.id AS pedido_id, p.total
FROM clientes c
FULL OUTER JOIN pedidos p ON p.cliente_id = c.id;
```
## JOIN com múltiplas tabelas
```sql
SELECT *
FROM pedidos p
JOIN clientes c ON c.id = p.cliente_id
JOIN cidades ci ON ci.id = c.cidade_id;
```

---
# Subconsultas
## IN
```sql
SELECT * FROM clientes
WHERE id IN (
  SELECT cliente_id FROM pedidos WHERE total > 500
);
```
## Subconsulta correlacionada
```sql
SELECT c.id, c.nome,
 (SELECT COUNT(*) FROM pedidos p WHERE p.cliente_id = c.id) AS pedidos
FROM clientes c;
```
## EXISTS
```sql
SELECT * FROM clientes c
WHERE EXISTS (
  SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id AND p.total > 500
);
```

---
# CRUD — INSERT, UPDATE e DELETE
## INSERT
```sql
INSERT INTO clientes (nome, email, cidade)
VALUES ('Francis', 'francis@example.com', 'Rio de Janeiro');
```
## UPDATE
```sql
UPDATE clientes
SET email = 'francis.n@example.com'
WHERE id = 1;
```
## DELETE
```sql
DELETE FROM clientes
WHERE id = 1;
```
## UPSERT
### PostgreSQL
```sql
INSERT INTO clientes (id, nome, email)
VALUES (1, 'Francis', 'f@example.com')
ON CONFLICT (id) DO UPDATE SET email = EXCLUDED.email;
```
### MySQL
```sql
INSERT INTO clientes (id, nome, email)
VALUES (1, 'Francis', 'f@example.com')
ON DUPLICATE KEY UPDATE email = VALUES(email);
```

---
# DDL — CREATE, ALTER e DROP
## Criar tabela
```sql
CREATE TABLE clientes (
  id SERIAL PRIMARY KEY, -- PostgreSQL (auto)
  -- MySQL: id INT AUTO_INCREMENT PRIMARY KEY
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE,
  cidade VARCHAR(100),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```
## Alterar tabela
```sql
ALTER TABLE clientes ADD COLUMN ativo BOOLEAN DEFAULT TRUE;
-- PostgreSQL: ALTER COLUMN nome TYPE VARCHAR(150);
-- MySQL:      MODIFY nome VARCHAR(150);
```
## Deletar tabela
```sql
DROP TABLE IF EXISTS clientes;
```

---
# Constraints (PK, FK, UNIQUE, CHECK)
```sql
CREATE TABLE pedidos (
  id SERIAL PRIMARY KEY,
  cliente_id INT NOT NULL,
  total NUMERIC(10,2) CHECK (total >= 0),
  status VARCHAR(20) CHECK (status IN ('aberto','pago','cancelado')),
  CONSTRAINT fk_cliente
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);
```

---
# Índices
```sql
CREATE INDEX idx_clientes_email ON clientes(email);
CREATE INDEX idx_pedidos_cliente_status ON pedidos(cliente_id, status);
-- Remover índice
-- PostgreSQL: DROP INDEX idx_clientes_email;
-- MySQL:      DROP INDEX idx_clientes_email ON clientes;
```

---
# Views (Visões)
```sql
CREATE VIEW vw_clientes_pedidos AS
SELECT c.id, c.nome, COUNT(p.id) AS total_pedidos,
       COALESCE(SUM(p.total),0) AS gasto
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nome;
```
```sql
-- Consultar a view
SELECT * FROM vw_clientes_pedidos ORDER BY gasto DESC;
-- Dropar a view
DROP VIEW IF EXISTS vw_clientes_pedidos;
```

---
# Transações (BEGIN/COMMIT/ROLLBACK)
```sql
BEGIN; -- ou START TRANSACTION (MySQL)
UPDATE contas SET saldo = saldo - 100 WHERE id = 1;
UPDATE contas SET saldo = saldo + 100 WHERE id = 2;
-- Se algo der errado: ROLLBACK
COMMIT; -- confirma tudo
```

---
# Controle de Acesso (DCL)
## PostgreSQL
```sql
CREATE USER analista WITH PASSWORD 'senha_forte';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO analista;
```
## MySQL
```sql
CREATE USER 'analista'@'%' IDENTIFIED BY 'senha_forte';
GRANT SELECT ON banco.* TO 'analista'@'%';
FLUSH PRIVILEGES;
```

---
# Funções Úteis
```sql
-- Texto
SELECT UPPER(nome), LOWER(email), CONCAT(nome, ' <', email, '>') FROM clientes;

-- Datas
SELECT NOW() AS agora, CURRENT_DATE AS hoje; -- PostgreSQL/MySQL
SELECT DATE_PART('year', NOW()) AS ano_atual; -- PostgreSQL
SELECT YEAR(NOW()) AS ano_atual; -- MySQL/SQL Server

-- Nulos
SELECT COALESCE(telefone, 'sem telefone') FROM clientes;
```

---
# Diferenças entre SGBDs
- **LIMIT** (PostgreSQL/MySQL) vs **TOP** (SQL Server)
- **Auto incremento**:
  - PostgreSQL → `SERIAL` / `GENERATED`
  - MySQL → `AUTO_INCREMENT`
  - SQL Server → `IDENTITY`
- **FULL OUTER JOIN**: nativo em PostgreSQL/SQL Server; no MySQL, simular com `UNION` de dois LEFT/RIGHT JOINs
- Funções de data e string variam entre SGBDs — consulte a documentação específica

