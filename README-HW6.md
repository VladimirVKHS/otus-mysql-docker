# Homework 6

## Запрос с INNER JOIN

   Получение полного перечня адресов, для которых указаны все данные (страна, город, улица, дом)

    SELECT b.*, s.name as street_name, c.name as city_name, co.name as country_name, co.code as country_code, bt.name as building_type_name FROM buildings b 
        JOIN streets s ON s.id = b.street_id
        JOIN cities c ON s.city_id = c.id
        JOIN countries co ON co.id = c.country_id
        JOIN building_types bt ON bt.id = b.building_type_id
        ORDER BY country_name
        
## Запрос с LEFT JOIN

   Получение полного перечня стран с указанием количества городов имеющихся в БД
    
    SELECT co.id, co.code, co.name, count(c.id) as cities_count FROM countries co
    	LEFT JOIN cities c ON c.country_id = co.id
        GROUP BY co.id, co.code, co.name
        ORDER BY co.name

## Запросы с WHERE

  - Получение всех продуктов относящихся к категориям с id 1 или 2
  
        SELECT * FROM products WHERE category_id IN (1,2)
        
  - Тоже самое через OR
  
        SELECT * FROM products WHERE category_id = 1 OR category_id = 2 
        
  - Тоже самое через для определенного производителя
    
        SELECT * FROM products WHERE category_id IN (1,2) AND manufacturer_id = 1 
         
  - Получить все продуты с наименованием начинающимся на 'Смартфон'
  
        SELECT * FROM `products` WHERE name LIKE 'Смартфон%';
        
  - Получить историю цен на продукт установленные не позднее определенной даты
  
        SELECT * FROM prices WHERE product_id = 1 AND date >= '2019-12-22 00:00:00'      