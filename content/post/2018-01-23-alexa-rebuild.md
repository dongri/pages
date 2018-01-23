+++
title = "RebuildのAlexa Skillを作ってリジェクトされた話"
date = 2018-01-23T23:13:19+09:00
tags = ['alexa', 'amazon']
+++

Echo Dotが届いたのでAlexa Skillを作ってみることにしました。オフィスに届いた当日はSlackで使ってたhubot deployをAlexaからデプロイできるようにと遊んでみたがちゃんとしたものを作ろうと思って週末に http://rebuild.fm をAmazon Echoで聞けるようにしてみました。

<iframe width="560" height="315" src="https://www.youtube.com/embed/BttwX3ngw_E" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

以下実装上で困った話をしようと思います

## xml2jsonをrequireすると反応しない

http://feeds.rebuild.fm/rebuildfm RSSなのでxmlをパースする必要があり、nodejsでxmlパーサを探してみた結果これでした。
しかしrequireした時点でAlexa（Lambda）が反応しなくなりました。深く検証してませんが、おそらくnodejs 6.10にサポートしてないのが原因かと思われます。

## xml2jsファイルパースで無反応

xml2jsonがサポートしてないので、xml2jsで試してみました、こいつは正しく動いてるように見えますが、でかいファイルのパースにはダメでした。http://feeds.rebuild.fm/rebuildfm 実はこいつのxmlが意外とでかくて数千行もありましたね。。。

## 自前のサーバーでやろう

http://feeds.rebuild.fm/rebuildfm このfeedを定期的に取ってきて必要な情報だけjsonに変換してS3に突っ込んでそこから情報を取るようにしました。

## mp3が再生できない問題

Rebuildのfeedに書いてあるデフォルトのmp3ファイルだとURLがhttpのため `this.response.audioPlayerPlay` では再生できませんでした。
これもなんとかしようとして自前のS3にアップロードしてhttps対応しました。

## 自動化

一時間おきにrebuildのfeedから最新のxmlからjsonに変換して、追加されたmp3ファイルをS3にアップロードするようにしました。

## リジェクト

気軽く申請してみようと思い申請したものの、案の定リレクトされました。理由は

```
使用されている第三者の知的財産: 「Rebuild.fm」
第三者の知的財産が使用されていたメタデータ: スキル名、スキルアイコン、呼び出し名、スキル詳細ページ 

Amazonにとってカスタマーへの透明性は非常に重要なものです。これらの問題への対策としては、以下の2つが考えられます。 

A. ブランド所有者が「Rebuild.fm」の知的財産の使用を許可することを明記した署名入りの書面、またはライセンス契約等を提出する。 • 商標、知的財産、ブランドを正当に利用するスキルがある場合、そのスキルの認証を申請する際に、これらの使用許諾を所有することを示し、明示的に証明する。開発者ポータルの「Publishing Information」ページでテスト手順フォームを使用して、必要に応じて外部リンクと連絡先情報を含めてこの情報を入力し、スキルに必要な使用許諾があることを認定チームが判断できるようにする。
```

まあ、そうでしょうね。

## やってみてわかったこと

* Podcast系は所有者の承認を得ること
* ステップごとにヘルプ、ストップ、終了して、を認識させること
* Audio Playerの場合、一時停止、再開を認識させること
* 意外とちゃんとテストしてること


## 参考にコードをgithubに上げときます

https://github.com/dongri/alexa-rebuild/

index.jsがalexa skillで、main.goが rebuildのfeedからxmlをjsonに変換し、mp3をS3にアップロードしてるスクリプトです。

以上でした。

