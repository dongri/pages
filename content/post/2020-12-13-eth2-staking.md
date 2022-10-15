+++
title = "ETH2 Staking"
date = 2020-12-13T09:46:43+09:00
tags = ['ethereum', 'eth2', 'staking', 'prysm']
+++

ETH2のステーキング方法について、まともな日本語記事がなかったり、あっても会員登録必要だったり、逆にわかりにくかったりしたので、自分がやった手順を書こうと思います。

## Staking
ステーキングとはPoS（Proof of Stake）において、仮想通貨を自由に動かせない状態（ロック状態）にしてブロックに追加するデータの承認などの面でネットワークの維持に関わる見返りとして、その報酬を仮想通貨で受け取る仕組みです。
ETH2のステーキングだと年利4.9% ~ 21.6%ですが、stakeするETHが多ければ多いほど下がります。12月12日時点で13%程度です。
デポジットに関しても始まった時の進捗では524,288 ETHまで間に合うか心配してたが、後半になって一気に増えて予定した12月1日のローンチに間に合いました。

## Deposit
https://launchpad.ethereum.org/ で32ETHをデポジットします。（注意: デポジットされた32ETHは今のところ2年間ロックされるので注意が必要）
デポジット方法は、 https://launchpad.ethereum.org/overview ここの手順のまま進めばできるかと思います。
特に難しいことはありませんでしたが、ETH1とETH2のクライアント選ぶ時もしかすると注意が必要です。後ほどBeacon node起動する時のクライアントと関係してるので。
自分の場合はどっちもGo言語実装のGethとPrysmを選択しました。
デポジットが完了すると、validator_keysファイルを取得できるので、安全な場所に保管します。

## Prysm 環境
https://docs.prylabs.network/docs/install/install-with-script#system-requirements
```
Recommended specifications
* Processor: Intel Core i7–4770 or AMD FX-8310 or better
* Memory: 16GB RAM
* Storage: 100GB available space SSD
* Internet: Broadband connection
```
ラズパイとかでやってみようかと思ってたけど、このスペックは難しいのでペナルティ受ける可能性のあるawsにしました。
aws, gcp, azureなど大手クラウドサービスだと障害が起きた時大規模のノードが止まる可能性があるので、ペナルティがあるようです。

EC2インスタンス
```
Memory: 16GB
Storage: 100GB
```

## Beacon node
続いてbeacon chainのnodeを起動する必要あります。
https://docs.prylabs.network/docs/install/install-with-script/ こちらからprysm.shをダウンロードします。
続いて https://docs.prylabs.network/docs/mainnet/joining-eth2 こちらに書いてあるStepでbeacon nodeの起動、validator accountのインポート、validatorの起動順にやっていきます。

### prysm.shダウンロード
```
$ mkdir prysm && cd prysm
$ curl https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh --output prysm.sh && chmod +x prysm.sh
```

### Beacon node
```
$ ./prysm.sh beacon-chain --http-web3provider=https://mainnet.infura.io/v3/****
```
自前のETH1ノード使いたくなかったので、infuraを使うようにしました。もちろん自前のETHノードでも問題ないです。

### Import validator account
```
$ ./prysm.sh validator accounts import --keys-dir=$HOME/prysm/validator_keys
```
validator_keysディレクトリはデポジットした後取得したvalidator_keysになります。

### Run validator
```
$ ./prysm.sh validator
```

### 検証
https://beaconscan.com か https://beaconcha.in でpublic keyを入力して進捗を見ることができます。
public keyは `deposit_data_***.json` 中に書いてあるのでそれを使用します。

### Daemon化
nohupでEC2ターミナル閉じても、ログアウトして実行されるようにします。
```
$ nohup ./prysm.sh beacon-chain --http-web3provider=https://mainnet.infura.io/v3/****** >> ./log/beacon-chain.log &

$ nohup ./prysm.sh validator --wallet-password-file $HOME/.eth2validators/prysm-wallet-v2/password.txt >> ./log/validator.log &
```
(password.txt にはアカウントインポートした時のパスワードをplain textで記載します)

以上で、ETH2ステーキングに参加できました。

### The Merge
マージ後はinfura, alchemyなどのプロバイダーが使えなくなった
https://docs.prylabs.network/docs/prepare-for-merge#the-merge-before-and-now

自前でnodeクライアントを建てる、SSDは2TBに変更
```
$ go install github.com/ethereum/go-ethereum/cmd/geth

$ geth version
Geth
Version: 1.11.0-unstable
Architecture: amd64
Go Version: go1.18.3
Operating System: linux
GOPATH=
GOROOT=/usr/lib/golang
$ 
```

Geth
```
$ cd prysm

$ ./prysm.sh beacon-chain generate-auth-secret

$ vim run-geth.sh
#!/bin/sh
nohup geth --http --http.api eth,net,engine,admin --authrpc.jwtsecret $HOME/prysm/jwt.hex 2>> ./log/geth.log &

$ ./run-geth.sh
```

prysm
```
$ cd prysm

$ vim run-prysm.sh
#!/bin/sh
nohup ./prysm.sh beacon-chain --execution-endpoint=http://localhost:8551 --jwt-secret=$HOME/prysm/jwt.hex --suggested-fee-recipient=0x9D7Fa65552609eDF74417485D80613da5eC09Fe5 2>> ./log/beacon-chain.log &

nohup ./prysm.sh validator --wallet-password-file=$HOME/prysm/password.txt 2>> ./log/validator.log &

$ ./run-prysm.sh
```
