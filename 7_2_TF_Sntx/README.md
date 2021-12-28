
<h2 dir="auto">Задача 1 (вариант с AWS). Регистрация в aws и знакомство с основами (необязательно, но крайне желательно).</h2>
<p dir="auto">Остальные задания можно будет выполнять и без этого аккаунта, но с ним можно будет увидеть полный цикл процессов.</p>
<p dir="auto">AWS предоставляет достаточно много бесплатных ресурсов в первый год после регистрации, подробно описано <a href="https://aws.amazon.com/free/" rel="nofollow">здесь</a>.</p>
<ol dir="auto">
<li>Создайте аккаут aws.</li>
<li>Установите c aws-cli <a href="https://aws.amazon.com/cli/" rel="nofollow">https://aws.amazon.com/cli/</a>.</li>
<li>Выполните первичную настройку aws-sli <a href="https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html" rel="nofollow">https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html</a>.</li>
<li>Создайте IAM политику для терраформа c правами
<ul dir="auto">
<li>AmazonEC2FullAccess</li>
<li>AmazonS3FullAccess</li>
<li>AmazonDynamoDBFullAccess</li>
<li>AmazonRDSFullAccess</li>
<li>CloudWatchFullAccess</li>
<li>IAMFullAccess</li>
</ul>
</li>
<li>Добавьте переменные окружения
<div class="snippet-clipboard-content position-relative overflow-auto" data-snippet-clipboard-copy-content="export AWS_ACCESS_KEY_ID=(your access key id)
export AWS_SECRET_ACCESS_KEY=(your secret access key)"><pre><code>export AWS_ACCESS_KEY_ID=(your access key id)
export AWS_SECRET_ACCESS_KEY=(your secret access key)
</code></pre></div>
</li>
<li>Создайте, остановите и удалите ec2 инстанс (любой с пометкой <code>free tier</code>) через веб интерфейс.</li>
</ol>
<p dir="auto">В виде результата задания приложите вывод команды <code>aws configure list</code>.</p>

```
vagrant@ubuntu-20:~/aws$ aws configure list
      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************KQG6 shared-credentials-file
secret_key     ****************Ld45 shared-credentials-file
    region                eu-west-3      config-file    ~/.aws/config
```
<h2 dir="auto"></a>Задача 1 (Вариант с Yandex.Cloud). Регистрация в ЯО и знакомство с основами (необязательно, но крайне желательно).</h2>
<ol dir="auto">
<li>Подробная инструкция на русском языке содержится <a href="https://cloud.yandex.ru/docs/solutions/infrastructure-management/terraform-quickstart" rel="nofollow">здесь</a>.</li>
<li>Обратите внимание на период бесплатного использования после регистрации аккаунта.</li>
<li>Используйте раздел "Подготовьте облако к работе" для регистрации аккаунта. Далее раздел "Настройте провайдер" для подготовки
базового терраформ конфига.</li>
<li>Воспользуйтесь <a href="https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs" rel="nofollow">инструкцией</a> на сайте терраформа, что бы
не указывать авторизационный токен в коде, а терраформ провайдер брал его из переменных окружений.</li>
</ol>
<h2 dir="auto"><a id="user-content-задача-2-создание-aws-ec2-или-yandex_compute_instance-через-терраформ" class="anchor" aria-hidden="true" href="#задача-2-создание-aws-ec2-или-yandex_compute_instance-через-терраформ"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Задача 2. Создание aws ec2 или yandex_compute_instance через терраформ.</h2>
<ol dir="auto">
<li>В каталоге <code>terraform</code> вашего основного репозитория, который был создан в начале курсе, создайте файл <code>main.tf</code> и <code>versions.tf</code>.</li>
<li>Зарегистрируйте провайдер
<ol dir="auto">
<li>для <a href="https://registry.terraform.io/providers/hashicorp/aws/latest/docs" rel="nofollow">aws</a>. В файл <code>main.tf</code> добавьте
блок <code>provider</code>, а в <code>versions.tf</code> блок <code>terraform</code> с вложенным блоком <code>required_providers</code>. Укажите любой выбранный вами регион
внутри блока <code>provider</code>.</li>
<li>либо для <a href="https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs" rel="nofollow">yandex.cloud</a>. Подробную инструкцию можно найти
<a href="https://cloud.yandex.ru/docs/solutions/infrastructure-management/terraform-quickstart" rel="nofollow">здесь</a>.</li>

```
vagrant@ubuntu-20:~/yandex-cloud/7_2$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of yandex-cloud/yandex...
- Installing yandex-cloud/yandex v0.69.0...
- Installed yandex-cloud/yandex v0.69.0 (self-signed, key ID E40F590B50BB8E40)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
</ol>
</li>
<li>Внимание! В гит репозиторий нельзя пушить ваши личные ключи доступа к аккаунту. Поэтому в предыдущем задании мы указывали
их в виде переменных окружения.</li>
<li>В файле <code>main.tf</code> воспользуйтесь блоком <code>data "aws_ami</code> для поиска ami образа последнего Ubuntu.</li>
<li>В файле <code>main.tf</code> создайте рессурс
<ol dir="auto">
<li>либо <a href="https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance" rel="nofollow">ec2 instance</a>.
Постарайтесь указать как можно больше параметров для его определения. Минимальный набор параметров указан в первом блоке
<code>Example Usage</code>, но желательно, указать большее количество параметров.</li>
<li>либо <a href="https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_image" rel="nofollow">yandex_compute_image</a>.</li>
</ol>
</li>
<li>Также в случае использования aws:
<ol dir="auto">
<li>Добавьте data-блоки <code>aws_caller_identity</code> и <code>aws_region</code>.</li>
<li>В файл <code>outputs.tf</code> поместить блоки <code>output</code> с данными об используемых в данный момент:
<ul dir="auto">
<li>AWS account ID,</li>
<li>AWS user ID,</li>
<li>AWS регион, который используется в данный момент,</li>
<li>Приватный IP ec2 инстансы,</li>
<li>Идентификатор подсети в которой создан инстанс.</li>
</ul>
</li>
</ol>
</li>
<li>Если вы выполнили первый пункт, то добейтесь того, что бы команда <code>terraform plan</code> выполнялась без ошибок.</li>

```
vagrant@ubuntu-20:~/yandex-cloud/7_2$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.node01 will be created
  + resource "yandex_compute_instance" "node01" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "node01.netology.cloud"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCald/EX4Jl3GkLkbaRZ1a2GOtRB8ZBNb2HiqThLGm4m90CEj+AA4f65BoUUf5S36tllFc0tfALZr9nAhv4YOY0knRcKlqv3Nmo1kUwHDQuCujIU0NL6PmyoVdaFh63W6r0HnibeRGbs747BoEf+2+KQaIjfl/jRadmHJq30n3AvBBkoFpXf3ukS+q5EVCddObt9sPAZ3ZuSlBCyEMTJQiPTbzJmysuIEEDDEdovQRDn3BV07c/6BQosYl7acAI/1dgy2BbRS5bmLt7h/VC5EAXf9Rpc5Ua/gh6QzXt/BD++U1NEpDsSVSrtavcdiWGMl+owVegmD/NnbmCYA/IZokvSv8YkiTYSyXY5wxEi7aN0nklkF7DuRlYPdeV/0g8zsR6pUL5qh2p1CedCpBwZVUX+TAWi/SPnAqD27glWm+zGrAGDAFJ4BpvX5rHuXek8spLyiEASmpXSdYUwHv6vk4a7bYuNt77Pig2+8kE3LYIRGAFzmSd4dLSWqu1ZzQtFNs= vagrant@ubuntu-20
            EOT
        }
      + name                      = "node01"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8qrqqgk9hd7822tjfg"
              + name        = "root-node01"
              + size        = 50
              + snapshot_id = (known after apply)
              + type        = "network-nvme"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + placement_group_id = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 8
          + memory        = 8
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_vpc_network.default will be created
  + resource "yandex_vpc_network" "default" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "net"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.default will be created
  + resource "yandex_vpc_subnet" "default" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.101.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if
you run "terraform apply" now.
```
</ol>
<p dir="auto">В качестве результата задания предоставьте:</p>
<ol dir="auto">
<li>Ответ на вопрос: при помощи какого инструмента (из разобранных на прошлом занятии) можно создать свой образ ami?</li>

  * CloudFormation
<li>Ссылку на репозиторий с исходной конфигурацией терраформа.</li>

  * 
</ol>
