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
<code>touch имя_файла{1..1000}</code></p>
{1..300000} не отработает так, как по факту произойдет 300000 вызовов <code>touch</code> за раз,</p> 
а <code>get_conf ARG_MAX</code> поможет узнать максимальное количество аргументов за раз</i></p>

</li>
<li>
<p>В man bash поищите по <code>/\[\[</code>. Что делает конструкция <code>[[ -d /tmp ]]</code></p>
</li>
<li>
<p>Основываясь на знаниях о просмотре текущих (например, PATH) и установке новых переменных; командах, которые мы рассматривали, добейтесь в выводе type -a bash в виртуальной машине наличия первым пунктом в списке:</p>
<div class="highlight highlight-source-shell position-relative" data-snippet-clipboard-copy-content="bash is /tmp/new_path_directory/bash
bash is /usr/local/bin/bash
bash is /bin/bash
"><pre>bash is /tmp/new_path_directory/bash
bash is /usr/local/bin/bash
bash is /bin/bash</pre></div>
<p>(прочие строки могут отличаться содержимым и порядком)
В качестве ответа приведите команды, которые позволили вам добиться указанного вывода или соответствующие скриншоты.</p>
</li>
<li>
<p>Чем отличается планирование команд с помощью <code>batch</code> и <code>at</code>?</p>
</li>
<li>
<p>Завершите работу виртуальной машины чтобы не расходовать ресурсы компьютера и/или батарею ноутбука.</p>
</li>
</ol>
<hr>
<h2><a id="user-content-как-сдавать-задания" class="anchor" aria-hidden="true" href="#как-сдавать-задания"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Как сдавать задания</h2>
<p>Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.</p>
<p>Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.</p>
<p>Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.</p>
<p>Также вы можете выполнить задание в <a href="https://docs.google.com/document/u/0/?tgif=d" rel="nofollow">Google Docs</a> и отправить в личном кабинете на проверку ссылку на ваш документ.
Название файла Google Docs должно содержать номер лекции и фамилию студента. Пример названия: "1.1. Введение в DevOps — Сусанна Алиева".</p>
<p>Если необходимо прикрепить дополнительные ссылки, просто добавьте их в свой Google Docs.</p>
<p>Перед тем как выслать ссылку, убедитесь, что ее содержимое не является приватным (открыто на комментирование всем, у кого есть ссылка), иначе преподаватель не сможет проверить работу. Чтобы это проверить, откройте ссылку в браузере в режиме инкогнито.</p>
<p><a href="https://support.google.com/docs/answer/2494822?hl=ru&amp;co=GENIE.Platform%3DDesktop" rel="nofollow">Как предоставить доступ к файлам и папкам на Google Диске</a></p>
<p><a href="https://support.google.com/chrome/answer/95464?co=GENIE.Platform%3DDesktop&amp;hl=ru" rel="nofollow">Как запустить chrome в режиме инкогнито </a></p>
<p><a href="https://support.apple.com/ru-ru/guide/safari/ibrw1069/mac" rel="nofollow">Как запустить  Safari в режиме инкогнито </a></p>
<p>Любые вопросы по решению задач задавайте в чате Slack.</p>
<hr>
</article>
  </div>



  </readme-toc>




  </body>
</html>
