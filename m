Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C80C77B7A
	for <virtualization@archiver.kernel.org>; Wed, 31 May 2023 01:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB54F60E55;
	Wed, 31 May 2023 01:52:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EB54F60E55
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qp/5EwTg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3nIKCqRtRi04; Wed, 31 May 2023 01:52:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4AB2960D68;
	Wed, 31 May 2023 01:52:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4AB2960D68
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23038C0035;
	Wed, 31 May 2023 01:52:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA1FEC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 01:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD9DB82233
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 01:52:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD9DB82233
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qp/5EwTg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ORsO52DwLNK8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 01:51:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62C9782205
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62C9782205
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 01:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685497917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZY/uyU8aJZOwiy6EjdW0OjHBqJ1EFHarQaHg+HXS1g=;
 b=Qp/5EwTgUPBWhdYTSSMgUnhgIFLkTHIHUeA9A0PC8H5r1xBxytLWm7756PwcGPgHpZMOQq
 GJ75o4nqQ7fh3iETpha1AXn9nbH9xnd3cftcd9VrJSO9zi2GpY1+caoEATPuA8uLl0QxMW
 G3470mCjZjEPRullw7n4XYqGn/mxhXA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-fEGwA_YBMluAby6KZy8pyQ-1; Tue, 30 May 2023 21:51:56 -0400
X-MC-Unique: fEGwA_YBMluAby6KZy8pyQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af1a18584bso26790891fa.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 18:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685497915; x=1688089915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZY/uyU8aJZOwiy6EjdW0OjHBqJ1EFHarQaHg+HXS1g=;
 b=iIUJxKhBdAmpo1P/c9qknqqhgiEcWcBSnBmy4p+dyt+6l5dp+doOq3WkYXUlX3/FXQ
 jyj2MnoRf4dr6vUcANaIckvNlJpjaURnjfhPCK12C5BHzq5yC/SkRiaX3QBKZickEm60
 bqlPOP8pHSb/Hq3L/DHfE7bAICM0qhEXWxBRfYrBU9HvRNlVgaspWIsIlqw2wYN7yoGY
 uvbhVLTAWMeaCfrH9xfMASk9VzYuJD6VVwUUdbFC3PDpHUWoTqPeCHNVMg8iYPCgiRvy
 E2dq3XzttimDsF1r0lhlPORXw8QlUFaT5YRthG/UvrGbgLn9NAecrUAkGBzbnUo7Ciq/
 bv6g==
X-Gm-Message-State: AC+VfDyMa3sYij4s2UHAZw1zDoa9QRSDgnhL8PgNX4skoahiu4mu/uBb
 LNwFtQgzDaqm3RuyuOX8y5T6WnXoBK6HZjLl5HUnnVEraq/81A8BtnKgwgyZbOo+zhX6ApVQIX+
 nEw2siitB10w0OrPr4De71G+0K+/dt2rZEg7xRkyjBK5CQlSi5WhYhRQ7Bw==
X-Received: by 2002:a05:651c:112:b0:2ad:92b9:83b4 with SMTP id
 a18-20020a05651c011200b002ad92b983b4mr1580855ljb.5.1685497915176; 
 Tue, 30 May 2023 18:51:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FGrtpC58TqBWa1tQUHdJqeKjtNsQoORfQMSaoOqEp7iWDACMg8a68vy/cJLTizdbj60k/rqnCbIHjHJ1EPRU=
X-Received: by 2002:a05:651c:112:b0:2ad:92b9:83b4 with SMTP id
 a18-20020a05651c011200b002ad92b983b4mr1580849ljb.5.1685497914893; Tue, 30 May
 2023 18:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230530033626.1266794-1-sheng.zhao@bytedance.com>
In-Reply-To: <20230530033626.1266794-1-sheng.zhao@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 May 2023 09:51:43 +0800
Message-ID: <CACGkMEtpSHTcMnJxLtV18pwHPsPb2YXp1YG-VhsK1gJnoPsOug@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid empty string for dev name
To: Sheng Zhao <sheng.zhao@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
 Xianjun Zeng <zengxianjun@bytedance.com>, mst@redhat.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBNYXkgMzAsIDIwMjMgYXQgMTE6MzfigK9BTSBTaGVuZyBaaGFvIDxzaGVuZy56aGFv
QGJ5dGVkYW5jZS5jb20+IHdyb3RlOgo+Cj4gU3l6a2FsbGVyIGhpdHMgYSBrZXJuZWwgV0FSTiB3
aGVuIHRoZSBmaXJzdCBjaGFyYWN0ZXIgb2YgdGhlIGRldiBuYW1lCj4gcHJvdmlkZWQgaXMgTlVM
TC4gU29sdXRpb24gaXMgdG8gYWRkIGEgTlVMTCBjaGVjayBiZWZvcmUgY2FsbGluZwo+IGNkZXZf
ZGV2aWNlX2FkZCgpIGluIHZkdXNlX2NyZWF0ZV9kZXYoKS4KPgo+IGtvYmplY3Q6ICgwMDAwMDAw
MDcyMDQyMTY5KTogYXR0ZW1wdGVkIHRvIGJlIHJlZ2lzdGVyZWQgd2l0aCBlbXB0eSBuYW1lIQo+
IFdBUk5JTkc6IENQVTogMCBQSUQ6IDExMjY5NSBhdCBsaWIva29iamVjdC5jOjIzNgo+IENhbGwg
VHJhY2U6Cj4gIGtvYmplY3RfYWRkX3ZhcmcgbGludXgvc3JjL2xpYi9rb2JqZWN0LmM6MzkwIFtp
bmxpbmVdCj4gIGtvYmplY3RfYWRkKzB4ZjYvMHgxNTAgbGludXgvc3JjL2xpYi9rb2JqZWN0LmM6
NDQyCj4gIGRldmljZV9hZGQrMHgyOGYvMHhjMjAgbGludXgvc3JjL2RyaXZlcnMvYmFzZS9jb3Jl
LmM6MjE2Nwo+ICBjZGV2X2RldmljZV9hZGQrMHg4My8weGMwIGxpbnV4L3NyYy9mcy9jaGFyX2Rl
di5jOjU0Ngo+ICB2ZHVzZV9jcmVhdGVfZGV2IGxpbnV4L3NyYy9kcml2ZXJzL3ZkcGEvdmRwYV91
c2VyL3ZkdXNlX2Rldi5jOjIyNTQgW2lubGluZV0KPiAgdmR1c2VfaW9jdGwrMHg3YjUvMHhmMzAg
bGludXgvc3JjL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmM6MjMxNgo+ICB2ZnNf
aW9jdGwgbGludXgvc3JjL2ZzL2lvY3RsLmM6NDcgW2lubGluZV0KPiAgZmlsZV9pb2N0bCBsaW51
eC9zcmMvZnMvaW9jdGwuYzo1MTAgW2lubGluZV0KPiAgZG9fdmZzX2lvY3RsKzB4MTRiLzB4YTgw
IGxpbnV4L3NyYy9mcy9pb2N0bC5jOjY5Nwo+ICBrc3lzX2lvY3RsKzB4N2MvMHhhMCBsaW51eC9z
cmMvZnMvaW9jdGwuYzo3MTQKPiAgX19kb19zeXNfaW9jdGwgbGludXgvc3JjL2ZzL2lvY3RsLmM6
NzIxIFtpbmxpbmVdCj4gIF9fc2Vfc3lzX2lvY3RsIGxpbnV4L3NyYy9mcy9pb2N0bC5jOjcxOSBb
aW5saW5lXQo+ICBfX3g2NF9zeXNfaW9jdGwrMHg0Mi8weDUwIGxpbnV4L3NyYy9mcy9pb2N0bC5j
OjcxOQo+ICBkb19zeXNjYWxsXzY0KzB4OTQvMHgzMzAgbGludXgvc3JjL2FyY2gveDg2L2VudHJ5
L2NvbW1vbi5jOjI5MQo+ICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5
Cj4KPiBSZXBvcnRlZC1ieTogWGlhbmp1biBaZW5nIDx6ZW5neGlhbmp1bkBieXRlZGFuY2UuY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IFNoZW5nIFpoYW8gPHNoZW5nLnpoYW9AYnl0ZWRhbmNlLmNvbT4K
CkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0t
LQo+ICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIHwgMyArKysKPiAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92
ZHBhX3VzZXIvdmR1c2VfZGV2LmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5j
Cj4gaW5kZXggZGU5N2UzOGMzYjgyLi41ZjVjMjE2NzRmZGMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3Vz
ZXIvdmR1c2VfZGV2LmMKPiBAQCAtMTY4NSw2ICsxNjg1LDkgQEAgc3RhdGljIGJvb2wgdmR1c2Vf
dmFsaWRhdGVfY29uZmlnKHN0cnVjdCB2ZHVzZV9kZXZfY29uZmlnICpjb25maWcpCj4gICAgICAg
ICBpZiAoY29uZmlnLT52cV9udW0gPiAweGZmZmYpCj4gICAgICAgICAgICAgICAgIHJldHVybiBm
YWxzZTsKPgo+ICsgICAgICAgaWYgKCFjb25maWctPm5hbWVbMF0pCj4gKyAgICAgICAgICAgICAg
IHJldHVybiBmYWxzZTsKPiArCj4gICAgICAgICBpZiAoIWRldmljZV9pc19hbGxvd2VkKGNvbmZp
Zy0+ZGV2aWNlX2lkKSkKPiAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+Cj4gLS0KPiAy
LjIwLjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
