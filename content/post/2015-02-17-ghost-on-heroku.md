+++
date = "2015-02-17T11:28:57+09:00"
draft = false
title = "Ghost On Heroku"
tags = ["heroku", "node"]
+++

Ghostをherokuにデプロイしてみた。

_以下はあくまでの自分の環境で、nodeとpostgresなど一通りの開発環境は整った環境です。_

## Ghostをローカルで動かしてみる

```
$ cd /path/to/ghost/folder/
$ npm install --production

$ npm start
$ open http://localhost:2368
```

## herokuにpg addon追加

```
$ heroku addons:add heroku-postgresql:dev

$ heroku config
DATABASE_URL:                 postgres://{username}:{password}@ec2-***.compute-1.amazonaws.com:5432/{database}
HEROKU_POSTGRESQL_PURPLE_URL: postgres://{username}:{password}@ec2-***.compute-1.amazonaws.com:5432/{database}
```

## package.json 修正

package.jsonのdependenciesにpg追加。バージョンは固定にしたほうがいいかも。。。

```
"dependencies": {
  ....,
  "pg": "4.2.0"
}
```

## config.js 修正

以下の部分をproductionのところに設定する。databaseの部分は上のDATABASE_URLのところ参照

```
database: {
  client: 'postgres',
  connection: {
        host: 'ec2-***.compute-1.amazonaws.com',
        user: '{username}',
        password: '{password}',
        database: '{database}',
        port: '5432'
  }
},

server: {
    host: '0.0.0.0',
    port: process.env.PORT
}
```

## Procfileファイル追加
herokuにnodejsアプリをデプロイした人にはわかると思うがProfileを作成

```
$ vim Procfile
web: node index.js --production
```

## git remote, push

```
$ git init
$ git remote add origin git@heroku.com:{app}.git
$ git add .
$ git commit -m "Ghost"
$ git push origin master
```

## Debug

heroku上でApplication Error!

log見てみる

```
$ heroku logs --tail

Ghost is running in development...

```

developmentで実行されたようだ。

NODE_ENVをproductionに設定

```
$ heroku config:set NODE_ENV=production
```

上のコマンドでenv設定とrebootするので、tailで完了確認できたら、もう一度アクセスしてみる。

うまく表示されたようだ

## Ghost設定

```
$ open http://{app}.herokuapp.com/ghost/setup/
```

## 所感

設定して自分が欲しかったmarkdownで書けるようになったけど、意識高い系に似合うデザインのせいか
メモ、コードを書くにはいまいち。。。
