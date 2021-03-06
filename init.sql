-- MySQL Script generated by MySQL Workbench
-- 12/02/19 21:20:52
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema otus
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema otus
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `otus` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `otus` ;

-- -----------------------------------------------------
-- Table `otus`.`marital_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`marital_statuses` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID семейного положения',
  `name` VARCHAR(45) NOT NULL COMMENT 'Наименование',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`genders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`genders` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID пола',
  `name` VARCHAR(45) NOT NULL COMMENT 'Наименование',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`titles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`titles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`customers` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор заказчика',
  `first_name` VARCHAR(254) NULL COMMENT 'Имя',
  `last_name` VARCHAR(254) NULL COMMENT 'Фамилия',
  `birth_date` DATE NULL COMMENT 'Дата рождения',
  `gender_id` INT NULL COMMENT 'ID пола',
  `marital_status_id` INT NULL COMMENT 'ID семейного положения',
  `title_id` INT NULL COMMENT 'ID обращения (г-н, мистер и т.д.)',
  PRIMARY KEY (`id`),
  INDEX `fk_customers_marital_statuses1_idx` (`marital_status_id` ASC)  COMMENT 'Индекс для поиска заказчика по ID семейного положения',
  INDEX `fk_customers_genders1_idx` (`gender_id` ASC)  COMMENT 'Индекс для поиска заказчика по ID пола',
  INDEX `fk_customers_titles1_idx` (`title_id` ASC)  COMMENT 'Индекс для поиска заказчика по ID обращения',
  CONSTRAINT `fk_customers_marital_statuses1`
    FOREIGN KEY (`marital_status_id`)
    REFERENCES `otus`.`marital_statuses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_genders1`
    FOREIGN KEY (`gender_id`)
    REFERENCES `otus`.`genders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_titles1`
    FOREIGN KEY (`title_id`)
    REFERENCES `otus`.`titles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`countries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(2) NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`cities` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID города',
  `name` VARCHAR(45) NOT NULL COMMENT 'Наименование города',
  `country_id` INT NOT NULL COMMENT 'ID страны',
  PRIMARY KEY (`id`),
  INDEX `fk_cities_countries1_idx` (`country_id` ASC)  COMMENT 'Индекс для поиска города по ID страны',
  CONSTRAINT `fk_cities_countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `otus`.`countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`streets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`streets` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID улицы',
  `name` VARCHAR(45) NULL COMMENT 'Наименованеи улицы',
  `city_id` INT NOT NULL COMMENT 'ID города',
  `postal_code` INT NULL COMMENT 'Почтовый индекс',
  PRIMARY KEY (`id`),
  INDEX `fk_streets_cities1_idx` (`city_id` ASC)  COMMENT 'Индекс для поиска улицы по ID города',
  CONSTRAINT `fk_streets_cities1`
    FOREIGN KEY (`city_id`)
    REFERENCES `otus`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`building_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`building_types` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID типа строения ',
  `name` VARCHAR(45) NULL COMMENT 'Наименование',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`buildings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`buildings` (
  `id` BIGINT(8) NOT NULL AUTO_INCREMENT COMMENT 'ID здания (строения)',
  `street_id` INT NULL COMMENT 'ID улицы',
  `number` VARCHAR(45) NULL COMMENT 'Номер дома',
  `floors_count` INT NULL COMMENT 'Кол-во этажей',
  `apartments_count` INT NULL COMMENT 'Кол-во квартир',
  `building_type_id` INT NOT NULL COMMENT 'ID типа строения (здания)',
  PRIMARY KEY (`id`),
  INDEX `fk_buildings_streets1_idx` (`street_id` ASC)  COMMENT 'Индекс для поиска зданий по ID улицы',
  INDEX `fk_buildings_building_types1_idx` (`building_type_id` ASC)  COMMENT 'Индекс для поиска зданий по ID типа',
  CONSTRAINT `fk_buildings_streets1`
    FOREIGN KEY (`street_id`)
    REFERENCES `otus`.`streets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_buildings_building_types1`
    FOREIGN KEY (`building_type_id`)
    REFERENCES `otus`.`building_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID категории',
  `name` VARCHAR(45) NOT NULL,
  `parent_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_categories_categories1_idx` (`parent_id` ASC),
  UNIQUE INDEX `parent_id_name` (`name` ASC, `parent_id` ASC),
  CONSTRAINT `fk_categories_categories1`
    FOREIGN KEY (`parent_id`)
    REFERENCES `otus`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`manufacturers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`manufacturers` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID производителя',
  `name` VARCHAR(45) NULL COMMENT 'Наименование',
  `building_id` BIGINT(8) NULL COMMENT 'ID строения (здания)',
  PRIMARY KEY (`id`),
  INDEX `fk_manufacturers_buildings1_idx` (`building_id` ASC)  COMMENT 'Индекс для поиска заказчика по ID здания',
  CONSTRAINT `fk_manufacturers_buildings1`
    FOREIGN KEY (`building_id`)
    REFERENCES `otus`.`buildings` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`products` (
  `id` BIGINT(8) NOT NULL AUTO_INCREMENT COMMENT 'ID продукта',
  `name` VARCHAR(254) NOT NULL COMMENT 'Наименование',
  `category_id` INT NOT NULL COMMENT 'ID категории',
  `manufacturer_id` INT NOT NULL COMMENT 'ID производителя',
  `description` TEXT NULL,
  `properties` JSON COMMENT 'Характеристики товара',
  PRIMARY KEY (`id`),
  INDEX `fk_products_categories1_idx` (`category_id` ASC)  COMMENT 'Индекс для поиска продукта по ID категории',
  INDEX `fk_products_manufacturers1_idx` (`manufacturer_id` ASC)  COMMENT 'Индекс для поиска продукта по ID производителя',
  CONSTRAINT `fk_products_categories1`
    FOREIGN KEY (`category_id`)
    REFERENCES `otus`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_manufacturers1`
    FOREIGN KEY (`manufacturer_id`)
    REFERENCES `otus`.`manufacturers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
PACK_KEYS = DEFAULT;


-- -----------------------------------------------------
-- Table `otus`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`suppliers` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID поставщика',
  `name` VARCHAR(45) NOT NULL COMMENT 'Наименование',
  `building_id` BIGINT(8) NULL COMMENT 'ID строения (здания)',
  PRIMARY KEY (`id`),
  INDEX `fk_suppliers_buildings1_idx` (`building_id` ASC)  COMMENT 'Индекс для поиска поставщика по ID здания (по адресу)',
  CONSTRAINT `fk_suppliers_buildings1`
    FOREIGN KEY (`building_id`)
    REFERENCES `otus`.`buildings` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`currencies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`currencies` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID валюты',
  `name` VARCHAR(45) NOT NULL COMMENT 'Наименование',
  `designation` VARCHAR(3) NOT NULL COMMENT 'Обозначение',
  `weight_coefficient` FLOAT UNSIGNED NULL COMMENT 'Весовой коэффициент (для конвертации курса)',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `designation_UNIQUE` (`designation` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`receipts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`receipts` (
  `id` BIGINT(8) NOT NULL AUTO_INCREMENT COMMENT 'ID поступления товара',
  `product_id` BIGINT(8) NOT NULL COMMENT 'ID поступления товара',
  `supplier_id` INT NOT NULL COMMENT 'ID поставщика',
  `date` DATETIME NOT NULL COMMENT 'Дата и время поставки',
  `count` INT UNSIGNED NOT NULL COMMENT 'Кол-во поставленного товара',
  `price` DECIMAL(10,2) UNSIGNED NOT NULL COMMENT 'Цена поставленного товара (за 1 ед)',
  `currency_id` INT NOT NULL COMMENT 'ID валюты',
  PRIMARY KEY (`id`),
  INDEX `fk_receipts_products1_idx` (`product_id` ASC)  COMMENT 'Индекс для поиска поставки по ID продукта',
  INDEX `fk_receipts_currencies1_idx` (`currency_id` ASC)  COMMENT 'Индекс для поиска поставки по ID валюты',
  INDEX `fk_receipts_suppliers1_idx` (`supplier_id` ASC)  COMMENT 'Индекс для поиска поставки по ID поставщика',
  CONSTRAINT `fk_receipts_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `otus`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_receipts_currencies1`
    FOREIGN KEY (`currency_id`)
    REFERENCES `otus`.`currencies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_receipts_suppliers1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `otus`.`suppliers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`prices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`prices` (
  `id` BIGINT(8) NOT NULL AUTO_INCREMENT COMMENT 'ID цены',
  `product_id` BIGINT(8) NOT NULL COMMENT 'ID продукта',
  `date` DATETIME NOT NULL COMMENT 'Дата применения цены',
  `price` DECIMAL(10,2) UNSIGNED NOT NULL COMMENT 'Цена за одну единицу',
  `currency_id` INT NOT NULL COMMENT 'ID валюты',
  PRIMARY KEY (`id`),
  INDEX `fk_prices_products1_idx` (`product_id` ASC)  COMMENT 'Индекс для ускорения опредления цены продукта (поиска цены для данного товара)',
  INDEX `fk_prices_currencies1_idx` (`currency_id` ASC)  COMMENT 'Индекс для поиска цены по ID валюты',
  CONSTRAINT `fk_prices_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `otus`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prices_currencies1`
    FOREIGN KEY (`currency_id`)
    REFERENCES `otus`.`currencies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`order_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`order_statuses` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID статуса покупки',
  `name` VARCHAR(45) NOT NULL COMMENT 'Наименование',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`languages` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'ID языка',
  `code` VARCHAR(2) NULL COMMENT 'Обозначение (en, ru и т.д.)',
  `name` VARCHAR(45) NULL COMMENT 'Наименование языка',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otus`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otus`.`orders` (
  `id` BIGINT(8) NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL COMMENT 'ID заказчика',
  `product_id` BIGINT(8) NOT NULL COMMENT 'ID продукта',
  `price_id` BIGINT(8) NOT NULL COMMENT 'ID стоимости',
  `count` INT UNSIGNED NOT NULL COMMENT 'Кол-во товара',
  `order_status_id` INT NOT NULL COMMENT 'ID статуса покупки',
  `building_id` INT NULL COMMENT 'Адрес заказчика (адрес доставки)',
  `language_id` INT NULL COMMENT 'ID языка на котором сделан заказ',
  `date` DATETIME NOT NULL COMMENT 'Дата заказа',
  PRIMARY KEY (`id`, `date`),
  INDEX `fk_orders_products1_idx` (`product_id` ASC)  COMMENT 'Индекс для поиска заказов для отдельных продуктов (или группировки по product_id)',
  INDEX `fk_orders_prices1_idx` (`price_id` ASC)  COMMENT 'Индекс для поиска заказов по ID цены',
  INDEX `fk_orders_customers1_idx` (`customer_id` ASC)  COMMENT 'Индекс для поиска заказов по ID заказчика',
  INDEX `fk_orders_order_statuses1_idx` (`order_status_id` ASC)  COMMENT 'Индекс для поиска заказов с определенным статусом',
  INDEX `fk_orders_buildings1_idx` (`building_id` ASC)  COMMENT 'Индекс для поиска заказов по ID здания (адресу доставки)',
  INDEX `fk_orders_languages1_idx` (`language_id` ASC)  COMMENT 'Индекс для поиска заказов по ID языка')
ENGINE = InnoDB
PARTITION BY RANGE (YEAR(date)) (
  PARTITION p2018 VALUES LESS THAN (2018),
  PARTITION p2019 VALUES LESS THAN (2019),
  PARTITION p2020 VALUES LESS THAN (2020),
  PARTITION pMAX VALUES LESS THAN MAXVALUE
);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Test data

INSERT INTO countries (code, name) VALUES ('RU', 'Россия'), ('PL', 'Польша'), ('TK', 'Токелау');

INSERT INTO cities (name, country_id) VALUES ('Москва', 1), ('Санкт-Петербург', 1), ('Варшрава', 2);

INSERT INTO streets (name, city_id, postal_code) VALUES ('1-ая Московская', 1, 123456), ('2-ая Московская', 2, 123457), ('3-я Московская', 1, 123458), ('Первая', 2, 223458), ('Вторая', 2, 223459);

INSERT INTO building_types (name) VALUES ('Частный дом'), ('Многоквартирный дом');

INSERT INTO buildings (street_id, number, building_type_ID) VALUES (1, '1a', 1), (2, '1/2', 1), (2, '1/3', 2), (3, 1, 1), (3, 2, 2), (3, 3, 2);

INSERT INTO currencies (name, designation, weight_coefficient) VALUES ('Российский рубль', 'RUR', 1), ('Американский доллар', 'USD', 65);

INSERT INTO manufacturers (name, building_id) VALUES ('Apple', 1), ('Samsung', 2), ('НПО Электроника', 3);

INSERT INTO categories (name, parent_id) VALUES ('Электроника', null), ('Бытовая техника', null), ('Смартфоны', 1), ('Телевизоры', 1);

INSERT INTO products (name, category_id, manufacturer_id, description) VALUES ('Смартфон 1', 3, 1, 'Отличный смартфон 1'), ('Смартфон 2', 3, 2, 'Отличный смартфон 2'), ('Смартфон 3', 3, 1, 'Отличный смартфон 3');

INSERT INTO prices (product_id, date, price, currency_id) VALUES (1, NOW(), 100, 1), (2, NOW(), 200, 1),  (3, NOW(), 10, 2);

INSERT INTO genders (name) VALUES ('мужской'), ('женский');

INSERT INTO marital_statuses (name) VALUES ('женат'), ('за мужем'), ('не женат'), ('не замужем');

INSERT INTO titles (name) VALUES ('Господин'), ('Госпожа'), ('Товарищ');

INSERT INTO languages(code, name) VALUES ('ru', 'Русский'), ('en', 'Английский');

INSERT INTO order_statuses (name) VALUES ('Создан'), ('Оплачен'), ('Отменен'), ('Завершён');