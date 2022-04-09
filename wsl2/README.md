# How to use WSL2

## Prerequisites
Windows の機能で有効化
- Linux 用 Windows サブシステム
- 仮想マシン プラットフォーム

## Install
```shell-session
$ wsl --install
```
ヘルプテキストが表示される場合
```shell-session
# インストール可能なディストリビューション
$ wsl --list --online
NAME            FRIENDLY NAME
Ubuntu          Ubuntu
Debian          Debian GNU/Linux
kali-linux      Kali Linux Rolling
openSUSE-42     openSUSE Leap 42
SLES-12         SUSE Linux Enterprise Server v12
Ubuntu-16.04    Ubuntu 16.04 LTS
Ubuntu-18.04    Ubuntu 18.04 LTS
Ubuntu-20.04    Ubuntu 20.04 LTS

# ディストリビューションを指定してインストール
$  wsl --install -d ubuntu
```

その他コマンド
```shell-session
# Linux カーネルのステータス
$ wsl --status

# インストール済みディストリビューション
$ wsl --list --verbose
```

## Run

```shell-session
$ Enter nwe UNIX username:
$ Enter nwe Passwoed:

# Linux から Windows 上のマウント先確認
$ ls /mnt/c/

# Windows から Linux 上のファイル確認
$ \\wsl$
```

## Update
```shell-session
# バージョン確認
$ cat /etc/os-release

# アップデート
$ sudo apt update && sudo apt upgrade
```

## Visual Studio Code
### Install
VS Code の拡張機能をインストール
- Remote Development

```shell-session
$ code .
Installing VS Code Server for x64 (e18005f0f1b33c29e81d732535d8c0e47cafb0b5)
Downloading: 100%
Unpacking: 100%
Unpacked 2341 files and folders to /home/thara/.vscode-server/bin/e18005f0f1b33c29e81d732535d8c0e47cafb0b5.
```

## Docker Desktop
### Prerequisites
Linux カーネル更新プログラム パッケージをインストール

https://docs.microsoft.com/ja-jp/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package

### Install
https://docs.docker.com/desktop/windows/wsl/

```shell-session
$ docker run -d -p 80:80 docker/getting-started
```

