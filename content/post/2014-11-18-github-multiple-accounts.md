+++
date = "2014-11-18T11:28:57+09:00"
draft = false
title = "github multiple accounts"
tags = ["github"]
+++

ある事情により、githubに公開アカウントと秘密アカウントが必要になって、複数のアカウントを扱うようになりました。

### まず、新しいSSHキーの生成

```
$ ssh-keygen -t rsa -C "yoda@gmail.com" -f id_rsa_secret
```

### ~/.ssh/config 設定

```
$ vim ~/.ssh/config

############ Github ###############
Host github-secret
  User git
  Port 22
  HostName github.com
  IdentityFile ~/.ssh/id_rsa_secret
  TCPKeepAlive yes
  IdentitiesOnly yes
```

### git clone

SSH clone URL: git@github.com:user/project.git の場合

```
$ git clone git@github-secret:user/project.git
```

### git config

確認してみる。

```
$ git config --global user.name
$ git config --global user.email
```

SSHキー違ってもこのままだと複数プロジェクトのauthor, committerがglobal設定になるので、変更する。

git clone したあとのプロジェクトに入って

```
$ git config --local user.name "Yoda"
$ git config --local user.email "yoda@gmail.com"
```

以上です、複数のgithubを扱えるようになりました。

> user.name設定忘れるとご迷惑掛けする場合がございますので、忘れずに。。。
