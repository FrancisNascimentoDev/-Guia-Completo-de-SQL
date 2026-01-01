# 📗 Guia SQL para Iniciantes — Comentado

> Aprenda o essencial com exemplos diretos e comentários explicando cada comando.

## Conceitos
- Tabela = planilha mais robusta.
- Colunas = tipos de informação.
- Linhas = registros.

## SELECT — ver dados
```sql
-- Mostra todos os dados da tabela.
SELECT * FROM clientes;

-- Mostra somente as colunas de interesse.
SELECT nome, email FROM clientes;
```

## WHERE — filtrar
```sql
-- Filtra por cidade.
SELECT * FROM clientes WHERE cidade = 'Rio de Janeiro';

-- Outros exemplos de filtro.
SELECT * FROM clientes WHERE idade > 18;
SELECT * FROM clientes WHERE nome = 'Francis';
SELECT * FROM clientes WHERE ativo = TRUE;
```

## ORDER BY — ordenar
```sql
-- Ordena pelo nome (crescente).
SELECT * FROM clientes ORDER BY nome;

-- Ordena ao contrário (decrescente).
SELECT * FROM clientes ORDER BY nome DESC;
```

## LIKE — busca parcial
```sql
-- Nomes que começam com "Fran".
SELECT * FROM clientes WHERE nome LIKE 'Fran%';
```

## COUNT — contar registros
```sql
-- Conta quantas linhas existem em 'clientes'.
SELECT COUNT(*) FROM clientes;
```

## LIMIT — limitar resultados
```sql
-- Retorna as 5 primeiras linhas.
SELECT * FROM clientes LIMIT 5;
```

## INSERT — inserir
```sql
-- Insere um novo cliente.
INSERT INTO clientes (nome, email)
VALUES ('Francis', 'francis@email.com');
```

## UPDATE — atualizar
```sql
-- Atualiza o email do cliente id=1.
UPDATE clientes SET email = 'novo@email.com' WHERE id = 1;
```

## DELETE — remover
```sql
-- Remove o cliente id=1.
DELETE FROM clientes WHERE id = 1;

-- ⚠️ Sem WHERE, apaga tudo!
```

## Dicas finais
- Pratique com SELECT antes de usar DELETE/UPDATE.
- Leia mensagens de erro: costumam indicar coluna/tabela faltando.
