Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6C8CDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 04:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3CA340193;
	Thu, 19 Oct 2023 04:17:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3CA340193
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UVYKOIlu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3zADmGYxxqsn; Thu, 19 Oct 2023 04:17:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2B13D41D0B;
	Thu, 19 Oct 2023 04:17:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B13D41D0B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01475C0071;
	Thu, 19 Oct 2023 04:17:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13C6BC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 04:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCE266FA6F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 04:17:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DCE266FA6F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UVYKOIlu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pV_-9OS8WAms
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 04:17:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CEDCA6FA79
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 04:17:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CEDCA6FA79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697689037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KkTsB++L+7i7UU1Yoshrhi1BDk79q1+A3Ig7HjEAKaw=;
 b=UVYKOIluqDo9VqNy1gmiEPkhn8y3IZjcDjg6cU80WJ6zr1CuKmBpnyOuVfN5hrsDX5cQ0P
 AOxjFB2nGMlU+jusj+BR3EHDh3GD+CX95xoGzsDbjBg1aGty9HjTP5uI/WwWx4FqKalgf9
 WjWFWvM7K3RiU2BCv5Z3Dtvc8smEMy0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-RpJb1K3uMpqxhZwSI851wg-1; Thu, 19 Oct 2023 00:17:16 -0400
X-MC-Unique: RpJb1K3uMpqxhZwSI851wg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507cf807323so194589e87.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 21:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697689034; x=1698293834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkTsB++L+7i7UU1Yoshrhi1BDk79q1+A3Ig7HjEAKaw=;
 b=XIflQ7L/zLHzMFn6rioYcuTmAIcXkKBnI49XcwAvgiFGQGgI9bCQc4RK7XnyFpDxqc
 YeUg1qNTUCoiXwSG2PEauihPPzozQXAs1gI5q45vM6yk+5U+3qtETlAPHwYXBixMF/db
 8kT9CZf7MdFWY92pXZ7t6+Ah6WgdO6hCyiMyNOFEz2rnMRUpS+fYvD4yVNNDne77uv0E
 9DkXgfVgq8RYuD9gPXREWP8dD9HRtdmgRGviMJahI1dz6m8M3HKM0XA1AtoQZIAbByQK
 4MwSCc7alJZ0NGCm7GW7msRoM7AVIkS3lkC2VV8PbZ8qVDP65Jlz5ITsX+RTuqGVJ55c
 kXiw==
X-Gm-Message-State: AOJu0Yy9SS/JGJ/HqXARLLf3ngTO/3+k2cLexYdkP0PBZ6DXgrFHZ2hk
 dKcC7Zv7lP35ilAOP0nujP1xCIUzET7mZcnfr+R/JTsdDG7tCjGFtZNbeiH/Y9KkP10hw4aEMKJ
 sxUqmhylJy8Dn/P4I3rYYIUFWqNbqKTy7RPPWYPdt4IHoECm4KbO/RpiKFw==
X-Received: by 2002:a05:6512:3c99:b0:504:33cd:ad1 with SMTP id
 h25-20020a0565123c9900b0050433cd0ad1mr205996lfv.27.1697689034569; 
 Wed, 18 Oct 2023 21:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfUGZ0KgN83ChsxOZDC1tVe9D8W4LROZWc0NwAIHQ4POZXJoKA9TotA+ytmBZT+6J9VOoYZT2zJ5oG4swkEF4=
X-Received: by 2002:a05:6512:3c99:b0:504:33cd:ad1 with SMTP id
 h25-20020a0565123c9900b0050433cd0ad1mr205982lfv.27.1697689034175; Wed, 18 Oct
 2023 21:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Oct 2023 12:17:03 +0800
Message-ID: <CACGkMEuU9Ek-01wf0vf82pF=+1SKbjVpykLFdboDioA-CaSV8w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 01/19] virtio_net: rename free_old_xmit_skbs
 to free_old_xmit
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
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gU2luY2UgZnJlZV9vbGRfeG1pdF9za2JzIG5vdCBv
bmx5IGRlYWxzIHdpdGggc2tiLCBidXQgYWxzbyB4ZHAgZnJhbWUgYW5kCj4gc3Vic2VxdWVudCBh
ZGRlZCB4c2ssIHNvIGNoYW5nZSB0aGUgbmFtZSBvZiB0aGlzIGZ1bmN0aW9uIHRvCj4gZnJlZV9v
bGRfeG1pdC4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRo
YW5rcwoKPiAtLS0KPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMTAgKysrKystLS0tLQo+
ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+IGluZGV4IGZlN2YzMTRkNjVjOS4uM2Q4NzM4NmQ4MjIwIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+
IEBAIC03NDQsNyArNzQ0LDcgQEAgc3RhdGljIHZvaWQgdmlydG5ldF9ycV9zZXRfcHJlbWFwcGVk
KHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+ICAgICAgICAgfQo+ICB9Cj4KPiAtc3RhdGljIHZv
aWQgZnJlZV9vbGRfeG1pdF9za2JzKHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwgYm9vbCBpbl9uYXBp
KQo+ICtzdGF0aWMgdm9pZCBmcmVlX29sZF94bWl0KHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwgYm9v
bCBpbl9uYXBpKQo+ICB7Cj4gICAgICAgICB1bnNpZ25lZCBpbnQgbGVuOwo+ICAgICAgICAgdW5z
aWduZWQgaW50IHBhY2tldHMgPSAwOwo+IEBAIC04MTYsNyArODE2LDcgQEAgc3RhdGljIHZvaWQg
Y2hlY2tfc3FfZnVsbF9hbmRfZGlzYWJsZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRxdWV1ZV9uYXBpX3NjaGVkdWxlKCZzcS0+
bmFwaSwgc3EtPnZxKTsKPiAgICAgICAgICAgICAgICAgfSBlbHNlIGlmICh1bmxpa2VseSghdmly
dHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkKHNxLT52cSkpKSB7Cj4gICAgICAgICAgICAgICAgICAg
ICAgICAgLyogTW9yZSBqdXN0IGdvdCB1c2VkLCBmcmVlIHRoZW0gdGhlbiByZWNoZWNrLiAqLwo+
IC0gICAgICAgICAgICAgICAgICAgICAgIGZyZWVfb2xkX3htaXRfc2ticyhzcSwgZmFsc2UpOwo+
ICsgICAgICAgICAgICAgICAgICAgICAgIGZyZWVfb2xkX3htaXQoc3EsIGZhbHNlKTsKPiAgICAg
ICAgICAgICAgICAgICAgICAgICBpZiAoc3EtPnZxLT5udW1fZnJlZSA+PSAyK01BWF9TS0JfRlJB
R1MpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5ldGlmX3N0YXJ0X3N1YnF1
ZXVlKGRldiwgcW51bSk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0cXVl
dWVfZGlzYWJsZV9jYihzcS0+dnEpOwo+IEBAIC0yMTI0LDcgKzIxMjQsNyBAQCBzdGF0aWMgdm9p
ZCB2aXJ0bmV0X3BvbGxfY2xlYW50eChzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEpCj4KPiAgICAg
ICAgICAgICAgICAgZG8gewo+ICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRxdWV1ZV9kaXNh
YmxlX2NiKHNxLT52cSk7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgZnJlZV9vbGRfeG1pdF9z
a2JzKHNxLCB0cnVlKTsKPiArICAgICAgICAgICAgICAgICAgICAgICBmcmVlX29sZF94bWl0KHNx
LCB0cnVlKTsKPiAgICAgICAgICAgICAgICAgfSB3aGlsZSAodW5saWtlbHkoIXZpcnRxdWV1ZV9l
bmFibGVfY2JfZGVsYXllZChzcS0+dnEpKSk7Cj4KPiAgICAgICAgICAgICAgICAgaWYgKHNxLT52
cS0+bnVtX2ZyZWUgPj0gMiArIE1BWF9TS0JfRlJBR1MpCj4gQEAgLTIyNDYsNyArMjI0Niw3IEBA
IHN0YXRpYyBpbnQgdmlydG5ldF9wb2xsX3R4KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50
IGJ1ZGdldCkKPiAgICAgICAgIHR4cSA9IG5ldGRldl9nZXRfdHhfcXVldWUodmktPmRldiwgaW5k
ZXgpOwo+ICAgICAgICAgX19uZXRpZl90eF9sb2NrKHR4cSwgcmF3X3NtcF9wcm9jZXNzb3JfaWQo
KSk7Cj4gICAgICAgICB2aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+dnEpOwo+IC0gICAgICAgZnJl
ZV9vbGRfeG1pdF9za2JzKHNxLCB0cnVlKTsKPiArICAgICAgIGZyZWVfb2xkX3htaXQoc3EsIHRy
dWUpOwo+Cj4gICAgICAgICBpZiAoc3EtPnZxLT5udW1fZnJlZSA+PSAyICsgTUFYX1NLQl9GUkFH
UykKPiAgICAgICAgICAgICAgICAgbmV0aWZfdHhfd2FrZV9xdWV1ZSh0eHEpOwo+IEBAIC0yMzM2
LDcgKzIzMzYsNyBAQCBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ICAgICAgICAgICAgICAgICBpZiAodXNl
X25hcGkpCj4gICAgICAgICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3Et
PnZxKTsKPgo+IC0gICAgICAgICAgICAgICBmcmVlX29sZF94bWl0X3NrYnMoc3EsIGZhbHNlKTsK
PiArICAgICAgICAgICAgICAgZnJlZV9vbGRfeG1pdChzcSwgZmFsc2UpOwo+Cj4gICAgICAgICB9
IHdoaWxlICh1c2VfbmFwaSAmJiBraWNrICYmCj4gICAgICAgICAgICAgICAgdW5saWtlbHkoIXZp
cnRxdWV1ZV9lbmFibGVfY2JfZGVsYXllZChzcS0+dnEpKSk7Cj4gLS0KPiAyLjMyLjAuMy5nMDEx
OTVjZjlmCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
