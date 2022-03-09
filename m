Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54E8C4167E
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 09:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D71340AC9;
	Wed,  9 Mar 2022 09:28:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YG9ph2v29CLk; Wed,  9 Mar 2022 09:28:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C67FB40190;
	Wed,  9 Mar 2022 09:28:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83223C0012;
	Wed,  9 Mar 2022 09:28:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15849C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:28:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9EA460F76
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:28:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OWZ3P494MTxH
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:28:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E296F60C0D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:28:09 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R711e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V6j5umZ_1646818083; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6j5umZ_1646818083) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Mar 2022 17:28:04 +0800
Message-ID: <1646818039.8335996-8-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 14/26] virtio: add helper for queue reset
Date: Wed, 9 Mar 2022 17:27:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-15-xuanzhuo@linux.alibaba.com>
 <fda406d7-3ed9-7c62-0f26-4058a63e73a9@redhat.com>
In-Reply-To: <fda406d7-3ed9-7c62-0f26-4058a63e73a9@redhat.com>
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

T24gV2VkLCA5IE1hciAyMDIyIDE2OjQ4OjI4ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gQWRkIGhlbHBlciBmb3IgdmlydGlvIHF1ZXVlIHJlc2V0Lgo+ID4KPiA+ICog
dmlydGlvX3Jlc2V0X3ZxKCk6IHJlc2V0IGEgcXVldWUgaW5kaXZpZHVhbGx5Cj4gPiAqIHZpcnRp
b19lbmFibGVfcmVzZXRxKCk6IGVuYWJsZSBhIHJlc2V0IHF1ZXVlCj4gPgo+ID4gU2lnbmVkLW9m
Zi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4g
ICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaCB8IDQwICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspCj4g
Pgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oIGIvaW5jbHVk
ZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiA+IGluZGV4IGQ1MTkwNmIxMzg5Zi4uMGI4MWZiZTE3
Yzg1IDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiA+ICsr
KyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gPiBAQCAtMjMwLDYgKzIzMCw0NiBA
QCBpbnQgdmlydGlvX2ZpbmRfdnFzX2N0eChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5z
aWduZWQgbnZxcywKPiA+ICAgCQkJCSAgICAgIGRlc2MpOwo+ID4gICB9Cj4gPgo+ID4gKy8qKgo+
ID4gKyAqIHZpcnRpb19yZXNldF92cSAtIHJlc2V0IGEgcXVldWUgaW5kaXZpZHVhbGx5Cj4gPiAr
ICogQHZxOiB0aGUgdmlydHF1ZXVlCj4gPiArICoKPiA+ICsgKiByZXR1cm5zIDAgb24gc3VjY2Vz
cyBvciBlcnJvciBzdGF0dXMKPiA+ICsgKgo+ID4gKyAqIFRoZSBhcGkgcHJvY2VzcyBvZiByZXNl
dCB1bmRlciBub3JtYWwgY2lyY3Vtc3RhbmNlczoKPiA+ICsgKgkxLiB2aXJ0aW9fcmVzZXRfdnEo
KSAgICAgICAgICAgICAgLSBub3RpZnkgdGhlIGRldmljZSB0byByZXNldCB0aGUgcXVldWUKPiA+
ICsgKgkyLiB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYoKSAgLSByZWN5Y2xlIHRoZSBidWZm
ZXIgc3VibWl0dGVkCj4gPiArICoJMy4gdmlydHF1ZXVlX3Jlc2V0X3ZyaW5nKCkgICAgICAgIC0g
cmVzZXQgdGhlIHZyaW5nIChtYXkgcmUtYWxsb2MpCj4gPiArICoJNC4gdmlydGlvX2VuYWJsZV9y
ZXNldHEoKSAgICAgICAgIC0gbW1hcCB2cmluZyB0byBkZXZpY2UsIGFuZCBlbmFibGUgdGhlIHF1
ZXVlCj4gPiArICoKPiA+ICsgKiBDYWxsZXIgc2hvdWxkIGd1YXJhbnRlZSB0aGF0IHRoZSB2cmlu
ZyBpcyBub3QgYWNjZXNzZWQgYnkgYW55IGZ1bmN0aW9ucwo+ID4gKyAqIG9mIHZpcnRxdWV1ZS4K
PiA+ICsgKi8KPiA+ICtzdGF0aWMgaW5saW5lCj4gPiAraW50IHZpcnRpb19yZXNldF92cShzdHJ1
Y3QgdmlydHF1ZXVlICp2cSkKPiA+ICt7Cj4KPgo+IEl0IGxvb2tzIHRvIG1lIHRoZSBwcmVmaXgg
InZpcnRpbyIgaXMgdXNlZCBmb3IgdGhlIGRldmljZSBzcGVjaWZpYwo+IG9wZXJhdGlvbnMuCj4K
PiBJIHdvbmRlciBpZiBpdCdzIGJldHRlciB0byByZW5hbWUgdGhpcyBhcyB2aXJ0cXVldWVfcmVz
dGUoKSBhbmQgbW92ZSBpdAo+IHRvIHZpcnRpb19yaW5nLmM/CgpDYWxsIHZxLT52ZGV2LT5jb25m
aWctPnJlc2V0X3ZxIGluIHZpcnRpb19yaW5nLmM/CgpJZiBpdCBmaXRzLCBJIHRoaW5rIGl0J3Mg
ZmluZS4KClRoYW5rcy4KCj4KPiBUaGFua3MKPgo+Cj4gPiArCWlmICghdnEtPnZkZXYtPmNvbmZp
Zy0+cmVzZXRfdnEpCj4gPiArCQlyZXR1cm4gLUVOT0VOVDsKPiA+ICsKPiA+ICsJcmV0dXJuIHZx
LT52ZGV2LT5jb25maWctPnJlc2V0X3ZxKHZxKTsKPiA+ICt9Cj4gPiArCj4gPiArLyoqCj4gPiAr
ICogdmlydGlvX2VuYWJsZV9yZXNldHEgLSBlbmFibGUgYSByZXNldCBxdWV1ZQo+ID4gKyAqIEB2
cTogdGhlIHZpcnRxdWV1ZQo+ID4gKyAqCj4gPiArICogcmV0dXJucyAwIG9uIHN1Y2Nlc3Mgb3Ig
ZXJyb3Igc3RhdHVzCj4gPiArICoKPiA+ICsgKi8KPiA+ICtzdGF0aWMgaW5saW5lCj4gPiAraW50
IHZpcnRpb19lbmFibGVfcmVzZXRxKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+ID4gK3sKPiA+ICsJ
aWYgKCF2cS0+dmRldi0+Y29uZmlnLT5lbmFibGVfcmVzZXRfdnEpCj4gPiArCQlyZXR1cm4gLUVO
T0VOVDsKPiA+ICsKPiA+ICsJcmV0dXJuIHZxLT52ZGV2LT5jb25maWctPmVuYWJsZV9yZXNldF92
cSh2cSk7Cj4gPiArfQo+ID4gKwo+ID4gICAvKioKPiA+ICAgICogdmlydGlvX2RldmljZV9yZWFk
eSAtIGVuYWJsZSB2cSB1c2UgaW4gcHJvYmUgZnVuY3Rpb24KPiA+ICAgICogQHZkZXY6IHRoZSBk
ZXZpY2UKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
