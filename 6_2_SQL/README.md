<h2 dir="auto">Задача 1</h2>
<p dir="auto">Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume,
в который будут складываться данные БД и бэкапы.</p>
<p dir="auto">Приведите получившуюся команду или docker-compose манифест.</p>

```
vagrant@ubuntu-20:~$ docker pull postgres:12
vagrant@ubuntu-20:~$ docker volume create data
data
vagrant@ubuntu-20:~$ docker volume create bkp
bkp
vagrant@ubuntu-20:~$ docker run -d --rm --name postgres -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v data:/var/lib/postgresql/data -v bkp:/var/lib/postgresql/bkp postgres:12
c017936ae10a2961a826362308b4f57edaeb5c21df78c82b3f8d4d4c124ee274
vagrant@ubuntu-20:~$ docker attach postgres
root@c017936ae10a:/# ls /var/lib/postgresql/
bkp  data
```
<h2 dir="auto">Задача 2</h2>
<p dir="auto">В БД из задачи 1:</p>
<ul dir="auto">
<li>создайте пользователя test-admin-user и БД test_db</li>

```
postgres=# CREATE DATABASE test_db;
CREATE DATABASE
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
(4 rows)

postgres=# CREATE ROLE "test-admin-user" SUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
CREATE ROLE
postgres=# \du
                                      List of roles
    Role name    |                         Attributes                         | Member of
-----------------+------------------------------------------------------------+-----------
 postgres        | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 test-admin-user | Superuser, No inheritance                                  | {}
```
<li>в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)</li>

```
postgres=# \connect test_db
You are now connected to database "test_db" as user "postgres".
test_db=# CREATE TABLE orders
test_db-# (
test_db(# id integer,
test_db(# name text,
test_db(# price integer,
test_db(# PRIMARY KEY (id)
test_db(# );
CREATE TABLE

test_db=# \dt
         List of relations
 Schema |  Name  | Type  |  Owner
--------+--------+-------+----------
 public | orders | table | postgres
(1 row)

test_db=# \d orders
               Table "public.orders"
 Column |  Type   | Collation | Nullable | Default
--------+---------+-----------+----------+---------
 id     | integer |           | not null |
 name   | text    |           |          |
 price  | integer |           |          |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)

test_db=# CREATE TABLE clients
test_db-# (
test_db(# id integer PRIMARY KEY,
test_db(# lastname text,
test_db(# country text,
test_db(# booking integer,
test_db(# FOREIGN KEY (booking) REFERENCES orders (id)
test_db(# );
CREATE TABLE

test_db=# \d clients
               Table "public.clients"
  Column  |  Type   | Collation | Nullable | Default
----------+---------+-----------+----------+---------
 id       | integer |           | not null |
 lastname | text    |           |          |
 country  | text    |           |          |
 booking  | integer |           |          |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "clients_booking_fkey" FOREIGN KEY (booking) REFERENCES orders(id)
```
<li>предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db</li>

* Пользователь test-admin-user - superuser, т.е. имеет все права, включая все права на test_db
<li>создайте пользователя test-simple-user</li>

```
test_db=# CREATE ROLE "test-simple-user" NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
CREATE ROLE
test_db=# \du
                                       List of roles
    Role name     |                         Attributes                         | Member of
------------------+------------------------------------------------------------+-----------
 postgres         | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 test-admin-user  | Superuser, No inheritance                                  | {}
 test-simple-user | No inheritance                                             | {}
```
<li>предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db</li>

```
test_db=# GRANT SELECT ON TABLE public.orders TO "test-simple-user";
GRANT
test_db=# GRANT INSERT ON TABLE public.orders TO "test-simple-user";
GRANT
test_db=# GRANT UPDATE ON TABLE public.orders TO "test-simple-user";
GRANT
test_db=# GRANT DELETE ON TABLE public.orders TO "test-simple-user";
GRANT
test_db=# GRANT SELECT ON TABLE public.clients TO "test-simple-user";
GRANT
test_db=# GRANT INSERT ON TABLE public.clients TO "test-simple-user";
GRANT
test_db=# GRANT UPDATE ON TABLE public.clients TO "test-simple-user";
GRANT
test_db=# GRANT DELETE ON TABLE public.clients TO "test-simple-user";
GRANT
```
</ul>
<p dir="auto">Таблица orders:</p>
<ul dir="auto">
<li>id (serial primary key)</li>
<li>наименование (string)</li>
<li>цена (integer)</li>
</ul>
<p dir="auto">Таблица clients:</p>
<ul dir="auto">
<li>id (serial primary key)</li>
<li>фамилия (string)</li>
<li>страна проживания (string, index)</li>
<li>заказ (foreign key orders)</li>
</ul>
<p dir="auto">Приведите:</p>
<ul dir="auto">
<li>итоговый список БД после выполнения пунктов выше,</li>

```
test_db=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
(4 rows)
```
<li>описание таблиц (describe)</li>

```
test_db=# \dt
          List of relations
 Schema |  Name   | Type  |  Owner
--------+---------+-------+----------
 public | clients | table | postgres
 public | orders  | table | postgres
(2 rows)

test_db=# \d orders
               Table "public.orders"
 Column |  Type   | Collation | Nullable | Default
--------+---------+-----------+----------+---------
 id     | integer |           | not null |
 name   | text    |           |          |
 price  | integer |           |          |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_booking_fkey" FOREIGN KEY (booking) REFERENCES orders(id)

test_db=# \d clients
               Table "public.clients"
  Column  |  Type   | Collation | Nullable | Default
----------+---------+-----------+----------+---------
 id       | integer |           | not null |
 lastname | text    |           |          |
 country  | text    |           |          |
 booking  | integer |           |          |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "clients_country_key" UNIQUE CONSTRAINT, btree (country)
Foreign-key constraints:
    "clients_booking_fkey" FOREIGN KEY (booking) REFERENCES orders(id)
```
<li>SQL-запрос для выдачи списка пользователей с правами над таблицами test_db</li>

```
test_db=# SELECT * FROM information_schema.table_privileges WHERE grantee in ('test-admin-user','test-simple-user');
 grantor  |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarch
y
----------+------------------+---------------+--------------+------------+----------------+--------------+--------------
--
 postgres | test-simple-user | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | DELETE         | NO           | NO
(8 rows)
```

<li>список пользователей с правами над таблицами test_db</li>
</ul>
<h2 dir="auto">Задача 3</h2>
<p dir="auto">Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:</p>
<p dir="auto">Таблица orders</p>
<table>
<thead>
<tr>
<th>Наименование</th>
<th>цена</th>
</tr>
</thead>
<tbody>
<tr>
<td>Шоколад</td>
<td>10</td>
</tr>
<tr>
<td>Принтер</td>
<td>3000</td>
</tr>
<tr>
<td>Книга</td>
<td>500</td>
</tr>
<tr>
<td>Монитор</td>
<td>7000</td>
</tr>
<tr>
<td>Гитара</td>
<td>4000</td>
</tr>
</tbody>
</table>
<p dir="auto">Таблица clients</p>
<table>
<thead>
<tr>
<th>ФИО</th>
<th>Страна проживания</th>
</tr>
</thead>
<tbody>
<tr>
<td>Иванов Иван Иванович</td>
<td>USA</td>
</tr>
<tr>
<td>Петров Петр Петрович</td>
<td>Canada</td>
</tr>
<tr>
<td>Иоганн Себастьян Бах</td>
<td>Japan</td>
</tr>
<tr>
<td>Ронни Джеймс Дио</td>
<td>Russia</td>
</tr>
<tr>
<td>Ritchie Blackmore</td>
<td>Russia</td>
</tr>
</tbody>

</table>

```
test_db=# INSERT INTO orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (
5, 'Гитара', 4000);
INSERT 0 5

test_db=# INSERT INTO clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
INSERT 0 5
```
<p dir="auto">Используя SQL синтаксис:</p>
<ul dir="auto">
<li>вычислите количество записей для каждой таблицы</li>
<li>приведите в ответе:
<ul dir="auto">
<li>запросы</li>
<li>результаты их выполнения.</li>

```
test_db=# SELECT COUNT (*) FROM orders;
 count
-------
     5
(1 row)

test_db=# SELECT COUNT (*) FROM clients;
 count
-------
     5
(1 row)
```
</ul>
</li>
</ul>
<h2 dir="auto">Задача 4</h2>
<p dir="auto">Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.</p>
<p dir="auto">Используя foreign keys свяжите записи из таблиц, согласно таблице:</p>
<table>
<thead>
<tr>
<th>ФИО</th>
<th>Заказ</th>
</tr>
</thead>
<tbody>
<tr>
<td>Иванов Иван Иванович</td>
<td>Книга</td>
</tr>
<tr>
<td>Петров Петр Петрович</td>
<td>Монитор</td>
</tr>
<tr>
<td>Иоганн Себастьян Бах</td>
<td>Гитара</td>
</tr>
</tbody>
</table>
<p dir="auto">Приведите SQL-запросы для выполнения данных операций.</p>

```
test_db=# update  clients set booking = 3 where id = 1;
UPDATE 1
test_db=# update  clients set booking = 4 where id = 2;
UPDATE 1
test_db=# update  clients set booking = 5 where id = 3;
UPDATE 1
```
<p dir="auto">Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.</p>

```
test_db=# select * from clients where booking is not null;
 id |       lastname       | country | booking
----+----------------------+---------+---------
  1 | Иванов Иван Иванович | USA     |       3
  2 | Петров Петр Петрович | Canada  |       4
  3 | Иоганн Себастьян Бах | Japan   |       5
(3 rows)
```
<p dir="auto">Подсказк - используйте директиву <code>UPDATE</code>.</p>
<h2 dir="auto"></a>Задача 5</h2>
<p dir="auto">Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4
(используя директиву EXPLAIN).</p>
<p dir="auto">Приведите получившийся результат и объясните что значат полученные значения.</p>

```
test_db=# EXPLAIN ANALYZE SELECT * FROM clients WHERE booking IS NOT NULL;
                                             QUERY PLAN
-----------------------------------------------------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72) (actual time=0.009..0.010 rows=3 loops=1)
   Filter: (booking IS NOT NULL)
   Rows Removed by Filter: 2
 Planning Time: 0.034 ms
 Execution Time: 0.020 ms
(5 rows)
```
  *  <p> EXPLAIN - план выполнения для оператора SELECT по таблицу CLIENTS.
     <p> ANALYZE - фактиеческое выполнение плана.
     <p> cost - стоимость (0.00 - до запуска, 18.10 - общая стоимость) в обращениях.
     <p> rows - количество отобранных строк.
     <p> loops - количество проходов.
     <p> Rows Removed by Filter - количество отброшенных фильтром строк
     <p> Planning\Execution Time - ожидаемое\фактическое время выполнения запроса

<h2 dir="auto">Задача 6</h2>
<p dir="auto">Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).</p>

```
root@0193770d7d61:/# pg_dump -U postgres test_db -f /var/lib/postgresql/bkp/test_dump.sql
```
<p dir="auto">Остановите контейнер с PostgreSQL (но не удаляйте volumes).</p>

```
vagrant@ubuntu-20:~$ docker stop postgres
postgres
```
<p dir="auto">Поднимите новый пустой контейнер с PostgreSQL.</p>

```
vagrant@ubuntu-20:~$ docker run -d --rm --name postgres-new -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v data:/var/lib/postgresql/data -v bkp:/var/lib/postgresql/bkp postgres:12
3af9c538cd13da1c671aa4fc3bdecbb6e13c75fd3a4e9db1a36ed1d384de0dd8
```
<p dir="auto">Восстановите БД test_db в новом контейнере.</p>

```
vagrant@ubuntu-20:~$ docker exec -i postgres-new psql -U postgres -d test_db -f /var/lib/postgresql/bkp/test_dump.sql
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE TABLE
ALTER TABLE
COPY 5
COPY 5
ALTER TABLE
ALTER TABLE
ALTER TABLE
GRANT
GRANT
```

