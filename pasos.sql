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

-- 8. Ejecutar:
set autotrace traceonly;

-- 9. Ejecutar query (VER ARCHIVO queries.sql)

-- Para apagar el autotrace
set autotrace off;
