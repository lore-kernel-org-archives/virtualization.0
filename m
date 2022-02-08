Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE284C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 07:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EE5960C2F;
	Tue,  8 Feb 2022 07:56:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wbHU4a1uyPlL; Tue,  8 Feb 2022 07:56:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B666D60AAA;
	Tue,  8 Feb 2022 07:56:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89259C0011;
	Tue,  8 Feb 2022 07:56:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08117C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 07:56:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC57D60ABB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 07:56:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wI8WTIlgnGvB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 07:56:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C412C60AAA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 07:56:19 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V3vbOI4_1644306973; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V3vbOI4_1644306973) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 08 Feb 2022 15:56:14 +0800
Message-ID: <1644306673.8360631-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 00/17] virtio pci support VIRTIO_F_RING_RESET
Date: Tue, 8 Feb 2022 15:51:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEspyHTmcSaq9fgpU88VCZGzu21Khp9H+fqL-pb5GLdEpA@mail.gmail.com>
 <1644213739.5846965-1-xuanzhuo@linux.alibaba.com>
 <7d1e2d5b-a9a1-cbb7-4d80-89df1cb7bf15@redhat.com>
 <1644290085.868939-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644290085.868939-2-xuanzhuo@linux.alibaba.com>
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

T24gVHVlLCAwOCBGZWIgMjAyMiAxMToxNDo0NSArMDgwMCwgWHVhbiBaaHVvIDx4dWFuemh1b0Bs
aW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gT24gVHVlLCA4IEZlYiAyMDIyIDEwOjU5OjQ4ICsw
ODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiDlnKgg
MjAyMi8yLzcg5LiL5Y2IMjowMiwgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gT24gTW9uLCA3IEZl
YiAyMDIyIDExOjM5OjM2ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPiA+ID4+IE9uIFdlZCwgSmFuIDI2LCAyMDIyIGF0IDM6MzUgUE0gWHVhbiBaaHVvIDx4
dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+Pj4gPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KPiA+ID4+PiBUaGUgdmlydGlvIHNwZWMgYWxyZWFkeSBzdXBwb3J0cyB0aGUgdmly
dGlvIHF1ZXVlIHJlc2V0IGZ1bmN0aW9uLiBUaGlzIHBhdGNoIHNldAo+ID4gPj4+IGlzIHRvIGFk
ZCB0aGlzIGZ1bmN0aW9uIHRvIHRoZSBrZXJuZWwuIFRoZSByZWxldmFudCB2aXJ0aW8gc3BlYyBp
bmZvcm1hdGlvbiBpcwo+ID4gPj4+IGhlcmU6Cj4gPiA+Pj4KPiA+ID4+PiAgICAgIGh0dHBzOi8v
Z2l0aHViLmNvbS9vYXNpcy10Y3MvdmlydGlvLXNwZWMvaXNzdWVzLzEyNAo+ID4gPj4+Cj4gPiA+
Pj4gQWxzbyByZWdhcmRpbmcgTU1JTyBzdXBwb3J0IGZvciBxdWV1ZSByZXNldCwgSSBwbGFuIHRv
IHN1cHBvcnQgaXQgYWZ0ZXIgdGhpcwo+ID4gPj4+IHBhdGNoIGlzIHBhc3NlZC4KPiA+ID4+Pgo+
ID4gPj4+ICMxNC0jMTcgaXMgdGhlIGRpc2FibGUvZW5hYmxlIGZ1bmN0aW9uIG9mIHJ4L3R4IHBh
aXIgaW1wbGVtZW50ZWQgYnkgdmlydGlvLW5ldAo+ID4gPj4+IHVzaW5nIHRoZSBuZXcgaGVscGVy
Lgo+ID4gPj4gT25lIHRoaW5nIHRoYXQgY2FtZSB0byBtaW5kIGlzIHRoZSBzdGVlcmluZy4gRS5n
IGlmIHdlIGRpc2FibGUgYW4gUlgsCj4gPiA+PiBzaG91bGQgd2Ugc3RvcCBzdGVlcmluZyBwYWNr
ZXRzIHRvIHRoYXQgcXVldWU/CgpSZWdhcmRpbmcgdGhpcyBzcGVjLCBpZiB0aGVyZSBhcmUgbXVs
dGlwbGUgcXVldWVzIGRpc2FibGVkIGF0IHRoZSBzYW1lIHRpbWUsIGl0CndpbGwgYmUgYSB0cm91
Ymxlc29tZSBwcm9ibGVtIGZvciB0aGUgYmFja2VuZCB0byBzZWxlY3QgdGhlIHF1ZXVlLCBzbyBJ
IHdhbnQgdG8KZGlyZWN0bHkgZGVmaW5lIHRoYXQgb25seSBvbmUgcXVldWUgaXMgYWxsb3dlZCB0
byByZXNldCBhdCB0aGUgc2FtZSB0aW1lLCBkbyB5b3UKdGhpbmsgdGhpcyBpcyBhcHByb3ByaWF0
ZT8KCkluIHRlcm1zIG9mIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBiYWNrZW5kIHF1ZXVlIHJlc2Vs
ZWN0aW9uLCBpdCB3b3VsZCBiZSBtb3JlCmNvbnZlbmllbnQgdG8gaW1wbGVtZW50IGlmIHdlIGRy
b3AgcGFja2V0cyBkaXJlY3RseS4gRG8geW91IHRoaW5rIHdlIG11c3QKaW1wbGVtZW50IHRoaXMg
cmVzZWxlY3Rpb24gZnVuY3Rpb24/CgpUaGFua3MuCgo+ID4gPiBZZXMsIHdlIHNob3VsZCByZXNl
bGVjdCBhIHF1ZXVlLgo+ID4gPgo+ID4gPiBUaGFua3MuCj4gPgo+ID4KPiA+IE1heWJlIGEgc3Bl
YyBwYXRjaCBmb3IgdGhhdD8KPgo+IFllcywgSSBhbHNvIHJlYWxpemVkIHRoaXMuIEFsdGhvdWdo
IHZpcnRpby1uZXQncyBkaXNhYmxlL2VuYWJsZSBpcyBpbXBsZW1lbnRlZAo+IGJhc2VkIG9uIHF1
ZXVlIHJlc2V0LCB2aXJ0aW8tbmV0IHN0aWxsIGhhcyB0byBkZWZpbmUgaXRzIG93biBmbGFnIGFu
ZCBkZWZpbmUKPiBzb21lIG1vcmUgZGV0YWlsZWQgaW1wbGVtZW50YXRpb25zLgo+Cj4gSSdsbCB0
aGluayBhYm91dCBpdCBhbmQgcG9zdCBhIHNwZWMgcGF0Y2guCj4KPiBUaGFua3MuCj4KPiA+Cj4g
PiBUaGFua3MKPiA+Cj4gPgo+ID4gPgo+ID4gPj4gVGhhbmtzCj4gPiA+Pgo+ID4gPj4+IFRoaXMg
ZnVuY3Rpb24gaXMgbm90IGN1cnJlbnRseSByZWZlcmVuY2VkIGJ5IG90aGVyCj4gPiA+Pj4gZnVu
Y3Rpb25zLiBJdCBpcyBtb3JlIHRvIHNob3cgdGhlIHVzYWdlIG9mIHRoZSBuZXcgaGVscGVyLCBJ
IG5vdCBzdXJlIGlmIHRoZXkKPiA+ID4+PiBhcmUgZ29pbmcgdG8gYmUgbWVyZ2VkIHRvZ2V0aGVy
Lgo+ID4gPj4+Cj4gPiA+Pj4gUGxlYXNlIHJldmlldy4gVGhhbmtzLgo+ID4gPj4+Cj4gPiA+Pj4g
djM6Cj4gPiA+Pj4gICAgMS4ga2VlcCB2cSwgaXJxIHVucmVsZWFzZWQKPiA+ID4+Pgo+ID4gPj4+
IFh1YW4gWmh1byAoMTcpOgo+ID4gPj4+ICAgIHZpcnRpb19wY2k6IHN0cnVjdCB2aXJ0aW9fcGNp
X2NvbW1vbl9jZmcgYWRkIHF1ZXVlX25vdGlmeV9kYXRhCj4gPiA+Pj4gICAgdmlydGlvOiBxdWV1
ZV9yZXNldDogYWRkIFZJUlRJT19GX1JJTkdfUkVTRVQKPiA+ID4+PiAgICB2aXJ0aW86IHF1ZXVl
X3Jlc2V0OiBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgYWRkIGNhbGxiYWNrcyBmb3IKPiA+ID4+
PiAgICAgIHF1ZXVlX3Jlc2V0Cj4gPiA+Pj4gICAgdmlydGlvOiBxdWV1ZV9yZXNldDogYWRkIGhl
bHBlcgo+ID4gPj4+ICAgIHZyaXRpb19yaW5nOiBxdWV1ZV9yZXNldDogZXh0cmFjdCB0aGUgcmVs
ZWFzZSBmdW5jdGlvbiBvZiB0aGUgdnEgcmluZwo+ID4gPj4+ICAgIHZpcnRpb19yaW5nOiBxdWV1
ZV9yZXNldDogc3BsaXQ6IGFkZCBfX3ZyaW5nX2luaXRfdmlydHF1ZXVlKCkKPiA+ID4+PiAgICB2
aXJ0aW9fcmluZzogcXVldWVfcmVzZXQ6IHNwbGl0OiBzdXBwb3J0IGVuYWJsZSByZXNldCBxdWV1
ZQo+ID4gPj4+ICAgIHZpcnRpb19yaW5nOiBxdWV1ZV9yZXNldDogcGFja2VkOiBzdXBwb3J0IGVu
YWJsZSByZXNldCBxdWV1ZQo+ID4gPj4+ICAgIHZpcnRpb19yaW5nOiBxdWV1ZV9yZXNldDogYWRk
IHZyaW5nX3Jlc2V0X3ZpcnRxdWV1ZSgpCj4gPiA+Pj4gICAgdmlydGlvX3BjaTogcXVldWVfcmVz
ZXQ6IHVwZGF0ZSBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnIGFuZAo+ID4gPj4+ICAgICAg
b3B0aW9uIGZ1bmN0aW9ucwo+ID4gPj4+ICAgIHZpcnRpb19wY2k6IHF1ZXVlX3Jlc2V0OiByZWxl
YXNlIHZxIGJ5IHZwX2Rldi0+dnFzCj4gPiA+Pj4gICAgdmlydGlvX3BjaTogcXVldWVfcmVzZXQ6
IHNldHVwX3ZxIHVzZSB2cmluZ19zZXR1cF92aXJ0cXVldWUoKQo+ID4gPj4+ICAgIHZpcnRpb19w
Y2k6IHF1ZXVlX3Jlc2V0OiBzdXBwb3J0IFZJUlRJT19GX1JJTkdfUkVTRVQKPiA+ID4+PiAgICB2
aXJ0aW9fbmV0OiB2aXJ0bmV0X3R4X3RpbWVvdXQoKSBmaXggc3R5bGUKPiA+ID4+PiAgICB2aXJ0
aW9fbmV0OiB2aXJ0bmV0X3R4X3RpbWVvdXQoKSBzdG9wIHJlZiBzcS0+dnEKPiA+ID4+PiAgICB2
aXJ0aW9fbmV0OiBzcGxpdCBmcmVlX3VudXNlZF9idWZzKCkKPiA+ID4+PiAgICB2aXJ0aW9fbmV0
OiBzdXBwb3J0IHBhaXIgZGlzYWJsZS9lbmFibGUKPiA+ID4+Pgo+ID4gPj4+ICAgZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jICAgICAgICAgICAgICAgfCAyMjAgKysrKysrKysrKysrKysrKysrKysr
Ky0tLQo+ID4gPj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYyAgICAgfCAg
NjIgKysrKy0tLQo+ID4gPj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uaCAg
ICAgfCAgMTEgKy0KPiA+ID4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMg
ICAgIHwgICA1ICstCj4gPiA+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5j
ICAgICB8IDEyMCArKysrKysrKysrKysrLQo+ID4gPj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlv
X3BjaV9tb2Rlcm5fZGV2LmMgfCAgMjggKysrKwo+ID4gPj4+ICAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYyAgICAgICAgICAgfCAxNDQgKysrKysrKysrKystLS0tLQo+ID4gPj4+ICAgaW5j
bHVkZS9saW51eC92aXJ0aW8uaCAgICAgICAgICAgICAgICAgfCAgIDEgKwo+ID4gPj4+ICAgaW5j
bHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmggICAgICAgICAgfCAgNzUgKysrKysrKystCj4gPiA+
Pj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmggICAgICB8ICAgMiArCj4gPiA+
Pj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19yaW5nLmggICAgICAgICAgICB8ICA0MiArKystLQo+
ID4gPj4+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19jb25maWcuaCAgICAgfCAgIDcgKy0K
PiA+ID4+PiAgIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmggICAgICAgIHwgICAyICsK
PiA+ID4+PiAgIDEzIGZpbGVzIGNoYW5nZWQsIDYxOCBpbnNlcnRpb25zKCspLCAxMDEgZGVsZXRp
b25zKC0pCj4gPiA+Pj4KPiA+ID4+PiAtLQo+ID4gPj4+IDIuMzEuMAo+ID4gPj4+Cj4gPgo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0Cj4gVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKPiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
