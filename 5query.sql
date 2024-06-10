SELECT c.nome_empresa AS company_name, COUNT(DISTINCT b.codigo_funcionario) AS num_employees
FROM db_empresa.tb_beneficio b
JOIN db_empresa.tb_empresa c ON b.codigo_empresa = c.codigo_empresa
WHERE b.codigo_funcionario IN (
    SELECT DISTINCT codigo_funcionario
    FROM db_restaurante.tb_pedido p
    JOIN db_restaurante.tb_prato pr ON p.codigo_prato = pr.codigo_prato
    JOIN db_restaurante.tb_tipo_prato tp ON pr.codigo_tipo_prato = tp.codigo_tipo_prato
    WHERE tp.codigo_tipo_prato = 3
)
GROUP BY c.nome_empresa
ORDER BY COUNT(DISTINCT b.codigo_funcionario) DESC
LIMIT 1;