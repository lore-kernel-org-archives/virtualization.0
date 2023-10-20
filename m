Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1CBCDB474
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 07:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C2F3543212;
	Fri, 20 Oct 2023 07:23:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C2F3543212
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wwd7hs0QL6WY; Fri, 20 Oct 2023 07:23:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F3FC740156;
	Fri, 20 Oct 2023 07:23:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3FC740156
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF2D2C0039;
	Fri, 20 Oct 2023 07:23:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDF52C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 07:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B6BA083C7C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 07:23:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6BA083C7C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jjYQ2aUFNS6U
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 07:23:52 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E890183A49
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 07:23:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E890183A49
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R501e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VuWM7J9_1697786622; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuWM7J9_1697786622) by smtp.aliyun-inc.com;
 Fri, 20 Oct 2023 15:23:43 +0800
Message-ID: <1697786208.7535846-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 08/19] virtio_net: sq support premapped mode
Date: Fri, 20 Oct 2023 15:16:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEuq8i9_PX+vRESS3g2BpaWBv3FxDLMryG=aEJ+gAOsSaA@mail.gmail.com>
In-Reply-To: <CACGkMEuq8i9_PX+vRESS3g2BpaWBv3FxDLMryG=aEJ+gAOsSaA@mail.gmail.com>
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

T24gRnJpLCAyMCBPY3QgMjAyMyAxNDo1MDo1MiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMeKAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IElmIHRo
ZSB4c2sgaXMgZW5hYmxpbmcsIHRoZSB4c2sgdHggd2lsbCBzaGFyZSB0aGUgc2VuZCBxdWV1ZS4K
PiA+IEJ1dCB0aGUgeHNrIHJlcXVpcmVzIHRoYXQgdGhlIHNlbmQgcXVldWUgdXNlIHRoZSBwcmVt
YXBwZWQgbW9kZS4KPiA+IFNvIHRoZSBzZW5kIHF1ZXVlIG11c3Qgc3VwcG9ydCBwcmVtYXBwZWQg
bW9kZS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFs
aWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9uZXQvdmlydGlvL21haW4uYyAgICAgICB8
IDEwOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQo+ID4gIGRyaXZlcnMvbmV0L3Zp
cnRpby92aXJ0aW9fbmV0LmggfCAgNTQgKysrKysrKysrKysrKysrLQo+ID4gIDIgZmlsZXMgY2hh
bmdlZCwgMTQ5IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC92aXJ0aW8vbWFpbi5jIGIvZHJpdmVycy9uZXQvdmlydGlvL21haW4u
Ywo+ID4gaW5kZXggOGRhODRlYTliY2JlLi4wMmQyNzEwMWZlZjEgMTAwNjQ0Cj4gPiAtLS0gYS9k
cml2ZXJzL25ldC92aXJ0aW8vbWFpbi5jCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW8vbWFp
bi5jCj4gPiBAQCAtNTE0LDIwICs1MTQsMTA0IEBAIHN0YXRpYyB2b2lkICp2aXJ0bmV0X3JxX2Fs
bG9jKHN0cnVjdCB2aXJ0bmV0X3JxICpycSwgdTMyIHNpemUsIGdmcF90IGdmcCkKPiA+ICAgICAg
ICAgcmV0dXJuIGJ1ZjsKPiA+ICB9Cj4gPgo+ID4gLXN0YXRpYyB2b2lkIHZpcnRuZXRfcnFfc2V0
X3ByZW1hcHBlZChzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiA+ICtzdGF0aWMgaW50IHZpcnRu
ZXRfc3Ffc2V0X3ByZW1hcHBlZChzdHJ1Y3QgdmlydG5ldF9zcSAqc3EpCj4gPiAgewo+ID4gLSAg
ICAgICBpbnQgaTsKPiA+ICsgICAgICAgc3RydWN0IHZpcnRuZXRfc3FfZG1hICpkOwo+ID4gKyAg
ICAgICBpbnQgZXJyLCBzaXplLCBpOwo+ID4KPiA+IC0gICAgICAgLyogZGlzYWJsZSBmb3IgYmln
IG1vZGUgKi8KPiA+IC0gICAgICAgaWYgKCF2aS0+bWVyZ2VhYmxlX3J4X2J1ZnMgJiYgdmktPmJp
Z19wYWNrZXRzKQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybjsKPgo+IE5vdCBzcGVjaWZpYyB0
byB0aGlzIHBhdGNoIGJ1dCBhbnkgcGxhbiB0byBmaXggdGhlIGJpZyBtb2RlPwo+CgoKRm9yIGJp
Zywgd2Ugc2hvdWxkIG1ha2UgaXQgc3VwcG9ydCBYRFAgYW5kIGRvIGRtYSBmaXJzdC4KCgo+Cj4g
PiArICAgICAgIHNpemUgPSB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUoc3EtPnZxKTsKPiA+ICsK
PiA+ICsgICAgICAgc2l6ZSArPSBNQVhfU0tCX0ZSQUdTICsgMjsKPiA+ICsKPiA+ICsgICAgICAg
c3EtPmRtYWluZm8uaGVhZCA9IGtjYWxsb2Moc2l6ZSwgc2l6ZW9mKCpzcS0+ZG1haW5mby5oZWFk
KSwgR0ZQX0tFUk5FTCk7Cj4gPiArICAgICAgIGlmICghc3EtPmRtYWluZm8uaGVhZCkKPiA+ICsg
ICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPiA+ICsKPiA+ICsgICAgICAgZXJyID0gdmly
dHF1ZXVlX3NldF9kbWFfcHJlbWFwcGVkKHNxLT52cSk7Cj4gPiArICAgICAgIGlmIChlcnIpIHsK
PiA+ICsgICAgICAgICAgICAgICBrZnJlZShzcS0+ZG1haW5mby5oZWFkKTsKPiA+ICsgICAgICAg
ICAgICAgICByZXR1cm4gZXJyOwo+ID4gKyAgICAgICB9Cj4gPiArCj4gPiArICAgICAgIHNxLT5k
bWFpbmZvLmZyZWUgPSBOVUxMOwo+ID4gKwoKWy4uLl0KCj4gPiArCj4gPiArICAgICAgICAgICAg
ICAgZC0+YWRkciA9IHNnLT5kbWFfYWRkcmVzczsKPiA+ICsgICAgICAgICAgICAgICBkLT5sZW4g
PSBzZy0+bGVuZ3RoOwo+ID4gKwo+ID4gKyAgICAgICAgICAgICAgIGQtPm5leHQgPSBoZWFkOwo+
ID4gKyAgICAgICAgICAgICAgIGhlYWQgPSBkOwo+Cj4gSXQncyByZWFsbHkgYSBwaXR5IHRoYXQg
d2UgbmVlZCB0byBkdXBsaWNhdGUgdGhvc2UgRE1BIG1ldGF0YSB0d2ljZS4KPiBDb3VsZCB3ZSBp
bnZlbnQgYSBuZXcgQVBJIHRvIGp1c3QgZmV0Y2ggaXQgZnJvbSB0aGUgdmlydGlvIGNvcmU/CgpB
Y3R1YWxseSwgSSBwb3N0ZWQgdGhhdCBwYXRjaC4KCkNvbnNpZGVyIHRoaXMgaXMgcHVzaGluZyB0
byBuZXQtbmV4dC4gV2UgY2FuIGRvIHRoYXQgb24gdG9wLgoKCj4KPiA+ICsgICAgICAgfQo+ID4g
Kwo+ID4gKyAgICAgICBoZWFkLT5kYXRhID0gZGF0YTsKPiA+ICsKPiA+ICsgICAgICAgcmV0dXJu
ICh2b2lkICopKCh1bnNpZ25lZCBsb25nKWhlYWQgfCAoKHVuc2lnbmVkIGxvbmcpZGF0YSAmIFZJ
UlRJT19YTUlUX0RBVEFfTUFTSykpOwo+Cj4gSWYgd2UgcGFja2VkIGV2ZXJ5dGhpbmcgaW50byBk
bWFpbmZvLCB3ZSBjYW4gbGVhdmUgdGhlIHR5cGUgKFhEUCB2cwo+IHNrYikgdGhlcmUgdG8gYXZv
aWQgdHJpY2sgbGlrZSBwYWNraW5nIGl0IGludG8gdGhlIHBvaW50ZXIgaGVyZT8KClllcy4gQnV0
IGlmIHRoZSB2aXJ0aW8gaGFzIG5vdCBfQUNDRVNTX1BMQVRGT1JNLCB0aGUgZHJpdmVyIHdpbGwK
aGFzIG5vdCB0aGUgRE1BIG1ldGEgZGF0YS4KClRoYW5rcy4KCgo+Cj4gVGhhbmtzCj4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
