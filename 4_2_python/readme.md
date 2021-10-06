
<h2><a id="user-content-обязательные-задания" class="anchor" aria-hidden="true" href="#обязательные-задания"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Обязательные задания</h2>
<ol>
<li>
<p>Есть скрипт:</p>
<div class="highlight highlight-source-python position-relative overflow-auto" data-snippet-clipboard-copy-content="#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
"><pre><span class="pl-c">#!/usr/bin/env python3
a = 1
b = '2'
c = a + b</span>
<span class="pl-s1">a</span> <span class="pl-c1">=</span> <span class="pl-c1">1</span>
<span class="pl-s1">b</span> <span class="pl-c1">=</span> <span class="pl-s">'2'</span>
<span class="pl-s1">c</span> <span class="pl-c1">=</span> <span class="pl-s1">a</span> <span class="pl-c1">+</span> <span class="pl-s1">b</span></pre></div>
<ul>
<li>Какое значение будет присвоено переменной c?</li>
<p> А никакого. Python не умеет складывать данные разных типов
<li>Как получить для переменной c значение 12?</li>
Заключаем значение a в кавычки, чтобы придать свойство строки
<p>a = '1'
<p>b = '2'
<p>c = a + b
<li>Как получить для переменной c значение 3?</li>
Наоборот убираем кавычки, чтобы b стало int
<p>a = 1
<p>b = 2
<p>c = a + b
<p>
<p> P.s. Если переменные заданы жестко, то привести переменные к нужному типу данных можно и в строке операции: c = str(a) + b и c = a + int(b) соответственно.
</ul>
</li>
<li>
<p>Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?</p>
<div class="highlight highlight-source-python position-relative overflow-auto" data-snippet-clipboard-copy-content="#!/usr/bin/env python3

import os

bash_command = [&quot;cd ~/netology/sysadm-homeworks&quot;, &quot;git status&quot;]
result_os = os.popen(' &amp;&amp; '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break

"><pre><span class="pl-c">#!/usr/bin/env python3</span>

<span class="pl-k">import</span> <span class="pl-s1">os</span>

<span class="pl-s1">bash_command</span> <span class="pl-c1">=</span> [<span class="pl-s">"cd ~/netology/sysadm-homeworks"</span>, <span class="pl-s">"git status"</span>]
<span class="pl-s1">result_os</span> <span class="pl-c1">=</span> <span class="pl-s1">os</span>.<span class="pl-en">popen</span>(<span class="pl-s">' &amp;&amp; '</span>.<span class="pl-en">join</span>(<span class="pl-s1">bash_command</span>)).<span class="pl-en">read</span>()
<span class="pl-s1">is_change</span> <span class="pl-c1">=</span> <span class="pl-c1">False</span>
<span class="pl-k">for</span> <span class="pl-s1">result</span> <span class="pl-c1">in</span> <span class="pl-s1">result_os</span>.<span class="pl-en">split</span>(<span class="pl-s">'<span class="pl-cce">\n</span>'</span>):
    <span class="pl-k">if</span> <span class="pl-s1">result</span>.<span class="pl-en">find</span>(<span class="pl-s">'modified'</span>) <span class="pl-c1">!=</span> <span class="pl-c1">-</span><span class="pl-c1">1</span>:
        <span class="pl-s1">prepare_result</span> <span class="pl-c1">=</span> <span class="pl-s1">result</span>.<span class="pl-en">replace</span>(<span class="pl-s">'<span class="pl-cce">\t</span>modified:   '</span>, <span class="pl-s">''</span>)
        <span class="pl-en">print</span>(<span class="pl-s1">prepare_result</span>)
        <span class="pl-k">break</span></pre></div>
<p> Не очень понятно, что за переменная is_change. Точнее понятно, что она не используется. Ну и break относится к телу If. т.е. после первого найденного результата цикл прекратит работу.
<p> Если убрать и is_change и break, то все будет работать корректно.
</li>
<li>
<p>Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.</p>

import os
import sys

test_dir = os.getcwd()

if len(sys.argv)>=2:
    test_dir = sys.argv[1]
bash_command = ["cd " + test_dir, "git status 2>&1"]

result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('fatal') != -1:
        print('Каталог ' + test_dir + ' не является GIT репозиторием')
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified: ', '')
        print(prepare_result)
</code>
</li>
<li>
<p>Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: &lt;URL сервиса&gt; - &lt;его IP&gt;. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] &lt;URL сервиса&gt; IP mismatch: &lt;старый IP&gt; &lt;Новый IP&gt;. Будем считать, что наша разработка реализовала сервисы: drive.google.com, mail.google.com, google.com.</p>
</li>
</ol>
<h2><a id="user-content-дополнительное-задание-со-звездочкой---необязательно-к-выполнению" class="anchor" aria-hidden="true" href="#дополнительное-задание-со-звездочкой---необязательно-к-выполнению"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Дополнительное задание (со звездочкой*) - необязательно к выполнению</h2>
<p>Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз переносить архив с нашими изменениями с сервера на наш локальный компьютер, формировать новую ветку, коммитить в неё изменения, создавать pull request (PR) и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. Мы хотим максимально автоматизировать всю цепочку действий. Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым). При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. С директорией локального репозитория можно делать всё, что угодно. Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. Важно получить конечный результат с созданным PR, в котором применяются наши изменения.</p>
<hr>
<h3><a id="user-content-как-сдавать-задания" class="anchor" aria-hidden="true" href="#как-сдавать-задания"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Как сдавать задания?</h3>
<p>Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.</p>
<hr>
</article>
  </div>

    </div>

  </readme-toc>



  <details class="details-reset details-overlay details-overlay-dark" id="jumpto-line-details-dialog">
    <summary data-hotkey="l" aria-label="Jump to line"></summary>
    <details-dialog class="Box Box--overlay d-flex flex-column anim-fade-in fast linejump" aria-label="Jump to line">
      <!-- '"` --><!-- </textarea></xmp> --></option></form><form class="js-jump-to-line-form Box-body d-flex" action="" accept-charset="UTF-8" method="get">
        <input class="form-control flex-auto mr-3 linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" aria-label="Jump to line" autofocus>
        <button data-close-dialog="" type="submit" data-view-component="true" class="btn">

  Go


</button>
</form>    </details-dialog>
  </details>

    <div class="Popover anim-scale-in js-tagsearch-popover"
     hidden
     data-tagsearch-url="/netology-code/sysadm-homeworks/find-definition"
     data-tagsearch-ref="devsys10"
     data-tagsearch-path="04-script-02-py/README.md"
     data-tagsearch-lang="Markdown"
     data-hydro-click="{&quot;event_type&quot;:&quot;code_navigation.click_on_symbol&quot;,&quot;payload&quot;:{&quot;action&quot;:&quot;click_on_symbol&quot;,&quot;repository_id&quot;:252076404,&quot;ref&quot;:&quot;devsys10&quot;,&quot;language&quot;:&quot;Markdown&quot;,&quot;originating_url&quot;:&quot;https://github.com/netology-code/sysadm-homeworks/blob/devsys10/04-script-02-py/README.md&quot;,&quot;user_id&quot;:79792682}}"
     data-hydro-click-hmac="370861881e1e723da3d59f18dbb04c8923cc02e2922fdc0993637a0c48209e62">
  <div class="Popover-message Popover-message--large Popover-message--top-left TagsearchPopover mt-1 mb-4 mx-auto Box color-shadow-large">
    <div class="TagsearchPopover-content js-tagsearch-popover-content overflow-auto" style="will-change:transform;">
    </div>
  </div>
</div>


</div>



  </div>
</div>

    </main>
  </div>



  </div>


<div class="footer container-xl width-full p-responsive" role="contentinfo">
  <div class="position-relative d-flex flex-row-reverse flex-lg-row flex-wrap flex-lg-nowrap flex-justify-center flex-lg-justify-between pt-6 pb-2 mt-6 f6 color-text-secondary border-top color-border-secondary ">
    <ul class="list-style-none d-flex flex-wrap col-12 col-lg-5 flex-justify-center flex-lg-justify-between mb-2 mb-lg-0">
      <li class="mr-3 mr-lg-0">&copy; 2021 GitHub, Inc.</li>
        <li class="mr-3 mr-lg-0"><a href="https://docs.github.com/en/github/site-policy/github-terms-of-service" data-hydro-click="{&quot;event_type&quot;:&quot;analytics.event&quot;,&quot;payload&quot;:{&quot;category&quot;:&quot;Footer&quot;,&quot;action&quot;:&quot;go to terms&quot;,&quot;label&quot;:&quot;text:terms&quot;,&quot;originating_url&quot;:&quot;https://github.com/netology-code/sysadm-homeworks/blob/devsys10/04-script-02-py/README.md&quot;,&quot;user_id&quot;:79792682}}" data-hydro-click-hmac="ba04b0298225f5f76190c2bd4b216be3e26a846239fbd7ce14849764b3632ab5">Terms</a></li>
        <li class="mr-3 mr-lg-0"><a href="https://docs.github.com/en/github/site-policy/github-privacy-statement" data-hydro-click="{&quot;event_type&quot;:&quot;analytics.event&quot;,&quot;payload&quot;:{&quot;category&quot;:&quot;Footer&quot;,&quot;action&quot;:&quot;go to privacy&quot;,&quot;label&quot;:&quot;text:privacy&quot;,&quot;originating_url&quot;:&quot;https://github.com/netology-code/sysadm-homeworks/blob/devsys10/04-script-02-py/README.md&quot;,&quot;user_id&quot;:79792682}}" data-hydro-click-hmac="931ed17e811da68fe8627482a5c342fe39ea3ad43c857f01c2abc3fa105b6fe0">Privacy</a></li>
        <li class="mr-3 mr-lg-0"><a data-hydro-click="{&quot;event_type&quot;:&quot;analytics.event&quot;,&quot;payload&quot;:{&quot;category&quot;:&quot;Footer&quot;,&quot;action&quot;:&quot;go to security&quot;,&quot;label&quot;:&quot;text:security&quot;,&quot;originating_url&quot;:&quot;https://github.com/netology-code/sysadm-homeworks/blob/devsys10/04-script-02-py/README.md&quot;,&quot;user_id&quot;:79792682}}" data-hydro-click-hmac="e4c6339a79bbf84bcbaf5d0fe883c9ec434a6faf80b169f5732dd3b3f5a29e8f" href="https://github.com/security">Security</a></li>
        <li class="mr-3 mr-lg-0"><a href="https://www.githubstatus.com/" data-hydro-click="{&quot;event_type&quot;:&quot;analytics.event&quot;,&quot;payload&quot;:{&quot;category&quot;:&quot;Footer&quot;,&quot;action&quot;:&quot;go to status&quot;,&quot;label&quot;:&quot;text:status&quot;,&quot;originating_url&quot;:&quot;https://github.com/netology-code/sysadm-homeworks/blob/devsys10/04-script-02-py/README.md&quot;,&quot;user_id&quot;:79792682}}" data-hydro-click-hmac="7f94134c180dab4212a688ae88450c0ef4b46294e1796d44b53fb85ee5e639d4">Status</a></li>
        <li><a data-ga-click="Footer, go to help, text:Docs" href="https://docs.github.com">Docs</a></li>
    </ul>

    <a aria-label="Homepage" title="GitHub" class="footer-octicon d-none d-lg-block mx-lg-4" href="https://github.com">
      <svg aria-hidden="true" height="24" viewBox="0 0 16 16" version="1.1" width="24" data-view-component="true" class="octicon octicon-mark-github">
    <path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"></path>
</svg>
</a>
    <ul class="list-style-none d-flex flex-wrap col-12 col-lg-5 flex-justify-center flex-lg-justify-between mb-2 mb-lg-0">
        <li class="mr-3 mr-lg-0"><a href="https://support.github.com?tags=dotcom-footer" data-hydro-click="{&quot;event_type&quot;:&quot;analytics.event&quot;,&quot;payload&quot;:{&quot;category&quot;:&quot;Footer&quot;,&quot;action&quot;:&quot;go to contact&quot;,&quot;label&quot;:&quot;text:contact&quot;,&quot;originating_url&quot;:&quot;https://github.com/netology-code/sysadm-homeworks/blob/devsys10/04-script-02-py/README.md&quot;,&quot;user_id&quot;:79792682}}" data-hydro-click-hmac="281e9993fd835507d740d564b6e133c81de2ecd1f7f8d42dc56ff256db3cc8c4">Contact GitHub</a></li>
        <li class="mr-3 mr-lg-0"><a href="https://github.com/pricing" data-hydro-click="{&quot;event_type&quot;:&quot;analytics.event&quot;,&quot;payload&quot;:{&quot;category&quot;:&quot;Footer&quot;,&quot;action&quot;:&quot;go to Pricing&quot;,&quot;label&quot;:&quot;text:Pricing&quot;,&quot;originating_url&quot;:&quot;https://github.com/netology-code/sysadm-homeworks/blob/devsys10/04-script-02-py/README.md&quot;,&quot;user_id&quot;:79792682}}" data-hydro-click-hmac="35fa54a1ad8fcddb472c08606be413c3b4811ec7e7d8c007c65ac76a57a07193">Pricing</a></li>
      <li class="mr-3 mr-lg-0"><a href="https://docs.github.com" data-hydro-click="{&quot;event_type&quot;:&quot;analytics.event&quot;,&quot;payload&quot;:{&quot;category&quot;:&quot;Footer&quot;,&quot;action&quot;:&quot;go to api&quot;,&quot;label&quot;:&quot;text:api&quot;,&quot;originating_url&quot;:&quot;https://github.com/netology-code/sysadm-homeworks/blob/devsys10/04-script-02-py/README.md&quot;,&quot;user_id&quot;:79792682}}" data-hydro-click-hmac="f98409ddbe981d4e1a66b2527f684402ce23072088ed8cd14babd3aec5cbafcb">API</a></li>
      <li class="mr-3 mr-lg-0"><a href="https://services.github.com" data-hydro-click="{&quot;event_type&quot;:&quot;analytics.event&quot;,&quot;payload&quot;:{&quot;category&quot;:&quot;Footer&quot;,&quot;action&quot;:&quot;go to training&quot;,&quot;label&quot;:&quot;text:training&quot;,&quot;originating_url&quot;:&quot;https://github.com/netology-code/sysadm-homeworks/blob/devsys10/04-script-02-py/README.md&quot;,&quot;user_id&quot;:79792682}}" data-hydro-click-hmac="536c3be49264d8c331c1fde11207fc205ea50abe0a0f81de3b559911cbffe887">Training</a></li>
        <li class="mr-3 mr-lg-0"><a href="https://github.blog" data-hydro-click="{&quot;event_type&quot;:&quot;analytics.event&quot;,&quot;payload&quot;:{&quot;category&quot;:&quot;Footer&quot;,&quot;action&quot;:&quot;go to blog&quot;,&quot;label&quot;:&quot;text:blog&quot;,&quot;originating_url&quot;:&quot;https://github.com/netology-code/sysadm-homeworks/blob/devsys10/04-script-02-py/README.md&quot;,&quot;user_id&quot;:79792682}}" data-hydro-click-hmac="640afaecb219e3c0511fb6c0e8baf903750cf62d350a3084399d260bc6603e64">Blog</a></li>
        <li><a data-ga-click="Footer, go to about, text:about" href="https://github.com/about">About</a></li>
    </ul>
  </div>
  <div class="d-flex flex-justify-center pb-6">
    <span class="f6 color-text-tertiary"></span>
  </div>
</div>



  <div id="ajax-error-message" class="ajax-error-message flash flash-error" hidden>
    <svg aria-hidden="true" height="16" viewBox="0 0 16 16" version="1.1" width="16" data-view-component="true" class="octicon octicon-alert">
    <path fill-rule="evenodd" d="M8.22 1.754a.25.25 0 00-.44 0L1.698 13.132a.25.25 0 00.22.368h12.164a.25.25 0 00.22-.368L8.22 1.754zm-1.763-.707c.659-1.234 2.427-1.234 3.086 0l6.082 11.378A1.75 1.75 0 0114.082 15H1.918a1.75 1.75 0 01-1.543-2.575L6.457 1.047zM9 11a1 1 0 11-2 0 1 1 0 012 0zm-.25-5.25a.75.75 0 00-1.5 0v2.5a.75.75 0 001.5 0v-2.5z"></path>
</svg>
    <button type="button" class="flash-close js-ajax-error-dismiss" aria-label="Dismiss error">
      <svg aria-hidden="true" height="16" viewBox="0 0 16 16" version="1.1" width="16" data-view-component="true" class="octicon octicon-x">
    <path fill-rule="evenodd" d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z"></path>
</svg>
    </button>
    You can’t perform that action at this time.
  </div>

  <div class="js-stale-session-flash flash flash-warn flash-banner" hidden
    >
    <svg aria-hidden="true" height="16" viewBox="0 0 16 16" version="1.1" width="16" data-view-component="true" class="octicon octicon-alert">
    <path fill-rule="evenodd" d="M8.22 1.754a.25.25 0 00-.44 0L1.698 13.132a.25.25 0 00.22.368h12.164a.25.25 0 00.22-.368L8.22 1.754zm-1.763-.707c.659-1.234 2.427-1.234 3.086 0l6.082 11.378A1.75 1.75 0 0114.082 15H1.918a1.75 1.75 0 01-1.543-2.575L6.457 1.047zM9 11a1 1 0 11-2 0 1 1 0 012 0zm-.25-5.25a.75.75 0 00-1.5 0v2.5a.75.75 0 001.5 0v-2.5z"></path>
</svg>
    <span class="js-stale-session-flash-signed-in" hidden>You signed in with another tab or window. <a href="">Reload</a> to refresh your session.</span>
    <span class="js-stale-session-flash-signed-out" hidden>You signed out in another tab or window. <a href="">Reload</a> to refresh your session.</span>
  </div>
    <template id="site-details-dialog">
  <details class="details-reset details-overlay details-overlay-dark lh-default color-text-primary hx_rsm" open>
    <summary role="button" aria-label="Close dialog"></summary>
    <details-dialog class="Box Box--overlay d-flex flex-column anim-fade-in fast hx_rsm-dialog hx_rsm-modal">
      <button class="Box-btn-octicon m-0 btn-octicon position-absolute right-0 top-0" type="button" aria-label="Close dialog" data-close-dialog>
        <svg aria-hidden="true" height="16" viewBox="0 0 16 16" version="1.1" width="16" data-view-component="true" class="octicon octicon-x">
    <path fill-rule="evenodd" d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z"></path>
</svg>
      </button>
      <div class="octocat-spinner my-6 js-details-dialog-spinner"></div>
    </details-dialog>
  </details>
</template>

    <div class="Popover js-hovercard-content position-absolute" style="display: none; outline: none;" tabindex="0">
  <div class="Popover-message Popover-message--bottom-left Popover-message--large Box color-shadow-large" style="width:360px;">
  </div>
</div>

    <template id="snippet-clipboard-copy-button">
  <div class="zeroclipboard-container position-absolute right-0 top-0">
    <clipboard-copy aria-label="Copy" class="ClipboardButton btn js-clipboard-copy m-2 p-0 tooltipped-no-delay" data-copy-feedback="Copied!" data-tooltip-direction="w">
      <svg aria-hidden="true" height="16" viewBox="0 0 16 16" version="1.1" width="16" data-view-component="true" class="octicon octicon-copy js-clipboard-copy-icon m-2">
    <path fill-rule="evenodd" d="M0 6.75C0 5.784.784 5 1.75 5h1.5a.75.75 0 010 1.5h-1.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 00.25-.25v-1.5a.75.75 0 011.5 0v1.5A1.75 1.75 0 019.25 16h-7.5A1.75 1.75 0 010 14.25v-7.5z"></path><path fill-rule="evenodd" d="M5 1.75C5 .784 5.784 0 6.75 0h7.5C15.216 0 16 .784 16 1.75v7.5A1.75 1.75 0 0114.25 11h-7.5A1.75 1.75 0 015 9.25v-7.5zm1.75-.25a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 00.25-.25v-7.5a.25.25 0 00-.25-.25h-7.5z"></path>
</svg>
      <svg aria-hidden="true" height="16" viewBox="0 0 16 16" version="1.1" width="16" data-view-component="true" class="octicon octicon-check js-clipboard-check-icon color-text-success d-none m-2">
    <path fill-rule="evenodd" d="M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z"></path>
</svg>
    </clipboard-copy>
  </div>
</template>


    <style>
      .user-mention[href$="/vitsinv"] {
        color: var(--color-user-mention-fg);
        background-color: var(--color-user-mention-bg);
        border-radius: 2px;
        margin-left: -2px;
        margin-right: -2px;
        padding: 0 2px;
      }
    </style>


  </body>
</html>
