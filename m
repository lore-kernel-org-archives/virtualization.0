Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9266C001B0
	for <virtualization@archiver.kernel.org>; Mon, 14 Aug 2023 11:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 570AE41725;
	Mon, 14 Aug 2023 11:59:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 570AE41725
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kobbbXX-q-lm; Mon, 14 Aug 2023 11:59:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7C7B0416DE;
	Mon, 14 Aug 2023 11:59:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C7B0416DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45BA2C0072;
	Mon, 14 Aug 2023 11:59:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B73DFC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 11:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9282B81DE0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 11:59:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9282B81DE0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qZTHTxZ38OR4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 11:59:37 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C916881DA0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 11:59:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C916881DA0
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0Vpn6xQe_1692014369; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vpn6xQe_1692014369) by smtp.aliyun-inc.com;
 Mon, 14 Aug 2023 19:59:30 +0800
Message-ID: <1692014127.1405742-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
Date: Mon, 14 Aug 2023 19:55:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692003413.6339955-1-xuanzhuo@linux.alibaba.com>
 <20230814072350-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230814072350-mutt-send-email-mst@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
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

T24gTW9uLCAxNCBBdWcgMjAyMyAwNzoyNDo1OSAtMDQwMCwgIk1pY2hhZWwgUy4gVHNpcmtpbiIg
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiBPbiBNb24sIEF1ZyAxNCwgMjAyMyBhdCAwNDo1Njo1
M1BNICswODAwLCBYdWFuIFpodW8gd3JvdGU6Cj4gPiBPbiBNb24sIDE0IEF1ZyAyMDIzIDExOjA1
OjQ5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4g
T24gVGh1LCBBdWcgMTAsIDIwMjMgYXQgODozMeKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gQWRkZWQgdmlydHF1ZXVlX2Rt
YV9kZXYoKSB0byBnZXQgRE1BIGRldmljZSBmb3IgdmlydGlvLiBUaGVuIHRoZQo+ID4gPiA+IGNh
bGxlciBjYW4gZG8gZG1hIG9wZXJhdGlvbiBpbiBhZHZhbmNlLiBUaGUgcHVycG9zZSBpcyB0byBr
ZWVwIG1lbW9yeQo+ID4gPiA+IG1hcHBlZCBhY3Jvc3MgbXVsdGlwbGUgYWRkL2dldCBidWYgb3Bl
cmF0aW9ucy4KPiA+ID4gPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpo
dW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+ID4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+Cj4gPiA+Cj4gPiA+IFNvIEkgdGhpbmsgd2UgZG9uJ3QgaGF2ZSBhY3R1
YWwgdXNlcnMgZm9yIHRoaXMgaW4gdGhpcyBzZXJpZXM/IENhbiB3ZQo+ID4gPiBzaW1wbHkgaGF2
ZSBhbm90aGVyIGluZGVwZW5kZW50IHBhdGNoIGZvciB0aGlzPwo+ID4KPiA+IEkgYW0gb2suIEkg
d2lsbCByZW1vdmUgdGhpcyBmcm9tIHRoZSBuZXh0IHZlcnNpb24uCj4gPgo+ID4gQnV0IEkgYWxz
byBoZWxwIG1lcmdlIHRoaXMgdG8gNi42LiBUaGVuIHdlIGNhbiBsZXQgdGhlIHZpcnRpby1uZXQg
dG8gc3VwcG9ydAo+ID4gQUZfWERQIGluIDYuNysuCj4KPiBJcyB0aGVyZSBnb2luZyB0byBiZSBh
IG5leHQgdmVyc2lvbj8gQmVjYXVzZSBpZiB5ZXMgaXQgd2lsbCBiZSB0b28gbGF0ZSBmb3IgdGhl
IG5leHQgcmVsZWFzZS4KPiBpZiBhbGwgeW91IHdhbnQgdG8gZG8gaXMgZHJvcCB0aGlzIHBhdGNo
IHRoZW4ganVzdCBzYXkgc28sIG5vIG5lZWQKPiBmb3IgYW5vdGhlciB2ZXJzaW9uLgoKCkZvciBt
ZSwgSSB3YW50IHRoYXQgdGhpcyBwYXRjaCBjYW4gYmUgbWVyZ2VkIHRvIDYuNi4gQmVjYXVzZSB0
aGF0IHRoZSBBRl9YRFAKbmVlZHMgdGhpcy4KClRoYW5rcy4KCgo+Cj4gPgo+ID4gPgo+ID4gPiA+
IC0tLQo+ID4gPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMTcgKysrKysrKysr
KysrKysrKysKPiA+ID4gPiAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAyICsrCj4g
PiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQo+ID4gPiA+Cj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gPiA+ID4gaW5kZXggZjlmNzcyZTg1YTM4Li5iYjNkNzNkMjIxY2Qg
MTAwNjQ0Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gPiBAQCAtMjI2NSw2ICsy
MjY1LDIzIEBAIGludCB2aXJ0cXVldWVfYWRkX2luYnVmX2N0eChzdHJ1Y3QgdmlydHF1ZXVlICp2
cSwKPiA+ID4gPiAgfQo+ID4gPiA+ICBFWFBPUlRfU1lNQk9MX0dQTCh2aXJ0cXVldWVfYWRkX2lu
YnVmX2N0eCk7Cj4gPiA+ID4KPiA+ID4gPiArLyoqCj4gPiA+ID4gKyAqIHZpcnRxdWV1ZV9kbWFf
ZGV2IC0gZ2V0IHRoZSBkbWEgZGV2Cj4gPiA+ID4gKyAqIEBfdnE6IHRoZSBzdHJ1Y3QgdmlydHF1
ZXVlIHdlJ3JlIHRhbGtpbmcgYWJvdXQuCj4gPiA+ID4gKyAqCj4gPiA+ID4gKyAqIFJldHVybnMg
dGhlIGRtYSBkZXYuIFRoYXQgY2FuIGJlZW4gdXNlZCBmb3IgZG1hIGFwaS4KPiA+ID4gPiArICov
Cj4gPiA+ID4gK3N0cnVjdCBkZXZpY2UgKnZpcnRxdWV1ZV9kbWFfZGV2KHN0cnVjdCB2aXJ0cXVl
dWUgKl92cSkKPiA+ID4gPiArewo+ID4gPiA+ICsgICAgICAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZSAqdnEgPSB0b192dnEoX3ZxKTsKPiA+ID4gPiArCj4gPiA+ID4gKyAgICAgICBpZiAodnEtPnVz
ZV9kbWFfYXBpKQo+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gdnJpbmdfZG1hX2Rldih2
cSk7Cj4gPiA+ID4gKyAgICAgICBlbHNlCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBO
VUxMOwo+ID4gPiA+ICt9Cj4gPiA+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9kbWFf
ZGV2KTsKPiA+ID4KPiA+ID4gT25lIHBvc3NpYmxlIGNvbmNlcm4gaXMgdGhhdCBleHBvcnRpbmcg
dGhpbmdzIGxpa2UgTlVMTCBtYXkgcmVzdWx0IGluCj4gPiA+IHRoZSBzd2l0Y2ggaW4gdGhlIGNh
bGxlciAoZHJpdmVyKS4gSSB3b25kZXIgaWYgaXQncyBiZXR0ZXIgdG8gZG8KPiA+ID4gQlVHX09O
KCkgaW4gdGhlIHBhdGggb2YgTlVMTD8KPiA+Cj4gPgo+ID4gSSBhZ3JlZS4KPiA+Cj4gPiBCdXQg
d2UgbmVlZCBhIG5ldyBoZWxwZXIgdG8gdGVsbCB0aGUgZHJpdmVyKG9yIEFGX1hEUCkgdGhhdCB0
aGUgZGV2aWNlIHN1cHBvcnQKPiA+IEFDQ0VTU19QTEFURk9STSBvciBub3QuCj4gPgo+ID4gV2Ug
bmVlZCBhIHN3aXRjaCwgYnV0IHdlIGNhbiBtYWtlIHRoZSBzd2l0Y2ggaXMgaXJyZWxldmFudCB0
byB0aGUgRE1BLgo+ID4KPiA+IFRoYW5rcy4KPiA+Cj4gPgo+ID4KPiA+ID4KPiA+ID4gVGhhbmtz
Cj4gPiA+Cj4gPiA+ID4gKwo+ID4gPiA+ICAvKioKPiA+ID4gPiAgICogdmlydHF1ZXVlX2tpY2tf
cHJlcGFyZSAtIGZpcnN0IGhhbGYgb2Ygc3BsaXQgdmlydHF1ZXVlX2tpY2sgY2FsbC4KPiA+ID4g
PiAgICogQF92cTogdGhlIHN0cnVjdCB2aXJ0cXVldWUKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC92aXJ0aW8uaCBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiA+ID4gPiBpbmRl
eCA4YWRkMzgwMzg4NzcuLmJkNTVhMDVlZWMwNCAxMDA2NDQKPiA+ID4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L3ZpcnRpby5oCj4gPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ID4g
PiA+IEBAIC02MSw2ICs2MSw4IEBAIGludCB2aXJ0cXVldWVfYWRkX3NncyhzdHJ1Y3QgdmlydHF1
ZXVlICp2cSwKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqZGF0YSwKPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgZ2ZwX3QgZ2ZwKTsKPiA+ID4gPgo+ID4gPiA+ICtzdHJ1
Y3QgZGV2aWNlICp2aXJ0cXVldWVfZG1hX2RldihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gPiA+
ID4gKwo+ID4gPiA+ICBib29sIHZpcnRxdWV1ZV9raWNrKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsK
PiA+ID4gPgo+ID4gPiA+ICBib29sIHZpcnRxdWV1ZV9raWNrX3ByZXBhcmUoc3RydWN0IHZpcnRx
dWV1ZSAqdnEpOwo+ID4gPiA+IC0tCj4gPiA+ID4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+ID4gPiA+
Cj4gPiA+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
