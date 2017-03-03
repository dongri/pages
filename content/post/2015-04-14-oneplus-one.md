+++
date = "2015-04-14T11:28:57+09:00"
draft = false
title = "OnePlus One"
tags = ["android"]
+++

### 1. Bootloader Unlock

```
$ adb reboot bootloader
```

CyanogenMod Logoが出る

```
$ fastboot oem unlock
...
OKAY [  0.005s]
finished. total time: 0.005s
$  
```

### 2. Install TWRP

http://dl.twrp.me/bacon/

twrp-2.8.6.0-bacon.img ダウンロード

```
$ adb reboot bootloader

$ fastboot flash recovery twrp-2.8.6.0-bacon.img
target reported max download size of 536870912 bytes
sending 'recovery' (10180 KB)...
OKAY [  0.323s]
writing 'recovery'...
OKAY [  0.132s]
finished. total time: 0.455s

$ fastboot reboot
rebooting...

finished. total time: 0.005s
$
```

強制的にtwrp起動する

```
$ fastboot boot twrp-2.8.6.0-bacon.img
```

### 3. Wipe

電源ボタンとボリュームダウンボタンを同時に押してTWRPを起動する。
TWRP起動したらwipeを選択して全ての削除する！

### 4. Install Oxygen OS

https://oneplus.net/oxygenos

oxygenos_1.0.0.zip ダウンロード

oxygenos_1.0.0.zip を解凍して oxygenos_1.0.0.flashable.zip を OnePlus One に入れる

```
$ adb push oxygen_1.0.0_flashable.zip /sdcard/
```

TWRPでinstallを選択して、oxygen_1.0.0_flashable.zipを選択してインストール

SuperSUもインストールするようにする。デバイスが再起動したらもう一度SuperSUを起動してROOTを取る

以上
