-- Paso a paso para explain plan y TKPROF

-- 1. Crear una nueva sesion de sql plus

-- 2.
TRUNCATE TABLE detalle;
TRUNCATE TABLE factura;

-- 3. poblar las tablas mediante el uso de los procedimientos
---- Caso 1 Exp 3
EXECUTE inserta_facturas(500000);
EXECUTE inserta_detalles(3, 500000);

-- 4. Limpiar caché en SQL Plus con los siguientes comandos
ALTER SYSTEM flush buffer_cache;
ALTER SYSTEM flush shared_pool;
alter session set sql_trace true;

-- 5. Ejecutar el PID
SELECT spid FROM sys.v_$process
WHERE addr = (
    SELECT paddr FROM sys.v_$session
    WHERE audsid = USERENV('sessionid')
);
             
-- 6. Cambiar la siguiente ruta modificando el PID y crear una carpeta llamada "temp" en la raíz del disco C
-- Ejecutarlo en un CMD
tkprof C:\oraclexe\app\oracle\diag\rdbms\xe\xe\trace\xe_ora_13160.trc C:\temp\outcaso1exp3.txt

-- 7. ruta del trace
SELECT value AS ruta_d
FROM v$parameter
WHERE name = 'user_dump_dest';

-- Ejecutar:
set autotrace traceonly;

-- Consulta
SELECT *
FROM factura f, detalle d
WHERE f.codigof = d.codfact;

-- Para apagar el autotrace
set autotrace off;