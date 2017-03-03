+++
date = "2014-06-17T11:28:57+09:00"
draft = false
title = "Docker node"
tags = ["docker"]
+++

続いてnodejsをやってみる。

### Dockerfileを作成する。

```
$ vim Dockerfile
FROM centos:6.4                                                                                                                                                                                                                               
MAINTAINER Dongri Jin

RUN yum update -y
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN yum install -y npm

ADD nodejs /var/app/nodejs

RUN npm install -g nodemon
RUN cd /var/app/nodejs; npm install

EXPOSE 3000
CMD ["node", "/var/app/nodejs/index.js"]
```

### node環境構築する。
nodejsディレクトリの下に、package.jsonとindex.jsを作成

```
$ vim nodejs/package.json
{
  "name": "docker-node",
  "private": true,
  "version": "0.0.1",
  "description": "Node.js on Docker",
  "author": "Dongri Jin <dongriab@gmail.com>",
  "dependencies": {
    "express": "4.4.3"
  }
}

$ vim nodejs/index.js
var express = require('express');

var PORT = 3000;

var app = express();
app.get('/', function (req, res) {
  res.send('Hello Node.js\n');
});

app.listen(PORT);
console.log('Express server listening on port ' + PORT);
```

### ビルド & サーバー起動

```
$ docker build -t dongri/node .
$ docker run -p 3000:3000 -i -t dongri/node
Express server listening on port 3000
```

ブラウザから http://192.168.59.103:3000 アクセスしてみる。

Hello Node.js

以上で、nodejs
