
    
    
<ol>
<li>Какой системный вызов делает команда <code>cd</code>? В прошлом ДЗ мы выяснили, что <code>cd</code> не является самостоятельной  программой, это <code>shell builtin</code>, поэтому запустить <code>strace</code> непосредственно на <code>cd</code> не получится. Тем не менее, вы можете запустить <code>strace</code> на <code>/bin/bash -c 'cd /tmp'</code>. В этом случае вы увидите полный список системных вызовов, которые делает сам <code>bash</code> при старте. Вам нужно найти тот единственный, который относится именно к <code>cd</code>.
<p>chdir("/tmp")</p>
</li>
<li>Попробуйте использовать команду <code>file</code> на объекты разных типов на файловой системе. Например:
<div class="highlight highlight-source-shell position-relative" data-snippet-clipboard-copy-content="vagrant@netology1:~$ file /dev/tty
/dev/tty: character special (5/0)
vagrant@netology1:~$ file /dev/sda
/dev/sda: block special (8/0)
vagrant@netology1:~$ file /bin/bash
/bin/bash: ELF 64-bit LSB shared object, x86-64
"><pre>vagrant@netology1:<span class="pl-k">~</span>$ file /dev/tty
/dev/tty: character special (5/0)
vagrant@netology1:<span class="pl-k">~</span>$ file /dev/sda
/dev/sda: block special (8/0)
vagrant@netology1:<span class="pl-k">~</span>$ file /bin/bash
/bin/bash: ELF 64-bit LSB shared object, x86-64</pre></div>
Используя <code>strace</code> выясните, где находится база данных <code>file</code> на основании которой она делает свои догадки.
<p>
```
openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=111, ...}) = 0
read(3, "# Magic local data for file(1) c"..., 4096) = 111
read(3, "", 4096)                       = 0
close(3)                                = 0
```
</li>
<li>Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).
<p>cat /dev/null > имя_файла</p>
</li>
<li>Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?
<p>Процесс занимает место в таблице PID. Наличие единичных зомби-процессов угрозы системе не несет</p>
</li>
<li>В iovisor BCC есть утилита <code>opensnoop</code>:
<div class="highlight highlight-source-shell position-relative" data-snippet-clipboard-copy-content="root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
/usr/sbin/opensnoop-bpfcc
"><pre>root@vagrant:<span class="pl-k">~</span><span class="pl-c"><span class="pl-c">#</span> dpkg -L bpfcc-tools | grep sbin/opensnoop</span>
/usr/sbin/opensnoop-bpfcc</pre></div>
На какие файлы вы увидели вызовы группы <code>open</code> за первую секунду работы утилиты? Воспользуйтесь пакетом <code>bpfcc-tools</code> для Ubuntu 20.04. Дополнительные <a href="https://github.com/iovisor/bcc/blob/master/INSTALL.md">сведения по установке</a>.
<p>/etc/ld.so.cache
<p>/lib/x86_64-linux-gnu/libselinux.so.1
<p>/lib/x86_64-linux-gnu/libc.so.6
</p>
</li>
<li>Какой системный вызов использует <code>uname -a</code>? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в <code>/proc</code>, где можно узнать версию ядра и релиз ОС.
<p>$ strace uname -a
<p>uname({sysname="Linux", nodename="centos.test", ...}) = 0
<p>man 2 uname
<p>Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version,
       domainname}.
	   </p>
</li>
<li>Чем отличается последовательность команд через <code>;</code> и через <code>&amp;&amp;</code> в bash? Например:
<div class="highlight highlight-source-shell position-relative" data-snippet-clipboard-copy-content="root@netology1:~# test -d /tmp/some_dir; echo Hi
Hi
root@netology1:~# test -d /tmp/some_dir &amp;&amp; echo Hi
root@netology1:~#
"><pre>root@netology1:<span class="pl-k">~</span><span class="pl-c"><span class="pl-c">#</span> test -d /tmp/some_dir; echo Hi</span>
Hi
root@netology1:<span class="pl-k">~</span><span class="pl-c"><span class="pl-c">#</span> test -d /tmp/some_dir &amp;&amp; echo Hi</span>
root@netology1:<span class="pl-k">~</span><span class="pl-c"><span class="pl-c">#</span></span></pre></div>
Есть ли смысл использовать в bash <code>&amp;&amp;</code>, если применить <code>set -e</code>?
<p>; - просто указывает конец команды. следующая команда будет выполнена в любом случае.
<p>&& - указывает на то, что следующая команда будет выполнена только если предыдущая команда будет завершена с нулевым значением.
<p>set -e прерывает любую последовательность при возврате не нулевого значения любой командой. Соответственно использование && лишено практического смысла
</p>
</li>
<li>Из каких опций состоит режим bash <code>set -euxo pipefail</code> и почему его хорошо было бы использовать в сценариях?
<p>e - прекращает выполнение если какая то из команд завершилась ошибкой. И выводит строку ошибки в STDERR. Удобно для понимания где искать ошибку
<p>u - прекращает выполнение при наличии несуществующей переменной в скрипте.
<p>x - выводит запускаемыю команду в STDOUT - Визуализация
<p>o pipefail - выдаст ненулевой результат если любая команда из пайпа вернет ошибку. (на случай использования | true)
</li>

<li>Используя <code>-o stat</code> для <code>ps</code>, определите, какой наиболее часто встречающийся статус у процессов в системе. В <code>man ps</code> ознакомьтесь (<code>/PROCESS STATE CODES</code>) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).
<p>$ ps -o stat
<p>STAT
<p>Ss
<p>R+
<p> Самый часто встречающийся статус - в ожидании события. S, Ss, Ssl хотя и относятся к одному статусу - S, тем не менее s - указатель лидера сессии, а l - указывает на многопоточность</p>
</li>
</ol>
