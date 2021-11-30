
<h2 dir="auto">Введение</h2>
<p dir="auto">Перед выполнением задания вы можете ознакомиться с
<a href="https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md">дополнительными материалами</a>.</p>
<h2 dir="auto">Задача 1</h2>
<p dir="auto">Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.</p>

```
vagrant@ubuntu-20:/$ docker pull mysql:8.0

vagrant@ubuntu-20:/$ docker volume create mysql_data
mysql_data

vagrant@ubuntu-20:/$ docker run -d --rm --name mysql8 -e MYSQL_ROOT_PASSWORD=mysql -ti -p 3306:3306 -v mysql_data:/etc/m
ysql/data mysql:8.0
bde87a3027c6ba1d3753c8060599537c440b601a0749541ce38f94aaec4ab63f
```

<p dir="auto">Изучите <a href="https://github.com/netology-code/virt-homeworks/tree/master/06-db-03-mysql/test_data">бэкап БД</a> и
восстановитесь из него.</p>

```
root@b0242f173cfc:/# mysql -u root -p testdb < /etc/mysql/data/test_dump.sql
Enter password:
root@b0242f173cfc:/#
```
<p dir="auto">Перейдите в управляющую консоль <code>mysql</code> внутри контейнера.</p>

```
vagrant@ubuntu-20:~$ docker exec -it mysql8 mysql -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 17
Server version: 8.0.27 MySQL Community Server - GPL

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```
<p dir="auto">Используя команду <code>\h</code> получите список управляющих команд.</p>

```
mysql> \h

For information about MySQL products and services, visit:
   http://www.mysql.com/
For developer information, including the MySQL Reference Manual, visit:
   http://dev.mysql.com/
To buy MySQL Enterprise support, training, or other products, visit:
   https://shop.mysql.com/

List of all MySQL commands:
Note that all text commands must be first on line and end with ';'
?         (\?) Synonym for `help'.
clear     (\c) Clear the current input statement.
connect   (\r) Reconnect to the server. Optional arguments are db and host.
delimiter (\d) Set statement delimiter.
edit      (\e) Edit command with $EDITOR.
ego       (\G) Send command to mysql server, display result vertically.
exit      (\q) Exit mysql. Same as quit.
go        (\g) Send command to mysql server.
help      (\h) Display this help.
nopager   (\n) Disable pager, print to stdout.
notee     (\t) Don't write into outfile.
pager     (\P) Set PAGER [to_pager]. Print the query results via PAGER.
print     (\p) Print current command.
prompt    (\R) Change your mysql prompt.
quit      (\q) Quit mysql.
rehash    (\#) Rebuild completion hash.
source    (\.) Execute an SQL script file. Takes a file name as an argument.
status    (\s) Get status information from the server.
system    (\!) Execute a system shell command.
tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
use       (\u) Use another database. Takes database name as argument.
charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
warnings  (\W) Show warnings after every statement.
nowarning (\w) Don't show warnings after every statement.
resetconnection(\x) Clean session context.
query_attributes Sets string parameters (name1 value1 name2 value2 ...) for the next query to pick up.

For server side help, type 'help contents'
```
<p dir="auto">Найдите команду для выдачи статуса БД и <strong>приведите в ответе</strong> из ее вывода версию сервера БД.</p>

```
mysql> \s
--------------
mysql  Ver 8.0.27 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:          17
Current database:
Current user:           root@localhost
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         8.0.27 MySQL Community Server - GPL
Protocol version:       10
Connection:             Localhost via UNIX socket
Server characterset:    utf8mb4
Db     characterset:    utf8mb4
Client characterset:    latin1
Conn.  characterset:    latin1
UNIX socket:            /var/run/mysqld/mysqld.sock
Binary data as:         Hexadecimal
Uptime:                 30 min 13 sec

Threads: 2  Questions: 91  Slow queries: 0  Opens: 203  Flush tables: 3  Open tables: 121  Queries per second avg: 0.050
--------------

mysql>
```
<p dir="auto">Подключитесь к восстановленной БД и получите список таблиц из этой БД.</p>

```
mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| testdb             |
+--------------------+
5 rows in set (0.00 sec)

mysql> USE testdb
Database changed

mysql> SHOW TABLES;
+------------------+
| Tables_in_testdb |
+------------------+
| orders           |
+------------------+
1 row in set (0.00 sec)

mysql>
```
<p dir="auto"><strong>Приведите в ответе</strong> количество записей с <code>price</code> &gt; 300.</p>

```
mysql> SELECT COUNT(*) FROM orders WHERE price > 300;
+----------+
| COUNT(*) |
+----------+
|        1 |
+----------+
1 row in set (0.03 sec)

mysql>

mysql> SELECT * FROM orders WHERE price > 300;
+----+----------------+-------+
| id | title          | price |
+----+----------------+-------+
|  2 | My little pony |   500 |
+----+----------------+-------+
1 row in set (0.00 sec)

mysql>
```

<h2 dir="auto">Задача 2</h2>
<p dir="auto">Создайте пользователя test в БД c паролем test-pass, используя:</p>
<ul dir="auto">
<li>плагин авторизации mysql_native_password</li>
<li>срок истечения пароля - 180 дней</li>
<li>количество попыток авторизации - 3</li>
<li>максимальное количество запросов в час - 100</li>
<li>аттрибуты пользователя:
<ul dir="auto">
<li>Фамилия "Pretty"</li>
<li>Имя "James"</li>

```
mysql> CREATE USER 'test'@'localhost' IDENTIFIED BY 'test-pass';
Query OK, 0 rows affected (0.06 sec)

mysql> ALTER USER 'test'@'localhost' ATTRIBUTE '{"fname":"James", "lname":"Pretty"}';
Query OK, 0 rows affected (0.05 sec)

mysql> ALTER USER 'test'@'localhost'
    -> IDENTIFIED BY 'test-pass'
    -> WITH
    -> MAX_QUERIES_PER_HOUR 100
    -> PASSWORD EXPIRE INTERVAL 180 DAY
    -> FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2;
Query OK, 0 rows affected (0.04 sec)
```
</ul>
<p dir="auto">Предоставьте привелегии пользователю <code>test</code> на операции SELECT базы <code>test_db</code>.</p>

```
mysql> GRANT SELECT ON test_db.* TO 'test'@'localhost';
Query OK, 0 rows affected, 1 warning (0.04 sec)
```
<p dir="auto">Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю <code>test</code> и
<strong>приведите в ответе к задаче</strong>.</p>

```
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
+------+-----------+---------------------------------------+
| USER | HOST      | ATTRIBUTE                             |
+------+-----------+---------------------------------------+
| test | localhost | {"fname": "James", "lname": "Pretty"} |
+------+-----------+---------------------------------------+
1 row in set (0.01 sec)
```
<h2 dir="auto"><a id="user-content-задача-3" class="anchor" aria-hidden="true" href="#задача-3"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Задача 3</h2>
<p dir="auto">Установите профилирование <code>SET profiling = 1</code>.
Изучите вывод профилирования команд <code>SHOW PROFILES;</code>.</p>
<p dir="auto">Исследуйте, какой <code>engine</code> используется в таблице БД <code>test_db</code> и <strong>приведите в ответе</strong>.</p>

```
mysql> SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'testdb';
+------------+--------+
| TABLE_NAME | ENGINE |
+------------+--------+
| orders     | InnoDB |
+------------+--------+
1 row in set (0.00 sec)
```
<p dir="auto">Измените <code>engine</code> и <strong>приведите время выполнения и запрос на изменения из профайлера в ответе</strong>:</p>
<ul dir="auto">
<li>на <code>MyISAM</code></li>

```
mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.10 sec)
Records: 5  Duplicates: 0  Warnings: 0
```
<li>на <code>InnoDB</code></li>

```
mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (0.13 sec)
Records: 5  Duplicates: 0  Warnings: 0
```

```
mysql> SHOW PROFILES;
+----------+------------+----------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                  |
+----------+------------+----------------------------------------------------------------------------------------+
|        1 | 0.00017275 | SHOW PROGILES                                                                          |
|        2 | 0.00011400 | SET profiling = 1                                                                      |
|        3 | 0.00027450 | SELECT TABLE_NAME, ENGINE FROM informayion_schema.TABLES WHERE TABLE_SCHEMA = 'testdb' |
|        4 | 0.00300075 | SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'testdb' |
|        5 | 0.10583950 | ALTER TABLE orders ENGINE = MyISAM                                                     |
|        6 | 0.13902675 | ALTER TABLE orders ENGINE = InnoDB                                                     |
+----------+------------+----------------------------------------------------------------------------------------+
6 rows in set, 1 warning (0.00 sec)
```

  <p> На MyISAM переключился за 0,10, на InnoDB за 0,14.</p> 

<h2 dir="auto">Задача 4</h2>
<p dir="auto">Изучите файл <code>my.cnf</code> в директории /etc/mysql.</p>
<p dir="auto">Измените его согласно ТЗ (движок InnoDB):</p>
<ul dir="auto">
<li>Скорость IO важнее сохранности данных</li>
<li>Нужна компрессия таблиц для экономии места на диске</li>
<li>Размер буффера с незакомиченными транзакциями 1 Мб</li>
<li>Буффер кеширования 30% от ОЗУ</li>
<li>Размер файла логов операций 100 Мб</li>
</ul>
<p dir="auto">Приведите в ответе измененный файл <code>my.cnf</code>.</p>

```
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

# Set IO Speed Priority
# 0 - скорость
# 1 - сохранность
# 2 - универсальный параметр
innodb_flush_log_at_trx_commit = 0 

# Set compression
# Barracuda - формат файла с сжатием
innodb_file_format=Barracuda

# Set buffer size
innodb_log_buffer_size	= 1M

# Set cache size
key_buffer_size = 305М

#Set log size
max_binlog_size	= 100M
```
