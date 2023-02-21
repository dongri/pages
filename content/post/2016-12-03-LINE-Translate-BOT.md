+++
date = "2016-12-03T16:42:42+09:00"
title = "LINE Translate BOT"
tags = ["Blog", "LINE", "BOT"]
+++

LINE BOTがMessaging apiを正式にリリースしたので翻訳BOTを作りました。

<a href="https://wise.nilth.com" target="_blank">https://wise.nilth.com</a> (shutdown)

公式の通訳BOTも何個かあるのに何で今更翻訳BOT? と思う人もいるかも知らないですが、理由は2つあります。

### 1. 汎用性の問題
LINE公式通訳BOTをディスってるわけではないが、正直言って不便でした。日英、日中、日韓と一つ一つが単体のBOTになっていて、一つのグループに複数BOTを招待できないのと、あくまで日本語をベースにしてるので、例えば韓国語を英語に翻訳することはできません。

### 2. 進化した翻訳技術
ちょっと前に話題になっていた翻訳技術の進化です。ニューラルネットワーク機械学習の応用により翻訳の精度が今までと比較できないレベルまで進化してきました。

上の理由から今更なんですが翻訳BOTを作りました。英語がダメな私はまず普段辞書の代わりによく使うと思います。

### エンジニア的な話をちょっと
今はdocker container一つで動かしていて正直言ってどれくらいのリクエストで死ぬかわからないです。
このBOTの利用者が増えてリクエストをさばけない時にはサーバー増やしたりスペック上げたりなど考えることにしました。
エンジニア達はすぐ分かったと思いますが、この俺が翻訳エンジンなんか作れるわけではないので、Google Translate APIを使ってます。
こいつにも金取られるので、これ以上無理だと判断した時にはまた考えようかと思います。
BOTサーバーはGo言語で書いていて、LINE BOT API Trialの時から自前で作ったGo言語用SDKを使ってます。
[line-bot-sdk-go](https://github.com/dongri/line-bot-sdk-go) 。
Landing PageはF7さんのLp使いました。 [https://github.com/F7/Lp](https://github.com/F7/Lp)

### LINE BOT AWARDS
https://botawards.line.me これなんですが、この翻訳BOTはある意味今のLINE公式通訳BOTと競合？してるので、どうかなと思いますｗ。
それと元中の人だったので応募するとなんか気まずいところもあって、悩んてるところですｗ。
