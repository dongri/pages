+++
title = "メタトランザクションの実装例"
date = 2024-06-23T10:02:16+09:00
tags = ['ERC-2612', 'ERC-2771', 'ERC-3009']
+++

Ethereumのメタトランザクション（Meta-Transaction）とは、ユーザーがガス代を支払うことなくトランザクションを実行することを可能にする仕組みです。通常、Ethereum上のトランザクションを実行するには、ユーザーが自分のウォレットからガス代（ETH）を支払う必要があります。しかし、メタトランザクションを使用すると、ガス代を第三者（リレーアー、relayer）が支払い、ユーザーはETHを持っていなくてもトランザクションを送信できるようになります。（とChatGPTがおっしゃいました）

## EIP-712
https://eips.ethereum.org/EIPS/eip-712

Typed structured data hashing and signing をしてより人間にとって理解しやすいメッセージを署名する方式、以下の各EIPで使用されます。

## EIP-2612
https://eips.ethereum.org/EIPS/eip-2612

`permit` 関数を用意して中で `_approve` を行います。ユーザーがフロントエンドでEIP712署名を行って、relayerサーバーにsignatureを送ってrelayerが `transferFrom` 処理を行います。

## EIP-3009
https://eips.ethereum.org/EIPS/eip-3009

`transferWithAuthorization` 関数を用意して中で `ERC20._transfer` を行います。ユーザーがフロントエンドでEIP712署名を行って、Relayerサーバーにsignatureを送って、relayerが `transferWithAuthorization` を呼び出してtransfer処理を行います。

## EIP-2771
https://eips.ethereum.org/EIPS/eip-2771

`trustedForwarder` というスマートコントラクトを用意してTokenContractに設定します。ユーザーはフロントエンドでverifyingContractをforwarderAddressにしてEIP712署名を行って、Relayerサーバーにデータとsignatureを送ります。RelayerはデータとSignatureを使って `forwarderContract` の `execute` を呼び出してtransfer処理を行う。
forwarder contractとrelayサーバーを自前で構築するか、saasを使うことが可能です。relayサーバーは分散化GSN(Gas Station Network)もあります。

## 実装
実際動くものを作ってみないとものを言えないタイプなので、各EIPを実装してみました。
* https://github.com/dongri/ERC-2612
* https://github.com/dongri/ERC-3009
* https://github.com/dongri/ERC-2771
