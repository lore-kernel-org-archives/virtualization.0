Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F89C04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 07:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE311403E9;
	Wed, 27 Jul 2022 07:44:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE311403E9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WLAesFZ3CoXB; Wed, 27 Jul 2022 07:44:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6048B401C5;
	Wed, 27 Jul 2022 07:44:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6048B401C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 336DEC0033;
	Wed, 27 Jul 2022 07:44:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 797F8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43BCF403E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:44:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 43BCF403E9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HrgaH8RhEKid
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:44:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CCFF6401C5
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CCFF6401C5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:44:05 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VKZx5Pm_1658907838; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VKZx5Pm_1658907838) by smtp.aliyun-inc.com;
 Wed, 27 Jul 2022 15:43:59 +0800
Message-ID: <1658907413.1860468-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v13 16/42] virtio_ring: split: introduce
 virtqueue_resize_split()
Date: Wed, 27 Jul 2022 15:36:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-17-xuanzhuo@linux.alibaba.com>
 <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
In-Reply-To: <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
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

T24gV2VkLCAyNyBKdWwgMjAyMiAxMToxMjoxOSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi83LzI2IDE1OjIxLCBYdWFuIFpodW8g5YaZ
6YGTOgo+ID4gdmlydGlvIHJpbmcgc3BsaXQgc3VwcG9ydHMgcmVzaXplLgo+ID4KPiA+IE9ubHkg
YWZ0ZXIgdGhlIG5ldyB2cmluZyBpcyBzdWNjZXNzZnVsbHkgYWxsb2NhdGVkIGJhc2VkIG9uIHRo
ZSBuZXcgbnVtLAo+ID4gd2Ugd2lsbCByZWxlYXNlIHRoZSBvbGQgdnJpbmcuIEluIGFueSBjYXNl
LCBhbiBlcnJvciBpcyByZXR1cm5lZCwKPiA+IGluZGljYXRpbmcgdGhhdCB0aGUgdnJpbmcgc3Rp
bGwgcG9pbnRzIHRvIHRoZSBvbGQgdnJpbmcuCj4gPgo+ID4gSW4gdGhlIGNhc2Ugb2YgYW4gZXJy
b3IsIHJlLWluaXRpYWxpemUodmlydHF1ZXVlX3JlaW5pdF9zcGxpdCgpKSB0aGUKPiA+IHZpcnRx
dWV1ZSB0byBlbnN1cmUgdGhhdCB0aGUgdnJpbmcgY2FuIGJlIHVzZWQuCj4gPgo+ID4gU2lnbmVk
LW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IEFja2Vk
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gPiBpbmRleCBiNmZkYTkxYzgwNTkuLjU4MzU1ZTFhYzdkNyAxMDA2NDQK
PiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ICsrKyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IEBAIC0yMjAsNiArMjIwLDcgQEAgc3RhdGljIHN0cnVj
dCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4g
PiAgIAkJCQkJICAgICAgIHZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+
ICAgCQkJCQkgICAgICAgY29uc3QgY2hhciAqbmFtZSk7Cj4gPiAgIHN0YXRpYyBzdHJ1Y3QgdnJp
bmdfZGVzY19leHRyYSAqdnJpbmdfYWxsb2NfZGVzY19leHRyYSh1bnNpZ25lZCBpbnQgbnVtKTsK
PiA+ICtzdGF0aWMgdm9pZCB2cmluZ19mcmVlKHN0cnVjdCB2aXJ0cXVldWUgKl92cSk7Cj4gPgo+
ID4gICAvKgo+ID4gICAgKiBIZWxwZXJzLgo+ID4gQEAgLTExMTcsNiArMTExOCwzOSBAQCBzdGF0
aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+ICAg
CXJldHVybiB2cTsKPiA+ICAgfQo+ID4KPiA+ICtzdGF0aWMgaW50IHZpcnRxdWV1ZV9yZXNpemVf
c3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLCB1MzIgbnVtKQo+ID4gK3sKPiA+ICsJc3RydWN0
IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCB2cmluZ19zcGxpdCA9IHt9Owo+ID4gKwlzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gKwlzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldiA9IF92cS0+dmRldjsKPiA+ICsJaW50IGVycjsKPiA+ICsKPiA+ICsJZXJyID0gdnJp
bmdfYWxsb2NfcXVldWVfc3BsaXQoJnZyaW5nX3NwbGl0LCB2ZGV2LCBudW0sCj4gPiArCQkJCSAg
ICAgIHZxLT5zcGxpdC52cmluZ19hbGlnbiwKPiA+ICsJCQkJICAgICAgdnEtPnNwbGl0Lm1heV9y
ZWR1Y2VfbnVtKTsKPiA+ICsJaWYgKGVycikKPiA+ICsJCWdvdG8gZXJyOwo+Cj4KPiBJIHRoaW5r
IHdlIGRvbid0IG5lZWQgdG8gZG8gYW55dGhpbmcgaGVyZT8KCkFtIEkgbWlzc2luZyBzb21ldGhp
bmc/Cgo+Cj4KPiA+ICsKPiA+ICsJZXJyID0gdnJpbmdfYWxsb2Nfc3RhdGVfZXh0cmFfc3BsaXQo
JnZyaW5nX3NwbGl0KTsKPiA+ICsJaWYgKGVycikgewo+ID4gKwkJdnJpbmdfZnJlZV9zcGxpdCgm
dnJpbmdfc3BsaXQsIHZkZXYpOwo+ID4gKwkJZ290byBlcnI7Cj4KPgo+IEkgc3VnZ2VzdCB0byBt
b3ZlIHZyaW5nX2ZyZWVfc3BsaXQoKSBpbnRvIGEgZGVkaWNhdGVkIGVycm9yIGxhYmVsLgoKV2ls
bCBjaGFuZ2UuCgpUaGFua3MuCgoKPgo+IFRoYW5rcwo+Cj4KPiA+ICsJfQo+ID4gKwo+ID4gKwl2
cmluZ19mcmVlKCZ2cS0+dnEpOwo+ID4gKwo+ID4gKwl2aXJ0cXVldWVfdnJpbmdfaW5pdF9zcGxp
dCgmdnJpbmdfc3BsaXQsIHZxKTsKPiA+ICsKPiA+ICsJdmlydHF1ZXVlX2luaXQodnEsIHZyaW5n
X3NwbGl0LnZyaW5nLm51bSk7Cj4gPiArCXZpcnRxdWV1ZV92cmluZ19hdHRhY2hfc3BsaXQodnEs
ICZ2cmluZ19zcGxpdCk7Cj4gPiArCj4gPiArCXJldHVybiAwOwo+ID4gKwo+ID4gK2VycjoKPiA+
ICsJdmlydHF1ZXVlX3JlaW5pdF9zcGxpdCh2cSk7Cj4gPiArCXJldHVybiAtRU5PTUVNOwo+ID4g
K30KPiA+ICsKPiA+Cj4gPiAgIC8qCj4gPiAgICAqIFBhY2tlZCByaW5nIHNwZWNpZmljIGZ1bmN0
aW9ucyAtICpfcGFja2VkKCkuCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
