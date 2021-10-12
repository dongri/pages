+++
title = "Arweave マイニング"
date = 2021-10-11T11:49:39+09:00
tags = ['arweave', 'mining', 'blockchain']
+++

## Arweaveとは
> Arweaveは、データを無期限に保存するためのプラットフォームを提供することを目的とした分散型のストレージネットワークです。本ネットワークは「決して忘れることのない共同所有のハードドライブ」と自己表現しており、主にpermawebをホストしています。これは、コミュニティ主導のアプリケーションやプラットフォームを多数備えた永久的な分散型ウェブです。
> Arweaveネットワークは、ネイティブの仮想通貨ARを使って「マイナー」に料金を支払い、ネットワークの情報を無期限に保存しています。
> このプロジェクトは、まず2017年8月に「Archain」として発表され、その後2018年2月に「Arweave」にリブランディングし、2018年6月に正式にローンチしました。

coinmarketcapから抜粋

アーウィーブと読むらしい。FileCoinとの違いは、従量制課金ではなく、初回一回だけで永久にデータが保存される点です。

## Arweave (AR) Token
Arweaveは自分達のWalletを持ってます。Chrome, FirefoxのExtensionをインストールすれば、MetaMaskの似たようなUIでWalletを生成できて、AR送金もできます。  
[https://docs.arweave.org/info/wallets/arweave-web-extension-wallet](https://docs.arweave.org/info/wallets/arweave-web-extension-wallet)

## Arweave Mining
日本の取引所にAR上場してないので、マイニングしてみました。マイニングの手順は簡単で、公式ドキュメントを参考にすれば十数分でできるかと思います。  
[https://docs.arweave.org/info/mining/mining-guide](https://docs.arweave.org/info/mining/mining-guide)

### 1. awsでEC2作成
```
OS: Ubuntu
CPU: 4
RAM: 16GB
Storage: 1000GB
```
[https://viewblock.io/arweave](https://viewblock.io/arweave)
こちらのデータから見ると現在データのサイズは18TBなので、全部syncするのはさすがに無理で1000GBにします。それによってマイニング報酬が違います。

### 2. File ulimit設定
```
$ vim /etc/sysctl.conf

fs.file-max=900000
fs.nr_open=9000001

$ sysctl -p

$ vim /etc/security/limits.conf
ubuntu         soft    nofile  900000

$ umit -n
900000
```

### 3. arweave ダウンロード
[https://github.com/ArweaveTeam/arweave/releases](https://github.com/ArweaveTeam/arweave/releases)  
こちらからUbuntu版をダウンロード
```
$ wget https://github.com/ArweaveTeam/arweave/releases/download/N.2.4.4.0/arweave-2.4.4.0.ubuntu18-x86_64.tar.gz

$ tar -xzf arweave-2.4.4.0.ubuntu18-x86_64.tar.gz

$ mkdir arweave-2.4.4.0
$ mv * arweave-2.4.4.0
```

### 4. start
```
$ cd arweave-2.4.4.0
$ ./bin/start mine mining_addr YOUR-MINING-ADDRESS peer 188.166.200.45 peer 188.166.192.169 peer 163.47.11.64 peer 139.59.51.59 peer 138.197.232.192
```
`YOUR-MINING-ADDRESS` のところにChrome Extensionで生成したWalletのアドレスを入れます。

以下のエラーが発生した場合
```
error while loading shared libraries: libtinfo.so.5: cannot open shared object file: No such file or directory

$ sudo apt update
$ sudo apt upgrade
$ sudo apt install libncurses5
```

#### Daemon化
nohupでEC2ターミナル閉じても、ログアウトして実行されるようにします。
```
$ onhup ./bin/start mine mining_addr YOUR-MINING-ADDRESS peer 188.166.200.45 peer 188.166.192.169 peer 163.47.11.64 peer 139.59.51.59 peer 138.197.232.192 >> ./log/mining.log &
```

### 5. logs
```
$ ./bin/logs -f
 [info] /opt/arweave/apps/arweave/src/ar_meta_db.erl:97 event: ar_meta_db_start
 [info] /opt/arweave/apps/arweave/src/ar_arql_db.erl:173 ar_arql_db: init, data_dir: .
 [info] /opt/arweave/apps/arweave/src/ar_arql_db.erl:387 ar_arql_db: creating_meta_table
 [info] /opt/arweave/apps/arweave/src/ar_arql_db.erl:401 ar_arql_db: creating_schema
 [info] /opt/arweave/apps/arweave/src/ar_header_sync.erl:52 event: ar_header_sync_start
 [info] /opt/arweave/apps/arweave/src/ar_data_sync.erl:213 event: ar_data_sync_start
 [info] /opt/arweave/apps/arweave/src/ar_blacklist_middleware.erl:29 event: ar_blacklist_middleware_start
 [info] /opt/arweave/apps/arweave/src/ar_poller.erl:34 event: ar_poller_start
```

### 6. ブラウザから確認
http://{ec2-ip}:1984/
```
{
  network: "arweave.N.1",
  version: 5,
  release: 49,
  height: 787538,
  current: "QjJ5pdAim7YFlN0Mr2gXSfCVcj0PnMoQEOPL_Iej9S7q9I-5zPEb0N3keh6dZW4e",
  blocks: 162578,
  peers: 215,
  queue_length: 0,
  node_state_latency: 3
}
```
同期完了まで数日かかりそうです。

## サーバー料金、マイニング報酬
t2.xlarge + 1000GB
```
Amazon EC2 見積り
Amazon EC2 Instance Savings Plans のインスタンス (monthly): 83.95 USD
Amazon Elastic Block Storage (EBS) の料金 (monthly): 100.00 USD
合計月額コスト: 183.95 USD
```
[https://www.coingecko.com/en/coins/arweave](https://www.coingecko.com/en/coins/arweave)  
2021年10月11日時点で¥6,849

マイニング報酬は一ヶ月後にご報告します。

