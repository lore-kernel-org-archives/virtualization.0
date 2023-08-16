Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDCFC001DE
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 02:24:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A0C040953;
	Wed, 16 Aug 2023 02:24:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A0C040953
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jDGPLcjGyXn4; Wed, 16 Aug 2023 02:24:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2121740939;
	Wed, 16 Aug 2023 02:24:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2121740939
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E631CC0072;
	Wed, 16 Aug 2023 02:24:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D1A7C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC0BF414EE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:24:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC0BF414EE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id thX-F0GPJsLA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:24:34 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 000B140352
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:24:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 000B140352
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0Vptwffd_1692152666; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vptwffd_1692152666) by smtp.aliyun-inc.com;
 Wed, 16 Aug 2023 10:24:27 +0800
Message-ID: <1692152487.9422052-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
Date: Wed, 16 Aug 2023 10:21:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
 <1692091669.428807-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsnW-+fqcxu6E-cbAtMduE_n82fu+RA162fX5gr=Ckf5A@mail.gmail.com>
 <1692151724.9150448-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt7LSTY-TRcSD75vYcv0AkH2a5otVXga7VGRLu7JQT_dA@mail.gmail.com>
In-Reply-To: <CACGkMEt7LSTY-TRcSD75vYcv0AkH2a5otVXga7VGRLu7JQT_dA@mail.gmail.com>
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

T24gV2VkLCAxNiBBdWcgMjAyMyAxMDoxOTozNCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gV2VkLCBBdWcgMTYsIDIwMjMgYXQgMTA6MTbigK9BTSBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBX
ZWQsIDE2IEF1ZyAyMDIzIDA5OjEzOjQ4ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPiA+ID4gT24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgNTo0MOKAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+
ID4gT24gVHVlLCAxNSBBdWcgMjAyMyAxNTo1MDoyMyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiBPbiBUdWUsIEF1ZyAxNSwgMjAyMyBhdCAy
OjMy4oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEhpLCBKYXNvbgo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiBDb3VsZCB5b3Ugc2tpcCB0aGlzIHBhdGNoPwo+ID4gPiA+ID4KPiA+ID4gPiA+
IEknbSBmaW5lIHdpdGggZWl0aGVyIG1lcmdpbmcgb3IgZHJvcHBpbmcgdGhpcy4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IExldCB3ZSByZXZpZXcgb3RoZXIgcGF0Y2hlcyBmaXJz
dGx5Pwo+ID4gPiA+ID4KPiA+ID4gPiA+IEkgd2lsbCBiZSBvbiB2YWNhdGlvbiBzb29uLCBhbmQg
d29uJ3QgaGF2ZSB0aW1lIHRvIGRvIHRoaXMgdW50aWwgbmV4dCB3ZWVrLgo+ID4gPiA+Cj4gPiA+
ID4gSGF2ZSBhIGhhcHBseSB2YWNhdGlvbi4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IEJ1
dCBJIHNwb3QgdHdvIHBvc3NpYmxlICJpc3N1ZXMiOgo+ID4gPiA+ID4KPiA+ID4gPiA+IDEpIHRo
ZSBETUEgbWV0YWRhdGEgd2VyZSBzdG9yZWQgaW4gdGhlIGhlYWRyb29tIG9mIHRoZSBwYWdlLCB0
aGlzCj4gPiA+ID4gPiBicmVha3MgZnJhZ3MgY29hbGVzY2luZywgd2UgbmVlZCB0byBiZW5jaG1h
cmsgaXQncyBpbXBhY3QKPiA+ID4gPgo+ID4gPiA+IE5vdCBldmVyeSBwYWdlLCBqdXN0IHRoZSBm
aXJzdCBwYWdlIG9mIHRoZSBDT01QIHBhZ2VzLgo+ID4gPiA+Cj4gPiA+ID4gU28gSSB0aGluayB0
aGVyZSBpcyBubyBpbXBhY3QuCj4gPiA+Cj4gPiA+IE5vcGUsIHNlZSB0aGlzOgo+ID4gPgo+ID4g
PiAgICAgICAgIGlmIChTS0JfRlJBR19QQUdFX09SREVSICYmCj4gPiA+ICAgICAgICAgICAgICFz
dGF0aWNfYnJhbmNoX3VubGlrZWx5KCZuZXRfaGlnaF9vcmRlcl9hbGxvY19kaXNhYmxlX2tleSkp
IHsKPiA+ID4gICAgICAgICAgICAgICAgIC8qIEF2b2lkIGRpcmVjdCByZWNsYWltIGJ1dCBhbGxv
dyBrc3dhcGQgdG8gd2FrZSAqLwo+ID4gPiAgICAgICAgICAgICAgICAgcGZyYWctPnBhZ2UgPSBh
bGxvY19wYWdlcygoZ2ZwICYgfl9fR0ZQX0RJUkVDVF9SRUNMQUlNKSB8Cj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fR0ZQX0NPTVAgfCBfX0dGUF9OT1dB
Uk4gfAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX0dG
UF9OT1JFVFJZLAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBTS0JfRlJBR19QQUdFX09SREVSKTsKPiA+ID4gICAgICAgICAgICAgICAgIGlmIChsaWtlbHko
cGZyYWctPnBhZ2UpKSB7Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHBmcmFnLT5zaXpl
ID0gUEFHRV9TSVpFIDw8IFNLQl9GUkFHX1BBR0VfT1JERVI7Cj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiB0cnVlOwo+ID4gPiAgICAgICAgICAgICAgICAgfQo+ID4gPiAgICAg
ICAgIH0KPiA+ID4KPiA+ID4gVGhlIGNvbXAgcGFnZSBtaWdodCBiZSBkaXNhYmxlZCBkdWUgdG8g
dGhlIFNLQl9GUkFHX1BBR0VfT1JERVIgYW5kCj4gPiA+IG5ldF9oaWdoX29yZGVyX2FsbG9jX2Rp
c2FibGVfa2V5Lgo+ID4KPiA+Cj4gPiBZRVMuCj4gPgo+ID4gQnV0IGlmIGNvbXAgcGFnZSBpcyBk
aXNhYmxlZC4gVGhlbiB3ZSBvbmx5IGdldCBvbmUgcGFnZSBlYWNoIHRpbWUuIFRoZSBwYWdlcyBh
cmUKPiA+IG5vdCBjb250aWd1b3VzLCBzbyB3ZSBkb24ndCBoYXZlIGZyYWdzIGNvYWxlc2Npbmcu
Cj4gPgo+ID4gSWYgeW91IG1lYW4gdGhlIHR3byBwYWdlcyBnb3QgZnJvbSBhbGxvY19wYWdlIG1h
eSBiZSBjb250aWd1b3VzLiBUaGUgY29hbGVzY2luZwo+ID4gbWF5IHRoZW4gYmUgYnJva2VuLiBJ
dCdzIGEgcG9zc2liaWxpdHksIGJ1dCBJIHRoaW5rIHRoZSBpbXBhY3Qgd2lsbCBiZSBzbWFsbC4K
Pgo+IExldCdzIGhhdmUgYSBzaW1wbGUgYmVuY2htYXJrIGFuZCBzZWU/CgoKVGhhdCBpcyBvay4K
CkkgdGhpbmsgeW91IHdhbnQgdG8ga25vdyB0aGUgcGVyZiBudW0gd2l0aCBiaWcgdHJhZmZpYyBh
bmQgdGhlIGNvbXAgcGFnZQpkaXNhYmxlZC4KClRoYW5rcy4KCgo+Cj4gVGhhbmtzCj4KPiA+Cj4g
PiBUaGFua3MuCj4gPgo+ID4KPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiAyKSBwcmUg
bWFwcGVkIERNQSBhZGRyZXNzZXMgd2VyZSBub3QgcmV1c2VkIGluIHRoZSBjYXNlIG9mIFhEUF9U
WC9YRFBfUkVESVJFQ1QKPiA+ID4gPgo+ID4gPiA+IEJlY2F1c2UgdGhhdCB0aGUgdHggaXMgbm90
IHRoZSBwcmVtYXBwZWQgbW9kZS4KPiA+ID4KPiA+ID4gWWVzLCB3ZSBjYW4gb3B0aW1pemUgdGhp
cyBvbiB0b3AuCj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtz
Lgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gSSBzZWUgTWljaGFlbCBoYXMgbWVyZ2UgdGhp
cyBzZXJpZXMgc28gSSdtIGZpbmUgdG8gbGV0IGl0IGdvIGZpcnN0Lgo+ID4gPiA+ID4KPiA+ID4g
PiA+IFRoYW5rcwo+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhhbmtzLgo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPgo+ID4KPgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
