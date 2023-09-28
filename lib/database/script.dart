const createTable = '''

CREATE TABLE produto_local(
  ID INTEGER PRIMARY KEY
  ,DESCRICAO VARCHAR(200)
  ,CUSTO NUMERIC(16,2)
  ,VALOR NUMERIC(16,2)
  ,VALOR_MINIMO NUMERIC(16,2)
  ,QUANTIDADE_ATUAL INT
)
''';

const insertProd = '''
INSERT INTO produto_local(ID,DESCRICAO,CUSTO,VALOR,VALOR_MINIMO,QUANTIDADE_ATUAL)
VALUES(1,'teste',20.50,10.50,15.50,10)
''';

const createTable2 = '''
CREATE TABLE cliente_local(
  ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
  ,ID_CLIENTE INT 
  ,TIPO VARCHAR(30)
  ,DOCUMENTO VARCHAR(19)
  ,NOME VARCHAR(300)
  ,LOGRADOURO VARCHAR(300)
  ,NUMERO VARCHAR(50)
  ,BAIRRO VARCHAR(100)
  ,MUNICIPIO VARCHAR(100)
  ,UF VARCHAR(2)
  ,TELEFONE VARCHAR(20)
  ,EMAIL VARCHAR(150)
  ,COMPRADOR VARCHAR(300)
)
''';

const insertCli = '''
INSERT INTO cliente_local(ID,ID_CLIENTE,TIPO,DOCUMENTO,NOME,LOGRADOURO,NUMERO,BAIRRO,MUNICIPIO,UF,TELEFONE,EMAIL,COMPRADOR) 
VALUES(1,1,'PESSOA_JURIDICA','11.111.111/0001-11','Empresa Ltda','Avenida Avenue','31, APTO 105','Centro','Diadema','SP','(11)99999-9999','email@email.com','José Josue Jesus')
''';

const createTable3 = '''
CREATE TABLE venda_local(
  ID INTEGER PRIMARY KEY AUTOINCREMENT 
  ,ID_CLIENTE_LOCAL INT -
  ,COMPRADOR VARCHAR(300)-
  ,TELEFONE VARCHAR(20)
  ,EMAIL VARCHAR(150)
  ,ID_CONDICAO_PAGAMENTO INT
  ,ITENS INT 
  ,VALOR_CUSTO NUMERIC(19,4)
  ,VALOR_ORIGINAL NUMERIC(19,4)
  ,VALOR_FINAL NUMERIC(19,4)-
  ,DATA_EMISSAO DATETIME
  ,OBS_CLIENTE VARCHAR(1000)
  ,OBS_LOGISTICA VARCHAR(1000)
  ,OBS_FATURAMENTO VARCHAR(1000)
  ,STATUS VARCHAR(50)-
  ,FOREIGN KEY(ID_CLIENTE_LOCAL) REFERENCES cliente_local(ID)
) 
''';

const insertVenLocal = '''
INSERT INTO venda_local(ID,ID_CLIENTE_LOCAL,COMPRADOR,TELEFONE,EMAIL,ID_CONDICAO_PAGAMENTO,ITENS,VALOR_CUSTO,VALOR_ORIGINAL,VALOR_FINAL,DATA_EMISSAO,OBS_CLIENTE,OBS_LOGISTICA,OBS_FATURAMENTO,STATUS)
VALUES(1,19887,'Marcos Silva','(11)98429-2912','email.email@email.com',1,15,150.50,310.50,300.50,'10-06-2022','Entregar depois das 11 da manhã','Entragar ao lado do local de entrega','VALOR PAGO POR PIX','ENVIADO')
''';

const createTable4 = '''
CREATE TABLE item_local(
  ID INTEGER PRIMARY KEY AUTOINCREMENT 
  ,ID_VENDA_LOCAL INT 
  ,DATA_EMISSAO DATETIME
  ,ID_PRODUTO INT
  ,DESCRICAO VARCHAR(300)
  ,CUSTO_UNITARIO NUMERIC(19,4)
  ,VALOR_ORIGINAL NUMERIC(19,4)
  ,VALOR_PRATICADO NUMERIC(19,4)
  ,QUANTIDADE NUMERIC(19,4)
  ,DESCONTO NUMERIC(19,4)
  ,TOTAL NUMERIC(19,4)
  ,FOREIGN KEY(ID_VENDA_LOCAL) REFERENCES venda_local(ID)
  ,FOREIGN KEY(ID_PRODUTO) REFERENCES produto_local(ID)
)
''';

const insertItemLocal = '''
INSERT INTO item_local(ID,ID_VENDA_LOCAL,DATA_EMISSAO,ID_PRODUTO,DESCRICAO,CUSTO_UNITARIO,VALOR_ORIGINAL,VALOR_PRATICADO,QUANTIDADE,DESCONTO,TOTAL)
VALUES(1,1,'10-06-2022',10,'Agua sanitaria Super Candida, que nem chega perto da Sanitus',10,18.59,16.00,2,5.18,32)

''';