Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384D0C001DE
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 02:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6B808215F;
	Wed, 16 Aug 2023 02:16:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6B808215F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G-PLdlDX7NC2; Wed, 16 Aug 2023 02:16:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3AAC782158;
	Wed, 16 Aug 2023 02:16:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3AAC782158
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11E0BC0072;
	Wed, 16 Aug 2023 02:16:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C6B0C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DAD7482159
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:16:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DAD7482159
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mb9jHz4U0bQt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:16:11 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5335082158
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5335082158
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R501e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VptxGi0_1692152164; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VptxGi0_1692152164) by smtp.aliyun-inc.com;
 Wed, 16 Aug 2023 10:16:05 +0800
Message-ID: <1692151724.9150448-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
Date: Wed, 16 Aug 2023 10:08:44 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
 <1692091669.428807-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsnW-+fqcxu6E-cbAtMduE_n82fu+RA162fX5gr=Ckf5A@mail.gmail.com>
In-Reply-To: <CACGkMEsnW-+fqcxu6E-cbAtMduE_n82fu+RA162fX5gr=Ckf5A@mail.gmail.com>
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

T24gV2VkLCAxNiBBdWcgMjAyMyAwOToxMzo0OCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgNTo0MOKAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1
ZSwgMTUgQXVnIDIwMjMgMTU6NTA6MjMgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPiBPbiBUdWUsIEF1ZyAxNSwgMjAyMyBhdCAyOjMy4oCvUE0gWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4g
Pgo+ID4gPiA+IEhpLCBKYXNvbgo+ID4gPiA+Cj4gPiA+ID4gQ291bGQgeW91IHNraXAgdGhpcyBw
YXRjaD8KPiA+ID4KPiA+ID4gSSdtIGZpbmUgd2l0aCBlaXRoZXIgbWVyZ2luZyBvciBkcm9wcGlu
ZyB0aGlzLgo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gTGV0IHdlIHJldmlldyBvdGhlciBwYXRjaGVz
IGZpcnN0bHk/Cj4gPiA+Cj4gPiA+IEkgd2lsbCBiZSBvbiB2YWNhdGlvbiBzb29uLCBhbmQgd29u
J3QgaGF2ZSB0aW1lIHRvIGRvIHRoaXMgdW50aWwgbmV4dCB3ZWVrLgo+ID4KPiA+IEhhdmUgYSBo
YXBwbHkgdmFjYXRpb24uCj4gPgo+ID4gPgo+ID4gPiBCdXQgSSBzcG90IHR3byBwb3NzaWJsZSAi
aXNzdWVzIjoKPiA+ID4KPiA+ID4gMSkgdGhlIERNQSBtZXRhZGF0YSB3ZXJlIHN0b3JlZCBpbiB0
aGUgaGVhZHJvb20gb2YgdGhlIHBhZ2UsIHRoaXMKPiA+ID4gYnJlYWtzIGZyYWdzIGNvYWxlc2Np
bmcsIHdlIG5lZWQgdG8gYmVuY2htYXJrIGl0J3MgaW1wYWN0Cj4gPgo+ID4gTm90IGV2ZXJ5IHBh
Z2UsIGp1c3QgdGhlIGZpcnN0IHBhZ2Ugb2YgdGhlIENPTVAgcGFnZXMuCj4gPgo+ID4gU28gSSB0
aGluayB0aGVyZSBpcyBubyBpbXBhY3QuCj4KPiBOb3BlLCBzZWUgdGhpczoKPgo+ICAgICAgICAg
aWYgKFNLQl9GUkFHX1BBR0VfT1JERVIgJiYKPiAgICAgICAgICAgICAhc3RhdGljX2JyYW5jaF91
bmxpa2VseSgmbmV0X2hpZ2hfb3JkZXJfYWxsb2NfZGlzYWJsZV9rZXkpKSB7Cj4gICAgICAgICAg
ICAgICAgIC8qIEF2b2lkIGRpcmVjdCByZWNsYWltIGJ1dCBhbGxvdyBrc3dhcGQgdG8gd2FrZSAq
Lwo+ICAgICAgICAgICAgICAgICBwZnJhZy0+cGFnZSA9IGFsbG9jX3BhZ2VzKChnZnAgJiB+X19H
RlBfRElSRUNUX1JFQ0xBSU0pIHwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBfX0dGUF9DT01QIHwgX19HRlBfTk9XQVJOIHwKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBfX0dGUF9OT1JFVFJZLAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFNLQl9GUkFHX1BBR0VfT1JERVIpOwo+ICAgICAgICAg
ICAgICAgICBpZiAobGlrZWx5KHBmcmFnLT5wYWdlKSkgewo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHBmcmFnLT5zaXplID0gUEFHRV9TSVpFIDw8IFNLQl9GUkFHX1BBR0VfT1JERVI7Cj4gICAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7Cj4gICAgICAgICAgICAgICAgIH0KPiAg
ICAgICAgIH0KPgo+IFRoZSBjb21wIHBhZ2UgbWlnaHQgYmUgZGlzYWJsZWQgZHVlIHRvIHRoZSBT
S0JfRlJBR19QQUdFX09SREVSIGFuZAo+IG5ldF9oaWdoX29yZGVyX2FsbG9jX2Rpc2FibGVfa2V5
LgoKCllFUy4KCkJ1dCBpZiBjb21wIHBhZ2UgaXMgZGlzYWJsZWQuIFRoZW4gd2Ugb25seSBnZXQg
b25lIHBhZ2UgZWFjaCB0aW1lLiBUaGUgcGFnZXMgYXJlCm5vdCBjb250aWd1b3VzLCBzbyB3ZSBk
b24ndCBoYXZlIGZyYWdzIGNvYWxlc2NpbmcuCgpJZiB5b3UgbWVhbiB0aGUgdHdvIHBhZ2VzIGdv
dCBmcm9tIGFsbG9jX3BhZ2UgbWF5IGJlIGNvbnRpZ3VvdXMuIFRoZSBjb2FsZXNjaW5nCm1heSB0
aGVuIGJlIGJyb2tlbi4gSXQncyBhIHBvc3NpYmlsaXR5LCBidXQgSSB0aGluayB0aGUgaW1wYWN0
IHdpbGwgYmUgc21hbGwuCgpUaGFua3MuCgoKPgo+ID4KPiA+Cj4gPiA+IDIpIHByZSBtYXBwZWQg
RE1BIGFkZHJlc3NlcyB3ZXJlIG5vdCByZXVzZWQgaW4gdGhlIGNhc2Ugb2YgWERQX1RYL1hEUF9S
RURJUkVDVAo+ID4KPiA+IEJlY2F1c2UgdGhhdCB0aGUgdHggaXMgbm90IHRoZSBwcmVtYXBwZWQg
bW9kZS4KPgo+IFllcywgd2UgY2FuIG9wdGltaXplIHRoaXMgb24gdG9wLgo+Cj4gVGhhbmtzCj4K
PiA+Cj4gPiBUaGFua3MuCj4gPgo+ID4gPgo+ID4gPiBJIHNlZSBNaWNoYWVsIGhhcyBtZXJnZSB0
aGlzIHNlcmllcyBzbyBJJ20gZmluZSB0byBsZXQgaXQgZ28gZmlyc3QuCj4gPiA+Cj4gPiA+IFRo
YW5rcwo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzLgo+ID4gPiA+Cj4gPiA+Cj4gPgo+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
