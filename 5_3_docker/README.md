
<hr>
<h2 dir="auto">Задача 1</h2>
<p dir="auto">Сценарий выполения задачи:</p>
<ul dir="auto">
<li>создайте свой репозиторий на <a href="https://hub.docker.com" rel="nofollow">https://hub.docker.com</a>;</li>
<li>выберите любой образ, который содержит веб-сервер Nginx;</li>
<li>создайте свой fork образа;</li>
<li>реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:</li>
</ul>
<div class="snippet-clipboard-content position-relative overflow-auto" data-snippet-clipboard-copy-content="&lt;html&gt;
&lt;head&gt;
Hey, Netology
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;I’m DevOps Engineer!&lt;/h1&gt;
&lt;/body&gt;
&lt;/html&gt;
"><pre><code>&lt;html&gt;
&lt;head&gt;
Hey, Netology
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;I’m DevOps Engineer!&lt;/h1&gt;
&lt;/body&gt;
&lt;/html&gt;
</code></pre></div>
<p dir="auto">Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на <a href="https://hub.docker.com/username_repo" rel="nofollow">https://hub.docker.com/username_repo</a>.</p>

* Запуск контейнера с nginx 

```
vagrant@ubuntu-20:~/docker_base/nginx$ docker run -d -p 80:80 --name dz-nginx vitsin/nginx:v0.0.1
42e1ecc0480bf2da3297df6e6c615ad96bb6c8e71b92fefc5ac6cc106b800f42
```
* Проверка условия задачи:

```
vagrant@ubuntu-20:~/docker_base/nginx$ curl http://172.17.0.1
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>

```

* Ссылка на образ:
https://hub.docker.com/layers/176937793/vitsin/netology-homeworks/v0.0.1/images/sha256-a91ae9cb856a54312c538a09bb075097dcd48f5f80a3675711cabbdaaee1b1be?context=repo


<h2 dir="auto">Задача 2</h2>
<p dir="auto">Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"</p>
<p dir="auto">Детально опишите и обоснуйте свой выбор.</p>
<p dir="auto">--</p>
<p dir="auto">Сценарий:</p>
<ul dir="auto">
<li>Высоконагруженное монолитное java веб-приложение;</li>

<a> Монолитное - следовательно, для деления на микросервисы (основное применение докера) придется приложить немало усилий и человекочасов. Высоконагруженное - т.е. критическая зависимость от физических ресурсов. Исходя из этого - физическая машина, а то и кластер.</a>

<li>Nodejs веб-приложение;</li>

<a>Основное предназначение докера - как раз такие приложения.</a>
<li>Мобильное приложение c версиями для Android и iOS;</li>
<a>Смущает наличие GUI. Если приложениеи просто оперирует данными, а GUI отрисовывается, к примеру, на самом устройстве, то можно и докер. Но это редкая конфигурация. Поэтому отдам предпочтение физическому устройству. Или, что оптимальней, полноценной виртуальной машине.</a>
<li>Шина данных на базе Apache Kafka;</li>
<a>Если потеря данных не грозит финансовыми потерями, то докер. иначе - ВМ</a>
<li>Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;</li>
<a>Ну тут по условию большая вариативность. Рискну предположить что Elastic - лучше оставить на физике, а logstash и kibana - можно и в докер. Kibana - точно, так как это просто веб-морда для визуализации. logstash - тут варианты, так как есть работа с данными, это не микросервис. Но можно хранилище вывести в отдельный volume и переподключать при перезапуске контейнера. Ну а Elastic - достаточно требователен к ресурсам.</a>
<li>Мониторинг-стек на базе Prometheus и Grafana;</li>
<a>Докер. Grafana - инструмент визуализации, Prometheus - агрегатор. Данные используются в оперативном режиме.</a>
<li>MongoDB, как основное хранилище данных для java-приложения;</li>
<a>БД в докере могут себе позволить только те, кому сохранность данных не критична. Физика или ВМ</a>
<li>Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.</li>
<a>Я бы поставил на физическую машину. Все таки хранение версий и работа с ними.</a>
</ul>
<h2 dir="auto">Задача 3</h2>
<ul dir="auto">
<li>Запустите первый контейнер из образа <em><strong>centos</strong></em> c любым тэгом в фоновом режиме, подключив папку <code>/data</code> из текущей рабочей директории на хостовой машине в <code>/data</code> контейнера;</li>

* Запуск контейнера с Centos
```
vagrant@ubuntu-20:~/docker_base$ docker run -itd -v ~/docker_base/data:/data --name centos-d centos:latest
5244c07e6f40b2d57df0418735d0f084953631c241f6d18cff8377ff016f27e0
```
<li>Запустите второй контейнер из образа <em><strong>debian</strong></em> в фоновом режиме, подключив папку <code>/data</code> из текущей рабочей директории на хостовой машине в <code>/data</code> контейнера;</li>

* Запуск контейнера с debian
```
vagrant@ubuntu-20:~/docker_base$ docker run -itd -v ~/docker_base/data:/data --name debian-d debian:latest
2307957cd0701ba5ea7d142f788d7e244228018bfe2255ebb4d6213f4f9b0bf5
```
<li>Подключитесь к первому контейнеру с помощью <code>docker exec</code> и создайте текстовый файл любого содержания в <code>/data</code>;</li>
* Запускаем vi в контейнере с Centos

```
vagrant@ubuntu-20:~/docker_base$ docker exec -it centos-d touch /data/1st_txt_file
```
<li>Добавьте еще один файл в папку <code>/data</code> на хостовой машине;</li>
* Добавление второго файла

```
vagrant@ubuntu-20:~/docker_base/data$ echo random_content > 2nd_txt_file
```

<li>Подключитесь во второй контейнер и отобразите листинг и содержание файлов в <code>/data</code> контейнера.</li>

* Подключение к контейнеру с Debian
```
vagrant@ubuntu-20:~/docker_base/data$ docker exec -it debian-d /bin/bash
root@2307957cd070:/#
```

* Листинг /data
```
root@2307957cd070:/# ls /data/
1st_txt_file  2nd_txt_file
```

* Содержание файлов
```
root@2307957cd070:/# cat /data/1st_txt_file
random netology content
root@2307957cd070:/# cat /data/2nd_txt_file
random_content
```
</ul>
<h2 dir="auto">Задача 4 (*)</h2>
<p dir="auto">Воспроизвести практическую часть лекции самостоятельно.</p>
<p dir="auto">Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.</p>

* Запуск и проверка:
```
vagrant@ubuntu-20:~/docker_base/centos$ docker run -itd vitsin/netology-homeworks:ansible
5baccf99dd12ff72aab71a2fad4f0fe7374d9c372ad6a26e9b1b70bdaa010e27
vagrant@ubuntu-20:~/docker_base/centos$ docker exec 5baccf99dd12ff72aab71a2fad4f0fe7374d9c372ad6a26e9b1b70bdaa010e27 ans
ible --version
ansible 2.9.27
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.6/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.6.8 (default, Nov  2 2021, 13:01:57) [GCC 8.4.1 20200928 (Red Hat 8.4.1-1)]
  ```
  * Ссылка:
  <a>https://hub.docker.com/r/vitsin/netology-homeworks/tags</a>

  * Команда:
  <a>docker pull vitsin/netology-homeworks:ansible</a>
