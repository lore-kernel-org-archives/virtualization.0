Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24025C43334
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 02:22:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83F2340986;
	Mon,  4 Jul 2022 02:22:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83F2340986
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05UyC2gwDE1m; Mon,  4 Jul 2022 02:22:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 89CFC40977;
	Mon,  4 Jul 2022 02:22:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89CFC40977
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 540D8C0032;
	Mon,  4 Jul 2022 02:22:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F319C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C5A2818A1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:22:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C5A2818A1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f3PBwNGz4jdS
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:22:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7D1B817AF
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D7D1B817AF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:22:45 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R281e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VIE1rLs_1656901358; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VIE1rLs_1656901358) by smtp.aliyun-inc.com;
 Mon, 04 Jul 2022 10:22:39 +0800
Message-ID: <1656901259.0328152-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 22/40] virtio_ring: introduce virtqueue_resize()
Date: Mon, 4 Jul 2022 10:20:59 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-23-xuanzhuo@linux.alibaba.com>
 <d3788739-1c7f-4f1e-a222-f83bd73c14a1@redhat.com>
In-Reply-To: <d3788739-1c7f-4f1e-a222-f83bd73c14a1@redhat.com>
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

T24gRnJpLCAxIEp1bCAyMDIyIDE3OjMxOjM0ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiBJbnRyb2R1Y2UgdmlydHF1ZXVlX3Jlc2l6ZSgpIHRvIGltcGxlbWVudCB0aGUgcmVz
aXplIG9mIHZyaW5nLgo+ID4gQmFzZWQgb24gdGhlc2UsIHRoZSBkcml2ZXIgY2FuIGR5bmFtaWNh
bGx5IGFkanVzdCB0aGUgc2l6ZSBvZiB0aGUgdnJpbmcuCj4gPiBGb3IgZXhhbXBsZTogZXRodG9v
bCAtRy4KPiA+Cj4gPiB2aXJ0cXVldWVfcmVzaXplKCkgaW1wbGVtZW50cyByZXNpemUgYmFzZWQg
b24gdGhlIHZxIHJlc2V0IGZ1bmN0aW9uLiBJbgo+ID4gY2FzZSBvZiBmYWlsdXJlIHRvIGFsbG9j
YXRlIGEgbmV3IHZyaW5nLCBpdCB3aWxsIGdpdmUgdXAgcmVzaXplIGFuZCB1c2UKPiA+IHRoZSBv
cmlnaW5hbCB2cmluZy4KPiA+Cj4gPiBEdXJpbmcgdGhpcyBwcm9jZXNzLCBpZiB0aGUgcmUtZW5h
YmxlIHJlc2V0IHZxIGZhaWxzLCB0aGUgdnEgY2FuIG5vCj4gPiBsb25nZXIgYmUgdXNlZC4gQWx0
aG91Z2ggdGhlIHByb2JhYmlsaXR5IG9mIHRoaXMgc2l0dWF0aW9uIGlzIG5vdCBoaWdoLgo+ID4K
PiA+IFRoZSBwYXJhbWV0ZXIgcmVjeWNsZSBpcyB1c2VkIHRvIHJlY3ljbGUgdGhlIGJ1ZmZlciB0
aGF0IGlzIG5vIGxvbmdlcgo+ID4gdXNlZC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpo
dW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMgfCA3MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKPiA+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAzICsrCj4gPiAgIDIgZmls
ZXMgY2hhbmdlZCwgNzUgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4g
aW5kZXggNDg2MDc4NzI4NmRiLi41ZWM0MzYwN2NjMTUgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gPiBAQCAtMjU0Miw2ICsyNTQyLDc4IEBAIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2Ny
ZWF0ZV92aXJ0cXVldWUoCj4gPiAgIH0KPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwodnJpbmdfY3Jl
YXRlX3ZpcnRxdWV1ZSk7Cj4gPgo+ID4gKy8qKgo+ID4gKyAqIHZpcnRxdWV1ZV9yZXNpemUgLSBy
ZXNpemUgdGhlIHZyaW5nIG9mIHZxCj4gPiArICogQF92cTogdGhlIHN0cnVjdCB2aXJ0cXVldWUg
d2UncmUgdGFsa2luZyBhYm91dC4KPiA+ICsgKiBAbnVtOiBuZXcgcmluZyBudW0KPiA+ICsgKiBA
cmVjeWNsZTogY2FsbGJhY2sgZm9yIHJlY3ljbGUgdGhlIHVzZWxlc3MgYnVmZmVyCj4gPiArICoK
PiA+ICsgKiBXaGVuIGl0IGlzIHJlYWxseSBuZWNlc3NhcnkgdG8gY3JlYXRlIGEgbmV3IHZyaW5n
LCBpdCB3aWxsIHNldCB0aGUgY3VycmVudCB2cQo+ID4gKyAqIGludG8gdGhlIHJlc2V0IHN0YXRl
LiBUaGVuIGNhbGwgdGhlIHBhc3NlZCBjYWxsYmFjayB0byByZWN5Y2xlIHRoZSBidWZmZXIKPiA+
ICsgKiB0aGF0IGlzIG5vIGxvbmdlciB1c2VkLiBPbmx5IGFmdGVyIHRoZSBuZXcgdnJpbmcgaXMg
c3VjY2Vzc2Z1bGx5IGNyZWF0ZWQsIHRoZQo+ID4gKyAqIG9sZCB2cmluZyB3aWxsIGJlIHJlbGVh
c2VkLgo+ID4gKyAqCj4gPiArICogQ2FsbGVyIG11c3QgZW5zdXJlIHdlIGRvbid0IGNhbGwgdGhp
cyB3aXRoIG90aGVyIHZpcnRxdWV1ZSBvcGVyYXRpb25zCj4gPiArICogYXQgdGhlIHNhbWUgdGlt
ZSAoZXhjZXB0IHdoZXJlIG5vdGVkKS4KPiA+ICsgKgo+ID4gKyAqIFJldHVybnMgemVybyBvciBh
IG5lZ2F0aXZlIGVycm9yLgo+ID4gKyAqIDA6IHN1Y2Nlc3MuCj4gPiArICogLUVOT01FTTogRmFp
bGVkIHRvIGFsbG9jYXRlIGEgbmV3IHJpbmcsIGZhbGwgYmFjayB0byB0aGUgb3JpZ2luYWwgcmlu
ZyBzaXplLgo+ID4gKyAqICB2cSBjYW4gc3RpbGwgd29yayBub3JtYWxseQo+ID4gKyAqIC1FQlVT
WTogRmFpbGVkIHRvIHN5bmMgd2l0aCBkZXZpY2UsIHZxIG1heSBub3Qgd29yayBwcm9wZXJseQo+
ID4gKyAqIC1FTk9FTlQ6IFRyYW5zcG9ydCBvciBkZXZpY2Ugbm90IHN1cHBvcnRlZAo+ID4gKyAq
IC1FMkJJRy8tRUlOVkFMOiBudW0gZXJyb3IKPiA+ICsgKiAtRVBFUk06IE9wZXJhdGlvbiBub3Qg
cGVybWl0dGVkCj4gPiArICoKPiA+ICsgKi8KPiA+ICtpbnQgdmlydHF1ZXVlX3Jlc2l6ZShzdHJ1
Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBudW0sCj4gPiArCQkgICAgIHZvaWQgKCpyZWN5Y2xlKShz
dHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKSkKPiA+ICt7Cj4gPiArCXN0cnVjdCB2cmlu
Z192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gPiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2ID0gdnEtPnZxLnZkZXY7Cj4gPiArCWJvb2wgcGFja2VkOwo+ID4gKwl2b2lkICpidWY7
Cj4gPiArCWludCBlcnI7Cj4gPiArCj4gPiArCWlmICghdnEtPndlX293bl9yaW5nKQo+ID4gKwkJ
cmV0dXJuIC1FUEVSTTsKPiA+ICsKPiA+ICsJaWYgKG51bSA+IHZxLT52cS5udW1fbWF4KQo+ID4g
KwkJcmV0dXJuIC1FMkJJRzsKPiA+ICsKPiA+ICsJaWYgKCFudW0pCj4gPiArCQlyZXR1cm4gLUVJ
TlZBTDsKPiA+ICsKPiA+ICsJcGFja2VkID0gdmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJ
T19GX1JJTkdfUEFDS0VEKSA/IHRydWUgOiBmYWxzZTsKPgo+Cj4gdnEtPnBhY2tlZF9yaW5nPwoK
V2lsbCBmaXguCgo+Cj4KPiA+ICsKPiA+ICsJaWYgKChwYWNrZWQgPyB2cS0+cGFja2VkLnZyaW5n
Lm51bSA6IHZxLT5zcGxpdC52cmluZy5udW0pID09IG51bSkKPiA+ICsJCXJldHVybiAwOwo+ID4g
Kwo+ID4gKwlpZiAoIXZkZXYtPmNvbmZpZy0+cmVzZXRfdnEpCj4gPiArCQlyZXR1cm4gLUVOT0VO
VDsKPiA+ICsKPiA+ICsJaWYgKCF2ZGV2LT5jb25maWctPmVuYWJsZV9yZXNldF92cSkKPiA+ICsJ
CXJldHVybiAtRU5PRU5UOwo+Cj4KPiBOb3Qgc3VyZSB0aGlzIGlzIHVzZWZ1bCwgZS5nIGRyaXZl
ciBtYXkgY2hvb3NlIHRvIHJlc2l6ZSBhZnRlciBhIHJlc2V0Cj4gb2YgdGhlIGRldmljZT8KClRo
ZXJlIG1heSBiZSBzb21lIG1pc3VuZGVyc3RhbmRpbmdzLCB0aGlzIGlzIHRvIGNoZWNrIHdoZXRo
ZXIgdGhlIHRyYW5zcG9ydCBoYXMKc2V0IHRoZSBjYWxsYmFjayBlbmFibGVfcmVzZXRfdnEoKS4K
ClRoYW5rcy4KCgo+Cj4gVGhhbmtzCj4KPgo+ID4gKwo+ID4gKwllcnIgPSB2ZGV2LT5jb25maWct
PnJlc2V0X3ZxKF92cSk7Cj4gPiArCWlmIChlcnIpCj4gPiArCQlyZXR1cm4gZXJyOwo+ID4gKwo+
ID4gKwl3aGlsZSAoKGJ1ZiA9IHZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1ZihfdnEpKSAhPSBO
VUxMKQo+ID4gKwkJcmVjeWNsZShfdnEsIGJ1Zik7Cj4gPiArCj4gPiArCWlmIChwYWNrZWQpCj4g
PiArCQllcnIgPSB2aXJ0cXVldWVfcmVzaXplX3BhY2tlZChfdnEsIG51bSk7Cj4gPiArCWVsc2UK
PiA+ICsJCWVyciA9IHZpcnRxdWV1ZV9yZXNpemVfc3BsaXQoX3ZxLCBudW0pOwo+ID4gKwo+ID4g
KwlpZiAodmRldi0+Y29uZmlnLT5lbmFibGVfcmVzZXRfdnEoX3ZxKSkKPiA+ICsJCXJldHVybiAt
RUJVU1k7Cj4gPiArCj4gPiArCXJldHVybiBlcnI7Cj4gPiArfQo+ID4gK0VYUE9SVF9TWU1CT0xf
R1BMKHZpcnRxdWV1ZV9yZXNpemUpOwo+ID4gKwo+ID4gICAvKiBPbmx5IGF2YWlsYWJsZSBmb3Ig
c3BsaXQgcmluZyAqLwo+ID4gICBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19uZXdfdmlydHF1ZXVl
KHVuc2lnbmVkIGludCBpbmRleCwKPiA+ICAgCQkJCSAgICAgIHVuc2lnbmVkIGludCBudW0sCj4g
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaCBiL2luY2x1ZGUvbGludXgvdmly
dGlvLmgKPiA+IGluZGV4IGE4MjYyMDAzMmU0My4uMTI3MjU2NmFkZWM2IDEwMDY0NAo+ID4gLS0t
IGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ID4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW8u
aAo+ID4gQEAgLTkxLDYgKzkxLDkgQEAgZG1hX2FkZHJfdCB2aXJ0cXVldWVfZ2V0X2Rlc2NfYWRk
cihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gPiAgIGRtYV9hZGRyX3QgdmlydHF1ZXVlX2dldF9h
dmFpbF9hZGRyKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiA+ICAgZG1hX2FkZHJfdCB2aXJ0cXVl
dWVfZ2V0X3VzZWRfYWRkcihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gPgo+ID4gK2ludCB2aXJ0
cXVldWVfcmVzaXplKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB1MzIgbnVtLAo+ID4gKwkJICAgICB2
b2lkICgqcmVjeWNsZSkoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1ZikpOwo+ID4gKwo+
ID4gICAvKioKPiA+ICAgICogdmlydGlvX2RldmljZSAtIHJlcHJlc2VudGF0aW9uIG9mIGEgZGV2
aWNlIHVzaW5nIHZpcnRpbwo+ID4gICAgKiBAaW5kZXg6IHVuaXF1ZSBwb3NpdGlvbiBvbiB0aGUg
dmlydGlvIGJ1cwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
