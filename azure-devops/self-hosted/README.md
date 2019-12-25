# Self-hosted agents

## Self-hosted Windows agents
https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-windows?view=azure-devops


### personal access token (PAT)
Azure DevOps の右上アカウントから、PAT を発行する  
※権限を要確認

### agent をダウンロード
Azure DevOps の Organization Settings から、Agent Pools を選択する。  
Default の Agent タブから、New Agent ボタンを押す。

ダウンロードした zip を展開したファイルを一式、agent フォルダにコピーする
```shell-session
$ cd c:\
$ mkdir agent
```

### agent を構成する
```shell-session
$ cd agent
$ .\config.cmd

Enter server URL >https://xxx.visualstudio.com/
Enter authentication type (press enter for PAT) >
Enter personal access token >xxx
Enter agent pool (press enter for default) >
Enter agent name (press enter for xxx) >
Enter work folder (press enter for _work) >
Enter run agent as service? (Y/N) (press enter for N) >Y
Enter User account to use for the service (press enter for NT AUTHORITY\NETWORK SERVICE) >thara
Enter Password for the account xxx\thara >xxx
```

### .NET Version の確認
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full  
Release DWORD 値：461814(.NET Framework 4.7.2)

### Build Tools for Visual Studio 2019
インストール  
https://visualstudio.microsoft.com/ja/downloads/?rr=https%3A%2F%2Fqiita.com%2F

コンポーネントは、Web development build tools を選択する

### MSBuild.exe
C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin

MSBuild.exe "C:\Users\thara\Desktop\self-hosted-test\self-hosted-test.sln" /t:build /p:configuration=release /p:Platform="Any CPU"

### Azure DevOps Pipelines を作成する
MSBuild のタスクを使う

### agent を削除する
```shell-session
$ cd agent
$ .\config remove

Enter authentication type (press enter for PAT) >
Enter personal access token >xxx
```
