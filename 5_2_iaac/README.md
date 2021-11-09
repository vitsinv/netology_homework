

<h2>Задача 1</h2>
<ul>
<li>Опишите своими словами основные преимущества применения на практике IaaC паттернов.</li>
  
  * Автоматизация предоставления инфраструктуры для любого этапа разработки ПО.

  * Уверенность, что на любом этапе, инфраструктура будет идентичной.

  * Скорость развертывания инфраструктуры уменьшает время, потраченное на какждый из этапов разработки.

<li>Какой из принципов IaaC является основополагающим?</li>

* Идемпотентность. На любом из этапов, при применении методологии IaaC можно быть уверенным в идентичности инфраструктуры. 
</ul>
<h2>Задача 2</h2>
<ul>
<li>Чем Ansible выгодно отличается от других систем управление конфигурациями?</li>

* Для работы Ansible, целевой хост должен иметь доступ по SSH и установленный Python. И то и то практически на всех linux хостах есть по умолчанию. В то время как другие инструменты требуют еще какой-то подготовки на целевом хосте.
<li>Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?</li>

* С одной стороны, когда сам целевой хост запрашивает конфигурацию с сервера управления (PULL) - надежней. Хотя бы тем, что данные авторизации лежат уже на целевом хосте, а не в конфигурации. Однако, для реализации этой модели на целевом хосте, должен быть установлен какой-то агент. То, что не нужно при применении PUSH.
</ul>
<h2>Задача 3</h2>
<p>Установить на личный компьютер:</p>
<ul>
<li>VirtualBox</li>

```
Графический интерфейс VirtualBox
Версия 6.1.26 r145957 (Qt5.6.2)
Copyright © 2021 Oracle Corporation and/or its affiliates. All rights reserved.
```
<li>Vagrant</li>

<code>

```
/mnt/c/Users/vitsin$ vagrant --version
Vagrant 2.2.18
```
</code>

<li>Ansible</li>

```
/mnt/c/Users/vitsin$ ansible --version
ansible 2.9.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/vitsin/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Jun  2 2021, 10:49:15) [GCC 9.4.0]
  ```

</ul>
<p><em>Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.</em></p>
<h2></a>Задача 4 (*)</h2>
<p>Воспроизвести практическую часть лекции самостоятельно.</p>
<ul>
<li>Создать виртуальную машину.</li>

```
/mnt/c/Users/vitsin/vagrant_files$ vagrant up
Bringing machine 'server1.netology' up with 'hyperv' provider...
==> server1.netology: Verifying Hyper-V is enabled...
==> server1.netology: Verifying Hyper-V is accessible...
==> server1.netology: Importing a Hyper-V instance
    server1.netology: Creating and registering the VM...
    server1.netology: Successfully imported VM
    server1.netology: Please choose a switch to attach to your Hyper-V instance.
    server1.netology: If none of these are appropriate, please open the Hyper-V manager
    server1.netology: to create a new virtual switch.
    server1.netology:
    server1.netology: 1) HVExt
    server1.netology: 2) Default Switch
    server1.netology: 3) WSL
    server1.netology:
    server1.netology: What switch would you like to use? 2
    server1.netology: Configuring the VM...
    server1.netology: Setting VM Integration Services
==> server1.netology: guest_service_interface is enabled
    server1.netology: Setting VM Enhanced session transport type to disabled/default (VMBus)
==> server1.netology: Starting the machine...
==> server1.netology: Waiting for the machine to report its IP address...
    server1.netology: Timeout: 120 seconds
    server1.netology: IP: 172.22.8.20
==> server1.netology: Waiting for machine to boot. This may take a few minutes...
    server1.netology: SSH address: 172.22.8.20:22
    server1.netology: SSH username: vagrant
    server1.netology: SSH auth method: private key
    server1.netology: Warning: Connection refused. Retrying...
    server1.netology:
    server1.netology: Vagrant insecure key detected. Vagrant will automatically replace
    server1.netology: this with a newly generated keypair for better security.
    server1.netology:
    server1.netology: Inserting generated public key within guest...
    server1.netology: Removing insecure key from the guest if it's present...
    server1.netology: Key inserted! Disconnecting and reconnecting using new SSH key...
==> server1.netology: Machine booted and ready!
```

```
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=20.04
DISTRIB_CODENAME=focal
DISTRIB_DESCRIPTION="Ubuntu 20.04 LTS"
NAME="Ubuntu"
VERSION="20.04 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
```

<li>Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды <code>docker ps
</code></li>

 *
 ```
 vagrant@ubuntu-20:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@ubuntu-20:~$ docker --version
Docker version 20.10.10, build b485636
``` 
