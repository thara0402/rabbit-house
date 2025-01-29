# How to use Git Flow

## GitLab Flow
### Commit Stage
#### 機能を開発する
```shell-session
$ git clone <repository url>
$ cd <repository>
$ git checkout -b feature main
```
#### ローカル開発が完了
```shell-session
$ git add .
$ git commit -m "add-feature."
$ git push -u origin feature
```
feature ブランチから、main ブランチに Pull Request を作成する

#### ローカルの feature ブランチを削除する
Pull Request がマージされた後、GitHub の Web UI から feature ブランチを削除する  
続いて、ローカルの feature ブランチを削除する
```shell-session
$ git branch -a

$ git checkout main
$ git branch -d feature
$ git fetch -p
```

#### 次の機能を開発する
```shell-session
$ git checkout main
$ git pull origin main
$ git checkout -b feature-2 main
$ git add .
$ git commit -m "add-feature-2."
$ git push -u origin feature-2
```
feature-2 ブランチから、main ブランチに Pull Request を作成する

### Acceptance Stage
#### 受入テスト環境にデプロイする準備
main ブランチから、pre-production ブランチに Pull Request を作成する

#### 受入テストで発生した不具合を修正する
```shell-session
$ git checkout main
$ git fetch origin
$ git checkout -b hotfix origin/pre-production
$ git add .
$ git commit -m "hotfix."
$ git push -u origin hotfix
```
hotfix ブランチから、pre-production ブランチに Pull Request を作成する

#### 不具合修正を Commit Stage に反映する
pre-production ブランチから、main ブランチに Pull Request を作成する

### Production
#### 本番環境にリリースする
pre-production ブランチから、production ブランチに Pull Request を作成する

## Remote Repository for a fork
GitHub の Web UI からアップストリーム リポジトリとフォークのブランチを同期する  
続いて、ローカルのブランチを同期する
```shell-session
$ git remote -v
$ git remote add upstream <upstream repository url>

$ git fetch upstream
$ git merge upstream/main
```
