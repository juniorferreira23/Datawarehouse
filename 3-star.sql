SELECT 
    ano, 
    nome_cliente, 
     
    MAX(total_pessoas) AS total_pessoas
FROM (
    SELECT 
        A.ano, 
        P.num_pessoa_mesa, 
        SUM(P.num_pessoa_mesa) AS total_pessoas,
        DP.nome_cliente,
        ROW_NUMBER() OVER(PARTITION BY A.ano ORDER BY SUM(P.num_pessoa_mesa) DESC) AS ranks
    FROM 
        fato_pedido P 
        INNER JOIN dim_ano A ON P.dim_ano_id_ano = A.id_ano 
        INNER JOIN dim_cliente DP ON P.dim_cliente_id_cliente = DP.id_cliente
    GROUP BY 
        A.ano, 
        P.num_pessoa_mesa,
        DP.nome_cliente
) AS ranked
WHERE
    ranks = 1
GROUP BY
    ano, 
    nome_cliente
ORDER BY 
    total_pessoas DESC;