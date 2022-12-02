CREATE TABLE prodxtipo(
id NUMBER(20) PRIMARY KEY,
codprod NUMBER(20) NOT NULL,
tipo VARCHAR(2) NOT NULL
);

-- INSERTS
INSERT INTO prodxtipo VALUES(1, 1, 't1');
INSERT INTO prodxtipo VALUES(2, 2, 't2');
INSERT INTO prodxtipo VALUES(3, 3, 't3');
INSERT INTO prodxtipo VALUES(4, 4, 't4');
INSERT INTO prodxtipo VALUES(5, 5, 't5');
INSERT INTO prodxtipo VALUES(6, 6, 't6');
INSERT INTO prodxtipo VALUES(7, 7, 't7');
INSERT INTO prodxtipo VALUES(8, 8, 't8');
INSERT INTO prodxtipo VALUES(9, 9, 't9');
INSERT INTO prodxtipo VALUES(10, 10, 't0');


SELECT codprod,
                LISTAGG(tipo, '-') WITHIN GROUP (ORDER BY id) AS lista
FROM prodxtipo
GROUP BY codprod;


SELECT codprod,
                concatenarkendall(codprod) AS lista
FROM prodxtipo
GROUP BY codprod;

CREATE FUNCTION concatenarkendall(codprod IN PRODXTIPO.CODPROD%TYPE) RETURN VARCHAR IS

    cou number:=0;
    output varchar(125) := '';
    BEGIN
        FOR getproduct IN (SELECT tipo 
                            FROM PRODXTIPO 
                            WHERE CODPROD = codprod 
                            ORDER BY id) 
            LOOP
            IF cou <1 THEN
                output := getproduct.tipo;
                cou := cou+1;
            ELSE
                output := output||'-'||getproduct.tipo;
            END IF;
        end loop;
        RETURN output;
    END;
/

CREATE OR REPLACE PROCEDURE insertar_codprod(TOTAL NUMBER)  IS
    last_values codprod.id%TYPE;
    BEGIN

    SELECT max(id)
    INTO last_values
    FROM prodxtipo;

    FOR k IN 1..TOTAL LOOP
        INSERT INTO prodxtipo (id, codprod, tipo) VALUES (values)
      END LOOP
    END;