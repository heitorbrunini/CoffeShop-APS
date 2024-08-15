CREATE DATABASE coffeshop;
USE coffeshop;

CREATE TABLE funcionario (
	pis_pasep VARCHAR(15), codigo INTEGER PRIMARY KEY NOT NULL, 
	nome VARCHAR(30), cpf VARCHAR(11)
);
CREATE TABLE entregador (
	codigo INTEGER PRIMARY KEY NOT NULL, cnh VARCHAR(15) UNIQUE,
	nome VARCHAR(30), cpf VARCHAR(11));
CREATE TABLE cliente(
	codigo INTEGER PRIMARY KEY NOT NULL, nome VARCHAR(30),
	cpf VARCHAR(11) NOT NULL
);
CREATE TABLE mesa (
	numero INTEGER PRIMARY KEY NOT NULL, capacidade INTEGER,
	status BOOLEAN
);
CREATE TABLE endereco(
	enderco_pk INTEGER PRIMARY KEY NOT NULL, cep VARCHAR(8),
	numerocasa INTEGER
);
CREATE TABLE veiculo(veiculo_pk INTEGER PRIMARY KEY NOT NULL, cor VARCHAR(10), placa VARCHAR(10) );

CREATE TABLE pagamento(
	nota VARCHAR(50), valor DOUBLE, status BOOLEAN, cliente_codigo INTEGER,
	CONSTRAINT fk_cliente FOREIGN KEY (cliente_codigo) REFERENCES cliente(codigo)
);
CREATE TABLE ocupacao(
	cliente_codigo INTEGER, mesa_numero INTEGER, data_ocupa DATE NOT NULL,
	CONSTRAINT pk_ocupacao PRIMARY KEY (cliente_codigo, mesa_numero),
	CONSTRAINT fk_cliente_ocupacao FOREIGN KEY (cliente_codigo) REFERENCES cliente(codigo),
	CONSTRAINT fk_mesa FOREIGN KEY (mesa_numero) REFERENCES mesa(numero)
);
CREATE TABLE celular(
	celular_pk INTEGER, celular_numero VARCHAR(15), cliente_codigo INTEGER,
	CONSTRAINT pk_cliente_celular PRIMARY KEY (cliente_codigo, celular_pk),
	CONSTRAINT fk_cliente_celular FOREIGN KEY (cliente_codigo) REFERENCES cliente(codigo)
);

CREATE TABLE pedido(
	numero INTEGER PRIMARY KEY NOT NULL, descricao VARCHAR(50), 
	status BOOLEAN, cliente_codigo INTEGER, funcionario_codigo INTEGER,
	CONSTRAINT fk_cliente_pedido FOREIGN KEY (cliente_codigo) REFERENCES cliente(codigo),
	CONSTRAINT fk_funcionario_pedido FOREIGN KEY (funcionario_codigo) REFERENCES funcionario(codigo)
);

CREATE TABLE avaliacao(
	numero INTEGER PRIMARY KEY NOT NULL, nota INTEGER DEFAULT 5,
	cliente_codigo INTEGER, funcionario_codigo INTEGER, entregador_codigo INTEGER,
	CONSTRAINT fk_cliente_avaliacao FOREIGN KEY (cliente_codigo) REFERENCES cliente(codigo),
	CONSTRAINT fk_funcionario_avaliacao FOREIGN KEY (funcionario_codigo) REFERENCES funcionario(codigo),
	CONSTRAINT fk_entregador_avaliacao FOREIGN KEY (entregador_codigo) REFERENCES  entregador(codigo)
);

CREATE TABLE moto_entrega(
	numero INTEGER PRIMARY KEY NOT NULL, pedido_numero INTEGER, veiculo_fk INTEGER,
	entregador_codigo INTEGER, enderco_fk INTEGER,
	CONSTRAINT fk_entregador_moto FOREIGN KEY (entregador_codigo) REFERENCES entregador(codigo),
	CONSTRAINT fk_pedido_moto FOREIGN KEY (pedido_numero) REFERENCES pedido(numero),
	CONSTRAINT fk_veiculo_moto FOREIGN KEY (veiculo_fk) REFERENCES veiculo(veiculo_pk),
	CONSTRAINT fk_endereco_moto FOREIGN KEY (enderco_fk) REFERENCES endereco(enderco_pk)
)