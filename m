Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902CDC43219
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 12:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 35286401C9;
	Wed, 13 Apr 2022 12:19:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vAQ9su_LdRyO; Wed, 13 Apr 2022 12:19:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AB51D403AC;
	Wed, 13 Apr 2022 12:19:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B16AC002F;
	Wed, 13 Apr 2022 12:19:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AAB9C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 12:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 78E1F81CDB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 12:19:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xj2HgLgdU4S8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 12:19:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3567281C44
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 12:19:02 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R911e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V9zZ.hy_1649852336; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V9zZ.hy_1649852336) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 13 Apr 2022 20:18:57 +0800
Message-ID: <1649852080.6360478-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v9 18/32] virtio_ring: introduce virtqueue_resize()
Date: Wed, 13 Apr 2022 20:14:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-19-xuanzhuo@linux.alibaba.com>
 <92622553-e02d-47bd-06f9-0ce24c22650c@redhat.com>
In-Reply-To: <92622553-e02d-47bd-06f9-0ce24c22650c@redhat.com>
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

T24gVHVlLCAxMiBBcHIgMjAyMiAxNDo0MToxOCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi80LzYg5LiK5Y2IMTE6NDMsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBJbnRyb2R1Y2UgdmlydHF1ZXVlX3Jlc2l6ZSgpIHRvIGltcGxlbWVudCB0
aGUgcmVzaXplIG9mIHZyaW5nLgo+ID4gQmFzZWQgb24gdGhlc2UsIHRoZSBkcml2ZXIgY2FuIGR5
bmFtaWNhbGx5IGFkanVzdCB0aGUgc2l6ZSBvZiB0aGUgdnJpbmcuCj4gPiBGb3IgZXhhbXBsZTog
ZXRodG9vbCAtRy4KPiA+Cj4gPiB2aXJ0cXVldWVfcmVzaXplKCkgaW1wbGVtZW50cyByZXNpemUg
YmFzZWQgb24gdGhlIHZxIHJlc2V0IGZ1bmN0aW9uLiBJbgo+ID4gY2FzZSBvZiBmYWlsdXJlIHRv
IGFsbG9jYXRlIGEgbmV3IHZyaW5nLCBpdCB3aWxsIGdpdmUgdXAgcmVzaXplIGFuZCB1c2UKPiA+
IHRoZSBvcmlnaW5hbCB2cmluZy4KPiA+Cj4gPiBEdXJpbmcgdGhpcyBwcm9jZXNzLCBpZiB0aGUg
cmUtZW5hYmxlIHJlc2V0IHZxIGZhaWxzLCB0aGUgdnEgY2FuIG5vCj4gPiBsb25nZXIgYmUgdXNl
ZC4gQWx0aG91Z2ggdGhlIHByb2JhYmlsaXR5IG9mIHRoaXMgc2l0dWF0aW9uIGlzIG5vdCBoaWdo
Lgo+ID4KPiA+IFRoZSBwYXJhbWV0ZXIgcmVjeWNsZSBpcyB1c2VkIHRvIHJlY3ljbGUgdGhlIGJ1
ZmZlciB0aGF0IGlzIG5vIGxvbmdlcgo+ID4gdXNlZC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA2OSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysKPiA+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAzICsrCj4gPiAg
IDIgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ID4gaW5kZXggMDZmNjZiMTVjODZjLi42MjUwZTE5ZmM1YmYgMTAwNjQ0Cj4gPiAtLS0gYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jCj4gPiBAQCAtMjU1NCw2ICsyNTU0LDc1IEBAIHN0cnVjdCB2aXJ0cXVldWUgKnZy
aW5nX2NyZWF0ZV92aXJ0cXVldWUoCj4gPiAgIH0KPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwodnJp
bmdfY3JlYXRlX3ZpcnRxdWV1ZSk7Cj4gPgo+ID4gKy8qKgo+ID4gKyAqIHZpcnRxdWV1ZV9yZXNp
emUgLSByZXNpemUgdGhlIHZyaW5nIG9mIHZxCj4gPiArICogQF92cTogdGhlIHN0cnVjdCB2aXJ0
cXVldWUgd2UncmUgdGFsa2luZyBhYm91dC4KPiA+ICsgKiBAbnVtOiBuZXcgcmluZyBudW0KPiA+
ICsgKiBAcmVjeWNsZTogY2FsbGJhY2sgZm9yIHJlY3ljbGUgdGhlIHVzZWxlc3MgYnVmZmVyCj4g
PiArICoKPiA+ICsgKiBXaGVuIGl0IGlzIHJlYWxseSBuZWNlc3NhcnkgdG8gY3JlYXRlIGEgbmV3
IHZyaW5nLCBpdCB3aWxsIHNldCB0aGUgY3VycmVudCB2cQo+ID4gKyAqIGludG8gdGhlIHJlc2V0
IHN0YXRlLiBUaGVuIGNhbGwgdGhlIHBhc3NlZCBjYWxsYmFjayB0byByZWN5Y2xlIHRoZSBidWZm
ZXIKPiA+ICsgKiB0aGF0IGlzIG5vIGxvbmdlciB1c2VkLiBPbmx5IGFmdGVyIHRoZSBuZXcgdnJp
bmcgaXMgc3VjY2Vzc2Z1bGx5IGNyZWF0ZWQsIHRoZQo+ID4gKyAqIG9sZCB2cmluZyB3aWxsIGJl
IHJlbGVhc2VkLgo+ID4gKyAqCj4gPiArICogQ2FsbGVyIG11c3QgZW5zdXJlIHdlIGRvbid0IGNh
bGwgdGhpcyB3aXRoIG90aGVyIHZpcnRxdWV1ZSBvcGVyYXRpb25zCj4gPiArICogYXQgdGhlIHNh
bWUgdGltZSAoZXhjZXB0IHdoZXJlIG5vdGVkKS4KPiA+ICsgKgo+ID4gKyAqIFJldHVybnMgemVy
byBvciBhIG5lZ2F0aXZlIGVycm9yLgo+Cj4KPiBTaG91bGQgd2UgZG9jdW1lbnQgdGhhdCB0aGUg
dmlydHF1ZXVlIGlzIGtlcHQgdW5jaGFuZ2VkIChzdGlsbAo+IGF2YWlsYWJsZSkgb24gKHNwZWNp
ZmljKSBmYWlsdXJlPwo+CgpPSy4KCj4KPiA+ICsgKi8KPiA+ICtpbnQgdmlydHF1ZXVlX3Jlc2l6
ZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBudW0sCj4gPiArCQkgICAgIHZvaWQgKCpyZWN5
Y2xlKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKSkKPiA+ICt7Cj4gPiArCXN0cnVj
dCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gPiArCXN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICp2ZGV2ID0gdnEtPnZxLnZkZXY7Cj4gPiArCWJvb2wgcGFja2VkOwo+ID4gKwl2b2lk
ICpidWY7Cj4gPiArCWludCBlcnI7Cj4gPiArCj4gPiArCWlmICghdnEtPndlX293bl9yaW5nKQo+
ID4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gPiArCj4gPiArCWlmIChudW0gPiB2cS0+dnEubnVtX21h
eCkKPiA+ICsJCXJldHVybiAtRTJCSUc7Cj4gPiArCj4gPiArCWlmICghbnVtKQo+ID4gKwkJcmV0
dXJuIC1FSU5WQUw7Cj4gPiArCj4gPiArCXBhY2tlZCA9IHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2
LCBWSVJUSU9fRl9SSU5HX1BBQ0tFRCkgPyB0cnVlIDogZmFsc2U7Cj4gPiArCj4gPiArCWlmICgo
cGFja2VkID8gdnEtPnBhY2tlZC52cmluZy5udW0gOiB2cS0+c3BsaXQudnJpbmcubnVtKSA9PSBu
dW0pCj4gPiArCQlyZXR1cm4gMDsKPiA+ICsKPiA+ICsJaWYgKCF2ZGV2LT5jb25maWctPnJlc2V0
X3ZxKQo+ID4gKwkJcmV0dXJuIC1FTk9FTlQ7Cj4gPiArCj4gPiArCWlmICghdmRldi0+Y29uZmln
LT5lbmFibGVfcmVzZXRfdnEpCj4gPiArCQlyZXR1cm4gLUVOT0VOVDsKPiA+ICsKPiA+ICsJZXJy
ID0gdmRldi0+Y29uZmlnLT5yZXNldF92cShfdnEpOwo+ID4gKwlpZiAoZXJyKQo+ID4gKwkJcmV0
dXJuIGVycjsKPiA+ICsKPiA+ICsJd2hpbGUgKChidWYgPSB2aXJ0cXVldWVfZGV0YWNoX3VudXNl
ZF9idWYoX3ZxKSkgIT0gTlVMTCkKPiA+ICsJCXJlY3ljbGUoX3ZxLCBidWYpOwo+ID4gKwo+ID4g
KwlpZiAocGFja2VkKSB7Cj4gPiArCQllcnIgPSB2aXJ0cXVldWVfcmVzaXplX3BhY2tlZChfdnEs
IG51bSk7Cj4gPiArCQlpZiAoZXJyKQo+ID4gKwkJCXZpcnRxdWV1ZV9yZWluaXRfcGFja2VkKHZx
KTsKPgo+Cj4gQ2FsbGluZyByZWluaXQgaGVyZSBzZWVtcyBhIGxpdHRsZSBiaXQgb2RkLCBpdCBs
b29rcyBtb3JlIGxpa2UgYSByZXNldAo+IG9mIHRoZSB2aXJ0cXVldWUuIENvbnNpZGVyIHdlIG1h
eSByZS11c2UgdmlydHF1ZXVlIHJlc2V0IGZvciBtb3JlCj4gcHVycG9zZSwgSSB3b25kZXIgaWYg
d2UgbmVlZCBhIGhlbHBlciBsaWtlOgo+Cj4gdmlydHF1ZXVlX3Jlc2l6ZSgpIHsKPiAgwqDCoMKg
IHZkZXYtPmNvbmZpZy0+cmVzZXRfdnEoX3ZxKTsKPiAgwqDCoMKgIGlmIChwYWNrZWQpCj4gIMKg
wqDCoCDCoMKgwqAgdmlydHF1ZXVlX3JlaW5pdF9wYWNrZWQoX3ZxKQo+ICDCoMKgwqAgZWxzZQo+
ICDCoMKgwqDCoMKgwqDCoCB2aXJ0cXVldWVfcmVpbml0X3NwbGl0KF92cSkKPiB9CgpZZXMsIGN1
cnJlbnRseSB3ZSBhcmUgaW1wbGVtZW50aW5nIHJlc2l6ZS4gVGhpcyBpcyB1c2VkIHRvIGltcGxl
bWVudApzZXRfcmluZ3BhcmFtKCkKCkxhdGVyLCB3aGVuIHdlIGltcGxlbWVudCB2aXJ0aW9fbmV0
ICsgQUZfWERQLCB3aGF0IHdlIHdhbnQgaXMgcmVzZXQgbm90IHJlc2l6ZSwKc28gd2UgbmVlZCB0
byBpbXBsZW1lbnQgYSBoZWxwZXI6CgogdmlydHF1ZXVlX3Jlc2V0KCkgewogIMKgwqDCoCB2ZGV2
LT5jb25maWctPnJlc2V0X3ZxKF92cSk7CiAgwqDCoMKgIGlmIChwYWNrZWQpCiAgwqDCoMKgIMKg
wqDCoCB2aXJ0cXVldWVfcmVpbml0X3BhY2tlZChfdnEpCiAgwqDCoMKgIGVsc2UKICDCoMKgwqDC
oMKgwqDCoCB2aXJ0cXVldWVfcmVpbml0X3NwbGl0KF92cSkKIH0KClNvIEkgdXNlIHZpcnRxdWV1
ZV9yZWluaXRfKiBhcyBhIHNlcGFyYXRlIGZ1bmN0aW9uIG5vdCBvbmx5IHRvIGRlYWwgd2l0aCB0
aGUKY2FzZSBvZiByZXNpemUgZmFpbHVyZSwgYnV0IGFsc28gdG8gY29uc2lkZXIgdGhlIHN1YnNl
cXVlbnQgaW1wbGVtZW50YXRpb24gb2YKdmlydHF1ZXVlX3Jlc2V0KCkKClRoYW5rcy4KCgo+Cj4g
VGhhbmtzCj4KPgo+ID4gKwl9IGVsc2Ugewo+ID4gKwkJZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZV9z
cGxpdChfdnEsIG51bSk7Cj4gPiArCQlpZiAoZXJyKQo+ID4gKwkJCXZpcnRxdWV1ZV9yZWluaXRf
c3BsaXQodnEpOwo+ID4gKwl9Cj4gPiArCj4gPiArCWlmICh2ZGV2LT5jb25maWctPmVuYWJsZV9y
ZXNldF92cShfdnEpKQo+ID4gKwkJcmV0dXJuIC1FQlVTWTsKPiA+ICsKPiA+ICsJcmV0dXJuIGVy
cjsKPiA+ICt9Cj4gPiArRVhQT1JUX1NZTUJPTF9HUEwodmlydHF1ZXVlX3Jlc2l6ZSk7Cj4gPiAr
Cj4gPiAgIC8qIE9ubHkgYXZhaWxhYmxlIGZvciBzcGxpdCByaW5nICovCj4gPiAgIHN0cnVjdCB2
aXJ0cXVldWUgKnZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ID4gICAJ
CQkJICAgICAgdW5zaWduZWQgaW50IG51bSwKPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ID4gaW5kZXggZDU5YWRjNGJlMDY4
Li5jODZmZjAyZTBjYTAgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4g
PiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiBAQCAtOTEsNiArOTEsOSBAQCBkbWFf
YWRkcl90IHZpcnRxdWV1ZV9nZXRfZGVzY19hZGRyKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiA+
ICAgZG1hX2FkZHJfdCB2aXJ0cXVldWVfZ2V0X2F2YWlsX2FkZHIoc3RydWN0IHZpcnRxdWV1ZSAq
dnEpOwo+ID4gICBkbWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKHN0cnVjdCB2aXJ0
cXVldWUgKnZxKTsKPiA+Cj4gPiAraW50IHZpcnRxdWV1ZV9yZXNpemUoc3RydWN0IHZpcnRxdWV1
ZSAqdnEsIHUzMiBudW0sCj4gPiArCQkgICAgIHZvaWQgKCpyZWN5Y2xlKShzdHJ1Y3QgdmlydHF1
ZXVlICp2cSwgdm9pZCAqYnVmKSk7Cj4gPiArCj4gPiAgIC8qKgo+ID4gICAgKiB2aXJ0aW9fZGV2
aWNlIC0gcmVwcmVzZW50YXRpb24gb2YgYSBkZXZpY2UgdXNpbmcgdmlydGlvCj4gPiAgICAqIEBp
bmRleDogdW5pcXVlIHBvc2l0aW9uIG9uIHRoZSB2aXJ0aW8gYnVzCj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
