<ol>
<li>
<p>На лекции мы познакомились с <a href="https://github.com/prometheus/node_exporter/releases">node_exporter</a>. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой <a href="https://www.freedesktop.org/software/systemd/man/systemd.service.html" rel="nofollow">unit-файл</a> для node_exporter:</p>
<ul>
<li>поместите его в автозагрузку,</li>
<li>предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на <code>systemctl cat cron</code>),</li>
<li>удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.
<p>Unit File:
<p>
[Unit]
Description=Node Exporter

[Service]
EnvironmentFile=/opt/node_exporter/options
ExecStart=/opt/node_exporter/node_exporter --collectors.enabled ${collectors}

[Install]
WantedBy=default.target
</p>
<p> Файл options с перечислением метрик:
<p> collectors=meminfo,loadavg,filesystem
<p> В автозагрузку: sudo systemctl enable node_exporter.service
<p> Статус: 
$ sudo systemctl status node_exporter.service
● node_exporter.service - Node Exporter
   Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2021-09-08 19:21:07 UTC; 27min ago
 Main PID: 10998 (node_exporter)
   CGroup: /system.slice/node_exporter.service
           └─10998 /opt/node_exporter/node_exporter

Sep 08 19:21:07 centos.test node_exporter[10998]: level=info ts=2021-09-08T19:21:07.294Z caller=node_exporter.go:115 collector=time
Sep 08 19:21:07 centos.test node_exporter[10998]: level=info ts=2021-09-08T19:21:07.294Z caller=node_exporter.go:115 collector=timex
Sep 08 19:21:07 centos.test node_exporter[10998]: level=info ts=2021-09-08T19:21:07.294Z caller=node_exporter.go:115 collector=udp_queues
Sep 08 19:21:07 centos.test node_exporter[10998]: level=info ts=2021-09-08T19:21:07.294Z caller=node_exporter.go:115 collector=uname
Sep 08 19:21:07 centos.test node_exporter[10998]: level=info ts=2021-09-08T19:21:07.294Z caller=node_exporter.go:115 collector=vmstat
Sep 08 19:21:07 centos.test node_exporter[10998]: level=info ts=2021-09-08T19:21:07.294Z caller=node_exporter.go:115 collector=xfs
Sep 08 19:21:07 centos.test node_exporter[10998]: level=info ts=2021-09-08T19:21:07.294Z caller=node_exporter.go:115 collector=zfs
Sep 08 19:21:07 centos.test node_exporter[10998]: level=info ts=2021-09-08T19:21:07.294Z caller=node_exporter.go:199 msg="Listening on" address=:9100
Sep 08 19:21:07 centos.test node_exporter[10998]: level=info ts=2021-09-08T19:21:07.295Z caller=tls_config.go:191 msg="TLS is disabled." http2=false
Sep 08 19:35:28 centos.test systemd[1]: Current command vanished from the unit file, execution of the command list won't be resumed.
</li>
</ul>
</li>
<li>
<p>Ознакомьтесь с опциями node_exporter и выводом <code>/metrics</code> по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.</p>
<p>https://github.com/prometheus/node_exporter/blob/master/README.md#collectors
<p>node_cpu..., node_memory..., node_disk..., node_network...
</li>
<li>
<p>Установите в свою виртуальную машину <a href="https://github.com/netdata/netdata">Netdata</a>. Воспользуйтесь <a href="https://packagecloud.io/netdata/netdata/install" rel="nofollow">готовыми пакетами</a> для установки (<code>sudo apt install -y netdata</code>). После успешной установки:</p>
<ul>
<li>в конфигурационном файле <code>/etc/netdata/netdata.conf</code> в секции [web] замените значение с localhost на <code>bind to = 0.0.0.0</code>,</li>
<li>добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте <code>vagrant reload</code>:</li>
</ul>
<div class="highlight highlight-source-shell position-relative" data-snippet-clipboard-copy-content="config.vm.network &quot;forwarded_port&quot;, guest: 19999, host: 19999
"><pre>config.vm.network <span class="pl-s"><span class="pl-pds">"</span>forwarded_port<span class="pl-pds">"</span></span>, guest: 19999, host: 19999</pre></div>
<p>После успешной перезагрузки в браузере <em>на своем ПК</em> (не в виртуальной машине) вы должны суметь зайти на <code>localhost:19999</code>. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.</p>
<p>cpu, load, disk, ram, swap, network, processes, etc.
</li>
<li>
<p>Можно ли по выводу <code>dmesg</code> понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?</p>
<p>[    0.000000] Hypervisor detected: KVM
</li>
<li>
<p>Как настроен sysctl <code>fs.nr_open</code> на системе по-умолчанию? 
<p> fs.nr_open = 1048576
<p>Узнайте, что означает этот параметр.
<p> максимальное количество дескрипторов файлов, которое может выделить процесс
<p> Какой другой существующий лимит не позволит достичь такого числа (<code>ulimit --help</code>)?</p>
<p> -S        use the `soft' resource limit
<p> -H        use the `hard' resource limit
<p> Мягкий и жесткий лимиты. Мягкий можно изменять в любую сторону, не превышая жесткого.
</li>
<li>
<p>Запустите любой долгоживущий процесс (не <code>ls</code>, который отработает мгновенно, а, например, <code>sleep 1h</code>) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через <code>nsenter</code>. Для простоты работайте в данном задании под root (<code>sudo -i</code>). Под обычным пользователем требуются дополнительные опции (<code>--map-root-user</code>) и т.д.</p>
<p>root@vagrant:~# ps -e | grep sleep
   1580 pts/0    00:00:00 sleep
   root@vagrant:~# nsenter --target 1580 --pid --mount
   root@vagrant:/# ps
		PID TTY          TIME CMD
	1581 pts/1    00:00:00 sudo
	1583 pts/1    00:00:00 bash
	1598 pts/1    00:00:00 nsenter
	1599 pts/1    00:00:00 bash
	1608 pts/1    00:00:00 ps
</li>
<li>
<p>Найдите информацию о том, что такое <code>:(){ :|:&amp; };:</code>.
<p> форк бомба. функция запускает две своих копии, те еще две и так до тех пор пока не закончатся PID-ы
<p >Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (<strong>это важно, поведение в других ОС не проверялось</strong>). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов <code>dmesg</code> расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?</p>
<p> [ 2321.193318] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-3.scope
<p> ulimit -u количество_процессов_для_пользователя
</li>
</ol>
