<ol>
<li>
<p>Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.</p>
<p> https://github.com/vitsinv/netology_homework/blob/exp/3_9_sec/btw_plugin.JPG
<p> https://github.com/vitsinv/netology_homework/blob/exp/3_9_sec/btw_vault.JPG
</li>
<li>
<p>Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.</p>
<p>https://github.com/vitsinv/netology_homework/blob/exp/3_9_sec/G_auth.JPG
</li>
<li>
<p>Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.</p>
<p>/etc/apache2/ssl$ sudo openssl req -new -x509 -days 1461 -nodes -out test_cert.pem -keyout test_c
ert.key -subj "/C=RU/ST=MSK/L=MSK/OU=Home/CN=netology/CN=test"
<p>Generating a RSA private key
<p>...............+++++
<p>....................+++++
<p>writing new private key to 'test_cert.key'
<p>-----
<p> https://github.com/vitsinv/netology_homework/blob/exp/3_9_sec/nettest.JPG
</li>
<li>
<p>Проверьте на TLS уязвимости произвольный сайт в интернете.</p>
<p>$ nmap --script ssl-enum-ciphers -p 443 ya.ru
<p>Starting Nmap 7.80 ( https://nmap.org ) at 2021-09-20 07:21 UTC
<p>Nmap scan report for ya.ru (87.250.250.242)
<p>Host is up (0.025s latency).
<p>Other addresses for ya.ru (not scanned): 2a02:6b8::2:242
<p>
<p>PORT    STATE SERVICE
<p>443/tcp open  https
<p>| ssl-enum-ciphers:
<p>|   TLSv1.0:
<p>|     ciphers:
<p>|       TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA (ecdh_x25519) - A
<p>|       TLS_RSA_WITH_AES_128_CBC_SHA (rsa 2048) - A
<p>|       TLS_RSA_WITH_3DES_EDE_CBC_SHA (rsa 2048) - C
<p>|     compressors:
<p>|       NULL
<p>|     cipher preference: server
<p>|     warnings:
<p>|       64-bit block cipher 3DES vulnerable to SWEET32 attack
<p>|   TLSv1.1:
<p>|     ciphers:
<p>|       TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA (ecdh_x25519) - A
<p>|       TLS_RSA_WITH_AES_128_CBC_SHA (rsa 2048) - A
<p>|       TLS_RSA_WITH_3DES_EDE_CBC_SHA (rsa 2048) - C
<p>|     compressors:
<p>|       NULL
<p>|     cipher preference: server
<p>|     warnings:
<p>|       64-bit block cipher 3DES vulnerable to SWEET32 attack
<p>|   TLSv1.2:
<p>|     ciphers:
<p>|       TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256 (ecdh_x25519) - A
<p>|       TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256 (ecdh_x25519) - A
<p>|       TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 (ecdh_x25519) - A
<p>|       TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (ecdh_x25519) - A
<p>|       TLS_ECDHE_ECDSA_WITH_AES_128_CCM_8 (ecdh_x25519) - A
<p>|       TLS_ECDHE_ECDSA_WITH_AES_128_CCM (ecdh_x25519) - A
<p>|       TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256 (ecdh_x25519) - A
<p>|       TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256 (ecdh_x25519) - A
<p>|       TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA (ecdh_x25519) - A
<p>|       TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384 (ecdh_x25519) - A
<p>|       TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (ecdh_x25519) - A
<p>|       TLS_RSA_WITH_AES_128_GCM_SHA256 (rsa 2048) - A
<p>|       TLS_RSA_WITH_AES_128_CCM_8 (rsa 2048) - A
<p>|       TLS_RSA_WITH_AES_128_CCM (rsa 2048) - A
<p>|       TLS_RSA_WITH_AES_128_CBC_SHA256 (rsa 2048) - A
<p>|       TLS_RSA_WITH_AES_128_CBC_SHA (rsa 2048) - A
<p>|       TLS_RSA_WITH_3DES_EDE_CBC_SHA (rsa 2048) - C
<p>|     compressors:
<p>|       NULL
<p>|     cipher preference: server
<p>|     warnings:
<p>|       64-bit block cipher 3DES vulnerable to SWEET32 attack
<p>|_  least strength: C
<p>
<p>Nmap done: 1 IP address (1 host up) scanned in 3.22 seconds
<p>
<p> Таким образом ya.ru имеет уязвимость перед атакой sweet32 (https://habr.com/ru/company/pt/blog/308476/)
</li>
<li>
<p>Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.</p>
<p> генерируем ключ
</p>
<p>[vits@cs8-1 ~]$ ssh-keygen
<p>Generating public/private rsa key pair.
<p>Enter file in which to save the key (/home/vits/.ssh/id_rsa):
<p>Created directory '/home/vits/.ssh'.
<p>Enter passphrase (empty for no passphrase):
<p>Enter same passphrase again:
<p>Your identification has been saved in /home/vits/.ssh/id_rsa.
<p>Your public key has been saved in /home/vits/.ssh/id_rsa.pub.
<p>The key fingerprint is:
<p>SHA256:U16AptwEvtTcOsRzxSHn4BRdVCfOCzQ+7c2WtCHI9eg vits@cs8-1
<p>The key's randomart image is:
<p>+---[RSA 3072]----+
<p>|      .. .*+*=+.o|
<p>|     . +++.X==o..|
<p>|     .o=* =o*o++ |
<p>|     .oo.* ..+o++|
<p>|      . S .  Eoo+|
<p>|         o     . |
<p>|                 |
<p>|                 |
<p>|                 |
<p>+----[SHA256]-----+
</p>
<p>Копируем ключ
</p>
<p>[vits@cs8-1 ~]$ ssh-copy-id vagrant@192.168.62.54
<p>The authenticity of host '192.168.62.54 (192.168.62.54)' can't be established.
<p>ECDSA key fingerprint is SHA256:wSHl+h4vAtTT7mbkj2lbGyxWXWTUf6VUliwpncjwLPM.
<p>Are you sure you want to continue connecting (yes/no/[fingerprint])? y
<p>Please type 'yes', 'no' or the fingerprint: yes
<p>/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
<p>/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
<p>vagrant@192.168.62.54's password:
<p>
<p>Number of key(s) added: 1
<p>
<p>Now try logging into the machine, with:   "ssh 'vagrant@192.168.62.54'"
<p>and check to make sure that only the key(s) you wanted were added.
<p>
<p> Подключаемся
</p>
<p>[vits@cs8-1 ~]$ ssh 'vagrant@192.168.62.54'
<p>Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-80-generic x86_64)
<p>
<p> * Documentation:  https://help.ubuntu.com
<p> * Management:     https://landscape.canonical.com
<p> * Support:        https://ubuntu.com/advantage
<p>
<p>  System information as of Mon 20 Sep 2021 07:34:10 AM UTC
<p>
<p>  System load:  0.03              Processes:             118
<p>  Usage of /:   2.5% of 61.31GB   Users logged in:       1
<p>  Memory usage: 24%               IPv4 address for eth0: 10.0.2.15
<p>  Swap usage:   0%                IPv4 address for eth1: 192.168.62.54
<p>
<p>
<p>This system is built by the Bento project by Chef Software
<p>More information can be found at https://github.com/chef/bento
<p>Last login: Fri Sep 17 13:41:09 2021 from 192.168.62.65
<p>vagrant@ubuntu-20:~$
</li>
<li>
<p>Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.</p>
<p> Переименовываем файлы
</p>
<p> [vits@cs8-1 .ssh]$ ls
<p> config  id_rsa_1  id_rsa_newname.pub  known_hosts
</p>
<p> Пишем config </p>
<p>Host vagrant
<p>  HostName 192.168.62.54
<p> User vagrant
<p>  IdentityFile ~/.ssh/id_rsa_1
</p>
<p> Подключаемся к хосту:</p>
<p> ssh -v (для полного лога) vagrant
<p> Далее часть лога</p>
<p>debug1: Host '192.168.62.54' is known and matches the ECDSA host key. (поскольку уже было успешное соедиение)
<p>debug1: Found key in /home/vits/.ssh/known_hosts:1 (найден ключ)
<p>debug1: rekey out after 4294967296 blocks
<p>debug1: SSH2_MSG_NEWKEYS sent
<p>debug1: expecting SSH2_MSG_NEWKEYS
<p>debug1: SSH2_MSG_NEWKEYS received
<p>debug1: rekey in after 4294967296 blocks
<p>debug1: Will attempt key: vits@cs8-1 RSA SHA256:U16AptwEvtTcOsRzxSHn4BRdVCfOCzQ+7c2WtCHI9eg agent (man ssh agent многое обьясняет)
<p>debug1: Will attempt key: /home/vits/.ssh/id_rsa  explicit
<p>debug1: SSH2_MSG_EXT_INFO received
<p>debug1: kex_input_ext_info: server-sig-algs=<ssh-ed25519,sk-ssh-ed25519@openssh.com,ssh-rsa,rsa-sha2-256,rsa-sha2-512,ssh-dss,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,sk-ecdsa-sha2-nistp256@openssh.com>
<p>debug1: SSH2_MSG_SERVICE_ACCEPT received
<p>debug1: Authentications that can continue: publickey,password (проверка готовности клиента завершена)
<p>debug1: Next authentication method: publickey 
<p>debug1: Offering public key: vits@cs8-1 RSA SHA256:U16AptwEvtTcOsRzxSHn4BRdVCfOCzQ+7c2WtCHI9eg agent (Пробуется ключ из агента)
<p>debug1: Server accepts key: vits@cs8-1 RSA SHA256:U16AptwEvtTcOsRzxSHn4BRdVCfOCzQ+7c2WtCHI9eg agent (сервер его принимает)
<p>debug1: Authentication succeeded (publickey). (все успешно, доступ предоставлен)
</li>
<li>
<p>Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.</p>
<p>vagrant@ubuntu-20:~$ tcpdump -D
<p>1.eth0 [Up, Running]
<p>2.eth1 [Up, Running]
<p>3.lo [Up, Running, Loopback]
<p>4.any (Pseudo-device that captures on all interfaces) [Up, Running]
<p>5.bluetooth-monitor (Bluetooth Linux Monitor) [none]
<p>6.nflog (Linux netfilter log (NFLOG) interface) [none]
<p>7.nfqueue (Linux netfilter queue (NFQUEUE) interface) [none]
<p>vagrant@ubuntu-20:~$ sudo tcpdump -i eth0 -w eth0_tcpdump.pcap
<p>tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
<p>^C6 packets captured
<p>7 packets received by filter
<p>0 packets dropped by kernel
</p>
<p> Открываем в Wireshark
<p> https://github.com/vitsinv/netology_homework/blob/exp/3_9_sec/ws.png
</li>
</ol>
<hr>
<h2><a id="user-content-задание-для-самостоятельной-отработки-необязательно-к-выполнению" class="anchor" aria-hidden="true" href="#задание-для-самостоятельной-отработки-необязательно-к-выполнению"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Задание для самостоятельной отработки (необязательно к выполнению)</h2>
<p>8*. Просканируйте хост scanme.nmap.org. Какие сервисы запущены?</p>
<p>vagrant@ubuntu-20:~$ nmap scanme.nmap.org
<p>Starting Nmap 7.80 ( https://nmap.org ) at 2021-09-20 09:09 UTC
<p>Nmap scan report for scanme.nmap.org (45.33.32.156)
<p>Host is up (0.21s latency).
<p>Other addresses for scanme.nmap.org (not scanned): 2600:3c01::f03c:91ff:fe18:bb2f
<p>Not shown: 996 filtered ports
<p>PORT      STATE SERVICE
<p>22/tcp    open  ssh
<p>80/tcp    open  http
<p>9929/tcp  open  nping-echo
<p>31337/tcp open  Elite
<p>
<p>Nmap done: 1 IP address (1 host up) scanned in 15.04 seconds
</p>
<p>9*. Установите и настройте фаервол ufw на web-сервер из задания 3. Откройте доступ снаружи только к портам 22,80,443</p>
<p>vagrant@ubuntu-20:~$ ufw --version
<p>ufw 0.36
<p>Copyright 2008-2015 Canonical Ltd.
</p>
<p>Закрываем входящие
<p>sudo ufw deny incoming
</p>
<p> Открываем заявленные:
<p>vagrant@ubuntu-20:~$ sudo ufw allow 22/tcp
<p>Rule added
<p>Rule added (v6)
<p>vagrant@ubuntu-20:~$ sudo ufw allow 80/tcp
<p>Rule added
<p>Rule added (v6)
<p>vagrant@ubuntu-20:~$ sudo ufw allow 443/tcp
<p>Rule added
<p>Rule added (v6)
</p>
<p>Проверяем статус
<p>vagrant@ubuntu-20:~$ sudo ufw status
<p>Status: active
<p>
<p>To                         Action      From
<p>--                         ------      ----
<p>22/tcp                     ALLOW       Anywhere
<p>80/tcp                     ALLOW       Anywhere
<p>443/tcp                    ALLOW       Anywhere
<p>22/tcp (v6)                ALLOW       Anywhere (v6)
<p>80/tcp (v6)                ALLOW       Anywhere (v6)
<p>443/tcp (v6)               ALLOW       Anywhere (v6)
</p>