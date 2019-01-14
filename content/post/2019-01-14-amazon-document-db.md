+++
title = "Amazon DocumentDBを試してみた"
date = 2019-01-14T21:42:00+09:00
tags = ['amazon', 'aws', 'documentdb', 'mongri']
+++

AmazonからMongoDBと互換性を持つDocumentDBをリリースしたと言ってるので試してみた。
クラスタを作成するためにVPCが必要だったのでVPCを一つ作成。VPCの他にアベイラビリティゾーン２つ必要なので、違うアベイラビリティゾーンを持つサブネット２つ作成。これでクラスタ作成できる。

インスタンスタイプは最低でもdb.r4.largeで15.25GBのメモリ。値段は$0.277

エンドポイントはPublicにできないので、sshトンネル作って接続するようにする。

### SSHトンネル
```
$ ssh -L 27017:docdb-2019-01-14-13-34-21.cluster-crgjmmxnvvix.us-east-1.docdb.amazonaws.com:27017 -i ~/.ssh/{pem file} -p 22 ec2-user@{bastion ip}
```
bastionをssh configに設定済みであれば以下のようにしてもOK
```
$ ssh -L 27017:docdb-2019-01-14-13-34-21.cluster-crgjmmxnvvix.us-east-1.docdb.amazonaws.com:27017 {bastion}
```

### mongo cliで接続してみる
```
$ wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem

$ mongo --ssl --host localhost:27017 --sslCAFile ./rds-combined-ca-bundle.pem --username {user} --password {password} --sslAllowInvalidHostnames

MongoDB shell version v4.0.1
connecting to: mongodb://localhost:12345/
MongoDB server version: 3.6.0
rs0:PRIMARY> show dbs
docdb-2019-01-14-13-34-21  0.000GB
rs0:PRIMARY> use docdb-2019-01-14-13-34-21
switched to db docdb-2019-01-14-13-34-21
rs0:PRIMARY> show collections
users
```

### mongriで接続してみる
https://github.com/dongri/mongri

```
$ vim config/mongo.json

  "docdb": {
    "uri": "mongodb://{user}:{password}@localhost:27017/{docdb-2019-01-14-13-34-21}",
    "opts": {
      "poolSize": 20,
      "useNewUrlParser": true,
      "ssl": true
    }
  },

$ NODE_ENV=docdb node app.js
```

# 感想
本当にmongodbと互換性があったｗ
