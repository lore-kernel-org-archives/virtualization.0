Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93A1C43217
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 06:41:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AC9382662;
	Wed, 13 Apr 2022 06:41:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jHBn0ah_IEkC; Wed, 13 Apr 2022 06:41:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 59F1182660;
	Wed, 13 Apr 2022 06:41:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DBA0C0033;
	Wed, 13 Apr 2022 06:41:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C29A1C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE72340877
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:41:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OHMtJ54FnK3Z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:41:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1CD6940876
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:40:59 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R381e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V9yQeE6_1649832051; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V9yQeE6_1649832051) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 13 Apr 2022 14:40:53 +0800
Message-ID: <1649831529.7724812-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v9 11/32] virtio_ring: split: introduce
 virtqueue_resize_split()
Date: Wed, 13 Apr 2022 14:32:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-12-xuanzhuo@linux.alibaba.com>
 <f79fc367-7ac5-961b-83c5-90f3d097c672@redhat.com>
In-Reply-To: <f79fc367-7ac5-961b-83c5-90f3d097c672@redhat.com>
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Heiko Carstens <hca@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCAxMiBBcHIgMjAyMiAxMzo1Mzo0NCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi80LzYg5LiK5Y2IMTE6NDMsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiB2aXJ0aW8gcmluZyBzcGxpdCBzdXBwb3J0cyByZXNpemUuCj4gPgo+ID4g
T25seSBhZnRlciB0aGUgbmV3IHZyaW5nIGlzIHN1Y2Nlc3NmdWxseSBhbGxvY2F0ZWQgYmFzZWQg
b24gdGhlIG5ldyBudW0sCj4gPiB3ZSB3aWxsIHJlbGVhc2UgdGhlIG9sZCB2cmluZy4gSW4gYW55
IGNhc2UsIGFuIGVycm9yIGlzIHJldHVybmVkLAo+ID4gaW5kaWNhdGluZyB0aGF0IHRoZSB2cmlu
ZyBzdGlsbCBwb2ludHMgdG8gdGhlIG9sZCB2cmluZy4KPiA+Cj4gPiBJbiB0aGUgY2FzZSBvZiBh
biBlcnJvciwgdGhlIGNhbGxlciBtdXN0Cj4gPiByZS1pbml0aWFsaXplKHZpcnRxdWV1ZV9yZWlu
aXRfc3BsaXQoKSkgdGhlIHZpcnRxdWV1ZSB0byBlbnN1cmUgdGhhdCB0aGUKPiA+IHZyaW5nIGNh
biBiZSB1c2VkLgo+ID4KPiA+IEluIGFkZGl0aW9uLCB2cmluZ19hbGlnbiwgbWF5X3JlZHVjZV9u
dW0gYXJlIG5lY2Vzc2FyeSBmb3IgcmVhbGxvY2F0aW5nCj4gPiB2cmluZywgc28gdGhleSBhcmUg
cmV0YWluZWQgZm9yIGNyZWF0aW5nIHZxLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1
byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kwo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYwo+ID4gaW5kZXggM2RjNmFjZTJiYTdhLi4zMzg2NDEzNGE3NDQgMTAwNjQ0Cj4gPiAt
LS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gPiBAQCAtMTM5LDYgKzEzOSwxMiBAQCBzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlIHsKPiA+ICAgCQkJLyogRE1BIGFkZHJlc3MgYW5kIHNpemUgaW5mb3JtYXRpb24gKi8K
PiA+ICAgCQkJZG1hX2FkZHJfdCBxdWV1ZV9kbWFfYWRkcjsKPiA+ICAgCQkJc2l6ZV90IHF1ZXVl
X3NpemVfaW5fYnl0ZXM7Cj4gPiArCj4gPiArCQkJLyogVGhlIHBhcmFtZXRlcnMgZm9yIGNyZWF0
aW5nIHZyaW5ncyBhcmUgcmVzZXJ2ZWQgZm9yCj4gPiArCQkJICogY3JlYXRpbmcgbmV3IHZyaW5n
Lgo+ID4gKwkJCSAqLwo+ID4gKwkJCXUzMiB2cmluZ19hbGlnbjsKPiA+ICsJCQlib29sIG1heV9y
ZWR1Y2VfbnVtOwo+ID4gICAJCX0gc3BsaXQ7Cj4gPgo+ID4gICAJCS8qIEF2YWlsYWJsZSBmb3Ig
cGFja2VkIHJpbmcgKi8KPiA+IEBAIC0xOTksNiArMjA1LDcgQEAgc3RydWN0IHZyaW5nX3ZpcnRx
dWV1ZSB7Cj4gPiAgIH07Cj4gPgo+ID4gICBzdGF0aWMgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEg
KnZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEodW5zaWduZWQgaW50IG51bSk7Cj4gPiArc3RhdGljIHZv
aWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpOwo+ID4KPiA+ICAgLyoKPiA+ICAg
ICogSGVscGVycy4KPiA+IEBAIC0xMDg4LDYgKzEwOTUsOCBAQCBzdGF0aWMgc3RydWN0IHZpcnRx
dWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+ICAgCQlyZXR1cm4gTlVMTDsK
PiA+ICAgCX0KPiA+Cj4gPiArCXRvX3Z2cSh2cSktPnNwbGl0LnZyaW5nX2FsaWduID0gdnJpbmdf
YWxpZ247Cj4gPiArCXRvX3Z2cSh2cSktPnNwbGl0Lm1heV9yZWR1Y2VfbnVtID0gbWF5X3JlZHVj
ZV9udW07Cj4KPgo+IEl0IGxvb2tzIHRvIG1lIHRoZSBhYm92ZSBzaG91bGQgYmVsb25nIHRvIHBh
dGNoIDYuCgpwYXRjaCA2IGp1c3QgZXh0cmFjdHMgYSBmdW5jdGlvbiwgbm8gbG9naWNhbCBtb2Rp
ZmljYXRpb24uCgp0b192dnEodnEpLT5zcGxpdC5tYXlfcmVkdWNlX251bSBpcyBuZXdseSBhZGRl
ZCwgc28gSSBkb24ndCB0aGluayBpdCBzaG91bGQgYmUKbWVyZ2VkIGludG8gcGF0Y2ggNi4KCj4K
Pgo+ID4gICAJdG9fdnZxKHZxKS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSBkbWFfYWRkcjsKPiA+
ICAgCXRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMgPSBxdWV1ZV9zaXplX2lu
X2J5dGVzOwo+ID4gICAJdG9fdnZxKHZxKS0+d2Vfb3duX3JpbmcgPSB0cnVlOwo+ID4gQEAgLTEw
OTUsNiArMTEwNCw0NCBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3Zp
cnRxdWV1ZV9zcGxpdCgKPiA+ICAgCXJldHVybiB2cTsKPiA+ICAgfQo+ID4KPiA+ICtzdGF0aWMg
aW50IHZpcnRxdWV1ZV9yZXNpemVfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLCB1MzIgbnVt
KQo+ID4gK3sKPiA+ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsK
PiA+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYgPSBfdnEtPnZkZXY7Cj4gPiArCXN0cnVj
dCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0ICpzdGF0ZTsKPiA+ICsJc3RydWN0IHZyaW5nX2Rlc2Nf
ZXh0cmEgKmV4dHJhOwo+ID4gKwlzaXplX3QgcXVldWVfc2l6ZV9pbl9ieXRlczsKPiA+ICsJZG1h
X2FkZHJfdCBkbWFfYWRkcjsKPiA+ICsJc3RydWN0IHZyaW5nIHZyaW5nOwo+ID4gKwlpbnQgZXJy
ID0gLUVOT01FTTsKPiA+ICsJdm9pZCAqcXVldWU7Cj4gPiArCj4gPiArCXF1ZXVlID0gdnJpbmdf
YWxsb2NfcXVldWVfc3BsaXQodmRldiwgJmRtYV9hZGRyLCAmbnVtLAo+ID4gKwkJCQkJdnEtPnNw
bGl0LnZyaW5nX2FsaWduLAo+ID4gKwkJCQkJdnEtPndlYWtfYmFycmllcnMsCj4gPiArCQkJCQl2
cS0+c3BsaXQubWF5X3JlZHVjZV9udW0pOwo+ID4gKwlpZiAoIXF1ZXVlKQo+ID4gKwkJcmV0dXJu
IC1FTk9NRU07Cj4gPiArCj4gPiArCXF1ZXVlX3NpemVfaW5fYnl0ZXMgPSB2cmluZ19zaXplKG51
bSwgdnEtPnNwbGl0LnZyaW5nX2FsaWduKTsKPiA+ICsKPiA+ICsJZXJyID0gdnJpbmdfYWxsb2Nf
c3RhdGVfZXh0cmFfc3BsaXQobnVtLCAmc3RhdGUsICZleHRyYSk7Cj4gPiArCWlmIChlcnIpIHsK
PiA+ICsJCXZyaW5nX2ZyZWVfcXVldWUodmRldiwgcXVldWVfc2l6ZV9pbl9ieXRlcywgcXVldWUs
IGRtYV9hZGRyKTsKPiA+ICsJCXJldHVybiAtRU5PTUVNOwo+ID4gKwl9Cj4gPiArCj4gPiArCXZy
aW5nX2ZyZWUoJnZxLT52cSk7Cj4gPiArCj4gPiArCXZyaW5nX2luaXQoJnZyaW5nLCBudW0sIHF1
ZXVlLCB2cS0+c3BsaXQudnJpbmdfYWxpZ24pOwo+ID4gKwl2cmluZ192aXJ0cXVldWVfYXR0YWNo
X3NwbGl0KHZxLCB2cmluZywgc3RhdGUsIGV4dHJhKTsKPiA+ICsJdnEtPnNwbGl0LnF1ZXVlX2Rt
YV9hZGRyID0gZG1hX2FkZHI7Cj4gPiArCXZxLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzID0g
cXVldWVfc2l6ZV9pbl9ieXRlczsKPgo+Cj4gSSB3b25kZXIgaWYgaXQncyBiZXR0ZXIgdG8gbW92
ZSB0aGUgYWJvdmUgYXNzaWdubWVudHMgdG8KPiB2cmluZ192aXJ0cXVldWVfYXR0YWNoX3NwbGl0
KCkuCgpJIGFsc28gdGhpbmsgc28sIHRoZSByZWFzb24gZm9yIG5vdCBkb2luZyB0aGlzIGlzIHRo
YXQgdGhlcmUgaXMgbm8gZG1hX2FkZHIgYW5kCnF1ZXVlX3NpemVfaW5fYnl0ZXMgd2hlbiB2cmlu
Z192aXJ0cXVldWVfYXR0YWNoX3NwbGl0IGlzIGNhbGxlZCBpbgpfX3ZyaW5nX25ld192aXJ0cXVl
dWUuCgpBcyBkaXNjdXNzZWQgaW4gcGF0Y2ggMTIsIHdlIGNhbiBwYXNzIHRoZSBzdHJ1Y3Qgc3Ry
dWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCB0bwp2cmluZ192aXJ0cXVldWVfYXR0YWNoX3NwbGl0
KCkuIFRoaXMgaXMgbXVjaCBtb3JlIGNvbnZlbmllbnQuCgpUaGFua3MuCgo+Cj4gT3RoZXIgbG9v
a3MgZ29vZC4KPgo+IFRoYW5rcwo+Cj4KPiA+ICsKPiA+ICsJdnJpbmdfdmlydHF1ZXVlX2luaXRf
c3BsaXQodnEsIHZkZXYsIHRydWUpOwo+ID4gKwlyZXR1cm4gMDsKPiA+ICt9Cj4gPiArCj4gPgo+
ID4gICAvKgo+ID4gICAgKiBQYWNrZWQgcmluZyBzcGVjaWZpYyBmdW5jdGlvbnMgLSAqX3BhY2tl
ZCgpLgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
