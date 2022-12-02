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
CREATE OR REPLACE PROCEDURE inserta_detalles (caso IN detalle.codigod%TYPE, cantidad IN detalle.codigod%TYPE, agregar IN VARCHAR2(5))
IS
 TYPE cod_fact IS TABLE OF factura.codigof%TYPE;
 arr_codigof cod_fact;
 num_detalles NUMBER(2);
 cont NUMBER(20) := 0;
BEGIN
 SELECT codigof BULK COLLECT INTO arr_codigof FROM factura;
 
 IF agregar = 'f' THEN
  SELECT MAX(codigod)INTO cont FROM detalle;
 END IF;
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