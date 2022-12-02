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





