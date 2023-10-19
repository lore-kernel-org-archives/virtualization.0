Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29174CDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 06:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0BD04249A;
	Thu, 19 Oct 2023 06:18:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B0BD04249A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FF7PNirw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XbNimMz7mb9d; Thu, 19 Oct 2023 06:17:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B1E59400AF;
	Thu, 19 Oct 2023 06:17:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1E59400AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E385C0071;
	Thu, 19 Oct 2023 06:17:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE8D6C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA27560750
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:17:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA27560750
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FF7PNirw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NURMVbyW_eSP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:17:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A825606A9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:17:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A825606A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697696274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/PuqaXTNUDAuY+PkSea1LqeAPr02g4Cwph0Z+g7436c=;
 b=FF7PNirw+YR1+ulB6TTEmVbrsIAoUgz0nMbr1p2Jve8UAl00n9cElE0dhJ32I2kmKSrV5h
 RLkz/yFydf7ILqWomlqKK8k//ND4bq4m+lKloSX9fNMgI2HPrssyyyiAzlYttFyAG8AKvM
 Gs46IEbSAkwZHlTrqHRuvrLSSEgnZog=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-xjqfO5EZP8iZ3Za8xnRQ5g-1; Thu, 19 Oct 2023 02:17:48 -0400
X-MC-Unique: xjqfO5EZP8iZ3Za8xnRQ5g-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507ce973a03so664874e87.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 23:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697696267; x=1698301067;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/PuqaXTNUDAuY+PkSea1LqeAPr02g4Cwph0Z+g7436c=;
 b=VrfyMQSVaYeW+bhO7M48LX3qYH8R91iFOARVURkPSIzvyIb8UacZUFiqL9NpnHVixa
 +vvtf1QTNv3LmW3ElPUGgT5yNpoG6PhoM2/1crAZi6KD4w/LLTiCsaZcalajMYYmiiKA
 ULtzlWi2CnR/XDybVcyuineczFEji6UoqkVpYKv/nhPyIEI61Uq7BKUKucF34PZAEKxD
 EjXALtP+4YOO34xR5kkbcJ6JrsI7N5cVKoV8sCia+cRP1YSWSJEWQuTogrUA029eCLPO
 uRoi266tcZbucjeCTyiLHfc8x+SxcG6c0TpiDILhN76YACBvuZzdD3jJ5pqbDMbrmToS
 asMg==
X-Gm-Message-State: AOJu0Yy/ry/cDoI4/0qpGRMfdfXYl00QIl9JMrF/JluLr7laTvDFD8H8
 CCaT/eFYJ9ncLLHU1LSlAtki/ilwiFN+kHjU7j1uc0zp6cIO+cy8pHYqrpgtDWuDBInUJlexgxz
 TFtkEMlphKWaOnRgKN9i/4lhRPXyW9ORoeNKXXftJ4SzzpcVZ/zbAW6hDOw==
X-Received: by 2002:a19:ee16:0:b0:507:ab62:48a5 with SMTP id
 g22-20020a19ee16000000b00507ab6248a5mr646490lfb.21.1697696266877; 
 Wed, 18 Oct 2023 23:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHByP6mfsSCluk9sCZUGdaOPomDtr6n3wTg6/xe3nrOw8ffMYgY2ZllbvDXPQDB1aq7nf0tgU5oMzZ6tOpqzqk=
X-Received: by 2002:a19:ee16:0:b0:507:ab62:48a5 with SMTP id
 g22-20020a19ee16000000b00507ab6248a5mr646467lfb.21.1697696266555; Wed, 18 Oct
 2023 23:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Oct 2023 14:17:35 +0800
Message-ID: <CACGkMEsMhapWJAjqQAYiJ5LFbSEojK5Z-W2Ncwg=F+u=xsu-bg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 06/19] virtio_net: separate virtnet_rx_resize()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaCBzZXBhcmF0ZXMgdHdvIHN1Yi1m
dW5jdGlvbnMgZnJvbSB2aXJ0bmV0X3J4X3Jlc2l6ZSgpOgo+Cj4gKiB2aXJ0bmV0X3J4X3BhdXNl
Cj4gKiB2aXJ0bmV0X3J4X3Jlc3VtZQo+Cj4gVGhlbiB0aGUgc3Vic2VxdWVudCByZXNldCByeCBm
b3IgeHNrIGNhbiBzaGFyZSB0aGVzZSB0d28gZnVuY3Rpb25zLgo+Cj4gU2lnbmVkLW9mZi1ieTog
WHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0tLQo+ICBkcml2ZXJzL25ldC92
aXJ0aW8vbWFpbi5jICAgICAgIHwgMjkgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KPiAg
ZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuaCB8ICAzICsrKwo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDI0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvdmlydGlvL21haW4uYyBiL2RyaXZlcnMvbmV0L3ZpcnRpby9tYWluLmMKPiBpbmRl
eCBiYTM4YjYwNzhlMWQuLmU2YjI2MjM0MTYxOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92
aXJ0aW8vbWFpbi5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvL21haW4uYwo+IEBAIC0yMTIw
LDI2ICsyMTIwLDM5IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBzdGFydF94bWl0KHN0cnVjdCBza19i
dWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gICAgICAgICByZXR1cm4gTkVUREVW
X1RYX09LOwo+ICB9Cj4KPiAtc3RhdGljIGludCB2aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1Y3Qgdmly
dG5ldF9pbmZvICp2aSwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0
bmV0X3JxICpycSwgdTMyIHJpbmdfbnVtKQo+ICt2b2lkIHZpcnRuZXRfcnhfcGF1c2Uoc3RydWN0
IHZpcnRuZXRfaW5mbyAqdmksIHN0cnVjdCB2aXJ0bmV0X3JxICpycSkKPiAgewo+ICAgICAgICAg
Ym9vbCBydW5uaW5nID0gbmV0aWZfcnVubmluZyh2aS0+ZGV2KTsKPiAtICAgICAgIGludCBlcnIs
IHFpbmRleDsKPiAtCj4gLSAgICAgICBxaW5kZXggPSBycSAtIHZpLT5ycTsKPgo+ICAgICAgICAg
aWYgKHJ1bm5pbmcpCj4gICAgICAgICAgICAgICAgIG5hcGlfZGlzYWJsZSgmcnEtPm5hcGkpOwo+
ICt9Cj4KPiAtICAgICAgIGVyciA9IHZpcnRxdWV1ZV9yZXNpemUocnEtPnZxLCByaW5nX251bSwg
dmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYpOwo+IC0gICAgICAgaWYgKGVycikKPiAtICAgICAg
ICAgICAgICAgbmV0ZGV2X2Vycih2aS0+ZGV2LCAicmVzaXplIHJ4IGZhaWw6IHJ4IHF1ZXVlIGlu
ZGV4OiAlZCBlcnI6ICVkXG4iLCBxaW5kZXgsIGVycik7Cj4gK3ZvaWQgdmlydG5ldF9yeF9yZXN1
bWUoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHN0cnVjdCB2aXJ0bmV0X3JxICpycSkKPiArewo+
ICsgICAgICAgYm9vbCBydW5uaW5nID0gbmV0aWZfcnVubmluZyh2aS0+ZGV2KTsKPgo+ICAgICAg
ICAgaWYgKCF0cnlfZmlsbF9yZWN2KHZpLCBycSwgR0ZQX0tFUk5FTCkpCj4gICAgICAgICAgICAg
ICAgIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygmdmktPnJlZmlsbCwgMCk7Cj4KPiAgICAgICAgIGlm
IChydW5uaW5nKQo+ICAgICAgICAgICAgICAgICB2aXJ0bmV0X25hcGlfZW5hYmxlKHJxLT52cSwg
JnJxLT5uYXBpKTsKPiArfQo+ICsKPiArc3RhdGljIGludCB2aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1
Y3QgdmlydG5ldF9pbmZvICp2aSwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCB2aXJ0bmV0X3JxICpycSwgdTMyIHJpbmdfbnVtKQo+ICt7Cj4gKyAgICAgICBpbnQgZXJyLCBx
aW5kZXg7Cj4gKwo+ICsgICAgICAgcWluZGV4ID0gcnEgLSB2aS0+cnE7Cj4gKwo+ICsgICAgICAg
dmlydG5ldF9yeF9wYXVzZSh2aSwgcnEpOwo+ICsKPiArICAgICAgIGVyciA9IHZpcnRxdWV1ZV9y
ZXNpemUocnEtPnZxLCByaW5nX251bSwgdmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYpOwo+ICsg
ICAgICAgaWYgKGVycikKPiArICAgICAgICAgICAgICAgbmV0ZGV2X2Vycih2aS0+ZGV2LCAicmVz
aXplIHJ4IGZhaWw6IHJ4IHF1ZXVlIGluZGV4OiAlZCBlcnI6ICVkXG4iLCBxaW5kZXgsIGVycik7
Cj4gKwo+ICsgICAgICAgdmlydG5ldF9yeF9yZXN1bWUodmksIHJxKTsKPiAgICAgICAgIHJldHVy
biBlcnI7Cj4gIH0KPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW8vdmlydGlvX25l
dC5oIGIvZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuaAo+IGluZGV4IDI4MjUwNGQ2NjM5
YS4uNzBlZWEyM2FkYmE2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpby92aXJ0aW9f
bmV0LmgKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW8vdmlydGlvX25ldC5oCj4gQEAgLTI1Myw0
ICsyNTMsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgdmlydG5ldF9pc194ZHBfcmF3X2J1ZmZlcl9x
dWV1ZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwgaW50Cj4gICAgICAgICBlbHNlCj4gICAgICAg
ICAgICAgICAgIHJldHVybiBmYWxzZTsKPiAgfQo+ICsKPiArdm9pZCB2aXJ0bmV0X3J4X3BhdXNl
KHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1Y3QgdmlydG5ldF9ycSAqcnEpOwo+ICt2b2lk
IHZpcnRuZXRfcnhfcmVzdW1lKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1Y3QgdmlydG5l
dF9ycSAqcnEpOwo+ICAjZW5kaWYKPiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
