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
tkprof C:\oraclexe\app\oracle\diag\rdbms\xe\xe\trace\xe_ora_9244.trc C:\temp\out1.txt

-- 8. ruta del trace
SELECT value AS ruta_d
FROM v$parameter
WHERE name = 'user_dump_dest';

-- 8. Ejecutar:
set autotrace traceonly;

-- 9. Ejecutar query (VER ARCHIVO queries.sql)

-- Para apagar el autotrace
set autotrace off;





0. Crear una nueva sesion de sql plus
1. Hacer drop de las tablas
drop table detalle;
drop table factura;
drop index cluster_factura;
drop cluster mi_cluster;
2. Crear las tablas nuevamente

CREATE CLUSTER mi_cluster
(codigo number(20));

CREATE INDEX cluster_factura ON CLUSTER mi_cluster;

CREATE TABLE factura (
    codigof NUMBER(20) PRIMARY KEY,
    fecha DATE NOT NULL
) CLUSTER mi_cluster(codigof);

CREATE TABLE detalle (
    codigod NUMBER(20) PRIMARY KEY,
    codproducto NUMBER(20) NOT NULL,
    nro_unidades NUMBER(20) NOT NULL,
    valor_unitario NUMBER(20) NOT NULL,
    codfact NUMBER(20) NOT NULL REFERENCES factura
) CLUSTER mi_cluster(codfact);

3. Llenar las tablas usando console
EXECUTE inserta_facturas(100000);
EXECUTE inserta_detalles(1, 400000);
5. Borrar cache
ALTER SYSTEM flush buffer_cache;
ALTER SYSTEM flush shared_pool;
6. alter session set sql_trace true;
7. Ver id del proceso
SELECT spid FROM sys.v_$process
WHERE addr = (SELECT paddr FROM sys.v_$session
              WHERE audsid = USERENV('sessionid')
             );
8. Cambiar pid en la ruta (no ejecutar) tkprof C:\oraclexe\app\oracle\diag\rdbms\xe\xe\trace\xe_ora_13160.trc C:\temp\out1.txt

9. Imprimir solo explain plan
set autotrace traceonly;
10. Enviar consulta

SELECT *
FROM factura f, detalle d
WHERE f.codigof = d.codfact;

PANTALLAZOOO

11. Abrir ruta en cmd (ejecutar paso 8)

12. Buscar el txt creado en c/temp

13. Hacer ctrl + b  y buscar el numero de filas que quedaron en detalle hasta que se vea la consulta ejecutada

14. Borra el archivo out1.txt
15- Borrar en
C:\oraclexe\app\oracle\diag\rdbms\xe\xe\trace
los archivos con el PID del paso 7
