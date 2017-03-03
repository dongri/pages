+++
date = "2016-12-18T15:58:44+09:00"
title = "Suica PASMO リーダー"
tags = ['Android', 'NFC', 'Suica', 'PASMO']
+++

最近良く自分のPASMO残高を把握できず、改札口で引っかかって「ファック」と小さい声出した時がよくあって、
AndroidでPASMOの残高を確認できるアプリを探してみたが、どれも必要ない機能ががたくさんあるのとデザインがイマイチ、
且つうざい広告が出るので逆にイラッとしたり、自分のAndroidのせいか分からないが、クラッシュしまくったり、、、

今週Android Payも出たし、FeliCaとかNFCの勉強も含めてアプリを開発してみようと思ってSuica, PASMOリーダーを作ってみることにした。

一日でやっつけたもので処理は単純。かざすとアプリが起動して読み取ったデータを表示するだけ。

[Play Store - Suica PASMO リーダー](https://play.google.com/store/apps/details?id=com.guncy.android.cardreader)

参考になったページ

* [FeliCa Library](https://osdn.net/projects/felicalib/wiki/suica)

* [路線、駅コード](http://www.denno.net/SFCardFan/)

* [AndroidでFelica(NFC)のブロックデータの取得](http://qiita.com/pear510/items/38f94d61c020a17314b6)

ダウンロード数がどれぐらいになるかわからないが、広告入れる予定もないし、機能追加しても課金する予定もないので、
オープンソースにしてメンテナンスして行こうと思います。

[Github - CardReader](https://github.com/dongri/CardReader)

TODO

* 読み取れる件数は決まってるので、過去のデータを保存する機能
* CSVフォーマットでUSBストレージに保存する機能
