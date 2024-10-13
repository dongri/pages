+++
date = "2017-09-09T06:50:55+09:00"
title = "GoでAmazon SES送信テスト"
tags = ['amazon', 'ses', 'go']
+++

毎回ハマったりするのでメモ。GolangでAmazon SES送信テスト。

```
package main

import (
  "errors"
  "log"

  "github.com/aws/aws-sdk-go/aws"
  "github.com/aws/aws-sdk-go/aws/credentials"
  "github.com/aws/aws-sdk-go/aws/session"
  "github.com/aws/aws-sdk-go/service/ses"
)

func main() {
  from := "noreply@domain.com"
  to := "dongrium@gmail.com"
  title := "amazon ses"
  body := "hello, from ses"
  err := sendSESEmail(from, to, title, body)
  if err != nil {
  	log.Println("mail sending error")
  }
}

func sendSESEmail(from string, to string, title string, body string) error {
  awsSession := session.New(&aws.Config{
    Region:      aws.String("us-east-1"),
    Credentials: credentials.NewStaticCredentials("AWS_ACCESS_KEY_ID", "AWS_SECRET_KEY", ""),
  })

  svc := ses.New(awsSession)
  input := &ses.SendEmailInput{
    Destination: &ses.Destination{
      ToAddresses: []*string{
        aws.String(to),
      },
    },
    Message: &ses.Message{
      Body: &ses.Body{
        Text: &ses.Content{
          Charset: aws.String("UTF-8"),
          Data:    aws.String(body),
        },
      },
      Subject: &ses.Content{
        Charset: aws.String("UTF-8"),
        Data:    aws.String(title),
      },
    },
    Source: aws.String(from),
  }
  _, err := svc.SendEmail(input)
  if err != nil {
    return errors.New(err.Error())
  }
  return nil
}
```

Amazon SESを有効にしただけではデフォルトsandboxモードになっていて認証済みのメールアドレス宛にしか送れない。
以下のエラーが出る。
```
MessageRejected: Email address is not verified. The following identities failed the check in region US-EAST-1: dongrium@gmail.com
  status code: 400, request id: c219f19b-94de-11e7-9a09-5d9282910f87
```

supportに「Request a Sending Limit Increase」申請する。
