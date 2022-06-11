Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0607C433EF
	for <virtualization@archiver.kernel.org>; Sat, 11 Jun 2022 00:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6044C403C4;
	Sat, 11 Jun 2022 00:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qN8xi13sQARi; Sat, 11 Jun 2022 00:35:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E32E640104;
	Sat, 11 Jun 2022 00:35:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A887DC0032;
	Sat, 11 Jun 2022 00:35:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97D0BC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 00:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 766994196E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 00:35:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DN9jAQ6k9Rl4
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 00:35:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 05E2741729
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 00:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654907720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3QqBXlVzdxEx7BVrX2Bp0zht9XaGuyMHHWNPN3fZElE=;
 b=Tl+UnIDj6TUYpQogoD0LCAehc/2flXoyr/SPsNOhbbLBkFWPukD1cPQ7c80NEbMfmewYjb
 yeTua+kMXyDA1X8sgH0PkP9ZkscONgLEaUiv31g1F+NC7tSG2VEWZeUgG/s6P9gW8tQKcb
 KW3yltTays7Phvq76vq5/mxNGgccung=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-5NZlWhv9N_ObS23veldz2g-1; Fri, 10 Jun 2022 20:35:18 -0400
X-MC-Unique: 5NZlWhv9N_ObS23veldz2g-1
Received: by mail-ed1-f72.google.com with SMTP id
 t14-20020a056402020e00b0042bd6f4467cso437666edv.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 17:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3QqBXlVzdxEx7BVrX2Bp0zht9XaGuyMHHWNPN3fZElE=;
 b=ApXwMM4Nctf2mHwMsA0JqPrFyqYj6L+cAbMZJmmSsH4cdrD/3GN5/r7DVjzTASm1n6
 ph224gH0QwFC0Oh4BFshZ3mxZtNMw1PShX1l6zrq+afah8kpWoxrpRsFrhcwQ7Ce5KMd
 J2zXgpn17F3jSv9fXuzwtlriuGZUdBm5P8A8IrZqfL/wfEo4ej9eVKJFpNdrO2yN/yAI
 iOVmt3wozNf+am/1QRasAnXdu/EGtNe4NT80hbZaUqkJf3ipuhN7YX/sRPKLplS1TMFH
 njMSr3usbJrfvvagrtr7f3JnFUJjEO9b9RJB5T5SeT4KoZ/DPNinWKo4w/K6+oM33Vp9
 xHzA==
X-Gm-Message-State: AOAM531ATu43QoVW+tdVgWG858jn3p3EYP5HokB2GT7LhhZuHVSZoCo3
 qrBTTz2uctHrqfppCfSQwS5tP82khxQenyO72zZlYTbinthtcR2vMU8eH3Q9bOOYyQtzsow+bCA
 ec5WWB3vJP2HEj6M4MdtZcmZ0BLtW5toDrK5uZM0LOA==
X-Received: by 2002:a05:6402:330:b0:42d:cd47:89f3 with SMTP id
 q16-20020a056402033000b0042dcd4789f3mr52845943edw.301.1654907717003; 
 Fri, 10 Jun 2022 17:35:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkIVWCoMSdsb1OKxkaz+CMYUGtwEWs4yGvx6Woly7qGBlOcW4hvO+IZNXI/C1nQKh3T6auwA==
X-Received: by 2002:a05:6402:330:b0:42d:cd47:89f3 with SMTP id
 q16-20020a056402033000b0042dcd4789f3mr52845931edw.301.1654907716770; 
 Fri, 10 Jun 2022 17:35:16 -0700 (PDT)
Received: from redhat.com ([212.116.178.142]) by smtp.gmail.com with ESMTPSA id
 i27-20020a50871b000000b0042dcbc3f302sm417601edb.36.2022.06.10.17.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jun 2022 17:35:16 -0700 (PDT)
Date: Fri, 10 Jun 2022 20:35:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Subject: Re: [External] Re: [PATCH] virtio_ring : fix vring_packed_desc
 memory out of bounds bug
Message-ID: <20220610203449-mutt-send-email-mst@kernel.org>
References: <20220610103314.61577-1-huangjie.albert@bytedance.com>
 <20220610103905-mutt-send-email-mst@kernel.org>
 <CABKxMyPTLJ0bbxb23C_aeucVEP8MYNiFz1y9d8eGA4Bvdyey3g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABKxMyPTLJ0bbxb23C_aeucVEP8MYNiFz1y9d8eGA4Bvdyey3g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

T24gU2F0LCBKdW4gMTEsIDIwMjIgYXQgMTI6Mzg6MTBBTSArMDgwMCwg6buE5p2wIHdyb3RlOgo+
ID4gVGhpcyBwYXR0ZXJuIHdhcyBhbHdheXMgaWZmeSwgYnV0IEkgZG9uJ3QgdGhpbmsgdGhlIHBh
dGNoCj4gPiBpbXByb3ZlcyB0aGUgc2l0dWF0aW9uIG11Y2guIGxhc3RfdXNlZF9pZHggYW5kIHZx
LT5wYWNrZWQudXNlZF93cmFwX2NvdW50ZXIKPiA+IGNhbiBzdGlsbCBnZXQgb3V0IG9mIHN5bmMu
Cj4gCj4gWWVz77yMIFlvdSBhcmUgYWJzb2x1dGVseSBjb3JyZWN0LCB0aGFua3MgZm9yIHBvaW50
aW5nIG91dCB0aGlzIGlzc3VlLCBJCj4gZGlkbid0IHRha2UgdGhhdCBpbnRvIGNvbnNpZGVyYXRp
b24sCj4gaG93IGFib3V0IGRpc2FibGluZyBpbnRlcnJ1cHRzIGJlZm9yZSB0aGlzIGNvZGUgYmVs
b3c6Cj4gCj4gPiB2cS0+bGFzdF91c2VkX2lkeCArPSB2cS0+cGFja2VkLmRlc2Nfc3RhdGVbaWRd
Lm51bTsKPiA+IGlmICh1bmxpa2VseSh2cS0+bGFzdF91c2VkX2lkeCA+PSB2cS0+cGFja2VkLnZy
aW5nLm51bSkpIHsKPiA+ICAgICAgICAgIHZxLT5sYXN0X3VzZWRfaWR4IC09IHZxLT5wYWNrZWQu
dnJpbmcubnVtOwo+ID4gICAgICAgICAgdnEtPnBhY2tlZC51c2VkX3dyYXBfY291bnRlciBePSAx
Owo+ID4gfQo+IAo+IGl0IHNlZW1zIHRvIGJlIGZpbmUgdG8ganVzdCB0dXJuIG9mZiB0aGUgaW50
ZXJydXB0cyBvZiB0aGUgY3VycmVudCB2cmluZy4KPiAKPiBCUgoKVGhhdCB3b3VsZCBtYWtlIGRh
dGFwYXRoIHNpZ25pZmljYW50bHkgc2xvd2VyLgoKPiAKPiBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiDkuo4yMDIy5bm0NuaciDEw5pel5ZGo5LqUIDIyOjUw5YaZ6YGT77yaCj4g
Pgo+ID4gT24gRnJpLCBKdW4gMTAsIDIwMjIgYXQgMDY6MzM6MTRQTSArMDgwMCwgaHVhbmdqaWUu
YWxiZXJ0IHdyb3RlOgo+ID4gPiBrc29mdGlycWQgbWF5IGNvbnN1bWUgdGhlIHBhY2tldCBhbmQg
aXQgd2lsbCBjYWxsOgo+ID4gPiB2aXJ0bmV0X3BvbGwKPiA+ID4gICAgICAgLS0+dmlydG5ldF9y
ZWNlaXZlCj4gPiA+ICAgICAgICAgICAgICAgLS0+dmlydHF1ZXVlX2dldF9idWZfY3R4Cj4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAtLT52aXJ0cXVldWVfZ2V0X2J1Zl9jdHhfcGFja2VkCj4g
PiA+IGFuZCBpbiB2aXJ0cXVldWVfZ2V0X2J1Zl9jdHhfcGFja2VkOgo+ID4gPgo+ID4gPiB2cS0+
bGFzdF91c2VkX2lkeCArPSB2cS0+cGFja2VkLmRlc2Nfc3RhdGVbaWRdLm51bTsKPiA+ID4gaWYg
KHVubGlrZWx5KHZxLT5sYXN0X3VzZWRfaWR4ID49IHZxLT5wYWNrZWQudnJpbmcubnVtKSkgewo+
ID4gPiAgICAgICAgICB2cS0+bGFzdF91c2VkX2lkeCAtPSB2cS0+cGFja2VkLnZyaW5nLm51bTsK
PiA+ID4gICAgICAgICAgdnEtPnBhY2tlZC51c2VkX3dyYXBfY291bnRlciBePSAxOwo+ID4gPiB9
Cj4gPiA+Cj4gPiA+IGlmIGF0IHRoZSBzYW1lIHRpbWUsIHRoZXJlIGNvbWVzIGEgdnJpbmcgaW50
ZXJydXB077yMaW4gdnJpbmdfaW50ZXJydXB0Ogo+ID4gPiB3ZSB3aWxsIGNhbGw6Cj4gPiA+IHZy
aW5nX2ludGVycnVwdAo+ID4gPiAgICAgICAtLT5tb3JlX3VzZWQKPiA+ID4gICAgICAgICAgICAg
ICAtLT5tb3JlX3VzZWRfcGFja2VkCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAtLT5pc191
c2VkX2Rlc2NfcGFja2VkCj4gPiA+IGluIGlzX3VzZWRfZGVzY19wYWNrZWQsIHRoZSBsYXN0X3Vz
ZWRfaWR4IG1heWJlID49IHZxLT5wYWNrZWQudnJpbmcubnVtLgo+ID4gPiBzbyB0aGlzIGNvdWxk
IGNhc2UgYSBtZW1vcnkgb3V0IG9mIGJvdW5kcyBidWcuCj4gPiA+Cj4gPiA+IHRoaXMgcGF0Y2gg
aXMgdG8gZml4IHRoaXMuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IGh1YW5namllLmFsYmVy
dCA8aHVhbmdqaWUuYWxiZXJ0QGJ5dGVkYW5jZS5jb20+Cj4gPgo+ID4KPiA+IFRoaXMgcGF0dGVy
biB3YXMgYWx3YXlzIGlmZnksIGJ1dCBJIGRvbid0IHRoaW5rIHRoZSBwYXRjaAo+ID4gaW1wcm92
ZXMgdGhlIHNpdHVhdGlvbiBtdWNoLiBsYXN0X3VzZWRfaWR4IGFuZCB2cS0+cGFja2VkLnVzZWRf
d3JhcF9jb3VudGVyCj4gPiBjYW4gc3RpbGwgZ2V0IG91dCBvZiBzeW5jLgo+ID4KPiA+IE1heWJl
IHJlZmFjdG9yIGNvZGUgdG8ga2VlcCBldmVyeXRoaW5nIGluIHZxLT5sYXN0X3VzZWRfaWR4Pwo+
ID4KPiA+IEphc29uIHdoYXQgaXMgeW91ciB0YWtlPwo+ID4KPiA+Cj4gPgo+ID4KPiA+Cj4gPiA+
IC0tLQo+ID4gPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDMgKysrCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ID4gPiBpbmRleCAxM2E3MzQ4Y2VkZmYuLmQyYWJiYjNhODE4NyAxMDA2NDQKPiA+ID4gLS0t
IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiArKysgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gPiA+IEBAIC0xMzk3LDYgKzEzOTcsOSBAQCBzdGF0aWMgaW5saW5l
IGJvb2wgaXNfdXNlZF9kZXNjX3BhY2tlZChjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2
cSwKPiA+ID4gICAgICAgYm9vbCBhdmFpbCwgdXNlZDsKPiA+ID4gICAgICAgdTE2IGZsYWdzOwo+
ID4gPgo+ID4gPiArICAgICBpZiAoaWR4ID49IHZxLT5wYWNrZWQudnJpbmcubnVtKQo+ID4gPiAr
ICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKPiA+ID4gKwo+ID4gPiAgICAgICBmbGFncyA9IGxl
MTZfdG9fY3B1KHZxLT5wYWNrZWQudnJpbmcuZGVzY1tpZHhdLmZsYWdzKTsKPiA+ID4gICAgICAg
YXZhaWwgPSAhIShmbGFncyAmICgxIDw8IFZSSU5HX1BBQ0tFRF9ERVNDX0ZfQVZBSUwpKTsKPiA+
ID4gICAgICAgdXNlZCA9ICEhKGZsYWdzICYgKDEgPDwgVlJJTkdfUEFDS0VEX0RFU0NfRl9VU0VE
KSk7Cj4gPiA+IC0tCj4gPiA+IDIuMjcuMAo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
