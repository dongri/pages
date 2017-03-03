+++
date = "2014-06-17T11:28:57+09:00"
draft = false
title = "Docker Install"
tags = ["docker"]
+++

[https://docs.docker.com/installation/mac/](https://docs.docker.com/installation/mac/ "docker install")

youtube動画通りにダウンロードしてインストールする。

applicationsに入ったappアイコンをクリックするとboot2dockerがinit, start, DOCKER_HOSTまで設定してくれるので、作業はそのまま進められる。

もしくはboot2dockerコマンドで一から作りなおしてもいい。

```
➜  ~  boot2docker init
➜  ~  boot2docker start
➜  ~  export DOCKER_HOST=tcp://:2375
```

exportの部分は.zshrcとかに入れとけば毎回設定する必要なくなる。
DOCKER_HOST正しく設定されないと以下のエラーが出る。

```
2014/06/17 22:07:38 Cannot connect to the Docker daemon. Is 'docker -d' running on this host?
```

dockerコマンドを確認してみる

```
➜  ~  docker version
Client version: 1.0.0
Client API version: 1.12
Go version (client): go1.2.1
Git commit (client): 63fe64c
Server version: 1.0.0
Server API version: 1.12
Go version (server): go1.2.1
Git commit (server): 63fe64c
➜  ~  docker images
REPOSITORY           TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
centos               centos6             0c752394b855        7 days ago          124.1 MB
centos               latest              0c752394b855        7 days ago          124.1 MB
➜  ~  
```
