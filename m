Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B030C19F2D
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 04:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77D1F81980;
	Wed, 27 Jul 2022 04:37:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 77D1F81980
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KDMXYbcD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S6gJcLcAwXL3; Wed, 27 Jul 2022 04:37:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C2E5B81975;
	Wed, 27 Jul 2022 04:37:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2E5B81975
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 962ECC0035;
	Wed, 27 Jul 2022 04:37:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8D63C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A63B781980
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:37:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A63B781980
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UGENbXmCixAH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:37:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6B8B81975
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B6B8B81975
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658896661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eglJXh28UWwMt7nfBux4PPlOeAEHThKdFwbJ4et/2A8=;
 b=KDMXYbcDiB7Ovgd+MI+K7xaBbNi7yacHpY1GoMG1w1bZR9EHU3UIQwWosku1d0XlbFfEfM
 LIclddEpErPX5YDJWz3/qNH1oLz2Qbn/JRCJLLtpeJSsPciYp/WE6LLN6dAWPi8/33hw3Q
 E8FKgOhlzNzSNh5ZjgCtTCFaHT0UZZM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-2S_7lpIIM3iDYpG_iJSwiQ-1; Wed, 27 Jul 2022 00:37:39 -0400
X-MC-Unique: 2S_7lpIIM3iDYpG_iJSwiQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 j10-20020a62b60a000000b0052b30f6626bso5521568pff.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 21:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=eglJXh28UWwMt7nfBux4PPlOeAEHThKdFwbJ4et/2A8=;
 b=407i3eSnk+1i+FBGq1xpC08RMS78esy+XsOzckGwxJpfSwgxs3izHYN62Y8vvFe48w
 GlrtRYFTBb6zsvsc7Xuk1nPSkJ7r3cE2dcSGl2vEfS/onX38lt2nZa55sYMgDa8wpYiT
 p2qSQwPLg/k7N8a65cgNZnBB+UDTJZyODRAa2ShoAT6jKePn0xMCO5JVJF8kTQLh/U49
 kiCn0UWY5ST7i5XGZOIRJHbWA4TiDVVOM5fKg+T4Fjcztyi0rQx3xYVmPqIbK6zC1alW
 CztLr7o/luIs9fNf1RzkEKOT9zcP+YE/dtcGrdus135B514fIi5LUMm2NOeUf4kKQP/X
 C3xg==
X-Gm-Message-State: AJIora85VB5PP+lrzoGOG3kSaWm6JDF+ljbw0tgBaoqkGTlbR3PggPyu
 i4p14LPUmhMwJr4C9KaLh7++zP7EbPgyeetttxGR7sucmxvN8kAMR/gUhffViVW3IKRB+HToOco
 hCIjy2wgKa7m4v7zV7cMF8zSro2cbXKYQMNCHl6Z/EA==
X-Received: by 2002:a17:90b:4c51:b0:1f2:46b2:7c28 with SMTP id
 np17-20020a17090b4c5100b001f246b27c28mr2510320pjb.231.1658896658012; 
 Tue, 26 Jul 2022 21:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tcSW0SH/oE3E1QIJ9xZXlmolMaePDPPfBCRfkcaVWN7oKvG/J6RPnSNe2Qq4YMnD3xbv2vjg==
X-Received: by 2002:a17:90b:4c51:b0:1f2:46b2:7c28 with SMTP id
 np17-20020a17090b4c5100b001f246b27c28mr2510272pjb.231.1658896657718; 
 Tue, 26 Jul 2022 21:37:37 -0700 (PDT)
Received: from [10.72.12.96] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a170902e84400b0016a0bf0ce32sm12698532plg.70.2022.07.26.21.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jul 2022 21:37:30 -0700 (PDT)
Message-ID: <980553b7-ba12-bcdf-0be0-8f3da5985441@redhat.com>
Date: Wed, 27 Jul 2022 12:37:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 32/42] virtio_pci: support VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-33-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-33-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 kangjie.xu@linux.alibaba.com, Heiko Carstens <hca@linux.ibm.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzcvMjYgMTU6MjIsIFh1YW4gWmh1byDlhpnpgZM6Cj4gVGhpcyBwYXRjaCBpbXBs
ZW1lbnRzIHZpcnRpbyBwY2kgc3VwcG9ydCBmb3IgUVVFVUUgUkVTRVQuCj4KPiBQZXJmb3JtaW5n
IHJlc2V0IG9uIGEgcXVldWUgaXMgZGl2aWRlZCBpbnRvIHRoZXNlIHN0ZXBzOgo+Cj4gICAxLiBu
b3RpZnkgdGhlIGRldmljZSB0byByZXNldCB0aGUgcXVldWUKPiAgIDIuIHJlY3ljbGUgdGhlIGJ1
ZmZlciBzdWJtaXR0ZWQKPiAgIDMuIHJlc2V0IHRoZSB2cmluZyAobWF5IHJlLWFsbG9jKQo+ICAg
NC4gbW1hcCB2cmluZyB0byBkZXZpY2UsIGFuZCBlbmFibGUgdGhlIHF1ZXVlCj4KPiBUaGlzIHBh
dGNoIGltcGxlbWVudHMgdmlydGlvX3Jlc2V0X3ZxKCksIHZpcnRpb19lbmFibGVfcmVzZXRxKCkg
aW4gdGhlCj4gcGNpIHNjZW5hcmlvLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFu
emh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24u
YyB8IDEyICsrKy0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgfCA4OCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgOTcgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcGNpX2NvbW1vbi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24u
Ywo+IGluZGV4IGNhNTFmY2M5ZGFhYi4uYWQyNThhOWQzYjlmIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX2NvbW1vbi5jCj4gQEAgLTIxNCw5ICsyMTQsMTUgQEAgc3RhdGljIHZvaWQgdnBfZGVs
X3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+ICAgCXN0cnVjdCB2aXJ0aW9fcGNpX3ZxX2luZm8g
KmluZm8gPSB2cF9kZXYtPnZxc1t2cS0+aW5kZXhdOwo+ICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7
Cj4gICAKPiAtCXNwaW5fbG9ja19pcnFzYXZlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiAtCWxp
c3RfZGVsKCZpbmZvLT5ub2RlKTsKPiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnZwX2Rldi0+
bG9jaywgZmxhZ3MpOwo+ICsJLyoKPiArCSAqIElmIGl0IGZhaWxzIGR1cmluZyByZS1lbmFibGUg
cmVzZXQgdnEuIFRoaXMgd2F5IHdlIHdvbid0IHJlam9pbgo+ICsJICogaW5mby0+bm9kZSB0byB0
aGUgcXVldWUuIFByZXZlbnQgdW5leHBlY3RlZCBpcnFzLgo+ICsJICovCj4gKwlpZiAoIXZxLT5y
ZXNldCkgewo+ICsJCXNwaW5fbG9ja19pcnFzYXZlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiAr
CQlsaXN0X2RlbCgmaW5mby0+bm9kZSk7Cj4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdnBf
ZGV2LT5sb2NrLCBmbGFncyk7Cj4gKwl9Cj4gICAKPiAgIAl2cF9kZXYtPmRlbF92cShpbmZvKTsK
PiAgIAlrZnJlZShpbmZvKTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9tb2Rlcm4uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiBpbmRleCA5
MDQxZDlhNDFiN2QuLmMzYjlmMjc2MTg0OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcGNpX21vZGVybi5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rl
cm4uYwo+IEBAIC0zNCw2ICszNCw5IEBAIHN0YXRpYyB2b2lkIHZwX3RyYW5zcG9ydF9mZWF0dXJl
cyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdTY0IGZlYXR1cmVzKQo+ICAgCWlmICgoZmVh
dHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX1NSX0lPVikpICYmCj4gICAJCQlwY2lfZmluZF9leHRf
Y2FwYWJpbGl0eShwY2lfZGV2LCBQQ0lfRVhUX0NBUF9JRF9TUklPVikpCj4gICAJCV9fdmlydGlv
X3NldF9iaXQodmRldiwgVklSVElPX0ZfU1JfSU9WKTsKPiArCj4gKwlpZiAoZmVhdHVyZXMgJiBC
SVRfVUxMKFZJUlRJT19GX1JJTkdfUkVTRVQpKQo+ICsJCV9fdmlydGlvX3NldF9iaXQodmRldiwg
VklSVElPX0ZfUklOR19SRVNFVCk7Cj4gICB9Cj4gICAKPiAgIC8qIHZpcnRpbyBjb25maWctPmZp
bmFsaXplX2ZlYXR1cmVzKCkgaW1wbGVtZW50YXRpb24gKi8KPiBAQCAtMTk5LDYgKzIwMiw4NyBA
QCBzdGF0aWMgaW50IHZwX2FjdGl2ZV92cShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdTE2IG1zaXhf
dmVjKQo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBpbnQgdnBfbW9kZXJuX2Rp
c2FibGVfdnFfYW5kX3Jlc2V0KHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+ICt7Cj4gKwlzdHJ1Y3Qg
dmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldiA9IHRvX3ZwX2RldmljZSh2cS0+dmRldik7Cj4gKwlz
dHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2ID0gJnZwX2Rldi0+bWRldjsKPiAr
CXN0cnVjdCB2aXJ0aW9fcGNpX3ZxX2luZm8gKmluZm87Cj4gKwl1bnNpZ25lZCBsb25nIGZsYWdz
Owo+ICsKPiArCWlmICghdmlydGlvX2hhc19mZWF0dXJlKHZxLT52ZGV2LCBWSVJUSU9fRl9SSU5H
X1JFU0VUKSkKPiArCQlyZXR1cm4gLUVOT0VOVDsKPiArCj4gKwl2cF9tb2Rlcm5fc2V0X3F1ZXVl
X3Jlc2V0KG1kZXYsIHZxLT5pbmRleCk7Cj4gKwo+ICsJaW5mbyA9IHZwX2Rldi0+dnFzW3ZxLT5p
bmRleF07Cj4gKwo+ICsJLyogZGVsZXRlIHZxIGZyb20gaXJxIGhhbmRsZXIgKi8KPiArCXNwaW5f
bG9ja19pcnFzYXZlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiArCWxpc3RfZGVsKCZpbmZvLT5u
b2RlKTsKPiArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnZwX2Rldi0+bG9jaywgZmxhZ3MpOwo+
ICsKPiArCUlOSVRfTElTVF9IRUFEKCZpbmZvLT5ub2RlKTsKPiArCj4gKyNpZmRlZiBDT05GSUdf
VklSVElPX0hBUkRFTl9OT1RJRklDQVRJT04KPiArCV9fdmlydHF1ZXVlX2JyZWFrKHZxKTsKPiAr
I2VuZGlmCj4gKwo+ICsJLyogRm9yIHRoZSBjYXNlIHdoZXJlIHZxIGhhcyBhbiBleGNsdXNpdmUg
aXJxLCBjYWxsIHN5bmNocm9uaXplX2lycSgpIHRvCj4gKwkgKiB3YWl0IGZvciBjb21wbGV0aW9u
Lgo+ICsJICoKPiArCSAqIG5vdGU6IFdlIGNhbid0IHVzZSBkaXNhYmxlX2lycSgpIHNpbmNlIGl0
IGNvbmZsaWN0cyB3aXRoIHRoZSBhZmZpbml0eQo+ICsJICogbWFuYWdlZCBJUlEgdGhhdCBpcyB1
c2VkIGJ5IHNvbWUgZHJpdmVycy4KPiArCSAqLwo+ICsJaWYgKHZwX2Rldi0+cGVyX3ZxX3ZlY3Rv
cnMgJiYgaW5mby0+bXNpeF92ZWN0b3IgIT0gVklSVElPX01TSV9OT19WRUNUT1IpCj4gKwkJc3lu
Y2hyb25pemVfaXJxKHBjaV9pcnFfdmVjdG9yKHZwX2Rldi0+cGNpX2RldiwgaW5mby0+bXNpeF92
ZWN0b3IpKTsKPiArCj4gKwl2cS0+cmVzZXQgPSB0cnVlOwo+ICsKPiArCXJldHVybiAwOwo+ICt9
Cj4gKwo+ICtzdGF0aWMgaW50IHZwX21vZGVybl9lbmFibGVfdnFfYWZ0ZXJfcmVzZXQoc3RydWN0
IHZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArCXN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2
ID0gdG9fdnBfZGV2aWNlKHZxLT52ZGV2KTsKPiArCXN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9k
ZXZpY2UgKm1kZXYgPSAmdnBfZGV2LT5tZGV2Owo+ICsJc3RydWN0IHZpcnRpb19wY2lfdnFfaW5m
byAqaW5mbzsKPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3MsIGluZGV4Owo+ICsJaW50IGVycjsKPiAr
Cj4gKwlpZiAoIXZxLT5yZXNldCkKPiArCQlyZXR1cm4gLUVCVVNZOwo+ICsKPiArCWluZGV4ID0g
dnEtPmluZGV4Owo+ICsJaW5mbyA9IHZwX2Rldi0+dnFzW2luZGV4XTsKPiArCj4gKwlpZiAodnBf
bW9kZXJuX2dldF9xdWV1ZV9yZXNldChtZGV2LCBpbmRleCkpCj4gKwkJcmV0dXJuIC1FQlVTWTsK
PiArCj4gKwlpZiAodnBfbW9kZXJuX2dldF9xdWV1ZV9lbmFibGUobWRldiwgaW5kZXgpKQo+ICsJ
CXJldHVybiAtRUJVU1k7Cj4gKwo+ICsJZXJyID0gdnBfYWN0aXZlX3ZxKHZxLCBpbmZvLT5tc2l4
X3ZlY3Rvcik7Cj4gKwlpZiAoZXJyKQo+ICsJCXJldHVybiBlcnI7Cj4gKwo+ICsJaWYgKHZxLT5j
YWxsYmFjaykgewo+ICsJCXNwaW5fbG9ja19pcnFzYXZlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsK
PiArCQlsaXN0X2FkZCgmaW5mby0+bm9kZSwgJnZwX2Rldi0+dmlydHF1ZXVlcyk7Cj4gKwkJc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4gKwl9IGVsc2Ugewo+
ICsJCUlOSVRfTElTVF9IRUFEKCZpbmZvLT5ub2RlKTsKPiArCX0KPiArCj4gKyNpZmRlZiBDT05G
SUdfVklSVElPX0hBUkRFTl9OT1RJRklDQVRJT04KPiArCV9fdmlydHF1ZXVlX3VuYnJlYWsodnEp
Owo+ICsjZW5kaWYKPiArCj4gKwl2cF9tb2Rlcm5fc2V0X3F1ZXVlX2VuYWJsZSgmdnBfZGV2LT5t
ZGV2LCBpbmRleCwgdHJ1ZSk7Cj4gKwl2cS0+cmVzZXQgPSBmYWxzZTsKPiArCj4gKwlyZXR1cm4g
MDsKPiArfQo+ICsKPiAgIHN0YXRpYyB1MTYgdnBfY29uZmlnX3ZlY3RvcihzdHJ1Y3QgdmlydGlv
X3BjaV9kZXZpY2UgKnZwX2RldiwgdTE2IHZlY3RvcikKPiAgIHsKPiAgIAlyZXR1cm4gdnBfbW9k
ZXJuX2NvbmZpZ192ZWN0b3IoJnZwX2Rldi0+bWRldiwgdmVjdG9yKTsKPiBAQCAtNDEzLDYgKzQ5
Nyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgdmlydGlvX3BjaV9j
b25maWdfbm9kZXZfb3BzID0gewo+ICAgCS5zZXRfdnFfYWZmaW5pdHkgPSB2cF9zZXRfdnFfYWZm
aW5pdHksCj4gICAJLmdldF92cV9hZmZpbml0eSA9IHZwX2dldF92cV9hZmZpbml0eSwKPiAgIAku
Z2V0X3NobV9yZWdpb24gID0gdnBfZ2V0X3NobV9yZWdpb24sCj4gKwkuZGlzYWJsZV92cV9hbmRf
cmVzZXQgPSB2cF9tb2Rlcm5fZGlzYWJsZV92cV9hbmRfcmVzZXQsCj4gKwkuZW5hYmxlX3ZxX2Fm
dGVyX3Jlc2V0ID0gdnBfbW9kZXJuX2VuYWJsZV92cV9hZnRlcl9yZXNldCwKPiAgIH07Cj4gICAK
PiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgdmlydGlvX3BjaV9jb25m
aWdfb3BzID0gewo+IEBAIC00MzEsNiArNTE3LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2aXJ0
aW9fY29uZmlnX29wcyB2aXJ0aW9fcGNpX2NvbmZpZ19vcHMgPSB7Cj4gICAJLnNldF92cV9hZmZp
bml0eSA9IHZwX3NldF92cV9hZmZpbml0eSwKPiAgIAkuZ2V0X3ZxX2FmZmluaXR5ID0gdnBfZ2V0
X3ZxX2FmZmluaXR5LAo+ICAgCS5nZXRfc2htX3JlZ2lvbiAgPSB2cF9nZXRfc2htX3JlZ2lvbiwK
PiArCS5kaXNhYmxlX3ZxX2FuZF9yZXNldCA9IHZwX21vZGVybl9kaXNhYmxlX3ZxX2FuZF9yZXNl
dCwKPiArCS5lbmFibGVfdnFfYWZ0ZXJfcmVzZXQgPSB2cF9tb2Rlcm5fZW5hYmxlX3ZxX2FmdGVy
X3Jlc2V0LAo+ICAgfTsKPiAgIAo+ICAgLyogdGhlIFBDSSBwcm9iaW5nIGZ1bmN0aW9uICovCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
