# da1ight_infra

Homework #3

```
bastion_IP = 130.193.51.168
someinternalhost_IP = 10.130.0.33
```

Jumpbox cheatsheet:
Just a quick tip that helps ssh to internal infrastructure using bastion host in one step

edit ~/.ssh/config

```
Host bastion
    HostName {$BastionIP}
    User appuser

Host someinternalhost
    HostName {$InternalIP}
    User appuser
    ProxyCommand ssh -q -W %h:%p bastion
```

Then just run `ssh someinternalhost` and you good to go

Homework #4

```
testapp_IP = 84.201.131.164
testapp_port = 3030
```

Create VM with metadata file
```
yc compute instance create   --name reddit-app-meta   --hostname reddit-app-meta   --memory=4   --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB   --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4   --metadata serial-port-enable=1 --metadata-from-file user-data=./meta.yaml
```

Homework #5
* Созданы файлы шаблонов fry/bake (ubuntu16.json/immutable.json) для packer.
* Добавлена возможность параметризации по средствам отдельного файла variables.json.
* Шаблоны проверены packer validate.
* Изучены возможности builders и provisioners.
* Создамы VM на основе шаблонов, как из web консоли так и по средствам cli.
* Добавлен скрипт для автоматического создания VM из образа по средствам yc cli create-reddit-vm.sh.

При запуске скрипта необходимо указать тип имиджа и путь до вашего публичного ssh ключа:

```
./create-reddit-vm.sh full /path/to/your/key/1.pub
```

Homework #6

Касательно конфигурации с reddit-app2, основная проблема в отсутсвии автоматического масштабирования. Если два наших инстанса перестанут переваривать нагрузку, все просто упадет. Либо другая ситуация, когда нагрузка слишком маленькая, а мы все равно держим инстансы запущеными.

Добавил переменную instance_count для определения count. В lb.tf реализовал атоматическое добавление таргетов через dynamic block construct + добавил count.index к имени VM в main.tf. Как и в прошлом варианте не хватает автоматического масштабирования, но нам уже проще добавлять/удалять инстансы определяя переменную `instance_count`. У Яндекса есть "Группы виртуальных машин", по сути все что мы тут изобретаем уже готово. Думаю познакомимся с этим на следующем занатии).

Homework #7

Изучены основные компоненты Terraform. Выполнены самостоятельные задания:
* Удалите из папки terraform файлы main.tf, outputs.tf, terraform.tfvars, variables.tf, так как они теперь перенесены в stage и prod
* Параметризируйте конфигурацию модулей насколько считаете нужным
* Отформатируйте конфигурационные файлы, используя команду
   terraform fmt

Стейт terraform-a перенесен в Object Storage на Yandex-e. Схема протестирована и успешно работает при запуске проекта из разных локаций.
Для того, чтобы доступ к бакету заработал, необходимо экспортировать переменные с access и secret key.
```
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
```

Homework #8

* Установлен Ansible
* Познакомился с базовыми функциями и инвентори
* Выполнениk различныt модули на подготовленной в прошлых ДЗ инфраструктуре (command, shell, git)
* Написал playbook clone.yml

Задания со '*'

* Создан _dynamic_inventory.sh. Скрипт налету генерирует inventory (Мне решение показалось не слишком надежным, есть нюансы. Поэтому решил использовать более простое со статическим inventory.json))
* Вручную создан inventory.json (https://serverfault.com/questions/927125/dynamic-inventory-in-yaml-format)
* Скрипт dynamic_inventory.sh просто выдает в stdout содержимое файла inventory.json

```
$ ansible-inventory --inventory ./dynamic_inventory.sh --graph
@all:
  |--@app:
  |  |--84.201.128.150
  |--@db:
  |  |--130.193.39.101
  |--@ungrouped:

```
