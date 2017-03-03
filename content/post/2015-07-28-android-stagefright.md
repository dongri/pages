+++
date = "2015-07-28T11:28:57+09:00"
draft = false
title = "Android Stagefright"
tags = ["android", "security"]
+++


詳しいことはこちら。

[Androidに最悪の脆弱性発見―ビデオメッセージを受信するだけでデバイスが乗っ取られる](http://jp.techcrunch.com/2015/07/28/20150727nasty-bug-lets-hackers-into-nearly-any-android-phone-using-nothing-but-a-message/)

ということで、まずSIMを抜いてOSのバージョンアップするようにした。

[CyanogenMod: Recent Stagefright issues](https://plus.google.com/+CyanogenMod/posts/7iuX21Tz7n8)

### Zip Fileダウンロードしてインストール

こちらから最新版cm-12.1をダウンロード。

[https://download.cyanogenmod.org/?device=bacon](https://download.cyanogenmod.org/?device=bacon)

```
$ adb push cm-12.1-20150728-NIGHTLY-bacon.zip /sdcard/
```

TWRPでinstallを選択して、cm-12.1-20150728-NIGHTLY-bacon.zipを選択してインストール

### Google Appsインストール

CMではデフォルトでGoogle Apps入ってないので、追加でインストールする。
こちらからarmバージョンをダウンロードする。

[https://github.com/cgapps/vendor_google](https://github.com/cgapps/vendor_google)

```
$ adb push gapps-5.1-arm-2015-07-17-13-29.zip /sdcard/
```

TWRPでinstallを選択して、gapps-5.1-arm-2015-07-17-13-29.zipを選択してインストール
