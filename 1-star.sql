SELECT 
    total_pedidos, 
    nome_cliente, 
    ano 
FROM (
    SELECT 
        COUNT(*) AS total_pedidos, 
        C.nome_cliente, 
        A.ano, 
        ROW_NUMBER() OVER(PARTITION BY A.ano ORDER BY COUNT(*) DESC) AS ranks 
    FROM 
        fato_pedido P 
        INNER JOIN dim_cliente C ON C.id_cliente = P.dim_cliente_id_cliente 
        INNER JOIN dim_ano A ON P.dim_ano_id_ano = A.id_ano 
    GROUP BY 
        C.nome_cliente, 
        A.ano 
) AS ranked 
WHERE 
    ranks = 1;