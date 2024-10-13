+++
title = "WeChat Pay, Alipay両方対応QRコード"
date = 2018-12-08T10:55:01+09:00
tags = ['qrcode', 'weixin', 'alipay']
+++

先週会社のオフサイトで中国上海に行って来ました。

"QRコード決済先進国、中国・上海にて、どのようにQRコード決済が人々の生活の一部になっているのかを実際に「見る」、「体験する」ことが醍醐味です。" らしいです。

QRコードで決済する以外にもofo,mobike QRコードで鍵を解除できたら、QRコードで自販機のジュース買えたりなどなど。

そこでみんなが気になってたのが、店頭に置いてある一枚のQRコードでWeChat Pay, Alipayどっちも決済できることでした。どのアプリからスキャンしても正しく認識して決済画面に遷移させるQRコードのことです。その辺の仕組み調べたので共有しようと思います。

## アプリの判別
WeChatからスキャンされたか、AlipayからスキャンされたかはUser Agentで判別します。
下の図がAlipayとWeChatからスキャンされたときのUser Agentです。

<img src="/images/post/2018-12-08/alipay-useragent.png" width="400px;">
<img src="/images/post/2018-12-08/weixin-useragent.png" width="400px;">

```
if (navigator.userAgent.match(/Alipay/i)) {
  // Alipay
} else if (navigator.userAgent.match(/MicroMessenger\//i)) {
  // WeChat pay
} else {
  // その他
}
```
Javascriptの例ですが、これをnginxのレベルで判別してもいいし、アプリケーションサーバー側で判別してもいいかと思います。

## Alipay
AlipayのQRコードはURL形式になっていて、アプリ判別したら用意したURLにリダイレクトすれば決済（送金）画面に遷移します。
```
例: https://qr.alipay.com/fkx07120vzhsliuln927l74
```

## WeChat Pay
WeChat PayはカスタマURLスキーム形式になっていて、Alipayのようにリダイレクトさせてもアプリが認識してくれませんでした。

```
例: wxp://f2f067yve_yNrmWOKjAmyEeuYcStPZXhjpud
```

スマートな方法ではないですが、WeChat Payのオリジナル「お金を受け取るQRコード」を表示させて、ユーザーがそれを長押しして「画像内のQRコードをスキャンする」でアプリに認識させる方法があります。

<img src="/images/post/2018-12-08/weixin-click.png" width="300px;">
<img src="/images/post/2018-12-08/weixin-input.png" width="300px;">

## 実装
簡単な例ですが、こんな感じになります。ここの `weixin.png` を自分のオリジナルQRコードの画像に置き換えてください。

```
<div id="weixin" style="display: none;">
  <img src="./weixin.png" style="width: 300px;">
  <br>
  <h4>QRコードを長押しして認識させる</h4>
</div>
<script>
  if (navigator.userAgent.match(/Alipay/i)) {
    window.location.href = "https://qr.alipay.com/fkx07120vzhsliuln927l74";
  } else if (navigator.userAgent.match(/MicroMessenger\//i)) {
    document.getElementById("weixin").style.display = 'block';
  } else {
    alert("Only Support WeChat Pay and Alipay");
  }
</script>
```

<img src="https://nilth.com/qrcode/direct/weixin-alipay.png" style="border-radius: 10px;" width="300px;"><br>
このQRコードをWeChatとAlipayどれからスキャンしても相手に送金する画面に遷移します。（間違って送金しないように）

## 各プラットフォームのAPIを使う方法
上の方法はアプリの送金画面にリダイレクトさせる方法で、WeChatの場合はあんまりスマートではないです。そこで現れたのが「收钱吧」みたいなサービスです。

https://shouqianba.com/pay-code.html

彼らの仕組みは店舗情報を登録させて、WeChat、Alipayの情報とあわせてプラットフォームのAPIを使って決済できるようにしてます。各アプリの送金画面に直接遷移させるのではなく、QRコードスキャンすると彼らのページに飛んで金額入力画面を表示させて、API経由でWeChat, Alipayと決済します。どのAPIと通信するかはUser Agentで判別するんでしょうね

<img src="/images/post/2018-12-08/shouqianba.png" width="500px;" style="border: 1px solid #aaa;">

上のQRコードはこんなURLになってます。
```
https://qr.shouqianba.com/18010900256037830890
```

#### WeChatでスキャン
<img src="/images/post/2018-12-08/weixin-payment-1.png" width="300px;" style="border: 1px solid #aaa;">
<img src="/images/post/2018-12-08/weixin-payment-2.png" width="300px;" style="border: 1px solid #aaa;">

#### Alipayでスキャン
<img src="/images/post/2018-12-08/alipay-payment-1.png" width="300px;" style="border: 1px solid #aaa;">
<img src="/images/post/2018-12-08/alipay-payment-2.png" width="300px;" style="border: 1px solid #aaa;">

アプリに合わせて共通のページを作ってるので、UIなどが統一されてます。この仕組だとWeChat Pay, AlipayだけではなくAPI公開してる決済サービスであればすべて対応可能です。

## WeChat, Alipay APIドキュメント
WeChat Pay<br>
https://pay.weixin.qq.com/wiki/doc/api/index.html

Alipay<br>
https://open.alipay.com/developmentDocument.htm

## 先日酒飲んでつぶやいてた

<blockquote class="twitter-tweet" data-lang="en"><p lang="ja" dir="ltr">EMVcoのような団体が決済用QRコードの標準を普及するよりプレイヤーがAPI公開して、みんな（自販機業者など）が実装したほうが速い気がする <a href="https://t.co/FTgEHax5nf">https://t.co/FTgEHax5nf</a></p>&mdash; D (@dongrium) <a href="https://twitter.com/dongrium/status/1070679301270302720?ref_src=twsrc%5Etfw">December 6, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet" data-lang="en"><p lang="ja" dir="ltr">そこでセキュリティリスクがあるのでAPIを公開しないプレイヤーも絶対いると思うけど、そこはビジョンの違いだな</p>&mdash; D (@dongrium) <a href="https://twitter.com/dongrium/status/1070680462744465408?ref_src=twsrc%5Etfw">December 6, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

日本のQRコード決済プレイヤーも早くAPI公開してくれるいいな