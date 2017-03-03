+++
date = "2014-11-14T11:28:57+09:00"
draft = false
title = "tmux on yosemite"
tags = ["tool", "osx"]
+++

やっとYosemiteにした。

自分の環境でちょっと動かなかった、ぶつかった問題をまとめてみた。

### homebrew
まずはこのエラー

```
/opt/boxen/homebrew/bin/brew: line 26: /opt/boxen/homebrew/Library/brew.rb: Undefined error: 0
```

brew.rbを修正

```
--- #!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby -W0
+++ #!/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/bin/ruby -W0
```

### brew update

```
$ git add /opt/boxen/homebrew/Library/brew.rb
$ git commit -am "Fix ruby version"
```

mysqlのバージョン固定する必要あるので

```
$ brew pin mysql
$ brew update
```

### tmux

tmuxからatom, gitx起動できない。

```
LSOpenURLsWithRole() failed for the application /Applications/Atom.app with error -10810.
```


reattach-to-user-namespace インストール

```
$ brew install reattach-to-user-namespace
```

tumx.conf に追加

```
# Fix LSOpenURLsWithRole() error on OS X. Requires reattach-to-user-namespace
# to be installed.
set-option -g default-command "which reattach-to-user-namespace > /dev/null && reattach-to-user-namespace -l $SHELL || $SHELL"
```

(今さらだけど、Yosemiteキレイね！)
