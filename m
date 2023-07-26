Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CA4EB64DD
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 01:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D54B740541;
	Wed, 26 Jul 2023 01:55:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D54B740541
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dur0+WeA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QV2lfF_948hn; Wed, 26 Jul 2023 01:55:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 356D5400D2;
	Wed, 26 Jul 2023 01:55:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 356D5400D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDD51C0071;
	Wed, 26 Jul 2023 01:55:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B632C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 01:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17AE26117A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 01:55:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17AE26117A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dur0+WeA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o5T2aEI9MLIK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 01:55:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CB5560F82
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 01:55:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CB5560F82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690336507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWu3B8vvWTlSK2/gVzv/iHW5SwZZZ1PnJ4r4lJp+rz4=;
 b=dur0+WeAousnkbcHHVlchAs/WxmaV7R65e6I7Ua5mJDY0CjlBVUYuFbJH1lowK9jZI0MWD
 ayUDPAc84qDfr8kO9bEOdFFoCP/OBpOkTSRUh1+v4jiev1ZZcBa/QMBsV9g8zXmu0Qex8Q
 FCtUFhwpfUDnof9szLVx7V9xl6uYKfo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-93FhT4REP2y6g11zI5Bq5A-1; Tue, 25 Jul 2023 21:55:06 -0400
X-MC-Unique: 93FhT4REP2y6g11zI5Bq5A-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6f0527454so51801791fa.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 18:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690336504; x=1690941304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWu3B8vvWTlSK2/gVzv/iHW5SwZZZ1PnJ4r4lJp+rz4=;
 b=Gob9qwwPbsYjvgp/iOlQue7ZmZT5wmkdGEv3cd3CnOQjhMEuxfqLw6ZFi0Tic2cmL7
 w5nNp3Q4b6RK0GpgUdPHLrrmPFfQza8PfxauaAJmhK7U0HzabiiWTCNQeIT+pO1XTyET
 uPgoen3Gy0JVa6BmA7TZMLiuashs6rDycugQvoEnIXEFjUEYk8girHr6BOU8JcBkDD7I
 XD6PTmFBaQXV74DKX7RSGJso5GbFmvW445ovK/jAir5qpXdRCE5geB5pEY+5Ln+cHSN5
 WOoqXkReOAUbBD+atbJvhdeWxobbgaHDdHDJjEoy4Q4ZBFFFjfUNEnpvFD577LZdEqRA
 3CfQ==
X-Gm-Message-State: ABy/qLZ9WpCQerOcgpX7r8094ECgHiVHVc3mxc6PVNYXp8bOy31dGfoh
 bmKgRP/2PC/+f9O2FtEFv7ph/d1XjF9k7nWi6NGiMVEmz/DpBD+RSaR0pTWfxonIthBhgU6+RTa
 biqZBeitAIcSGq0VjrcUkdMMkgXd2YXRsl37yIcS5GFSAdH+ergHHr4EpTw==
X-Received: by 2002:a2e:6e11:0:b0:2b9:563b:7e3a with SMTP id
 j17-20020a2e6e11000000b002b9563b7e3amr376809ljc.32.1690336504551; 
 Tue, 25 Jul 2023 18:55:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGePGkE9JcftKxT8qFEJKD005x07vC0fBPJh6B4t54XQVLeK2VokVl+UKA76A5++jaxgO3jPiakibc6Rmslffg=
X-Received: by 2002:a2e:6e11:0:b0:2b9:563b:7e3a with SMTP id
 j17-20020a2e6e11000000b002b9563b7e3amr376799ljc.32.1690336504212; Tue, 25 Jul
 2023 18:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230725072049.617289-1-jasowang@redhat.com>
 <20230725035120-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230725035120-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jul 2023 09:54:52 +0800
Message-ID: <CACGkMEszSRxefFqfoDzpyUV2b6+zKKotXKVUOgxpihDyfk9FgQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix race between set queues and probe
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMzo1M+KAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMDM6MjA6NDlB
TSAtMDQwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IEEgcmFjZSB3ZXJlIGZvdW5kIHdoZXJlIHNl
dF9jaGFubmVscyBjb3VsZCBiZSBjYWxsZWQgYWZ0ZXIgcmVnaXN0ZXJpbmcKPiA+IGJ1dCBiZWZv
cmUgdmlydG5ldF9zZXRfcXVldWVzKCkgaW4gdmlydG5ldF9wcm9iZSgpLiBGaXhpbmcgdGhpcyBi
eQo+ID4gbW92aW5nIHRoZSB2aXJ0bmV0X3NldF9xdWV1ZXMoKSBiZWZvcmUgbmV0ZGV2aWNlIHJl
Z2lzdGVyaW5nLiBXaGlsZSBhdAo+ID4gaXQsIHVzZSBfdmlydG5ldF9zZXRfcXVldWVzKCkgdG8g
YXZvaWQgaG9sZGluZyBydG5sIGFzIHRoZSBkZXZpY2UgaXMKPiA+IG5vdCBldmVuIHJlZ2lzdGVy
ZWQgYXQgdGhhdCB0aW1lLgo+ID4KPiA+IEZpeGVzOiBhMjIwODcxYmU2NmYgKCJ2aXJ0aW8tbmV0
OiBjb3JyZWN0bHkgZW5hYmxlIG11bHRpcXVldWUiKQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPgo+Cj4gQWNrZWQtYnk6IE1pY2hhZWwgUy4gVHNp
cmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4KPiBzdGFibGUgbWF0ZXJpYWwgSSBndWVzcz8KClllcyBp
dCBpcy4KClRoYW5rcwoKPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwg
NCArKy0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPiBpbmRleCAwZGIxNGY2Yjg3ZDMuLjEyNzBjOGQyMzQ2MyAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPiBAQCAtNDIxOSw2ICs0MjE5LDggQEAgc3RhdGljIGludCB2
aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gICAgICAgaWYgKHZp
LT5oYXNfcnNzIHx8IHZpLT5oYXNfcnNzX2hhc2hfcmVwb3J0KQo+ID4gICAgICAgICAgICAgICB2
aXJ0bmV0X2luaXRfZGVmYXVsdF9yc3ModmkpOwo+ID4KPiA+ICsgICAgIF92aXJ0bmV0X3NldF9x
dWV1ZXModmksIHZpLT5jdXJyX3F1ZXVlX3BhaXJzKTsKPiA+ICsKPiA+ICAgICAgIC8qIHNlcmlh
bGl6ZSBuZXRkZXYgcmVnaXN0ZXIgKyB2aXJ0aW9fZGV2aWNlX3JlYWR5KCkgd2l0aCBuZG9fb3Bl
bigpICovCj4gPiAgICAgICBydG5sX2xvY2soKTsKPiA+Cj4gPiBAQCAtNDI1Nyw4ICs0MjU5LDYg
QEAgc3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+
ID4gICAgICAgICAgICAgICBnb3RvIGZyZWVfdW5yZWdpc3Rlcl9uZXRkZXY7Cj4gPiAgICAgICB9
Cj4gPgo+ID4gLSAgICAgdmlydG5ldF9zZXRfcXVldWVzKHZpLCB2aS0+Y3Vycl9xdWV1ZV9wYWly
cyk7Cj4gPiAtCj4gPiAgICAgICAvKiBBc3N1bWUgbGluayB1cCBpZiBkZXZpY2UgY2FuJ3QgcmVw
b3J0IGxpbmsgc3RhdHVzLAo+ID4gICAgICAgICAgb3RoZXJ3aXNlIGdldCBsaW5rIHN0YXR1cyBm
cm9tIGNvbmZpZy4gKi8KPiA+ICAgICAgIG5ldGlmX2NhcnJpZXJfb2ZmKGRldik7Cj4gPiAtLQo+
ID4gMi4zOS4zCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
