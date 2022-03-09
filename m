Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EC8C433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 09:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 863FC812CE;
	Wed,  9 Mar 2022 09:34:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yfjAvQLjBeL5; Wed,  9 Mar 2022 09:34:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0C369812C1;
	Wed,  9 Mar 2022 09:34:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3206C0012;
	Wed,  9 Mar 2022 09:34:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56AE1C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:34:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 400FC415F5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:34:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ErB72o_C-EHb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:34:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3261415F2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:34:06 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V6j5vtI_1646818439; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6j5vtI_1646818439) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Mar 2022 17:34:01 +0800
Message-ID: <1646818328.2590482-9-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 17/26] virtio_pci: queue_reset: support
 VIRTIO_F_RING_RESET
Date: Wed, 9 Mar 2022 17:32:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-18-xuanzhuo@linux.alibaba.com>
 <8b9d337d-71c2-07b4-8e65-6f83cf09bf7a@redhat.com>
In-Reply-To: <8b9d337d-71c2-07b4-8e65-6f83cf09bf7a@redhat.com>
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

T24gV2VkLCA5IE1hciAyMDIyIDE2OjU0OjEwICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHZpcnRpbyBwY2kgc3VwcG9ydCBmb3Ig
UVVFVUUgUkVTRVQuCj4gPgo+ID4gUGVyZm9ybWluZyByZXNldCBvbiBhIHF1ZXVlIGlzIGRpdmlk
ZWQgaW50byB0aGVzZSBzdGVwczoKPiA+Cj4gPiAgIDEuIHZpcnRpb19yZXNldF92cSgpICAgICAg
ICAgICAgICAtIG5vdGlmeSB0aGUgZGV2aWNlIHRvIHJlc2V0IHRoZSBxdWV1ZQo+ID4gICAyLiB2
aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYoKSAgLSByZWN5Y2xlIHRoZSBidWZmZXIgc3VibWl0
dGVkCj4gPiAgIDMuIHZpcnRxdWV1ZV9yZXNldF92cmluZygpICAgICAgICAtIHJlc2V0IHRoZSB2
cmluZyAobWF5IHJlLWFsbG9jKQo+ID4gICA0LiB2aXJ0aW9fZW5hYmxlX3Jlc2V0cSgpICAgICAg
ICAgLSBtbWFwIHZyaW5nIHRvIGRldmljZSwgYW5kIGVuYWJsZSB0aGUgcXVldWUKPiA+Cj4gPiBU
aGlzIHBhdGNoIGltcGxlbWVudHMgdmlydGlvX3Jlc2V0X3ZxKCksIHZpcnRpb19lbmFibGVfcmVz
ZXRxKCkgaW4gdGhlCj4gPiBwY2kgc2NlbmFyaW8uCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIHwgIDggKy0tCj4gPiAgIGRyaXZlcnMvdmlydGlv
L3ZpcnRpb19wY2lfbW9kZXJuLmMgfCA4MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
PiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA4OCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+
ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYwo+ID4gaW5kZXggZmRiZGUxZGI1ZWM1
Li44NjNkM2E4YTA5NTYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNp
X2NvbW1vbi5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4g
PiBAQCAtMjQ4LDkgKzI0OCwxMSBAQCBzdGF0aWMgdm9pZCB2cF9kZWxfdnEoc3RydWN0IHZpcnRx
dWV1ZSAqdnEpCj4gPiAgIAlzdHJ1Y3QgdmlydGlvX3BjaV92cV9pbmZvICppbmZvID0gdnBfZGV2
LT52cXNbdnEtPmluZGV4XTsKPiA+ICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4gPgo+ID4gLQlz
cGluX2xvY2tfaXJxc2F2ZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4gPiAtCWxpc3RfZGVsKCZp
bmZvLT5ub2RlKTsKPiA+IC0Jc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdnBfZGV2LT5sb2NrLCBm
bGFncyk7Cj4gPiArCWlmICghdnEtPnJlc2V0KSB7Cj4gPiArCQlzcGluX2xvY2tfaXJxc2F2ZSgm
dnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4gPiArCQlsaXN0X2RlbCgmaW5mby0+bm9kZSk7Cj4gPiAr
CQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiA+ICsJfQo+
ID4KPiA+ICAgCXZwX2Rldi0+ZGVsX3ZxKGluZm8pOwo+ID4gICAJa2ZyZWUoaW5mbyk7Cj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiA+IGluZGV4IDQ5YTQ0OTM3MzJjZi4uM2M2N2Qz
NjA3ODAyIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4u
Ywo+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+ID4gQEAgLTM0
LDYgKzM0LDkgQEAgc3RhdGljIHZvaWQgdnBfdHJhbnNwb3J0X2ZlYXR1cmVzKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpCj4gPiAgIAlpZiAoKGZlYXR1cmVzICYgQklU
X1VMTChWSVJUSU9fRl9TUl9JT1YpKSAmJgo+ID4gICAJCQlwY2lfZmluZF9leHRfY2FwYWJpbGl0
eShwY2lfZGV2LCBQQ0lfRVhUX0NBUF9JRF9TUklPVikpCj4gPiAgIAkJX192aXJ0aW9fc2V0X2Jp
dCh2ZGV2LCBWSVJUSU9fRl9TUl9JT1YpOwo+ID4gKwo+ID4gKwlpZiAoZmVhdHVyZXMgJiBCSVRf
VUxMKFZJUlRJT19GX1JJTkdfUkVTRVQpKQo+ID4gKwkJX192aXJ0aW9fc2V0X2JpdCh2ZGV2LCBW
SVJUSU9fRl9SSU5HX1JFU0VUKTsKPiA+ICAgfQo+ID4KPiA+ICAgLyogdmlydGlvIGNvbmZpZy0+
ZmluYWxpemVfZmVhdHVyZXMoKSBpbXBsZW1lbnRhdGlvbiAqLwo+ID4gQEAgLTE5OSw2ICsyMDIs
ODIgQEAgc3RhdGljIGludCB2cF9hY3RpdmVfdnEoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHUxNiBt
c2l4X3ZlYykKPiA+ICAgCXJldHVybiAwOwo+ID4gICB9Cj4gPgo+ID4gK3N0YXRpYyBpbnQgdnBf
bW9kZXJuX3Jlc2V0X3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+ID4gK3sKPiA+ICsJc3RydWN0
IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYgPSB0b192cF9kZXZpY2UodnEtPnZkZXYpOwo+ID4g
KwlzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2ID0gJnZwX2Rldi0+bWRldjsK
PiA+ICsJc3RydWN0IHZpcnRpb19wY2lfdnFfaW5mbyAqaW5mbzsKPiA+ICsJdW5zaWduZWQgbG9u
ZyBmbGFnczsKPiA+ICsJdW5zaWduZWQgaW50IGlycTsKPiA+ICsKPiA+ICsJaWYgKCF2aXJ0aW9f
aGFzX2ZlYXR1cmUodnEtPnZkZXYsIFZJUlRJT19GX1JJTkdfUkVTRVQpKQo+ID4gKwkJcmV0dXJu
IC1FTk9FTlQ7Cj4gPiArCj4gPiArCXZwX21vZGVybl9zZXRfcXVldWVfcmVzZXQobWRldiwgdnEt
PmluZGV4KTsKPiA+ICsKPiA+ICsJaW5mbyA9IHZwX2Rldi0+dnFzW3ZxLT5pbmRleF07Cj4gPiAr
Cj4gPiArCS8qIGRlbGV0ZSB2cSBmcm9tIGlycSBoYW5kbGVyICovCj4gPiArCXNwaW5fbG9ja19p
cnFzYXZlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiA+ICsJbGlzdF9kZWwoJmluZm8tPm5vZGUp
Owo+ID4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiA+
ICsKPiA+ICsJSU5JVF9MSVNUX0hFQUQoJmluZm8tPm5vZGUpOwo+ID4gKwo+ID4gKwl2cS0+cmVz
ZXQgPSBWSVJUSU9fVlFfUkVTRVRfU1RFUF9ERVZJQ0U7Cj4gPiArCj4gPiArCS8qIHN5bmMgaXJx
IGNhbGxiYWNrLiAqLwo+ID4gKwlpZiAodnBfZGV2LT5pbnR4X2VuYWJsZWQpIHsKPiA+ICsJCWly
cSA9IHZwX2Rldi0+cGNpX2Rldi0+aXJxOwo+ID4gKwo+ID4gKwl9IGVsc2Ugewo+ID4gKwkJaWYg
KGluZm8tPm1zaXhfdmVjdG9yID09IFZJUlRJT19NU0lfTk9fVkVDVE9SKQo+ID4gKwkJCXJldHVy
biAwOwo+ID4gKwo+ID4gKwkJaXJxID0gcGNpX2lycV92ZWN0b3IodnBfZGV2LT5wY2lfZGV2LCBp
bmZvLT5tc2l4X3ZlY3Rvcik7Cj4gPiArCX0KPiA+ICsKPiA+ICsJc3luY2hyb25pemVfaXJxKGly
cSk7Cj4KPgo+IFN5bmNocm9uaXplX2lycSgpIGlzIG5vdCBzdWZmaWNpZW50IGhlcmUgc2luY2Ug
aXQgYnJlYWtzIHRoZSBlZmZvcnQgb2YKPiB0aGUgaW50ZXJydXB0IGhhcmRlbmluZyB3aGljaCBp
cyBkb25lIGJ5IGNvbW1pdHM6Cj4KPiAwODBjZDdjM2FjODcgdmlydGlvLXBjaTogaGFyZGVuIElO
VFggaW50ZXJydXB0cwo+IDllMzUyNzZhNTM0NCB2aXJ0aW9fcGNpOiBoYXJkZW4gTVNJLVggaW50
ZXJydXB0cwo+Cj4gVW5mb3J0dW5hdGVsecKgIDA4MGNkN2MzYWM4NyBpbnRyb2R1Y2VzIGFuIGlz
c3VlIHRoYXQgZGlzYWJsZV9pcnEoKSB3ZXJlCj4gdXNlZCBmb3IgdGhlIGFmZmluaXR5IG1hbmFn
ZWQgaXJxIGJ1dCB3ZSdyZSBkaXNjdXNzaW5nIGEgZml4LgoKSSBuZWVkIHRvIHVuZGVyc3RhbmQg
aXQgZmlyc3QuCgo+Cj4KPiA+ICsKPiA+ICsJcmV0dXJuIDA7Cj4gPiArfQo+ID4gKwo+ID4gK3N0
YXRpYyBpbnQgdnBfbW9kZXJuX2VuYWJsZV9yZXNldF92cShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkK
PiA+ICt7Cj4gPiArCXN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2ID0gdG9fdnBfZGV2
aWNlKHZxLT52ZGV2KTsKPiA+ICsJc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRl
diA9ICZ2cF9kZXYtPm1kZXY7Cj4gPiArCXN0cnVjdCB2aXJ0aW9fcGNpX3ZxX2luZm8gKmluZm87
Cj4gPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3MsIGluZGV4Owo+ID4gKwlpbnQgZXJyOwo+ID4gKwo+
ID4gKwlpZiAodnEtPnJlc2V0ICE9IFZJUlRJT19WUV9SRVNFVF9TVEVQX1ZSSU5HX0FUVEFDSCkK
PiA+ICsJCXJldHVybiAtRUJVU1k7Cj4gPiArCj4gPiArCWluZGV4ID0gdnEtPmluZGV4Owo+ID4g
KwlpbmZvID0gdnBfZGV2LT52cXNbaW5kZXhdOwo+ID4gKwo+ID4gKwkvKiBjaGVjayBxdWV1ZSBy
ZXNldCBzdGF0dXMgKi8KPiA+ICsJaWYgKHZwX21vZGVybl9nZXRfcXVldWVfcmVzZXQobWRldiwg
aW5kZXgpICE9IDEpCj4gPiArCQlyZXR1cm4gLUVCVVNZOwo+ID4gKwo+ID4gKwllcnIgPSB2cF9h
Y3RpdmVfdnEodnEsIGluZm8tPm1zaXhfdmVjdG9yKTsKPiA+ICsJaWYgKGVycikKPiA+ICsJCXJl
dHVybiBlcnI7Cj4gPiArCj4gPiArCWlmICh2cS0+Y2FsbGJhY2spIHsKPiA+ICsJCXNwaW5fbG9j
a19pcnFzYXZlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiA+ICsJCWxpc3RfYWRkKCZpbmZvLT5u
b2RlLCAmdnBfZGV2LT52aXJ0cXVldWVzKTsKPiA+ICsJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JnZwX2Rldi0+bG9jaywgZmxhZ3MpOwo+ID4gKwl9IGVsc2Ugewo+ID4gKwkJSU5JVF9MSVNUX0hF
QUQoJmluZm8tPm5vZGUpOwo+ID4gKwl9Cj4gPiArCj4gPiArCXZwX21vZGVybl9zZXRfcXVldWVf
ZW5hYmxlKCZ2cF9kZXYtPm1kZXYsIGluZGV4LCB0cnVlKTsKPgo+Cj4gQW55IHJlYXNvbiB3ZSBu
ZWVkIHRvIGNoZWNrIHF1ZXVlX2VuYWJsZSgpIGhlcmU/CgpUaGUgcHVycG9zZSBvZiB0aGlzIGZ1
bmN0aW9uIGlzIHRvIGVuYWJsZSBhIHJlc2V0IHZxLCBzbyBjYWxsIHF1ZXVlX2VuYWJsZSgpIHRv
CmFjdGl2YXRlIGl0LgoKVGhhbmtzLgoKPgo+IFRoYW5rcwo+Cj4KPiA+ICsJdnEtPnJlc2V0ID0g
VklSVElPX1ZRX1JFU0VUX1NURVBfTk9ORTsKPiA+ICsKPiA+ICsJcmV0dXJuIDA7Cj4gPiArfQo+
ID4gKwo+ID4gICBzdGF0aWMgdTE2IHZwX2NvbmZpZ192ZWN0b3Ioc3RydWN0IHZpcnRpb19wY2lf
ZGV2aWNlICp2cF9kZXYsIHUxNiB2ZWN0b3IpCj4gPiAgIHsKPiA+ICAgCXJldHVybiB2cF9tb2Rl
cm5fY29uZmlnX3ZlY3RvcigmdnBfZGV2LT5tZGV2LCB2ZWN0b3IpOwo+ID4gQEAgLTQwNyw2ICs0
ODYsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZpcnRpb19jb25maWdfb3BzIHZpcnRpb19wY2lf
Y29uZmlnX25vZGV2X29wcyA9IHsKPiA+ICAgCS5zZXRfdnFfYWZmaW5pdHkgPSB2cF9zZXRfdnFf
YWZmaW5pdHksCj4gPiAgIAkuZ2V0X3ZxX2FmZmluaXR5ID0gdnBfZ2V0X3ZxX2FmZmluaXR5LAo+
ID4gICAJLmdldF9zaG1fcmVnaW9uICA9IHZwX2dldF9zaG1fcmVnaW9uLAo+ID4gKwkucmVzZXRf
dnEJID0gdnBfbW9kZXJuX3Jlc2V0X3ZxLAo+ID4gKwkuZW5hYmxlX3Jlc2V0X3ZxID0gdnBfbW9k
ZXJuX2VuYWJsZV9yZXNldF92cSwKPiA+ICAgfTsKPiA+Cj4gPiAgIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgdmlydGlvX2NvbmZpZ19vcHMgdmlydGlvX3BjaV9jb25maWdfb3BzID0gewo+ID4gQEAgLTQy
NSw2ICs1MDYsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZpcnRpb19jb25maWdfb3BzIHZpcnRp
b19wY2lfY29uZmlnX29wcyA9IHsKPiA+ICAgCS5zZXRfdnFfYWZmaW5pdHkgPSB2cF9zZXRfdnFf
YWZmaW5pdHksCj4gPiAgIAkuZ2V0X3ZxX2FmZmluaXR5ID0gdnBfZ2V0X3ZxX2FmZmluaXR5LAo+
ID4gICAJLmdldF9zaG1fcmVnaW9uICA9IHZwX2dldF9zaG1fcmVnaW9uLAo+ID4gKwkucmVzZXRf
dnEJID0gdnBfbW9kZXJuX3Jlc2V0X3ZxLAo+ID4gKwkuZW5hYmxlX3Jlc2V0X3ZxID0gdnBfbW9k
ZXJuX2VuYWJsZV9yZXNldF92cSwKPiA+ICAgfTsKPiA+Cj4gPiAgIC8qIHRoZSBQQ0kgcHJvYmlu
ZyBmdW5jdGlvbiAqLwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
