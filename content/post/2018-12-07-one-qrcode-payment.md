+++
title = "一つのQRコードでWeChat Pay, Alipay対応"
date = 2018-12-07T16:55:01+09:00
tags = ['qrcode', 'weixin', 'alipay']
+++

先週会社のオフサイトで中国の上海に行って来ました。

> QRコード決済先進国、中国・上海にて、どのようにQRコード決済が人々の生活の一部になっているのかを実際に「見る」、「体験する」ことが醍醐味です。

QRコード決済以外にもofo,mobikeみたいにQRコードで鍵を解除できたら、QRコードで自販機でジュース買えたりしたけど、みんな気になってた統一QRコードの仕組みを調べたのでちょっと解説しようかと思います。

一つのQRコードでWeChat Pay, Alipayに対応できるQRコードのことで、どのアプリからスキャンしても正しく認識して決済画面に遷移させるQRコードのことです。

# アプリの判別
WeChatからスキャンされたか、Alipayからスキャンされたかは皆さんもよく知ってるuser agentです。

<img src="/images/post/2018-12-07/alipay-useragent.png" width="400px;">
<img src="/images/post/2018-12-07/weixin-useragent.png" width="400px;">

```
if (navigator.userAgent.match(/Alipay/i)) {
  // Alipay
} else if (navigator.userAgent.match(/MicroMessenger\//i)) {
  // WeChat pay
} else {
  // その他
}
```
Javascriptの例ですが、これをnginxレイヤーで判別してもいいし、アプリケーションサーバー側で判別してもいいかと思います。

# ダイレクトでアプリに遷移させる方法
### Alipay
AlipayのQRコードはURL形式になっていて、アプリ判別したら用意したURLにリダイレクトすれば決済（送金）画面に遷移します。

例: https://qr.alipay.com/fkx07120vzhsliuln927l74

### WeChat Pay
WeChat　PayはカスタマURLスキーム形式になってるAlipayのようにリダイレクトさせてもアプリが認識してくれませんでした。

例: wxp://f2f067yve_yNrmWOKjAmyEeuYcStPZXhjpud

スマートな方法ではないですが、WeChat Payのオリジナル送金QRコードを表示されて、ユーザーにそれを長押ししてアプリに認識させる方法です。

一枚のhtmlでやるとこんな感じになります。

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
    alert("Only Support Weixin Pay and Alipay");
  }
</script>
```

<img src="https://hackerth.com/qrcode/direct/weixin-alipay.png" style="border-radius: 10px;" width="300px;"><br>
このQRコードで確認できます。（間違って送金しないように）

# 中間レイヤー作って各プラットフォームのAPIで実装する方法

