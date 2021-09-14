<ol>
<li>
<p>Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?</p>
</li>
<p> Windows: ipconfig, Linux: ifconfig
<li>
<p>Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?</p>
<p> ARP - IPv4, NDP IPv6
<p> Поскольку это WSL ВМ, то ожидаемо ARP увидел только IP виртуального маршрутизатора.
$ sudo arp-scan --interface=eth0 --localnet
Interface: eth0, type: EN10MB, MAC: 00:15:5d:63:34:ff, IPv4: 172.18.123.198
Starting arp-scan 1.9.7 with 4096 hosts (https://github.com/royhills/arp-scan)
172.18.112.1    00:15:5d:81:d8:02       Microsoft Corporation

1 packets received by filter, 0 packets dropped by kernel
Ending arp-scan 1.9.7: 4096 hosts scanned in 17.503 seconds (234.02 hosts/sec). 1 responded
</li>
<li>
<p>Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.</p>
<p> VLAN - Virtual local area network
<p> netplan config:
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: yes
  vlans:
    vlan10:
      id: 10
      link: eth0
      dhcp4: no
      addresses: [192.168.0.100/24]
      gateway4: 192.168.0.1
      routes:
          - to: 192.168.0.0/24
            via: 192.168.0.1
            on-link: true
</li>
<li>
<p>Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.</p>
<p> round-robin (все по очереди), active-backup (один работает, если падает - мак переносится на второй и поднимается второй интерфейс), balance-xor (согласно xmit_hash_policy), broadcast (оба одновременно работают), 802.3ad (на основании соответствующего протокола), balance-tlb (один на вход, все на исходящий), balance-alb (все на исходящий, входящий балансируется с помощью ARP)
<p> netplan config:
network:
    version: 2
    renderer: networkd
    ethernets:
        ens2f0: {}
        ens2f1: {}
    bonds:
        bond0:
            dhcp4: no
            interfaces:
            - ens2f0
            - ens2f1
            parameters:
                mode: active-backup
            addresses:
                - 192.168.122.195/24
            gateway4: 192.168.122.1
            mtu: 1500
            nameservers:
                addresses:
                    - 8.8.8.8
                    - 77.88.8.8
</li>
<li>
<p>Сколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.</p>
<p> /29 - 8 адресов, из которых 2 служебных.
<p> 256 / 8 = 32 подсети
<p> 10.10.10.0/29, 10.10.10.8/29, 10.10.10.16/29 и т.д.
</li>
<li>
<p>Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.</p>
<p> 100.64.0.0/17 - 128 хостов. 40+ на каждую подсеть
</li>
<li>
<p>Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?</p>
<p>Linix: arp -e. Windows: arp -a. - просмотр
<p>Linux: arp -d или ip link set arp off dev eth0; ip link set arp on dev eth0. Windows: netsh interface ip delete arpcache. - Очистка
<p>Linux: ip neigh delete IP dev Interface. Windows: arp -d IP. - выборочное удаление ARP записей
</li>
</ol>
<hr>
<h2><a id="user-content-задание-для-самостоятельной-отработки-необязательно-к-выполнению" class="anchor" aria-hidden="true" href="#задание-для-самостоятельной-отработки-необязательно-к-выполнению"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Задание для самостоятельной отработки (необязательно к выполнению)</h2>
<p>8*. Установите эмулятор EVE-ng.</p>
<p>Инструкция по установке - <a href="https://github.com/svmyasnikov/eve-ng">https://github.com/svmyasnikov/eve-ng</a></p>
<p>Выполните задания на lldp, vlan, bonding в эмуляторе EVE-ng.</p>
<hr>
