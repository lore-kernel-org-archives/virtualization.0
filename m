Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE17C001B0
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 08:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E49F813F8;
	Tue, 27 Jun 2023 08:53:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E49F813F8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jTFc6OWLBRmt; Tue, 27 Jun 2023 08:53:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DB031813EC;
	Tue, 27 Jun 2023 08:53:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB031813EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF1CCC0072;
	Tue, 27 Jun 2023 08:53:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54B01C0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:53:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F991605BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:53:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F991605BA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2i937d8ftl4W
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:53:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 04EFA605AF
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 04EFA605AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:53:35 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R731e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vm57mv3_1687856008; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vm57mv3_1687856008) by smtp.aliyun-inc.com;
 Tue, 27 Jun 2023 16:53:28 +0800
Message-ID: <1687855801.1280077-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 02/10] virtio_ring: introduce
 virtqueue_set_premapped()
Date: Tue, 27 Jun 2023 16:50:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEt3xRvn5na+f4vHjFQoJJcPTvvE3Yd_bGxrDFo9owkqCA@mail.gmail.com>
In-Reply-To: <CACGkMEt3xRvn5na+f4vHjFQoJJcPTvvE3Yd_bGxrDFo9owkqCA@mail.gmail.com>
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

T24gVHVlLCAyNyBKdW4gMjAyMyAxNjowMzoyMyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gRnJpLCBKdW4gMiwgMjAyMyBhdCA1OjIy4oCvUE0gWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gVGhpcyBo
ZWxwZXIgYWxsb3dzIHRoZSBkcml2ZXIgY2hhbmdlIHRoZSBkbWEgbW9kZSB0byBwcmVtYXBwZWQg
bW9kZS4KPiA+IFVuZGVyIHRoZSBwcmVtYXBwZWQgbW9kZSwgdGhlIHZpcnRpbyBjb3JlIGRvIG5v
dCBkbyBkbWEgbWFwcGluZwo+ID4gaW50ZXJuYWxseS4KPiA+Cj4gPiBUaGlzIGp1c3Qgd29yayB3
aGVuIHRoZSB1c2VfZG1hX2FwaSBpcyB0cnVlLiBJZiB0aGUgdXNlX2RtYV9hcGkgaXMgZmFsc2Us
Cj4gPiB0aGUgZG1hIG9wdGlvbnMgaXMgbm90IHRocm91Z2ggdGhlIERNQSBBUElzLCB0aGF0IGlz
IG5vdCB0aGUgc3RhbmRhcmQKPiA+IHdheSBvZiB0aGUgbGludXgga2VybmVsLgo+ID4KPiA+IFNp
Z25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAt
LS0KPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNDAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCj4gPiAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8
ICAyICsrCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gPiBpbmRleCA3MmVkMDdhNjA0ZDQuLjJhZmRmYjllM2UzMCAxMDA2NDQK
PiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ICsrKyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IEBAIC0xNzIsNiArMTcyLDkgQEAgc3RydWN0IHZyaW5n
X3ZpcnRxdWV1ZSB7Cj4gPiAgICAgICAgIC8qIEhvc3QgcHVibGlzaGVzIGF2YWlsIGV2ZW50IGlk
eCAqLwo+ID4gICAgICAgICBib29sIGV2ZW50Owo+ID4KPiA+ICsgICAgICAgLyogRG8gRE1BIG1h
cHBpbmcgYnkgZHJpdmVyICovCj4gPiArICAgICAgIGJvb2wgcHJlbWFwcGVkOwo+ID4gKwo+ID4g
ICAgICAgICAvKiBIZWFkIG9mIGZyZWUgYnVmZmVyIGxpc3QuICovCj4gPiAgICAgICAgIHVuc2ln
bmVkIGludCBmcmVlX2hlYWQ7Cj4gPiAgICAgICAgIC8qIE51bWJlciB3ZSd2ZSBhZGRlZCBzaW5j
ZSBsYXN0IHN5bmMuICovCj4gPiBAQCAtMjA1OSw2ICsyMDYyLDcgQEAgc3RhdGljIHN0cnVjdCB2
aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+ID4gICAgICAgICB2cS0+
cGFja2VkX3JpbmcgPSB0cnVlOwo+ID4gICAgICAgICB2cS0+ZG1hX2RldiA9IGRtYV9kZXY7Cj4g
PiAgICAgICAgIHZxLT51c2VfZG1hX2FwaSA9IHZyaW5nX3VzZV9kbWFfYXBpKHZkZXYpOwo+ID4g
KyAgICAgICB2cS0+cHJlbWFwcGVkID0gZmFsc2U7Cj4gPgo+ID4gICAgICAgICB2cS0+aW5kaXJl
Y3QgPSB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX1JJTkdfRl9JTkRJUkVDVF9ERVND
KSAmJgo+ID4gICAgICAgICAgICAgICAgICFjb250ZXh0Owo+ID4gQEAgLTI1NDgsNiArMjU1Miw3
IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWdu
ZWQgaW50IGluZGV4LAo+ID4gICNlbmRpZgo+ID4gICAgICAgICB2cS0+ZG1hX2RldiA9IGRtYV9k
ZXY7Cj4gPiAgICAgICAgIHZxLT51c2VfZG1hX2FwaSA9IHZyaW5nX3VzZV9kbWFfYXBpKHZkZXYp
Owo+ID4gKyAgICAgICB2cS0+cHJlbWFwcGVkID0gZmFsc2U7Cj4gPgo+ID4gICAgICAgICB2cS0+
aW5kaXJlY3QgPSB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX1JJTkdfRl9JTkRJUkVD
VF9ERVNDKSAmJgo+ID4gICAgICAgICAgICAgICAgICFjb250ZXh0Owo+ID4gQEAgLTI2OTEsNiAr
MjY5Niw0MSBAQCBpbnQgdmlydHF1ZXVlX3Jlc2l6ZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsIHUz
MiBudW0sCj4gPiAgfQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9yZXNpemUpOwo+
ID4KPiA+ICsvKioKPiA+ICsgKiB2aXJ0cXVldWVfc2V0X3ByZW1hcHBlZCAtIHNldCB0aGUgdnJp
bmcgcHJlbWFwcGVkIG1vZGUKPiA+ICsgKiBAX3ZxOiB0aGUgc3RydWN0IHZpcnRxdWV1ZSB3ZSdy
ZSB0YWxraW5nIGFib3V0Lgo+ID4gKyAqCj4gPiArICogRW5hYmxlIHRoZSBwcmVtYXBwZWQgbW9k
ZSBvZiB0aGUgdnEuCj4gPiArICoKPiA+ICsgKiBUaGUgdnJpbmcgaW4gcHJlbWFwcGVkIG1vZGUg
ZG9lcyBub3QgZG8gZG1hIGludGVybmFsbHksIHNvIHRoZSBkcml2ZXIgbXVzdAo+ID4gKyAqIGRv
IGRtYSBtYXBwaW5nIGluIGFkdmFuY2UuIFRoZSBkcml2ZXIgbXVzdCBwYXNzIHRoZSBkbWFfYWRk
cmVzcyB0aHJvdWdoCj4gPiArICogZG1hX2FkZHJlc3Mgb2Ygc2NhdHRlcmxpc3QuIFdoZW4gdGhl
IGRyaXZlciBnb3QgYSB1c2VkIGJ1ZmZlciBmcm9tCj4gPiArICogdGhlIHZyaW5nLCBpdCBoYXMg
dG8gdW5tYXAgdGhlIGRtYSBhZGRyZXNzLiBTbyB0aGUgZHJpdmVyIG11c3QgY2FsbAo+ID4gKyAq
IHZpcnRxdWV1ZV9nZXRfYnVmX3ByZW1hcHBlZCgpL3ZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1
Zl9wcmVtYXBwZWQoKS4KPiA+ICsgKgo+ID4gKyAqIFRoaXMgbXVzdCBiZSBjYWxsZWQgYmVmb3Jl
IGFkZGluZyBhbnkgYnVmIHRvIHZyaW5nLgo+Cj4gQW5kIGFueSBvbGQgYnVmZmVyIHNob3VsZCBi
ZSBkZXRhY2hlZD8KCkkgbWVhbiB0aGF0IGJlZm9yZSBhZGRpbmcgYW55IGJ1ZiwgU28gdGhlcmUg
YXJlIG5vdCBvbGQgYnVmZmVyLgoKCj4KPiA+ICsgKiBTbyB0aGlzIHNob3VsZCBiZSBjYWxsZWQg
aW1tZWRpYXRlbHkgYWZ0ZXIgaW5pdCB2cSBvciB2cSByZXNldC4KPgo+IEFueSB3YXkgdG8gZGV0
ZWN0IGFuZCB3YXJuIGluIHRoaXMgY2FzZT8gKG5vdCBhIG11c3QgaWYgaXQncyB0b28KPiBleHBl
bnNpdmUgdG8gZG8gdGhlIGNoZWNrKQoKCkkgY2FuIHRyeSB0byBjaGVjayB3aGV0aGVyIHRoZSBx
ZXVldSBpcyBlbXB0eS4KCgo+Cj4gPiArICoKPiA+ICsgKiBDYWxsZXIgbXVzdCBlbnN1cmUgd2Ug
ZG9uJ3QgY2FsbCB0aGlzIHdpdGggb3RoZXIgdmlydHF1ZXVlIG9wZXJhdGlvbnMKPiA+ICsgKiBh
dCB0aGUgc2FtZSB0aW1lIChleGNlcHQgd2hlcmUgbm90ZWQpLgo+ID4gKyAqCj4gPiArICogUmV0
dXJucyB6ZXJvIG9yIGEgbmVnYXRpdmUgZXJyb3IuCj4gPiArICogMDogc3VjY2Vzcy4KPiA+ICsg
KiAtRUlOVkFMOiB2cmluZyBkb2VzIG5vdCB1c2UgdGhlIGRtYSBhcGksIHNvIHdlIGNhbiBub3Qg
ZW5hYmxlIHByZW1hcHBlZCBtb2RlLgo+ID4gKyAqLwo+ID4gK2ludCB2aXJ0cXVldWVfc2V0X3By
ZW1hcHBlZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gPiArewo+ID4gKyAgICAgICBzdHJ1Y3Qg
dnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gKwo+ID4gKyAgICAgICBpZiAo
IXZxLT51c2VfZG1hX2FwaSkKPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+
ICsKPiA+ICsgICAgICAgdnEtPnByZW1hcHBlZCA9IHRydWU7Cj4KPiBJIGd1ZXNzIHRoZXJlIHNo
b3VsZCBiZSBhIHdheSB0byBkaXNhYmxlIGl0LiBXb3VsZCBpdCBiZSB1c2VmdWwgZm9yCj4gdGhl
IGNhc2Ugd2hlbiBBRl9YRFAgc29ja2V0cyB3ZXJlIGRlc3Ryb3llZD8KClllcy4KCldoZW4gd2Ug
cmVzZXQgdGhlIHF1ZXVlLCB0aGUgdnEtPnByZW1hcHBlZCB3aWxsIGJlIHNldCB0byAwLgoKVGhl
IGlzIGNhbGxlZCBhZnRlciBmaW5kX3ZxcyBvciByZXNldCB2cS4KClRoYW5rcy4KCgoKPgo+IFRo
YW5rcwo+Cj4KPiA+ICsKPiA+ICsgICAgICAgcmV0dXJuIDA7Cj4gPiArfQo+ID4gK0VYUE9SVF9T
WU1CT0xfR1BMKHZpcnRxdWV1ZV9zZXRfcHJlbWFwcGVkKTsKPiA+ICsKPiA+ICAvKiBPbmx5IGF2
YWlsYWJsZSBmb3Igc3BsaXQgcmluZyAqLwo+ID4gIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX25l
d192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgbnVtLAo+ID4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvdmlydGlvLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiBpbmRleCBiOTMy
MzhkYjk0ZTMuLjFmYzBlMTAyM2JkNCAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvdmly
dGlvLmgKPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiA+IEBAIC03OCw2ICs3OCw4
IEBAIGJvb2wgdmlydHF1ZXVlX2VuYWJsZV9jYihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gPgo+
ID4gIHVuc2lnbmVkIHZpcnRxdWV1ZV9lbmFibGVfY2JfcHJlcGFyZShzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSk7Cj4gPgo+ID4gK2ludCB2aXJ0cXVldWVfc2V0X3ByZW1hcHBlZChzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEpOwo+ID4gKwo+ID4gIGJvb2wgdmlydHF1ZXVlX3BvbGwoc3RydWN0IHZpcnRxdWV1
ZSAqdnEsIHVuc2lnbmVkKTsKPiA+Cj4gPiAgYm9vbCB2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5
ZWQoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ID4gLS0KPiA+IDIuMzIuMC4zLmcwMTE5NWNmOWYK
PiA+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
