<h1>Домашнее задание к занятию "6.6. Troubleshooting"</h1>
<h2 dir="auto">Задача 1</h2>
<p dir="auto">Перед выполнением задания ознакомьтесь с документацией по <a href="https://docs.mongodb.com/manual/administration/" rel="nofollow">администрированию MongoDB</a>.</p>
<p dir="auto">Пользователь (разработчик) написал в канал поддержки, что у него уже 3 минуты происходит CRUD операция в MongoDB и её
нужно прервать.</p>
<p dir="auto">Вы как инженер поддержки решили произвести данную операцию:</p>
<ul dir="auto">
<li>напишите список операций, которые вы будете производить для остановки запроса пользователя</li>

* Найти и уничтожить:
```
db.currentOp({"secs_running":{$gte:180}})
db.killOp(operationID)
```
<li>предложите вариант решения проблемы с долгими (зависающими) запросами в MongoDB</li>

  * Возможно стоит перестроить индексы относящиеся к проблемным запросам
</ul>


<h2 dir="auto">Задача 2</h2>
<p dir="auto">Перед выполнением задания познакомьтесь с документацией по <a href="https://redis.io/topics/latency" rel="nofollow">Redis latency troobleshooting</a>.</p>
<p dir="auto">Вы запустили инстанс Redis для использования совместно с сервисом, который использует механизм TTL.
Причем отношение количества записанных key-value значений к количеству истёкших значений есть величина постоянная и
увеличивается пропорционально количеству реплик сервиса.</p>
<p dir="auto">При масштабировании сервиса до N реплик вы увидели, что:</p>
<ul dir="auto">
<li>сначала рост отношения записанных значений к истекшим</li>
<li>Redis блокирует операции записи</li>
</ul>
<p dir="auto">Как вы думаете, в чем может быть проблема?</p>

  * Очевидно, что проблема возникла при кратном увеличении количества значений. Механизм проверки блокирует запись при наличии более 25% ключей с истекшим сроком действия по отношению к общему количеству.

<h2 dir="auto">Задача 3</h2>
<p dir="auto">Перед выполнением задания познакомьтесь с документацией по <a href="https://dev.mysql.com/doc/refman/8.0/en/common-errors.html" rel="nofollow">Common Mysql errors</a>.</p>
<p dir="auto">Вы подняли базу данных MySQL для использования в гис-системе. При росте количества записей, в таблицах базы,
пользователи начали жаловаться на ошибки вида:</p>
<div class="highlight highlight-source-python position-relative overflow-auto" data-snippet-clipboard-copy-content="InterfaceError: (InterfaceError) 2013: Lost connection to MySQL server during query u'SELECT..... '
"><pre><span class="pl-v">InterfaceError</span>: (<span class="pl-v">InterfaceError</span>) <span class="pl-c1">2013</span>: <span class="pl-v">Lost</span> <span class="pl-s1">connection</span> <span class="pl-s1">to</span> <span class="pl-v">MySQL</span> <span class="pl-s1">server</span> <span class="pl-s1">during</span> <span class="pl-s1">query</span> <span class="pl-s">u'SELECT..... '</span></pre></div>
<p dir="auto">Как вы думаете, почему это начало происходить и как локализовать проблему?</p>
<p dir="auto">Какие пути решения данной проблемы вы можете предложить?</p>

  * Судя по ошибке - отваливается сетевой интерфейс. Если проблема в сетевой инфраструктуре, то можно увеличить время ожидания интерфейса: net_read_timeout и увеличить максимальное количество значений - max_connections

  * Возможно ошибки возникают из-за роста нагрузки.
    <p> Для решения можно попробовать:</p>
    <p> - добавить системных ресурсов хосту
    <p> - Оптимизировать и ускорить запросы путем создания индексов
    <p> - Увеличить значения параметров таймаута: coonect_timeout, wait_timeout, interactive_timeout 



  
<h2 dir="auto">Задача 4</h2>
<p dir="auto">Перед выполнением задания ознакомтесь со статьей <a href="https://www.percona.com/blog/2020/06/05/10-common-postgresql-errors/" rel="nofollow">Common PostgreSQL errors</a> из блога Percona.</p>
<p dir="auto">Вы решили перевести гис-систему из задачи 3 на PostgreSQL, так как прочитали в документации, что эта СУБД работает с
большим объемом данных лучше, чем MySQL.</p>
<p dir="auto">После запуска пользователи начали жаловаться, что СУБД время от времени становится недоступной. В dmesg вы видите, что:</p>
<p dir="auto"><code>postmaster invoked oom-killer</code></p>
<p dir="auto">Как вы думаете, что происходит?</p>

  * Был вызван системный процесс Out Of Memory killer, который предназначен для освобождения памяти путем завершения каких-то процессов. Процессы определяются путем присваиванием оценки (OOM_score). OOM_score умножается на размер запрашиваемой памяти. Поскольку в алгоритм OOM_killer входит азадча завершить как можно меньшее количество процессов и освободить как можно большее количество памяти, то завершаются процессы с наибольшим значением.
<p dir="auto">Как бы вы решили данную проблему?</p>

1. Отключить OOM Killer и с нетерпением ждать краха всей системы

  ```
  sudo -s sysctl -w vm.oom-kill = 0
  ```

2. Читаем <a href="https://postgrespro.ru/docs/postgresql/9.4/runtime-config-resource" rel="nofollow">Потребление ресурсов</a>. Выставляем shared_buffer на 25% от общего размера RAM.

3. Добавить RAM.
<hr>
