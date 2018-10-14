+++
title = "Chromeアドレスバー非表示"
date = 2018-10-14T23:55:10+09:00
tags = ['chrome', 'windows']
+++

ある案件でChromeのアドレスバーを隠す必要があって調べてみたが、以下どれも効かなかった。

* Javascriptでwindow.open時toolbar,locationなどをnoにする方法
* Chromeのショートカットキー作成して、開く方法
* フルスクリーンモード

2018年10月14日時点で、Windows, Macで確実に隠せる方法。

### Mac
```
$ cd /Applications/Google\ Chrome.app/Contents/MacOS
$ sudo ./Google\ Chrome --app="https://google.com" --incognito
```

### Windows
```
> cd /Program Files (x86)\Google\Chrome\Application
> chrome.exe --app="https://google.com" --incognito
```
