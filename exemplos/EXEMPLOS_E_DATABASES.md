# 🗂️ Exemplos e Databases — Guia de Uso

Este arquivo reúne **datasets prontos** (CSV e scripts SQL para PostgreSQL/MySQL/SQL Server) e **consultas de exemplo** para praticar.

## 📦 Conteúdo
- `datasets/cidades.csv` — cidades (id, nome, uf)
- `datasets/clientes.csv` — clientes (id, nome, email, cidade_id, ativo, criado_em)
- `datasets/pedidos.csv` — pedidos (id, cliente_id, total, status, criado_em)
- `datasets_postgres.sql` — criação e carga para PostgreSQL
- `datasets_mysql.sql` — criação e carga para MySQL
- `datasets_sqlserver.sql` — criação e carga para SQL Server

## 🚀 Como carregar rapidamente
### PostgreSQL
```sql
-- Execute em psql:
\i datasets_postgres.sql
```

### MySQL
```sql
-- Execute no cliente mysql:
SOURCE datasets_mysql.sql;
```

### SQL Server
```sql
-- Execute no SQL Server Management Studio:
:r datasets_sqlserver.sql
```

> Dica: se preferir importar via CSV, crie as tabelas e use ferramentas como `COPY` (PostgreSQL), `LOAD DATA INFILE` (MySQL) ou `BULK INSERT` (SQL Server).

## 🧪 Consultas de exemplo
### 1) Seleção básica
```sql
SELECT * FROM clientes LIMIT 5;
SELECT nome, email FROM clientes ORDER BY nome;
```

### 2) Filtros e ordenação
```sql
SELECT * FROM pedidos
WHERE status IN ('aberto','pago')
ORDER BY criado_em DESC;
```

### 3) Agregação e agrupamento
```sql
SELECT c.cidade_id, COUNT(*) AS total_clientes
FROM clientes c
GROUP BY c.cidade_id
ORDER BY total_clientes DESC;

SELECT p.cliente_id, SUM(p.total) AS gasto_total
FROM pedidos p
GROUP BY p.cliente_id
HAVING SUM(p.total) > 1000
ORDER BY gasto_total DESC;
```

### 4) JOINs (3 tabelas)
```sql
SELECT c.id, c.nome, ci.nome AS cidade, COUNT(p.id) AS qtd_pedidos, COALESCE(SUM(p.total),0) AS gasto
FROM clientes c
LEFT JOIN cidades ci ON ci.id = c.cidade_id
LEFT JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nome, ci.nome
ORDER BY gasto DESC;
```

### 5) Subconsultas
```sql
SELECT * FROM clientes
WHERE id IN (SELECT cliente_id FROM pedidos WHERE total > 500);

SELECT c.id, c.nome
FROM clientes c
WHERE EXISTS (SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id AND p.status = 'pago');
```

### 6) Índices e views (exemplos)
```sql
-- Índices
CREATE INDEX idx_clientes_cidade ON clientes(cidade_id);
CREATE INDEX idx_pedidos_cliente_status ON pedidos(cliente_id, status);

-- View consolidada
CREATE VIEW vw_clientes_resumo AS
SELECT c.id, c.nome, ci.uf, COUNT(p.id) AS pedidos, COALESCE(SUM(p.total),0) AS gasto
FROM clientes c
LEFT JOIN cidades ci ON ci.id = c.cidade_id
LEFT JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nome, ci.uf;

SELECT * FROM vw_clientes_resumo ORDER BY gasto DESC;
```

### 7) Transação simples
```sql
BEGIN; -- ou START TRANSACTION
UPDATE pedidos SET status = 'cancelado' WHERE id = 1;
UPDATE pedidos SET status = 'pago' WHERE id = 2;
COMMIT; -- ROLLBACK para desfazer
```

## 🔎 Observações de compatibilidade
- **LIMIT vs TOP**: use `LIMIT` (PostgreSQL/MySQL) e `TOP` (SQL Server).
- **Auto incremento**: `SERIAL/GENERATED` (PostgreSQL), `AUTO_INCREMENT` (MySQL), `IDENTITY` (SQL Server).
- **Funções de data** variam por SGBD (`NOW()`, `GETDATE()`, etc.).
- **CHECK** é parcialmente suportado no MySQL dependendo da versão.

---
### ✅ Pronto para uso
Carregue um dos scripts de banco, abra seu cliente SQL e execute as consultas de exemplo acima.

Se quiser, posso gerar **scripts específicos** para um SGBD que você usa no dia a dia, ou criar **exercícios com gabarito** usando estes datasets.
