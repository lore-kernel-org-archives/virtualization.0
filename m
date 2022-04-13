Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5B3C43219
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 03:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 494AB40150;
	Wed, 13 Apr 2022 03:26:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BYLC7s10CAOi; Wed, 13 Apr 2022 03:26:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BE0D840127;
	Wed, 13 Apr 2022 03:26:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A165BC002F;
	Wed, 13 Apr 2022 03:26:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 031DBC002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 03:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC01B417BB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 03:26:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J_mTvfsfMVg4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 03:26:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E38D417BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 03:26:37 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V9xXClK_1649820390; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V9xXClK_1649820390) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 13 Apr 2022 11:26:32 +0800
Message-ID: <1649820210.3432868-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v9 12/32] virtio_ring: packed: extract the logic of alloc
 queue
Date: Wed, 13 Apr 2022 11:23:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-13-xuanzhuo@linux.alibaba.com>
 <4da7b8dc-74ca-fc1b-fbdb-21f9943e8d45@redhat.com>
In-Reply-To: <4da7b8dc-74ca-fc1b-fbdb-21f9943e8d45@redhat.com>
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

T24gVHVlLCAxMiBBcHIgMjAyMiAxNDoyODoyNCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi80LzYg5LiK5Y2IMTE6NDMsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBTZXBhcmF0ZSB0aGUgbG9naWMgb2YgcGFja2VkIHRvIGNyZWF0ZSB2cmlu
ZyBxdWV1ZS4KPiA+Cj4gPiBGb3IgdGhlIGNvbnZlbmllbmNlIG9mIHBhc3NpbmcgcGFyYW1ldGVy
cywgYWRkIGEgc3RydWN0dXJlCj4gPiB2cmluZ19wYWNrZWQuCj4gPgo+ID4gVGhpcyBmZWF0dXJl
IGlzIHJlcXVpcmVkIGZvciBzdWJzZXF1ZW50IHZpcnR1cXVldWUgcmVzZXQgdnJpbmcuCj4gPgo+
ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4K
PiA+IC0tLQo+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNzAgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA1NiBpbnNl
cnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IGlu
ZGV4IDMzODY0MTM0YTc0NC4uZWE0NTFhZTJhYWVmIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ID4gQEAgLTE4MTcsMTkgKzE4MTcsMTcgQEAgc3RhdGljIHN0cnVjdCB2cmluZ19kZXNjX2V4
dHJhICp2cmluZ19hbGxvY19kZXNjX2V4dHJhKHVuc2lnbmVkIGludCBudW0pCj4gPiAgIAlyZXR1
cm4gZGVzY19leHRyYTsKPiA+ICAgfQo+ID4KPiA+IC1zdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAq
dnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9wYWNrZWQoCj4gPiAtCXVuc2lnbmVkIGludCBpbmRleCwK
PiA+IC0JdW5zaWduZWQgaW50IG51bSwKPiA+IC0JdW5zaWduZWQgaW50IHZyaW5nX2FsaWduLAo+
ID4gLQlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPiA+IC0JYm9vbCB3ZWFrX2JhcnJpZXJz
LAo+ID4gLQlib29sIG1heV9yZWR1Y2VfbnVtLAo+ID4gLQlib29sIGNvbnRleHQsCj4gPiAtCWJv
b2wgKCpub3RpZnkpKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPiAtCXZvaWQgKCpjYWxsYmFjayko
c3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+IC0JY29uc3QgY2hhciAqbmFtZSkKPiA+ICtzdGF0aWMg
aW50IHZyaW5nX2FsbG9jX3F1ZXVlX3BhY2tlZChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwK
PiA+ICsJCQkJICAgIHUzMiBudW0sCj4gPiArCQkJCSAgICBzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rl
c2MgKipfcmluZywKPiA+ICsJCQkJICAgIHN0cnVjdCB2cmluZ19wYWNrZWRfZGVzY19ldmVudCAq
Kl9kcml2ZXIsCj4gPiArCQkJCSAgICBzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rlc2NfZXZlbnQgKipf
ZGV2aWNlLAo+ID4gKwkJCQkgICAgZG1hX2FkZHJfdCAqX3JpbmdfZG1hX2FkZHIsCj4gPiArCQkJ
CSAgICBkbWFfYWRkcl90ICpfZHJpdmVyX2V2ZW50X2RtYV9hZGRyLAo+ID4gKwkJCQkgICAgZG1h
X2FkZHJfdCAqX2RldmljZV9ldmVudF9kbWFfYWRkciwKPiA+ICsJCQkJICAgIHNpemVfdCAqX3Jp
bmdfc2l6ZV9pbl9ieXRlcywKPiA+ICsJCQkJICAgIHNpemVfdCAqX2V2ZW50X3NpemVfaW5fYnl0
ZXMpCj4gPiAgIHsKPiA+IC0Jc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnE7Cj4gPiAgIAlzdHJ1
Y3QgdnJpbmdfcGFja2VkX2Rlc2MgKnJpbmc7Cj4gPiAgIAlzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rl
c2NfZXZlbnQgKmRyaXZlciwgKmRldmljZTsKPiA+ICAgCWRtYV9hZGRyX3QgcmluZ19kbWFfYWRk
ciwgZHJpdmVyX2V2ZW50X2RtYV9hZGRyLCBkZXZpY2VfZXZlbnRfZG1hX2FkZHI7Cj4gPiBAQCAt
MTg1Nyw2ICsxODU1LDUyIEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVf
dmlydHF1ZXVlX3BhY2tlZCgKPiA+ICAgCWlmICghZGV2aWNlKQo+ID4gICAJCWdvdG8gZXJyX2Rl
dmljZTsKPiA+Cj4gPiArCSpfcmluZyAgICAgICAgICAgICAgICAgICA9IHJpbmc7Cj4gPiArCSpf
ZHJpdmVyICAgICAgICAgICAgICAgICA9IGRyaXZlcjsKPiA+ICsJKl9kZXZpY2UgICAgICAgICAg
ICAgICAgID0gZGV2aWNlOwo+ID4gKwkqX3JpbmdfZG1hX2FkZHIgICAgICAgICAgPSByaW5nX2Rt
YV9hZGRyOwo+ID4gKwkqX2RyaXZlcl9ldmVudF9kbWFfYWRkciAgPSBkcml2ZXJfZXZlbnRfZG1h
X2FkZHI7Cj4gPiArCSpfZGV2aWNlX2V2ZW50X2RtYV9hZGRyICA9IGRldmljZV9ldmVudF9kbWFf
YWRkcjsKPiA+ICsJKl9yaW5nX3NpemVfaW5fYnl0ZXMgICAgID0gcmluZ19zaXplX2luX2J5dGVz
Owo+ID4gKwkqX2V2ZW50X3NpemVfaW5fYnl0ZXMgICAgPSBldmVudF9zaXplX2luX2J5dGVzOwo+
Cj4KPiBJIHdvbmRlciBpZiB3ZSBjYW4gc2ltcGx5IGZhY3RvciBvdXQgc3BsaXQgYW5kIHBhY2tl
ZCBmcm9tIHN0cnVjdAo+IHZyaW5nX3ZpcnRxdWV1ZToKPgo+IHN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgewo+ICDCoMKgwqAgdW5pb24gewo+ICDCoMKgwqAgwqDCoMKgIHN0cnVjdCB7fSBzcGxpdDsK
PiAgwqDCoMKgIMKgwqDCoCBzdHJ1Y3Qge30gcGFja2VkOwo+ICDCoMKgwqAgfTsKPiB9Owo+Cj4g
dG8KPgo+IHN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQge307Cj4gc3RydWN0IHZyaW5nX3Zp
cnRxdWV1ZV9wYWNrZWQge307Cj4KPiBUaGVuIHdlIGNhbiBkbyB0aGluZ3MgbGlrZToKPgo+IHZy
aW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1
MzIgbnVtLAo+IHN0cnVjdCB2cmluZ192aXJ0cXVldWVfcGFja2VkICpwYWNrZWQpOwo+Cj4gYW5k
Cj4KPiB2cmluZ192cml0cXVldWVfYXR0YWNoX3BhY2tlZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVl
ICp2cSwgc3RydWN0Cj4gdnJpbmdfdmlydHF1ZXVlX3BhY2tlZCBwYWNrZWQpOwoKVGhpcyBpZGVh
IGlzIHZlcnkgc2ltaWxhciB0byBteSBwcmV2aW91cyBpZGVhLCBqdXN0IHdpdGhvdXQgaW50cm9k
dWNpbmcgYSBuZXcKc3RydWN0dXJlLgoKSSdkIGJlIG1vcmUgdGhhbiBoYXBweSB0byByZXZpc2Ug
dGhpcy4KClRoYW5rcy4KCgo+Cj4gVGhhbmtzCj4KPgo+ID4gKwo+ID4gKwlyZXR1cm4gMDsKPiA+
ICsKPiA+ICtlcnJfZGV2aWNlOgo+ID4gKwl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIGV2ZW50X3Np
emVfaW5fYnl0ZXMsIGRyaXZlciwgZHJpdmVyX2V2ZW50X2RtYV9hZGRyKTsKPiA+ICsKPiA+ICtl
cnJfZHJpdmVyOgo+ID4gKwl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIHJpbmdfc2l6ZV9pbl9ieXRl
cywgcmluZywgcmluZ19kbWFfYWRkcik7Cj4gPiArCj4gPiArZXJyX3Jpbmc6Cj4gPiArCXJldHVy
biAtRU5PTUVNOwo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJp
bmdfY3JlYXRlX3ZpcnRxdWV1ZV9wYWNrZWQoCj4gPiArCXVuc2lnbmVkIGludCBpbmRleCwKPiA+
ICsJdW5zaWduZWQgaW50IG51bSwKPiA+ICsJdW5zaWduZWQgaW50IHZyaW5nX2FsaWduLAo+ID4g
KwlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPiA+ICsJYm9vbCB3ZWFrX2JhcnJpZXJzLAo+
ID4gKwlib29sIG1heV9yZWR1Y2VfbnVtLAo+ID4gKwlib29sIGNvbnRleHQsCj4gPiArCWJvb2wg
KCpub3RpZnkpKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPiArCXZvaWQgKCpjYWxsYmFjaykoc3Ry
dWN0IHZpcnRxdWV1ZSAqKSwKPiA+ICsJY29uc3QgY2hhciAqbmFtZSkKPiA+ICt7Cj4gPiArCWRt
YV9hZGRyX3QgcmluZ19kbWFfYWRkciwgZHJpdmVyX2V2ZW50X2RtYV9hZGRyLCBkZXZpY2VfZXZl
bnRfZG1hX2FkZHI7Cj4gPiArCXN0cnVjdCB2cmluZ19wYWNrZWRfZGVzY19ldmVudCAqZHJpdmVy
LCAqZGV2aWNlOwo+ID4gKwlzaXplX3QgcmluZ19zaXplX2luX2J5dGVzLCBldmVudF9zaXplX2lu
X2J5dGVzOwo+ID4gKwlzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rlc2MgKnJpbmc7Cj4gPiArCXN0cnVj
dCB2cmluZ192aXJ0cXVldWUgKnZxOwo+ID4gKwo+ID4gKwlpZiAodnJpbmdfYWxsb2NfcXVldWVf
cGFja2VkKHZkZXYsIG51bSwgJnJpbmcsICZkcml2ZXIsICZkZXZpY2UsCj4gPiArCQkJCSAgICAg
JnJpbmdfZG1hX2FkZHIsICZkcml2ZXJfZXZlbnRfZG1hX2FkZHIsCj4gPiArCQkJCSAgICAgJmRl
dmljZV9ldmVudF9kbWFfYWRkciwKPiA+ICsJCQkJICAgICAmcmluZ19zaXplX2luX2J5dGVzLAo+
ID4gKwkJCQkgICAgICZldmVudF9zaXplX2luX2J5dGVzKSkKPiA+ICsJCWdvdG8gZXJyX3Jpbmc7
Cj4gPiArCj4gPiAgIAl2cSA9IGttYWxsb2Moc2l6ZW9mKCp2cSksIEdGUF9LRVJORUwpOwo+ID4g
ICAJaWYgKCF2cSkKPiA+ICAgCQlnb3RvIGVycl92cTsKPiA+IEBAIC0xOTM5LDkgKzE5ODMsNyBA
QCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9wYWNrZWQo
Cj4gPiAgIAlrZnJlZSh2cSk7Cj4gPiAgIGVycl92cToKPiA+ICAgCXZyaW5nX2ZyZWVfcXVldWUo
dmRldiwgZXZlbnRfc2l6ZV9pbl9ieXRlcywgZGV2aWNlLCBkZXZpY2VfZXZlbnRfZG1hX2FkZHIp
Owo+ID4gLWVycl9kZXZpY2U6Cj4gPiAgIAl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIGV2ZW50X3Np
emVfaW5fYnl0ZXMsIGRyaXZlciwgZHJpdmVyX2V2ZW50X2RtYV9hZGRyKTsKPiA+IC1lcnJfZHJp
dmVyOgo+ID4gICAJdnJpbmdfZnJlZV9xdWV1ZSh2ZGV2LCByaW5nX3NpemVfaW5fYnl0ZXMsIHJp
bmcsIHJpbmdfZG1hX2FkZHIpOwo+ID4gICBlcnJfcmluZzoKPiA+ICAgCXJldHVybiBOVUxMOwo+
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
