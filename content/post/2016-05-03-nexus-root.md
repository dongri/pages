+++
date = "2016-05-03T01:36:00+09:00"
title = "Nexus 5X クリーンインストール & Root化"
tags = ["android", "nexus"]
+++

## Factory Image

Googleが公開しているNexus端末向けの初期ROMデータのことを言います。
Factory Imageには、「system・boot（Kernel）・recovery・bootloader・radio・userdata・cache」などの各領域のイメージが含まれており、
それらを端末に書き込むことで領域を完全に初期化することが出来ます。

https://developers.google.com/android/nexus/images

nexus5xのところの最新のものをダウンロードして解凍する

## OEMロック解除

開発者向けオプションで「OEMロック解除を有効にする」にチェックを入れる

## ブートローダーをアンロック

```
$ adb reboot bootloader // もしくは、電源ボタンとボリュームダウンボタンを同時に長押し
$ fastboot oem unlock
...
OKAY [ 20.966s]
finished. total time: 20.966s
```

これでbootloaderがunlockの状態になる

`DEVICE STATE - locked`

 ↓

`DEVICE STATE - unlocked`


## flash-all

```
$ cd bullhead-mhc19q
$ ./flash-all.sh
...
OKAY [  0.214s]
writing 'cache'...
OKAY [  0.061s]
rebooting...

finished. total time: 86.174s
```

## カスタムリカバリの導入

https://twrp.me/devices/lgnexus5x.html

Download Links で 最新のimgファイルダウンロードする。

```
$ fastboot flash recovery twrp-3.0.2-0-bullhead.img
```

ブートローダー画面から「Recovery mode」を選択すると導入したTWRPを起動できるようなりました。

## Root化

SuperSUの最新版を見つけて入れる。バージョンが違うとAndroid自体が起動できなかったりするのでご注意を

https://download.chainfire.eu/932/SuperSU/BETA-SuperSU-v2.71-20160331103524.zip

BETA-SuperSU-v2.71-20160331103524.zipを端末に転送して、install

```
$ adb push BETA-SuperSU-v2.71-20160331103524.zip /sdcard/
4103 KB/s (4015219 bytes in 0.955s)
$ adb reboot bootloader
```

Recovery modeを選択して決定、「Install」より先ほどダウンロードしたSuperSUを選択して書き込む。

http://g.co/ABH

警告でるが、電源ボタンを２回押して続ける。

再起動されるが、めっちゃ遅い................

これでroot取れた。

やり放題。ubuntu入れて、webサーバー立てる。
