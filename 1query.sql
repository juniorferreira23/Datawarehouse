SELECT
  ano,
  nome_cliente,
  total_pedidos
FROM (
  SELECT
    YEAR(m.data_hora_entrada) AS ano,
    c.nome_cliente,
    COUNT(p.codigo_mesa) AS total_pedidos
  FROM
    tb_pedido p
    INNER JOIN tb_mesa m ON p.codigo_mesa = m.codigo_mesa
    INNER JOIN tb_cliente c ON m.id_cliente = c.id_cliente
  GROUP BY
    YEAR(m.data_hora_entrada),
    c.nome_cliente
  ORDER BY
    YEAR(m.data_hora_entrada),
    total_pedidos DESC
) t
WHERE
  total_pedidos = (
    SELECT
      MAX(total_pedidos)
    FROM (
      SELECT
        YEAR(m.data_hora_entrada) AS ano,
        c.nome_cliente,
        COUNT(p.codigo_mesa) AS total_pedidos
      FROM
        tb_pedido p
        INNER JOIN tb_mesa m ON p.codigo_mesa = m.codigo_mesa
        INNER JOIN tb_cliente c ON m.id_cliente = c.id_cliente
      GROUP BY
        YEAR(m.data_hora_entrada),
        c.nome_cliente
    ) t2
    WHERE
      t2.ano = t.ano
  );