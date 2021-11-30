<h1 dir="auto">>Домашнее задание к занятию "6.4. PostgreSQL"</h1>

<h2 dir="auto">Задача 1</h2>
<p dir="auto">Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.</p>

```
vagrant@ubuntu-20:~$ docker pull postgres:13
13: Pulling from library/postgres
eff15d958d66: Pull complete
de2b4ab3ade5: Pull complete
108afa831d95: Pull complete
29f36a620c9a: Pull complete
5c78220cdd7f: Pull complete
c7fc8d555476: Pull complete
6cf6f19a1e0f: Pull complete
5367c2439241: Pull complete
c64bc7d70f1c: Pull complete
1ef4f481a727: Pull complete
965b11f6bf7b: Pull complete
8076d08e9bcf: Pull complete
2340e84c9fe1: Pull complete
Digest: sha256:daf0514687347b649483cf56d3aec40a0f130d5cacea0629f5b764fa880e08da
Status: Downloaded newer image for postgres:13
docker.io/library/postgres:13
vagrant@ubuntu-20:~$ docker volume create ps_data
ps_data
vagrant@ubuntu-20:~$ docker run -d --rm --name postgres13 -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v ps_data:/var
/lib/postgresql/data postgres:13
5e671e92457990cd3d8bcf5776282683ad13ccf592df8c0089964a02ed9b03b0
```
<p dir="auto">Подключитесь к БД PostgreSQL используя <code>psql</code>.</p>

```
vagrant@ubuntu-20:~$ docker exec -it postgres13 psql -U postgres
psql (13.5 (Debian 13.5-1.pgdg110+1))
Type "help" for help.

postgres=#
```
<p dir="auto">Воспользуйтесь командой <code>\?</code> для вывода подсказки по имеющимся в <code>psql</code> управляющим командам.</p>
<p dir="auto"><strong>Найдите и приведите</strong> управляющие команды для:</p>
<ul dir="auto">
<li>вывода списка БД</li>

```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)
```
<li>подключения к БД</li>

```
postgres=# \c postgres
You are now connected to database "postgres" as user "postgres".
```
<li>вывода списка таблиц</li>

* Пустая база
```
postgres=# \dt
Did not find any relations.
```

* Просмотр таблиц, включая системные объекты
```
postgres=# \dtS
                    List of relations
   Schema   |          Name           | Type  |  Owner
------------+-------------------------+-------+----------
 pg_catalog | pg_aggregate            | table | postgres
 pg_catalog | pg_am                   | table | postgres
 pg_catalog | pg_amop                 | table | postgres
 pg_catalog | pg_amproc               | table | postgres
 pg_catalog | pg_attrdef              | table | postgres
 pg_catalog | pg_attribute            | table | postgres
 pg_catalog | pg_auth_members         | table | postgres
```

<li>вывода описания содержимого таблиц</li>

```
postgres=# \dS+ pg_index
                                      Table "pg_catalog.pg_index"
     Column     |     Type     | Collation | Nullable | Default | Storage  | Stats target | Description
----------------+--------------+-----------+----------+---------+----------+--------------+-------------
 indexrelid     | oid          |           | not null |         | plain    |              |
 indrelid       | oid          |           | not null |         | plain    |              |
 indnatts       | smallint     |           | not null |         | plain    |              |
 indnkeyatts    | smallint     |           | not null |         | plain    |              |
 indisunique    | boolean      |           | not null |         | plain    |              |
 indisprimary   | boolean      |           | not null |         | plain    |              |
 indisexclusion | boolean      |           | not null |         | plain    |              |
 indimmediate   | boolean      |           | not null |         | plain    |              |
 indisclustered | boolean      |           | not null |         | plain    |              |
 indisvalid     | boolean      |           | not null |         | plain    |              |
 indcheckxmin   | boolean      |           | not null |         | plain    |              |
 indisready     | boolean      |           | not null |         | plain    |              |
 indislive      | boolean      |           | not null |         | plain    |              |
 indisreplident | boolean      |           | not null |         | plain    |              |
 indkey         | int2vector   |           | not null |         | plain    |              |
 indcollation   | oidvector    |           | not null |         | plain    |              |
 indclass       | oidvector    |           | not null |         | plain    |              |
 indoption      | int2vector   |           | not null |         | plain    |              |
 indexprs       | pg_node_tree | C         |          |         | extended |              |
 indpred        | pg_node_tree | C         |          |         | extended |              |
Indexes:
    "pg_index_indexrelid_index" UNIQUE, btree (indexrelid)
    "pg_index_indrelid_index" btree (indrelid)
Access method: heap
```

<li>выхода из psql</li>

```
postgres=# \q
```
</ul>
<h2 dir="auto">Задача 2</h2>
<p dir="auto">Используя <code>psql</code> создайте БД <code>test_database</code>.</p>

```
postgres=# CREATE DATABASE test_database;
CREATE DATABASE
```
<p dir="auto">Изучите <a href="https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data">бэкап БД</a>.</p>
<p dir="auto">Восстановите бэкап БД в <code>test_database</code>.</p>

```
root@5e671e924579:/# psql -U postgres -f /var/lib/postgresql/data/test_dump.sql test_database
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
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval
--------
      8
(1 row)

ALTER TABLE
```
<p dir="auto">Перейдите в управляющую консоль <code>psql</code> внутри контейнера.</p>
<p dir="auto">Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.</p>

```
postgres=# \c test_database
You are now connected to database "test_database" as user "postgres".
test_database=# \dt
         List of relations
 Schema |  Name  | Type  |  Owner
--------+--------+-------+----------
 public | orders | table | postgres
(1 row)

test_database=# ANALYZE VERBOSE public.orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
```
<p dir="auto">Используя таблицу <a href="https://postgrespro.ru/docs/postgresql/12/view-pg-stats" rel="nofollow">pg_stats</a>, найдите столбец таблицы <code>orders</code>
с наибольшим средним значением размера элементов в байтах.</p>
<p dir="auto"><strong>Приведите в ответе</strong> команду, которую вы использовали для вычисления и полученный результат.</p>

```
test_database=# select avg_width from pg_stats where tablename='orders';
 avg_width
-----------
         4
        16
         4
(3 rows)
```
<h2 dir="auto">Задача 3</h2>
<p dir="auto">Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price&gt;499 и orders_2 - price&lt;=499).</p>
<p dir="auto">Предложите SQL-транзакцию для проведения данной операции.</p>

* Переименовываем существующую таблицу
```
test_database=# ALTER TABLE orders RENAME TO old_orders;
ALTER TABLE
```

* Создаем партиционированную таблицу
```
test_database=# CREATE TABLE orders (id integer, title varchar(80), price integer) PARTITION BY RANGE(price);
CREATE TABLE
```

* Создаем таблицу orders_1 для значений больше 499
```
test_database=# CREATE TABLE orders_1 PARTITION OF orders FOR VALUES FROM (499) to (999999999);
CREATE TABLE
```

* Создаем таблицу orders_2 для значений меньше 500
```
test_database=# CREATE TABLE orders_2 PARTITION OF orders FOR VALUES FROM (0) to (499);
CREATE TABLE
```

* Заполняем данными из старой orders
```
test_database=# INSERT INTO orders (id, title, price) SELECT * FROM old_orders;
INSERT 0 8
```

* Удаляем первоначальную таблицу orders
```
test_database=# DROP TABLE old_orders;
DROP TABLE
```
<p dir="auto">Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?</p>

* Конечно, если при начальном планировании сделать таблицу orders партицинированной.

<h2 dir="auto">Задача 4</h2>
<p dir="auto">Используя утилиту <code>pg_dump</code> создайте бекап БД <code>test_database</code>.</p>

```
root@5e671e924579:/# pg_dump -U postgres -d test_database > /var/lib/postgresql/data/test_database_dump.sql
```
<p dir="auto">Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца <code>title</code> для таблиц <code>test_database</code>?</p>

* Можно путем добавления какого-нибудь индекса. 
```
CREATE INDEX ON orders ((lower(title)));
```
