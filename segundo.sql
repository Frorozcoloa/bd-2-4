CREATE TABLE prodxtipo(
id NUMBER(20) PRIMARY KEY,
codprod NUMBER(20) NOT NULL,
tipo VARCHAR(2) NOT NULL
);

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
    output varchar(125):='';
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
    begin

    select max(id)
    into last_values
    from prodxtipo;

      FOR k IN 1..TOTAL LOOP
        id := 
        insert into prodxtipo (id, codprod, tipo)
        values (values)
      END LOOP
    end;