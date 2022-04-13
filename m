Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6678C4321E
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 06:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AEB0415A9;
	Wed, 13 Apr 2022 06:52:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NDwsUVVsO0ku; Wed, 13 Apr 2022 06:52:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9955E41553;
	Wed, 13 Apr 2022 06:52:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F6BBC0033;
	Wed, 13 Apr 2022 06:52:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB72BC002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3558610BC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:52:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p4eWLm2emWWH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:52:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2BA7360F39
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:52:49 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V9yF1bX_1649832763; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V9yF1bX_1649832763) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 13 Apr 2022 14:52:44 +0800
Message-ID: <1649832486.146921-7-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v9 07/32] virtio_ring: split: extract the logic of alloc
 state and extra
Date: Wed, 13 Apr 2022 14:48:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-8-xuanzhuo@linux.alibaba.com>
 <927ee895-84ae-fb69-c9ed-9c1836ff1d03@redhat.com>
In-Reply-To: <927ee895-84ae-fb69-c9ed-9c1836ff1d03@redhat.com>
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

T24gVHVlLCAxMiBBcHIgMjAyMiAxMToyNjo0OSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi80LzYg5LiK5Y2IMTE6NDMsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBTZXBhcmF0ZSB0aGUgbG9naWMgb2YgY3JlYXRpbmcgZGVzY19zdGF0ZSwg
ZGVzY19leHRyYSwgYW5kIHN1YnNlcXVlbnQKPiA+IHBhdGNoZXMgd2lsbCBjYWxsIGl0IGluZGVw
ZW5kZW50bHkuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
IHwgNTMgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPiA+IGluZGV4IDcyZDVhZTA2M2ZhMC4uNmRlNjc0MzljYjU3IDEwMDY0NAo+ID4g
LS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gKysrIGIvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+ID4gQEAgLTE5OCw2ICsxOTgsNyBAQCBzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlIHsKPiA+ICAgI2VuZGlmCj4gPiAgIH07Cj4gPgo+ID4gK3N0YXRpYyBzdHJ1Y3QgdnJp
bmdfZGVzY19leHRyYSAqdnJpbmdfYWxsb2NfZGVzY19leHRyYSh1bnNpZ25lZCBpbnQgbnVtKTsK
PiA+Cj4gPiAgIC8qCj4gPiAgICAqIEhlbHBlcnMuCj4gPiBAQCAtOTE1LDYgKzkxNiwzMyBAQCBz
dGF0aWMgdm9pZCAqdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmX3NwbGl0KHN0cnVjdCB2aXJ0
cXVldWUgKl92cSkKPiA+ICAgCXJldHVybiBOVUxMOwo+ID4gICB9Cj4gPgo+ID4gK3N0YXRpYyBp
bnQgdnJpbmdfYWxsb2Nfc3RhdGVfZXh0cmFfc3BsaXQodTMyIG51bSwKPiA+ICsJCQkJCSBzdHJ1
Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxpdCAqKmRlc2Nfc3RhdGUsCj4gPiArCQkJCQkgc3RydWN0
IHZyaW5nX2Rlc2NfZXh0cmEgKipkZXNjX2V4dHJhKQo+ID4gK3sKPiA+ICsJc3RydWN0IHZyaW5n
X2Rlc2Nfc3RhdGVfc3BsaXQgKnN0YXRlOwo+ID4gKwlzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAq
ZXh0cmE7Cj4gPiArCj4gPiArCXN0YXRlID0ga21hbGxvY19hcnJheShudW0sIHNpemVvZihzdHJ1
Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxpdCksIEdGUF9LRVJORUwpOwo+ID4gKwlpZiAoIXN0YXRl
KQo+ID4gKwkJZ290byBlcnJfc3RhdGU7Cj4gPiArCj4gPiArCWV4dHJhID0gdnJpbmdfYWxsb2Nf
ZGVzY19leHRyYShudW0pOwo+ID4gKwlpZiAoIWV4dHJhKQo+ID4gKwkJZ290byBlcnJfZXh0cmE7
Cj4gPiArCj4gPiArCW1lbXNldChzdGF0ZSwgMCwgbnVtICogc2l6ZW9mKHN0cnVjdCB2cmluZ19k
ZXNjX3N0YXRlX3NwbGl0KSk7Cj4gPiArCj4gPiArCSpkZXNjX3N0YXRlID0gc3RhdGU7Cj4gPiAr
CSpkZXNjX2V4dHJhID0gZXh0cmE7Cj4gPiArCXJldHVybiAwOwo+ID4gKwo+ID4gK2Vycl9leHRy
YToKPiA+ICsJa2ZyZWUoc3RhdGUpOwo+ID4gK2Vycl9zdGF0ZToKPiA+ICsJcmV0dXJuIC1FTk9N
RU07Cj4gPiArfQo+ID4gKwo+ID4gICBzdGF0aWMgdm9pZCAqdnJpbmdfYWxsb2NfcXVldWVfc3Bs
aXQoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gPiAgIAkJCQkgICAgIGRtYV9hZGRyX3Qg
KmRtYV9hZGRyLAo+ID4gICAJCQkJICAgICB1MzIgKm4sCj4gPiBAQCAtMjE5Niw3ICsyMjI0LDEw
IEBAIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQg
aW5kZXgsCj4gPiAgIAkJCQkJdm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+
ID4gICAJCQkJCWNvbnN0IGNoYXIgKm5hbWUpCj4gPiAgIHsKPiA+ICsJc3RydWN0IHZyaW5nX2Rl
c2Nfc3RhdGVfc3BsaXQgKnN0YXRlOwo+ID4gKwlzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAqZXh0
cmE7Cj4gPiAgIAlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cTsKPiA+ICsJaW50IGVycjsKPiA+
Cj4gPiAgIAlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19GX1JJTkdfUEFDS0VE
KSkKPiA+ICAgCQlyZXR1cm4gTlVMTDsKPiA+IEBAIC0yMjQ2LDMwICsyMjc3LDIyIEBAIHN0cnVj
dCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4g
PiAgIAkJCQkJdnEtPnNwbGl0LmF2YWlsX2ZsYWdzX3NoYWRvdyk7Cj4gPiAgIAl9Cj4gPgo+ID4g
LQl2cS0+c3BsaXQuZGVzY19zdGF0ZSA9IGttYWxsb2NfYXJyYXkodnJpbmcubnVtLAo+ID4gLQkJ
CXNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxpdCksIEdGUF9LRVJORUwpOwo+ID4g
LQlpZiAoIXZxLT5zcGxpdC5kZXNjX3N0YXRlKQo+ID4gLQkJZ290byBlcnJfc3RhdGU7Cj4gPiAr
CWVyciA9IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3NwbGl0KHZyaW5nLm51bSwgJnN0YXRlLCAm
ZXh0cmEpOwo+Cj4KPiBOaXQ6IHdlIGNhbiBwYXNzIGUuZyAmdnEtPnNwbGl0LmRlc2Nfc3RhdGUg
aGVyZSB0byBhdm9pZCBleHRyYSB0ZW1wCj4gdmFyaWFibGUgYW5kIGFzc2lnbm1lbnQuCgpUaGUg
cmVhc29uIGZvciBub3QgZG9pbmcgdGhpcyBpcyB0aGF0IHdoZW4gd2UgaW1wbGVtZW50IHJlc2l6
ZSBsYXRlciwgd2hlbiB3ZQpjYWxsIHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3NwbGl0KCksIHdl
IHdhbnQgdG8ga2VlcCB0aGUgb2xkIGRlc2Nfc3RhdGUsIGFuZApkZXNjX2V4dHJhIGJlY2F1c2Ug
d2Ugd2FudCB0byByZWxlYXNlIHRoZW0uCgpBcyBkaXNjdXNzZWQgaW4gcGF0Y2ggMTEsIDEyLCBz
dHJ1Y3QgdnJpbmdfdmlydHF1ZXVlX3NwbGl0IHdpbGwgb3B0aW1pemUgdGhpcwpsb2dpYy4KClRo
YW5rcy4KCj4KPiBPdGhlciBsb29rcyBnb29kLgo+Cj4gVGhhbmtzCj4KPgo+ID4gKwlpZiAoZXJy
KSB7Cj4gPiArCQlrZnJlZSh2cSk7Cj4gPiArCQlyZXR1cm4gTlVMTDsKPiA+ICsJfQo+ID4KPiA+
IC0JdnEtPnNwbGl0LmRlc2NfZXh0cmEgPSB2cmluZ19hbGxvY19kZXNjX2V4dHJhKHZyaW5nLm51
bSk7Cj4gPiAtCWlmICghdnEtPnNwbGl0LmRlc2NfZXh0cmEpCj4gPiAtCQlnb3RvIGVycl9leHRy
YTsKPiA+ICsJdnEtPnNwbGl0LmRlc2Nfc3RhdGUgPSBzdGF0ZTsKPiA+ICsJdnEtPnNwbGl0LmRl
c2NfZXh0cmEgPSBleHRyYTsKPiA+Cj4gPiAgIAkvKiBQdXQgZXZlcnl0aGluZyBpbiBmcmVlIGxp
c3RzLiAqLwo+ID4gICAJdnEtPmZyZWVfaGVhZCA9IDA7Cj4gPiAtCW1lbXNldCh2cS0+c3BsaXQu
ZGVzY19zdGF0ZSwgMCwgdnJpbmcubnVtICoKPiA+IC0JCQlzaXplb2Yoc3RydWN0IHZyaW5nX2Rl
c2Nfc3RhdGVfc3BsaXQpKTsKPiA+Cj4gPiAgIAlzcGluX2xvY2soJnZkZXYtPnZxc19saXN0X2xv
Y2spOwo+ID4gICAJbGlzdF9hZGRfdGFpbCgmdnEtPnZxLmxpc3QsICZ2ZGV2LT52cXMpOwo+ID4g
ICAJc3Bpbl91bmxvY2soJnZkZXYtPnZxc19saXN0X2xvY2spOwo+ID4gICAJcmV0dXJuICZ2cS0+
dnE7Cj4gPiAtCj4gPiAtZXJyX2V4dHJhOgo+ID4gLQlrZnJlZSh2cS0+c3BsaXQuZGVzY19zdGF0
ZSk7Cj4gPiAtZXJyX3N0YXRlOgo+ID4gLQlrZnJlZSh2cSk7Cj4gPiAtCXJldHVybiBOVUxMOwo+
ID4gICB9Cj4gPiAgIEVYUE9SVF9TWU1CT0xfR1BMKF9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSk7Cj4g
Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
