
<h2 dir="auto">Задача 1</h2>
<p dir="auto">Создать собственный образ операционной системы с помощью Packer.</p>
<p dir="auto">Для получения зачета, вам необходимо предоставить:</p>
<ul dir="auto">
<li>Скриншот страницы, как на слайде из презентации (слайд 37).</li>
</ul>

 *
```
vagrant@ubuntu-20:~/yandex-cloud/terraform$ yc compute image list
+----------------------+---------------+--------+----------------------+--------+
|          ID          |     NAME      | FAMILY |     PRODUCT IDS      | STATUS |
+----------------------+---------------+--------+----------------------+--------+
| fd8qrqqgk9hd7822tjfg | centos-7-base | centos | f2ebfhrshe5m6i4saf1j | READY  |
+----------------------+---------------+--------+----------------------+--------+
```
<h2 dir="auto"></a>Задача 2</h2>
<p dir="auto">Создать вашу первую виртуальную машину в Яндекс.Облаке.</p>

<p align="center" dir="auto"> 
  <a target="_blank" rel="noopener noreferrer" href="node01.jpg"><img width="550" height="650" src="node01.jpg" style="max-width: 100%;"></a>
</p>
<h2 dir="auto">Задача 3</h2>
<p dir="auto">Создать ваш первый готовый к боевой эксплуатации компонент мониторинга, состоящий из стека микросервисов.</p>

<p align="center" dir="auto">
  <a target="_blank" rel="noopener noreferrer" href="grafana.jpg"><img width="1200" height="550" src="grafana.jpg" style="max-width: 100%;"></a>
</p>
<h2 dir="auto">Задача 4 (*)</h2>
<p dir="auto">Создать вторую ВМ и подключить её к мониторингу развёрнутому на первом сервере.</p>

<p align="center" dir="auto">
  <a target="_blank" rel="noopener noreferrer" href="grafana-node02.jpg"><img width="1200" height="500" src="grafana-node02.jpg" style="max-width: 100%;"></a>

<p align="center" dir="auto">
  <a target="_blank" rel="noopener noreferrer" href="prom-targets.jpg"><img width="1200" height="500" src="prom-targets.jpg" style="max-width: 100%;"></a>