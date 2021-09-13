
<li>
<p>Узнайте о <a href="https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB" rel="nofollow">sparse</a> (разряженных) файлах.</p>
</li>
<li>
<p>Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?</p>
<p>Нет. Потому что, hard link это еще одно название целевого файла. имеет те же свойства что и сам файл. так же в системе и файл и все жесткие ссылки будут иметь один файловый дескриптор(inode).
</li>
<li>
<p>Сделайте <code>vagrant destroy</code> на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:</p>
<div class="highlight highlight-source-shell position-relative" data-snippet-clipboard-copy-content="Vagrant.configure(&quot;2&quot;) do |config|
  config.vm.box = &quot;bento/ubuntu-20.04&quot;
  config.vm.provider :virtualbox do |vb|
    lvm_experiments_disk0_path = &quot;/tmp/lvm_experiments_disk0.vmdk&quot;
    lvm_experiments_disk1_path = &quot;/tmp/lvm_experiments_disk1.vmdk&quot;
    vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]
    vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk0_path]
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk1_path]
  end
end
"><pre>Vagrant.configure(<span class="pl-s"><span class="pl-pds">"</span>2<span class="pl-pds">"</span></span>) <span class="pl-k">do</span> <span class="pl-k">|</span>config<span class="pl-k">|</span>
  config.vm.box = <span class="pl-s"><span class="pl-pds">"</span>bento/ubuntu-20.04<span class="pl-pds">"</span></span>
  config.vm.provider :virtualbox <span class="pl-k">do</span> <span class="pl-k">|</span>vb<span class="pl-k">|</span>
    lvm_experiments_disk0_path = <span class="pl-s"><span class="pl-pds">"</span>/tmp/lvm_experiments_disk0.vmdk<span class="pl-pds">"</span></span>
    lvm_experiments_disk1_path = <span class="pl-s"><span class="pl-pds">"</span>/tmp/lvm_experiments_disk1.vmdk<span class="pl-pds">"</span></span>
    vb.customize [<span class="pl-s"><span class="pl-pds">'</span>createmedium<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>--filename<span class="pl-pds">'</span></span>, lvm_experiments_disk0_path, <span class="pl-s"><span class="pl-pds">'</span>--size<span class="pl-pds">'</span></span>, 2560]
    vb.customize [<span class="pl-s"><span class="pl-pds">'</span>createmedium<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>--filename<span class="pl-pds">'</span></span>, lvm_experiments_disk1_path, <span class="pl-s"><span class="pl-pds">'</span>--size<span class="pl-pds">'</span></span>, 2560]
    vb.customize [<span class="pl-s"><span class="pl-pds">'</span>storageattach<span class="pl-pds">'</span></span>, :id, <span class="pl-s"><span class="pl-pds">'</span>--storagectl<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>SATA Controller<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>--port<span class="pl-pds">'</span></span>, 1, <span class="pl-s"><span class="pl-pds">'</span>--device<span class="pl-pds">'</span></span>, 0, <span class="pl-s"><span class="pl-pds">'</span>--type<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>hdd<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>--medium<span class="pl-pds">'</span></span>, lvm_experiments_disk0_path]
    vb.customize [<span class="pl-s"><span class="pl-pds">'</span>storageattach<span class="pl-pds">'</span></span>, :id, <span class="pl-s"><span class="pl-pds">'</span>--storagectl<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>SATA Controller<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>--port<span class="pl-pds">'</span></span>, 2, <span class="pl-s"><span class="pl-pds">'</span>--device<span class="pl-pds">'</span></span>, 0, <span class="pl-s"><span class="pl-pds">'</span>--type<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>hdd<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>--medium<span class="pl-pds">'</span></span>, lvm_experiments_disk1_path]
  end
end</pre></div>
<p>Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.</p>
<p>
</li>
<li>
<p>Используя <code>fdisk</code>, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.</p>
<p>
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xc8d3c999

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdb1          2048 4196351 4194304    2G 83 Linux
/dev/sdb2       4196352 5242879 1046528  511M 83 Linux
</li>
<li>
<p>Используя <code>sfdisk</code>, перенесите данную таблицу разделов на второй диск.</p>
<p>
sudo sfdisk -d /dev/sdb | sudo sfdisk /dev/sdc
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0xc8d3c999.
/dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
/dev/sdc3: Done.

New situation:
Disklabel type: dos
Disk identifier: 0xc8d3c999

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc1          2048 4196351 4194304    2G 83 Linux
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
</li>
<li>
<p>Соберите <code>mdadm</code> RAID1 на паре разделов 2 Гб.</p>
<p>$ sudo mdadm --create --verbose /dev/md0 -l 1 -n 2 /dev/sd{b1,c1}
</li>
<li>
<p>Соберите <code>mdadm</code> RAID0 на второй паре маленьких разделов.</p>
<p>$ sudo mdadm --create --verbose /dev/md1 -l 0 -n 2 /dev/sd{b2,c2}
</li>
<li>
<p>Создайте 2 независимых PV на получившихся md-устройствах.</p>
<p>
vagrant@vagrant:~$ sudo pvcreate /dev/md0
  Physical volume "/dev/md0" successfully created.
vagrant@vagrant:~$ sudo pvcreate /dev/md1
  Physical volume "/dev/md1" successfully created.
</li>
<li>
<p>Создайте общую volume-group на этих двух PV.</p>
<p>
vagrant@vagrant:~$ sudo vgcreate vg1 /dev/md{0,1}
  Volume group "vg1" successfully created
</li>
<li>
<p>Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.</p>
<p>
vagrant@vagrant:~$ sudo lvcreate -L 100M vg1 /dev/md0
  Logical volume "lvol0" created.
</li>
<li>
<p>Создайте <code>mkfs.ext4</code> ФС на получившемся LV.</p>
<p> 
vagrant@vagrant:~$ sudo mkfs.ext4 /dev/vg1/lvol0
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
</li>
<li>
<p>Смонтируйте этот раздел в любую директорию, например, <code>/tmp/new</code>.</p>
<p>
vagrant@vagrant:~$ sudo mkdir /tmp/new
vagrant@vagrant:~$ sudo mount /dev/vg1/lvol0 /tmp/new
</li>
<li>
<p>Поместите туда тестовый файл, например <code>wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz</code>.</p>
<p>
vagrant@vagrant:~$ sudo wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
--2021-09-13 10:12:33--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 20979432 (20M) [application/octet-stream]
Saving to: ‘/tmp/new/test.gz’

/tmp/new/test.gz              100%[=================================================>]  20.01M  1.47MB/s    in 15s

2021-09-13 10:12:50 (1.32 MB/s) - ‘/tmp/new/test.gz’ saved [20979432/20979432]

vagrant@vagrant:~$ ls /tmp/new/
lost+found  test.gz
</li>
<li>
<p>Прикрепите вывод <code>lsblk</code>.</p>
<p>
vagrant@vagrant:~$ sudo lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part  /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
│ └─md0                9:0    0    2G  0 raid1
│   └─vg1-lvol0      253:2    0  100M  0 lvm   /tmp/new
└─sdb2                 8:18   0  511M  0 part
  └─md1                9:1    0 1018M  0 raid0
sdc                    8:32   0  2.5G  0 disk
├─sdc1                 8:33   0    2G  0 part
│ └─md0                9:0    0    2G  0 raid1
│   └─vg1-lvol0      253:2    0  100M  0 lvm   /tmp/new
└─sdc2                 8:34   0  511M  0 part
  └─md1                9:1    0 1018M  0 raid0
</li>
<li>
<p>Протестируйте целостность файла:</p>
<div class="highlight highlight-source-shell position-relative" data-snippet-clipboard-copy-content="root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
"><pre>root@vagrant:<span class="pl-k">~</span><span class="pl-c"><span class="pl-c">#</span> gzip -t /tmp/new/test.gz</span>
root@vagrant:<span class="pl-k">~</span><span class="pl-c"><span class="pl-c">#</span> echo $?</span>
0</pre></div>
<p> 
vagrant@vagrant:~$ sudo gzip -t /tmp/new/test.gz | echo $?
0
</li>
<li>
<p>Используя pvmove, переместите содержимое PV с RAID0 на RAID1.</p>
<p>
vagrant@vagrant:~$ sudo pvmove /dev/md0
  /dev/md0: Moved: 44.00%
  /dev/md0: Moved: 100.00%
</li>
<li>
<p>Сделайте <code>--fail</code> на устройство в вашем RAID1 md.</p>
<p>
vagrant@vagrant:~$ sudo mdadm /dev/md0 --fail /dev/sdb1
mdadm: set /dev/sdb1 faulty in /dev/md0
</li>
<li>
<p>Подтвердите выводом <code>dmesg</code>, что RAID1 работает в деградированном состоянии.</p>
<p>
vagrant@vagrant:~$ sudo dmesg | grep md0
[51516.149059] md/raid1:md0: not clean -- starting background reconstruction
[51516.149061] md/raid1:md0: active with 2 out of 2 mirrors
[51516.149077] md0: detected capacity change from 0 to 2144337920
[51516.152324] md: resync of RAID array md0
[51527.005466] md: md0: resync done.
[52055.622329] md: data-check of RAID array md0
[52067.818012] md: md0: data-check done.
[53982.591170] md/raid1:md0: Disk failure on sdb1, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.
</li>
<li>
<p>Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:</p>
<div class="highlight highlight-source-shell position-relative" data-snippet-clipboard-copy-content="root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
"><pre>root@vagrant:<span class="pl-k">~</span><span class="pl-c"><span class="pl-c">#</span> gzip -t /tmp/new/test.gz</span>
root@vagrant:<span class="pl-k">~</span><span class="pl-c"><span class="pl-c">#</span> echo $?</span>
0</pre></div>
<p>
vagrant@vagrant:~$ sudo gzip -t /tmp/new/test.gz | echo $?
0
</li>
<li>
<p>Погасите тестовый хост, <code>vagrant destroy</code>.</p>
<p>
C:\WINDOWS\system32>vagrant destroy ef4982b
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
</li>
</ol>
