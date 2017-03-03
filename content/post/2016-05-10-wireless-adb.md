+++
date = "2016-05-10T22:21:05+09:00"
title = "Wireless adb"
tass = ["android"]
+++

毎回USB繋げるのが面倒。

wifi環境でandroid adb shellできるようにした。

### adb tcpip listen_port

USBで繋げて

```
$ adb tcpip 5555
restarting in TCP mode port: 5555
```

### adb connect ip_address:lesten_port

```
$ adb connect 192.168.10.5:5555
connected to 192.168.10.5:5555

$ adb devices
List of devices attached
192.168.10.5:5555       device
```

### adb shell

```
$ adb shell
shell@bullhead:/ $ su
root@bullhead:/ # ls -la
```

これでUSBケーブルなくてもadb shellで繋げるようになった。

### Warning

このまま放置しておくとIPアドレスバレると誰からもadbで入れるので、終わったら adb usbでusbモードに戻しておきましょう。

```
$ adb usb
restarting in USB mode
```

### 追記

wifi環境が変わったりすると不安定になるので、app使ったほうが簡単だし、安全

https://play.google.com/store/apps/details?id=com.ttxapps.wifiadb
