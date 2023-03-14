Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3946AC6FD1C
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 09:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD28A606C6;
	Tue, 14 Mar 2023 09:23:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD28A606C6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EzpM5IVai1hX; Tue, 14 Mar 2023 09:23:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4920060742;
	Tue, 14 Mar 2023 09:23:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4920060742
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17973C0035;
	Tue, 14 Mar 2023 09:23:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7572C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 09:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DFC881456
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 09:23:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7DFC881456
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mpBsyQU-hAJy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 09:23:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD97C8141F
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD97C8141F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 09:23:24 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0Vdrspcv_1678785799; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vdrspcv_1678785799) by smtp.aliyun-inc.com;
 Tue, 14 Mar 2023 17:23:20 +0800
Message-ID: <1678785506.21071-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v2 08/12] virtio_ring: update document for
 virtqueue_add_*
Date: Tue, 14 Mar 2023 17:18:26 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
 <20230308064443.50639-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEvh2Hxym5Xo_nwzHYa-0chNnM82FcuzRK_TXUy5K5s3rg@mail.gmail.com>
In-Reply-To: <CACGkMEvh2Hxym5Xo_nwzHYa-0chNnM82FcuzRK_TXUy5K5s3rg@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCAxNCBNYXIgMjAyMyAxNTo1ODoyMiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gV2VkLCBNYXIgOCwgMjAyMyBhdCAyOjQ04oCvUE0gWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gVXBkYXRl
IHRoZSBkb2N1bWVudCBvZiB2aXJ0cXVldWVfYWRkXyogc2VyaWVzIEFQSSwgYWxsb3dpbmcgdGhl
IGNhbGxlcnMgdG8KPiA+IHVzZSBzZy0+ZG1hX2FkZHJlc3MgdG8gcGFzcyB0aGUgZG1hIGFkZHJl
c3MgdG8gVmlydGlvIENvcmUuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFu
emh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgfCAxNiArKysrKysrKysrKysrKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGlu
c2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IGluZGV4IGIyM2QzMDFlZmZi
NS4uMjE2YWM4NjU0OTgyIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gQEAgLTIxOTAs
NiArMjE5MCwxMCBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkKHN0cnVjdCB2aXJ0
cXVldWUgKl92cSwKPiA+ICAgKiBDYWxsZXIgbXVzdCBlbnN1cmUgd2UgZG9uJ3QgY2FsbCB0aGlz
IHdpdGggb3RoZXIgdmlydHF1ZXVlIG9wZXJhdGlvbnMKPiA+ICAgKiBhdCB0aGUgc2FtZSB0aW1l
IChleGNlcHQgd2hlcmUgbm90ZWQpLgo+ID4gICAqCj4gPiArICogSWYgdGhlIGNhbGxlciBoYXMg
ZG9uZSBkbWEgbWFwIHRoZW4gdXNlIHNnLT5kbWFfYWRkcmVzcyB0byBwYXNzIGRtYSBhZGRyZXNz
Lgo+ID4gKyAqIElmIG9uZSBzZy0+ZG1hX2FkZHJlc3MgaXMgdXNlZCwgdGhlbiBhbGwgc2dzIG11
c3QgdXNlIHNnLT5kbWFfYWRkcmVzczsKPiA+ICsgKiBvdGhlcndpc2UgYWxsIHNnLT5kbWFfYWRk
cmVzcyBtdXN0IGJlIE5VTEwuCj4KPiBJcyBpdCB3b3J0aCBhZGRpbmcgY2hlY2tzIGZvciB0aG9z
ZSByZXF1aXJlbWVudHM/CgpJZiB3ZSB3YW50IHRvIGNoZWNrLCB3ZSBuZWVkIHRvIGNoZWNrIGV2
ZXJ5IFNHLCBhbmQgSSB0aGluayB0aGUgb3ZlcmhlYWQgaXMgYQpiaXQgYmlnLgoKSWYgdGhlIGRy
aXZlciBpcyBub3QgaW1wbGVtZW50ZWQgYXMgdGhlc2UgcmVxdWlyZW1lbnRzLCBJIHRoaW5rIGhl
IHdpbGwgYWx3YXlzCmVuY291bnRlciBzb21lIGFibm9ybWFsaXRpZXMgd2hlbiB0ZXN0aW5nLgoK
VGhhbmtzLgoKPgo+IFRoYW5rcwo+Cj4gPiArICoKPiA+ICAgKiBSZXR1cm5zIHplcm8gb3IgYSBu
ZWdhdGl2ZSBlcnJvciAoaWUuIEVOT1NQQywgRU5PTUVNLCBFSU8pLgo+ID4gICAqLwo+ID4gIGlu
dCB2aXJ0cXVldWVfYWRkX3NncyhzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gPiBAQCAtMjIyNCw2
ICsyMjI4LDEwIEBAIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9hZGRfc2dzKTsKPiA+ICAg
KiBDYWxsZXIgbXVzdCBlbnN1cmUgd2UgZG9uJ3QgY2FsbCB0aGlzIHdpdGggb3RoZXIgdmlydHF1
ZXVlIG9wZXJhdGlvbnMKPiA+ICAgKiBhdCB0aGUgc2FtZSB0aW1lIChleGNlcHQgd2hlcmUgbm90
ZWQpLgo+ID4gICAqCj4gPiArICogSWYgdGhlIGNhbGxlciBoYXMgZG9uZSBkbWEgbWFwIHRoZW4g
dXNlIHNnLT5kbWFfYWRkcmVzcyB0byBwYXNzIGRtYSBhZGRyZXNzLgo+ID4gKyAqIElmIG9uZSBz
Zy0+ZG1hX2FkZHJlc3MgaXMgdXNlZCwgdGhlbiBhbGwgc2dzIG11c3QgdXNlIHNnLT5kbWFfYWRk
cmVzczsKPiA+ICsgKiBvdGhlcndpc2UgYWxsIHNnLT5kbWFfYWRkcmVzcyBtdXN0IGJlIE5VTEwu
Cj4gPiArICoKPiA+ICAgKiBSZXR1cm5zIHplcm8gb3IgYSBuZWdhdGl2ZSBlcnJvciAoaWUuIEVO
T1NQQywgRU5PTUVNLCBFSU8pLgo+ID4gICAqLwo+ID4gIGludCB2aXJ0cXVldWVfYWRkX291dGJ1
ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwKPiA+IEBAIC0yMjQ2LDYgKzIyNTQsMTAgQEAgRVhQT1JU
X1NZTUJPTF9HUEwodmlydHF1ZXVlX2FkZF9vdXRidWYpOwo+ID4gICAqIENhbGxlciBtdXN0IGVu
c3VyZSB3ZSBkb24ndCBjYWxsIHRoaXMgd2l0aCBvdGhlciB2aXJ0cXVldWUgb3BlcmF0aW9ucwo+
ID4gICAqIGF0IHRoZSBzYW1lIHRpbWUgKGV4Y2VwdCB3aGVyZSBub3RlZCkuCj4gPiAgICoKPiA+
ICsgKiBJZiB0aGUgY2FsbGVyIGhhcyBkb25lIGRtYSBtYXAgdGhlbiB1c2Ugc2ctPmRtYV9hZGRy
ZXNzIHRvIHBhc3MgZG1hIGFkZHJlc3MuCj4gPiArICogSWYgb25lIHNnLT5kbWFfYWRkcmVzcyBp
cyB1c2VkLCB0aGVuIGFsbCBzZ3MgbXVzdCB1c2Ugc2ctPmRtYV9hZGRyZXNzOwo+ID4gKyAqIG90
aGVyd2lzZSBhbGwgc2ctPmRtYV9hZGRyZXNzIG11c3QgYmUgTlVMTC4KPiA+ICsgKgo+ID4gICAq
IFJldHVybnMgemVybyBvciBhIG5lZ2F0aXZlIGVycm9yIChpZS4gRU5PU1BDLCBFTk9NRU0sIEVJ
TykuCj4gPiAgICovCj4gPiAgaW50IHZpcnRxdWV1ZV9hZGRfaW5idWYoc3RydWN0IHZpcnRxdWV1
ZSAqdnEsCj4gPiBAQCAtMjI2OSw2ICsyMjgxLDEwIEBAIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRx
dWV1ZV9hZGRfaW5idWYpOwo+ID4gICAqIENhbGxlciBtdXN0IGVuc3VyZSB3ZSBkb24ndCBjYWxs
IHRoaXMgd2l0aCBvdGhlciB2aXJ0cXVldWUgb3BlcmF0aW9ucwo+ID4gICAqIGF0IHRoZSBzYW1l
IHRpbWUgKGV4Y2VwdCB3aGVyZSBub3RlZCkuCj4gPiAgICoKPiA+ICsgKiBJZiB0aGUgY2FsbGVy
IGhhcyBkb25lIGRtYSBtYXAgdGhlbiB1c2Ugc2ctPmRtYV9hZGRyZXNzIHRvIHBhc3MgZG1hIGFk
ZHJlc3MuCj4gPiArICogSWYgb25lIHNnLT5kbWFfYWRkcmVzcyBpcyB1c2VkLCB0aGVuIGFsbCBz
Z3MgbXVzdCB1c2Ugc2ctPmRtYV9hZGRyZXNzOwo+ID4gKyAqIG90aGVyd2lzZSBhbGwgc2ctPmRt
YV9hZGRyZXNzIG11c3QgYmUgTlVMTC4KPiA+ICsgKgo+ID4gICAqIFJldHVybnMgemVybyBvciBh
IG5lZ2F0aXZlIGVycm9yIChpZS4gRU5PU1BDLCBFTk9NRU0sIEVJTykuCj4gPiAgICovCj4gPiAg
aW50IHZpcnRxdWV1ZV9hZGRfaW5idWZfY3R4KHN0cnVjdCB2aXJ0cXVldWUgKnZxLAo+ID4gLS0K
PiA+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPiA+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
