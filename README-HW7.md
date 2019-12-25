# Homework 7

## Пример транзакции

   Покупка в 1 клик: создание пользователя и заказа
   
       DELIMITER $$;
       CREATE PROCEDURE pay1click (
           IN user_first_name VARCHAR(255),
           IN user_last_name VARCHAR(255),
           IN user_gender_id INT,
           IN user_marital_status_id INT,
           IN user_title_id INT,
           IN user_buiding_id INT,
           IN user_language_id INT,
           IN target_product_id INT,
           IN product_count INT
       )
       BEGIN
           START TRANSACTION;
               INSERT INTO customers (first_name, last_name, gender_id, marital_status_id, title_id) 
                    VALUES (user_first_name, user_last_name, user_gender_id, user_marital_status_id, user_title_id);
               SELECT @price_id = max(price) FROM prices WHERE product_id = 1 ORDER BY date DESC LIMIT 1;
               INSERT INTO orders (customer_id, product_id, count, price_id, order_status_id, building_id, language_id, date) 
                    VALUES(LAST_INSERT_ID(), target_product_id, product_count, @price_id, user_buiding_id, user_language_id, 1, NOW());
           COMMIT;
       END
       $$;
       
## Загрузка данных (LOAD DATA)

   Загрузка продуктов из файла Apparel.csv
   
   (присвоены случайные идентификаторы категории и производителя)
   
        LOAD DATA INFILE '/csv/Apparel.csv' 
        INTO TABLE products
        FIELDS TERMINATED BY ',' ENCLOSED BY '"'
        LINES TERMINATED BY '\n'
        IGNORE 1 LINES
        (@dummy, name, description, @dummy, @type, @tags, @published, @option1name, @option1value, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
        SET category_id = FLOOR(1 + RAND() * 2),
            manufacturer_id = FLOOR(1 + RAND() * 2),
            properties = (JSON_OBJECT('type', @type, 'tags', @tags, 'published', @published, @option1name, @option1value));
            
   Результат:
   
        Query OK, 104 rows affected (0.04 sec)
        Records: 104  Deleted: 0  Skipped: 0  Warnings: 0
   
   
## Загрузка данных (mysqlimport)

   Загрузка продуктов из файла Bicycles.csv
   
   Файл предварительно подготовлен для импорта (ввиду ограничений mysqlimport):
       
   - переименован в products.csv
   - добавлены столбцы идентификатора категории и производителя (Category ID, Manufacturer ID)
   
   
       mysqlimport --ignore-lines=1 --fields-terminated-by=, --columns=name,description,category_id,manufacturer_id -u root -p12345 otus /csv/products.csv --ignore


   Результат:
   
        otus.products: Records: 2812  Deleted: 0  Skipped: 1679  Warnings: 7570

## Загрузка данных (FIFO)

   В процессе...