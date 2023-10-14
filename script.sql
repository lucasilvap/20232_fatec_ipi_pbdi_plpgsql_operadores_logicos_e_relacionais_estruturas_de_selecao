--1.1 Faça um programa que exibe se um número inteiro é múltiplo de 3.

--SOLUÇÃO COM IF

DO $$
DECLARE
    numero INT := floor(random() * 100) + 1;  -- Gere um número aleatório entre 1 e 100
BEGIN
    IF numero % 3 = 0 THEN
        RAISE NOTICE 'O número % é múltiplo de 3.', numero;
    ELSE
        RAISE NOTICE 'O número % não é múltiplo de 3.', numero;
    END IF;
END;
$$;


--SOLUÇÃO COM CASE

DO $$
DECLARE
    numero INT := floor(random() * 100) + 1;  -- Gere um número aleatório entre 1 e 100
BEGIN
    CASE
        WHEN numero % 3 = 0 THEN
            RAISE NOTICE 'O número % é múltiplo de 3.', numero;
        ELSE
            RAISE NOTICE 'O número % não é múltiplo de 3.', numero;
    END CASE;
END;
$$;



--1.2 Faça um programa que exibe se um número inteiro é múltiplo de 3 ou de 5.
--SOLUCAO COm IF
DO $$
DECLARE
    numero INT := floor(random() * 100) + 1;  -- Gere um número aleatório entre 1 e 100
BEGIN
    IF numero % 3 = 0 OR numero % 5 = 0 THEN
        RAISE NOTICE 'O número % é múltiplo de 3 ou de 5.', numero;
    ELSE
        RAISE NOTICE 'O número % não é múltiplo de 3 nem de 5.', numero;
    END IF;
END;
$$;

--SOLUCAO  COM CASE
DO $$
DECLARE
    numero INT := floor(random() * 100) + 1;  -- Gere um número aleatório entre 1 e 100
BEGIN
    CASE
        WHEN numero % 3 = 0 OR numero % 5 = 0 THEN
            RAISE NOTICE 'O número % é múltiplo de 3 ou de 5.', numero;
        ELSE
            RAISE NOTICE 'O número % não é múltiplo de 3 nem de 5.', numero;
    END CASE;
END;
$$;


--1.3 Faça um programa que opera de acordo com o seguinte menu.
-- Opções:
-- 1 - Soma
-- 2 - Subtração
-- 3 - Multiplicação
-- 4 - Divisão
-- Cada operação envolve dois números inteiros. O resultado deve ser exibido no formato
-- op1 op op2 = res
-- Exemplo:
-- 2 + 3 = 5


--SOLUÇÃO COM IF
CREATE OR REPLACE FUNCTION operacoes_matematicas_if(opcao INT, num1 INT, num2 INT) RETURNS TEXT AS
$$
DECLARE
    resultado INT;
    operacao TEXT;
BEGIN
    IF opcao = 1 THEN
        resultado := num1 + num2;
        operacao := '+';
    ELSIF opcao = 2 THEN
        resultado := num1 - num2;
        operacao := '-';
    ELSIF opcao = 3 THEN
        resultado := num1 * num2;
        operacao := '*';
    ELSIF opcao = 4 THEN
        IF num2 = 0 THEN
            RETURN 'Divisão por zero não é permitida.';
        ELSE
            resultado := num1 / num2;
            operacao := '/';
        END IF;
    ELSE
        RETURN 'Opção inválida.';
    END IF;

    RETURN num1 || ' ' || operacao || ' ' || num2 || ' = ' || resultado;
END;
$$ LANGUAGE plpgsql;

SELECT operacoes_matematicas_if(1, 5, 3); -- Deverá retornar "5 + 3 = 8"
SELECT operacoes_matematicas_if(4, 8, 0); -- Deverá retornar "Divisão por zero não é permitida."


--SOLUCAO COM CASE
CREATE OR REPLACE FUNCTION operacoes_matematicas_case(opcao INT, num1 INT, num2 INT) RETURNS TEXT AS
$$
DECLARE
    resultado INT;
BEGIN
    CASE opcao
        WHEN 1 THEN
            resultado := num1 + num2;
            RETURN num1 || ' + ' || num2 || ' = ' || resultado;
        WHEN 2 THEN
            resultado := num1 - num2;
            RETURN num1 || ' - ' || num2 || ' = ' || resultado;
        WHEN 3 THEN
            resultado := num1 * num2;
            RETURN num1 || ' * ' || num2 || ' = ' || resultado;
        WHEN 4 THEN
            IF num2 = 0 THEN
                RETURN 'Divisão por zero não é permitida.';
            ELSE
                resultado := num1 / num2;
                RETURN num1 || ' / ' || num2 || ' = ' || resultado;
            END IF;
        ELSE
            RETURN 'Opção inválida.';
    END CASE;
END;
$$ LANGUAGE plpgsql;

SELECT operacoes_matematicas_case(2, 10, 4); -- Deverá retornar "10 - 4 = 6"
SELECT operacoes_matematicas_case(5, 7, 2); -- Deverá retornar "Opção inválida."


-- --1.4 Um comerciante comprou um produto e quer vendê-lo com um lucro de 45% se o valor
-- da compra for menor que R$20. Caso contrário, ele deseja lucro de 30%. Faça um
-- programa que, dado o valor do produto, calcula o valor de venda.

--SOLUCAO COM IF
CREATE OR REPLACE FUNCTION calcula_valor_venda_if(valor_compra NUMERIC) RETURNS NUMERIC AS
$$
DECLARE
    percentual_lucro NUMERIC;
BEGIN
    IF valor_compra < 20 THEN
        percentual_lucro := 0.45; -- 45%
    ELSE
        percentual_lucro := 0.30; -- 30%
    END IF;

    RETURN valor_compra + (valor_compra * percentual_lucro);
END;
$$ LANGUAGE plpgsql;

SELECT calcula_valor_venda_if(15); -- Deverá retornar o valor de venda com 45% de lucro


--SOLUCAO COM CASE
CREATE OR REPLACE FUNCTION calcula_valor_venda_case(valor_compra NUMERIC) RETURNS NUMERIC AS
$$
DECLARE
    percentual_lucro NUMERIC;
BEGIN
    CASE
        WHEN valor_compra < 20 THEN
            percentual_lucro := 0.45; -- 45%
        ELSE
            percentual_lucro := 0.30; -- 30%
    END CASE;

    RETURN valor_compra + (valor_compra * percentual_lucro);
END;
$$ LANGUAGE plpgsql;

SELECT calcula_valor_venda_case(25); -- Deverá retornar o valor de venda com 30% de lucro


--1.5 Resolva o problema disponível no link a seguir.
-- https://www.beecrowd.com.br/judge/en/problems/view/1048

--SOLUCAO COM IF

CREATE OR REPLACE FUNCTION calcular_aumento_salarial(salario NUMERIC)
RETURNS TABLE (
    novo_salario NUMERIC,
    reajuste_ganho NUMERIC,
    percentual INT
) AS
$$
BEGIN
    IF salario <= 400.00 THEN
        RETURN QUERY SELECT salario * 1.15, salario * 0.15, 15;
    ELSIF salario <= 800.00 THEN
        RETURN QUERY SELECT salario * 1.12, salario * 0.12, 12;
    ELSIF salario <= 1200.00 THEN
        RETURN QUERY SELECT salario * 1.10, salario * 0.10, 10;
    ELSIF salario <= 2000.00 THEN
        RETURN QUERY SELECT salario * 1.07, salario * 0.07, 7;
    ELSE
        RETURN QUERY SELECT salario * 1.04, salario * 0.04, 4;
    END IF;
END;
$$ LANGUAGE plpgsql;



SELECT * FROM calcular_aumento_salarial(300.00);


--SOLUCAO COM CASE
CREATE OR REPLACE FUNCTION calcular_aumento_salarial(salario NUMERIC)
RETURNS TABLE (
    novo_salario NUMERIC,
    reajuste_ganho NUMERIC,
    percentual INT
) AS
$$
BEGIN
    CASE
        WHEN salario <= 400.00 THEN
            RETURN QUERY SELECT salario * 1.15, salario * 0.15, 15;
        WHEN salario <= 800.00 THEN
            RETURN QUERY SELECT salario * 1.12, salario * 0.12, 12;
        WHEN salario <= 1200.00 THEN
            RETURN QUERY SELECT salario * 1.10, salario * 0.10, 10;
        WHEN salario <= 2000.00 THEN
            RETURN QUERY SELECT salario * 1.07, salario * 0.07, 7;
        ELSE
            RETURN QUERY SELECT salario * 1.04, salario * 0.04, 4;
    END CASE;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM calcular_aumento_salarial(400.00);
