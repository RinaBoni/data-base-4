-- object: public.delivery | type: TABLE --
-- DROP TABLE IF EXISTS public.delivery CASCADE;
CREATE TABLE IF NOT EXISTS  public.delivery (
	delivery_id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	delivery_type smallint NOT NULL,
	delivery_price money NOT NULL,
	delivery_time interval NOT NULL,
	CONSTRAINT delivery_pk PRIMARY KEY (delivery_id)

);
-- ddl-end --
ALTER TABLE public.delivery OWNER TO postgres;
-- ddl-end --

-- object: public.product | type: TABLE --
-- DROP TABLE IF EXISTS public.product CASCADE;
CREATE TABLE IF NOT EXISTS  public.product (
	product_id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	product_name text NOT NULL,
	product_price money NOT NULL,
	product_info text NOT NULL,
	CONSTRAINT product_pk PRIMARY KEY (product_id)

);
-- ddl-end --
ALTER TABLE public.product OWNER TO postgres;
-- ddl-end --

-- object: public.client | type: TABLE --
-- DROP TABLE IF EXISTS public.client CASCADE;
CREATE TABLE IF NOT EXISTS public.client (
	client_id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	company_name text NOT NULL,
	address text NOT NULL,
	number numeric(11,0) NOT NULL,
	contact_person text NOT NULL,
	CONSTRAINT client_pk PRIMARY KEY (client_id)

);
-- ddl-end --
ALTER TABLE public.client OWNER TO postgres;
-- ddl-end --

-- object: public.contract | type: TABLE --
-- DROP TABLE IF EXISTS public.contract CASCADE;
CREATE TABLE IF NOT EXISTS public.contract (
	contract_number smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	date_of_purchase date NOT NULL,
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
CREATE TABLE IF NOT EXISTS public.many_product_has_many_contract (
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
CREATE TABLE IF NOT EXISTS public.many_product_has_many_delivery (
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




INSERT INTO client (company_name, address, number, contact_person) VALUES
('Prodmix', 'Новобульварная 9', 89141234569, 'Петров А.А.'),
('Fixprice', 'Бутина 50', 89244562536, 'Игорева И.П.'),
('Караван', 'Кастринская 34', 89542653023, 'Варишкин О.Е.');
('Спутник', 'Красноярская 57', 89145682536, 'Сидоров Р.О.'),
('Макавеевский', 'Космонавтов 65', 89145261245, 'Ершин П.А.'),
('Светофор', 'Богомякова 78', 89245685959, 'Долинов Л.Д'),
('Янта', 'Журавлева 100', 89145689894, 'Федорева О.О');
('Хлеб-соль', 'Шилова 8', 89145689595, 'Волошин П.А.'),
('Читинка', 'Нечаева 80', 89245468253, 'Кирилюк А.В.');




INSERT INTO delivery (delivery_type, delivery_price, delivery_time) VALUES
('Поездом', 4000, '6 D'),
('Самолет', 5000, '2 D'),
('Машина', 3000, '10 D');




INSERT INTO product (product_name, product_price, product_info) VALUES
('Молоко', 75, '1 литр'),
('Молоко', 100, '2 литра'),
('Масло', 200, '200 грамм'),
('Сыр', 1400, '1000 грамм'),
('Творог', 150, '500 грамм'),
('Кефир', 80, '1 литр'),
('Йогурт', 75, '0.5 литра'),
('Сметана', 140, '400 грамм'),
('Снежок', 50, '0.5 литра');



INSERT INTO contract ("date_of_ purchase", client_id_client) VALUES
('2022-06-25', 3),
('2022-06-25', 1),
('2022-06-26', 2),
('2022-07-25', 4),
('2022-07-30', 6),
('2022-08-10', 8),
('2022-08-10', 5),
('2022-08-12', 9),
('2022-09-8', 2),
('2022-09-10', 7),
('2022-09-16', 8),
('2022-09-16', 9),
('2022-09-30', 5),
('2022-09-30', 6);





INSERT INTO many_product_has_many_delivery (product_id_product, delivery_id_delivery) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(3, 2),
(3, 3),
(4, 1),
(4, 2),
(4, 3),
(5, 2),
(5, 3),
(6, 1),
(6, 3),
(7, 1),
(7, 2),
(7, 3),
(8, 1),
(8, 3),
(9, 1);




INSERT INTO many_product_has_many_contract (product_id_product, contract_number_contract, delivery_id_delivery, product_quantity) VALUES
(1, 1, 2, 1000),
(2, 1, 2, 500),
(5, 1, 2, 100),
(3, 2, 3, 2000),
(4, 2, 3, 200),
(5, 2, 3, 500),
(7, 2, 3, 2000),
(2, 3, 1, 100),
(6, 3, 1, 2000),
(4, 4, 3, 300),
(8, 4, 3, 1700),
(3, 4, 3, 1500),
(1, 5, 1, 2000),
(9, 5, 1, 300),
(8, 6, 1, 2000),
(4, 6, 1, 400),
(7, 6, 1, 500),
(2, 6, 1, 500),
(9, 7, 1, 550),
(5, 7, 3, 700),
(3, 7, 3, 700),
(4, 7, 3, 2000),
(7, 7, 3, 1000),
(6, 7, 3, 1500),
(8, 7, 3, 1000),
(1, 7, 1, 200),
(2, 7, 1, 1000),
(1, 8, 3, 1500),
(2, 8, 1, 1050),
(3, 8, 3, 1080),
(4, 8, 3, 400),
(5, 8, 3, 1540),
(8, 8, 1, 1156),
(9, 8, 1, 1480),
(1, 9, 1, 480),
(5, 10, 3, 485),
(6, 10, 3, 100),
(1, 11, 3, 100),
(2, 11, 1, 200),
(5, 11, 3, 1500),
(9, 11, 1, 320),
(3, 12, 3, 500),
(4, 12, 1, 1510),
(5, 12, 3, 450),
(8, 12, 1, 546),
(9, 12, 1, 1055),
(4, 13, 2, 1450),
(5, 13, 2, 1000),
(9, 13, 1, 1500),
(1, 14, 2, 1040),
(2, 14, 2, 148),
(3, 14, 3, 150),
(4, 14, 3, 1605),
(5, 14, 3, 1040),
(6, 14, 1, 1550),
(7, 14, 1, 1060),
(8, 14, 1, 1040),
(9, 14, 1, 1450);


UPDATE delivery SET delivery_price = 40.00 WHERE delivery_id = 1;
UPDATE delivery SET delivery_price = 50.00 WHERE delivery_id = 2;
UPDATE delivery SET delivery_price = 30.00 WHERE delivery_id = 3



UPDATE goods SET price = 150 WHERE num = 2 --изменить значение поля--

ALTER TABLE tblmovies ALTER COLUMN movie_id TYPE BIGINT --изменить тип поля--

SELECT *
FROM delivery

ALTER TABLE contract
RENAME COLUMN  "date_of_ purchase" TO date_of_purchase;




--Список заказов за определенную дату:
SELECT * FROM contract WHERE date_of_purchase = '2022-09-30';

--пример
--SELECT NAZV_F||' обучается '||COUNT(STUDENT.BALL)||' человек' As CountStudOnFakultet FROM FAKULTET, SPEC, STUDENT WHERE STUDENT.KOD_S=SPEC.KOD_S AND SPEC.KOD_F=FAKULTET.KOD_F GROUP BY NAZV_F;

--пример
--SELECT NAZV_F||' обучается '||COUNT(STUDENT.BALL)||' человек' As CountStudOnFakultet 
--FROM FAKULTET, SPEC, STUDENT 
--WHERE STUDENT.KOD_S=SPEC.KOD_S AND SPEC.KOD_F=FAKULTET.KOD_F 
--GROUP BY NAZV_F;




--SELECT SUM(product.product_price) 
--FROM contract inner join many_product_has_many_contract on many_product_has_many_contract.contract_number_contract = contract.contract_number
--WHERE EXTRACT (MONTH FROM date_of_purchase) = 09;

SELECT MAX (delivery_price)
FROM delivery

SELECT *
FROM product
WHERE product_price BETWEEN 100 AND 150


--пример
--ALTER TABLE Persons
--ADD UNIQUE (ID);

ALTER TABLE client
ADD UNIQUE (company_name),
ADD UNIQUE (number),
ADD UNIQUE (contact_person);


DELETE FROM client
WHERE client_id = 10


INSERT INTO client (company_name, address, number, contact_person) VALUES
('Prodmix', 'Новhобульварная 9', 89141234569, 'Петров А.А.');







INSERT INTO client (company_name, address, number, contact_person) VALUES
('Соловушка', 'Новобульварная 9', 89141232569, 'Петрова А.Т.');

ALTER TABLE client
ADD UNIQUE (company_name),
ADD UNIQUE (number),
ADD UNIQUE (contact_person);


SELECT *
FROM client

DELETE FROM client
WHERE client_id = 13



UPDATE client SET address = 'Бутина 9' WHERE client_id = 13

--Прибыль компании за месяц:
SELECT SUM(product.product_price * many_product_has_many_contract.product_quantity) AS Monthly_income
FROM product 
	JOIN many_product_has_many_contract 
		ON product.product_id = many_product_has_many_contract.product_id_product 
	JOIN contract 
		ON contract.contract_number = many_product_has_many_contract.contract_number_contract
WHERE EXTRACT (MONTH FROM date_of_purchase) = 09;



----------------------попытки сделать  самый редкий способ доставки для каждого заказчика---------------------
SELECT DISTINCT(many_product_has_many_contract.delivery_id_delivery), contract.client_id_client
FROM product 
	JOIN many_product_has_many_contract 
		ON product.product_id = many_product_has_many_contract.product_id_product 
	JOIN contract 
		ON contract.contract_number = many_product_has_many_contract.contract_number_contract


SELECT * --DISTINCT(contract.client_id_client), many_product_has_many_contract.delivery_id_delivery
FROM product 
	JOIN many_product_has_many_contract 
		ON product.product_id = many_product_has_many_contract.product_id_product 
	JOIN contract 
		ON contract.contract_number = many_product_has_many_contract.contract_number_contract




SELECT contract.client_id_client, many_product_has_many_contract.delivery_id_delivery, COUNT(*) AS quantity
	FROM many_product_has_many_contract 
		JOIN contract 
			ON contract.contract_number = many_product_has_many_contract.contract_number_contract
	GROUP BY contract.client_id_client, many_product_has_many_contract.delivery_id_delivery
	HAVING COUNT(*) > 1
	ORDER BY contract.client_id_client


SELECT contract.client_id_client, many_product_has_many_contract.delivery_id_delivery, COUNT(*) AS quantity
	FROM many_product_has_many_contract 
		JOIN contract 
			ON contract.contract_number = many_product_has_many_contract.contract_number_contract
	GROUP BY contract.client_id_client, many_product_has_many_contract.delivery_id_delivery

	ORDER BY contract.client_id_client

SELECT *
FROM (SELECT contract.client_id_client, many_product_has_many_contract.delivery_id_delivery, COUNT(*) AS quantity
	FROM many_product_has_many_contract 
		JOIN contract 
			ON contract.contract_number = many_product_has_many_contract.contract_number_contract
	GROUP BY contract.client_id_client, many_product_has_many_contract.delivery_id_delivery

	ORDER BY contract.client_id_client) as c
	
	
	
	
	
	SELECT *
FROM (SELECT contract.client_id_client, many_product_has_many_contract.delivery_id_delivery, COUNT(*) AS quantity
	FROM many_product_has_many_contract 
		JOIN contract 
			ON contract.contract_number = many_product_has_many_contract.contract_number_contract
	GROUP BY contract.client_id_client, many_product_has_many_contract.delivery_id_delivery
	) as c
--WHERE c.client_id_client
--GROUP BY c.client_id_client, c.delivery_id_delivery
ORDER BY c.client_id_client



SELECT many_product_has_many_contract.delivery_id_delivery, COUNT(*) AS quantity
	FROM many_product_has_many_contract 
		JOIN contract 
			ON contract.contract_number = many_product_has_many_contract.contract_number_contract
	GROUP BY many_product_has_many_contract.delivery_id_delivery
-------------------------------------------------------------------------------------------------------------------------	
	
DROP TABLE product_audit

DROP FUNCTION product_update_trigger_fnc() CASCADE

DROP TRIGGER product_update_trigger ON product

DROP FUNCTION product_insert_trigger_fnc() CASCADE

DROP TRIGGER product_insert_trigger ON product

DROP FUNCTION product_delete_trigger_fnc() CASCADE

--таблица для хранения записей аудита
CREATE TABLE product_audit(
	product_audit_id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	product_id smallint,
	product_name text NOT NULL,
	modified_by varchar(20) NOT NULL,
	modified_date varchar(20) NOT NULL,
	operation char(1),		--I-INSERT, U-UPDATE, D-DELETE
	CONSTRAINT product_audit_pk PRIMARY KEY (product_audit_id)
)

--функция для триггера INSERT
CREATE OR REPLACE FUNCTION product_insert_trigger_fnc()
  RETURNS trigger AS
	$$
	BEGIN
		INSERT INTO product_audit ( product_id, product_name, modified_by,modified_date ,operation)
		VALUES(NEW.product_id,NEW.product_name,current_user,current_date, 'I');
		RETURN NEW;
	END;
	$$
  LANGUAGE 'plpgsql';

--триггер INSERT
CREATE TRIGGER product_insert_trigger
  AFTER INSERT
  	ON product
  FOR EACH ROW
  EXECUTE PROCEDURE product_insert_trigger_fnc();


INSERT INTO product (product_name, product_price, product_info) VALUES
--('Сухарики', 74, '50 грамм'),
('Рис', 90, '1 килограмм'),
('Чипсы', 100, '150 грамм')

SELECT * FROM product

SELECT * FROM product_audit;

--функция для триггера UPDATE
CREATE OR REPLACE FUNCTION product_update_trigger_fnc()
  RETURNS trigger AS
	$$
	BEGIN
		INSERT into product_audit ( product_id, product_name, modified_by,modified_date ,operation)
		VALUES (OLD.product_id,NEW.product_name,current_user,current_date, 'U');
		RETURN NEW;
	END;
	$$
  LANGUAGE 'plpgsql';

--триггер UPDATE
CREATE TRIGGER product_update_trigger
  AFTER UPDATE
  ON product
  FOR EACH ROW
  EXECUTE PROCEDURE product_update_trigger_fnc()


UPDATE product SET product_name = 'Lays' WHERE product_id = 17;

--функция для триггера DELETE
CREATE OR REPLACE FUNCTION product_delete_trigger_fnc()
  RETURNS trigger AS
	$$
	BEGIN
		INSERT into product_audit ( product_id, product_name, modified_by,modified_date ,operation)
		VALUES (OLD.product_id,OLD.product_name,current_user,current_date, 'D');
		RETURN NEW;
	END;
	$$
  LANGUAGE 'plpgsql';

--триггер DELETE
CREATE TRIGGER product_delete_trigger
  AFTER DELETE
  ON product
  FOR EACH ROW
  EXECUTE PROCEDURE product_delete_trigger_fnc()

DELETE FROM product WHERE product_id = 16;
DELETE FROM product WHERE product_id = 17;
DELETE FROM product WHERE product_id = 18;

DELETE FROM product_audit;


--Самый прибыльный вид доставки:
SELECT delivery_id AS  delivery_price
FROM delivery
WHERE delivery_price = (SELECT MAX(delivery_price)
						FROM delivery)


--самая редкая доставка
SELECT c.delivery_id_delivery, c.quantity
FROM (SELECT many_product_has_many_contract.delivery_id_delivery, COUNT(*) AS quantity
		FROM many_product_has_many_contract 
			JOIN contract 
				ON contract.contract_number = many_product_has_many_contract.contract_number_contract
		GROUP BY many_product_has_many_contract.delivery_id_delivery) AS c
WHERE c.quantity = (SELECT MIN(c.quantity) FROM (SELECT many_product_has_many_contract.delivery_id_delivery, COUNT(*) AS quantity
												 FROM many_product_has_many_contract 
													JOIN contract 
														ON contract.contract_number = many_product_has_many_contract.contract_number_contract
												 GROUP BY many_product_has_many_contract.delivery_id_delivery) AS c)
	