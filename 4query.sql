SELECT 
    ano,
    cliente,
    num_pessoas
FROM (
    SELECT
        YEAR(ms.data_hora_entrada) AS ano,
        cl.nome_cliente AS cliente,
        SUM(pd.quantidade_pedido) AS num_pessoas,
        ROW_NUMBER() OVER (PARTITION BY YEAR(ms.data_hora_entrada) ORDER BY SUM(pd.quantidade_pedido) DESC) AS rn
    FROM
        tb_pedido pd
        JOIN tb_mesa ms ON pd.codigo_mesa = ms.codigo_mesa
        JOIN tb_cliente cl ON ms.id_cliente = cl.id_cliente
    GROUP BY
        ano,
        cliente
) AS ranked
WHERE
    rn = 1;
