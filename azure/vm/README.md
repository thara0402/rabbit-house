# Virtual Machines

## sysprep with PowerShell
```shell-session
$ & "$Env:SystemRoot\system32\sysprep\sysprep.exe" /generalize /oobe /shutdown
```

## Capture Image
プロビジョニングを解除した VM の割り当てを解除する
```shell-session
$ az vm list
$ az vm deallocate -g <myResourceGroup> -n <myVM>
```

VM の状態を一般化に設定する
```shell-session
$ az vm generalize -g <myResourceGroup> -n <myVM>
```

VM リソースのイメージを作成後、リソースグループを移動する
```shell-session
$ az image create -g <myResourceGroup> -n <myImage> --source <myVM>
$ az group create -n vm-image -l japaneast
```
