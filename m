Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EB0C433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 06:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3138A409EE;
	Wed, 13 Apr 2022 06:53:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hyxswEOvF1G6; Wed, 13 Apr 2022 06:53:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C930E404C5;
	Wed, 13 Apr 2022 06:53:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94C38C0033;
	Wed, 13 Apr 2022 06:53:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5163DC002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30664812E4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:53:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RV98JPBMVi2i
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:53:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B245F8291C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:53:30 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V9yAtwn_1649832804; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V9yAtwn_1649832804) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 13 Apr 2022 14:53:25 +0800
Message-ID: <1649832776.947242-8-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v9 06/32] virtio_ring: split: extract the logic of alloc
 queue
Date: Wed, 13 Apr 2022 14:52:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-7-xuanzhuo@linux.alibaba.com>
 <b435b86d-26af-2e39-8859-6746830769d5@redhat.com>
In-Reply-To: <b435b86d-26af-2e39-8859-6746830769d5@redhat.com>
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

T24gVHVlLCAxMiBBcHIgMjAyMiAxMToyMjozMyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi80LzYg5LiK5Y2IMTE6NDMsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBTZXBhcmF0ZSB0aGUgbG9naWMgb2Ygc3BsaXQgdG8gY3JlYXRlIHZyaW5n
IHF1ZXVlLgo+ID4KPiA+IFRoaXMgZmVhdHVyZSBpcyByZXF1aXJlZCBmb3Igc3Vic2VxdWVudCB2
aXJ0dXF1ZXVlIHJlc2V0IHZyaW5nLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8
eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYyB8IDUzICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCj4g
Pgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBpbmRleCAzM2ZkZGZiOTA3YTYuLjcyZDVhZTA2M2Zh
MCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IEBAIC05MTUsMjMgKzkxNSwxNSBAQCBz
dGF0aWMgdm9pZCAqdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmX3NwbGl0KHN0cnVjdCB2aXJ0
cXVldWUgKl92cSkKPiA+ICAgCXJldHVybiBOVUxMOwo+ID4gICB9Cj4gPgo+ID4gLXN0YXRpYyBz
dHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ID4gLQl1bnNp
Z25lZCBpbnQgaW5kZXgsCj4gPiAtCXVuc2lnbmVkIGludCBudW0sCj4gPiAtCXVuc2lnbmVkIGlu
dCB2cmluZ19hbGlnbiwKPiA+IC0Jc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gPiAtCWJv
b2wgd2Vha19iYXJyaWVycywKPiA+IC0JYm9vbCBtYXlfcmVkdWNlX251bSwKPiA+IC0JYm9vbCBj
b250ZXh0LAo+ID4gLQlib29sICgqbm90aWZ5KShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4gLQl2
b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPiAtCWNvbnN0IGNoYXIgKm5h
bWUpCj4gPiArc3RhdGljIHZvaWQgKnZyaW5nX2FsbG9jX3F1ZXVlX3NwbGl0KHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2LAo+ID4gKwkJCQkgICAgIGRtYV9hZGRyX3QgKmRtYV9hZGRyLAo+ID4g
KwkJCQkgICAgIHUzMiAqbiwKPiA+ICsJCQkJICAgICB1bnNpZ25lZCBpbnQgdnJpbmdfYWxpZ24s
Cj4gPiArCQkJCSAgICAgYm9vbCB3ZWFrX2JhcnJpZXJzLAo+Cj4KPiBUaGlzIGlzIG5vdCB1c2Vk
IGluIHRoaXMgZnVuY3Rpb24uCgpUaGUgbmV4dCB2ZXJzaW9uIHdpbGwgZml4IGl0LgoKVGhhbmtz
LgoKCj4KPiBUaGFua3MKPgo+Cj4gPiArCQkJCSAgICAgYm9vbCBtYXlfcmVkdWNlX251bSkKPiA+
ICAgewo+ID4gLQlzdHJ1Y3QgdmlydHF1ZXVlICp2cTsKPiA+ICAgCXZvaWQgKnF1ZXVlID0gTlVM
TDsKPiA+IC0JZG1hX2FkZHJfdCBkbWFfYWRkcjsKPiA+IC0Jc2l6ZV90IHF1ZXVlX3NpemVfaW5f
Ynl0ZXM7Cj4gPiAtCXN0cnVjdCB2cmluZyB2cmluZzsKPiA+ICsJdTMyIG51bSA9ICpuOwo+ID4K
PiA+ICAgCS8qIFdlIGFzc3VtZSBudW0gaXMgYSBwb3dlciBvZiAyLiAqLwo+ID4gICAJaWYgKG51
bSAmIChudW0gLSAxKSkgewo+ID4gQEAgLTk0Miw3ICs5MzQsNyBAQCBzdGF0aWMgc3RydWN0IHZp
cnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+ICAgCS8qIFRPRE86IGFs
bG9jYXRlIGVhY2ggcXVldWUgY2h1bmsgaW5kaXZpZHVhbGx5ICovCj4gPiAgIAlmb3IgKDsgbnVt
ICYmIHZyaW5nX3NpemUobnVtLCB2cmluZ19hbGlnbikgPiBQQUdFX1NJWkU7IG51bSAvPSAyKSB7
Cj4gPiAgIAkJcXVldWUgPSB2cmluZ19hbGxvY19xdWV1ZSh2ZGV2LCB2cmluZ19zaXplKG51bSwg
dnJpbmdfYWxpZ24pLAo+ID4gLQkJCQkJICAmZG1hX2FkZHIsCj4gPiArCQkJCQkgIGRtYV9hZGRy
LAo+ID4gICAJCQkJCSAgR0ZQX0tFUk5FTHxfX0dGUF9OT1dBUk58X19HRlBfWkVSTyk7Cj4gPiAg
IAkJaWYgKHF1ZXVlKQo+ID4gICAJCQlicmVhazsKPiA+IEBAIC05NTYsMTEgKzk0OCwzOCBAQCBz
dGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+
ICAgCWlmICghcXVldWUpIHsKPiA+ICAgCQkvKiBUcnkgdG8gZ2V0IGEgc2luZ2xlIHBhZ2UuIFlv
dSBhcmUgbXkgb25seSBob3BlISAqLwo+ID4gICAJCXF1ZXVlID0gdnJpbmdfYWxsb2NfcXVldWUo
dmRldiwgdnJpbmdfc2l6ZShudW0sIHZyaW5nX2FsaWduKSwKPiA+IC0JCQkJCSAgJmRtYV9hZGRy
LCBHRlBfS0VSTkVMfF9fR0ZQX1pFUk8pOwo+ID4gKwkJCQkJICBkbWFfYWRkciwgR0ZQX0tFUk5F
THxfX0dGUF9aRVJPKTsKPiA+ICAgCX0KPiA+ICAgCWlmICghcXVldWUpCj4gPiAgIAkJcmV0dXJu
IE5VTEw7Cj4gPgo+ID4gKwkqbiA9IG51bTsKPiA+ICsJcmV0dXJuIHF1ZXVlOwo+ID4gK30KPiA+
ICsKPiA+ICtzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9z
cGxpdCgKPiA+ICsJdW5zaWduZWQgaW50IGluZGV4LAo+ID4gKwl1bnNpZ25lZCBpbnQgbnVtLAo+
ID4gKwl1bnNpZ25lZCBpbnQgdnJpbmdfYWxpZ24sCj4gPiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2LAo+ID4gKwlib29sIHdlYWtfYmFycmllcnMsCj4gPiArCWJvb2wgbWF5X3JlZHVjZV9u
dW0sCj4gPiArCWJvb2wgY29udGV4dCwKPiA+ICsJYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRx
dWV1ZSAqKSwKPiA+ICsJdm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4g
Kwljb25zdCBjaGFyICpuYW1lKQo+ID4gK3sKPiA+ICsJc2l6ZV90IHF1ZXVlX3NpemVfaW5fYnl0
ZXM7Cj4gPiArCXN0cnVjdCB2aXJ0cXVldWUgKnZxOwo+ID4gKwlkbWFfYWRkcl90IGRtYV9hZGRy
Owo+ID4gKwlzdHJ1Y3QgdnJpbmcgdnJpbmc7Cj4gPiArCXZvaWQgKnF1ZXVlOwo+ID4gKwo+ID4g
KwlxdWV1ZSA9IHZyaW5nX2FsbG9jX3F1ZXVlX3NwbGl0KHZkZXYsICZkbWFfYWRkciwgJm51bSwg
dnJpbmdfYWxpZ24sCj4gPiArCQkJCQl3ZWFrX2JhcnJpZXJzLCBtYXlfcmVkdWNlX251bSk7Cj4g
PiArCWlmICghcXVldWUpCj4gPiArCQlyZXR1cm4gTlVMTDsKPiA+ICsKPiA+ICAgCXF1ZXVlX3Np
emVfaW5fYnl0ZXMgPSB2cmluZ19zaXplKG51bSwgdnJpbmdfYWxpZ24pOwo+ID4gICAJdnJpbmdf
aW5pdCgmdnJpbmcsIG51bSwgcXVldWUsIHZyaW5nX2FsaWduKTsKPiA+Cj4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
