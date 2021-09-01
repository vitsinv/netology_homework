<p>Какого типа команда <code>cd</code>? Попробуйте объяснить, почему она именно такого типа; опишите ход своих мыслей, если считаете что она могла бы быть другого типа.</p>
<p> встроенная комманда оболочки. то есть будет присутствовать в любом запущенном экземпляре оболочки</p>
<li>
<p>Какая альтернатива без pipe команде <code>grep &lt;some_string&gt; &lt;some_file&gt; | wc -l</code>? <code>man grep</code> поможет в ответе на этот вопрос. Ознакомьтесь с <a href="http://www.smallo.ruhr.de/award.html" rel="nofollow">документом</a> о других подобных некорректных вариантах использования pipe.</p>
</li>
<p><code>grep -c &lt;some_string&gt; &lt;some_file&gt;</code> подсчет количества вхождения паттерна</p>
<li>
<p>Какой процесс с PID <code>1</code> является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?</p>
<p>init</p>
</li>
<li>
<p>Как будет выглядеть команда, которая перенаправит вывод stderr <code>ls</code> на другую сессию терминала?</p>
<p>Предположим, что мы работаем в сессии 0 и еще открыта сессия 1 то команда будет выглядеть так: <code>ls 2>/dev/pts/1</code>
</li>
<li>
<p>Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.</p>
<p><code>cat Vagrantfile > v_new</code>
</li>
<li>
<p>Получится ли вывести находясь в графическом режиме данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные?</p>
<p>Да</p>
</li>
<li>
<p>Выполните команду <code>bash 5&gt;&amp;1</code>. К чему она приведет? Что будет, если вы выполните <code>echo netology &gt; /proc/$$/fd/5</code>? Почему так происходит?</p>
<p><code>bash 5>&1</code> Команда завершится с кодом 0. Однако визуально не произодйдет ничего. Просто создали дескриптор 5 и перенаправили егое в STDOUT.
<p><code>echo netology > /proc/$$/fd/5</code> А вот тут мы посылаем ввод echo в 5 дескриптор, который ранее перенаправили в STDOUT. Поэтому на выходе мы получим вывод netology на экран</p>
</li>
<li>
<p>Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty? Напоминаем: по умолчанию через pipe передается только stdout команды слева от <code>|</code> на stdin команды справа.
Это можно сделать, поменяв стандартные потоки местами через промежуточный новый дескриптор, который вы научились создавать в предыдущем вопросе.</p>
<p>Вообще правильный ответ просто "ДА". bash читает слева направо. т.е. мы сначала выводим STDTERR в STDOUT <code>2>&1</code>, перенаправляемм STDOUT в промежуточный <code>1>&3</code> и pipe получит STDERR в качестве входного потока. После чего возвращаем STDOUT в &1</p>
</li>
<li>
<p>Что выведет команда <code>cat /proc/$$/environ</code>? Как еще можно получить аналогичный по содержанию вывод?</p>
<p>Выводится действующее окружение, можно использовать команду env</p> 
</li>
<li>
<p>Используя <code>man</code>, опишите что доступно по адресам <code>/proc/&lt;PID&gt;/cmdline</code>, <code>/proc/&lt;PID&gt;/exe</code>.</p>
<p> /proc/[pid]/cmdline
              This read-only file holds the complete command line for the process, unless the process is a zombie.  In the latter case, there is nothing in this file: that is, a read on  this  file  will
              return 0 characters.  The command-line arguments appear in this file as a set of strings separated by null bytes ('\0'), with a further null byte after the last string.</p>
<p>Т.е. cmdline содержит полную строку запуска процесса</p>
<p> /proc/[pid]/exe
              Under  Linux 2.2 and later, this file is a symbolic link containing the actual pathname of the executed command.  This symbolic link can be dereferenced normally; attempting to open it will
              open the executable.  You can even type /proc/[pid]/exe to run another copy of the same executable that is being run by process [pid].  If the pathname has been unlinked, the symbolic  link
              will  contain the string '(deleted)' appended to the original pathname.  In a multithreaded process, the contents of this symbolic link are not available if the main thread has already ter‐
              minated (typically by calling pthread_exit(3))</p>
<p>Фактически это симлинк на исполняемый файл.</p>
</li>
<li>
<p>Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью <code>/proc/cpuinfo</code>.</p>
<p>4_2
<p>'''cat /proc/cpuinfo | grep sse
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology cpuid pni pclmulqdq
sse3 fma cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti ssbd ibrs ibpb stibp fsgsbase bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 xsaves flush_l1d arch_capabilities
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology cpuid pni pclmulqdq
sse3 fma cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti ssbd ibrs ibpb stibp fsgsbase bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 xsaves flush_l1d arch_capabilities
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology cpuid pni pclmulqdq
sse3 fma cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti ssbd ibrs ibpb stibp fsgsbase bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 xsaves flush_l1d arch_capabilities
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology cpuid pni pclmulqdq
sse3 fma cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti ssbd ibrs ibpb stibp fsgsbase bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 xsaves flush_l1d arch_capabilities'''</p>
</li>
<li>
<p>При открытии нового окна терминала и <code>vagrant ssh</code> создается новая сессия и выделяется pty. Это можно подтвердить командой <code>tty</code>, которая упоминалась в лекции 3.2. Однако:</p>
<div class="highlight highlight-source-shell position-relative" data-snippet-clipboard-copy-content="vagrant@netology1:~$ ssh localhost 'tty'
not a tty
"><pre>vagrant@netology1:<span class="pl-k">~</span>$ ssh localhost <span class="pl-s"><span class="pl-pds">'</span>tty<span class="pl-pds">'</span></span>
not a tty</pre></div>
<p>Почитайте, почему так происходит, и как изменить поведение.</p>
<p>По дефолту tty не выделяется, решается <code>ssh -t localhost 'tty"</code></p>
</li>
<li>
<p>Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую. Попробуйте сделать это, воспользовавшись <code>reptyr</code>. Например, так можно перенести в <code>screen</code> процесс, который вы запустили по ошибке в обычной SSH-сессии.</p>
</li>
<p>
'''vitsin$ ps -a
  PID TTY          TIME CMD
   66 pts/2    00:00:00 ping
   75 pts/1    00:00:00 ps
11:33:32 vitsin@FinDir:/mnt/c/Users/vitsin$ sudo reptyr -T 66
64 bytes from ya.ru (87.250.250.242): icmp_seq=51 ttl=247 time=19.8 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=52 ttl=247 time=17.1 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=53 ttl=247 time=11.1 ms
'''
</p>
<li>
<p><code>sudo echo string &gt; /root/new_file</code> не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а, который запущен без <code>sudo</code> под вашим пользователем. Для решения данной проблемы можно использовать конструкцию <code>echo string | sudo tee /root/new_file</code>. Узнайте что делает команда <code>tee</code> и почему в отличие от <code>sudo echo</code> команда с <code>sudo tee</code> будет работать.</p>
<p></p> Echo - выводит введенные данные. tee - забирает результат ввода и может записать в файл и вывести на STDOUT.
</li>

  </body>
</html>

