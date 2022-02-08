Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4970C43219
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 03:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B84281458;
	Tue,  8 Feb 2022 03:18:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4uuHtFycwr_p; Tue,  8 Feb 2022 03:18:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 21CA9813B9;
	Tue,  8 Feb 2022 03:18:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0627C001A;
	Tue,  8 Feb 2022 03:18:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA4E8C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A92E6400CE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:18:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NlG_ycNhNkbt
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:18:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E8DC400C8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:17:59 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V3uNet-_1644290275; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V3uNet-_1644290275) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 08 Feb 2022 11:17:56 +0800
Message-Id: <1644290085.868939-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 00/17] virtio pci support VIRTIO_F_RING_RESET
Date: Tue, 08 Feb 2022 11:14:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEspyHTmcSaq9fgpU88VCZGzu21Khp9H+fqL-pb5GLdEpA@mail.gmail.com>
 <1644213739.5846965-1-xuanzhuo@linux.alibaba.com>
 <7d1e2d5b-a9a1-cbb7-4d80-89df1cb7bf15@redhat.com>
In-Reply-To: <7d1e2d5b-a9a1-cbb7-4d80-89df1cb7bf15@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

T24gVHVlLCA4IEZlYiAyMDIyIDEwOjU5OjQ4ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzIvNyDkuIvljYgyOjAyLCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gT24gTW9uLCA3IEZlYiAyMDIyIDExOjM5OjM2ICswODAwLCBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+PiBPbiBXZWQsIEphbiAyNiwgMjAyMiBh
dCAzOjM1IFBNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+
ID4+PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID4+PiBUaGUgdmlydGlvIHNwZWMgYWxyZWFk
eSBzdXBwb3J0cyB0aGUgdmlydGlvIHF1ZXVlIHJlc2V0IGZ1bmN0aW9uLiBUaGlzIHBhdGNoIHNl
dAo+ID4+PiBpcyB0byBhZGQgdGhpcyBmdW5jdGlvbiB0byB0aGUga2VybmVsLiBUaGUgcmVsZXZh
bnQgdmlydGlvIHNwZWMgaW5mb3JtYXRpb24gaXMKPiA+Pj4gaGVyZToKPiA+Pj4KPiA+Pj4gICAg
ICBodHRwczovL2dpdGh1Yi5jb20vb2FzaXMtdGNzL3ZpcnRpby1zcGVjL2lzc3Vlcy8xMjQKPiA+
Pj4KPiA+Pj4gQWxzbyByZWdhcmRpbmcgTU1JTyBzdXBwb3J0IGZvciBxdWV1ZSByZXNldCwgSSBw
bGFuIHRvIHN1cHBvcnQgaXQgYWZ0ZXIgdGhpcwo+ID4+PiBwYXRjaCBpcyBwYXNzZWQuCj4gPj4+
Cj4gPj4+ICMxNC0jMTcgaXMgdGhlIGRpc2FibGUvZW5hYmxlIGZ1bmN0aW9uIG9mIHJ4L3R4IHBh
aXIgaW1wbGVtZW50ZWQgYnkgdmlydGlvLW5ldAo+ID4+PiB1c2luZyB0aGUgbmV3IGhlbHBlci4K
PiA+PiBPbmUgdGhpbmcgdGhhdCBjYW1lIHRvIG1pbmQgaXMgdGhlIHN0ZWVyaW5nLiBFLmcgaWYg
d2UgZGlzYWJsZSBhbiBSWCwKPiA+PiBzaG91bGQgd2Ugc3RvcCBzdGVlcmluZyBwYWNrZXRzIHRv
IHRoYXQgcXVldWU/Cj4gPiBZZXMsIHdlIHNob3VsZCByZXNlbGVjdCBhIHF1ZXVlLgo+ID4KPiA+
IFRoYW5rcy4KPgo+Cj4gTWF5YmUgYSBzcGVjIHBhdGNoIGZvciB0aGF0PwoKWWVzLCBJIGFsc28g
cmVhbGl6ZWQgdGhpcy4gQWx0aG91Z2ggdmlydGlvLW5ldCdzIGRpc2FibGUvZW5hYmxlIGlzIGlt
cGxlbWVudGVkCmJhc2VkIG9uIHF1ZXVlIHJlc2V0LCB2aXJ0aW8tbmV0IHN0aWxsIGhhcyB0byBk
ZWZpbmUgaXRzIG93biBmbGFnIGFuZCBkZWZpbmUKc29tZSBtb3JlIGRldGFpbGVkIGltcGxlbWVu
dGF0aW9ucy4KCkknbGwgdGhpbmsgYWJvdXQgaXQgYW5kIHBvc3QgYSBzcGVjIHBhdGNoLgoKVGhh
bmtzLgoKPgo+IFRoYW5rcwo+Cj4KPiA+Cj4gPj4gVGhhbmtzCj4gPj4KPiA+Pj4gVGhpcyBmdW5j
dGlvbiBpcyBub3QgY3VycmVudGx5IHJlZmVyZW5jZWQgYnkgb3RoZXIKPiA+Pj4gZnVuY3Rpb25z
LiBJdCBpcyBtb3JlIHRvIHNob3cgdGhlIHVzYWdlIG9mIHRoZSBuZXcgaGVscGVyLCBJIG5vdCBz
dXJlIGlmIHRoZXkKPiA+Pj4gYXJlIGdvaW5nIHRvIGJlIG1lcmdlZCB0b2dldGhlci4KPiA+Pj4K
PiA+Pj4gUGxlYXNlIHJldmlldy4gVGhhbmtzLgo+ID4+Pgo+ID4+PiB2MzoKPiA+Pj4gICAgMS4g
a2VlcCB2cSwgaXJxIHVucmVsZWFzZWQKPiA+Pj4KPiA+Pj4gWHVhbiBaaHVvICgxNyk6Cj4gPj4+
ICAgIHZpcnRpb19wY2k6IHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgYWRkIHF1ZXVlX25v
dGlmeV9kYXRhCj4gPj4+ICAgIHZpcnRpbzogcXVldWVfcmVzZXQ6IGFkZCBWSVJUSU9fRl9SSU5H
X1JFU0VUCj4gPj4+ICAgIHZpcnRpbzogcXVldWVfcmVzZXQ6IHN0cnVjdCB2aXJ0aW9fY29uZmln
X29wcyBhZGQgY2FsbGJhY2tzIGZvcgo+ID4+PiAgICAgIHF1ZXVlX3Jlc2V0Cj4gPj4+ICAgIHZp
cnRpbzogcXVldWVfcmVzZXQ6IGFkZCBoZWxwZXIKPiA+Pj4gICAgdnJpdGlvX3Jpbmc6IHF1ZXVl
X3Jlc2V0OiBleHRyYWN0IHRoZSByZWxlYXNlIGZ1bmN0aW9uIG9mIHRoZSB2cSByaW5nCj4gPj4+
ICAgIHZpcnRpb19yaW5nOiBxdWV1ZV9yZXNldDogc3BsaXQ6IGFkZCBfX3ZyaW5nX2luaXRfdmly
dHF1ZXVlKCkKPiA+Pj4gICAgdmlydGlvX3Jpbmc6IHF1ZXVlX3Jlc2V0OiBzcGxpdDogc3VwcG9y
dCBlbmFibGUgcmVzZXQgcXVldWUKPiA+Pj4gICAgdmlydGlvX3Jpbmc6IHF1ZXVlX3Jlc2V0OiBw
YWNrZWQ6IHN1cHBvcnQgZW5hYmxlIHJlc2V0IHF1ZXVlCj4gPj4+ICAgIHZpcnRpb19yaW5nOiBx
dWV1ZV9yZXNldDogYWRkIHZyaW5nX3Jlc2V0X3ZpcnRxdWV1ZSgpCj4gPj4+ICAgIHZpcnRpb19w
Y2k6IHF1ZXVlX3Jlc2V0OiB1cGRhdGUgc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyBhbmQK
PiA+Pj4gICAgICBvcHRpb24gZnVuY3Rpb25zCj4gPj4+ICAgIHZpcnRpb19wY2k6IHF1ZXVlX3Jl
c2V0OiByZWxlYXNlIHZxIGJ5IHZwX2Rldi0+dnFzCj4gPj4+ICAgIHZpcnRpb19wY2k6IHF1ZXVl
X3Jlc2V0OiBzZXR1cF92cSB1c2UgdnJpbmdfc2V0dXBfdmlydHF1ZXVlKCkKPiA+Pj4gICAgdmly
dGlvX3BjaTogcXVldWVfcmVzZXQ6IHN1cHBvcnQgVklSVElPX0ZfUklOR19SRVNFVAo+ID4+PiAg
ICB2aXJ0aW9fbmV0OiB2aXJ0bmV0X3R4X3RpbWVvdXQoKSBmaXggc3R5bGUKPiA+Pj4gICAgdmly
dGlvX25ldDogdmlydG5ldF90eF90aW1lb3V0KCkgc3RvcCByZWYgc3EtPnZxCj4gPj4+ICAgIHZp
cnRpb19uZXQ6IHNwbGl0IGZyZWVfdW51c2VkX2J1ZnMoKQo+ID4+PiAgICB2aXJ0aW9fbmV0OiBz
dXBwb3J0IHBhaXIgZGlzYWJsZS9lbmFibGUKPiA+Pj4KPiA+Pj4gICBkcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgICAgICAgICAgICAgICB8IDIyMCArKysrKysrKysrKysrKysrKysrKysrLS0tCj4g
Pj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYyAgICAgfCAgNjIgKysrKy0t
LQo+ID4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmggICAgIHwgIDExICst
Cj4gPj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYyAgICAgfCAgIDUgKy0K
PiA+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jICAgICB8IDEyMCArKysr
KysrKysrKysrLQo+ID4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2Rldi5j
IHwgIDI4ICsrKysKPiA+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jICAgICAgICAg
ICB8IDE0NCArKysrKysrKysrKy0tLS0tCj4gPj4+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAg
ICAgICAgICAgICAgICAgfCAgIDEgKwo+ID4+PiAgIGluY2x1ZGUvbGludXgvdmlydGlvX2NvbmZp
Zy5oICAgICAgICAgIHwgIDc1ICsrKysrKysrLQo+ID4+PiAgIGluY2x1ZGUvbGludXgvdmlydGlv
X3BjaV9tb2Rlcm4uaCAgICAgIHwgICAyICsKPiA+Pj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19y
aW5nLmggICAgICAgICAgICB8ICA0MiArKystLQo+ID4+PiAgIGluY2x1ZGUvdWFwaS9saW51eC92
aXJ0aW9fY29uZmlnLmggICAgIHwgICA3ICstCj4gPj4+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3Zp
cnRpb19wY2kuaCAgICAgICAgfCAgIDIgKwo+ID4+PiAgIDEzIGZpbGVzIGNoYW5nZWQsIDYxOCBp
bnNlcnRpb25zKCspLCAxMDEgZGVsZXRpb25zKC0pCj4gPj4+Cj4gPj4+IC0tCj4gPj4+IDIuMzEu
MAo+ID4+Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
