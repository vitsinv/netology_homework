<ol>
<li>Работа c HTTP через телнет.</li>
</ol>
<ul>
<li>Подключитесь утилитой телнет к сайту stackoverflow.com
<code>telnet stackoverflow.com 80</code></li>
<li>отправьте HTTP запрос</li>

<div class="highlight highlight-source-shell position-relative" data-snippet-clipboard-copy-content="GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]
"><pre>GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]</pre></div>
<ul>
<li>В ответе укажите полученный HTTP код, что он означает?</li>
<p>
$ telnet stackoverflow.com 80
Trying 151.101.129.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0
HOST: stackoverflow.com

HTTP/1.1 301 Moved Permanently
<p> Ресурс перемещен навсегда
</ul>
</ul>
<ol start="2">
<li>Повторите задание 1 в браузере, используя консоль разработчика F12.</li>
</ol>
<ul>
<li>откройте вкладку <code>Network</code></li>
<li>отправьте запрос <a href="http://stackoverflow.com" rel="nofollow">http://stackoverflow.com</a></li>
<li>найдите первый ответ HTTP сервера, откройте вкладку <code>Headers</code></li>
<li>укажите в ответе полученный HTTP код.</li>
<p> 200
<li>проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?</li>
<p> Request URL: https://stats.g.doubleclick.net/j/collect?t=dc&aip=1&_r=3&v=1&_v=j93&tid=UA-108242619-1&cid=843008760.1622102542&jid=1590431556&gjid=942896679&_gid=134024615.1630951327&_u=YCDACEAABAAAAC~&z=494800375
<li>приложите скриншот консоли браузера в ответ.</li>
<p>скриншот - stackoverflow.jpg
</ul>
<ol start="3">
<li>Какой IP адрес у вас в интернете?</li>
<p>Ваш IP-адрес
<p>Протокол	Публичный адрес
<p>IPv4	62.148.7.82
<li>Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой <code>whois</code>
<p>inetnum:        62.148.0.0 - 62.148.7.255
<p>netname:        WTCMOSCOW-NET
<p>origin:         AS39376
</p>
</li>
<p>
<li>Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой <code>traceroute</code>
<p>
```
$ traceroute -An 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  172.25.48.1 [AS22773]  0.600 ms  0.839 ms  0.818 ms
 2  192.168.62.50 [*]  5.016 ms  5.008 ms  4.987 ms
 3  62.148.7.81 [AS39376]  4.967 ms  4.947 ms  4.927 ms
 4  81.211.56.29 [AS3216]  4.907 ms  4.887 ms  5.151 ms
 5  79.104.235.215 [AS3216]  4.848 ms  4.818 ms 79.104.225.15 [AS3216]  4.778 ms
 6  72.14.213.116 [AS15169]  4.748 ms  3.466 ms  10.738 ms
 7  108.170.250.34 [AS15169]  12.018 ms 108.170.250.51 [AS15169]  10.534 ms 108.170.250.83 [AS15169]  10.829 ms
 8  142.251.49.158 [AS15169]  22.784 ms * 142.250.239.64 [AS15169]  27.746 ms
 9  72.14.238.168 [AS15169]  22.072 ms  22.401 ms 72.14.235.69 [AS15169]  28.604 ms
10  142.250.210.103 [AS15169]  28.418 ms 216.239.49.115 [AS15169]  29.610 ms 216.239.62.107 [AS15169]  28.227 ms
11  * * *
12  * * *
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  8.8.8.8 [AS15169]  25.668 ms  25.805 ms  25.741 ms
```
</p>
</li>
<li>Повторите задание 5 в утилите <code>mtr</code>. На каком участке наибольшая задержка - delay?
<p>10. 216.239.49.115                                                            0.0%    91   22.5  30.1 AWG = 30.1
</li>
<li>Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой <code>dig</code>
<p>
```
;; ANSWER SECTION:
dns.google.             0       IN      A       8.8.4.4
dns.google.             0       IN      A       8.8.8.8
```
</li>
<li>Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой <code>dig</code>
```
;; QUESTION SECTION:
;8.8.8.8.in-addr.arpa.          IN      PTR
```
</li>
</ol>
<p>В качестве ответов на вопросы можно приложите лог выполнения команд в консоли или скриншот полученных результатов.</p>
<hr>
