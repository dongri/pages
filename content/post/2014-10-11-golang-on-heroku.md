+++
date = "2014-10-11T11:28:57+09:00"
draft = false
title = "Golang on heroku"
tags = ["golang", "heroku"]
+++

今までGolangプロジェクトはGoogle App Engineにデプロイしたが、管理画面がいまだに
使い慣れてないのとAppEngine特有の癖があるので、やめてherokuにデプロイしてみた。
herokuも公式にはGolang対応してなくて、buildpackを使わないとダメ。

herokuサポート言語

[https://devcenter.heroku.com/categories/language-support](https://devcenter.heroku.com/categories/language-support)

buildpackはこちら

[https://github.com/kr/heroku-buildpack-go](https://github.com/kr/heroku-buildpack-go)

### まずローカルでGoプロジェクトを作成して確認みる。

```
$ cd $GOPATH/src

$ mkdir osakago
$ cd osakago
$ vim server.go
```

```
package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", hello)
	fmt.Printf("Server listening on port %v ...\n", os.Getenv("PORT"))
	err := http.ListenAndServe(":"+os.Getenv("PORT"), nil)
	if err != nil {
		panic(err)
	}
}

func hello(res http.ResponseWriter, req *http.Request) {
	fmt.Fprintln(res, "hello, world")
}
```

```
$ PORT=8080 go run server.go
Server listening on port 8080 ...

$ curl -i localhost:8080
HTTP/1.1 200 OK
Date: Sat, 11 Oct 2014 05:04:01 GMT
Content-Length: 13
Content-Type: text/plain; charset=utf-8

hello, world
$
```

### バイナリ作成、サーバー起動して確認

```
$ go get
$ which osakago
/Users/you/go/bin/osakago
$ PORT=8080 osakago
$ curl -i localhost:8080
```

### Heroku側設定

メールアドレスとか変わった場合とか認証がうまくいかない場合があるので、念の為loginしておく。

```
$ heroku login
Enter your Heroku credentials.
Email: you@hoge.com
Password:
```

### Procfileファイル作成

```
$ echo 'web: osakago' > Procfile
```

### Godepインストール

```
$ go get github.com/kr/godep
$ godep save
```

Godepsフォルダ生成される。

### Herokuにデプロイ

```
$ heroku create osakago -b https://github.com/kr/heroku-buildpack-go.git
Creating osakago... done, stack is cedar
BUILDPACK_URL=https://github.com/kr/heroku-buildpack-go.git
http://osakago.herokuapp.com/ | git@heroku.com:osakago.git

$ git add .
$ git commit -m "Hi"
$ git push heroku master
```

( これからはherokuだな、さようなら～ AppEngine )
