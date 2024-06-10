import mysql.connector

def connectDb():
    try:
        db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="root",
        database='db_restaurante'
    )

        if db.is_connected():
            print('Banco de dados MySQL conectado com sucesso!')
        
        return db

    except Exception as e:
        print(f'Ocorreu um erro na conexao com o banco de dados MySQL: {e}')
        
db = connectDb()

cursor = db.cursor(dictionary=True)

def extract_data(query):
    cursor.execute(query)
    return cursor.fetchall()

def load_data(query, data):
    cursor.executemany(query, data)
    db.commit()
    
query = 'SELECT P.quantidade_pedido, PR.preco_unitario_prato, YEAR(M.data_hora_entrada) as ano, MONTH(M.data_hora_entrada) as mes, DAY(M.data_hora_entrada) as dia, C.id_cliente as id_cliente,C.cpf_cliente, C.nome_cliente, C.email_cliente, C.telefone_cliente, M.num_pessoa_mesa  FROM  tb_pedido P INNER JOIN tb_mesa M ON P.codigo_mesa = M.codigo_mesa INNER JOIN tb_cliente C ON C.id_cliente = M.id_cliente INNER JOIN tb_prato PR ON PR.codigo_prato = P.codigo_prato'

dados = extract_data(query)
index_ano = 1

for dado in dados:
    # Inserir dados na tabela dim_ano
    ano = dado['ano']
    cursor.execute("INSERT INTO dim_ano(ano) VALUES(%s)", (ano,))
    id_ano = cursor.lastrowid
    
    # Inserir dados na tabela dim_mes
    mes = dado['mes']
    cursor.execute("INSERT INTO dim_mes(mes) VALUES(%s)", (mes,))
    id_mes = cursor.lastrowid
    
    # Inserir dados na tabela dim_dia
    dia = dado['dia']
    cursor.execute("INSERT INTO dim_dia(dia) VALUES(%s)", (dia,))
    id_dia = cursor.lastrowid
    
    # Verificar se o cliente já existe na tabela dim_cliente
    query_check_cliente = "SELECT id_cliente FROM dim_cliente WHERE id_cliente = %s"
    cursor.execute(query_check_cliente, (dado['id_cliente'],))
    cliente_existente = cursor.fetchone()
    
    if (not cliente_existente):
        # Inserir dados na tabela dim_cliente
        query_dim_cliente = 'INSERT INTO dim_cliente (id_cliente, cpf_cliente, telefone_cliente, email_cliente, nome_cliente) VALUES(%s, %s, %s, %s, %s)'
        cursor.execute(query_dim_cliente, (dado['id_cliente'], dado['cpf_cliente'], dado['telefone_cliente'], dado['email_cliente'], dado['nome_cliente']))
    
    # Inserir dados na tabela fato_pedido
    query_fato_pedido = 'INSERT INTO fato_pedido (valor_total, valor_unitario, quatidade_pedido, dim_cliente_id_cliente,dim_ano_id_ano, dim_mes_id_mes, dim_dia_id_dia, num_pessoa_mesa) VALUES(%s, %s, %s, %s, %s, %s, %s, %s)'
    cursor.execute(query_fato_pedido, (dado['preco_unitario_prato'] * int(dado['quantidade_pedido']), dado['preco_unitario_prato'], dado['quantidade_pedido'], dado['id_cliente'], id_ano, id_mes, id_dia, dado['num_pessoa_mesa']))
    
    db.commit()
    
    print("Dados Inseridos com sucesso") 

cursor.close()
db.close()
