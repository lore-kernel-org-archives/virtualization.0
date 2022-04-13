Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2938C43219
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 12:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D27E40228;
	Wed, 13 Apr 2022 12:22:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zSQDaRuUWZ8q; Wed, 13 Apr 2022 12:22:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6AB95401F7;
	Wed, 13 Apr 2022 12:22:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4010DC002F;
	Wed, 13 Apr 2022 12:22:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE6A7C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 12:22:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD07940228
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 12:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DRhlD5pLzOQ8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 12:22:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8FC06401F7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 12:22:50 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V9zbh3._1649852563; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V9zbh3._1649852563) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 13 Apr 2022 20:22:44 +0800
Message-ID: <1649852469.9980721-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v9 18/32] virtio_ring: introduce virtqueue_resize()
Date: Wed, 13 Apr 2022 20:21:09 +0800
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
ZmljKSBmYWlsdXJlPwo+Cj4KPiA+ICsgKi8KPiA+ICtpbnQgdmlydHF1ZXVlX3Jlc2l6ZShzdHJ1
Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBudW0sCj4gPiArCQkgICAgIHZvaWQgKCpyZWN5Y2xlKShz
dHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKSkKPiA+ICt7Cj4gPiArCXN0cnVjdCB2cmlu
Z192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gPiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2ID0gdnEtPnZxLnZkZXY7Cj4gPiArCWJvb2wgcGFja2VkOwo+ID4gKwl2b2lkICpidWY7
Cj4gPiArCWludCBlcnI7Cj4gPiArCj4gPiArCWlmICghdnEtPndlX293bl9yaW5nKQo+ID4gKwkJ
cmV0dXJuIC1FSU5WQUw7Cj4gPiArCj4gPiArCWlmIChudW0gPiB2cS0+dnEubnVtX21heCkKPiA+
ICsJCXJldHVybiAtRTJCSUc7Cj4gPiArCj4gPiArCWlmICghbnVtKQo+ID4gKwkJcmV0dXJuIC1F
SU5WQUw7Cj4gPiArCj4gPiArCXBhY2tlZCA9IHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJU
SU9fRl9SSU5HX1BBQ0tFRCkgPyB0cnVlIDogZmFsc2U7Cj4gPiArCj4gPiArCWlmICgocGFja2Vk
ID8gdnEtPnBhY2tlZC52cmluZy5udW0gOiB2cS0+c3BsaXQudnJpbmcubnVtKSA9PSBudW0pCj4g
PiArCQlyZXR1cm4gMDsKPiA+ICsKPiA+ICsJaWYgKCF2ZGV2LT5jb25maWctPnJlc2V0X3ZxKQo+
ID4gKwkJcmV0dXJuIC1FTk9FTlQ7Cj4gPiArCj4gPiArCWlmICghdmRldi0+Y29uZmlnLT5lbmFi
bGVfcmVzZXRfdnEpCj4gPiArCQlyZXR1cm4gLUVOT0VOVDsKPiA+ICsKPiA+ICsJZXJyID0gdmRl
di0+Y29uZmlnLT5yZXNldF92cShfdnEpOwo+ID4gKwlpZiAoZXJyKQo+ID4gKwkJcmV0dXJuIGVy
cjsKPiA+ICsKPiA+ICsJd2hpbGUgKChidWYgPSB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYo
X3ZxKSkgIT0gTlVMTCkKPiA+ICsJCXJlY3ljbGUoX3ZxLCBidWYpOwo+ID4gKwo+ID4gKwlpZiAo
cGFja2VkKSB7Cj4gPiArCQllcnIgPSB2aXJ0cXVldWVfcmVzaXplX3BhY2tlZChfdnEsIG51bSk7
Cj4gPiArCQlpZiAoZXJyKQo+ID4gKwkJCXZpcnRxdWV1ZV9yZWluaXRfcGFja2VkKHZxKTsKPgo+
Cj4gQ2FsbGluZyByZWluaXQgaGVyZSBzZWVtcyBhIGxpdHRsZSBiaXQgb2RkLCBpdCBsb29rcyBt
b3JlIGxpa2UgYSByZXNldAoKCkkgYWxzbyBmZWVsIHRoYXQgdGhpcyBpcyBhIGJpdCBvZGQsIEkg
d2lsbCBwdXQgdmlydHF1ZXVlX3JlaW5pdF8qIGludG8KdmlydHF1ZXVlX3Jlc2l6ZV8qLgoKVGhh
bmtzLgoKPiBvZiB0aGUgdmlydHF1ZXVlLiBDb25zaWRlciB3ZSBtYXkgcmUtdXNlIHZpcnRxdWV1
ZSByZXNldCBmb3IgbW9yZQo+IHB1cnBvc2UsIEkgd29uZGVyIGlmIHdlIG5lZWQgYSBoZWxwZXIg
bGlrZToKPgo+IHZpcnRxdWV1ZV9yZXNpemUoKSB7Cj4gIMKgwqDCoCB2ZGV2LT5jb25maWctPnJl
c2V0X3ZxKF92cSk7Cj4gIMKgwqDCoCBpZiAocGFja2VkKQo+ICDCoMKgwqAgwqDCoMKgIHZpcnRx
dWV1ZV9yZWluaXRfcGFja2VkKF92cSkKPiAgwqDCoMKgIGVsc2UKPiAgwqDCoMKgwqDCoMKgwqAg
dmlydHF1ZXVlX3JlaW5pdF9zcGxpdChfdnEpCj4gfQo+Cj4gVGhhbmtzCj4KPgo+ID4gKwl9IGVs
c2Ugewo+ID4gKwkJZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdChfdnEsIG51bSk7Cj4gPiAr
CQlpZiAoZXJyKQo+ID4gKwkJCXZpcnRxdWV1ZV9yZWluaXRfc3BsaXQodnEpOwo+ID4gKwl9Cj4g
PiArCj4gPiArCWlmICh2ZGV2LT5jb25maWctPmVuYWJsZV9yZXNldF92cShfdnEpKQo+ID4gKwkJ
cmV0dXJuIC1FQlVTWTsKPiA+ICsKPiA+ICsJcmV0dXJuIGVycjsKPiA+ICt9Cj4gPiArRVhQT1JU
X1NZTUJPTF9HUEwodmlydHF1ZXVlX3Jlc2l6ZSk7Cj4gPiArCj4gPiAgIC8qIE9ubHkgYXZhaWxh
YmxlIGZvciBzcGxpdCByaW5nICovCj4gPiAgIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX25ld192
aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ID4gICAJCQkJICAgICAgdW5zaWduZWQgaW50
IG51bSwKPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9s
aW51eC92aXJ0aW8uaAo+ID4gaW5kZXggZDU5YWRjNGJlMDY4Li5jODZmZjAyZTBjYTAgMTAwNjQ0
Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4
L3ZpcnRpby5oCj4gPiBAQCAtOTEsNiArOTEsOSBAQCBkbWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRf
ZGVzY19hZGRyKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiA+ICAgZG1hX2FkZHJfdCB2aXJ0cXVl
dWVfZ2V0X2F2YWlsX2FkZHIoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ID4gICBkbWFfYWRkcl90
IHZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiA+Cj4gPiAr
aW50IHZpcnRxdWV1ZV9yZXNpemUoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHUzMiBudW0sCj4gPiAr
CQkgICAgIHZvaWQgKCpyZWN5Y2xlKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKSk7
Cj4gPiArCj4gPiAgIC8qKgo+ID4gICAgKiB2aXJ0aW9fZGV2aWNlIC0gcmVwcmVzZW50YXRpb24g
b2YgYSBkZXZpY2UgdXNpbmcgdmlydGlvCj4gPiAgICAqIEBpbmRleDogdW5pcXVlIHBvc2l0aW9u
IG9uIHRoZSB2aXJ0aW8gYnVzCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
