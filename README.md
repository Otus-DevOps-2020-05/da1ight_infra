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
