+++
title = "非認証Android端末をGoogle認証通す方法"
date = 2018-04-13T03:13:44+08:00
tags = ['android', 'google']
+++

突然Kyashが使えなくなった。

<a data-flickr-embed="true"  href="https://www.flickr.com/photos/140596581@N07/39615383380/in/dateposted-public/" title="Kyash"><img src="https://farm1.staticflickr.com/785/39615383380_fcf4ee90d4.jpg" width="250" height="500" alt="Kyash"></a><script async src="//embedr.flickr.com/assets/client-code.js" charset="utf-8"></script>

この端末はRoot取ってないのでおそらくGoogleの認定を受けてない端末だからでしょう。Play Storeアプリ開いて設定見ると端末の認証のところが認証されてませんと出る。

<a data-flickr-embed="true"  href="https://www.flickr.com/photos/140596581@N07/27552736258/in/dateposted-public/" title="PlayStore"><img src="https://farm1.staticflickr.com/796/27552736258_a510f1d61b.jpg" width="250" height="500" alt="PlayStore"></a><script async src="//embedr.flickr.com/assets/client-code.js" charset="utf-8"></script>

https://www.android.com/certified/partners/

自分の端末はsmartisanという中国の端末で上のパートナー一覧には載ってなかった。

確かにこの前この辺のニュースも出て、将来はGoogleのアプリ（Gmail, Chromeなど）も認証されてない端末では動かないようにする予定。

https://www.google.com/android/uncertified/

上のリンク先にカスタムROMをインストールした端末はAndroid IDを入れるといいらしいが、自分の端末はちょっと違う。試しにAndroid IDを入れてみたら通った。Kyashも正しく起動してくれた。

Android IDはどう取得するのか？上のページでは adb コマンドで取得すると書いてあるが、そもそもRoot取ってないのでこの方法だとだめで、違う方法でAndroid IDを取得しないといけない。

```
String androidId = Settings.Secure.getString(getContext().getContentResolver(), Settings.Secure.ANDROID_ID);
System.out.println(androidId);
```

Android開発環境でこのようなコードで取得できるが、エンジニアじゃないと無理だろう。せっかくなのでAndroid IDだけを表示するアプリを作ってPlay Storeに公開した。

https://play.google.com/store/apps/details?id=org.dongri.androidid

### 追記
あとでPlay StoreでAndroid IDで検索してみたらアプリが大量に出てきたｗ


