Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F081C77B60
	for <virtualization@archiver.kernel.org>; Wed, 26 Apr 2023 06:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9488041977;
	Wed, 26 Apr 2023 06:01:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9488041977
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EusVyYl2wwcO; Wed, 26 Apr 2023 06:01:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8AAB6415FA;
	Wed, 26 Apr 2023 06:01:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AAB6415FA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EB9DC0036;
	Wed, 26 Apr 2023 06:01:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7DCFC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 06:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7362941977
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 06:01:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7362941977
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NFFSLdOcL6yI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 06:01:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A523B415FA
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A523B415FA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 06:01:04 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R391e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vh1odsN_1682488857; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vh1odsN_1682488857) by smtp.aliyun-inc.com;
 Wed, 26 Apr 2023 14:00:57 +0800
Message-ID: <1682488831.2667048-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 12/15] virtio_net: small: optimize code
Date: Wed, 26 Apr 2023 14:00:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
 <20230423105736.56918-13-xuanzhuo@linux.alibaba.com>
 <CACGkMEtC8WECH054KRs-uPeZiCv_PMUX4++9eUNffrB0Pboycw@mail.gmail.com>
In-Reply-To: <CACGkMEtC8WECH054KRs-uPeZiCv_PMUX4++9eUNffrB0Pboycw@mail.gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCAyNiBBcHIgMjAyMyAxMTowODo1MiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gU3VuLCBBcHIgMjMsIDIwMjMgYXQgNjo1OOKAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IEF2b2lk
IHRoZSBwcm9ibGVtIHRoYXQgc29tZSB2YXJpYWJsZXMoaGVhZHJvb20gYW5kIHNvIG9uKSB3aWxs
IHJlcGVhdAo+ID4gdGhlIGNhbGN1bGF0aW9uIHdoZW4gcHJvY2VzcyB4ZHAuCj4gPgo+ID4gU2ln
bmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPgo+IE5p
dDogSSB0aGluayB3ZSBuZWVkIHRvIHR3ZWFrIHRoZSB0aXRsZSwgaXQncyBiZXR0ZXIgdG8gc2F5
IHdoYXQgaXMKPiBvcHRpbWl6ZWQuIChBbmQgaXQgd291bGQgYmUgYmV0dGVyIHRvIHR3ZWFrIHRo
ZSB0aXRsZSBvZiBwYXRjaCAxMSBhcwo+IHdlbGwpCgpZZXMsIEkgYWdyZWUgdGhpcy4KClRoYW5r
cy4KCj4KPiBBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPgo+ID4g
LS0tCj4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMTIgKysrKysrKystLS0tCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+Cj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gPiBpbmRleCA1YmMzZGNhMGY2MGMuLjYwMWMwZTdmYzMyYiAxMDA2NDQKPiA+IC0t
LSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gPiBAQCAtMTAzMSwxMSArMTAzMSwxMCBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYg
KnJlY2VpdmVfc21hbGwoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiA+ICAgICAgICAgc3RydWN0
IHNrX2J1ZmYgKnNrYjsKPiA+ICAgICAgICAgc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZzsKPiA+
ICAgICAgICAgdW5zaWduZWQgaW50IHhkcF9oZWFkcm9vbSA9ICh1bnNpZ25lZCBsb25nKWN0eDsK
PiA+IC0gICAgICAgdW5zaWduZWQgaW50IGhlYWRlcl9vZmZzZXQgPSBWSVJUTkVUX1JYX1BBRCAr
IHhkcF9oZWFkcm9vbTsKPiA+IC0gICAgICAgdW5zaWduZWQgaW50IGhlYWRyb29tID0gdmktPmhk
cl9sZW4gKyBoZWFkZXJfb2Zmc2V0Owo+ID4gLSAgICAgICB1bnNpZ25lZCBpbnQgYnVmbGVuID0g
U0tCX0RBVEFfQUxJR04oR09PRF9QQUNLRVRfTEVOICsgaGVhZHJvb20pICsKPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFNLQl9EQVRBX0FMSUdOKHNpemVvZihzdHJ1Y3Qgc2tiX3No
YXJlZF9pbmZvKSk7Cj4gPiAgICAgICAgIHN0cnVjdCBwYWdlICpwYWdlID0gdmlydF90b19oZWFk
X3BhZ2UoYnVmKTsKPiA+ICsgICAgICAgdW5zaWduZWQgaW50IGhlYWRlcl9vZmZzZXQ7Cj4gPiAr
ICAgICAgIHVuc2lnbmVkIGludCBoZWFkcm9vbTsKPiA+ICsgICAgICAgdW5zaWduZWQgaW50IGJ1
ZmxlbjsKPiA+Cj4gPiAgICAgICAgIGxlbiAtPSB2aS0+aGRyX2xlbjsKPiA+ICAgICAgICAgc3Rh
dHMtPmJ5dGVzICs9IGxlbjsKPiA+IEBAIC0xMDYzLDYgKzEwNjIsMTEgQEAgc3RhdGljIHN0cnVj
dCBza19idWZmICpyZWNlaXZlX3NtYWxsKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiAgICAg
ICAgIHJjdV9yZWFkX3VubG9jaygpOwo+ID4KPiA+ICBza2lwX3hkcDoKPiA+ICsgICAgICAgaGVh
ZGVyX29mZnNldCA9IFZJUlRORVRfUlhfUEFEICsgeGRwX2hlYWRyb29tOwo+ID4gKyAgICAgICBo
ZWFkcm9vbSA9IHZpLT5oZHJfbGVuICsgaGVhZGVyX29mZnNldDsKPiA+ICsgICAgICAgYnVmbGVu
ID0gU0tCX0RBVEFfQUxJR04oR09PRF9QQUNLRVRfTEVOICsgaGVhZHJvb20pICsKPiA+ICsgICAg
ICAgICAgICAgICBTS0JfREFUQV9BTElHTihzaXplb2Yoc3RydWN0IHNrYl9zaGFyZWRfaW5mbykp
Owo+ID4gKwo+ID4gICAgICAgICBza2IgPSBidWlsZF9za2IoYnVmLCBidWZsZW4pOwo+ID4gICAg
ICAgICBpZiAoIXNrYikKPiA+ICAgICAgICAgICAgICAgICBnb3RvIGVycjsKPiA+IC0tCj4gPiAy
LjMyLjAuMy5nMDExOTVjZjlmCj4gPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
