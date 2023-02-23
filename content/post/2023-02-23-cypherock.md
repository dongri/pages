+++
title = "Cypherock X1 Wallet 使ってみた感想"
date = 2023-02-23T22:23:54+09:00
tags = ['crypto', 'wallet']
+++

(Followed by English translation)

先日Bspeak!さんのギブアウェア企画(https://bspeak.substack.com/p/aiweb3)に参加して、当選されたCypherock X1 Walletが先日届きました。数日触ってみた感想を書きます。

まず自分の質問の答えから
https://docs.google.com/spreadsheets/d/1JWEgAfSGvUpQsNistCrnNCuZGiIgXqmJLtLdgN9lMoM/edit#gid=0

## 質問
mnemonicの仕組みを知りたいです。4つのカードに分けて暗号化して管理してるのか？その場合復号するためにマスターキーが必要のはずだけど、それはどうやって実現してるのか？

## 答え
mnemonicの前に、デバイスの中でエントロピーが生成されます。このエントロピーを利用して、BIP39規格に準拠したmnemonicを作成します。デフォルトでは、24語のシードフレーズを作成します。このエントロピーを、X1ウォレットに1つ、X1カードに4つ、計5つに暗号的に分割する「Shamir Secret Sharing」というアルゴリズムを適用しています。エントロピーは、1つのシェアが他のシェアのコンポーネントを推測できないように分割されます。つまり、X1ウォレット上のX1カードを1枚タップすると、シードフレーズを見ることができるようになるのです。

### ChatGPTにShamir Secret Sharingについて聞いてみた
```
Shamir Secret Sharing（シャミアの秘密分散）は、秘密情報を複数のパーティーに分散させるための暗号技術の1つです。

秘密情報を共有する際に、通常は情報を1つの場所に集中して保管することが多いですが、この方法だと秘密情報が漏洩する危険性があります。Shamir Secret Sharingは、秘密情報を複数のパーティーに分割し、それぞれのパーティーに分割された情報の一部だけを知らせることで、秘密情報の漏洩リスクを低減することができます。

Shamir Secret Sharingは、分割された秘密情報のうち、いくつかの情報のみを知っていても、秘密情報全体を復元することができるしきい値秘密分散の1つです。例えば、秘密情報を3つの部分に分割し、そのうち2つの部分を知っている場合に限り、元の秘密情報を復元できるようにすることができます。

Shamir Secret Sharingは、暗号技術の分野で、データの保護や暗号化、秘密情報の共有など、様々な用途で利用されています。また、ブロックチェーンのスマートコントラクトなどの分野でも、Shamir Secret Sharingを用いて秘密情報を分割する方法が採用されています。
```

Cypherockはシークレットを4で共有して閾値を1にしたわけですね

# 使ってみた感想
* mnemonic（シードフレーズ）を気にする必要がない  
多くのハードウェアウォレットは最初にmnemonicを忘れないように物理紙カードまで用意してそこに書き留めて安全な場所に保管しましょうだけど、Cypherockはそんなことしなくて良くて４枚のカードさえあれば復元できます。
* 端末の操作が楽  
メニューの操作がボタン式ではなく、ゲーム機のスティックのような仕様で片手でも操作できて非常に楽でした。
* 複数のウォレットが作れる  
多くのハードウェアウォレットは一つのウォレットのみサポートしてるが、Cypherockは役割に分けて複数のウォレットを作れたり、削除したりできます。
* サポートしてるコインの種類多い  
https://www.cypherock.com/coin-support
ここのリストされてるように多くのコインをサポートしてます。

# 改善されてほしい点
* Account という名称がわかりにくかった  
cysyncアプリで最初にコイン追加する時、一瞬種類少ない！と勘違いしてました。アプリ上は `Account` という名称で追加するが、USDCがなくて、え！？となりました。一旦Ethereumを追加してみるとサブメニューにAdd TokenがあってそこにEthereumチェーン上のToken一覧出てきました。ここで言う `Account` は `Chain` だったんですね。慣れたら全然違和感ないですが、初めは少しわかりにくかったんです。 `Account(chain)` みたいなわかりやすい名称にしてほしいです。
* NFT表示機能あるといいね  
今開発中かも知らないが、cysyncアプリでNFT見れたらいいですね。
* MetaMaskのハードウェアウォレット一覧になかった  
Cypherockのシェアが大きくなるとMetaMaskがサポートするかも知らないが、今のところは使えなくて、今後に期待したいです。

# まとめ
頻繁にMetaMaskなどに繋げて使うのには向いてないかもしれませんが、資産の保管には向いていると思います。
ニーモニック、シードフレーズ、リカバリーフレーズって何？という初心者にはよいハードウェアウォレットではないかと思います。

----------------------------------

# English translation

I recently participated in Bspeak!'s give-away project (https://bspeak.substack.com/p/aiweb3) and received the Cypherock X1 Wallet the other day, which I won. I've had a chance to touch it for a few days and write my impressions.

I'll start with the answer to my own question.
https://docs.google.com/spreadsheets/d/1JWEgAfSGvUpQsNistCrnNCuZGiIgXqmJLtLdgN9lMoM/edit#gid=0

## Question.
I would like to know how mnemonic works, do they manage the encryption on 4 separate cards? If so, I should need a master key to decrypt it, how is that accomplished?

## Answer.
Great question, so before the mnemonics entropy is generated within the device. This entropy is then used to create mnemonics according to the BIP39 standard. By default, we create 24 word seed phrases. We apply an algorithm called Shamir Secret Sharing that cryptographically splits this entropy into 5 shares - 1 on the X1 wallet and 4 on the X1 cards. The entropy is split in such a way, that no 1 share can guess the components of any other shares. We use a threshold of 2/5 shares to recreate the mnemonics that were created from the entropy - which means you tap 1 X1 card on the X1 wallet and it will allow you to view the seed phrase. 

### Ask ChatGPT about Shamir Secret Sharing.
```
Shamir Secret Sharing is a cryptographic technique for distributing secret information to multiple parties.

When sharing secret information, information is usually stored in one centralized location, but with this method, there is a risk of leakage of the secret information. Shamir Secret Sharing reduces the risk of secret information leakage by dividing the secret information among multiple parties and informing each party of only a portion of the information that has been divided.

Shamir Secret Sharing is one type of threshold secret sharing that can recover the entire secret information even if only some of the divided secret information is known. For example, the secret information can be split into three parts so that the original secret information can be recovered only if two of the three parts are known.

Shamir Secret Sharing has a variety of applications in the field of cryptography, including data protection, encryption, and secret information sharing. Shamir Secret Sharing is also used to split secret information in areas such as blockchain smart contracts.
````

So Cypherock shares the secret with 4 and the threshold is 1.

# How it works.
* No need to worry about mnemonic (seed phrase)  
Many hardware wallets require you to write down the mnemonic on a physical paper card and store it in a safe place so that you don't forget it at first.
* Easy terminal operation  
The menu operation is not a button operation, but a stick-like operation like a game console, so it was very easy to operate even with one hand.
* Multiple wallets can be created  
Many hardware wallets support only one wallet, but Cypherock allows you to create and delete multiple wallets for different roles.
* Many types of coins supported.  
https://www.cypherock.com/coin-support
Many coins are supported as listed here.

# Points that could be improved
* The name "Account" was confusing.  
When I first added coins in the cysync app, for a second I thought there were not enough types! I was mistaken. The app says `Account` but there is no USDC, so I was like What? I was like "What? Once I added Ethereum, there was a sub-menu with Add Token and there was a list of Tokens on the Ethereum chain. So `Account` here is `Chain`. Once you get used to it, it doesn't seem strange at all, but at first it was a little confusing. I would like you to change the name to something easier to understand like `Account(chain)`.
* It would be nice to have an NFT display function.  
I don't know if it's under development right now, but it would be nice to be able to see NFTs in the cysync app.
* I couldn't find it in MetaMask's hardware wallet list.  
I don't know if MetaMask might support it as Cypherock's market share grows, but for now it's not available and I hope it will be in the future.

# Summary
It may not be suitable for frequent use connected to MetaMask or other systems, but it is suitable for storing assets.
What are mnemonics, seed phrases, and recovery phrases? I think this is a good hardware wallet for beginners who want to know what mnemonics, seed phrases, and recovery phrases are.
