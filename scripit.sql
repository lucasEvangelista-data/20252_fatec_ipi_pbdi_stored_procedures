DO $$
DECLARE
valor_total INT;
BEGIN
CALL sp_calcular_valor_de_um_pedido(1, valor_total);
RAISE NOTICE 'Total do pedido %: R$%', 1, valor_total;
END;
$$


CREATE OR REPLACE PROCEDURE sp_calcular_valor_de_um_pedido (
    IN p_cod_pedido INT,
     OUT valor_total INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT SUM(valor) FROM
    tb_pedido p
    INNER JOIN tb_item_pedido ip ON
    p.cod_pedido = ip.cod_pedido
    INNER JOIN tb_item i 
    ON i.cod_item = ip.cod_item
    WHERE p.cod_pedido = $1
    INTO $2;
END;
$$


-- CALL sp_adicionar_item_a_pedido (1, 1);

-- CREATE OR REPLACE PROCEDURE sp_adicionar_item_a_pedido (
--     IN cod_item INT, 
--     IN cod_pedido INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- --insere novo item
--     INSERT INTO tb_item_pedido (cod_item, cod_pedido) VALUES ($1, $2);
-- --atualiza data de modificação do pedido
--     UPDATE tb_pedido p SET data_modificacao = CURRENT_TIMESTAMP
--     WHERE p.cod_pedido = $2;
-- END;
-- $$

SELECT * FROM tb_item_pedido;
SELECT * FROM tb_pedido;



-- DO $$
-- DECLARE
-- --para guardar o código de pedido gerado
--     cod_pedido INT;
-- -- o código do cliente que vai fazer o pedido
--     cod_cliente INT;
-- BEGIN
-- -- pega o código da pessoa cujo nome é "João da Silva"
--     SELECT c.cod_cliente FROM tb_cliente c 
--     WHERE c.nome LIKE '%Jo%' INTO cod_cliente;
-- --cria o pedido
--     CALL sp_criar_pedido (cod_pedido, cod_cliente);
-- RAISE NOTICE 'Código do pedido recém criado: %', cod_pedido;
-- END;
-- $$

-- SELECT * FROM tb_pedido

-- CREATE OR REPLACE PROCEDURE sp_criar_pedido(
--     OUT cod_pedido INT,
--     IN cod_cliente INT
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     INSERT INTO tb_pedido (cod_cliente) VALUES (cod_cliente);
--     SELECT LASTVAL() INTO cod_pedido;
-- END;
-- $$



-- CALL sp_cadastrar_cliente('João');

-- CALL sp_cadastrar_cliente('Maria');

-- CREATE OR REPLACE PROCEDURE sp_cadastrar_cliente(
--     IN nome VARCHAR(200),
--     IN cod_cliente INT DEFAULT NULL
-- )
-- LANGUAGE PLPGSQL
-- AS $$
-- BEGIN
--     IF cod_cliente IS NULL THEN
--         INSERT INTO tb_cliente (nome) VALUES(nome);
--     ELSE    
--         INSERT INTO tb_cliente (cod_cliente, nome) VALUES (cod_cliente, nome);
--     END IF;
-- END;
-- $$


-- INSERT INTO tb_item
-- (descricao, valor, cod_tipo)VALUES
-- ('Coca-cola', 10, 1),
-- ('Água', 5, 1),
-- ('Coxinha', 7, 2),
-- ('Hamburguer', 20, 2);

-- SELECT * FROM tb_item;

-- CREATE TABLE IF NOT EXISTS tb_item_pedido(
-- --surrogate key, assim cod_item pode repetir
-- cod_item_pedido SERIAL PRIMARY KEY,
-- cod_item INT CONSTRAINT fk_item REFERENCES tb_item (cod_item),
-- cod_pedido INT CONSTRAINT fk_pedido REFERENCES tb_pedido(cod_pedido)
-- );


-- CREATE TABLE IF NOT EXISTS tb_item(
-- cod_item SERIAL PRIMARY KEY,
-- descricao VARCHAR(200) NOT NULL,
-- valor NUMERIC (10, 2) NOT NULL,
-- cod_tipo INT NOT NULL,
-- CONSTRAINT fk_tipo FOREIGN KEY (cod_tipo) REFERENCES
-- tb_tipo(cod_tipo)
-- );


-- INSERT INTO tb_tipo (descricao) VALUES ('Bebida'), ('Comida');
-- select * FROM tb_tipo;

-- CREATE TABLE tb_tipo(
-- cod_tipo SERIAL PRIMARY KEY,
-- descricao VARCHAR(200) NOT NULL
-- );
-- CREATE TABLE IF NOT EXIsTS tb_cliente (
-- cod_cliente SERIAL PRIMARY KEY,
-- nome VARCHAR(200) NOT NULL
-- );

-- CREATE TABLE if NOT EXISTS tb_pedido(
-- cod_pedido SERIAL PRIMARY KEY,
-- data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
-- data_modificacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
-- status VARCHAR DEFAULT 'aberto',
-- cod_cliente INT NOT NULL,
-- CONSTRAINT fk_cliente FOREIGN KEY (cod_cliente) REFERENCES
-- tb_cliente(cod_cliente)
-- );



-- CALL sp_calcula_media (1, 3, 5, 7)

-- --VARIADIC
-- CREATE OR REPLACE PROCEDURE sp_calcula_media(
--     VARIADIC valores INT[]
--     )
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     media NUMERIC (10, 2) := 0;
--     valor INT;
-- BEGIN
--     FOREACH valor IN ARRAY valores LOOP
--         media := media + valor;   
--     END LOOP;
--     RAISE NOTICE 'Media: %', media / array_length(valores, 1);

-- END;
-- $$


-- DO $$
-- DECLARE
--     valor1 INT := 5;
--     valor2 INT := 10;
-- BEGIN
--     CALL sp_acha_maiorv3(valor1, valor2);
--     RAISE NOTICE 'Maior: %', valor1;
-- END;
-- $$

-- --DROP PROCEDURE IF EXISTS sp_acha_maiorv3;

-- CREATE OR REPLACE PROCEDURE sp_acha_maiorv3(
--     INOUT valor1 INT,
--     IN valor2 INT
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     RAISE NOTICE 'Valor em modo INOUT: %', valor1;
--     IF valor1 < valor2 THEN
--         --$1 := $2;
--         valor1 := valor2;
--     END IF;
-- END;
-- $$

-- DO $$
-- DECLARE
--     resultado INT;
-- BEGIN
--     CALL sp_acha_maiorv2(resultado, 2, 3);
--     RAISE NOTICE '% é o maior', resultado;
-- END;
-- $$

-- DROP PROCEDURE IF EXISTS sp_acha_maiorv2;

-- CREATE OR REPLACE PROCEDURE sp_acha_maiorv2(
--     OUT resultado INT,
--     IN valor1 INT,
--     IN valor2 INT
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     RAISE NOTICE 'resultado que chegou %', resultado;
--     CASE 
--         WHEN valor1 > valor2 THEN
--         $1 := valor1;
--         ELSE
--             resultado := valor2;
--     END CASE;
-- END
-- $$


-- CALL sp_acha_maior(2, 3)

-- CREATE OR REPLACE PROCEDURE sp_acha_maior(
--     IN valor1 INT,
--     valor2 INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     IF valor1 > valor2 THEN
--         RAISE NOTICE 'Valor % é o maior', valor1;
--     ELSE
--         RAISE NOTICE 'Valor % é o maior', valor2;
--     END IF;
-- END;
-- $$

--Testando 
-- CALL sp_ola_usuario('Ana')

-- CREATE OR REPLACE PROCEDURE sp_ola_usuario(nome VARCHAR (200))
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     RAISE NOTICE 'Olá, %', nome;
--     RAISE NOTICE 'Olá, %', $1;
-- END;
-- $$


-- CALL sp_ola_procedures();


-- CREATE OR REPLACE PROCEDURE sp_ola_procedures()
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     RAISE NOTICE 'Olá, procedures!';
-- END;
-- $$


-- CREATE PROCEDURE sp_ola_procedures()
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     RAISE NOTICE 'Olá, procedures!';
-- END;
-- $$

