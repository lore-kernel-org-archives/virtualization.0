Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF57C7EE22
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 04:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C422F403B4;
	Wed, 10 May 2023 04:05:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C422F403B4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MNfCso/Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k4cPnf7B1_mr; Wed, 10 May 2023 04:05:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3A01E40291;
	Wed, 10 May 2023 04:05:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A01E40291
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 079C0C0036;
	Wed, 10 May 2023 04:05:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20469C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 04:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0AB382022
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 04:05:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0AB382022
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MNfCso/Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4K2B_-cIUX8W
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 04:05:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D4FE81FFD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D4FE81FFD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 04:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683691505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z4Nlt17NcD4TBcFZ5r4aDYoMl3ENzhd2Xf+fmrXbyX8=;
 b=MNfCso/Qcw2aAlUlJv8QWo11rGI4grGnpTcCvagmW5s6qPBIOlFNnWvx2IJMqt6a91L7qR
 eT/IflqObkv1AedinAwhbmZLGyKEo51U3K+Ce7Y02I/dX+9GkcTgeCzVMWvkx+secrCwsX
 NB74+mOMhcp+jQMGbyOwFaryqtldpoE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-QRmzZCrwPnmMSR03o141tA-1; Wed, 10 May 2023 00:05:04 -0400
X-MC-Unique: QRmzZCrwPnmMSR03o141tA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2acd53b376dso21169041fa.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 May 2023 21:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683691502; x=1686283502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z4Nlt17NcD4TBcFZ5r4aDYoMl3ENzhd2Xf+fmrXbyX8=;
 b=fVd1x7S2Bx7sQ6T37jbQM89bQs+0E2B/mLIz3pSOLINvSXsV8cxqZdNOUtNqZ0mCc+
 LZgRkuU+ZnGKqn0wWUuVxqShBntsqj7yhwuI6agckwuMoH1MtwTGLJSM49IfTHyMTByQ
 pHWapKLOXJp6QQfNF/jNVI/wPMjFcnGkchIk2Gsu28yKH3axfNu8w6aLycodSJFNhONB
 /5/gCjNft4IoAhqkoZ5kt1Yv4b9GgGsccjEkr0RNlty4zYtt6YvYa5O2Xvsp7cqYgfav
 j2lKX+WWIw+HfPd2YpyfCL2T5jiEIKCulhG6MyWIhn+qMSCjzgxGiHgKi/CwHHHTruYG
 OcaA==
X-Gm-Message-State: AC+VfDy+J0uIAz32xKblHZl6G8qd9aW+U/Mg9Z6Zv0lv+jnZDTZVQvVD
 lm+xokyI6FPHubt81XWtjoh2eywuwwrrLfIbL1iMV1MRwGBhf+Owf68vRsPH9JYfQpJz6gevCj6
 R62tuiYnnCpaxJfF3Sd3FYPaN0l/y4uJCW2GDjnhLqZMpPsGv3x+vLRueow==
X-Received: by 2002:a2e:7e05:0:b0:2ad:ab12:e4ce with SMTP id
 z5-20020a2e7e05000000b002adab12e4cemr991265ljc.7.1683691502293; 
 Tue, 09 May 2023 21:05:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61XER0BbsIE0Oj6R89yWvvxieAfdCSEO/TD30qyT1tZYfhyh3/Juv1WLBew+wAMjjfqnfqCHSn34db0a4HYZo=
X-Received: by 2002:a2e:7e05:0:b0:2ad:ab12:e4ce with SMTP id
 z5-20020a2e7e05000000b002adab12e4cemr991257ljc.7.1683691501938; Tue, 09 May
 2023 21:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
 <1683689214.9647853-1-xuanzhuo@linux.alibaba.com>
 <20230509233907-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230509233907-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 May 2023 12:04:50 +0800
Message-ID: <CACGkMEujVhZrU2Wa3=-6DAgK5x8suC9EDxMxt5nN3Y1-LAVcUA@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Joerg Roedel <jroedel@suse.de>,
 linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCBNYXkgMTAsIDIwMjMgYXQgMTE6NDTigK9BTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgTWF5IDEwLCAyMDIzIGF0IDExOjI2OjU0
QU0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPiA+IE9uIFdlZCwgMTAgTWF5IDIwMjMgMTA6NTQ6
MzcgKzA4MDAsIHpoZW53ZWkgcGkgPHBpemhlbndlaUBieXRlZGFuY2UuY29tPiB3cm90ZToKPiA+
ID4gQm90aCBzcGxpdCByaW5nIGFuZCBwYWNrZWQgcmluZyB1c2UgMzJiaXRzIHRvIGRlc2NyaWJl
IHRoZSBsZW5ndGggb2YKPiA+ID4gYSBkZXNjcmlwdG9yOiBzZWUgc3RydWN0IHZyaW5nX2Rlc2Mg
YW5kIHN0cnVjdCB2cmluZ19wYWNrZWRfZGVzYy4KPiA+ID4gVGhpcyBtZWFucyB0aGUgbWF4IHNl
Z21lbnQgc2l6ZSBzdXBwb3J0ZWQgYnkgdmlydGlvIGlzIFUzMl9NQVguCj4gPiA+Cj4gPiA+IEFu
IGV4YW1wbGUgb2YgdmlydGlvX21heF9kbWFfc2l6ZSBpbiB2aXJ0aW9fYmxrLmM6Cj4gPiA+ICAg
dTMyIHYsIG1heF9zaXplOwo+ID4gPgo+ID4gPiAgIG1heF9zaXplID0gdmlydGlvX21heF9kbWFf
c2l6ZSh2ZGV2KTsgIC0+IGltcGxpY2l0IGNvbnZlcnQKPiA+ID4gICBlcnIgPSB2aXJ0aW9fY3Jl
YWRfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fQkxLX0ZfU0laRV9NQVgsCj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRpb19ibGtfY29uZmlnLCBzaXplX21heCwgJnYp
Owo+ID4gPiAgIG1heF9zaXplID0gbWluKG1heF9zaXplLCB2KTsKPiA+ID4KPiA+ID4gVGhlcmUg
aXMgYSByaXNrIGR1cmluZyBpbXBsaWNpdCBjb252ZXJ0IGhlcmUsIG9uY2UgdmlydGlvX21heF9k
bWFfc2l6ZQo+ID4gPiByZXR1cm5zIDRHLCBtYXhfc2l6ZSBiZWNvbWVzIDAuCj4gPiA+Cj4gPiA+
IEZpeGVzOiBlNmQ2ZGQ2Yzg3NWUgKCJ2aXJ0aW86IEludHJvZHVjZSB2aXJ0aW9fbWF4X2RtYV9z
aXplKCkiKQo+ID4gPiBDYzogSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+Cj4gPiA+IFNp
Z25lZC1vZmYtYnk6IHpoZW53ZWkgcGkgPHBpemhlbndlaUBieXRlZGFuY2UuY29tPgo+ID4gPiAt
LS0KPiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxMiArKysrKysrKy0tLS0K
PiA+ID4gIGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgfCAgMiArLQo+ID4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gPiA+Cj4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYwo+ID4gPiBpbmRleCBjNTMxMGVhZjhiNDYuLjU1Y2ZlY2YwMzBhMSAxMDA2
NDQKPiA+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+IEBAIC0yODksMTIgKzI4OSwxNiBAQCBz
dGF0aWMgYm9vbCB2cmluZ191c2VfZG1hX2FwaShjb25zdCBzdHJ1Y3QgdmlydGlvX2RldmljZSAq
dmRldikKPiA+ID4gICAgIHJldHVybiBmYWxzZTsKPiA+ID4gIH0KPiA+ID4KPiA+ID4gLXNpemVf
dCB2aXJ0aW9fbWF4X2RtYV9zaXplKGNvbnN0IHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+
ID4gPiArdTMyIHZpcnRpb19tYXhfZG1hX3NpemUoY29uc3Qgc3RydWN0IHZpcnRpb19kZXZpY2Ug
KnZkZXYpCj4gPgo+ID4KPiA+IExHVE0KPiA+Cj4gPiBCdXQsIHNob3VsZCB3ZSBjaGFuZ2UgdGhl
IHBhcmFtZXRlciB0byB2cSwgdGhlbiB1c2UgdGhlIGRtYV9kZXY/Cj4gPgo+ID4gQEphc29uCj4g
Pgo+ID4gVGhhbmtzLgo+ID4KPgo+Cj4gdGhhdCB3b3VsZCBiZSBhbiB1bnJlbGF0ZWQgcmV3b3Jr
LgoKUHJvYmFibHksIGJ1dCBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIGJlIGRvbmUgb24gdG9wIG90
aGVyd2lzZSB3ZSBtYXkgZm9yZ2V0LgoKVGhhbmtzCgo+Cj4gPiA+ICB7Cj4gPiA+IC0gICBzaXpl
X3QgbWF4X3NlZ21lbnRfc2l6ZSA9IFNJWkVfTUFYOwo+ID4gPiArICAgdTMyIG1heF9zZWdtZW50
X3NpemUgPSBVMzJfTUFYOwo+ID4gPgo+ID4gPiAtICAgaWYgKHZyaW5nX3VzZV9kbWFfYXBpKHZk
ZXYpKQo+ID4gPiAtICAgICAgICAgICBtYXhfc2VnbWVudF9zaXplID0gZG1hX21heF9tYXBwaW5n
X3NpemUodmRldi0+ZGV2LnBhcmVudCk7Cj4gPiA+ICsgICBpZiAodnJpbmdfdXNlX2RtYV9hcGko
dmRldikpIHsKPiA+ID4gKyAgICAgICAgICAgc2l6ZV90IG1heF9kbWFfc2l6ZSA9IGRtYV9tYXhf
bWFwcGluZ19zaXplKHZkZXYtPmRldi5wYXJlbnQpOwo+ID4gPiArCj4gPiA+ICsgICAgICAgICAg
IGlmIChtYXhfZG1hX3NpemUgPCBtYXhfc2VnbWVudF9zaXplKQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgIG1heF9zZWdtZW50X3NpemUgPSBtYXhfZG1hX3NpemU7Cj4gPiA+ICsgICB9Cj4gPiA+
Cj4gPiA+ICAgICByZXR1cm4gbWF4X3NlZ21lbnRfc2l6ZTsKPiA+ID4gIH0KPiA+ID4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4g
PiA+IGluZGV4IGI5MzIzOGRiOTRlMy4uMWE2MDVmNDA4MzI5IDEwMDY0NAo+ID4gPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgK
PiA+ID4gQEAgLTE0Nyw3ICsxNDcsNyBAQCBpbnQgdmlydGlvX2RldmljZV9yZXN0b3JlKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICpkZXYpOwo+ID4gPiAgI2VuZGlmCj4gPiA+ICB2b2lkIHZpcnRpb19y
ZXNldF9kZXZpY2Uoc3RydWN0IHZpcnRpb19kZXZpY2UgKmRldik7Cj4gPiA+Cj4gPiA+IC1zaXpl
X3QgdmlydGlvX21heF9kbWFfc2l6ZShjb25zdCBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldik7
Cj4gPiA+ICt1MzIgdmlydGlvX21heF9kbWFfc2l6ZShjb25zdCBzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldik7Cj4gPiA+Cj4gPiA+ICAjZGVmaW5lIHZpcnRpb19kZXZpY2VfZm9yX2VhY2hfdnEo
dmRldiwgdnEpIFwKPiA+ID4gICAgIGxpc3RfZm9yX2VhY2hfZW50cnkodnEsICZ2ZGV2LT52cXMs
IGxpc3QpCj4gPiA+IC0tCj4gPiA+IDIuMjAuMQo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
