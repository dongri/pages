+++
date = "2016-08-16T00:42:53+09:00"
title = "Rust on Heroku with Docker"
tags = ['rust', 'programming', 'heroku', 'docker']
+++

Rustで書いたhello rustをherokuに載せてみた。
普通ならrust用のBuildpack使うのだが、今回はdockerを使うようにした。
Dockerfile、ソースコードなどはこちら

[https://github.com/dongri/hello-rust](https://github.com/dongri/hello-rust)

はじめはalpineで頑張ってみようかと思ったがrustのインストールがうまく行かなくて、ubuntuに変更。
Dockerfileは以下のようになっている。

```
FROM ubuntu:latest

# rust, cargo buildに必要なソフトウェアインストール
RUN apt-get -y update
RUN apt-get -y install curl file sudo gcc

# rustのインストール
RUN curl -sSf https://static.rust-lang.org/rustup.sh | sh

RUN mkdir -p /app
WORKDIR /app
COPY . /app

# ビルドして ./target/release/helloバイナリを作る
RUN cargo build --release

EXPOSE 8080

# 実行
CMD /app/target/release/hello
```

readmeにも書いてあるがherokuはdockerをサポートしていて、pushするだけでローカルのdockerと
同じように動かせる。必要なのは、heroku-container-toolsというheroku plugin。

```
$ heroku plugins:install heroku-container-tools
$ heroku container:push web
```

これでだけでherokuにアップされて動く。

[https://hello-rust.herokuapp.com/](https://hello-rust.herokuapp.com/)
