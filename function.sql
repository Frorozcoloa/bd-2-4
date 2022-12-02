-- SET SERVEROUTPUT ON;

DROP TABLE detalle;
DROP TABLE factura;

CREATE TABLE factura(
codigof NUMBER(20) PRIMARY KEY,
fecha DATE NOT NULL
);

CREATE TABLE detalle(
codigod NUMBER(20) PRIMARY KEY,
codproducto NUMBER(20) NOT NULL,
nro_unidades NUMBER(20) NOT NULL,
valor_unitario NUMBER(20) NOT NULL,
codfact NUMBER(20) NOT NULL REFERENCES factura
);

CREATE OR REPLACE PROCEDURE inserta_facturas (cantidad IN factura.codigof%TYPE)
IS
 cont NUMBER(20) := 0;
BEGIN
 LOOP
  INSERT INTO factura VALUES(cont, SYSDATE);
  cont := cont + 1;
  EXIT WHEN cont = cantidad;
 END LOOP;
END;

CREATE OR REPLACE PROCEDURE inserta_detalles (caso IN detalle.codigod%TYPE, cantidad IN detalle.codigod%TYPE)
IS
 TYPE cod_fact IS TABLE OF factura.codigof%TYPE;
 arr_codigof cod_fact;
 num_detalles NUMBER(2);
 cont NUMBER(20) := 0;
BEGIN
 SELECT codigof BULK COLLECT INTO arr_codigof FROM factura;
 
 IF caso = 1 THEN 
  IF arr_codigof.FIRST IS NOT NULL THEN
   FOR cod IN arr_codigof.FIRST .. arr_codigof.LAST LOOP
    INSERT INTO detalle VALUES(
        cont, 
        DBMS_RANDOM.VALUE(0, 1000), 
        DBMS_RANDOM.VALUE(0, 50), 
        DBMS_RANDOM.VALUE(1000, 1000000), 
        arr_codigof(cod));
    cont := cont + 1;
    EXIT WHEN cont = cantidad / 4;
   END LOOP;
  
   FOR cod IN arr_codigof.FIRST .. arr_codigof.LAST LOOP   
    num_detalles := DBMS_RANDOM.VALUE(1, 6);
    FOR n IN 1 .. num_detalles LOOP
     INSERT INTO detalle VALUES(
         cont, 
         DBMS_RANDOM.VALUE(0, 1000), 
         DBMS_RANDOM.VALUE(0, 50), 
         DBMS_RANDOM.VALUE(1000, 1000000), 
         arr_codigof(cod));
     cont := cont + 1;
     EXIT WHEN cont = cantidad;
    END LOOP;
    EXIT WHEN cont = cantidad;
   END LOOP;
  END IF;
 
 ELSIF caso = 2 THEN
   IF arr_codigof.FIRST IS NOT NULL THEN
   FOR cod IN arr_codigof.FIRST .. arr_codigof.LAST LOOP
    INSERT INTO detalle VALUES(
        cont, 
        DBMS_RANDOM.VALUE(0, 1000), 
        DBMS_RANDOM.VALUE(0, 50), 
        DBMS_RANDOM.VALUE(1000, 1000000), 
        arr_codigof(cod));
    cont := cont + 1;
    EXIT WHEN cont = cantidad / 2;
   END LOOP;
  
   FOR cod IN arr_codigof.FIRST .. arr_codigof.LAST LOOP   
    num_detalles := DBMS_RANDOM.VALUE(1, 2);
    FOR n IN 1 .. num_detalles LOOP
     INSERT INTO detalle VALUES(
         cont, 
         DBMS_RANDOM.VALUE(0, 1000), 
         DBMS_RANDOM.VALUE(0, 50), 
         DBMS_RANDOM.VALUE(1000, 1000000), 
         arr_codigof(cod));
     cont := cont + 1;
     EXIT WHEN cont = cantidad;
    END LOOP;
    EXIT WHEN cont = cantidad;
   END LOOP;
  END IF;
  
  ELSIF caso = 3 THEN
   IF arr_codigof.FIRST IS NOT NULL THEN
    FOR cod IN arr_codigof.FIRST .. arr_codigof.LAST LOOP
     INSERT INTO detalle VALUES(
        cont, 
        DBMS_RANDOM.VALUE(0, 1000), 
        DBMS_RANDOM.VALUE(0, 50), 
        DBMS_RANDOM.VALUE(1000, 1000000), 
        arr_codigof(cod));
     cont := cont + 1;
     EXIT WHEN cont = cantidad;
    END LOOP;
   END IF;
 END IF;
END;

-- BORRAR DATOS
-- TRUNCATE TABLE factura;
-- TRUNCATE TABLE detalle;
-- Caso 1 Exp 1
EXECUTE inserta_facturas(500000);
EXECUTE inserta_detalles(1, 2000000);

-- Caso 1 Exp 2
EXECUTE inserta_facturas(500000);
EXECUTE inserta_detalles(1, 1000000);

-- Caso 1 Exp 3
EXECUTE inserta_facturas(500000);
EXECUTE inserta_detalles(1, 500000);


SELECT * FROM factura;
SELECT * FROM  detalle ORDER BY codfact;
DELETE FROM factura;
DELETE FROM detalle;


-- Primer query
SELECT *
FROM factura f, detalle d
WHERE f.codigof = d.codfact;

-- Segundo query
CREATE INDEX i_codfact ON detalle(codfact);

SELECT INDEX(i_codfact)
FROM factura f, detalle d
WHERE f.codigof = d.codfact;

-- tercer query
CREATE CLUSTER mi_cluster 
(factura NUMBER(6)); 

DROP TABLE detalle;
DROP TABLE factura;

CREATE TABLE factura(
codigof NUMBER(20) PRIMARY KEY,
fecha DATE NOT NULL)mi_cluster(codigof);

CREATE TABLE detalle(
codigod NUMBER(20) PRIMARY KEY,
codproducto NUMBER(20) NOT NULL,
nro_unidades NUMBER(20) NOT NULL,
valor_unitario NUMBER(20) NOT NULL,
codfact NUMBER(20) NOT NULL REFERENCES factura
)mi_cluster(codfact);


--Cuarto Query
DROP TABLE detalle;
DROP TABLE factura;

CREATE TABLE factura(
codigof NUMBER(20) PRIMARY KEY,
fecha DATE NOT NULL);

CREATE TABLE detalle(
codigod NUMBER(20) PRIMARY KEY,
codproducto NUMBER(20) NOT NULL,
nro_unidades NUMBER(20) NOT NULL,
valor_unitario NUMBER(20) NOT NULL,
codfact NUMBER(20) NOT NULL REFERENCES factura
)


-- Paso a paso para explain plan y TKPROF

-- 1. Crear una nueva sesion de sql plus
-- 2
drop table detalle;
drop table factura;
-- 3. crear las tablas de nuevo
-- 4. poblar las tablas mediante el uso de los procedimientos
-- 5. Limpiar caché en SQL Plus con los siguientes comandos
ALTER SYSTEM flush buffer_cache;
ALTER SYSTEM flush shared_pool;
alter session set sql_trace true;
-- 6. Ejecutar el PID
SELECT spid FROM sys.v_$process
WHERE addr = (SELECT paddr FROM sys.v_$session
              WHERE audsid = USERENV('sessionid')
             );
             
-- 7. Cambiar la siguiente ruta modificando el PID y crear una carpeta llamada "temp" en la raíz del disco C
-- Ejecutarlo en un CMD
tkprof C:\oraclexe\app\oracle\diag\rdbms\xe\xe\trace\xe_ora_13160.trc C:\temp\out1.txt

-- 8. ruta del trace
SELECT value AS ruta_d
FROM v$parameter
WHERE name = 'user_dump_dest';

-- Ejecutar:
set autotrace traceonly;

-- Para apagar el autotrace
set autotrace off;
