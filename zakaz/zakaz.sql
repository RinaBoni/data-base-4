-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.3
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: ord | type: SCHEMA --
-- DROP SCHEMA IF EXISTS ord CASCADE;
CREATE SCHEMA ord;
-- ddl-end --
ALTER SCHEMA ord OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,ord;
-- ddl-end --

-- object: public.delivery | type: TABLE --
-- DROP TABLE IF EXISTS public.delivery CASCADE;
CREATE TABLE public.delivery (
	delivery_id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	delivery_type smallint,
	delivery_price money NOT NULL,
	delivery_time interval NOT NULL,
	CONSTRAINT delivery_pk PRIMARY KEY (delivery_id)

);
-- ddl-end --
ALTER TABLE public.delivery OWNER TO postgres;
-- ddl-end --

-- object: public.product | type: TABLE --
-- DROP TABLE IF EXISTS public.product CASCADE;
CREATE TABLE public.product (
	product_id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	product_name text,
	product_price money NOT NULL,
	product_info text,
	CONSTRAINT product_pk PRIMARY KEY (product_id)

);
-- ddl-end --
ALTER TABLE public.product OWNER TO postgres;
-- ddl-end --

-- object: public.client | type: TABLE --
-- DROP TABLE IF EXISTS public.client CASCADE;
CREATE TABLE public.client (
	client_id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	company_name text,
	address text NOT NULL,
	number smallint NOT NULL,
	contact_person text NOT NULL,
	CONSTRAINT client_pk PRIMARY KEY (client_id)

);
-- ddl-end --
ALTER TABLE public.client OWNER TO postgres;
-- ddl-end --

-- object: public.contract | type: TABLE --
-- DROP TABLE IF EXISTS public.contract CASCADE;
CREATE TABLE public.contract (
	contract_number smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	"date_of_ purchase" date NOT NULL,
	client_id_client smallint,
	CONSTRAINT contract_pk PRIMARY KEY (contract_number)

);
-- ddl-end --
ALTER TABLE public.contract OWNER TO postgres;
-- ddl-end --

-- object: client_fk | type: CONSTRAINT --
-- ALTER TABLE public.contract DROP CONSTRAINT IF EXISTS client_fk CASCADE;
ALTER TABLE public.contract ADD CONSTRAINT client_fk FOREIGN KEY (client_id_client)
REFERENCES public.client (client_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.many_product_has_many_contract | type: TABLE --
-- DROP TABLE IF EXISTS public.many_product_has_many_contract CASCADE;
CREATE TABLE public.many_product_has_many_contract (
	product_id_product smallint NOT NULL,
	contract_number_contract smallint NOT NULL,
	delivery_id_delivery smallint,
	product_quantity smallint NOT NULL,
	CONSTRAINT many_product_has_many_contract_pk PRIMARY KEY (product_id_product,contract_number_contract)

);
-- ddl-end --

-- object: product_fk | type: CONSTRAINT --
-- ALTER TABLE public.many_product_has_many_contract DROP CONSTRAINT IF EXISTS product_fk CASCADE;
ALTER TABLE public.many_product_has_many_contract ADD CONSTRAINT product_fk FOREIGN KEY (product_id_product)
REFERENCES public.product (product_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: contract_fk | type: CONSTRAINT --
-- ALTER TABLE public.many_product_has_many_contract DROP CONSTRAINT IF EXISTS contract_fk CASCADE;
ALTER TABLE public.many_product_has_many_contract ADD CONSTRAINT contract_fk FOREIGN KEY (contract_number_contract)
REFERENCES public.contract (contract_number) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public.many_product_has_many_delivery | type: TABLE --
-- DROP TABLE IF EXISTS public.many_product_has_many_delivery CASCADE;
CREATE TABLE public.many_product_has_many_delivery (
	product_id_product smallint NOT NULL,
	delivery_id_delivery smallint NOT NULL,
	CONSTRAINT many_product_has_many_delivery_pk PRIMARY KEY (product_id_product,delivery_id_delivery)

);
-- ddl-end --

-- object: product_fk | type: CONSTRAINT --
-- ALTER TABLE public.many_product_has_many_delivery DROP CONSTRAINT IF EXISTS product_fk CASCADE;
ALTER TABLE public.many_product_has_many_delivery ADD CONSTRAINT product_fk FOREIGN KEY (product_id_product)
REFERENCES public.product (product_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: delivery_fk | type: CONSTRAINT --
-- ALTER TABLE public.many_product_has_many_delivery DROP CONSTRAINT IF EXISTS delivery_fk CASCADE;
ALTER TABLE public.many_product_has_many_delivery ADD CONSTRAINT delivery_fk FOREIGN KEY (delivery_id_delivery)
REFERENCES public.delivery (delivery_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: delivery_fk | type: CONSTRAINT --
-- ALTER TABLE public.many_product_has_many_contract DROP CONSTRAINT IF EXISTS delivery_fk CASCADE;
ALTER TABLE public.many_product_has_many_contract ADD CONSTRAINT delivery_fk FOREIGN KEY (delivery_id_delivery)
REFERENCES public.delivery (delivery_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


