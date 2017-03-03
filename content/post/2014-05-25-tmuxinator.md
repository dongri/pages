+++
date = "2014-05-25T11:28:57+09:00"
draft = false
title = "tmuxinator"
tags=["tool", "osx"]
+++

tmux使ってて一番困ったことがMac再起動した時にtmux sessionがクリアされて、windowを最初から
起動しないとだめだった。

そこでtmuxinatorが登場！

tmuxinator は、tmuxで起動するウィンドウやレイアウトを事前に設定しておき、
tmuxinatorコマンドを実行することにより設定通りのウィンドウ配置にするツールです。

```
% tmux -V
tmux 1.9a
% gem -v
2.0.14
```

### tmuxinator インストール & 設定
```
% gem install tmuxinator
% echo $SHELL
/bin/zsh
$ echo $EDITOR
vim
% echo 'source ~/.tmuxinator/tmuxinator.zsh' >> ${HOME}/.zshrc
% soruce ~/.zshrc
% mux doctor
Checking if tmux is installed ==> Yes
Checking if $EDITOR is set ==> Yes
Checking if $SHELL is set ==> Yes
%
```

### project 作成 & 設定
```
% mux new dongri

# ~/.tmuxinator/dongri.yml

name: dongri
root: ~/

# Optional tmux socket
# socket_name: foo

# Runs before everything. Use it to start daemons etc.
# pre: sudo /etc/rc.d/mysqld start

# Runs in each window and pane before window/pane specific commands. Useful for setting up interpreter versions.
# pre_window: rbenv shell 2.0.0-p247

# Pass command line options to tmux. Useful for specifying a different tmux.conf.
# tmux_options: -f ~/.tmux.mac.conf

# Change the command to call tmux.  This can be used by derivatives/wrappers like byobu.
# tmux_command: byobu

windows:
  - local:
      layout: 16ba,238x62,0,0{119x62,0,0[119x31,0,0,34,119x30,0,32,37],118x62,120,0[118x31,120,0,35,118x30,120,32,36]}
      panes:
        -
        -
        -
        -
  - vagrant:
      layout: 16ba,238x62,0,0{119x62,0,0[119x31,0,0,34,119x30,0,32,37],118x62,120,0[118x31,120,0,35,118x30,120,32,36]}
      panes:
        - cd project/project-backend
        - cd project/project-web
        - cd project/inside-project
  - git-server:
      layout: 16ba,238x62,0,0{119x62,0,0[119x31,0,0,34,119x30,0,32,37],118x62,120,0[118x31,120,0,35,118x30,120,32,36]}
      panes:
        - cd project/project-backend
        - cd project/project-api
        - cd project/project-api
        - cd project/server-config
  - git-others:
      layout: 16ba,238x62,0,0{119x62,0,0[119x31,0,0,34,119x30,0,32,37],118x62,120,0[118x31,120,0,35,118x30,120,32,36]}
      panes:
        - cd project/project-ios
        - cd project/project-android
        - cd project/project-web
        - cd project/inside-project
  - project-local:
      layout: 16ba,238x62,0,0{119x62,0,0[119x31,0,0,34,119x30,0,32,37],118x62,120,0[118x31,120,0,35,118x30,120,32,36]}
      panes:
        - cd project/project-backend
        - cd project/project-web
        - cd project/project-api
        - cd project/inside-project
  - project-dev:
      layout: a916,237x59,0,0{118x59,0,0,74,118x59,119,0,90}
      panes:
        - ssh project-dev
        - ssh project-dev
  - project-script:
      layout: a916,237x59,0,0{118x59,0,0,74,118x59,119,0,90}
      panes:
        - ssh project-script
        - ssh project-script
  - project-bastion:
      layout: a916,237x59,0,0{118x59,0,0,74,118x59,119,0,90}
      panes:
        - ssh aws-project-bastion
        - ssh aws-project-bastion
```

layoutはところわけわらない数字は list-windows で表示された数字です。自分の設定したtmuxの環境で以下のコマンドで確認

```
% tmux list-windows
0: local- (4 panes) [238x62] [layout 5297,238x62,0,0{119x62,0,0[119x31,0,0,0,119x30,0,32,8],118x62,120,0[118x31,120,0,9,118x30,120,32,10]}] @0
1: vagrant* (3 panes) [238x62] [layout 162a,238x62,0,0{119x62,0,0[119x31,0,0,1,119x30,0,32,11],118x62,120,0,12}] @1
```

[layout ****] ***の部分を ~/.tmuxinator/dongri.yml のlayoutのところにペスト

### プロジェクト起動

```
$ mux dongri
```

### イメージ
![Tmux](/images/posts/tmux.png "Tmux" width="96px" height="96px")
