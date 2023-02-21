+++
title = "短縮URLサービスを作ってみた"
date = 2018-04-14T03:13:44+08:00
tags = ['shortener', 'python', 'goo.gl']
+++

goo.glサービス終了のニュースで「短縮URLサービス作ってみた」の記事見かけで、ちょうど自分も一ヶ月ほど前に作ったものがあってその解説をしようと思います。
作ってみたきっかけはサイドプロジェクトでSMS送信する必要があったのですが、140文字の制限で長いURLは送れませんでした。それでGo言語用の [go-shortener](https://github.com/dongri/go-shortener) というライブラリ？まで作りました。

その後５日間の休みを取って海外旅行したので、飛行機の中と旅行先で自前の短縮URLサービスを作ってみたくなって作りました。

https://shortener.nilth.com

~~clacky.org ドメインは旅行先のシンガポールClarke Quayから来てます。（ドメインは短くないですが）~~

### 一定長さの文字列にする
ハッシュ関数を使ってすべての文字列を一定長さにする方法もありますが、

```
MD5    - 32文字
sha1   - 40文字
sha256 - 64文字
sha512 - 128文字
```

どれも短くありません。

### ランダム文字列にしてデータベースに保存
一定長さのランダム文字列を生成してデータベースに保存して、マッピング表を作ります。同じランダム文字列のキーがあったらもう一回ランダム文字列を生成して同じキーがないところまで処理を繰り返します。これは短い文字列生成の目的は達成できますが、データの量が多くなると一つの処理で数千、数万、データの数分データベースにクエリを発行することになります。データベースに対しての負荷が大きすぎるので、現実的ではありませんでした。

### データベースのIDを62進数に変換する
`小文字、大文字アルファベット + 数字 = 62文字`

URLをデータベースに保存して発行される連番IDを62進数に変換して短縮URLのキーにします。100億件のデータも62進数に変換すると6桁（aUKYOA）だけなので十分短いです。

### pythonコード

```
chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJELMNOPQRSTUVWXYZ"

def encode62(num, chars=chars):
    base = len(chars)
    string = ""
    while True:
        string = chars[num % base] + string
        num = num // base
        if num == 0:
            break
    return string

def decode62(string, chars=chars):
    base = len(chars)
    num = 0
    for char in string:
        num = num * base + chars.index(char)
    return num

e = encode62(99999999999)
print(e)  # 1L9zO9N

d = decode62('1L9zO9N')
print(d)  # 99999999999
```

### ちょっと工夫

* 数字アルファベット順にするとランダム性ないので、charsをシャッフルしてから設定
* 238327件でやっとZZZなのでencode62(id+238327)して3桁、4桁にしてそれぽく見せる
* 連番だと62進数も連番で増えていくのでランダムを求めるためにIDをreverseする

これで

* 短い
* ユニーク
* データベース負荷

すべてクリアしました。

これは自分の実装ですが、他によい方法あれば教えてください〜

シンガポールもう一度行ってみたい。