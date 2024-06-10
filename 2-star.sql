SELECT 
    nome_cliente, 
    SUM(valor_total) as total_gasto 
    FROM fato_pedido P 
        INNER JOIN dim_cliente C 
            ON C.id_cliente = P.dim_cliente_id_cliente 
    GROUP BY nome_cliente 
    ORDER BY total_gasto DESC 
LIMIT 1;