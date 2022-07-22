Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91A5C433EF
	for <virtualization@archiver.kernel.org>; Fri, 22 Jul 2022 03:06:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62609841A2;
	Fri, 22 Jul 2022 03:06:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62609841A2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TqGsaRAen_b2; Fri, 22 Jul 2022 03:06:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 90B4A841A4;
	Fri, 22 Jul 2022 03:06:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90B4A841A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56640C0033;
	Fri, 22 Jul 2022 03:06:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D3FEC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 03:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22E1241A67
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 03:06:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 22E1241A67
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7zGOs8ytfbwP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 03:06:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3787841BDF
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3787841BDF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 03:06:09 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VK3N6a-_1658459160; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VK3N6a-_1658459160) by smtp.aliyun-inc.com;
 Fri, 22 Jul 2022 11:06:01 +0800
Message-ID: <1658459137.1276448-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v12 30/40] virtio_pci: support VIRTIO_F_RING_RESET
Date: Fri, 22 Jul 2022 11:05:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-31-xuanzhuo@linux.alibaba.com>
 <efb6adca-a2a8-98d2-5604-5482d8be6ec9@redhat.com>
In-Reply-To: <efb6adca-a2a8-98d2-5604-5482d8be6ec9@redhat.com>
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
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

T24gVGh1LCAyMSBKdWwgMjAyMiAxNzoxNToxMSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi83LzIwIDExOjA0LCBYdWFuIFpodW8g5YaZ
6YGTOgo+ID4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHZpcnRpbyBwY2kgc3VwcG9ydCBmb3IgUVVF
VUUgUkVTRVQuCj4gPgo+ID4gUGVyZm9ybWluZyByZXNldCBvbiBhIHF1ZXVlIGlzIGRpdmlkZWQg
aW50byB0aGVzZSBzdGVwczoKPiA+Cj4gPiAgIDEuIG5vdGlmeSB0aGUgZGV2aWNlIHRvIHJlc2V0
IHRoZSBxdWV1ZQo+ID4gICAyLiByZWN5Y2xlIHRoZSBidWZmZXIgc3VibWl0dGVkCj4gPiAgIDMu
IHJlc2V0IHRoZSB2cmluZyAobWF5IHJlLWFsbG9jKQo+ID4gICA0LiBtbWFwIHZyaW5nIHRvIGRl
dmljZSwgYW5kIGVuYWJsZSB0aGUgcXVldWUKPiA+Cj4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMg
dmlydGlvX3Jlc2V0X3ZxKCksIHZpcnRpb19lbmFibGVfcmVzZXRxKCkgaW4gdGhlCj4gPiBwY2kg
c2NlbmFyaW8uCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2Nv
bW1vbi5jIHwgMTIgKysrLQo+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5j
IHwgOTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMTA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX2NvbW1vbi5jCj4gPiBpbmRleCBjYTUxZmNjOWRhYWIuLmFkMjU4YTlkM2I5ZiAxMDA2
NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiA+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiA+IEBAIC0yMTQsOSArMjE0LDE1
IEBAIHN0YXRpYyB2b2lkIHZwX2RlbF92cShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiA+ICAgCXN0
cnVjdCB2aXJ0aW9fcGNpX3ZxX2luZm8gKmluZm8gPSB2cF9kZXYtPnZxc1t2cS0+aW5kZXhdOwo+
ID4gICAJdW5zaWduZWQgbG9uZyBmbGFnczsKPiA+Cj4gPiAtCXNwaW5fbG9ja19pcnFzYXZlKCZ2
cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiA+IC0JbGlzdF9kZWwoJmluZm8tPm5vZGUpOwo+ID4gLQlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiA+ICsJLyoKPiA+
ICsJICogSWYgaXQgZmFpbHMgZHVyaW5nIHJlLWVuYWJsZSByZXNldCB2cS4gVGhpcyB3YXkgd2Ug
d29uJ3QgcmVqb2luCj4gPiArCSAqIGluZm8tPm5vZGUgdG8gdGhlIHF1ZXVlLiBQcmV2ZW50IHVu
ZXhwZWN0ZWQgaXJxcy4KPiA+ICsJICovCj4gPiArCWlmICghdnEtPnJlc2V0KSB7Cj4gPiArCQlz
cGluX2xvY2tfaXJxc2F2ZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4gPiArCQlsaXN0X2RlbCgm
aW5mby0+bm9kZSk7Cj4gPiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2cF9kZXYtPmxvY2ss
IGZsYWdzKTsKPiA+ICsJfQo+ID4KPiA+ICAgCXZwX2Rldi0+ZGVsX3ZxKGluZm8pOwo+ID4gICAJ
a2ZyZWUoaW5mbyk7Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9t
b2Rlcm4uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiA+IGluZGV4IDkw
NDFkOWE0MWI3ZC4uNGQyOGI2OTE4YzgwIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9tb2Rlcm4uYwo+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9t
b2Rlcm4uYwo+ID4gQEAgLTM0LDYgKzM0LDkgQEAgc3RhdGljIHZvaWQgdnBfdHJhbnNwb3J0X2Zl
YXR1cmVzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpCj4gPiAgIAlp
ZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9TUl9JT1YpKSAmJgo+ID4gICAJCQlwY2lf
ZmluZF9leHRfY2FwYWJpbGl0eShwY2lfZGV2LCBQQ0lfRVhUX0NBUF9JRF9TUklPVikpCj4gPiAg
IAkJX192aXJ0aW9fc2V0X2JpdCh2ZGV2LCBWSVJUSU9fRl9TUl9JT1YpOwo+ID4gKwo+ID4gKwlp
ZiAoZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX1JJTkdfUkVTRVQpKQo+ID4gKwkJX192aXJ0
aW9fc2V0X2JpdCh2ZGV2LCBWSVJUSU9fRl9SSU5HX1JFU0VUKTsKPiA+ICAgfQo+ID4KPiA+ICAg
LyogdmlydGlvIGNvbmZpZy0+ZmluYWxpemVfZmVhdHVyZXMoKSBpbXBsZW1lbnRhdGlvbiAqLwo+
ID4gQEAgLTE5OSw2ICsyMDIsOTUgQEAgc3RhdGljIGludCB2cF9hY3RpdmVfdnEoc3RydWN0IHZp
cnRxdWV1ZSAqdnEsIHUxNiBtc2l4X3ZlYykKPiA+ICAgCXJldHVybiAwOwo+ID4gICB9Cj4gPgo+
ID4gK3N0YXRpYyBpbnQgdnBfbW9kZXJuX3Jlc2V0X3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+
ID4gK3sKPiA+ICsJc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYgPSB0b192cF9kZXZp
Y2UodnEtPnZkZXYpOwo+ID4gKwlzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2
ID0gJnZwX2Rldi0+bWRldjsKPiA+ICsJc3RydWN0IHZpcnRpb19wY2lfdnFfaW5mbyAqaW5mbzsK
PiA+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsKPiA+ICsKPiA+ICsJaWYgKCF2aXJ0aW9faGFzX2Zl
YXR1cmUodnEtPnZkZXYsIFZJUlRJT19GX1JJTkdfUkVTRVQpKQo+ID4gKwkJcmV0dXJuIC1FTk9F
TlQ7Cj4gPiArCj4gPiArCXZwX21vZGVybl9zZXRfcXVldWVfcmVzZXQobWRldiwgdnEtPmluZGV4
KTsKPiA+ICsKPiA+ICsJaW5mbyA9IHZwX2Rldi0+dnFzW3ZxLT5pbmRleF07Cj4gPiArCj4gPiAr
CS8qIGRlbGV0ZSB2cSBmcm9tIGlycSBoYW5kbGVyICovCj4gPiArCXNwaW5fbG9ja19pcnFzYXZl
KCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiA+ICsJbGlzdF9kZWwoJmluZm8tPm5vZGUpOwo+ID4g
KwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiA+ICsKPiA+
ICsJSU5JVF9MSVNUX0hFQUQoJmluZm8tPm5vZGUpOwo+ID4gKwo+ID4gKwkvKiBGb3IgdGhlIGNh
c2Ugd2hlcmUgdnEgaGFzIGFuIGV4Y2x1c2l2ZSBpcnEsIHRvIHByZXZlbnQgdGhlIGlycSBmcm9t
Cj4gPiArCSAqIGJlaW5nIHJlY2VpdmVkIGFnYWluIGFuZCB0aGUgcGVuZGluZyBpcnEsIGNhbGwg
c3luY2hyb25pemVfaXJxKCksIGFuZAo+ID4gKwkgKiBicmVhayBpdC4KPiA+ICsJICoKPiA+ICsJ
ICogV2UgY2FuJ3QgdXNlIGRpc2FibGVfaXJxKCkgc2luY2UgaXQgY29uZmxpY3RzIHdpdGggdGhl
IGFmZmluaXR5Cj4gPiArCSAqIG1hbmFnZWQgSVJRIHRoYXQgaXMgdXNlZCBieSBzb21lIGRyaXZl
cnMuIFNvIHRoaXMgaXMgZG9uZSBvbiB0b3Agb2YKPiA+ICsJICogSVJRIGhhcmRlbmluZy4KPiA+
ICsJICoKPiA+ICsJICogSW4gdGhlIHNjZW5hcmlvIGJhc2VkIG9uIHNoYXJlZCBpbnRlcnJ1cHRz
LCB2cSB3aWxsIGJlIHNlYXJjaGVkIGZyb20KPiA+ICsJICogdGhlIHF1ZXVlIHZpcnRxdWV1ZXMu
IFNpbmNlIHRoZSBwcmV2aW91cyBsaXN0X2RlbCgpIGhhcyBiZWVuIGRlbGV0ZWQKPiA+ICsJICog
ZnJvbSB0aGUgcXVldWUsIGl0IGlzIGltcG9zc2libGUgZm9yIHZxIHRvIGJlIGNhbGxlZCBpbiB0
aGlzIGNhc2UuCj4gPiArCSAqIFRoZXJlIGlzIG5vIG5lZWQgdG8gY2xvc2UgdGhlIGNvcnJlc3Bv
bmRpbmcgaW50ZXJydXB0Lgo+ID4gKwkgKi8KPiA+ICsJaWYgKHZwX2Rldi0+cGVyX3ZxX3ZlY3Rv
cnMgJiYgaW5mby0+bXNpeF92ZWN0b3IgIT0gVklSVElPX01TSV9OT19WRUNUT1IpIHsKPiA+ICsj
aWZkZWYgQ09ORklHX1ZJUlRJT19IQVJERU5fTk9USUZJQ0FUSU9OCj4gPiArCQlfX3ZpcnRxdWV1
ZV9icmVhayh2cSk7Cj4gPiArI2VuZGlmCj4KPgo+IEkgdGhpbmsgd2Ugc2hvdWxkIGRvIHRoaXMg
dW5jb25kaXRpb25hbGx5IHNpbmNlIGl0J3MgYW4gaW5kZXBlbmRlbnQKPiBmZWF0dXJlLCB0aG91
Z2ggdGhlIGxpc3RfZGVsKCkgYWJvdmUgc2hvdWxkIGJlIHN1ZmZpY2llbnQuCgpZZXMuCgo+Cj4K
PiA+ICsJCXN5bmNocm9uaXplX2lycShwY2lfaXJxX3ZlY3Rvcih2cF9kZXYtPnBjaV9kZXYsIGlu
Zm8tPm1zaXhfdmVjdG9yKSk7Cj4gPiArCX0KPiA+ICsKPiA+ICsJdnEtPnJlc2V0ID0gdHJ1ZTsK
PiA+ICsKPiA+ICsJcmV0dXJuIDA7Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyBpbnQgdnBfbW9k
ZXJuX2VuYWJsZV9yZXNldF92cShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiA+ICt7Cj4gPiArCXN0
cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2ID0gdG9fdnBfZGV2aWNlKHZxLT52ZGV2KTsK
PiA+ICsJc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldiA9ICZ2cF9kZXYtPm1k
ZXY7Cj4gPiArCXN0cnVjdCB2aXJ0aW9fcGNpX3ZxX2luZm8gKmluZm87Cj4gPiArCXVuc2lnbmVk
IGxvbmcgZmxhZ3MsIGluZGV4Owo+ID4gKwlpbnQgZXJyOwo+ID4gKwo+ID4gKwlpZiAoIXZxLT5y
ZXNldCkKPiA+ICsJCXJldHVybiAtRUJVU1k7Cj4gPiArCj4gPiArCWluZGV4ID0gdnEtPmluZGV4
Owo+ID4gKwlpbmZvID0gdnBfZGV2LT52cXNbaW5kZXhdOwo+ID4gKwo+ID4gKwlpZiAodnBfbW9k
ZXJuX2dldF9xdWV1ZV9yZXNldChtZGV2LCBpbmRleCkpCj4gPiArCQlyZXR1cm4gLUVCVVNZOwo+
ID4gKwo+ID4gKwlpZiAodnBfbW9kZXJuX2dldF9xdWV1ZV9lbmFibGUobWRldiwgaW5kZXgpKQo+
ID4gKwkJcmV0dXJuIC1FQlVTWTsKPiA+ICsKPiA+ICsJZXJyID0gdnBfYWN0aXZlX3ZxKHZxLCBp
bmZvLT5tc2l4X3ZlY3Rvcik7Cj4gPiArCWlmIChlcnIpCj4gPiArCQlyZXR1cm4gZXJyOwo+ID4g
Kwo+ID4gKwlpZiAodnEtPmNhbGxiYWNrKSB7Cj4gPiArCQlzcGluX2xvY2tfaXJxc2F2ZSgmdnBf
ZGV2LT5sb2NrLCBmbGFncyk7Cj4gPiArCQlsaXN0X2FkZCgmaW5mby0+bm9kZSwgJnZwX2Rldi0+
dmlydHF1ZXVlcyk7Cj4gPiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2cF9kZXYtPmxvY2ss
IGZsYWdzKTsKPiA+ICsJfSBlbHNlIHsKPiA+ICsJCUlOSVRfTElTVF9IRUFEKCZpbmZvLT5ub2Rl
KTsKPiA+ICsJfQo+ID4gKwo+ID4gKyNpZmRlZiBDT05GSUdfVklSVElPX0hBUkRFTl9OT1RJRklD
QVRJT04KPiA+ICsJaWYgKHZwX2Rldi0+cGVyX3ZxX3ZlY3RvcnMgJiYgaW5mby0+bXNpeF92ZWN0
b3IgIT0gVklSVElPX01TSV9OT19WRUNUT1IpCj4gPiArCQlfX3ZpcnRxdWV1ZV91bmJyZWFrKHZx
KTsKPiA+ICsjZW5kaWYKPiA+ICsKPiA+ICsJdnBfbW9kZXJuX3NldF9xdWV1ZV9lbmFibGUoJnZw
X2Rldi0+bWRldiwgaW5kZXgsIHRydWUpOwo+ID4gKwl2cS0+cmVzZXQgPSBmYWxzZTsKPiA+ICsK
PiA+ICsJcmV0dXJuIDA7Cj4gPiArfQo+ID4gKwo+ID4gICBzdGF0aWMgdTE2IHZwX2NvbmZpZ192
ZWN0b3Ioc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYsIHUxNiB2ZWN0b3IpCj4gPiAg
IHsKPiA+ICAgCXJldHVybiB2cF9tb2Rlcm5fY29uZmlnX3ZlY3RvcigmdnBfZGV2LT5tZGV2LCB2
ZWN0b3IpOwo+ID4gQEAgLTQxMyw2ICs1MDUsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZpcnRp
b19jb25maWdfb3BzIHZpcnRpb19wY2lfY29uZmlnX25vZGV2X29wcyA9IHsKPiA+ICAgCS5zZXRf
dnFfYWZmaW5pdHkgPSB2cF9zZXRfdnFfYWZmaW5pdHksCj4gPiAgIAkuZ2V0X3ZxX2FmZmluaXR5
ID0gdnBfZ2V0X3ZxX2FmZmluaXR5LAo+ID4gICAJLmdldF9zaG1fcmVnaW9uICA9IHZwX2dldF9z
aG1fcmVnaW9uLAo+ID4gKwkuZGlzYWJsZV92cV9hbmRfcmVzZXQgPSB2cF9tb2Rlcm5fcmVzZXRf
dnEsCj4gPiArCS5lbmFibGVfdnFfYWZ0ZXJfcmVzZXQgPSB2cF9tb2Rlcm5fZW5hYmxlX3Jlc2V0
X3ZxLAo+Cj4KPiBOaXQ6Cj4KPiBUbyBiZSBjb25zaXN0ZW50LCBsZXQncyB1c2UgdnBfbW9kZXJu
X2Rpc2FibGVfdnFfYW5kX3Jlc2V0KCkgYW5kCj4gdnBfbW9kZXJuX2VuYWJsZV92cV9hZnRlcl9y
ZXNldCgpCgpXaWxsIGZpeC4KClRoYW5rcy4KCgo+Cj4gVGhhbmtzCj4KPgo+ID4gICB9Owo+ID4K
PiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyB2aXJ0aW9fcGNpX2Nv
bmZpZ19vcHMgPSB7Cj4gPiBAQCAtNDMxLDYgKzUyNSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
dmlydGlvX2NvbmZpZ19vcHMgdmlydGlvX3BjaV9jb25maWdfb3BzID0gewo+ID4gICAJLnNldF92
cV9hZmZpbml0eSA9IHZwX3NldF92cV9hZmZpbml0eSwKPiA+ICAgCS5nZXRfdnFfYWZmaW5pdHkg
PSB2cF9nZXRfdnFfYWZmaW5pdHksCj4gPiAgIAkuZ2V0X3NobV9yZWdpb24gID0gdnBfZ2V0X3No
bV9yZWdpb24sCj4gPiArCS5kaXNhYmxlX3ZxX2FuZF9yZXNldCA9IHZwX21vZGVybl9yZXNldF92
cSwKPiA+ICsJLmVuYWJsZV92cV9hZnRlcl9yZXNldCA9IHZwX21vZGVybl9lbmFibGVfcmVzZXRf
dnEsCj4gPiAgIH07Cj4gPgo+ID4gICAvKiB0aGUgUENJIHByb2JpbmcgZnVuY3Rpb24gKi8KPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
