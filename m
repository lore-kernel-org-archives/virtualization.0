Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079D8EB64D9
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 08:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82D7741E34;
	Wed, 12 Jul 2023 08:36:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82D7741E34
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7f9jAQNIkGWz; Wed, 12 Jul 2023 08:36:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AD70041E39;
	Wed, 12 Jul 2023 08:36:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD70041E39
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8726DC0072;
	Wed, 12 Jul 2023 08:36:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2ACCC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CD44C4051D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:36:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD44C4051D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fuK1m7ivE6TS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:36:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E963404FC
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E963404FC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:36:21 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VnCF4AR_1689150975; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VnCF4AR_1689150975) by smtp.aliyun-inc.com;
 Wed, 12 Jul 2023 16:36:16 +0800
Message-ID: <1689150956.767141-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 03/10] virtio_ring: introduce
 virtqueue_set_premapped()
Date: Wed, 12 Jul 2023 16:35:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEumF73qbByV3K1+fdgnXBXqu-YS2yas+Vy_=Dn+yjy-cw@mail.gmail.com>
In-Reply-To: <CACGkMEumF73qbByV3K1+fdgnXBXqu-YS2yas+Vy_=Dn+yjy-cw@mail.gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCAxMiBKdWwgMjAyMyAxNjoyNDoxOCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgMTE6NDLigK9BTSBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IHdyb3RlOgo+Cj4gPiBUaGlz
IGhlbHBlciBhbGxvd3MgdGhlIGRyaXZlciBjaGFuZ2UgdGhlIGRtYSBtb2RlIHRvIHByZW1hcHBl
ZCBtb2RlLgo+ID4gVW5kZXIgdGhlIHByZW1hcHBlZCBtb2RlLCB0aGUgdmlydGlvIGNvcmUgZG8g
bm90IGRvIGRtYSBtYXBwaW5nCj4gPiBpbnRlcm5hbGx5Lgo+ID4KPiA+IFRoaXMganVzdCB3b3Jr
IHdoZW4gdGhlIHVzZV9kbWFfYXBpIGlzIHRydWUuIElmIHRoZSB1c2VfZG1hX2FwaSBpcyBmYWxz
ZSwKPiA+IHRoZSBkbWEgb3B0aW9ucyBpcyBub3QgdGhyb3VnaCB0aGUgRE1BIEFQSXMsIHRoYXQg
aXMgbm90IHRoZSBzdGFuZGFyZAo+ID4gd2F5IG9mIHRoZSBsaW51eCBrZXJuZWwuCj4gPgo+ID4g
U2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+
IC0tLQo+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA0NSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKPiA+ICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAg
IHwgIDIgKysKPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKykKPiA+Cj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMKPiA+IGluZGV4IDg3ZDdjZWVlY2RiZC4uNWFjZTQ1MzkzNDRjIDEwMDY0
NAo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gKysrIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gQEAgLTE3Miw2ICsxNzIsOSBAQCBzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlIHsKPiA+ICAgICAgICAgLyogSG9zdCBwdWJsaXNoZXMgYXZhaWwgZXZlbnQg
aWR4ICovCj4gPiAgICAgICAgIGJvb2wgZXZlbnQ7Cj4gPgo+ID4gKyAgICAgICAvKiBEbyBETUEg
bWFwcGluZyBieSBkcml2ZXIgKi8KPiA+ICsgICAgICAgYm9vbCBwcmVtYXBwZWQ7Cj4gPiArCj4g
PiAgICAgICAgIC8qIEhlYWQgb2YgZnJlZSBidWZmZXIgbGlzdC4gKi8KPiA+ICAgICAgICAgdW5z
aWduZWQgaW50IGZyZWVfaGVhZDsKPiA+ICAgICAgICAgLyogTnVtYmVyIHdlJ3ZlIGFkZGVkIHNp
bmNlIGxhc3Qgc3luYy4gKi8KPiA+IEBAIC0yMDYxLDYgKzIwNjQsNyBAQCBzdGF0aWMgc3RydWN0
IHZpcnRxdWV1ZQo+ID4gKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+ID4gICAgICAg
ICB2cS0+cGFja2VkX3JpbmcgPSB0cnVlOwo+ID4gICAgICAgICB2cS0+ZG1hX2RldiA9IGRtYV9k
ZXY7Cj4gPiAgICAgICAgIHZxLT51c2VfZG1hX2FwaSA9IHZyaW5nX3VzZV9kbWFfYXBpKHZkZXYp
Owo+ID4gKyAgICAgICB2cS0+cHJlbWFwcGVkID0gZmFsc2U7Cj4gPgo+ID4gICAgICAgICB2cS0+
aW5kaXJlY3QgPSB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwKPiA+IFZJUlRJT19SSU5HX0ZfSU5E
SVJFQ1RfREVTQykgJiYKPiA+ICAgICAgICAgICAgICAgICAhY29udGV4dDsKPiA+IEBAIC0yNTUw
LDYgKzI1NTQsNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZQo+ID4gKl9fdnJpbmdfbmV3X3Zp
cnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiAgI2VuZGlmCj4gPiAgICAgICAgIHZxLT5k
bWFfZGV2ID0gZG1hX2RldjsKPiA+ICAgICAgICAgdnEtPnVzZV9kbWFfYXBpID0gdnJpbmdfdXNl
X2RtYV9hcGkodmRldik7Cj4gPiArICAgICAgIHZxLT5wcmVtYXBwZWQgPSBmYWxzZTsKPiA+Cj4g
PiAgICAgICAgIHZxLT5pbmRpcmVjdCA9IHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LAo+ID4gVklS
VElPX1JJTkdfRl9JTkRJUkVDVF9ERVNDKSAmJgo+ID4gICAgICAgICAgICAgICAgICFjb250ZXh0
Owo+ID4gQEAgLTI2OTMsNiArMjY5OCw0NiBAQCBpbnQgdmlydHF1ZXVlX3Jlc2l6ZShzdHJ1Y3Qg
dmlydHF1ZXVlICpfdnEsIHUzMiBudW0sCj4gPiAgfQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKHZp
cnRxdWV1ZV9yZXNpemUpOwo+ID4KPiA+ICsvKioKPiA+ICsgKiB2aXJ0cXVldWVfc2V0X3ByZW1h
cHBlZCAtIHNldCB0aGUgdnJpbmcgcHJlbWFwcGVkIG1vZGUKPiA+ICsgKiBAX3ZxOiB0aGUgc3Ry
dWN0IHZpcnRxdWV1ZSB3ZSdyZSB0YWxraW5nIGFib3V0Lgo+ID4gKyAqCj4gPiArICogRW5hYmxl
IHRoZSBwcmVtYXBwZWQgbW9kZSBvZiB0aGUgdnEuCj4gPiArICoKPiA+ICsgKiBUaGUgdnJpbmcg
aW4gcHJlbWFwcGVkIG1vZGUgZG9lcyBub3QgZG8gZG1hIGludGVybmFsbHksIHNvIHRoZSBkcml2
ZXIKPiA+IG11c3QKPiA+ICsgKiBkbyBkbWEgbWFwcGluZyBpbiBhZHZhbmNlLiBUaGUgZHJpdmVy
IG11c3QgcGFzcyB0aGUgZG1hX2FkZHJlc3MgdGhyb3VnaAo+ID4gKyAqIGRtYV9hZGRyZXNzIG9m
IHNjYXR0ZXJsaXN0LiBXaGVuIHRoZSBkcml2ZXIgZ290IGEgdXNlZCBidWZmZXIgZnJvbQo+ID4g
KyAqIHRoZSB2cmluZywgaXQgaGFzIHRvIHVubWFwIHRoZSBkbWEgYWRkcmVzcy4KPiA+ICsgKgo+
ID4gKyAqIFRoaXMgZnVuY3Rpb24gbXVzdCBiZSBjYWxsZWQgaW1tZWRpYXRlbHkgYWZ0ZXIgY3Jl
YXRpbmcgdGhlIHZxLCBvcgo+ID4gYWZ0ZXIgdnEKPiA+ICsgKiByZXNldCwgYW5kIGJlZm9yZSBh
ZGRpbmcgYW55IGJ1ZmZlcnMgdG8gaXQuCj4gPiArICoKPiA+ICsgKiBDYWxsZXIgbXVzdCBlbnN1
cmUgd2UgZG9uJ3QgY2FsbCB0aGlzIHdpdGggb3RoZXIgdmlydHF1ZXVlIG9wZXJhdGlvbnMKPiA+
ICsgKiBhdCB0aGUgc2FtZSB0aW1lIChleGNlcHQgd2hlcmUgbm90ZWQpLgo+ID4gKyAqCj4gPiAr
ICogUmV0dXJucyB6ZXJvIG9yIGEgbmVnYXRpdmUgZXJyb3IuCj4gPiArICogMDogc3VjY2Vzcy4K
PiA+ICsgKiAtRUlOVkFMOiB2cmluZyBkb2VzIG5vdCB1c2UgdGhlIGRtYSBhcGksIHNvIHdlIGNh
biBub3QgZW5hYmxlCj4gPiBwcmVtYXBwZWQgbW9kZS4KPiA+ICsgKi8KPiA+ICtpbnQgdmlydHF1
ZXVlX3NldF9wcmVtYXBwZWQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ID4gK3sKPiA+ICsgICAg
ICAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPiA+ICsgICAgICAg
dTMyIG51bTsKPiA+ICsKPiA+ICsgICAgICAgbnVtID0gdnEtPnBhY2tlZF9yaW5nID8gdnEtPnBh
Y2tlZC52cmluZy5udW0gOiB2cS0+c3BsaXQudnJpbmcubnVtOwo+ID4gKwo+ID4gKyAgICAgICBp
ZiAobnVtICE9IHZxLT52cS5udW1fZnJlZSkKPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJ
TlZBTDsKPiA+Cj4KPiBJZiB3ZSBjaGVjayB0aGlzLCBJIHRoaW5rIHdlIG5lZWQgdG8gcHJvdGVj
dCB0aGlzIHdpdGgKPiBTVEFSVF9VU0UoKS9FTkRfVVNFKCkuCgpZRVMuCgoKPgo+Cj4gPiArCj4g
PiArICAgICAgIGlmICghdnEtPnVzZV9kbWFfYXBpKQo+ID4gKyAgICAgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOwo+ID4KPgo+IE5vdCBhIG5hdGl2ZSBzcHJlYWssIGJ1dCBJIHRoaW5rICJkbWFf
cHJlbWFwcGVkIiBpcyBiZXR0ZXIgdGhhbiAicHJlbWFwcGVkIgo+IGFzICJkbWFfcHJlbWFwcGVk
IiBpbXBsaWVzICJ1c2VfZG1hX2FwaSIuCgpJIGFtIG9rIHRvIGZpeCB0aGlzLgoKVGhhbmtzLgoK
Cj4KPiBUaGFua3MKPgo+Cj4gPiArCj4gPiArICAgICAgIHZxLT5wcmVtYXBwZWQgPSB0cnVlOwo+
ID4gKwo+ID4gKyAgICAgICByZXR1cm4gMDsKPiA+ICt9Cj4gPiArRVhQT1JUX1NZTUJPTF9HUEwo
dmlydHF1ZXVlX3NldF9wcmVtYXBwZWQpOwo+ID4gKwo+ID4gIC8qIE9ubHkgYXZhaWxhYmxlIGZv
ciBzcGxpdCByaW5nICovCj4gPiAgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfbmV3X3ZpcnRxdWV1
ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGludCBudW0sCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92
aXJ0aW8uaCBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiA+IGluZGV4IGRlNjA0MWRlZWUzNy4u
MmVmZDA3Yjc5ZWNmIDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ID4g
KysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ID4gQEAgLTc4LDYgKzc4LDggQEAgYm9vbCB2
aXJ0cXVldWVfZW5hYmxlX2NiKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiA+Cj4gPiAgdW5zaWdu
ZWQgdmlydHF1ZXVlX2VuYWJsZV9jYl9wcmVwYXJlKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiA+
Cj4gPiAraW50IHZpcnRxdWV1ZV9zZXRfcHJlbWFwcGVkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSk7
Cj4gPiArCj4gPiAgYm9vbCB2aXJ0cXVldWVfcG9sbChzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdW5z
aWduZWQpOwo+ID4KPiA+ICBib29sIHZpcnRxdWV1ZV9lbmFibGVfY2JfZGVsYXllZChzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSk7Cj4gPiAtLQo+ID4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+ID4KPiA+Cj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
