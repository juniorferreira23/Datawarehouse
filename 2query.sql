SELECT 
  c.nome_cliente, 
  SUM(p.quantidade_pedido * pr.preco_unitario_prato) AS total_gasto
FROM 
  tb_pedido p
  INNER JOIN tb_mesa m ON p.codigo_mesa = m.codigo_mesa
  INNER JOIN tb_cliente c ON m.id_cliente = c.id_cliente
  INNER JOIN tb_prato pr ON p.codigo_prato = pr.codigo_prato
GROUP BY 
  c.nome_cliente
ORDER BY 
  total_gasto DESC
LIMIT 1;