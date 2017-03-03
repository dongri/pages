+++
date = "2015-05-11T11:28:57+09:00"
draft = false
title = "Goodbye Heroku"
tags = ["heroku"]
+++

<a href="https://www.flickr.com/photos/dongriat/16899138724" title="heroku_shot by Dongri Jin, 於 Flickr"><img src="https://c1.staticflickr.com/9/8707/16899138724_1bc1099219_z.jpg" width="640" height="479" alt="heroku_shot"></a>

これが2007年同時のherokuでした。エディタ使わずブラウザでコード書いてSaveするとRailsが動く！素晴らしい！

その後gitが流行り始めgit pushでデプロイできるようになりましたね。heroku buttonも出てOne Clickでデプロイできるようになったり。

2007年から今まで使ってて、Privateのプロジェクトも一時には会社のプロジェクトにも使いました。

初めはRubyだけだったのが、今はjava, scala, php, python, nodejs, goまでサポートしてます。最近はdockerもサポートするので、言語問わなくデプロイできちゃいますね。

herokuの特徴と言えばとりあえず動かせるを場を提供する。そのかわりファイルアップロードできない、一定時間でスリープ、などいろいろ制限されるけど、sandboxとしては十分で便利なプラットフォームです。

自分のリポジトリ数えてみたらびっくりしました。50個近くのアプリがデプロイされてました。(ほとんどがゴミ w w w)

[https://blog.heroku.com/archives/2015/5/7/new-dyno-types-public-beta](https://blog.heroku.com/archives/2015/5/7/new-dyno-types-public-beta)

こんなので自分の遊びがなくなりました。$7 払えないわけではない。しかし昔みたいにとりあえずherokuみたいな感じにはなれない。

herokuの代わりのものを Google Cloud, AWS も検討してみましたが、結局は DigitalOceanでサーバー立てて、[dokku](https://github.com/progrium/dokku) 入れて自分専用の遊び場を作ることにしました。

今のところ4GBでnode, rails, goなど10個のcontainer立ち上げても問題なさそうです。

heroku長い間お世話になりました！

Goodbye! Heroku!
