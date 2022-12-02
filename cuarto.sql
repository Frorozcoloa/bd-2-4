-- Crear tipo para tabla tipada
DROP TYPE tipo_factura FORCE;
CREATE OR REPLACE TYPE tipo_factura
AS OBJECT(
    codigof NUMBER(20),
    fecha DATE
);

-- Crear tabla tipada
DROP TABLE factura;
CREATE TABLE factura OF tipo_factura
(
    codigof PRIMARY KEY
);


-- CREATE TABLE factura(
--     codigof NUMBER(20) PRIMARY KEY,
--     fecha DATE NOT NULL
-- );


-- Crear tipo para tabla detalle
DROP TYPE tipo_detalle FORCE;
CREATE OR REPLACE TYPE tipo_detalle
AS OBJECT(
    codigod NUMBER(20),
    codproducto NUMBER(20),
    nro_unidades NUMBER(20),
    valor_unitario NUMBER(20),
    codfact REF tipo_factura
);

-- Crear tabla tipada
DROP TABLE detalle;
CREATE TABLE detalle OF tipo_detalle(
    SCOPE FOR(codfact) IS factura
);

-- CREATE TABLE detalle(
--     codigod NUMBER(20) PRIMARY KEY,
--     codproducto NUMBER(20) NOT NULL,
--     nro_unidades NUMBER(20) NOT NULL,
--     valor_unitario NUMBER(20) NOT NULL,
--     codfact NUMBER(20) NOT NULL REFERENCES factura
-- );