# da1ight_infra

* bastion_IP = 130.193.51.168
* someinternalhost_IP = 10.130.0.33


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
