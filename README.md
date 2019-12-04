# Homework 5
ДЗ №4 находится в файле readme-hw4.md

## Партиционирование
-  Выполнено партиционирование таблицы orders по году даты выполнения заказа.
-  Необходимость обусловлена потенциально большим количеством заказов, что может привести к снижению производительности, с учётом того, что 
вероятность наличия в одном запросе заказов с разными годами достаточно низка.
-  Добавление новых партиций следует производить также по годам.

## Изменение типов данных
-  Типы id таблицы orders и products заменены на BIGINT(8) взамен INT (для предотвращения переполнения)
-  В таблице categories тип parent_id скорректирован с NOT NULL на NULL

## JSON-поле
-  В таблицу products добавлено поле "properties" типа JSON для хранения характеристик товаров.
- Примеры запросов:

      insert into products (name, category_id, manufacturer_id, properties) values ('Samsung Galaxy A20', 1, 1, '{"color": "black", "weight": 100, "weight_units": "g"}');
      
      select id, name, JSON_EXTRACT(properties, '$.color') AS color from products;