<h1 dir="auto">Домашнее задание к занятию "6.5. Elasticsearch"</h1>
<h2 dir="auto"></a>Задача 1</h2>
<p dir="auto">В этом задании вы потренируетесь в:</p>
<ul dir="auto">
<li>установке elasticsearch</li>
<li>первоначальном конфигурировании elastcisearch</li>
<li>запуске elasticsearch в docker</li>
</ul>
<p dir="auto">Используя докер образ <a href="https://hub.docker.com/_/centos" rel="nofollow">centos:7</a> как базовый и
<a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html" rel="nofollow">документацию по установке и запуску Elastcisearch</a>:</p>
<ul dir="auto">
<li>составьте Dockerfile-манифест для elasticsearch</li>
<li>соберите docker-образ и сделайте <code>push</code> в ваш docker.io репозиторий</li>
<li>запустите контейнер из получившегося образа и выполните запрос пути <code>/</code> c хост-машины</li>
</ul>
<p dir="auto">Требования к <code>elasticsearch.yml</code>:</p>
<ul dir="auto">
<li>данные <code>path</code> должны сохраняться в <code>/var/lib</code></li>
<li>имя ноды должно быть <code>netology_test</code></li>
</ul>
<p dir="auto">В ответе приведите:</p>
<ul dir="auto">
<li>текст Dockerfile манифеста</li>

```
FROM centos:7
# Определение переменных
ENV PATH=/usr/lib/jvm/jre-11/bin:/usr/lib:$PATH
ENV JAVA_HOME=/elasticsearch-7.15.2/jdk/
ENV ES_HOME=/elasticsearch-7.15.2

# Установка java, wget и perl-Digest-SHA
RUN yum install java-11-openjdk -y
RUN yum install wget -y
RUN yum install perl-Digest-SHA -y

# Качаем Elastic (https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html)
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.2-linux-x86_64.tar.gz \
    && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.2-linux-x86_64.tar.gz.sha512
RUN shasum -a 512 -c elasticsearch-7.15.2-linux-x86_64.tar.gz.sha512 \
    && tar -xzf elasticsearch-7.15.2-linux-x86_64.tar.gz \
    && yum upgrade -y


# Подсовываем файл конфигурации
ADD elasticsearch.yml /elasticsearch-7.15.2/config/

# Добавляем пользователя
RUN groupadd elasticsearch \
    && useradd -g elasticsearch elasticsearch
```
<li>ссылку на образ в репозитории dockerhub</li>

* https://hub.docker.com/layers/179884882/vitsin/netology-homeworks/elastic/images/sha256-afa1124d9013bc433e51a75ca5d90312533860b6bdf073b22118ceb538e35f07?context=repo


<li>ответ <code>elasticsearch</code> на запрос пути <code>/</code> в json виде</li>

```
{
  "name" : "f4d4b37f69c9",
  "cluster_name" : "netology_test",
  "cluster_uuid" : "oFMxMHeKSXesB0lQ3h8bFA",
  "version" : {
    "number" : "7.15.2",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "93d5a7f6192e8a1a12e154a2b81bf6fa7309da0c",
    "build_date" : "2021-11-04T14:04:42.515624022Z",
    "build_snapshot" : false,
    "lucene_version" : "8.9.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```
</ul>
<p dir="auto">Подсказки:</p>
<ul dir="auto">
<li>возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum</li>
<li>при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml</li>
<li>при некоторых проблемах вам поможет docker директива ulimit</li>
<li>elasticsearch в логах обычно описывает проблему и пути ее решения</li>
</ul>
<p dir="auto">Далее мы будем работать с данным экземпляром elasticsearch.</p>
<h2 dir="auto">Задача 2</h2>
<p dir="auto">В этом задании вы научитесь:</p>
<ul dir="auto">
<li>создавать и удалять индексы</li>
<li>изучать состояние кластера</li>
<li>обосновывать причину деградации доступности данных</li>
</ul>
<p dir="auto">Ознакомтесь с <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html" rel="nofollow">документацией</a>
и добавьте в <code>elasticsearch</code> 3 индекса, в соответствии со таблицей:</p>
<table>
<thead>
<tr>
<th>Имя</th>
<th>Количество реплик</th>
<th>Количество шард</th>
</tr>
</thead>
<tbody>
<tr>
<td>ind-1</td>
<td>0</td>
<td>1</td>
</tr>
<tr>
<td>ind-2</td>
<td>1</td>
<td>2</td>
</tr>
<tr>
<td>ind-3</td>
<td>2</td>
<td>4</td>
</tr>
</tbody>
</table>

```
[elasticsearch@f4d4b37f69c9 /]$ curl -X PUT localhost:9200/ind-1 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_replicas": 0,  "number_of_shards": 1 }}'
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-1"}[elasticsearch@f4d4b37f69c9 /]$

[elasticsearch@f4d4b37f69c9 /]$ curl -X PUT localhost:9200/ind-2 -H 'Content-Type: application/json' -d'{ "settings":"number_of_replicas": 1,  "number_of_shards": 2 }}'
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-2"}[elasticsearch@f4d4b37f69c9 /]$

[elasticsearch@f4d4b37f69c9 /]$ curl -X PUT localhost:9200/ind-3 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_replicas": 2,  "number_of_shards": 4 }}'
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-3"}[elasticsearch@f4d4b37f69c9 /]$

```
<p dir="auto">Получите список индексов и их статусов, используя API и <strong>приведите в ответе</strong> на задание.</p>

* Список
```
[elasticsearch@f4d4b37f69c9 /]$ curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases YGSYMswEQjGrIG2UaaFPJQ   1   0         42            0     40.8mb         40.8mb
green  open   ind-1            2SP8eAKCQCyqDRHseOIkWA   1   0          0            0       208b           208b
yellow open   ind-3            BYSPq7_7QpWyXwMF74qoVw   4   2          0            0       832b           832b
yellow open   ind-2            m1bvzQNJRRO9Xq53tg0p5A   2   1          0            0       416b           416b
```

* Статусы
```
[elasticsearch@f4d4b37f69c9 /]$ curl -X GET 'http://localhost:9200/_cluster/health/ind-1?pretty'
{
  "cluster_name" : "netology_test",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1,
  "active_shards" : 1,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}

[elasticsearch@f4d4b37f69c9 /]$ curl -X GET 'http://localhost:9200/_cluster/health/ind-2?pretty'
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 2,
  "active_shards" : 2,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 2,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shar
  ds_percent_as_number" : 44.44444444444444
}

[elasticsearch@f4d4b37f69c9 /]$ curl -X GET 'http://localhost:9200/_cluster/health/ind-3?pretty'
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 4,
  "active_shards" : 4,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 8,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 44.44444444444444
}
```
<p dir="auto">Получите состояние кластера <code>elasticsearch</code>, используя API.</p>

```
[elasticsearch@f4d4b37f69c9 /]$ curl -XGET localhost:9200/_cluster/health/?pretty=true
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 8,
  "active_shards" : 8,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 44.44444444444444
}
```
<p dir="auto">Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?</p>

* При создании индексов указывалось количество реплик. Но сервер 1 и реплики по факту отсутствуют. Поэтому статус желтый. В ind-1 количество реплик - 0, реплик по факту нет. Соответственно статус зеленый.
<p dir="auto">Удалите все индексы.</p>

```
[elasticsearch@f4d4b37f69c9 /]$ curl -X DELETE 'http://localhost:9200/ind-1?pretty'
{
  "acknowledged" : true
}

[elasticsearch@f4d4b37f69c9 /]$ curl -X DELETE 'http://localhost:9200/ind-2?pretty'
{
  "acknowledged" : true
}

[elasticsearch@f4d4b37f69c9 /]$ curl -X DELETE 'http://localhost:9200/ind-3?pretty'
{
  "acknowledged" : true
}
```
<p dir="auto"><strong>Важно</strong></p>
<p dir="auto">При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.</p>
<h2 dir="auto">Задача 3</h2>
<p dir="auto">В данном задании вы научитесь:</p>
<ul dir="auto">
<li>создавать бэкапы данных</li>
<li>восстанавливать индексы из бэкапов</li>
</ul>
<p dir="auto">Создайте директорию <code>{путь до корневой директории с elasticsearch в образе}/snapshots</code>.</p>

* Dockerfile
  ```
  RUN mkdir /elasticsearch-7.15.2/snapshots &&\
    chown elasticsearch:elasticsearch /elasticsearch-7.15.2/snapshots
  ```

* Строка в elasticsearch.yml
  ```
  path.repo: /elasticsearch-7.15.2/snapshots
  ```
<p dir="auto">Используя API <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository" rel="nofollow">зарегистрируйте</a>
данную директорию как <code>snapshot repository</code> c именем <code>netology_backup</code>.</p>
<p dir="auto"><strong>Приведите в ответе</strong> запрос API и результат вызова API для создания репозитория.</p>

* Запрос

  ```
  [elasticsearch@6702d7bfc7cf elasticsearch-7.15.2]$ curl -XPOST localhost:9200/_snapshot/netology_backup?pretty -H 'Content-Type: application/json' -d'{"type": "fs", "settings": { "location":"/elasticsearch-7.15.2/snapshots" }}'
  {
  "acknowledged" : true
  }
  ```
* Вызов

  ```
  [elasticsearch@6702d7bfc7cf elasticsearch-7.15.2]$ curl http://localhost:9200/_snapshot/netology_backup?pretty
  {
    "netology_backup" : {
      "type" : "fs",
      "settings" : {
        "location" : "/elasticsearch-7.15.2/snapshots"
      }
    }
  }
  ```

<p dir="auto">Создайте индекс <code>test</code> с 0 реплик и 1 шардом и <strong>приведите в ответе</strong> список индексов.</p>

* Создаем индекс
  ```
  [elasticsearch@6702d7bfc7cf elasticsearch-7.15.2]$ curl -X PUT localhost:9200/test -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'
  {"acknowledged":true,"shards_acknowledged":true,"index":"test"}
  ```

* Список индексов
  ```
  [elasticsearch@6702d7bfc7cf elasticsearch-7.15.2]$ curl -X GET 'http://localhost:9200/_cat/indices?v'
  health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
  green  open   .geoip_databases 72YBiiJHQDeW6q3v75dPUA   1   0         43            0     40.9mb         40.9mb
  green  open   test             m4YoWLM-R3arAEm2cKj8kQ   1   0          0            0       208b           208b
  ```
<p dir="auto"><a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html" rel="nofollow">Создайте <code>snapshot</code></a>
состояния кластера <code>elasticsearch</code>.</p>

* Создаем
  ```
  [elasticsearch@6702d7bfc7cf elasticsearch-7.15.2]$ curl -X PUT localhost:9200/_snapshot/netology_backup/elasticsearch?wait_for_completion=true
  {"snapshot":{"snapshot":"elasticsearch","uuid":"KikRs269QD-QDJMEGJVS0Q","repository":"netology_backup","version_id":7150299,"version":"7.15.2","indices":["test",".geoip_databases"],"data_streams":[],"include_global_state":true,"state":"SUCCESS","start_time":"2021-12-02T16:32:58.456Z","start_time_in_millis":1638462778456,"end_time":"2021-12-02T16:33:00.058Z","end_time_in_millis":1638462780058,"duration_in_millis":1602,"failures":[],"shards":{"total":2,"failed":0,"successful":2},"feature_states":[{"feature_name":"geoip","indices":[".geoip_databases"]}]}}[elasticsearch@6702d7bfc7cf elasticsearch-7.15.2]$
  ```
<p dir="auto"><strong>Приведите в ответе</strong> список файлов в директории со <code>snapshot</code>ами.</p>

  * Список файлов
  ```
  [elasticsearch@6702d7bfc7cfelasticsearch-7.15.2]$ ls -la /elasticsearch-7.15.2/snapshots/
  total 56
  drwxr-xr-x 1 elasticsearch elasticsearch  4096 Dec  2 16:33 .
  drwxr-xr-x 1 elasticsearch elasticsearch  4096 Nov 30 15:51 ..
  -rw-r--r-- 1 elasticsearch elasticsearch   831 Dec  2 16:33 index-0
  -rw-r--r-- 1 elasticsearch elasticsearch     8 Dec  2 16:33 index.latest
  drwxr-xr-x 4 elasticsearch elasticsearch  4096 Dec  2 16:32 indices
  -rw-r--r-- 1 elasticsearch elasticsearch 27663 Dec  2 16:33 meta-KikRs269QD-QDJMEGJVS0Q.dat
  -rw-r--r-- 1 elasticsearch elasticsearch   440 Dec  2 16:33 snap-KikRs269QD-QDJMEGJVS0Q.dat
  ```
<p dir="auto">Удалите индекс <code>test</code> и создайте индекс <code>test-2</code>. 

* Удаляем индекс
  ```
  [elasticsearch@6702d7bfc7cf elasticsearch-7.15.2]$ curl -X DELETE 'http://localhost:9200/test?pretty'
  {
    "acknowledged" : true
  }
  ```

<strong>Приведите в ответе</strong> список индексов.</p>

* Список:
  ```
  [elasticsearch@6702d7bfc7cf elasticsearch-7.15.2]$ curl -X GET 'http://localhost:9200/_cat/indices?v'
  health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
  green  open   .geoip_databases 72YBiiJHQDeW6q3v75dPUA   1   0         43            0     40.9mb         40.9mb
  ```
* Создаем индекс test-2
  ```
  [elasticsearch@6702d7bfc7cf elasticsearch-7.15.2]$ curl -X PUT localhost:9200/test-2?pretty -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'
  {
    "acknowledged" : true,
    "shards_acknowledged" : true,
    "index" : "test-2"
  }
  ```
* Список:
  ```
  [elasticsearch@6702d7bfc7cf elasticsearch-7.15.2]$ curl -X GET 'http://localhost:9200/_cat/indices?v'
  health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
  green  open   .geoip_databases 72YBiiJHQDeW6q3v75dPUA   1   0         43            0     40.9mb         40.9mb
  green  open   test-2           _Jzf_rmmQUmdfI8CjhkvTQ   1   0          0            0       208b           208b
  ```
<p dir="auto"><a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html" rel="nofollow">Восстановите</a> состояние
кластера <code>elasticsearch</code> из <code>snapshot</code>, созданного ранее.</p>

<p dir="auto"><strong>Приведите в ответе</strong> запрос к API восстановления и итоговый список индексов.</p>

* Восстанавливаем:
  ```
  [elasticsearch@6702d7bfc7cf elasticsearch-7.15.2]$ curl -X POST localhost:9200/_snapshot/netology_backup/elasticsearch/_restore?pretty -H 'Content-Type: application/json' -d'{"include_global_state":true}'
  {
    "accepted" : true
  }
  ```
* Список:
  ```
  [elasticsearch@6702d7bfc7cf elasticsearch-7.15.2]$ curl -X GET 'http://localhost:9200/_cat/indices?v'
  health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
  green  open   .geoip_databases 45wDA6pqRzeTu4lbcdxRBg   1   0         43            0     40.9mb         40.9mb
  green  open   test-2           _Jzf_rmmQUmdfI8CjhkvTQ   1   0          0            0       208b           208b
  green  open   test             vr2ZFJMXSFCP4OdtrAYUbg   1   0          0            0       208b           208b
  ```
