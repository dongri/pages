+++
date = "2014-12-11T11:28:57+09:00"
draft = false
title = "Revel on Heroku"
tags = ["heroku", "golang"]
+++

RevelをHerokuにデプロイしてみる。

### 事前確認

```
$ echo $GOPATH
/Users/dongri/go

```

### Revelプロジェクト作成

```
$ revel new team
```

↑で $GOPATH/src/にteamフォルダが出来上がる

### ローカルで実行してみる

```
$ revel run team

$ open http://localhost:9000
```

### herokuにbuildpackでデプロイ

```
$ heroku create -b https://github.com/robfig/heroku-buildpack-go-revel.git
```

### heroku画面でアプリの名前を変更する。

```
$ git remote -v
$ git retemo rm origin
$ git remote add origin git@heroku.com:[app].git
```

### .godirファイル作成

```
$ pwd
/Users/dongri/go/src/team
$ echo "team" > .godir
```

### デプロイ

```
$ git add .
$ git commit -m "hoge"
$ git push origin master

```

以上で完了
