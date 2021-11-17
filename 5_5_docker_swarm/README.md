
<h2 dir="auto">Задача 1</h2>
<p dir="auto">Дайте письменые ответы на следующие вопросы:</p>
<ul dir="auto">
<li>В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?</li>

 * replication - режим, в котором изначально задается количество реплик для каждого сервиса. Global - распространяет сервис на все ноды без исключений.
<li>Какой алгоритм выбора лидера используется в Docker Swarm кластере?</li>

* Первым лидером назначется хост, где производится инциализация swarm. Остальные менеджеры назначаются командой promote. Если лидер недоступен, то роль передается одному из stand-by менеджеров (наименее загруженному). Для переноса роли лидера на конкретный хост потребуется вывести все оставшиеся менеджерские хосты, кроме требуемого. Тогда роль перейдет автоматически. После чего можно добавить роли обратно. На работу swarm в целом это не повлияет.
<li>Что такое Overlay Network?</li>

* Фактически это наложенная сеть для общения контейнеров на разных хостах docker swarm. использует порт 4789/UDP. Есть возможность шифрования.
</ul>
<h2 dir="auto">Задача 2</h2>
<p dir="auto">Создать ваш первый Docker Swarm кластер в Яндекс.Облаке</p>
<p dir="auto">Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:</p>
<div class="snippet-clipboard-content position-relative overflow-auto" data-snippet-clipboard-copy-content="docker node ls
"><pre><code>docker node ls
</code></pre></div>
____________________________________________

```
[root@node01 ~]# docker node ls
ID                            HOSTNAME             STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
541f1zl4a5dx0qa0pflp3m7xk *   node01.netology.yc   Ready     Active         Leader           20.10.10
ygqokcjxcfnplipkdbb44v5ai     node02.netology.yc   Ready     Active         Reachable        20.10.10
a67t3jzasjtyb815ti9m9od9v     node03.netology.yc   Ready     Active         Reachable        20.10.10
rfkcyn29966ouxke4915enpz1     node04.netology.yc   Ready     Active                          20.10.10
467mj3zhvvo0gq8a0vpjvbdj0     node05.netology.yc   Ready     Active                          20.10.10
ktlf91f3ygwncswl24g37m1ik     node06.netology.yc   Ready     Active                          20.10.10
```
<h2 dir="auto">Задача 3</h2>
<p dir="auto">Создать ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.</p>
<p dir="auto">Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:</p>
<div class="snippet-clipboard-content position-relative overflow-auto" data-snippet-clipboard-copy-content="docker service ls
"><pre><code>docker service ls
</code></pre></div>
___________________________________________


```
[root@node01 ~]# docker service ls
ID             NAME                                MODE         REPLICAS   IMAGE
  PORTS
8k1lt89m1cg6   swarm_monitoring_alertmanager       replicated   1/1        stefanprodan/swarmprom-alertmanager:v0.14.0

b79tdw0y9p84   swarm_monitoring_caddy              replicated   1/1        stefanprodan/caddy:latest
  *:3000->3000/tcp, *:9090->9090/tcp, *:9093-9094->9093-9094/tcp
yochv5n90k9l   swarm_monitoring_cadvisor           global       6/6        google/cadvisor:latest

azanas6precg   swarm_monitoring_dockerd-exporter   global       6/6        stefanprodan/caddy:latest

cni2fcayycig   swarm_monitoring_grafana            replicated   1/1        stefanprodan/swarmprom-grafana:5.3.4

ph31wukzcef9   swarm_monitoring_node-exporter      global       6/6        stefanprodan/swarmprom-node-exporter:v0.16.0

ltxfgikj8zgk   swarm_monitoring_prometheus         replicated   1/1        stefanprodan/swarmprom-prometheus:v2.5.0

awzbxd3jgnvi   swarm_monitoring_unsee              replicated   1/1        cloudflare/unsee:v0.8.0
```
<h2 dir="auto">Задача 4 (*)</h2>
<p dir="auto">Выполнить на лидере Docker Swarm кластера команду (указанную ниже) и дать письменное описание её функционала, что она делает и зачем она нужна:</p>
<div class="snippet-clipboard-content position-relative overflow-auto" data-snippet-clipboard-copy-content="# см.документацию: https://docs.docker.com/engine/swarm/swarm_manager_locking/
docker swarm update --autolock=true
"><pre><code># см.документацию: https://docs.docker.com/engine/swarm/swarm_manager_locking/
docker swarm update --autolock=true
</code></pre></div>
_____________________________________________

<a> Этой командой мы блокируем swarm для повышения уровня безопасности ключом. К примеру, необходимо разблокировать swarm после перезапуска, иначе он не запустится. Журналы будут также недоступны. К работающему swarm можно добавлять новые узлы, но, к примеру, сделать хост менеджером уже не получится без разблокировки.</a>

<a>Кстати, в поисках информации, наткнулся на интересную статью о журналах swarm, их шифровании и работе с ними.</a>

https://medium.com/lucjuggery/raft-logs-on-swarm-mode-1351eff1e690

```
[root@node01 ~]# docker swarm update --autolock=true
Swarm updated.
To unlock a swarm manager after it restarts, run the `docker swarm unlock`
command and provide the following key:

    SWMKEY-1-jgfOAW2Yf/qXwZ64uRu9wDSyu3qps+fpaqLHqDFbqZg

Please remember to store this key in a password manager, since without it you
will not be able to restart the manager.
```




