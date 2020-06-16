# da1ight_infra
da1ight Infra repository


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
