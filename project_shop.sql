/* База данных интернет- магазина по продаже сетевого оборудования. 
Сначала создаю каталог с товарами, скидками на группы товаров, наполняю сайт новостями, пользователями, сообщениями друг другу и в поодержку, лайками новостей, заказами. 
Добавляю счета пользователей и транзакции. Создаю таблицу с логами, чтобы отслеживать изменения. 
Также добавила просмотр статистики по новостям и товарам в категориях.
*/

DROP DATABASE IF EXISTS project_shop;
CREATE DATABASE project_shop;
USE project_shop;


-- Добавляю разделы каталога
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(120) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs (`name`) VALUES
('Антенны'),
('Базовые станции'),
('Блоки питания сменные'),
('Всенаправленные Wi-Fi антенны'),
('Кабели питания'),
('Кабели прямого подключения'),
('Коннекторы'),
('Контроллеры Wi-Fi'),
('Маршрутизаторы для дома и офиса'),
('Медиаконвертеры'),
('Профессиональные Wi-Fi системы'),
('Радиоустройства'),
('Секторные Wi-Fi антенны'),
('Точки доступа Wi-Fi'),
('Трансиверы SFP'),
('Узконаправленные Wi-Fi антенны'),
('Управляемые коммутаторы')
;
SELECT * FROM catalogs;

-- Напомляю таблицу товарами
DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  value INT UNSIGNED COMMENT 'Количество',
  catalog_id BIGINT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (catalog_id) REFERENCES catalogs(id)
) COMMENT = 'Товары';

INSERT INTO products (name, desription, price, value, catalog_id) VALUES
('Ubiquiti UniFi 6 AP Long Range', 'Точка доступа 2.4+5 ГГц, ac Wave2, Wi-Fi 6, 4х4 MU-MIMO, 802.3at, 1х 1G RJ45', '17200', '0', '11'),
('Ubiquiti UniFi 6 AP Lite', 'Точка доступа 2.4+5 ГГц, ac Wave2, Wi-Fi 6, 2х2 MU-MIMO, 802.3af, 1х 1G RJ45', '9370', '0', '11'),
('MikroTik Wireless Wire Cube', 'Радиомост 60+5 ГГц, 2 Гбит/с, TDD, 800 м', '19190', '0', '12'),
('MikroTik Cube 60G ac', 'Радиоустройство 60+5 ГГц, CPE', '9590', '0', '12'),
('MikroTik mANT30 PA (4-pack)', '4 антенны 5 ГГц, MIMO 2x2, 30 дБи', '41180', '1', '16'),
('MikroTik SFP28 1m direct attach cable', 'Патчкорд SFP/SFP+/SFP28 длиной 1 м', '2364', '89', '6'),
('MikroTik SFP28 3m direct attach cable', 'Патчкорд SFP/SFP+/SFP28 длиной 3 м', '3100', '0', '6'),
('MikroTik wAP ac', 'Wi-Fi маршрутизатор, 2,4+5 ГГц (a/b/g/n/ac), 2х 1G Ethernet, MIMO 2x2', '7010', '0', '11'),
('MikroTik wAP ac BE', 'Wi-Fi маршрутизатор, 2,4+5 ГГц (a/b/g/n/ac), 2х 1G Ethernet, MIMO 2x2', '7340', '100', '11'),
('Ubiquiti GigaBeam Long Range', 'Радиоустройство 60 ГГц (с резервированием 5 ГГц), airMAX ac, 38/11 дБи', '20120', '0', '12'),
('Ubiquiti airFiber 60 LR', 'РРС 60 ГГц, 1.8 Гбит/с, со встроенной антенной 38 дБи', '37460', '0', '12'),
('Ubiquiti UniFi WiFi BaseStation XG', 'Точка доступа 3х5 ГГц, ac Wave2, 4х4 MU-MIMO, 802.3bt, 1х 1G RJ45, 1х 10G ICM Ethernet', '123980', '0', '11'),
('Ubiquiti UniFi Switch Flex Mini', 'Коммутатор, 5х 1G RJ45', '2830', '32', '17'),
('Ubiquiti airFiber 60', 'РРС 60 ГГц (с резервированием 5 ГГц), 1.8 Гбит/с, со встроенной антенной 38 дБи', '27930', '0', '12'),
('MikroTik CRS326-24G-2S+IN', 'Kоммутатор, 24х 1G RJ45, 2x SFP+, SwOS / RouterOS', '15350', '56', '17'),
('MikroTik Wireless Wire nRAY', 'Радиомост 60 ГГц, 2 Гбит/с, TDD, 1,5 км', '23690', '0', '12'),
('MikroTik hAP ac³', 'Wi-Fi маршрутизатор, 2,4+5 ГГц (a/b/g/n/ac), 5x 1G RJ45, MIMO 2x2, USB, раздача PoE', '7900', '0', '14'),
('MikroTik mANTBox 52 15s', 'Базовая станция, 2,4+5 ГГц (a/b/g/n/ac), 12 дБи (2,4 ГГц), 15 дБи (5 ГГц), SFP', '12550', '0', '12'),
('Ubiquiti LTU Rocket', 'Базовая станция для радиосети LTU, 5 ГГц, PtMP, MIMO 2х2, 29 дБм, 2x RP‑SMA, GPS Sync', '35060', '22', '12'),
('Ubiquiti LTU Pro', 'Абонентское устройство для радиосети LTU, 5 ГГц, MIMO 2x2, 24 дБи, 22 дБм, до 25 км', '16300', '28', '12'),
('Ubiquiti LTU Lite', 'Абонентское устройство для радиосети LTU, 5 ГГц, MIMO 2x2, 13 дБи, 22 дБм, до 10 км', '8710', '381', '12'),
('MikroTik Cube Lite60', 'Радиоустройство 60 ГГц, CPE', '5420', '170', '12'),
('Ubiquiti UniFi Building-to-Building Bridge', 'Комплект для небольшого радиомоста 60 ГГц (с резервированием 5 ГГц)', '45020', '15', '11'),
('Ubiquiti UniFi Dream Machine', 'Многофункциональное устройство, объединяющее маршрутизатор, точку доступа Wi-Fi, коммутатор и контроллер', '28710', '42', '11'),
('Ubiquiti UniFi Direct Attach Cable SFP+ 0.5 m', 'Патч-корд SFP+ длиной 0.5 м', '1550', '46', '6'),
('Ubiquiti UniFi Direct Attach Cable SFP28 0.5 m', 'Патч-корд SFP28 длиной 0.5 м', '2830', '94', '6'),
('Ubiquiti Rocket 2AC Prism', 'Радиоустройство 2.4 ГГц, PtP/PtMP, airMAX ac, 2x RP-SMA, фильтры airPrism, GPS Sync', '17490', '0', '12'),
('Ubiquiti airFiber 11', 'РРС 11 ГГц, 1.2 Гбит/с, FDD, без антенны (поставляется отдельно), 2x N-type', '92620', '1', '12'),
('Ubiquiti airFiber 11 Complete High-Band', 'РРС 11 ГГц, 1.2 Гбит/с, FDD, с антенной 35 дБи и дуплексером верхнего диапазона', '145390', '7', '12'),
('Ubiquiti airFiber 11 Complete Low-Band', 'РРС 11 ГГц, 1.2 Гбит/с, FDD, с антенной 35 дБи и дуплексером нижнего диапазона', '145390', '6', '12'),
('MikroTik HGO-antenna-OUT', 'Всенаправленная антенна, 2.4/5 ГГц, 3/6 дБи, RP-SMA (male)', '890', '18', '4'),
('MikroTik Q+DA0001', 'Патч-корд QSFP+ длиной 1 м', '2382', '20', '6'),
('MikroTik Q+BC0003-S+', 'Кабель для разводки QSFP+ на 4х SFP+, 3 м', '4268', '13', '6'),
('MikroTik GB60A-S12', 'Внутренний блок питания (12 В, 5 А) для линейки CCR1016 (r2)', '2290', '10', '3'),
('MikroTik UP1302C-12', 'Внутренний блок питания (12 В, 10,8 А) для линейки CCR1036 (r2)', '3050', '10', '3'),
('Ubiquiti UniFi AP AC SHD', 'Точка доступа 2.4+5 ГГц, ac Wave2, 4х4 MU-MIMO, 802.3at, 2х 1G Ethernet', '38380', '2', '11'),
('MikroTik Audience LTE6 kit', 'Mesh-маршрутизатор, 3 диапазона, Wi-Fi + LTE, 802.11ac, micro-SIM, miniPCI-e', '21990', '18', '14'),
('MikroTik Audience', 'Mesh-маршрутизатор, 3 диапазона, 802.11ac', '13320', '47', '14'),
('MikroTik PW48V-12V85W', 'Блок питания для CCR бескорпусный', '3990', '3', '3'),
('MikroTik Antenna MTAO-2/5G-6', 'Всенаправленная антенна 2.4/5 ГГц, 6/8 дБи, N-type', '1110', '0', '4'),
('Ubiquiti AmpliFi Gamer’s Edition', 'Wi-Fi система 2.4+5 ГГц, 5.25 Гбит/с, MIMO 3x3, 1858 м²', '35420', '0', '14'),
('Ubiquiti UFiber ActiveEthernet', 'Медиаконвертер SFP-RJ45', '2490', '0', '10'),
('MikroTik S+AO0005', 'Патч-корд SFP+ длиной 5 м', '4123', '31', '6'),
('Ubiquiti AmpliFi Instant', 'Wi-Fi система 2.4+5 ГГц, 2.334 Гбит/с, MIMO 2x2, 371.6 м²', '16260', '21', '14'),
('Ubiquiti AmpliFi Instant Router', 'Wi-Fi маршрутизатор 2.4+5 ГГц, 1.167 Гбит/с, 22 дБм, 185.8 м²', '8930', '65', '14'),
('MikroTik S-C47DLC40D', 'Трансивер SFP CWDM, Single Mode, 40 км, 1470 нм, Dual LC, DDM', '3910', '13', '15'),
('Ubiquiti UniFi AP AC Pro (3-pack)', '3 точки доступа 2.4+5 ГГц, 802.11a/b/g/n/ac, MIMO 3x3, 2x 1G Ethernet, 802.3af/at', '35280', '4', '11'),
('MikroTik S-C49DLC40D', 'Трансивер SFP CWDM, Single Mode, 40 км, 1490 нм, Dual LC, DDM', '2710', '9', '15'),
('MikroTik S-C51DLC40D', 'Трансивер SFP CWDM, Single Mode, 40 км, 1510 нм, Dual LC, DDM', '2710', '0', '15'),
('MikroTik S-C53DLC40D', 'Трансивер SFP CWDM, Single Mode, 40 км, 1530 нм, Dual LC, DDM', '2710', '16', '15'),
('MikroTik S-C55DLC40D', 'Трансивер SFP CWDM, Single Mode, 40 км, 1550 нм, Dual LC, DDM', '2710', '0', '15'),
('MikroTik S-C57DLC40D', 'Трансивер SFP CWDM, Single Mode, 40 км, 1570 нм, Dual LC, DDM', '2710', '14', '15'),
('MikroTik S-C59DLC40D', 'Трансивер SFP CWDM, Single Mode, 40 км, 1590 нм, Dual LC, DDM', '2710', '0', '15'),
('MikroTik S-C61DLC40D', 'Трансивер SFP CWDM, Single Mode, 40 км, 1610 нм, Dual LC, DDM', '2710', '12', '15'),
('MikroTik RB4011iGS+5HacQ2HnD-IN', 'Wi-Fi маршрутизатор 2.4+5 ГГц (a/b/g/n/ac), 4 ядра (1.4 ГГц), 10х 1G RJ45, SFP+, miniPCI-e, раздача PoE', '20180', '136', '14'),
('Ubiquiti UniFi Cloud Key Gen2', 'Контроллер для сети UniFi', '16090', '1', '8'),
('Ubiquiti UniFi AP In-Wall HD', 'Точка доступа 2.4+5 ГГц, ac Wave2, 4х4 MU-MIMO, 5х 1G RJ45, 802.3at/af', '15280', '0', '11'),
('Ubiquiti UniFi Cloud Key Gen2 Plus', 'Контроллер для сети UniFi', '18010', '43', '8'),
('Ubiquiti EdgeRouter 12', 'Маршрутизатор 4 ядра (1 ГГц), 10х 1G RJ45, 2х SFP, раздача PoE', '20890', '1', '9'),
('MikroTik ACGPSA', 'Внешняя GPS-антенна для LtAP mini', '740', '29', '1'),
('MikroTik mANT LTE 5o', 'LTE-антенна 699 - 2690 МГц, 5 дБи, MIMO 2x2, 2x SMA', '1480', '0', '1'),
('Ubiquiti UniFi WiFi BaseStation XG (Black)', 'Точка доступа 3х5 ГГц, ac Wave2, 4х4 MU-MIMO, 802.3bt, 1х 1G RJ45, 1х 10G ICM Ethernet', '123980', '0', '11'),
('MikroTik hEX S', 'Маршрутизатор 2 ядра (880 МГц), 5х 1G RJ45, SFP, USB, MicroSD, раздача PoE', '5420', '371', '9'),
('Ubiquiti Horn 5-30', 'Рупорная антенна 5 ГГц, 19 дБи, 30°', '6800', '0', '13'),
('Ubiquiti Horn 5-45', 'Рупорная антенна 5 ГГц, 15 дБи, 45°', '6640', '13', '13'),
('Ubiquiti Horn 5-60', 'Рупорная антенна 5 ГГц, 16 дБи, 60°', '6690', '0', '13'),
('Ubiquiti Horn 5-90', 'Рупорная антенна 5 ГГц, 13 дБи, 90°', '6640', '0', '13'),
('MikroTik cAP ac', 'Точка доступа 2.4+5 ГГц, 802.11a/b/g/n/ac, 26 дБм, MIMO 2x2, 802.3af/at', '5410', '680', '11'),
('MikroTik hAP ac²', 'Wi-Fi маршрутизатор 2.4+5 ГГц MIMO 2х2', '5420', '3', '14'),
('MikroTik 24V2APOW', 'Ремонтный блок питания CCR/CRS', '1400', '1', '3'),
('MikroTik PW48V-12V150W', 'Модуль питания DC-DC для CCR1072', '7900', '3', '3'),
('MikroTik 12POW150', 'Модуль питания AC-DC для CCR1072', '7900', '12', '3'),
('MikroTik 24V4APOW', 'Ремонтный блок питания CCR', '2290', '10', '3'),
('Ubiquiti UniFi Mesh Antenna Dual-Band', 'Антенна 2.4+5 ГГц для UAP-AC-M, 10/15 дБи', '8120', '18', '13'),
('Ubiquiti EdgeRouter 4', 'Маршрутизатор 4 ядра (1 ГГц), 3х 1G RJ45, 1х SFP', '16380', '11', '9'),
('Ubiquiti PowerModule 100W AC', 'Модуль питания AC-DC', '5900', '10', '3'),
('Ubiquiti PowerModule 100W DC', 'Модуль питания DC-DC', '7600', '6', '3'),
('Ubiquiti UniFi Direct Attach Copper Cable SFP+ 1m', 'Патч-корд SFP+ длиной 1 м', '1620', '41', '6'),
('Ubiquiti UniFi Direct Attach Copper Cable SFP+ 2m', 'Патч-корд SFP+ длиной 2 м', '1990', '35', '6'),
('Ubiquiti UniFi Direct Attach Copper Cable SFP+ 3m', 'Патч-корд SFP+ длиной 3 м', '2370', '20', '6'),
('MikroTik hAP mini', 'Wi-Fi мини-маршрутизатор 2.4 ГГц, 802.11b/g/n, 2х LAN, 1х WAN', '1570', '0', '14'),
('Ubiquiti EdgePower 54V 150W DC', 'Модуль питания DC-DC для EdgePower', '6570', '7', '3'),
('Ubiquiti EdgePower 54V 150W AC', 'Модуль питания AC-DC для EdgePower', '6570', '9', '3'),
('Ubiquiti AmpliFi HD Router', 'Wi-Fi маршрутизатор 2.4+5 ГГц, 1.75 Гбит/с, 26 дБм', '12470', '189', '14'),
('Ubiquiti AmpliFi HD Point', 'Mesh-точка доступа 2.4+5 ГГц, 1.75 Гбит/с, 26 дБм', '10700', '331', '14'),
('MikroTik mANT30 (4-pack)', 'Комплект из 4 антенн 5 ГГц, 30 дБи', '36600', '0', '16'),
('MikroTik hEX', 'Маршрутизатор 2 ядра (880 МГц), 5х 1G RJ45', '4720', '235', '9'),
('Ubiquiti AmpliFi HD', 'Wi-Fi система 2.4+5 ГГц, 5.25 Гбит/с, MIMO 3x3, 1858 м²', '31690', '125', '14'),
('Ubiquiti airFiber 11G-35', 'Антенна для использования с airFiber 11X', '38460', '0', '16'),
('MikroTik hAP ac lite TC', 'Wi-Fi маршрутизатор, 2.4+5 ГГц AC', '3950', '514', '14'),
('Ubiquiti UniFi Switch 24', 'Коммутатор в стойку, 24х 1G RJ45, 2х SFP', '18010', '0', '17'),
('Ubiquiti UniFi Switch 48', 'Коммутатор в стойку, 48х 1G RJ45, 2х SFP, 2х SFP+, 1х RJ45', '34830', '2', '17'),
('Ubiquiti EdgeSwitch 8-150W', 'PoE-коммутатор, 8х 1G RJ45, 2х SFP, раздача 130 Вт', '18040', '7', '17'),
('Ubiquiti UniFi Switch 8-150W', 'PoE-коммутатор, 8х 1G RJ45, 2х SFP, раздача 130 Вт', '19528', '8', '17'),
('Ubiquiti UniFi Switch 16-150W', 'PoE-коммутатор в стойку, 16х 1G RJ45, 2х SFP, раздача 122 Вт', '28591', '4', '17'),
('MikroTik mAP', 'Wi-Fi мини-маршрутизатор 2.4 ГГц (b/g/n), MIMO 2x2, 2x RJ45, microUSB, PoE-питание и раздача', '3550', '330', '14'),
('Nikomax Коннектор Cat.5e неэкранированный', '100 шт., золотое покрытие 50 мкд', '1190', '13', '7'),
('Nikomax Коннектор Cat.5e экранированный', '100 шт., золотое покрытие 50 мкд', '2610', '4', '7'),
('Nikomax Коннектор Cat.6 неэкранированный', '100 шт., золотое покрытие 50 мкд', '1890', '4', '7'),
('Ubiquiti EdgeSwitch 12 Fiber', 'Коммутатор в стойку, 12x SFP, 4х 1G RJ45', '18130', '7', '17'),
('MikroTik mAP lite', 'Мини-точка доступа 2.4 ГГц, 1x RJ45, 802.3af/at', '2030', '37', '14'),
('MikroTik hAP lite TC', 'Wi-Fi маршрутизатор 2.4 ГГц, 802.11b/g/n, 22 дБм, MIMO 2x2, 4х Ethernet', '1848', '400', '14'),
('Ubiquiti EdgeSwitch 16-150W', 'PoE-коммутатор в стойку, 16х 1G RJ45, 2х SFP, раздача 122 Вт', '26550', '20', '17'),
('Ubiquiti LiteBeam 5AC-16-120', 'Радиоустройство 5 ГГц, PtP/PtMP, airMAX ac, MIMO 2х2, 16 дБи, 30+ км', '7370', '0', '12'),
('Ubiquiti NanoBeam 5AC-16', 'Радиоустройство 5 ГГц, PtP/PtMP, airMAX ac, MIMO 2x2, 16 дБи, 26 дБм', '6640', '0', '12'),
('MikroTik mANT 15s', 'Секторная антенна 5 ГГц, 15 дБи, 120°', '3990', '8', '13'),
('MikroTik mANT 19s', 'Секторная антенна 5 ГГц, 19 дБи, 120°', '7970', '0', '13'),
('Ubiquiti LiteBeam 5AC-23', 'Радиоустройство 5 ГГц, PtP/CPE, airMAX ac, MIMO 2х2, 23 дБи, 30+ км', '5020', '0', '12'),
('Ubiquiti Rocket 5AC PRISM', 'Радиоустройство 5 ГГц, PtMP/PtP, airMAX ac, 2x RP-SMA, фильтры airPrism, GPS Sync', '18490', '0', '12'),
('Ubiquiti EdgePoint S16', 'PoE-коммутатор, 16х 1G RJ45, 2x SFP+, раздача Passive PoE, уличный корпус', '41700', '4', '17'),
('Ubiquiti UniFi Cloud Key', 'Контроллер для сети UniFi', '7377', '29', '8'),
('Ubiquiti airPrism Sector 5AC-90-HD', 'Секторная антенна для PtMP, 5 ГГц, 22 дБи, 3x30°', '40400', '0', '13'),
('MikroTik SXT 5', 'Радиомаршрутизатор 5 ГГц, 802.11a/n, 31 дБм, MIMO 2x2, 1.25 Вт, 1х Ethernet', '5830', '0', '12'),
('Ubiquiti LiteBeam M5-23', 'Радиоустройство 5 ГГц, PtP/CPE, airMAX, SISO, 23 дБи, 30+ км', '4150', '0', '12'),
('Ubiquiti EdgeSwitch 24 Lite', 'Коммутатор в стойку, 24х 1G RJ45, 2x SFP', '18050', '22', '17'),
('Ubiquiti EdgeSwitch 48 Lite', 'Коммутатор в стойку, 48х 1G RJ45, 2x SFP, 2x SFP+', '34860', '21', '17'),
('Ubiquiti airFiber 2X', 'РРС 2.4 ГГц, 687 Мбит/с, Hybrid TDD, без антенны (поставляется отдельно), 2x RP‑SMA', '43390', '3', '12'),
('Ubiquiti airFiber 3X', 'РРС 3.5 ГГц, 687 Мбит/с, Hybrid TDD, без антенны (поставляется отдельно), 2x RP-SMA', '68780', '4', '12'),
('Ubiquiti airFiber 3G-26-S45', 'Антенна 3 ГГц для airFiber 3X, 26 дБи', '24280', '3', '16'),
('Ubiquiti airFiber 2G-24-S45', 'Антенна 2.4 ГГц для airFiber 2X, 24 дБи', '18490', '10', '16'),
('Ubiquiti PowerBeam 5AC-300 ISO', 'Радиоустройство 5 ГГц, PtP/CPE, airMAX ac, MIMO 2х2, 22 дБи, 25 дБм', '9520', '0', '12'),
('Ubiquiti PowerBeam 5AC-400 ISO', 'Радиоустройство 5 ГГц, PtP/CPE, airMAX ac, MIMO 2х2, 25 дБи, 25 дБм', '10850', '0', '12'),
('Ubiquiti AirMax AC Sector 5G-21-60-AC', 'Секторная антенна 5 ГГц, 21 дБи, 60°', '16960', '7', '13'),
('MikroTik wAP', 'Точка доступа 2.4 ГГц, 802.11b/g/n, 22 дБм, MIMO 2x2, 802.3af/at', '3610', '142', '11'),
('MikroTik wAP BE', 'Точка доступа 2.4 ГГц, 802.11b/g/n, 22 дБм, MIMO 2x2, 802.3af/at', '3500', '18', '11'),
('Ubiquiti PowerBeam 5AC-300', 'Радиоустройство 5 ГГц, PtP/CPE, airMAX ac, MIMO 2х2, 22 дБи, 25 дБм', '7970', '0', '12'),
('Ubiquiti PowerBeam 5AC-400', 'Радиоустройство 5 ГГц, PtP/CPE, airMAX ac, MIMO 2х2, 25 дБи, 25 дБм', '8930', '0', '12'),
('MikroTik hEX lite', 'Маршрутизатор 850 МГц, 5х RJ45', '3370', '52', '9'),
('Ubiquiti airFiber 5X', 'РРС 5 ГГц, 500 Мбит/с, Hybrid TDD, без антенны (поставляется отдельно), 2x RP‑SMA', '34940', '0', '12'),
('Ubiquiti airFiber 5G-23-S45', 'Антенна 5 ГГц для airFiber 5X, 23 дБи', '9890', '1', '16'),
('Ubiquiti airFiber 5G-30-S45', 'Антенна 5 ГГц для airFiber 5X, 30 дБи', '11510', '0', '16'),
('Ubiquiti airFiber 5G-34-S45', 'Антенна 5 ГГц для airFiber 5X, 34 дБи', '32580', '0', '16'),
('MikroTik hAP lite', 'Wi-Fi маршрутизатор 2.4 ГГц, 4х Ethernet, 802.11b/g/n, MIMO 2х2', '1790', '759', '14'),
('MikroTik hAP', 'Wi-Fi маршрутизатор 2.4 ГГц, 802.11b/g/n, MIMO 2x2, 22 дБм, 5х Ethernet, раздача PoE', '3490', '679', '14'),
('MikroTik hAP ac Lite', 'Wi-Fi маршрутизатор 2.4+5 ГГц, MIMO 2x2, 5x Ethernet', '4087', '587', '14'),
('MikroTik hAP ac', 'Wi-Fi маршрутизатор 2.4+5 ГГц, 802.11a/b/g/n/ac, MIMO 3x3, 5x Gigabit Ethernet, 1x SFP', '10526', '315', '14'),
('MikroTik CRS112-8G-4S-IN', 'Коммутатор, 8х 1G RJ45, 4x SFP, RouterOS', '10920', '0', '17'),
('MikroTik QRT 5 ac', 'Точка доступа 5 ГГц, 802.11ac, 30 дБм, 1х 1G Ethernet', '15680', '32', '12'),
('MikroTik SXT HG5 ac', 'Радиомаршрутизатор 5 ГГц, 802.11a/n/ac, 31 дБм, MIMO 2x2, 1х 1G Ethernet', '9230', '0', '12'),
('MikroTik DynaDish 5', 'Точка доступа 5 ГГц, 802.11ac, MIMO 2x2, 720 МГц, 25 дБи, 802.3af/at', '12550', '25', '12'),
('Ubiquiti EdgeRouter X', 'Маршрутизатор 2 ядра (880 МГц), 5x 1G RJ45, раздача PoE', '4400', '0', '9'),
('Ubiquiti EdgeRouter X SFP', 'PoE-маршрутизатор 2 ядра (880 МГц), 5x 1G RJ45, 1x SFP, раздача PoE', '6650', '0', '9'),
('Ubiquiti UniFi Switch 24-250W', 'PoE-коммутатор в стойку, 24х 1G RJ45, 2х SFP, раздача 220 Вт', '36110', '56', '17'),
('Ubiquiti UniFi Switch 48-500W', 'PoE-коммутатор в стойку, 48х 1G RJ45, 2х SFP, 2х SFP+, раздача 436 Вт', '71590', '1', '17'),
('Ubiquiti UniFi Switch 48-750W', 'PoE-коммутатор в стойку, 48х 1G RJ45, 2х SFP, 2х SFP+, раздача 686 Вт', '87380', '0', '17'),
('Ubiquiti UniFi Switch 24-500W', 'PoE-коммутатор в стойку, 24х 1G RJ45, 2х SFP, раздача 470 Вт', '49080', '0', '17'),
('MikroTik RBMRTGx2', 'Маршрутизатор 500 МГц, 5x 1G RJ45, 1x DB9, 1х microSD', '11810', '0', '9'),
('MikroTik CRS210-8G-2S+IN', 'Коммутатор настольный/в стойку, 8х 1G RJ45, 2x SFP+, RouterOS', '17710', '0', '17'),
('MikroTik CRS212-1G-10S-1S+IN', 'Коммутатор настольный/в стойку, 10х SFP, 1x SFP+, 1х 1G RJ45, RouterOS', '17270', '0', '17'),
('Ubiquiti RocketDish 5G-30 Light Weight', 'Антенна 5 ГГц, облегченная версия RocketDish 5G30, 30 дБи, 7.5 кг', '9650', '15', '16'),
('Ubiquiti EdgeSwitch 24-250W', 'PoE-коммутатор в стойку, 24х 1G RJ45, 2x SFP, раздача 220 Вт', '36130', '11', '17'),
('Ubiquiti EdgeSwitch 24-500W', 'PoE-коммутатор в стойку, 24х 1G RJ45, 2x SFP, раздача 470 Вт', '49080', '22', '17'),
('Ubiquiti EdgeSwitch 48-500W', 'PoE-коммутатор в стойку, 48х 1G RJ45, 2x SFP, 2x SFP+, раздача 436 Вт', '68780', '2', '17'),
('Ubiquiti EdgeSwitch 48-750W', 'PoE-коммутатор в стойку, 48х 1G RJ45, 2x SFP, 2x SFP+, раздача 686 Вт', '85090', '0', '17'),
('Ubiquiti AirMax AC Sector 5M-21-60-AC', 'AirMax AC Sector 5M-21-60-AC - cекторная антенна для создания базовых станций диапазона 5 ГГц от компании Ubiquiti Networks (UBNT). Разработана для Rocket M5 AC. Усиление антенны 21 дБи. Угол излучения 60°.', '13290', '0', '13'),
('Ubiquiti UniFi Security Gateway', 'Маршрутизатор 2 ядра (500 МГц), 3x 1G RJ45, 1x RJ45', '10040', '49', '9'),
('MikroTik CRS109-8G-1S-2HnD-IN', 'Коммутатор, 8х 1G RJ45, 1x SFP, 1x RJ45, Wi-Fi, RouterOS', '11810', '7', '17'),
('Ubiquiti PowerBridge M10 Dish', 'Антенна для PowerBridge M10. ТОЧКА ДОСТУПА ПОСТАВЛЯЕТСЯ ОТДЕЛЬНО.', '8560', '0', '16'),
('MikroTik cAP 2n', 'Компактное устройство для помещений - встроенная антенна и радиомодуль в небольшом корпусе (185 х 31 мм) с удобной установкой на подвесной потолок или стену.', '3910', '0', '11'),
('MikroTik FTC', 'Медиаконвертер SFP-RJ45, уличный корпус', '3050', '44', '10'),
('Ubiquiti RocketDish 5G-31 AC', 'Антенна 5 ГГц для Rocket 5AC, 31 дБи', '32570', '11', '16'),
('Ubiquiti AirMax AC Sector 5G-22-45-AC', 'Cекторная антенна 5 ГГц, 22 дБи, 45°', '17220', '0', '13'),
('MikroTik RB2011UiAS-2HnD-IN', 'Wi-Fi маршрутизатор 2.4 ГГц (b/g/n), MIMO 2x2, 5х Gigabit Ethernet, 5x Ethernet, 1x SFP', '10150', '0', '14'),
('Ubiquiti UniFi AP AC Outdoor', 'Лучший UniFi для установки вне помещений: 3x3 MIMO, 802.11a/b/g/n/ac, 2.4 + 5 ГГц, два гигабитных порта.', '40220', '0', '11'),
('Ubiquiti UniFi AP AC', 'Мощная точка для дома и офиса - одновременно два диапазона излучения (2.4 и 5 ГГц), суммарно до 1750 Мбит/с на расстоянии до 120 метров.', '12470', '0', '11'),
('Ubiquiti UniFi AP AC (3-pack)', 'Комплект из 3-х точек доступа - одновременно два диапазона излучения (2.4 и 5 ГГц), суммарно до 1750 Мбит/с на расстоянии до 120 метров каждая.', '72690', '0', '11'),
('Ubiquiti TOUGHCable Connectors Grounded 1000 шт.', 'Экранированный коннектор RJ45', '73360', '0', '7'),
('Ubiquiti TOUGHCable Connectors 2400 шт.', 'Экранированный коннектор RJ45 марки Ubiquiti Networks (UBNT). 8 контактов.', '109150', '0', '7'),
('MikroTik mAP 2n', 'Wi-Fi 2.4 ГГц компактный маршрутизатор, который может раздавать PoE-питание на 2 порту (а также питаться сам на 1 порту).', '3470', '7', '14'),
('Ubiquiti TOUGHCable Connectors 100 шт.', 'Экранированный коннектор RJ45 марки Ubiquiti Networks (UBNT). 8 контактов.', '4550', '20', '7'),
('Ubiquiti TOUGHCable Connectors Grounded 20 шт.', 'Экранированный коннектор RJ45', '1480', '29', '7'),
('MikroTik 2.4GHz Dipole', 'Всенаправленная антенна, 2.4 ГГц, 5 дБи', '480', '37', '4'),
('MikroTik SFP+ 1m direct attach cable', 'Патч-корд SFP+ длиной 1 м', '2290', '43', '6'),
('MikroTik SFP+ 3m direct attach cable', 'Патч-корд SFP+ длиной 3 м', '3100', '0', '6'),
('MikroTik CRS226-24G-2S+IN', 'Коммутатор из новой серии Smart Switch на 24 гигабитных порта Ethernet и 2 SFP+.', '23100', '0', '17'),
('MikroTik CRS226-24G-2S+RM', 'Коммутатор в стойку, 24х 1G Ethernet, 2x SFP+', '23760', '0', '17'),
('MikroTik RB260GSP', 'PoE-коммутатор, 5х 1G RJ45, 1x SFP, раздача Passive PoE, SwOS', '4390', '150', '17'),
('MikroTik mANT30', 'Антенна 5 ГГц, 30 дБи, MIMO 2х2, 2х RP-SMA female', '9230', '9', '16'),
('MikroTik mANT30 PA', 'Антенна 5 ГГц, MIMO 2x2, 30 дБи', '10410', '0', '16'),
('MikroTik CRS125-24G-1S-RM', 'Коммутатор 24х Gigabit Ethernet, 1х SFP, 1x microUSB', '15420', '0', '17'),
('MikroTik CRS125-24G-1S-IN', 'Коммутатор, 24х 1G RJ45, 1x SFP, RouterOS', '15350', '0', '17'),
('MikroTik CRS125-24G-1S-2HnD-IN', 'Коммутатор, 24х 1G RJ45, 1x SFP, Wi-Fi, RouterOS', '17270', '0', '17'),
('Ubiquiti AirMax Sector Titanium 5G Mini', 'Секторная антенна 5 ГГц, металлический корпус, 17 дБи, от 60° до 120°', '14430', '0', '13'),
('Ubiquiti UniFi AP Outdoor+', 'Точка доступа 2.4 ГГц, 802.11b/g/n, 28 дБм, 802.3af', '12990', '0', '11'),
('MikroTik RB260GS', 'Коммутатор, 5х 1G RJ45, 1x SFP, SwOS', '3380', '40', '17'),
('MikroTik RB951Ui-2HnD', 'Wi-Fi маршрутизатор 2.4 ГГц, 802.11b/g/n, MIMO 2x2, раздача PoE, 5х Ethernet', '4875', '405', '14'),
('MikroTik RB951G-2HnD', 'Wi-Fi маршрутизатор 2.4 ГГц, 802.11b/g/n, 5x Gigabit Ethernet, 1 Вт', '6300', '334', '14'),
('Ubiquiti EdgeRouter LITE', 'Маршрутизатор 2 ядра (500 МГц), 3х 1G RJ45, 1х RJ45', '8460', '0', '9'),
('Ubiquiti RocketDish 3G-26', 'Параболическая антенна, 3 ГГц, 26 дБи', '20860', '4', '16'),
('Ubiquiti AirMax Sector Titanium 5G', 'Секторная антенна 5 ГГц, металлический корпус, от 60° до 120°', '19680', '0', '13'),
('Ubiquiti Airmax Omni 3G12', 'Всенаправленная MIMO-антенна, 3 ГГц, 12 дБи', '13340', '0', '4'),
('Ubiquiti AirMax Sector 900-120-13', 'Секторная антенна 900 МГц, MIMO 2х2, 13 дБи', '24440', '0', '13'),
('Ubiquiti UniFi AP Outdoor 5', 'Точка доступа 5 ГГц (a/n), до 300 Мбит/с, MIMO 2x2, 27 дБм, PoE-питание', '10920', '0', '11'),
('Ubiquiti AirMax Sector Titanium 2G', 'Секторная антенна 2.4 ГГц, металлический корпус, 17 дБи, от 60° до 120°', '23680', '5', '13'),
('Ubiquiti UniFi AP Pro (3-pack)', '3 точки доступа 2.4+5 ГГц (a/b/g/n), до 750 Мбит/с, MIMO 3х3, 30 дБм, PoE-питание', '53950', '0', '11'),
('MikroTik RB2011UAS-2HnD-IN', 'Самый функциональный Wi-Fi роутер среди MikroTik - 5x Gigabit, 5x Fast Ethernet, SFP, 1Вт 2x2 MIMO 2.4 ГГц Wi-Fi, microUSB, 2 антенны и RouterOS Level 5!', '9960', '0', '14'),
('Ubiquiti UniFi AP Pro', 'Точка доступа 2.4+5 ГГц (a/b/g/n), до 750 Мбит/с, MIMO 3х3, 30 дБм, PoE-питание', '18150', '0', '11'),
('Ubiquiti AirMax Yagi 9M16', 'Мощная антенна 900 МГц, MIMO 2x2, 16 дБи', '16680', '0', '16'),
('Ubiquiti UniFi AP Long Range (3-pack)', '3 точки доступа 2.4 ГГц (b/g/n), до 300 Мбит/с, MIMO 2х2, 27 дБм, PoE-питание', '21400', '0', '11'),
('MikroTik ACSWI', 'Комнатная всенаправленная антенна, 4 дБи', '890', '0', '4'),
('MikroTik ACSWIM', 'Комнатная всенаправленная антенна, 4 дБи', '890', '1', '4'),
('Ubiquiti TOUGHSwitch POE', 'PoE-коммутатор, 5х 1G RJ45, раздача 55 Вт', '7530', '0', '17'),
('Ubiquiti TOUGHSwitch POE Pro', 'PoE-коммутатор, 8х 1G RJ45, раздача 145 Вт', '15650', '0', '17'),
('Ubiquiti TOUGHSwitch POE CARRIER', '2 PoE-коммутатора в стойку в 1 корпусе, 16х 1G RJ45, раздача 23 Вт', '35500', '0', '17'),
('Ubiquiti WiFiStation', 'Wi-Fi адаптер от Ubiquiti Networks (UBNT) диапазона 2.4 ГГц. Поддержка стандартов 802.11 g/n. Усиление 6 дБи. Выходная мощность 30 дБм (1000 мВт).', '1200', '0', '14'),
('Ubiquiti AirRouter HP', 'Wi-Fi маршрутизатор 2.4 ГГц, 802.11 b/g/n, 5x Ethernet', '4980', '0', '14'),
('MikroTik RB951-2n', 'Компактный домашний маршрутизатор - 5 Ethernet-портов и 802.11b/g/n Wi-Fi со встроенной антенной.', '3470', '0', '14'),
('Ubiquiti AirMax Omni 2G13', 'Антенна для базовых станций, 2.4 ГГц, 13 дБи', '20860', '32', '4'),
('Ubiquiti AirMax Omni 5G13', 'Всенаправленная MIMO-антенна для базовых станций, 5 ГГц, 13 дБи', '13670', '0', '4'),
('Ubiquiti WiFiStation EXT', 'Wi-Fi адаптер 2.4 ГГц, 802.11 g/n, 6 дБи, 30 дБм', '1200', '0', '14'),
('MikroTik RB750GL', 'Маршрутизатор, разработанный компанией Mikrotik для высоких сетевых нагрузок. Разработан на чипе Atheros AR7242, 400 МГц - Ethernet. 5x 10/100/1000 Mбит/с Ethernet.', '4650', '0', '9'),
('Ubiquiti UniFi AP Long Range', 'Точка доступа 2.4 ГГц (b/g/n), до 300 Мбит/с, MIMO 2x2, 27 дБм, PoE-питание', '7310', '0', '11'),
('Ubiquiti UniFi AP (3-pack)', '3 точки доступа 2.4 ГГц (b/g/n), до 300 Мбит/с, MIMO 2х2, 20 дБм, PoE-питание', '16340', '0', '11'),
('MikroTik RB751G-2HnD', 'Wi-Fi маршрутизатор для небольшого дома или офиса, 2.4 ГГц. Мощность сигнала 1 Вт!', '4190', '0', '14'),
('MikroTik RB750', 'Маршрутизатор, 5x 10/100 Mbit/s Fast Ethernet.', '3320', '0', '9'),
('MikroTik RB750G', 'Маршрутизатор, 5x 10/100/1000 Mbit/s Ethernet.', '2900', '0', '9'),
('MikroTik RB751U-2HnD', 'Wi-Fi маршрутизатор SOHO, 2.4 ГГц, 802.11n', '3970', '0', '14'),
('Ubiquiti AirMax Sector 3G-18-120', 'Секторная антенна для базовых станций, 3 ГГц, 18 дБи, 120°', '16180', '0', '13'),
('Ubiquiti AirRouter', 'Wi-Fi маршрутизатор 2.4 ГГц, 802.11 b/g/n, 5х Ethernet, 19 дБм', '2880', '0', '14'),
('Ubiquiti PowerAP N', 'Wi-Fi маршрутизатор с двумя съемными внешними антеннами марки. Стандарт 802.11 b/g/n. Диапазон частот 2.4 ГГц. Сетевые порты: 4 LAN (10/100 Mbps), 1 WAN.', '3900', '0', '14'),
('Ubiquiti UniFi AP', 'Точка доступа 2.4 ГГц (b/g/n), до 300 Мбит/с, MIMO 2х2, 20 дБм, PoE-питание', '5630', '0', '11'),
('Ubiquiti UniFi AP Outdoor', 'Версия Unifi для установки вне помещений.', '10920', '0', '11'),
('Ubiquiti RocketDish 5G-30', 'Антенна 5 ГГц, для точки доступа Rocket M5, 30 дБи', '12850', '0', '16'),
('Ubiquiti RocketDish 5G-34', 'Узконаправленная антенна 5 ГГц, для точки доступа Rocket M5, 34 дБи', '30320', '27', '16'),
('MikroTik RB250GS', 'RouterBOARD RB250GS - бюджетный мощный Ethernet коммутатор разработанный компанией Mikrotik. 5x 10/100/1000 Mbit/s Gigabit Ethernet.', '3665', '129', '17'),
('Ubiquiti AirMax Omni 5G10', 'Всенаправленная MIMO-антенна для базовых станций, 5 ГГц, 10 дБи', '10250', '52', '4'),
('Ubiquiti AirMax Omni 2G10', 'Всенаправленная MIMO-антенна для базовых станций, 2.4 ГГц, 10 дБи', '14480', '0', '4'),
('Ubiquiti RocketDish 2G-24', 'Антенна 2.4 ГГц для Rocket M2, 24 дБи', '14690', '9', '16'),
('Ubiquiti AirMax Sector 5G-20-90', 'Секторная антенна 5 ГГц, 20 дБи, 90°', '11660', '0', '13'),
('MikroTik RBMRTG', 'Маршрутизатор 680 МГц, 5x 1G RJ45, 1x DB9, 1х microSD', '10180', '0', '9'),
('Ubiquiti AirMax Sector 2G15-120', 'Секторная антенна для базовых станций, 2.4 ГГц, 16 дБи, 120°', '11760', '17', '13'),
('Ubiquiti AirMax Sector 2G16-90', 'Секторная антенна для базовых станций, 2.4 ГГц, 17 дБи, 90°', '11720', '23', '13'),
('Ubiquiti AirMax Sector 5G-19-120', 'Секторная антенна для базовых станций, 5 ГГц, 19 дБи, 120°', '11690', '1', '13'),
('Ubiquiti AirMax Sector 5G-16-120', 'Секторная антенна для базовых станций, 5 ГГц, 16 дБи, 120°', '6610', '8', '13'),
('Ubiquiti AirMax Sector 5G-17-90', 'Секторная антенна для базовых станций, 5 ГГц, 17 дБи, 90°', '6610', '7', '13'),
('Ubiquiti AirWire', 'AirWire - Plug-n-Play Wi-Fi устройство от компании Ubiquiti Networks (UBNT), предназначенное для замены 10/100 Enternet кабеля беспроводным соединением. Рабочий диапазон - 2.4 ГГц. Усиление Wi-Fi устройства - 6 dBi.', '4650', '0', '14'),
('MikroTik wAP ac', 'Точка доступа 2.4+5 ГГц, 802.11ac, 1х 1G Ethernet', '6990', '3', '11'),
('Ubiquiti UniFi AP AC Long Range (5-pack)', '5 точек доступа 2.4+5 ГГц (ac), до 867 Мбит/с, MIMO 3х3, 24 дБм, PoE-питание', '9833', '30', '11'),
('Ubiquiti UniFi AP NanoHD', 'Точка доступа 2.4+5 ГГц, ac Wave2, 4х4 MU-MIMO, 802.3af, 1х 1G Ethernet', '13100', '0', '11'),
('Cambium cnMatrix EX1028, Switch', 'Умный управляемый коммутатор.', '71495', '30', '17'),
('Cambium cnMatrix EX1028-P, PoE Switch', 'Умный управляемый коммутатор.', '103490', '30', '17'),
('Cambium cnMatrix EX1010, Switch', 'Умный управляемый коммутатор.', '39500', '30', '17'),
('Cambium cnMatrix EX1010-P, PoE Switch', 'Умный управляемый коммутатор.', '55300', '30', '17'),
('Cambium cnVision Client MAXr with 19 dBi Integrated Antenna, IP67 (ROW), EU cord', 'Клиент с высоким коэффициентом усиления используется в суровом климате, на дальние расстояния или промышленных объектах.', '37130', '30', '12'),
('Cambium cnVision Client MINI with 16 dBi Integrated Antenna, IP55 (ROW), EU cord', 'Стандартный клиент, подходящий для большинства условий.', '34365', '30', '12'),
('Cambium cnVision Hub 360r Radio with 8 dBi Integrated Omni Antenna, IP67 (ROW), EU cord', 'Всенаправленный концентратор для соединения большого количества камер в любом направлении.', '41080', '30', '12'),
('Cambium cnVision HUB FLEXr Connectorized, IP67 (ROW), EU cord', 'Совместимый концентратор с большим количеством различных видов антенн.', '45425', '30', '12'),
('Cambium cnVision Client MICRO with 13 dBi Integrated Antenna, IP55 (ROW), EU cord', 'Клиент малого форм-фактора для более коротких расстояний.', '27255', '30', '12'),
('Cambium cnMatrix EX2052, Switch', 'Умный управляемый коммутатор.', '2255', '30', '17'),
('Cambium cnMatrix EX2010, Switch', 'Умный управляемый коммутатор.', '68335', '30', '17'),
('Cambium cnMatrix EX2028, Switch', 'Умный управляемый коммутатор.', '123240', '30', '17'),
('MikroTik wAP ac BE', 'Точка доступа 2.4+5 ГГц, 802.11ac, 1х 1G Ethernet', '7030', '0', '11'),
('MikroTik mANT30 PA (4-pack)', '4 антенны 5 ГГц, MIMO 2x2, 30 дБи', '44080', '0', '16')
;

-- Создаю представление таблицы товаров только с ценой, количеством c сортировкой по id каталога и названию. 
CREATE OR REPLACE VIEW prod AS
SELECT id, products.name, price, value, catalog_id
FROM products
ORDER BY catalog_id, name;
SELECT * FROM prod;

-- Добавляю представление, которое выводит название товарной позиции из таблицы products и соответствующее название каталога из таблицы catalogs.
CREATE OR REPLACE VIEW products_1 AS 
SELECT products.name AS product_name, catalogs.name AS catalog_name
FROM products
LEFT JOIN catalogs ON products.catalog_id = catalogs.id
ORDER BY products.name;
SELECT * FROM products_1;

-- Посчитаю общее количество товаров по группам
SELECT catalogs.name as category, count(*) AS cnt
FROM products 
INNER JOIN catalogs on products.catalog_id = catalogs.id
GROUP BY catalogs.id


-- Добавляю таблицу с новостями
DROP TABLE IF EXISTS news;
CREATE TABLE news (
	id SERIAL,
	title VARCHAR(255) COMMENT 'Название',
    body TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Добавляю таблицу с лайками новостей
DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL,
    news_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()
    , FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE restrict
    , FOREIGN KEY (news_id) REFERENCES news(id)
);
INSERT INTO `likes` VALUES 
('1','1','37','2020-10-14 18:47:39'),
('2','2','45','2020-09-04 16:08:30'),
('3','3','57','2020-07-10 22:07:03'),
('4','4','1','2020-05-12 20:32:08'),
('5','5','2','2020-09-10 14:36:01'),
('6','6','2','2020-04-15 01:27:31'),
('7','7','2','2021-02-03 04:56:27'),
('8','8','8','2021-02-24 09:30:19'),
('9','9','9','2021-02-07 20:53:55'),
('10','10','10','2020-05-11 03:21:40'),
('11','11','11','2020-12-17 13:03:56'),
('12','12','12','2020-07-17 21:22:38'),
('13','13','13','2020-09-07 23:34:21'),
('14','14','14','2021-01-27 23:11:53')
;

INSERT INTO news (title, body) VALUES 
('Коммутаторы: что это такое, для чего нужны, чем отличаются', 'Список оборудования, использующегося при прокладке сетей обширен, но «базовыми» устройствами в нем можно считать маршрутизаторы и коммутаторы. О первых мы достаточно подробно рассказали в прошлом материале, поэтому на этот раз поговорим о том, что такое коммутаторы, что делают эти сетевые узлы, а также какие отличия есть между их моделями.'),
('IP-адрес – что это такое?', 'Сегодня мы коснемся одного из самых базовых понятий сетевых технологий – IP-адреса, а именно расскажем, что это такое, какие виды бывают, и как узнать адрес собственного компьютера или телефона.'),
('Начались продажи устройств Ubiquiti LTU, в чем разница с airMAX ac', 'Стала доступна для покупки новая линейка устройств для реализации беспроводного подключения «точка-многоточка» (PtMP) Ubiquiti LTU. Ключевое отличие от предыдущих линеек и аналогичных решений конкурентов – отказ от стандарта Wi-Fi в пользу собственной технологии передачи данных.'),
('Инновационная поворотная камера Ubiquiti UniFi Protect G4 PTZ', 'Компания Ubiquiti анонсировала топовую высокоскоростную поворотную камеру кругового обзора UniFi Protect G4 PTZ.'),
('IP-камеры – что это такое, и как они работают', 'Повсеместное распространение интернета привело к тому, что сетевые интерфейсы и сопутствующие технологии начали постепенно проникать в другие сферы, в том числе и в видеонаблюдение, в котором до относительно недавнего времени использовались аналоговые камеры. Сейчас же его основой является цифровое устройство – IP-камера.'),
('WiFi-адаптеры: что это такое, зачем нужны, как выбрать', 'Все больше пользователей отдает предпочтение беспроводному подключению к локальной сети за счет его простоты и удобства. И если с мобильными устройствами все просто, то для ПК потребуется отдельный Wi-Fi-адаптер.'),
('Витая пара: устройство, отличия, назначение', 'Витая пара – один из самых распространенных видов кабеля в сфере телекоммуникаций. Впрочем, за этим названием скрывается не одна конкретная разновидность целая группа кабелей, имеющих определенные различия в конструкции и предназначении. Об этом мы и расскажем подробнее.'),
('Что такое пигтейлы, зачем они нужны и чем различаются', 'Для монтажа сети и подключения к интернету используются не только патч-корды, но и кардинально отличающиеся от них пигтейлы. Значит, стоит рассказать, что это такое, а заодно и коснуться ряда сопутствующих вопросов.'),
('Как правильно обжать коннектор RJ-45 с 4 и 8 жилами', 'Прокладка локальной сети, как и подключение к интернету, требует не только специального сетевого оборудования, но и наличия еще крайне важной детали – коммутационного кабеля с установленными на нем коннекторами RJ-45.'),
('Основные отличия коммутатора от маршрутизатора и концентратора', 'Организация локальной сети и подключения к интернету требует установки специального оборудования: маршрутизаторов, коммутаторов и концентраторов в различных комбинациях. Несмотря на то, что устройства выглядят крайне похоже принцип работы у них абсолютно разный.'),
('Как рассчитать ИБП для компьютера и других устройств', 'В продолжение нашей предыдущей статьи с базовыми понятиями об источниках бесперебойного питания мы решили немного углубиться в эту тему и подробнее рассказать о том, как подобрать ИБП по мощности и времени работы.'),
('ИБП – что такое, зачем нужны, чем отличаются друг от друга?', 'Насколько бы качественной и мощной ни была используемая электроника, без подключения к электросети она работать не сможет, поэтому на этот раз мы расскажем о периферии, ценность которой особенно сильно ощущается в критической ситуации – об ИБП.'),
('Вышла новая бета-версия RouterOS 7.0beta8', 'MikroTik представила новую бета-версию RouterOS 7.0 – своей основной операционной системы для управления сетевым оборудованием.'),
('Маршрутизаторы и роутеры: отличия, предназначение, основные функции', 'В чем разница между ними? Какое устройство лучше справляется со своими функциями? Какую модель лучше приобрести? Что ж, мы готовы дать ответы!'),
('Новые вебинары от RF elements', 'RF elements – один из ведущих производителей коммерческих антенн для беспроводной передачи данных пока не радует новинками оборудования, но не теряют времени зря. Официальный канал компании на YouTube недавно пополнился серией новых вебинаров.'),
('Выпущен новый мощный сетевой шлюз Ubiquiti UXG-Pro', 'Ubiquiti Networks выпустила обновленную модель корпоративного сетевого шлюза Ubiquiti UXG-Pro. Новинка входит в систему сетевого оборудования UniFi Enterprise и является улучшенной версией модели Ubiquiti UniFi Security Gateway Pro.'),
('Aqua-Fi – новая технология подводного беспроводного интернет-подключения', 'Во время тестовых погружений испытателями были использованы зеленые светодиоды и лазер с длиной волны 520 нм.'),
('Новая потолочная точка доступа от Edimax Technology', 'Тайваньский производитель сетевого оборудования Edimax Technology представил новую двухдиапазонную точку доступа CAX1800 с Wi-Fi 6 (IEEE 802.11ax).')
;

-- Создаю таблицу с юзерами со всеми данными
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(120) UNIQUE,
    password_hash VARCHAR(100),
    phone BIGINT, 
    birthday_at DATE COMMENT 'Дата рождения',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (firstname, lastname, email, password_hash, phone, birthday_at) VALUES
('Clair', 'Bednar', 'vgulgowski@example.net', 'd692631dcffb12df6e2b3bca3762edfd3b39f362', '74248733420', '1980-03-03'),
('Susie', 'Jacobs', 'trisha.pagac@example.com', '24f2ccb800fc26d2419b89a9b25a81baa8a01c9c', '74248733421', '1997-08-13'),
('Ansley', 'Raynor', 'ramona55@example.net', '1e43b0f116f852891ec365376403f3eb229efc0e', '74248733422', '1993-06-29'),
('Muriel', 'Toy', 'csmith@example.net', '521eb8649c37ca1bbff5d7e07231a593c54b3231', '74248733423', '2004-05-14'),
('Eldora', 'Bergstrom', 'daniella.reichert@example.net', '5158fcda91bb99a64c00c28c36cec5555de77ae7', '74248733424', '1981-12-10'),
('Elvis', 'Hagenes', 'zluettgen@example.com', '7395ce27296b39a4cf77ac29d1b0eaf3495a20fb', '74248733425', '2006-11-02'),
('Parker', 'Oberbrunner', 'barry.stracke@example.net', '329a47f4df07149fa789a724b1c89fd32e39a273', '74248733426', '1975-03-26'),
('Catherine', 'Simonis', 'vbrekke@example.net', 'c8c98b4f6227113313e43b7016a6821ffd5c66d9', '74248733427', '1973-09-15'),
('Jolie', 'Champlin', 'kwalker@example.com', '4251998dc3eda2dd933e4e52453da8d1cde88343', '74248733428', '1998-01-05'),
('Keith', 'Blick', 'milan.bartell@example.org', '1e4c2b019e8c427125e7727524d47d5d6e649e2a', '74248733429', '2007-01-16'),
('Kacie', 'Corkery', 'wilfrid.langworth@example.org', 'bce6f3001f7abebd83883aa785fcdba1fbd9beed', '74248733430', '2014-05-29'),
('Eloise', 'Kemmer', 'petra61@example.org', '18430fcdbcc2e1f5995c34b6701e37daf7e294bf', '74248733431', '2004-06-29'),
('Noelia', 'Crona', 'drake.johnson@example.com', 'ceb633f62fdbb239af3f69669a3b71ba5e020bf6', '74248733432', '1994-01-14'),
('Jabari', 'Maggio', 'bboyle@example.net', 'f424c70a404d7237a2c7946117540386a780cc83', '74248733433', '1980-07-10'),
('Derek', 'Hilll', 'crau@example.org', 'e0b09c283805f00efdb834499d147ac8485ee8c0', '74248733434', '2009-10-01'),
('Arvel', 'Yundt', 'macey.sipes@example.com', '2709b1fe8fea770b55b2becd6170b91042db808c', '74248733435', '1976-05-31'),
('Mallory', 'Mraz', 'chomenick@example.org', '8b82c2a578b8dd125908b75346719fe6e67f3e0f', '74248733436', '1996-11-19'),
('Emmanuel', 'Bashirian', 'ettie43@example.com', '365ac48621d09a390cde247dfc976a09af668b1a', '74248733437', '2005-04-09'),
('Catalina', 'Abshire', 'freeda.stamm@example.org', '7cf09d00b3e42069dd48d85b833ca876eaa7daf8', '74248733438', '1977-12-16'),
('Kennith', 'Hills', 'kboehm@example.org', '02c4860b18dd0b5d849e9a2ae18fc0efd9c97fbe', '74248733439', '2005-10-17'),
('Jadyn', 'Lockman', 'rogahn.bailee@example.net', 'ead954aed3ee0e7682ac51544935a3b88bed7446', '74248733440', '2000-12-26'),
('Jaeden', 'Ward', 'cmayert@example.com', '83d379c4b8248ba3b130c8286dee66fa1105d6d8', '74248733441', '2008-12-09'),
('Brett', 'Spencer', 'dparker@example.com', '21a8e276e2fc5146082a709842ed7a409b8e15ea', '74248733442', '1980-07-27'),
('Toy', 'Nienow', 'aufderhar.phyllis@example.net', 'bbe2f21646c3f959d644f7bb7f0001387ffa5b2f', '74248733443', '2009-03-28'),
('Cristian', 'Cassin', 'nellie.durgan@example.com', '1436a06e16ae0f8927f2a68d07ef20d2ec64f145', '74248733444', '2014-10-08'),
('Linda', 'Feil', 'sophie.kovacek@example.org', '56bab5bcb9855c4250db34564ede7def1d788970', '74248733445', '1974-07-05'),
('Millie', 'Klein', 'wondricka@example.net', '7af3932e433e17fcdf1d923275ae45d2066f4c3a', '74248733446', '1996-07-29'),
('Cheyanne', 'Bradtke', 'tdeckow@example.net', 'a7078b4200469cd04c03946b309b293c3bb09085', '74248733447', '1985-08-17'),
('Rozella', 'Prosacco', 'emery90@example.net', 'b65f32bd2564a7ab16571fd357f60fa0bb5dfe65', '74248733448', '2000-06-10'),
('Ezequiel', 'Langworth', 'kay52@example.com', '7a6215a1eb2bc80d5c5cd8f071c9ae041f9bad0a', '74248733449', '2012-05-06'),
('Aylin', 'Crist', 'bert34@example.net', 'a83a1514938f88725cd85b3e97f2294be004aa62', '74248733450', '1985-05-07'),
('Kristoffer', 'Rath', 'eliezer28@example.net', 'f5577f8f32927519ed77a65bcfc17b92319a4235', '74248733451', '1991-09-25'),
('Johan', 'Feeney', 'ava92@example.com', 'ed08f3d164c08f7a1975ed12ccd4da1e2dce0730', '74248733452', '2006-12-11'),
('Ned', 'Deckow', 'crooks.rex@example.net', '74f253c601270bd6bcb0e1a276ac99ec95201ad7', '74248733453', '1995-02-18'),
('Lela', 'Shanahan', 'brekke.ona@example.com', '10205243c49d2a1b9be374b6e57abc327ebedc53', '74248733454', '2010-03-19'),
('Audra', 'Bayer', 'litzy.stoltenberg@example.com', '35cf882f3b668f14b626963939f103712e87b047', '74248733455', '2012-11-03'),
('Mathilde', 'Nicolas', 'summer.dach@example.com', '396c434b81abb1a8a419ec1c5af2ca007df87217', '74248733456', '2007-05-20'),
('Ron', 'Stanton', 'nicolette48@example.com', '5068f4fa4db2d0911af645b085a09164df1246b1', '74248733457', '1989-06-03'),
('Muhammad', 'Reinger', 'greenholt.prince@example.com', '07f7a579136003ec76e5b311f8daf2774b807469', '74248733458', '1998-10-12'),
('Olin', 'Ratke', 'philip.will@example.org', 'f29abebe03a52946e1625602109840f75622d26d', '74248733459', '1993-01-12'),
('Makayla', 'Rogahn', 'amparo39@example.org', '7a74956b23d938f2f33a8c24b0782bd03a74f7fe', '74248733460', '2008-01-05'),
('Geoffrey', 'Prohaska', 'ckohler@example.org', '60fac3846b98d29672c7e9a1509dbc57d76dcbb0', '74248733461', '1980-08-17'),
('Kassandra', 'Runolfsson', 'lowe.lexi@example.com', '692c230d8e54999b295cb7fa2cfef74feeb06ec7', '74248733462', '1976-11-09'),
('Rebeca', 'Graham', 'ghamill@example.net', '909b458a27e31d00c84ef168865a26322f0f05a0', '74248733463', '1972-05-18'),
('Sheila', 'Monahan', 'ferry.chelsea@example.net', 'b8c9e5b7e6bf0196d8c74da4a915218a9fa728af', '74248733464', '1973-12-03'),
('Marcos', 'Heidenreich', 'gislason.june@example.com', '0a9274e6abf560c63012af6469d2804e2b9ad066', '74248733465', '1981-01-14'),
('Geovanny', 'Grant', 'haylie.parker@example.com', 'faf8cad6a20fadb2be541534c6f7daafcd79c6b2', '74248733466', '1971-02-02'),
('Asa', 'VonRueden', 'maddison.ankunding@example.net', '48b81a3274d1defda19a26c8f93cf5d178101a82', '74248733467', '2019-03-19'),
('Deangelo', 'Hoeger', 'mattie.wisozk@example.org', 'bc2c1cfe697c8291124379f259c09593fdec73a3', '74248733468', '1995-05-11'),
('Baby', 'Cormier', 'mschroeder@example.net', 'c0813bb5db4a29c3ccc368d0a7b1e19f74c08d0f', '74248733469', '1998-02-19'),
('Ocie', 'OReilly', 'stephon78@example.com', '3a44597d03c66ed02e943e49e93383789347ba14', '74248733470', '1993-07-05'),
('Carmel', 'Dicki', 'angelita.prosacco@example.com', '0209ce3c76ed6b602cdb30602224585760cf037c', '74248733471', '1990-11-17'),
('Ike', 'Collier', 'lakin.roel@example.org', 'cdefccddde42742b39771ed32bc86768dda0879b', '74248733472', '1990-07-30'),
('Margaretta', 'Mohr', 'cassandra.cronin@example.com', 'dae3f79bb27f0d68bf939ea5556b4d2738bcd58c', '74248733473', '2016-05-17'),
('Gavin', 'Grimes', 'cschowalter@example.org', '366e0a04aef70dad2fd5907236c5408910d046c3', '74248733474', '1990-04-10'),
('Jamel', 'Hand', 'josie.lebsack@example.com', '03afe11ced2adfd4fe5a1fd525a72fbdff21a3ee', '74248733475', '1973-04-16'),
('Clarissa', 'Bins', 'weimann.savion@example.org', 'be97791a3b254514c70e207247eb5ab8cb147ef0', '74248733476', '1998-03-01'),
('Elvis', 'Reinger', 'alberto.gerhold@example.org', 'e1fd37dce270f5cdf54b030460081e3cf4ed265e', '74248733477', '1989-01-07'),
('Ahmed', 'Yost', 'prosacco.macey@example.net', '4b60cd4953dd7347474d0084f221f12c0c04f37c', '74248733478', '2012-02-19'),
('Geovanni', 'Cole', 'otrantow@example.net', 'cbceaf58ed6fc0af6ac4ad833480609637abdd1b', '74248733479', '1981-02-22'),
('Bennett', 'Ondricka', 'amari47@example.com', '3915e61bdbaa43853c9f8dd8fbeebc513b7134d5', '74248733480', '1987-11-27'),
('Kiley', 'Goyette', 'bechtelar.herminio@example.net', 'd2e8308c6222f226b1df73590a114745cb6d04da', '74248733481', '2010-08-17'),
('Mavis', 'Zemlak', 'prince90@example.com', 'a6f4c7f7a184f23465204cd9f555482446297240', '74248733482', '2013-09-04'),
('Chauncey', 'Ward', 'purdy.cathrine@example.org', '62460bfdc4661779691d83d769579d100fdbe05f', '74248733483', '1989-01-15'),
('Alaina', 'Shields', 'skuhn@example.net', '25b96584b5cbb5824ec5eeb535afe6d01d311f05', '74248733484', '2008-11-03'),
('Gerson', 'Murazik', 'hlangworth@example.net', '0e7273d98b8d88d7d8768a75cd65ba05042fa859', '74248733485', '1982-12-15'),
('Darrell', 'Buckridge', 'zaria.gusikowski@example.org', 'eca3492f169dcbe807411a2d76624caea4bf471f', '74248733486', '1973-10-13'),
('Austen', 'Lindgren', 'lowe.jolie@example.com', 'e6127e88bd652fa19d15a6ba3a47aae893a3fc76', '74248733487', '1981-04-23'),
('Gilberto', 'Beer', 'edna.roob@example.org', 'bf5c6e3edc46c3f436883c0ab3b74e538281e76e', '74248733488', '1985-05-25'),
('Keira', 'Hayes', 'nash.berge@example.org', 'e2765cc2dcf3d09af92d5d47cbe996c7a8d682d0', '74248733489', '1971-01-14'),
('Name', 'Jakubowski', 'kuhlman.aliyah@example.org', '4795854310a348997a4e7cbb7b0b594895c0afe7', '74248733490', '1977-08-10'),
('Isidro', 'Howell', 'alessia.fisher@example.net', '78a474eb60ff5b991ce96978a9ee6e20e3c1ed37', '74248733491', '2010-11-24'),
('Geovanni', 'Huels', 'vmohr@example.net', '243a8ffffc2fa6f31753c1486cac887585ea01e4', '74248733492', '2004-12-01'),
('Mose', 'Lesch', 'keira.dicki@example.net', 'ef9bdaa5c1e1b7d01c273ba586b5741fcbe1681e', '74248733493', '1986-02-08'),
('Ashton', 'Runolfsdottir', 'qbernhard@example.com', '9afcfdde62545cc933a8c8de0468a9ae91203b42', '74248733494', '2018-03-04'),
('Dallas', 'Anderson', 'hilpert.davonte@example.org', '7a2dfffad8169414810affc1ae699fb7640f3275', '74248733495', '1994-02-18'),
('Isaac', 'Wiza', 'gibson.merle@example.org', '012803e165379c5330a449fd8af5b5361f3b778d', '74248733496', '1993-05-16'),
('Imelda', 'Berge', 'nigel40@example.com', 'e6b744f8c73f18991febf04d99d4fa8ee864f940', '74248733497', '1998-07-07'),
('Jamel', 'Thompson', 'vicenta27@example.net', '3f61eca9bfaa99cbbf4880501633d3454f078e38', '74248733498', '2018-03-13'),
('Stephania', 'Tremblay', 'ledner.camille@example.net', 'bcff89f983784e4fb474b637864cfe6deed5412f', '74248733499', '1993-12-27'),
('Keely', 'Hintz', 'mack.mayert@example.org', '8d01764e820be32b280b27b77090de988ada17cf', '74248733500', '2007-07-16'),
('Bianka', 'Klocko', 'brian17@example.org', 'ffd9954208b18934fe4697f75a7a77a84662776d', '74248733501', '2002-08-06'),
('Joaquin', 'Halvorson', 'ondricka.rosalyn@example.net', '739333ec1c316456be97d08cfb5cd7bc254ac698', '74248733502', '1980-08-05'),
('Keagan', 'Green', 'raphael.hane@example.org', '3a3e89e97ac39e6805fbdb2ed6de9316edb64323', '74248733503', '2013-07-10'),
('Alford', 'Barton', 'elwyn40@example.org', '152edef04e40762d3cdb64efa30d6aa52eb14125', '74248733504', '1996-08-09'),
('Mateo', 'Gleason', 'rjakubowski@example.com', 'e65a0357965dd84715e9c90bedb499b521f2d6e0', '74248733505', '2012-03-10'),
('Jeanette', 'DAmore', 'fritz.veum@example.net', 'adb5c6d9153cd37f7a7ba2883c68a0e6045bb7b6', '74248733506', '2019-11-20'),
('Monroe', 'Champlin', 'victor34@example.net', 'd023d6ea9e1949a5f778d61cf2064b7c40699c46', '74248733507', '1983-02-26'),
('Kennedi', 'Crona', 'joanne54@example.org', '84315557f0519d3862a3a7547bcd3757d9526e17', '74248733508', '2001-01-13'),
('Santina', 'Smitham', 'johnston.delia@example.com', '62077df0e803befd28b1d93f0ac3c63bfc36bc2f', '74248733509', '1997-01-10'),
('Bill', 'Zulauf', 'qrunolfsdottir@example.org', '5ff9ef0dacdf9338115fd67a82ddb32e49d3d5f3', '74248733510', '1973-04-12'),
('Janice', 'Legros', 'gerhold.zachary@example.net', '3cfb7a97a6a3f0296d11595e37eb49dfefde54bf', '74248733511', '1997-08-19'),
('Elliott', 'Gutmann', 'lester.bechtelar@example.net', '50599eb26312e0d9be8c0768d619c7de240de60f', '74248733512', '1976-10-22'),
('Esta', 'Skiles', 'hoeger.urban@example.net', '2d928a6ba1d8553da709df6a146bff1f64450765', '74248733513', '1986-01-07'),
('Loren', 'Hauck', 'rico.gislason@example.com', '66f7120f599e1bd9ffca44d1736e3d0ca51aa21a', '74248733514', '1981-05-25'),
('Jerome', 'Hills', 'astrid.walsh@example.net', '92643fe6b2ee4ae312e22c76d38a5783bf1a0136', '74248733515', '1998-09-14'),
('Elisha', 'Tillman', 'brandyn26@example.net', 'f02fa8522229e8428f63a04f96ab7429a42de3d2', '74248733516', '2010-06-16'),
('Katelyn', 'Wolf', 'loyal00@example.net', '676544838f2b5cc0e41ba39edd57febf06500dff', '74248733517', '1983-06-10'),
('Trisha', 'Schneider', 'swift.tom@example.net', 'b3d3e071bdd6456068c7b899f076d728334d60b4', '74248733518', '2015-09-04'),
('Marquis', 'Heaney', 'schmeler.tomasa@example.org', 'c49df57334e7a94e161ca81f680cccaf4d373828', '74248733519', '1983-03-14')
;

-- Добавляю таблицу с заказами товаров
DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  user_id BIGINT UNSIGNED,
  product_id BIGINT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (product_id) REFERENCES products(id)   
) COMMENT = 'Заказы и Состав заказа';

INSERT INTO orders_products (user_id, product_id, total) VALUES
('13', '87', '1'),
('58', '102', '3'),
('45', '115', '5'),
('16', '6', '1'),
('2', '28', '1'),
('48', '187', '13'),
('51', '241', '5'),
('5', '242', '2'),
('99', '243', '5'),
('87', '232', '6'),
('85', '55', '1'),
('39', '52', '1'),
('46', '68', '5'),
('56', '80', '5'),
('10', '184', '4'),
('6', '38', '1'),
('98', '5', '2')
;


-- Добавляю таблицу со скидками по категориям товаров
DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  catalog_id BIGINT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (catalog_id) REFERENCES catalogs(id)
) COMMENT = 'Скидки';

INSERT INTO discounts (catalog_id, discount, started_at, finished_at) VALUES
('1', '10', '2021-01-10 00:00:00', '2021-01-09 00:00:01'),
('2', '10', '2021-02-10 00:00:00', '2021-02-09 00:00:01'),
('3', '10', '2021-03-10 00:00:00', '2021-03-09 00:00:01'),
('4', '5', '2021-04-10 00:00:00', '2021-04-09 00:00:01'),
('5', '5', '2021-05-10 00:00:00', '2021-05-09 00:00:01'),
('6', '5', '2021-06-10 00:00:00', '2021-06-09 00:00:01'),
('7', '5', '2021-07-10 00:00:00', '2021-07-09 00:00:01'),
('8', '5', '2021-08-10 00:00:00', '2021-08-09 00:00:01'),
('9', '5', '2021-09-10 00:00:00', '2021-09-09 00:00:01'),
('10', '5', '2021-10-10 00:00:00', '2021-10-09 00:00:01'),
('11', '5', '2021-11-10 00:00:00', '2021-11-09 00:00:01'),
('12', '5', '2021-12-10 00:00:00', '2021-12-09 00:00:01'),
('13', '5', '2022-01-10 00:00:00', '2022-01-09 00:00:01'),
('14', '5', '2022-02-10 00:00:00', '2022-02-09 00:00:01'),
('15', '5', '2022-03-10 00:00:00', '2022-03-09 00:00:01'),
('16', '5', '2022-04-10 00:00:00', '2022-04-09 00:00:01'),
('17', '5', '2022-05-10 00:00:00', '2022-05-09 00:00:01'),
('1', '10', '2022-06-10 00:00:00', '2022-06-09 00:00:01'),
('2', '10', '2022-07-10 00:00:00', '2022-07-09 00:00:01'),
('3', '10', '2022-08-10 00:00:00', '2022-08-09 00:00:01')
;

-- Добавляю таблицу с сообщениями пользователей, а далее проверяю кто больше всего писал  админам (id=1)
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    INDEX messages_from_user_id (from_user_id),
    INDEX messages_to_user_id (to_user_id),
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

INSERT INTO `messages` VALUES 
('1','1','2','Voluptatem ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.','1995-08-28 22:44:29'),
('2','2','1','Sint dolores et debitis est ducimus. Aut et quia beatae minus. Ipsa rerum totam modi sunt sed. Voluptas atque eum et odio ea molestias ipsam architecto.',now()),
('3','3','1','Sed mollitia quo sequi nisi est tenetur at rerum. Sed quibusdam illo ea facilis nemo sequi. Et tempora repudiandae saepe quo.','1993-09-14 19:45:58'),
('4','1','3','Quod dicta omnis placeat id et officiis et. Beatae enim aut aliquid neque occaecati odit. Facere eum distinctio assumenda omnis est delectus magnam.','1985-11-25 16:56:25'),
('5','1','5','Voluptas omnis enim quia porro debitis facilis eaque ut. Id inventore non corrupti doloremque consequuntur. Molestiae molestiae deleniti exercitationem sunt qui ea accusamus deserunt.','1999-09-19 04:35:46'),
('6','1','6','Rerum labore culpa et laboriosam eum totam. Quidem pariatur sit alias. Atque doloribus ratione eum rem dolor vitae saepe.','1973-11-09 08:12:04'),
('7','1','7','Perspiciatis temporibus doloribus debitis. Et inventore labore eos modi. Quo temporibus corporis minus. Accusamus aspernatur nihil nobis placeat molestiae et commodi eaque.','1998-04-09 00:00:26'),
('8','8','8','Suscipit dolore voluptas et sit vero et sint. Rem ut ratione voluptatum assumenda nesciunt ea. Quas qui qui atque ut. Similique et praesentium non voluptate iure. Eum aperiam officia quia dolorem.','2005-08-20 18:40:27'),
('9','9','9','Et quia libero aut vitae minus. Rerum a blanditiis debitis sit nam. Veniam quasi aut autem ratione dolorem. Sunt quo similique dolorem odit totam sint sed.','2013-03-19 04:10:10'),
('10','10','10','Praesentium molestias quia aut odio. Est quis eius ut animi optio molestiae. Amet tempore sequi blanditiis in est.','1976-05-22 14:38:15'),
('11','11','11','Molestiae laudantium quibusdam porro est alias placeat assumenda. Ut consequatur rerum officiis exercitationem eveniet. Qui eum maxime sed in.','1996-04-27 00:23:37'),
('12','12','12','Quo asperiores et id veritatis placeat. Aperiam ut sit exercitationem iste vel nisi fugit quia. Suscipit labore error ducimus quaerat distinctio quae quasi.','1989-05-13 22:39:47'),
('13','13','1','Earum sunt quia sed harum modi accusamus. Quia dolor laboriosam asperiores aliquam quia. Sint id quasi et cumque qui minima ut quo. Autem sed laudantium officiis sit sit.','1997-09-30 00:06:14'),
('14','4','1','Aut enim sint voluptas saepe. Ut tenetur quos rem earum sint inventore fugiat. Eaque recusandae similique earum laborum.','1977-10-15 23:26:40'),
('15','4','1','Nisi rerum officiis officiis aut ad voluptates autem. Dolor nesciunt eum qui eos dignissimos culpa iste. Atque qui vitae quos odit inventore eum. Quam et voluptas quia amet.','1977-10-13 19:40:32'),
('16','4','1','Consequatur ut et repellat non voluptatem nihil veritatis. Vel deleniti omnis et consequuntur. Et doloribus reprehenderit sed earum quas velit labore.','1998-05-24 10:09:36'),
('17','2','1','Iste deserunt in et et. Corrupti rerum a veritatis harum. Ratione consequatur est ut deserunt dolores.','1993-01-30 15:51:38'),
('18','18','1','Dicta non inventore autem incidunt accusamus amet distinctio. Aut laborum nam ab maxime. Maxime minima blanditiis et neque. Et laboriosam qui at deserunt magnam.','1996-05-19 14:18:39'),
('19','19','1','Amet ad dolorum distinctio excepturi possimus quia. Adipisci veniam porro ipsum ipsum tempora est blanditiis. Magni ut quia eius qui.','1998-08-12 04:42:34'),
('20','20','20','Porro aperiam voluptate quo eos nobis. Qui blanditiis cum id eos. Est sit reprehenderit consequatur eum corporis. Molestias quia quo sit architecto aut.','2013-11-01 05:14:05'),
('21','21','21','Architecto sunt asperiores modi. A commodi non qui.','2007-10-22 01:34:17'),
('22','8','1','Minus praesentium ipsum iusto ipsum et a nobis. Aut distinctio enim dolor suscipit et. Quia culpa molestiae architecto quod. Error nulla qui et harum sapiente maxime qui sed.','1986-07-17 11:23:56'),
('23','8','1','Explicabo nostrum eius cum molestiae. Et deserunt aut consectetur molestiae. Illo veritatis sed ab.','2002-06-22 15:10:59'),
('24','8','1','Excepturi consequatur ducimus voluptatum. Est sed perferendis ducimus officia et. Qui nemo sapiente harum rerum.','2007-09-14 22:06:16'),
('25','8','1','Non deserunt quis non illum. In vel exercitationem dolore reiciendis non animi sequi cumque. Officia et repellat in aut voluptas. Dignissimos sed voluptatem minima eligendi. Magnam porro omnis mollitia aspernatur error quia.','2006-06-16 19:28:59'),
('26','8','1','Minus tenetur molestiae laudantium est voluptatem tempora. Sed ab veniam porro similique cumque. Accusamus illo est et tempora excepturi odit.','1977-11-04 08:02:22'),
('27','8','1','At ratione quae facere minima exercitationem vel ipsum ipsam. Qui eligendi repellat ut unde quos hic sit. Itaque expedita voluptatem id numquam. Provident culpa expedita alias optio ipsum id. Voluptatum quae quidem nihil aut nemo voluptatibus.','1975-06-25 22:37:18'),
('28','8','1','Nam dignissimos nobis qui qui voluptate. Dolor voluptas praesentium quis tenetur deleniti dolorem incidunt. Cupiditate qui nam excepturi.','2007-03-22 10:13:05'),
('29','8','1','Molestias ratione tenetur sint. Vel rerum voluptas vel vitae et aut non autem. Distinctio sunt in dignissimos esse eligendi praesentium. Ut totam autem vel sapiente architecto et.','2003-01-11 19:37:45'),
('30','8','1','Perferendis in eius architecto debitis exercitationem. Optio deleniti ad dolor sapiente soluta. Quisquam deserunt autem amet magni quasi quo dolores. Expedita ea omnis omnis sint.','2010-04-13 15:06:20')
;

-- Проверю с помощью вложенного запроса, кто большев всего образался в службу поддержки (id=1)
SELECT 
	from_user_id, 
	concat(
		(SELECT firstname FROM users WHERE id = m.from_user_id), ' ', 
		(SELECT lastname FROM users WHERE id = m.from_user_id)
	) AS name
	, count(*) cnt
FROM messages m
WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY cnt DESC;

-- Добавляю таблицу со счетами пользователей, и добавляю транзакции со счетами
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED,
    total DECIMAL (11,2) COMMENT 'Счет',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
) COMMENT = 'Счета пользователей и интернет магазина';

INSERT INTO accounts (user_id, total) VALUES
  ('4', '5000'),
  ('3', '0'),
  ('2', '200'),
  (NULL, '25000');

START TRANSACTION;
SELECT total FROM accounts WHERE user_id = 4;
UPDATE accounts SET total = total - 2000 WHERE user_id = 4;
UPDATE accounts SET total = total + 2000 WHERE user_id IS NULL;
COMMIT;

SELECT * FROM accounts;

-- Смотрим типы объектов для которых возможны новости  
SELECT * FROM news;
-- Начинаем создавать архив новостей по месяцам (сколько новостей в каждом месяце было создано)
SELECT 
	COUNT(id) AS news -- группируем по id и считаем сумму таких записей
	, MONTHNAME(created_at) AS month_name
	-- , MONTH(created_at) AS month_num -- если заходим вывести номер месяца (вспомогательно) 
FROM news
GROUP BY month_name
-- order by month(created_at) -- упорядочим по месяцам
order by news desc -- узнаем самые активные месяцы
; 


-- Транзакции по добавлению нового пользователя      
START TRANSACTION;

INSERT INTO users (firstname, lastname, email, password_hash, phone, birthday_at) VALUES 
('New', 'User', 'new@mail.com', 'hjkfordj', '74545454756', '1988-04-12');

SELECT @last_user_id := last_insert_id(); 
  
COMMIT;


-- Добавление таблицы с логами, а также тригеры к ней
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
   name_table VARCHAR(120) NOT NULL, 
   created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
   id_in_tbl BIGINT,
   name_in_tbl VARCHAR(120) NOT NULL
 ) ENGINE=ARCHIVE;

-- Триггеры
 
DELIMITER //
-- DROP TRIGGER IF EXISTS log_users //
CREATE TRIGGER catalogs_count AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    SELECT COUNT(*) INTO @total FROM catalogs;
END //

-- DROP TRIGGER IF EXISTS log_users //
CREATE TRIGGER log_users AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (name_table, created_at, id_in_tbl, name_in_tbl)
	VALUES ('users', NOW(), NEW.id, NEW.name);
END //

-- DROP TRIGGER IF EXISTS log_catalogs //

CREATE TRIGGER log_users AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (name_table, created_at, id_in_tbl, name_in_tbl)
	VALUES ('catalogs', NOW(), NEW.id, NEW.name);
END //

-- DROP TRIGGER IF EXISTS log_products //

CREATE TRIGGER log_users AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (name_table, created_at, id_in_tbl, name_in_tbl)
	VALUES ('products', NOW(), NEW.id, NEW.name);
END //


-- Процедуры

-- DROP PROCEDURE IF EXISTS insert_to_catalog//
CREATE PROCEDURE insert_to_catalog (IN id INT, IN name VARCHAR(255))
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET @error = 'Ошибка вставки значения';
    INSERT INTO catalogs VALUES(id, name);
    IF @error IS NOT NULL THEN
        SELECT @error;
    END IF;
END//

SELECT * FROM catalogs//

CALL insert_to_catalog(18, 'Материнские платы')//
CALL insert_to_catalog(19, 'Процессоры')//

delimiter ;

INSERT INTO users (firstname, birthday_at) VALUES ('Гена', '1989-10-11');
INSERT INTO catalogs VALUES (20, 'Системы охлаждения');
INSERT INTO products (name, description , price, catalog_id) VALUES ('Intel Core i3-10000', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 17890.00, 1);
