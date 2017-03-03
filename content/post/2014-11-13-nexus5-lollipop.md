+++
date = "2014-11-13T11:28:57+09:00"
draft = false
title = "Nexus5 Lollipop"
tags = ["nexus", "android"]
+++

数ヶ月間ずっとAndroid L Preview版入れて使ってたけど、今日やっとGoogleのデベロッパーサイトにNexus5のLollipop Factory Imageが現れたので、手動で入れてみた。

[Factory Images for Nexus Devices](https://developers.google.com/android/nexus/images)
アクセスして、Nexus5用のimageファイルダウンロード。[5.0 (LRX21O)](https://dl.google.com/dl/android/aosp/hammerhead-lrx21o-factory-01315e08.tgz)

```
$ tar -zxvf hammerhead-lrx21o-factory-01315e08.tgz
$ cd hammerhead-lrx21o
$ adb reboot bootloader
$ fastboot oem unlock
$ ./flash-all.sh
```

以上！
