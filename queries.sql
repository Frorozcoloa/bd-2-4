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