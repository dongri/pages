+++
title = "I Love Netskope"
date = 2019-12-12T00:00:00+09:00
tags = ['netskope', 'developer']
+++

Netskope大好きでちょっと便利なコマンド書いてみた。

### 永遠にさようなら
```sh
$ vim goodbye.sh

#!/bin/sh

sudo ps aux | grep Netskope | grep -v grep | awk '{ print "kill -9", $2 }' | sh
echo '[✓] Kill Netskope Process'

sudo rm -rf /Applications/Remove\ Netskope\ Client.app
echo '[✓] Removed Remove Netskope Client.app'

sudo rm -rf /Library/Application\ Support/Netskope
echo '[✓] Removed Agent of Netskope Client.app'

echo 'Successfully uninstalled.'

$ sh goodbye.sh
```

### しばらく消えて
```
$ vim ~/.bashrc

netskope () {
  case "$1" in
    pause)
      sudo launchctl unload /Library/LaunchDaemons/com.netskope.stagentsvc.plist
      echo "...Pause"
      ;;
    resume)
      sudo launchctl load /Library/LaunchDaemons/com.netskope.stagentsvc.plist
      echo "...Resume"
      ;;
    *)
      echo -e "netskope [pause|resume]"
  esac
}

$ source ~/.bashrc

$ netskope pause
$ curl ipconfig.io

$ netskope resume
$ curl ipconfig.io
```

以上！開発者達の仕事が捗ると何よりです！
