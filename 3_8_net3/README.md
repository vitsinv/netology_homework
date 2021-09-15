<ol>
<li>Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP</li>
</ol>
<div class="snippet-clipboard-content position-relative" data-snippet-clipboard-copy-content="telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
"><pre><code>telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
</code></pre></div>
<ol start="2">
<p>
route-views.isc.routeviews.org> show ip bgp 62.148.0.0
BGP routing table entry for 62.148.0.0/24
Paths: (7 available, best #7, table default)
  Not advertised to any peer
  6762 3216 39376
    198.32.176.70 from 198.32.176.70 (195.22.206.253)
      Origin IGP, metric 100, valid, external
      Community: 6762:1 6762:92 6762:14600
      Last update: Thu Sep  9 13:03:28 2021
  30286 3356 3216 39376
    198.32.176.142 from 198.32.176.142 (10.2.1.2)
      Origin IGP, valid, external
      Community: 3216:2001 3216:4477 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067
      Last update: Thu Sep  9 14:02:25 2021
  199524 1299 3216 39376
    198.32.176.226 from 198.32.176.226 (10.255.65.68)
      Origin IGP, valid, external
      Last update: Sat Aug 21 16:01:42 2021
  19151 174 3216 39376
    198.32.176.164 from 198.32.176.164 (66.186.193.17)
      Origin IGP, metric 0, valid, external
      Last update: Thu Sep  9 14:03:04 2021
  7575 6762 3216 39376
    198.32.176.70 from 198.32.176.177 (202.158.215.120)
      Origin IGP, valid, external
      Community: 7575:1002 7575:2520 7575:6002
      Last update: Thu Sep  9 13:03:28 2021
  6939 3216 39376
    198.32.176.20 from 198.32.176.20 (216.218.252.165)
      Origin IGP, valid, external
      Last update: Wed Aug 25 22:59:17 2021
  36351 3216 39376
    198.32.176.207 from 198.32.176.207 (173.192.18.26)
      Origin IGP, valid, external, best (Older Path)
      Community: 36351:202 46704:200 65501:6
      Last update: Mon Aug 30 07:44:16 2021
<li>
<p>Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.</p>
<p>
vagrant@vagrant:~$ lsmod | grep dummy
dummy                  16384  0
vagrant@vagrant:~$ sudo ip link add dummy0 type dummy
vagrant@vagrant:~$ ifconfig -a | grep dummy
dummy0: flags=130<BROADCAST,NOARP>  mtu 1500
<p>
vagrant@vagrant:~$ sudo route add -net 192.168.62.0 netmask 255.255.255.0 dev eth0
vagrant@vagrant:~$ sudo route add -host 8.8.8.8/32 dev eth0
vagrant@vagrant:~$ route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         _gateway        0.0.0.0         UG    0      0        0 vlan10
default         _gateway        0.0.0.0         UG    100    0        0 eth0
dns.google      0.0.0.0         255.255.255.255 UH    0      0        0 eth0
10.0.2.0        0.0.0.0         255.255.255.0   U     0      0        0 eth0
_gateway        0.0.0.0         255.255.255.255 UH    100    0        0 eth0
192.168.0.0     0.0.0.0         255.255.255.0   U     0      0        0 vlan10
192.168.0.0     _gateway        255.255.255.0   UG    0      0        0 vlan10
192.168.62.0    0.0.0.0         255.255.255.0   U     0      0        0 eth0
</li>
<li>
<p>Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.</p>
<p> ss или netstat не так важно
vagrant@vagrant:~$ sudo netstat -tlpn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      550/systemd-resolve
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      665/sshd: /usr/sbin
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      1/init
tcp6       0      0 :::22                   :::*                    LISTEN      665/sshd: /usr/sbin
tcp6       0      0 :::111                  :::*                    LISTEN      1/init
</li>
<li>
<p>Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?</p>
<p> для разнообразия lsof
vagrant@vagrant:~$ sudo lsof -nP -i | grep UDP
systemd      1            root   36u  IPv4  14804      0t0  UDP *:111
systemd      1            root   38u  IPv6  14810      0t0  UDP *:111
systemd-n  382 systemd-network   19u  IPv4  17914      0t0  UDP 10.0.2.15:68
rpcbind    549            _rpc    5u  IPv4  14804      0t0  UDP *:111
rpcbind    549            _rpc    7u  IPv6  14810      0t0  UDP *:111
systemd-r  550 systemd-resolve   12u  IPv4  22738      0t0  UDP 127.0.0.53:53
</li>
<li>
<p>Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.</p>
<p> https://github.com/vitsinv/netology_homework/blob/exp/3_8_net3/L3.png
</li>
</ol>
