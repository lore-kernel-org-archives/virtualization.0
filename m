Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCF4C433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 06:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA6B160FBC;
	Wed, 13 Apr 2022 06:47:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vt7ofBMK2zTx; Wed, 13 Apr 2022 06:47:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 98A73610BE;
	Wed, 13 Apr 2022 06:47:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C61EC0033;
	Wed, 13 Apr 2022 06:47:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23420C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07FEE409C0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kv65KO9kpDzW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:47:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com
 [47.90.199.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72C23409BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:47:40 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V9yF0Rm_1649832451; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V9yF0Rm_1649832451) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 13 Apr 2022 14:47:32 +0800
Message-ID: <1649832244.772237-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v9 08/32] virtio_ring: split: extract the logic of attach
 vring
Date: Wed, 13 Apr 2022 14:44:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-9-xuanzhuo@linux.alibaba.com>
 <28237db0-cf04-aa36-b7b8-de55b11d18db@redhat.com>
In-Reply-To: <28237db0-cf04-aa36-b7b8-de55b11d18db@redhat.com>
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

T24gVHVlLCAxMiBBcHIgMjAyMiAxMTozMTowOCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi80LzYg5LiK5Y2IMTE6NDMsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBTZXBhcmF0ZSB0aGUgbG9naWMgb2YgYXR0YWNoIHZyaW5nLCBzdWJzZXF1
ZW50IHBhdGNoZXMgd2lsbCBjYWxsIGl0Cj4gPiBzZXBhcmF0ZWx5Lgo+ID4KPiA+IFNpZ25lZC1v
ZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+
ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDIwICsrKysrKysrKysrKysrLS0tLS0t
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+
ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gaW5kZXggNmRlNjc0MzljYjU3Li4wODNmMjk5MmJh
MGQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiArKysg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBAQCAtOTE2LDYgKzkxNiwxOSBAQCBz
dGF0aWMgdm9pZCAqdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmX3NwbGl0KHN0cnVjdCB2aXJ0
cXVldWUgKl92cSkKPiA+ICAgCXJldHVybiBOVUxMOwo+ID4gICB9Cj4gPgo+ID4gK3N0YXRpYyB2
b2lkIHZyaW5nX3ZpcnRxdWV1ZV9hdHRhY2hfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAq
dnEsCj4gPiArCQkJCQkgc3RydWN0IHZyaW5nIHZyaW5nLAo+ID4gKwkJCQkJIHN0cnVjdCB2cmlu
Z19kZXNjX3N0YXRlX3NwbGl0ICpkZXNjX3N0YXRlLAo+ID4gKwkJCQkJIHN0cnVjdCB2cmluZ19k
ZXNjX2V4dHJhICpkZXNjX2V4dHJhKQo+ID4gK3sKPiA+ICsJdnEtPnNwbGl0LnZyaW5nID0gdnJp
bmc7Cj4gPiArCXZxLT5zcGxpdC5xdWV1ZV9kbWFfYWRkciA9IDA7Cj4gPiArCXZxLT5zcGxpdC5x
dWV1ZV9zaXplX2luX2J5dGVzID0gMDsKPgo+Cj4gQW55IHJlYXNvbiB0byBhZGQgdGhlIGFib3Zl
IHR3byBhc3NpZ25tZW50IGluIGF0dGFjaD8gSXQgc2VlbXMgYmVsb25nIHRvCj4gZnJlZSBvciBy
ZXNldC4KCkFzIGRpc2N1c3NlZCBpbiBwYXRjaCAxMSwgc2luY2UgdGhlcmUgaXMgbm8gZG1hX2Fk
ZHIgaW4gX192cmluZ19uZXdfdmlydHF1ZXVlKCksCnRoZSBjb3JyZXNwb25kaW5nIHZxLT5zcGxp
dC5xdWV1ZV9kbWFfYWRkciBjYW5ub3QgYmUgc2V0LCBzbyB0aGUgcHVycG9zZSBoZXJlCmlzIGp1
c3QgdG8gaW5pdGlhbGl6ZSBpdC4KCkluIHRoZSBuZXh0IHZlcnNpb24sIHN0cnVjdCB2cmluZ192
aXJ0cXVldWVfc3BsaXQgd2lsbCBiZSBwYXNzZWQgdG8KdnJpbmdfdmlydHF1ZXVlX2F0dGFjaF9z
cGxpdCgpIHRvIG1ha2UgdGhlIGxvZ2ljIGhlcmUgbG9vayBtb3JlIHJlYXNvbmFibGUuCgpUaGFu
a3MuCgoKPgo+IFRoYW5rcwo+Cj4KPiA+ICsKPiA+ICsJdnEtPnNwbGl0LmRlc2Nfc3RhdGUgPSBk
ZXNjX3N0YXRlOwo+ID4gKwl2cS0+c3BsaXQuZGVzY19leHRyYSA9IGRlc2NfZXh0cmE7Cj4gPiAr
fQo+ID4gKwo+ID4gICBzdGF0aWMgaW50IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3NwbGl0KHUz
MiBudW0sCj4gPiAgIAkJCQkJIHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0ICoqZGVzY19z
dGF0ZSwKPiA+ICAgCQkJCQkgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKipkZXNjX2V4dHJhKQo+
ID4gQEAgLTIyNjIsMTAgKzIyNzUsNiBAQCBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192
aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ID4gICAJaWYgKHZpcnRpb19oYXNfZmVhdHVy
ZSh2ZGV2LCBWSVJUSU9fRl9PUkRFUl9QTEFURk9STSkpCj4gPiAgIAkJdnEtPndlYWtfYmFycmll
cnMgPSBmYWxzZTsKPiA+Cj4gPiAtCXZxLT5zcGxpdC5xdWV1ZV9kbWFfYWRkciA9IDA7Cj4gPiAt
CXZxLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzID0gMDsKPiA+IC0KPiA+IC0JdnEtPnNwbGl0
LnZyaW5nID0gdnJpbmc7Cj4gPiAgIAl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93ID0gMDsK
PiA+ICAgCXZxLT5zcGxpdC5hdmFpbF9pZHhfc2hhZG93ID0gMDsKPiA+Cj4gPiBAQCAtMjI4Myw4
ICsyMjkyLDcgQEAgc3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2ln
bmVkIGludCBpbmRleCwKPiA+ICAgCQlyZXR1cm4gTlVMTDsKPiA+ICAgCX0KPiA+Cj4gPiAtCXZx
LT5zcGxpdC5kZXNjX3N0YXRlID0gc3RhdGU7Cj4gPiAtCXZxLT5zcGxpdC5kZXNjX2V4dHJhID0g
ZXh0cmE7Cj4gPiArCXZyaW5nX3ZpcnRxdWV1ZV9hdHRhY2hfc3BsaXQodnEsIHZyaW5nLCBzdGF0
ZSwgZXh0cmEpOwo+ID4KPiA+ICAgCS8qIFB1dCBldmVyeXRoaW5nIGluIGZyZWUgbGlzdHMuICov
Cj4gPiAgIAl2cS0+ZnJlZV9oZWFkID0gMDsKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
