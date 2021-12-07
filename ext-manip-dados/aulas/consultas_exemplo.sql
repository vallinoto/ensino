-- Objetivo: Contar o número total de usuários cadastrados
SELECT COUNT(*)
FROM users

-- Objetivo: Contar o número de nomes únicos de uma tabela
SELECT COUNT(DISTINCT name)
FROM users

--Fundamentos
--WHERE: Filtrando resultados
--WHERE retorna todas as linhas paras as quais as condições são verdadeiras

--Checks de igualdade e desigualdade
--WHERE name = 'Bernardo'
--WHERE name != 'João'

--Comparação de textos
--WHERE name LIKE 'Berna%'
--WHERE name NOT LIKE '%da Silva'

--Comparação de números e datas
-- WHERE price > 100
-- WHERE created_at > '2018-01-01'
-- WHERE user_id BETWEEN 10 AND 100
-- WHERE created_at BETWEEN '2018-01-01' AND '2018-03-01'

-- Checks de lógica
-- WHERE status IS TRUE
-- WHERE status IS FALSE
-- WHERE status IS NULL
-- WHERE status IS NOT NULL

-- Checks de inclusão
-- WHERE name IN ('Bernardo', 'João')
-- WHERE user_id NOT IN (112, 113)


SELECT user_id,
    COUNT(*) AS num_pedidos,
    SUM(price) AS total_gasto,
    AVG(price) AS media_preco,
    MIN(created_at) AS data_primeiro_pedido,
    MAX(created_at) AS data_ultimo_pedido
FROM requests
WHERE name LIKE 'Maria%'
GROUP BY user_id


-- HAVING é utilizando quando é necessário filtrar um resultado agregado, o que não é
-- possível no WHERE
SELECT user_id,
    COUNT(*) AS num_pedidos,
    SUM(price) AS total_gasto,
    AVG(price) AS media_preco,
    MIN(created_at) AS data_primeiro_pedido,
    MAX(created_at) AS data_ultimo_pedido
FROM requests
WHERE name LIKE 'Maria%'
GROUP BY user_id
HAVING COUNT(*) > 5


-- JOINS
SELECT *
FROM users
LEFT JOIN requests
ON requests.user_id = users.id


-------- Exercicios ---------
--● Quantos usuários com nome Lucas existem na base?
SELECT COUNT(*) FROM users WHERE name = 'Lucas';
--=> 41

--● Quantos usuários foram criados após o dia 15/04/2018?
SELECT COUNT(*) FROM users WHERE created_at > '2018-04-15';
--=> 692

--● Quantos usuários fizeram sign in entre 5 e 10 vezes?
SELECT COUNT(*) FROM users WHERE sign_in_count BETWEEN 5 AND 10;
--=> 55

--● Quantos usuários tem a conta confirmada?
SELECT COUNT(*) FROM users WHERE confirmed_at IS NOT NULL;
--=> 357

--● Quantas URLs de categorias contém ‘reformas-e-reparos’?
SELECT COUNT(*) FROM categories WHERE url LIKE 'reformas-e-reparos%';
--=> 58

--● Para cada nome, quantos usuários existem na base?
SELECT name, COUNT(*) AS num_users
FROM users
GROUP BY name
ORDER BY num_users DESC;

--● Quais nomes únicos estão presentes mais de 5 vezes na base?
SELECT name, COUNT(*) AS num_users
FROM users
GROUP BY name
HAVING num_users > 5
ORDER BY num_users DESC;

--● Para cada status do pedido (internal_status), quantos pedidos existem na base?
SELECT internal_status, COUNT(*) AS num_requests
FROM requests
GROUP BY internal_status
ORDER BY internal_status DESC;

--● Quantos pedidos geraram 0,1,2,3,... leads (num_leads)?
SELECT num_leads, COUNT(*) AS num_requests
FROM requests
GROUP BY num_leads
ORDER BY num_leads;

--● Qual é a média de receita (request_revenue) que cada pedido traz?
SELECT AVG(request_revenue) AS avg_request_revenue
FROM requests;

--● Quantos pedidos foram realizados em cada categoria?
SELECT name, COUNT(*) AS num_requests
FROM requests
INNER JOIN categories ON categories.id = requests.category_id
GROUP BY name
ORDER BY num_requests DESC;

----● Quantos clientes não realizaram nenhum pedido?
SELECT COUNT(*)
FROM users
LEFT JOIN requests ON requests.user_id = users.id
WHERE requests.id IS NULL;









