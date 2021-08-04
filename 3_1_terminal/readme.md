# Домашнее задание по 3.1 Работа в терминале

## Установите средство виртуализации <a href="https://www.virtualbox.org/" rel="nofollow">Oracle VirtualBox</a>.</p>
<i>После общения с одним из преподавателей, было выяснено что вид средства виртуализации большого значения не имеет. В связи с этим я остался на уже установленном Hyper-V</i></p>

## Установите средство автоматизации <a href="https://www.vagrantup.com/" rel="nofollow">Hashicorp Vagrant</a>.</p>
<i>Выполнено</i></p>

## В вашем основном окружении подготовьте удобный для дальнейшей работы терминал.</p>

- Windows Terminal в Windows</li> <i> Используется</i>
- выбрать цветовую схему, размер окна, шрифтов и т.д.</li> <i> В целом дефолтная вполне приятна</i>
- почитать о кастомизации PS1/применить при желании.</li></p>

<code>echo $PS1
</p>
\t \[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\
</code>

<p><i>#Добавлена дата </i></p>


## С помощью базового файла конфигурации запустите Ubuntu 20.04 в VirtualBox посредством Vagrant.</p>
<i>Немножко усложнил задачу, ниже вывод vagrantfile:</i>

```
<code>
#-*- mode: ruby -*-
#vi: set ft=ruby :

#Создаем 2 виртуальные машины на базе разных боксов vagrant

#Общие свойства
#Domain
DOMAIN="test"

#Перечисляем ВМ
servers =[
	{
		:hostname => "centos." + DOMAIN,
		:ram => 1024,
		:nodename => "centos/7",
		:hdd_name => "centos_hdd.vhd",
		:hdd_size => "10000"
	},
	{
		:hostname => "ubuntu." + DOMAIN,
		:ram => 1024,
		:nodename => "bento/ubuntu-20.04",
		:hdd_name => "ubuntu_hdd.vhd",
		:hdd_size => "10000"
	}
]


Vagrant.configure(2) do |config|
	#Добавить общую шару
	config.vm.synced_folder "c://users/vitsin/vagrant_files/exchange", "/src/exchange"
	#При выполнении запросит логин\пароль пользователя с правами для папки на хосте
	#Отключить дефолтную шару
	config.vm.synced_folder ".", "/vagrant", disabled: true
	#Перечисляем servers
	servers.each do |machine|
		#Применяем конфигурации
		#Имя сервера в диспетчере Hyper-V
		config.vm.define machine[:hostname] do |node|
		#Получаем Vagrant Box
		node.vm.box = machine[:nodename]

		#Настройки провайдера
		node.vm.provider "hyperv" do |hv|
			#Включаем Nifty
			hv.enable_virtualization_extensions = true
			hv.linked_clone = true
			#RAM
			hv.maxmemory = machine[:ram]
			#Присваиваем имя виртуалке
			hv.vmname = machine[:hostname]

		end
	end
end
end
</code>
```


## Ознакомьтесь с возможностями конфигурации VirtualBox через Vagrantfile: <a href="https://www.vagrantup.com/docs/providers/virtualbox/configuration.html" rel="nofollow">документация</a>. Как добавить оперативной памяти или ресурсов процессора виртуальной машине?</p>
<i>customize --memory</i></p> 

## Какой переменной можно задать длину журнала <code>history</code>, и на какой строчке manual это описывается?</p>
<i> HistSize по дефолту 500. (Manual page bash(1) line 575)</i></p>

## Что делает директива <code>ignoreboth</code> в bash?</p>
<i> IgnoreBoth указывает системе не записывать в хистори повторяющиеся команды а так же те, что начинается с пробела</i></p>

## В каких сценариях использования применимы скобки <code>{}</code> и на какой строчке <code>man bash</code> это описано?</p>
<i>(Manual page bash(1) line 203/3088) В отличие от <code>()</code>, когда выполнение происходит во вложенной среде, <code>{}</code> оставляет выполнение в текущей</i></p>

## Основываясь на предыдущем вопросе, как создать однократным вызовом <code>touch</code> 100000 файлов? А получилось ли создать 300000? Если нет, то почему?</p>
<i>
<code>touch имя_файла{1..100000}</code></p>
{1..300000} не отработает так, как по факту произойдет 300000 вызовов <code>touch</code> за раз,</p> 
а <code>get_conf ARG_MAX</code> поможет узнать максимальное количество аргументов за раз</i></p>

## В man bash поищите по /\[\[. Что делает конструкция <code>[[ -d /tmp ]]</code></p>
<i><code>[[ -d /tmp ]]</code> - условие что есть /tmp и это директория</i></p>

## Основываясь на знаниях о просмотре текущих (например, PATH) и установке новых переменных; командах, которые мы рассматривали, добейтесь в выводе type -a bash в виртуальной машине наличия первым пунктом в списке:</p>
<div class="highlight highlight-source-shell position-relative" data-snippet-clipboard-copy-content="bash is /tmp/new_path_directory/bash
bash is /usr/local/bin/bash
bash is /bin/bash
"><pre>bash is /tmp/new_path_directory/bash
bash is /usr/local/bin/bash
bash is /bin/bash</pre></div>
<p>(прочие строки могут отличаться содержимым и порядком)
В качестве ответа приведите команды, которые позволили вам добиться указанного вывода или соответствующие скриншоты.</p>
```
<code>
#создаем тестовые папки и файлы bash</p>
mkdir {1..9}</p>
touch ~/{1..9}/bash</p>
#Делаем файлы исполняемыми</p>
chmod u+x ~/{1..9}/bash</p>
#Добавляем созданные пути в PATH</p>
for number in [1-9]; do PATH=$PATH:~/$number/; done</p>
#Проверяем type -a bash</p>
[vagrant@centos ~]$ type -a bash</p>
bash is /usr/bin/bash</p>
bash is /home/vagrant/1/bash</p>
bash is /home/vagrant/2/bash</p>
bash is /home/vagrant/3/bash</p>
bash is /home/vagrant/4/bash</p>
bash is /home/vagrant/5/bash</p>
bash is /home/vagrant/6/bash</p>
bash is /home/vagrant/7/bash</p>
bash is /home/vagrant/8/bash</p>
bash is /home/vagrant/9/bash</p>
#Поскольку /usr/bin в PATH стоит раньше нами добавленных и уже находится на самом верху, то мы переместим наверх bash из папки ~/9</p>
export PATH=~/9:$PATH</p>
#Проверяем</p>
[vagrant@centos ~]$ type -a bash</p>
bash is /home/vagrant/9/bash</p>
bash is /usr/bin/bash</p>
bash is /home/vagrant/1/bash</p>
bash is /home/vagrant/2/bash</p>
bash is /home/vagrant/3/bash</p>
bash is /home/vagrant/4/bash</p>
bash is /home/vagrant/5/bash</p>
bash is /home/vagrant/6/bash</p>
bash is /home/vagrant/7/bash</p>
bash is /home/vagrant/8/bash</p>
bash is /home/vagrant/9/bash</p>
#Но теперь у меня 2 пути /home/vagrant/9, поэтому я просто вывел Path на экран, скопировал его, и командой export PATH= вставил, убрав лишний путь.</p>
</code>
```
</p>

## Чем отличается планирование команд с помощью <code>batch</code> и <code>at</code>?</p>
<i>at - планировщик по времени, batch по загрузке.</p>
Т.е. при использовании at указывается время выполнения задания, при использовании batch (частный случай at), </p>
задание помещается в очередь, которая будет запущена при средней загрузке системы ниже 1,5 (по умолчанию).</i></p>

## Завершите работу виртуальной машины чтобы не расходовать ресурсы компьютера и/или батарею ноутбука.</p>
<i><code>vagrant suspend --all-global</code></i></p>