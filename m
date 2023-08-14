Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1092DEB64DD
	for <virtualization@archiver.kernel.org>; Mon, 14 Aug 2023 09:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 699A440A67;
	Mon, 14 Aug 2023 09:03:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 699A440A67
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id njnOvo1iO7hP; Mon, 14 Aug 2023 09:03:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E519C40A6B;
	Mon, 14 Aug 2023 09:03:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E519C40A6B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BD19C0072;
	Mon, 14 Aug 2023 09:03:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B0A3C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 09:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E69B5812A0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 09:03:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E69B5812A0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KVtOH_Ck1TRZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 09:03:40 +0000 (UTC)
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3755A8129F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 09:03:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3755A8129F
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R541e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VpjgjX-_1692003812; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VpjgjX-_1692003812) by smtp.aliyun-inc.com;
 Mon, 14 Aug 2023 17:03:33 +0800
Message-ID: <1692003413.6339955-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
Date: Mon, 14 Aug 2023 16:56:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
In-Reply-To: <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
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

T24gTW9uLCAxNCBBdWcgMjAyMyAxMTowNTo0OSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBBdWcgMTAsIDIwMjMgYXQgODozMeKAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IEFkZGVk
IHZpcnRxdWV1ZV9kbWFfZGV2KCkgdG8gZ2V0IERNQSBkZXZpY2UgZm9yIHZpcnRpby4gVGhlbiB0
aGUKPiA+IGNhbGxlciBjYW4gZG8gZG1hIG9wZXJhdGlvbiBpbiBhZHZhbmNlLiBUaGUgcHVycG9z
ZSBpcyB0byBrZWVwIG1lbW9yeQo+ID4gbWFwcGVkIGFjcm9zcyBtdWx0aXBsZSBhZGQvZ2V0IGJ1
ZiBvcGVyYXRpb25zLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9A
bGludXguYWxpYmFiYS5jb20+Cj4gPiBBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KPgo+IFNvIEkgdGhpbmsgd2UgZG9uJ3QgaGF2ZSBhY3R1YWwgdXNlcnMgZm9yIHRo
aXMgaW4gdGhpcyBzZXJpZXM/IENhbiB3ZQo+IHNpbXBseSBoYXZlIGFub3RoZXIgaW5kZXBlbmRl
bnQgcGF0Y2ggZm9yIHRoaXM/CgpJIGFtIG9rLiBJIHdpbGwgcmVtb3ZlIHRoaXMgZnJvbSB0aGUg
bmV4dCB2ZXJzaW9uLgoKQnV0IEkgYWxzbyBoZWxwIG1lcmdlIHRoaXMgdG8gNi42LiBUaGVuIHdl
IGNhbiBsZXQgdGhlIHZpcnRpby1uZXQgdG8gc3VwcG9ydApBRl9YRFAgaW4gNi43Ky4KCgo+Cj4g
PiAtLS0KPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMTcgKysrKysrKysrKysr
KysrKysKPiA+ICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgIHwgIDIgKysKPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+
IGluZGV4IGY5Zjc3MmU4NWEzOC4uYmIzZDczZDIyMWNkIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+ID4gQEAgLTIyNjUsNiArMjI2NSwyMyBAQCBpbnQgdmlydHF1ZXVlX2FkZF9pbmJ1Zl9j
dHgoc3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4gPiAgfQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKHZp
cnRxdWV1ZV9hZGRfaW5idWZfY3R4KTsKPiA+Cj4gPiArLyoqCj4gPiArICogdmlydHF1ZXVlX2Rt
YV9kZXYgLSBnZXQgdGhlIGRtYSBkZXYKPiA+ICsgKiBAX3ZxOiB0aGUgc3RydWN0IHZpcnRxdWV1
ZSB3ZSdyZSB0YWxraW5nIGFib3V0Lgo+ID4gKyAqCj4gPiArICogUmV0dXJucyB0aGUgZG1hIGRl
di4gVGhhdCBjYW4gYmVlbiB1c2VkIGZvciBkbWEgYXBpLgo+ID4gKyAqLwo+ID4gK3N0cnVjdCBk
ZXZpY2UgKnZpcnRxdWV1ZV9kbWFfZGV2KHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiA+ICt7Cj4g
PiArICAgICAgIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gPiAr
Cj4gPiArICAgICAgIGlmICh2cS0+dXNlX2RtYV9hcGkpCj4gPiArICAgICAgICAgICAgICAgcmV0
dXJuIHZyaW5nX2RtYV9kZXYodnEpOwo+ID4gKyAgICAgICBlbHNlCj4gPiArICAgICAgICAgICAg
ICAgcmV0dXJuIE5VTEw7Cj4gPiArfQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9k
bWFfZGV2KTsKPgo+IE9uZSBwb3NzaWJsZSBjb25jZXJuIGlzIHRoYXQgZXhwb3J0aW5nIHRoaW5n
cyBsaWtlIE5VTEwgbWF5IHJlc3VsdCBpbgo+IHRoZSBzd2l0Y2ggaW4gdGhlIGNhbGxlciAoZHJp
dmVyKS4gSSB3b25kZXIgaWYgaXQncyBiZXR0ZXIgdG8gZG8KPiBCVUdfT04oKSBpbiB0aGUgcGF0
aCBvZiBOVUxMPwoKCkkgYWdyZWUuCgpCdXQgd2UgbmVlZCBhIG5ldyBoZWxwZXIgdG8gdGVsbCB0
aGUgZHJpdmVyKG9yIEFGX1hEUCkgdGhhdCB0aGUgZGV2aWNlIHN1cHBvcnQKQUNDRVNTX1BMQVRG
T1JNIG9yIG5vdC4KCldlIG5lZWQgYSBzd2l0Y2gsIGJ1dCB3ZSBjYW4gbWFrZSB0aGUgc3dpdGNo
IGlzIGlycmVsZXZhbnQgdG8gdGhlIERNQS4KClRoYW5rcy4KCgoKPgo+IFRoYW5rcwo+Cj4gPiAr
Cj4gPiAgLyoqCj4gPiAgICogdmlydHF1ZXVlX2tpY2tfcHJlcGFyZSAtIGZpcnN0IGhhbGYgb2Yg
c3BsaXQgdmlydHF1ZXVlX2tpY2sgY2FsbC4KPiA+ICAgKiBAX3ZxOiB0aGUgc3RydWN0IHZpcnRx
dWV1ZQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvLmggYi9pbmNsdWRlL2xp
bnV4L3ZpcnRpby5oCj4gPiBpbmRleCA4YWRkMzgwMzg4NzcuLmJkNTVhMDVlZWMwNCAxMDA2NDQK
PiA+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiA+ICsrKyBiL2luY2x1ZGUvbGludXgv
dmlydGlvLmgKPiA+IEBAIC02MSw2ICs2MSw4IEBAIGludCB2aXJ0cXVldWVfYWRkX3NncyhzdHJ1
Y3QgdmlydHF1ZXVlICp2cSwKPiA+ICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpkYXRhLAo+
ID4gICAgICAgICAgICAgICAgICAgICAgIGdmcF90IGdmcCk7Cj4gPgo+ID4gK3N0cnVjdCBkZXZp
Y2UgKnZpcnRxdWV1ZV9kbWFfZGV2KHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiA+ICsKPiA+ICBi
b29sIHZpcnRxdWV1ZV9raWNrKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiA+Cj4gPiAgYm9vbCB2
aXJ0cXVldWVfa2lja19wcmVwYXJlKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiA+IC0tCj4gPiAy
LjMyLjAuMy5nMDExOTVjZjlmCj4gPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
