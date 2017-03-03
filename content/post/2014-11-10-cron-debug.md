+++
date = "2014-11-10T11:28:57+09:00"
draft = false
title = "cron debug"
tags = ["linux"]
+++

毎回ハマるのでメモしとく。

コンソールでは正しく動くけど、crontabに記述すると動かない。

調べてみる順番

1.crondが動くか確認

```
$ ps aux | grep crond
root     25500  0.0  0.0 119380  1256 ?        Ss   Sep10   2:29 crond

$ /etc/init.d/crond status
crond (pid  25500) is running...
```

2.実行権限あるか確認してみる

```
$ ls -l /var/cron/hoge.sh
-rwxr-xr-x  1 root   root     90 Nov 10 08:54 hoge.sh
```

3.ログを仕込んでみる

標準出力は 1  
標準エラー出力は 2

```
0 5 * * * echo  "cron test" >> /home/dongri/cron-success.log 2>> /home/dongri/cron-error.log | mail -s "Cron Result" dongri@gmail.com

0 5 * * * /var/cron/hoge.sh >> /home/dongri/cron-success.log 2>> /home/dongri/cron-error.log | mail -s "Cron Result" dongri@gmail.com
```

※ 「2>&1」の意味は2の出力先を、1の出力先と同じようにする

4.cronログ見てみる

```
$ sudo tail -f /var/log/cron
```

5.メール確認してみる

こういう系メールは大体スパム扱いにされるので、Gmailのスパムフォルダを覗いてみる
