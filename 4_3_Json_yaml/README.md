<h2><a id="user-content-обязательные-задания" class="anchor" aria-hidden="true" href="#обязательные-задания"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Обязательные задания</h2>
<ol>
<li>Мы выгрузили JSON, который получили через API запрос к нашему сервису:
<div class="highlight highlight-source-json position-relative overflow-auto" data-snippet-clipboard-copy-content="{ &quot;info&quot; : &quot;Sample JSON output from our service\t&quot;,
    &quot;elements&quot; :[
        { &quot;name&quot; : &quot;first&quot;,
        &quot;type&quot; : &quot;server&quot;,
        &quot;ip&quot; : 7175 
        },
        { &quot;name&quot; : &quot;second&quot;,
        &quot;type&quot; : &quot;proxy&quot;,
        &quot;ip : 71.78.22.43
        }
    ]
}
"><pre>{ <span class="pl-s"><span class="pl-pds">"</span>info<span class="pl-pds">"</span></span> : <span class="pl-s"><span class="pl-pds">"</span>Sample JSON output from our service<span class="pl-cce">\t</span><span class="pl-pds">"</span></span>,
    <span class="pl-s"><span class="pl-pds">"</span>elements<span class="pl-pds">"</span></span> :[
        { <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span> : <span class="pl-s"><span class="pl-pds">"</span>first<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span> : <span class="pl-s"><span class="pl-pds">"</span>server<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>ip<span class="pl-pds">"</span></span> : <span class="pl-c1">7175</span> 
        },
        { <span class="pl-s"><span class="pl-pds">"</span>name<span class="pl-pds">"</span></span> : <span class="pl-s"><span class="pl-pds">"</span>second<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>type<span class="pl-pds">"</span></span> : <span class="pl-s"><span class="pl-pds">"</span>proxy<span class="pl-pds">"</span></span>,
        <span class="pl-s"><span class="pl-pds">"</span>ip : 71.78.22.43</span>
<span class="pl-s">        }</span>
<span class="pl-s">    ]</span>
<span class="pl-s">}</span></pre></div>
</li>
</ol>
<p>Нужно найти и исправить все ошибки, которые допускает наш сервис</p>

* в строке `"ip : 71.78.22.43` явно не хватает закрывающих кавычек. но поскольку значение представляет собой строку, то в кавычки надо заключить и его: `"ip" : "71.78.22.43"`
<ol start="2">
<li>В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: { "имя сервиса" : "его IP"}. Формат записи YAML по одному сервису: - имя сервиса: его IP. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.</li>

* Я еще зачем-то входные данные засунул в JSON, но думаю это не ошибка.
```py
import socket
import time
import json
import yaml

# Задаем стартовые значения
# Счетчик проверок
count = 0
# пауза перед следующей проверкой
pause = 1
# Путь к директории с файлами
path = 'C:\\Users\\vitsin\\Documents\\netology.devops\\4_3_Json_yaml\\'
# Имена хостов и первоначальные IP из JSON
with open(path + 'input_data\\data_in.json', 'r') as j_in:
    hosts = json.load(j_in)
init = 0


# Выводим стартовые значения
print(hosts)
print('======================================================================================')

# Задаем количество проверок
while count >= 0 and count < 3:
  # Перебираем значения
  for name in hosts:
    # Получаем реальный IP
    ip = socket.gethostbyname(name)
    # Если не соответствует заданному, выводим сообщение
    if ip != hosts[name]:
      if count == 0 and init != 1:
        print(' [ERROR] ' + str(name) + ' IP mismatch: ' + hosts[name] + ' ' + ip)
      # Перезаписываем стартовые значения на полученные
      hosts[name] = ip
      # Записываем JSON
      with open(path + 'out_data\\data_out.json', 'w') as j_out:
        json.dump(dict(hosts),  j_out, indent=4)
      # Записываем YML
      with open(path + 'out_data\\data_out.yml', 'w') as y_out:
        yaml.dump(dict(hosts),  y_out, indent=4)

  # Для наглядности
  print(hosts)
  # Увеличиваем счетчик
  count = count + 1
  # Устанавливаем время между проверками
  time.sleep(pause)
  ```

</ol>
