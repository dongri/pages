+++
date = "2014-05-26T11:28:57+09:00"
draft = false
title = "Powerline"
tags=["tool", "osx"]
+++

Powerline化！

歴史的には vim powerline, zsh powerline, tmux powerline がそれぞれあったみたいだったが、最近はそれがひとつに統合されました。

https://github.com/Lokaltog/powerline

### まず vim から

vim プラグイン管理ツールNeoBundle.vimをインストール

```
$ mkdir -p ~/.vim/bundle
$ git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
```

~/.vimrc 編集

```
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

"" NeoBundle
NeoBundle 'Shougo/neobundle.vim'

filetype plugin indent on
filetype indent on
syntax on
```

### Powerlineのインストール

~/.vimrcに追加

```
NeoBundle 'alpaca-tc/alpaca_powertabline'
NeoBundle 'https://github.com/Lokaltog/powerline.git'
````

保存して、もう一度開いてインストール
:NeoBundleInstall

ちなみにアンインストールは NeoBundleをvimrcから消してから
:NeoBundleClean

### powerlineのためfontにパッチをあてる

Powerlineのステータスバーには特殊文字列を使うために既存fontにパッチを当てる必要ある。

```
% git clone https://github.com/Lokaltog/vim-powerline.git

% brew update
% brew install fontforge
% fontforge -script vim-powerline/fontpatcher/fontpatcher  ~/Library/Fonts/<font>
% cp *-Powerline.ttf  ~/Library/Fonts/
```

もしくは [https://github.com/Lokaltog/powerline-fonts](https://github.com/Lokaltog/powerline-fonts) 直接ダウンロードする。

### ~/.vimrc 設定
```
set laststatus=2
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'
set noshowmode
```

### ~/.zshrc 設定
```
source ~/.vim/bundle/powerline/powerline/bindings/zsh/powerline.zsh
```

### ~/.tmux.conf 設定
```
source ~/.vim/bundle/powerline/powerline/bindings/tmux/powerline.conf
```

以上で、vim, zsh, tmuxのstatuslineが格好良くなりました。

![zsh](/images/posts/2014-05-26/powerline-zsh.png "zsh")

![vim](/images/posts/2014-05-26/powerline-vim.png "vim")

![tmux](/images/posts/2014-05-26/powerline-tmux.png "tmux")
