+++
date = "2014-06-17T11:28:57+09:00"
draft = false
title = "Docker Nginx"
tags = ["docker"]
+++

インストール終わったので、nginxを構築してみる。

### Dockerfileを作成する。

```
$ vim Dockerfile
FROM centos
MAINTAINER Dongri Jin

RUN yum update -y && \
    rpm --import http://nginx.org/keys/nginx_signing.key && \
    yum install -y http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm && \
    yum install -y nginx

ADD conf.d/default.conf /etc/nginx/conf.d/default.conf

ADD html /var/app/nginx/html

EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
```

Dockerfileは以下の流れになる。

* centos imageをダウンロード
* yumでnginxをインストール
* host(osx)のconfファイルをnginx containerのconfに置き換え
* host(osx)のhtmlフィルダをnginx containerのhtmlソースフォルダにコピー
* 80番portを開放
* 作成されたコンテナ起動(nginx)

### ビルド

```
$ docker build -t dongri/nginx .
```

container名を[username]/[imagename]にしたのはdocker hubに公開するため。

### 起動

```
$ docker run -p 80:80 -d dongri/nginx
6358e578f3072e4e32d057647b5dbe63b34d0dfc07e46a497241498f27cf3e88
$ curl 192.168.59.103
hello World!<br/>
path: /var/app/nginx/html/index.html
$
```

* -p は host port : container port
* -d バックグラウンドで起動

ここでdockerのipを指定したが、localhostも可能。ただし、port forwardingが必要。

```
$ VBoxManage controlvm "boot2docker-vm" natpf1 "nginx,tcp,127.0.0.1,8080,,80"
```

上の用にすることで、http://localhost:8080でアクセス可能。

ポートフォワーディングは OSX 8080 ---> VirtualBox 80 ---> nginx 80

### docker hubにアップする

```
$ docker ps
6358e578f307        dongri/nginx:latest         /usr/sbin/nginx -g '   2 hours ago         Up 6 minutes        0.0.0.0:80->80/tcp                                                                       distracted_wilson   
$ docker commit 6358e578f307 dongri/nginx
$ docker push dongri/nginx
```

事前に [https://hub.docker.com/](https://hub.docker.com/) にユーザー登録必要あり。

### ポイント
* imageになるのはcommit時の状態のcontainerである。nginxが起動されてない状態のcontainerをcommitしてもhubからpullして来ても外部コマンド使わないで起動できない。
* bashでnginxの中身を見たい場合は、ENTRYPOINTをオーバーライドして見る

```
$ docker run -i -t --entrypoint='/bin/bash' dongri/nginx
bash-4.1#
```

上のDockerfileとconf, htmlはgithubから参照可能。

[https://github.com/dongri/Dockerfiles/tree/master/nginx](https://github.com/dongri/Dockerfiles/tree/master/nginx)

以上で、nginx
