# How to use Git Flow

## GitLab Flow
### Commit Stage
#### 機能を開発する
```shell-session
$ git clone <repository url>
$ cd <repository>
$ git checkout -b feature master
```
#### ローカル開発が完了
```shell-session
$ git add .
$ git commit -m "add-feature."
$ git push -u origin feature
```
feature ブランチから、master ブランチに Pull Request を作成する

#### 次の機能を開発する
```shell-session
$ git checkout master
$ git pull origin master
$ git checkout -b feature-2 master
$ git add .
$ git commit -m "add-feature-2."
$ git push -u origin feature-2
```
feature-2 ブランチから、master ブランチに Pull Request を作成する

### Acceptance Stage
#### 受入テスト環境にデプロイする準備
master ブランチから、pre-production ブランチに Pull Request を作成する

#### 受入テストで発生した不具合を修正する
```shell-session
$ git checkout master
$ git fetch origin
$ git checkout -b hotfix origin/pre-production
$ git add .
$ git commit -m "hotfix."
$ git push -u origin hotfix
```
hotfix ブランチから、pre-production ブランチに Pull Request を作成する

#### 不具合修正を Commit Stage に反映する
pre-production ブランチから、master ブランチに Pull Request を作成する

### Production
#### 本番環境にリリースする
pre-production ブランチから、production ブランチに Pull Request を作成する

## GitHub Flow



