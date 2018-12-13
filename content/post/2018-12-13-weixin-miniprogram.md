+++
title = "WeChatミニプログラム作ってみた"
date = 2018-12-13T10:43:06+09:00
tags = ['wechat', 'miniprogram']
+++

WeChatミニプログラムとは？

WeChat上で構築できるアプリのことです。基本Javascript(TypeScript)とwxmlで書けます。

https://developers.weixin.qq.com/miniprogram/dev/index.html

こちらに書いてあるようにアカウント申請して、開発ツールダウンロードすれば開発できます。

勉強も含めてミニプログラム作ってみました。

<img src="/images/post/2018-12-13/weixin-miniprogram.png" width="300px" style="border: 1px solid #ccc;">

今日は何を食おうかを登録済みのリストからランダムに表示させて選ばせるシンプルなアプリです。

WeChatでスキャンして確認できます。

<img src="/images/post/2018-12-13/qrcode.jpg" width="300px" style="border: 1px solid #ccc;">

ソースコードはこちらにあります。

https://github.com/dongri/what-to-eat

### 触ってみた感じ

1. wxmlはhtmlと互換性が低い
2. wxmlに独自のタグがたくさんある
3. 外部リンク貼れない
4. ajaxで通信するには管理画面のwhite listにドメインを登録する必要がある
5. storage機能が付いてる
6. クラウド用意してあるのでサーバレスで開発できる
7. アプリのサイズが5MB超えると申請できない
8. アプリの審査が簡単。初回だとちょっと時間かかるが、更新だと早いときは1,2時間で反映される。

