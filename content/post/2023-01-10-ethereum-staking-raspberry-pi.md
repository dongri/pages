+++
title = "The Merge後のEthereumステーキングの話"
date = 2023-01-10T18:15:43+09:00
tags = ['ethereum', 'staking','raspberry pi','post-merge']
+++

2022年9月15日にマージが無事完了。
ステーキングに関してinfura,alchemyなどのRPCがマージ後は使えなくなった。
つまりノードを自分で建てないといけない。2TBのストレージ用意するのは結構なコスト。

今まではawsで月1万円ちょっとでalexaアプリ開発のクレジット50ドル分があったので、実質5千円ぐらいでステーキングできたのが、2TBストレージのノードまで建てると月7万円まで膨らんだ。クリプトのこの冬にこれはやってられないと思って、自宅でノード建てようと思った。使ってないMacBookでやってみたが1TBストレージが10日間ぐらいでいっぱいになった。外部SSD接続してもよいが、どうせやるならRaspberry Piで遊んでみようと思ってRaspberry Piと4TBのSSDを買って構築。

## ハードウェア
```
Raspberry Pi 4B 8GB
4TB SSD
```

## いろいろな問題
いろんな想定外の問題に遭遇したのでリストしてみた

* 2TB以上のストレージマウント問題  
OSとデータを4TB SSDで動かそうとして、マウントで2TB以上だとマウントがうまく行かない問題。GPTフォーマットにしないといけない。

* Ethereum on Arm イメージ動かない問題  
https://ethereum-on-arm-documentation.readthedocs.io/en/latest/index.html
インストールしたけど、ethereum/etehreumでログインできない。
諦めて自前でRaspberry Pi用のUbuntuを入れる

* 4TBストレージが壊れた  
Gethの同期中突然書き込めなくなった。試しに修復コマンドで頑張ってみたがだめだった。

* Geth最後の100 blockぐらいで同期が終わらない問題  
最後の100 blockが12時間経っても同期が終わらない、ディスクI/Oか、bandwidthの問題

* USB 2が遅い問題  
SSDをUSB 2のところに挿してた。

* WiFiが遅い問題  
MacBookではWiFiで問題なくステーキングできたけど、Raspberry PiのWiFiは遅い、LANケーブルに変更

* 電源問題  
Raspberry Pi買った時に付いて来た電源を使ってたが、しばらく動かすとsshできなくなり、Raspberry Piが無反応状態になる、PC用の電源に変更。

* Prysmがメモリ食う問題  
Go製のPrysmは8GBのメモリでGethと一緒に動かすとメモリが足りなくてすぐ死ぬ、Rust製のLighthouseに変更

* それでもメモリ足りない問題  
Lighthouseはある程度動かしたけど、数時間立つとvalidator client側が落ちる。
3GBのswapfile作成してswapスペースを確保する

普段クラウド（aws, gcp）で動かすとなかなか出会えない問題で辛かった。面白かったところもあるけど

![image](/images/post/2023-01-10/raspberry-pi.png)
