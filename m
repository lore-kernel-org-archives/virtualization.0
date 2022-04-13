Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B1EC433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 07:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EDD780BEC;
	Wed, 13 Apr 2022 07:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IEImASFRb-SW; Wed, 13 Apr 2022 07:05:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4635180BED;
	Wed, 13 Apr 2022 07:05:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A764C0033;
	Wed, 13 Apr 2022 07:05:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDA12C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 07:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A662E60E50
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 07:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7DSt0kZySZOC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 07:04:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com
 [47.90.199.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5451360E41
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 07:04:57 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R391e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V9yF4q8_1649833489; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V9yF4q8_1649833489) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 13 Apr 2022 15:04:50 +0800
Message-ID: <1649833450.9482608-9-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v9 09/32] virtio_ring: split: extract the logic of vq init
Date: Wed, 13 Apr 2022 15:04:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-10-xuanzhuo@linux.alibaba.com>
 <f91435e4-6559-c0c9-2b37-92084c88dee2@redhat.com>
In-Reply-To: <f91435e4-6559-c0c9-2b37-92084c88dee2@redhat.com>
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

T24gVHVlLCAxMiBBcHIgMjAyMiAxMTo0MjoyNSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi80LzYg5LiK5Y2IMTE6NDMsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBTZXBhcmF0ZSB0aGUgbG9naWMgb2YgaW5pdGlhbGl6aW5nIHZxLCBhbmQg
c3Vic2VxdWVudCBwYXRjaGVzIHdpbGwgY2FsbAo+ID4gaXQgc2VwYXJhdGVseS4KPiA+Cj4gPiBU
aGUgZmVhdHVyZSBvZiB0aGlzIHBhcnQgaXMgdGhhdCBpdCBkb2VzIG5vdCBkZXBlbmQgb24gdGhl
IGluZm9ybWF0aW9uCj4gPiBwYXNzZWQgYnkgdGhlIHVwcGVyIGxheWVyIGFuZCBjYW4gYmUgY2Fs
bGVkIHJlcGVhdGVkbHkuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1
b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jIHwgNjggKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkKPiA+Cj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMKPiA+IGluZGV4IDA4M2YyOTkyYmEwZC4uODc0Zjg3ODA4N2EzIDEwMDY0
NAo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gKysrIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gQEAgLTkxNiw2ICs5MTYsNDMgQEAgc3RhdGljIHZv
aWQgKnZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1Zl9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpf
dnEpCj4gPiAgIAlyZXR1cm4gTlVMTDsKPiA+ICAgfQo+ID4KPiA+ICtzdGF0aWMgdm9pZCB2cmlu
Z192aXJ0cXVldWVfaW5pdF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiA+ICsJ
CQkJICAgICAgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ID4gKwkJCQkgICAgICAgYm9v
bCBvd25fcmluZykKPiA+ICt7Cj4gPiArCXZxLT5wYWNrZWRfcmluZyA9IGZhbHNlOwo+ID4gKwl2
cS0+dnEubnVtX2ZyZWUgPSB2cS0+c3BsaXQudnJpbmcubnVtOwo+ID4gKwl2cS0+d2Vfb3duX3Jp
bmcgPSBvd25fcmluZzsKPiA+ICsJdnEtPmJyb2tlbiA9IGZhbHNlOwo+ID4gKwl2cS0+bGFzdF91
c2VkX2lkeCA9IDA7Cj4gPiArCXZxLT5ldmVudF90cmlnZ2VyZWQgPSBmYWxzZTsKPiA+ICsJdnEt
Pm51bV9hZGRlZCA9IDA7Cj4gPiArCXZxLT51c2VfZG1hX2FwaSA9IHZyaW5nX3VzZV9kbWFfYXBp
KHZkZXYpOwo+ID4gKyNpZmRlZiBERUJVRwo+ID4gKwl2cS0+aW5fdXNlID0gZmFsc2U7Cj4gPiAr
CXZxLT5sYXN0X2FkZF90aW1lX3ZhbGlkID0gZmFsc2U7Cj4gPiArI2VuZGlmCj4gPiArCj4gPiAr
CXZxLT5ldmVudCA9IHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fUklOR19GX0VWRU5U
X0lEWCk7Cj4gPiArCj4gPiArCWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX0Zf
T1JERVJfUExBVEZPUk0pKQo+ID4gKwkJdnEtPndlYWtfYmFycmllcnMgPSBmYWxzZTsKPiA+ICsK
PiA+ICsJdnEtPnNwbGl0LmF2YWlsX2ZsYWdzX3NoYWRvdyA9IDA7Cj4gPiArCXZxLT5zcGxpdC5h
dmFpbF9pZHhfc2hhZG93ID0gMDsKPiA+ICsKPiA+ICsJLyogTm8gY2FsbGJhY2s/ICBUZWxsIG90
aGVyIHNpZGUgbm90IHRvIGJvdGhlciB1cy4gKi8KPiA+ICsJaWYgKCF2cS0+dnEuY2FsbGJhY2sp
IHsKPiA+ICsJCXZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cgfD0gVlJJTkdfQVZBSUxfRl9O
T19JTlRFUlJVUFQ7Cj4gPiArCQlpZiAoIXZxLT5ldmVudCkKPiA+ICsJCQl2cS0+c3BsaXQudnJp
bmcuYXZhaWwtPmZsYWdzID0gY3B1X3RvX3ZpcnRpbzE2KHZkZXYsCj4gPiArCQkJCQl2cS0+c3Bs
aXQuYXZhaWxfZmxhZ3Nfc2hhZG93KTsKPiA+ICsJfQo+ID4gKwo+ID4gKwkvKiBQdXQgZXZlcnl0
aGluZyBpbiBmcmVlIGxpc3RzLiAqLwo+ID4gKwl2cS0+ZnJlZV9oZWFkID0gMDsKPgo+Cj4gSXQn
cyBub3QgY2xlYXIgd2hhdCBraW5kIG9mIGluaXRpYWxpemF0aW9uIHRoYXQgd2Ugd2FudCB0byBk
byBoZXJlLiBFLmcKPiBpdCBtaXhlcyBzcGxpdCBzcGVjaWZpYyBzZXR1cHMgd2l0aCBzb21lIGdl
bmVyYWwgc2V0dXBzIHdoaWNoIGlzIGtpbmQgb2YKPiBkdXBsaWNhdGlvbiBvZiB2cmluZ192aXJ0
cXVldWVfaW5pdF9wYWNrZWQoKS4KPgo+IEkgd29uZGVyIGlmIGl0J3MgYmV0dGVyIHRvIG9ubHkg
ZG8gc3BsaXQgc3BlY2lmaWMgc2V0dXBzIGhlcmUgYW5kIGhhdmUgYQo+IGNvbW1vbiBoZWxwZXIg
dG8gZG8gdGhlIHNldHVwIHRoYXQgaXMgaXJyZWxldmFudCB0byByaW5nIGxheW91dC4KClllcywg
eW91IGFyZSByaWdodCwgSSBkaWRuJ3Qgbm90aWNlIHRoaXMgc2l0dWF0aW9uIGJlZm9yZS4KClRo
YW5rcy4KCj4KPiBUaGFua3MKPgo+Cj4gPiArfQo+ID4gKwo+ID4gICBzdGF0aWMgdm9pZCB2cmlu
Z192aXJ0cXVldWVfYXR0YWNoX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ID4g
ICAJCQkJCSBzdHJ1Y3QgdnJpbmcgdnJpbmcsCj4gPiAgIAkJCQkJIHN0cnVjdCB2cmluZ19kZXNj
X3N0YXRlX3NwbGl0ICpkZXNjX3N0YXRlLAo+ID4gQEAgLTIyNDksNDIgKzIyODYsMTUgQEAgc3Ry
dWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwK
PiA+ICAgCWlmICghdnEpCj4gPiAgIAkJcmV0dXJuIE5VTEw7Cj4gPgo+ID4gLQl2cS0+cGFja2Vk
X3JpbmcgPSBmYWxzZTsKPiA+ICAgCXZxLT52cS5jYWxsYmFjayA9IGNhbGxiYWNrOwo+ID4gICAJ
dnEtPnZxLnZkZXYgPSB2ZGV2Owo+ID4gICAJdnEtPnZxLm5hbWUgPSBuYW1lOwo+ID4gLQl2cS0+
dnEubnVtX2ZyZWUgPSB2cmluZy5udW07Cj4gPiAgIAl2cS0+dnEuaW5kZXggPSBpbmRleDsKPiA+
IC0JdnEtPndlX293bl9yaW5nID0gZmFsc2U7Cj4gPiAgIAl2cS0+bm90aWZ5ID0gbm90aWZ5Owo+
ID4gICAJdnEtPndlYWtfYmFycmllcnMgPSB3ZWFrX2JhcnJpZXJzOwo+ID4gLQl2cS0+YnJva2Vu
ID0gZmFsc2U7Cj4gPiAtCXZxLT5sYXN0X3VzZWRfaWR4ID0gMDsKPiA+IC0JdnEtPmV2ZW50X3Ry
aWdnZXJlZCA9IGZhbHNlOwo+ID4gLQl2cS0+bnVtX2FkZGVkID0gMDsKPiA+IC0JdnEtPnVzZV9k
bWFfYXBpID0gdnJpbmdfdXNlX2RtYV9hcGkodmRldik7Cj4gPiAtI2lmZGVmIERFQlVHCj4gPiAt
CXZxLT5pbl91c2UgPSBmYWxzZTsKPiA+IC0JdnEtPmxhc3RfYWRkX3RpbWVfdmFsaWQgPSBmYWxz
ZTsKPiA+IC0jZW5kaWYKPiA+Cj4gPiAgIAl2cS0+aW5kaXJlY3QgPSB2aXJ0aW9faGFzX2ZlYXR1
cmUodmRldiwgVklSVElPX1JJTkdfRl9JTkRJUkVDVF9ERVNDKSAmJgo+ID4gICAJCSFjb250ZXh0
Owo+ID4gLQl2cS0+ZXZlbnQgPSB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX1JJTkdf
Rl9FVkVOVF9JRFgpOwo+ID4gLQo+ID4gLQlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJ
UlRJT19GX09SREVSX1BMQVRGT1JNKSkKPiA+IC0JCXZxLT53ZWFrX2JhcnJpZXJzID0gZmFsc2U7
Cj4gPiAtCj4gPiAtCXZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cgPSAwOwo+ID4gLQl2cS0+
c3BsaXQuYXZhaWxfaWR4X3NoYWRvdyA9IDA7Cj4gPiAtCj4gPiAtCS8qIE5vIGNhbGxiYWNrPyAg
VGVsbCBvdGhlciBzaWRlIG5vdCB0byBib3RoZXIgdXMuICovCj4gPiAtCWlmICghY2FsbGJhY2sp
IHsKPiA+IC0JCXZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cgfD0gVlJJTkdfQVZBSUxfRl9O
T19JTlRFUlJVUFQ7Cj4gPiAtCQlpZiAoIXZxLT5ldmVudCkKPiA+IC0JCQl2cS0+c3BsaXQudnJp
bmcuYXZhaWwtPmZsYWdzID0gY3B1X3RvX3ZpcnRpbzE2KHZkZXYsCj4gPiAtCQkJCQl2cS0+c3Bs
aXQuYXZhaWxfZmxhZ3Nfc2hhZG93KTsKPiA+IC0JfQo+ID4KPiA+ICAgCWVyciA9IHZyaW5nX2Fs
bG9jX3N0YXRlX2V4dHJhX3NwbGl0KHZyaW5nLm51bSwgJnN0YXRlLCAmZXh0cmEpOwo+ID4gICAJ
aWYgKGVycikgewo+ID4gQEAgLTIyOTMsOSArMjMwMyw3IEBAIHN0cnVjdCB2aXJ0cXVldWUgKl9f
dnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiAgIAl9Cj4gPgo+ID4g
ICAJdnJpbmdfdmlydHF1ZXVlX2F0dGFjaF9zcGxpdCh2cSwgdnJpbmcsIHN0YXRlLCBleHRyYSk7
Cj4gPiAtCj4gPiAtCS8qIFB1dCBldmVyeXRoaW5nIGluIGZyZWUgbGlzdHMuICovCj4gPiAtCXZx
LT5mcmVlX2hlYWQgPSAwOwo+ID4gKwl2cmluZ192aXJ0cXVldWVfaW5pdF9zcGxpdCh2cSwgdmRl
diwgZmFsc2UpOwo+ID4KPiA+ICAgCXNwaW5fbG9jaygmdmRldi0+dnFzX2xpc3RfbG9jayk7Cj4g
PiAgIAlsaXN0X2FkZF90YWlsKCZ2cS0+dnEubGlzdCwgJnZkZXYtPnZxcyk7Cj4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
