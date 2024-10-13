+++
title = "フルオンチェーンNFTプロジェクト Permavatar"
date = 2021-11-10T10:16:22+09:00
tags = ['NFT', 'on-chain']
+++

数週間前にフルオンチェーンNFTを作ってみたくて、Permavatarというプロジェクトを始めました。
自分一人でやるのも面白くなかったので、Twitterで募集しました。

![image](/images/post/2021-11-10/permavatar.png)

[https://twitter.com/dongrium/status/1449698160817803278](https://twitter.com/dongrium/status/1449698160817803278)

ありがたいことにいろんな方から連絡が来てちょっとびっくりしました。

この辺の経緯は [shingofushimi.eth](https://twitter.com/smcpglf) の記事を見れば雰囲気が分かるかと思います。

[shingofushimi.eth](https://twitter.com/smcpglf) の medium : [残り続けるモノを創ってみたかったから、NFT Projectを立ち上げてみました。](https://smcpglf.medium.com/%E6%AE%8B%E3%82%8A%E7%B6%9A%E3%81%91%E3%82%8B%E3%83%A2%E3%83%8E%E3%82%92%E5%89%B5%E3%81%A3%E3%81%A6%E3%81%BF%E3%81%9F%E3%81%8B%E3%81%A3%E3%81%9F%E3%81%8B%E3%82%89-nft-project%E3%82%92%E7%AB%8B%E3%81%A1%E4%B8%8A%E3%81%92%E3%81%A6%E3%81%BF%E3%81%BE%E3%81%97%E3%81%9F-a7a42859440f)

ここではスマートコントラクトなど技術面の話を少ししようかと思います。

## フルオンチェーンの難しいところ
フルオンチェーンはすべてのデータをEthereum上に保存するので、データの量でいろんな制約に引っかかりました。

### 1. 一つのfunctionで変数定義オーバー問題
```
CompilerError: Stack too deep, try removing local variables.
```
一つのsolidity functionで変数の定義が一定数超えるとエラーが発生します。
対応策としては、functionを分割して処理を分けるか、ブロックを定義して、それぞれのブロックで変数を定義することで回避できます。

### 2. スマートコントラクトコードサイズ問題
```
"Permavatar" ran out of gas. Something in the constructor (ex: infinite loop) caused gas estimation to fail. Try:
```
solidityのビルドはうまくいきますが、デプロイすると上のようなエラーが発生しました。
Gasが足りないようなエラーメッセージですが、実はこのエラーはスマートコントラクトコードサイズが大きすぎたのが問題でした。
調べて知ったのですが、EIP-170という制約があるらしいです。
https://github.com/ethereum/EIPs/blob/master/EIPS/eip-170.md

## Gas fee 節約対策
普通にコントラクト書くとERC721の `setTokenURI` にsvgのデータを渡してセットすると思いますが、それだとデータサイズが大きくなるので、Permavatarでは `setTokenURI` を使用せず、tokenIDを呼び出す時に使われる `tokenURI` でsvgを生成して返すようにしてます。これによってmint時のGas feeを最小限に抑えることができました。

## 拘ったこと
フルオンチェーン + Decentralized 

これを守りたくて、NFTのmint画面も特定のサーバーで構築するのではなく、IPFSに配置するようにしました。
https://app.uniswap.org/#/swap と同じ方式です。

バッドエンドになる部分のスマートコントラクトはEthreumネットワーク上で動いて、フロントエンドになる部分はIPFSにデプロイされてるので、理論上は永久に動くサービスになります。

## 最後に
ここまで読んだら、何十年、何百年残り続ける Permavatar をmintしたくなりましたか？ｗ

[https://permavatar.com](https://permavatar.com)
