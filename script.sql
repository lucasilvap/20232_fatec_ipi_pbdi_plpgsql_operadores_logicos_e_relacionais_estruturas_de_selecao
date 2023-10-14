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

