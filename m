Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C742C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 09:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CFCAE401C2;
	Wed,  9 Mar 2022 09:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IxmZ1SpcxrWI; Wed,  9 Mar 2022 09:20:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BED164002B;
	Wed,  9 Mar 2022 09:20:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C4AEC0012;
	Wed,  9 Mar 2022 09:20:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2F81C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83B0F417B7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:20:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IGte-sPz5gMC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:20:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DAFCD41684
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:20:52 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R231e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V6j5tde_1646817644; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6j5tde_1646817644) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Mar 2022 17:20:45 +0800
Message-ID: <1646817603.8985817-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 04/26] virtio_ring: split: extract the logic of
 creating vring
Date: Wed, 9 Mar 2022 17:20:03 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-5-xuanzhuo@linux.alibaba.com>
 <4b32d0b4-b794-cc1c-25f7-50b5ea6ac25e@redhat.com>
In-Reply-To: <4b32d0b4-b794-cc1c-25f7-50b5ea6ac25e@redhat.com>
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

QWdyZWUgZm9yIGFsbC4KClRoYW5rcy4KCk9uIFdlZCwgOSBNYXIgMjAyMiAxNDo0NjowMSArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi8z
Lzgg5LiL5Y2IODozNCwgWHVhbiBaaHVvIOWGmemBkzoKPiA+IFNlcGFyYXRlIHRoZSBsb2dpYyBv
ZiBzcGxpdCB0byBjcmVhdGUgdnJpbmcgcXVldWUuCj4gPgo+ID4gRm9yIHRoZSBjb252ZW5pZW5j
ZSBvZiBwYXNzaW5nIHBhcmFtZXRlcnMsIGFkZCBhIHN0cnVjdHVyZQo+ID4gdnJpbmdfc3BsaXQu
Cj4gPgo+ID4gVGhpcyBmZWF0dXJlIGlzIHJlcXVpcmVkIGZvciBzdWJzZXF1ZW50IHZpcnR1cXVl
dWUgcmVzZXQgdnJpbmcuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1
b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jIHwgNzQgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkKPiA+Cj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMKPiA+IGluZGV4IGI4NzEzMGM4ZjMxMi4uZDMyNzkzNjE1NDUxIDEwMDY0
NAo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gKysrIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gQEAgLTg1LDYgKzg1LDEzIEBAIHN0cnVjdCB2cmlu
Z19kZXNjX2V4dHJhIHsKPiA+ICAgCXUxNiBuZXh0OwkJCS8qIFRoZSBuZXh0IGRlc2Mgc3RhdGUg
aW4gYSBsaXN0LiAqLwo+ID4gICB9Owo+ID4KPiA+ICtzdHJ1Y3QgdnJpbmdfc3BsaXQgewo+ID4g
Kwl2b2lkICpxdWV1ZTsKPiA+ICsJZG1hX2FkZHJfdCBkbWFfYWRkcjsKPiA+ICsJc2l6ZV90IHF1
ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gPiArCXN0cnVjdCB2cmluZyB2cmluZzsKPiA+ICt9Owo+Cj4K
PiBTbyB0aGlzIHN0cnVjdHVyZSB3aWxsIGJlIG9ubHkgdXNlZCBpbiB2cmluZ19jcmVhdGVfdnJp
bmdfc3BsaXQoKSB3aGljaAo+IHNlZW1zIG5vdCB0aGF0IHVzZWZ1bC4KPgo+IE1vcmUgc2VlIGJl
bG93Lgo+Cj4KPiA+ICsKPiA+ICAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSB7Cj4gPiAgIAlzdHJ1
Y3QgdmlydHF1ZXVlIHZxOwo+ID4KPiA+IEBAIC05MTUsMjggKzkyMiwyMSBAQCBzdGF0aWMgdm9p
ZCAqdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92
cSkKPiA+ICAgCXJldHVybiBOVUxMOwo+ID4gICB9Cj4gPgo+ID4gLXN0YXRpYyBzdHJ1Y3Qgdmly
dHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ID4gLQl1bnNpZ25lZCBpbnQg
aW5kZXgsCj4gPiAtCXVuc2lnbmVkIGludCBudW0sCj4gPiAtCXVuc2lnbmVkIGludCB2cmluZ19h
bGlnbiwKPiA+IC0Jc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gPiAtCWJvb2wgd2Vha19i
YXJyaWVycywKPiA+IC0JYm9vbCBtYXlfcmVkdWNlX251bSwKPiA+IC0JYm9vbCBjb250ZXh0LAo+
ID4gLQlib29sICgqbm90aWZ5KShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4gLQl2b2lkICgqY2Fs
bGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPiAtCWNvbnN0IGNoYXIgKm5hbWUpCj4gPiAr
c3RhdGljIGludCB2cmluZ19jcmVhdGVfdnJpbmdfc3BsaXQoc3RydWN0IHZyaW5nX3NwbGl0ICp2
cmluZywKPiA+ICsJCQkJICAgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ID4gKwkJCQkg
ICAgdW5zaWduZWQgaW50IHZyaW5nX2FsaWduLAo+ID4gKwkJCQkgICAgYm9vbCB3ZWFrX2JhcnJp
ZXJzLAo+ID4gKwkJCQkgICAgYm9vbCBtYXlfcmVkdWNlX251bSwKPiA+ICsJCQkJICAgIHUzMiBu
dW0pCj4KPgo+IEknZCByZW5hbWUgdGhpcyBhcyB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCgpIGFu
ZCBsZXQgaXQgc2ltcGx5IHJldHVybgo+IHRoZSBhZGRyZXNzIG9mIHF1ZXVlIGxpa2UgdnJpbmdf
YWxsb2NfcXVldWUoKS4KPgo+IEFuZCBsZXQgaXQgc2ltcGxlIGFjY2VwdCBkbWFfYWRkcl90ICpk
bWFfYWRkZXIgaW5zdGVhZCBvZiB2cmluZ19zcGxpdC4KPgo+Cj4gPiAgIHsKPiA+IC0Jc3RydWN0
IHZpcnRxdWV1ZSAqdnE7Cj4gPiAgIAl2b2lkICpxdWV1ZSA9IE5VTEw7Cj4gPiAgIAlkbWFfYWRk
cl90IGRtYV9hZGRyOwo+ID4gICAJc2l6ZV90IHF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gPiAtCXN0
cnVjdCB2cmluZyB2cmluZzsKPiA+Cj4gPiAgIAkvKiBXZSBhc3N1bWUgbnVtIGlzIGEgcG93ZXIg
b2YgMi4gKi8KPiA+ICAgCWlmIChudW0gJiAobnVtIC0gMSkpIHsKPiA+ICAgCQlkZXZfd2Fybigm
dmRldi0+ZGV2LCAiQmFkIHZpcnRxdWV1ZSBsZW5ndGggJXVcbiIsIG51bSk7Cj4gPiAtCQlyZXR1
cm4gTlVMTDsKPiA+ICsJCXJldHVybiAtRUlOVkFMOwo+ID4gICAJfQo+ID4KPiA+ICAgCS8qIFRP
RE86IGFsbG9jYXRlIGVhY2ggcXVldWUgY2h1bmsgaW5kaXZpZHVhbGx5ICovCj4gPiBAQCAtOTQ3
LDExICs5NDcsMTEgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0
cXVldWVfc3BsaXQoCj4gPiAgIAkJaWYgKHF1ZXVlKQo+ID4gICAJCQlicmVhazsKPiA+ICAgCQlp
ZiAoIW1heV9yZWR1Y2VfbnVtKQo+ID4gLQkJCXJldHVybiBOVUxMOwo+ID4gKwkJCXJldHVybiAt
RU5PTUVNOwo+ID4gICAJfQo+ID4KPiA+ICAgCWlmICghbnVtKQo+ID4gLQkJcmV0dXJuIE5VTEw7
Cj4gPiArCQlyZXR1cm4gLUVOT01FTTsKPiA+Cj4gPiAgIAlpZiAoIXF1ZXVlKSB7Cj4gPiAgIAkJ
LyogVHJ5IHRvIGdldCBhIHNpbmdsZSBwYWdlLiBZb3UgYXJlIG15IG9ubHkgaG9wZSEgKi8KPiA+
IEBAIC05NTksMjEgKzk1OSw0OSBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3Jl
YXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+ICAgCQkJCQkgICZkbWFfYWRkciwgR0ZQX0tFUk5FTHxf
X0dGUF9aRVJPKTsKPiA+ICAgCX0KPiA+ICAgCWlmICghcXVldWUpCj4gPiAtCQlyZXR1cm4gTlVM
TDsKPiA+ICsJCXJldHVybiAtRU5PTUVNOwo+ID4KPiA+ICAgCXF1ZXVlX3NpemVfaW5fYnl0ZXMg
PSB2cmluZ19zaXplKG51bSwgdnJpbmdfYWxpZ24pOwo+ID4gLQl2cmluZ19pbml0KCZ2cmluZywg
bnVtLCBxdWV1ZSwgdnJpbmdfYWxpZ24pOwo+ID4gKwl2cmluZ19pbml0KCZ2cmluZy0+dnJpbmcs
IG51bSwgcXVldWUsIHZyaW5nX2FsaWduKTsKPgo+Cj4gSXQncyBiZXR0ZXIgdG8gbW92ZSB0aGlz
IHRvIGl0cyBjYWxsZXIgKHZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQpLAo+IHNvIHdlIGhh
dmUgcmF0aGVyIHNpbXBsZSBsb2dpYyBiZWxvdzoKPgo+Cj4KPiA+ICsKPiA+ICsJdnJpbmctPmRt
YV9hZGRyID0gZG1hX2FkZHI7Cj4gPiArCXZyaW5nLT5xdWV1ZSA9IHF1ZXVlOwo+ID4gKwl2cmlu
Zy0+cXVldWVfc2l6ZV9pbl9ieXRlcyA9IHF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gPiArCj4gPiAr
CXJldHVybiAwOwo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJp
bmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+ICsJdW5zaWduZWQgaW50IGluZGV4LAo+ID4g
Kwl1bnNpZ25lZCBpbnQgbnVtLAo+ID4gKwl1bnNpZ25lZCBpbnQgdnJpbmdfYWxpZ24sCj4gPiAr
CXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ID4gKwlib29sIHdlYWtfYmFycmllcnMsCj4g
PiArCWJvb2wgbWF5X3JlZHVjZV9udW0sCj4gPiArCWJvb2wgY29udGV4dCwKPiA+ICsJYm9vbCAo
Km5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+ICsJdm9pZCAoKmNhbGxiYWNrKShzdHJ1
Y3QgdmlydHF1ZXVlICopLAo+ID4gKwljb25zdCBjaGFyICpuYW1lKQo+ID4gK3sKPiA+ICsJc3Ry
dWN0IHZyaW5nX3NwbGl0IHZyaW5nOwo+ID4gKwlzdHJ1Y3QgdmlydHF1ZXVlICp2cTsKPiA+ICsJ
aW50IGVycjsKPiA+ICsKPiA+ICsJZXJyID0gdnJpbmdfY3JlYXRlX3ZyaW5nX3NwbGl0KCZ2cmlu
ZywgdmRldiwgdnJpbmdfYWxpZ24sIHdlYWtfYmFycmllcnMsCj4gPiArCQkJCSAgICAgICBtYXlf
cmVkdWNlX251bSwgbnVtKTsKPiA+ICsJaWYgKGVycikKPiA+ICsJCXJldHVybiBOVUxMOwo+Cj4K
PiBxdWV1ZSA9IHZyaW5nX2FsbG9jX3F1ZXVlX3NwbGl0KHZkZXYsICZkbWFfYWRkciwgLi4uKTsK
Pgo+IGlmICghcXVldWUpCj4KPiAgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+Cj4gdnJpbmdfaW5p
dCgpOwo+Cj4gLi4uCj4KPiBUaGFua3MKPgo+Cj4gPgo+ID4gLQl2cSA9IF9fdnJpbmdfbmV3X3Zp
cnRxdWV1ZShpbmRleCwgdnJpbmcsIHZkZXYsIHdlYWtfYmFycmllcnMsIGNvbnRleHQsCj4gPiAr
CXZxID0gX192cmluZ19uZXdfdmlydHF1ZXVlKGluZGV4LCB2cmluZy52cmluZywgdmRldiwgd2Vh
a19iYXJyaWVycywgY29udGV4dCwKPiA+ICAgCQkJCSAgIG5vdGlmeSwgY2FsbGJhY2ssIG5hbWUp
Owo+ID4gICAJaWYgKCF2cSkgewo+ID4gLQkJdnJpbmdfZnJlZV9xdWV1ZSh2ZGV2LCBxdWV1ZV9z
aXplX2luX2J5dGVzLCBxdWV1ZSwKPiA+IC0JCQkJIGRtYV9hZGRyKTsKPiA+ICsJCXZyaW5nX2Zy
ZWVfcXVldWUodmRldiwgdnJpbmcucXVldWVfc2l6ZV9pbl9ieXRlcywgdnJpbmcucXVldWUsCj4g
PiArCQkJCSB2cmluZy5kbWFfYWRkcik7Cj4gPiAgIAkJcmV0dXJuIE5VTEw7Cj4gPiAgIAl9Cj4g
Pgo+ID4gLQl0b192dnEodnEpLT5zcGxpdC5xdWV1ZV9kbWFfYWRkciA9IGRtYV9hZGRyOwo+ID4g
LQl0b192dnEodnEpLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzID0gcXVldWVfc2l6ZV9pbl9i
eXRlczsKPiA+ICsJdG9fdnZxKHZxKS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSB2cmluZy5kbWFf
YWRkcjsKPiA+ICsJdG9fdnZxKHZxKS0+c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9IHZyaW5n
LnF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gPiAgIAl0b192dnEodnEpLT53ZV9vd25fcmluZyA9IHRy
dWU7Cj4gPgo+ID4gICAJcmV0dXJuIHZxOwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
