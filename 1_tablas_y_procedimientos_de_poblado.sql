-- Creación de tablas factura y detalle

-- DROP TABLE detalle;
CREATE TABLE factura(
codigof NUMBER(20) PRIMARY KEY,
fecha DATE NOT NULL
);

--DROP TABLE factura;
CREATE TABLE detalle(
codigod NUMBER(20) PRIMARY KEY,
codproducto NUMBER(20) NOT NULL,
nro_unidades NUMBER(20) NOT NULL,
valor_unitario NUMBER(20) NOT NULL,
codfact NUMBER(20) NOT NULL REFERENCES factura
);


-- Procedimiento para insertar facturas

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

-- Procedimiento para insertar detalles

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