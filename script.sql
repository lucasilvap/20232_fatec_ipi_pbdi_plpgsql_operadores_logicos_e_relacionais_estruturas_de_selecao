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
