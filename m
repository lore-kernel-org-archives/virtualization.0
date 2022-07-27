Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A710C3F6B0
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 07:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DC4FF40412;
	Wed, 27 Jul 2022 07:36:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DC4FF40412
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lRNwKiblVgKH; Wed, 27 Jul 2022 07:36:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B2D8401C5;
	Wed, 27 Jul 2022 07:36:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B2D8401C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1075FC0033;
	Wed, 27 Jul 2022 07:36:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 468F5C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21822403E2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:36:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21822403E2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SBsQIkX4-wO3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:36:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48A64401C5
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 48A64401C5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:36:49 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R251e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VKZmDNB_1658907402; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VKZmDNB_1658907402) by smtp.aliyun-inc.com;
 Wed, 27 Jul 2022 15:36:43 +0800
Message-ID: <1658907340.34387-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v13 07/42] virtio_ring: split: stop __vring_new_virtqueue
 as export symbol
Date: Wed, 27 Jul 2022 15:35:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-8-xuanzhuo@linux.alibaba.com>
 <a5449e49-ba38-9760-ac07-cfad048bc602@redhat.com>
In-Reply-To: <a5449e49-ba38-9760-ac07-cfad048bc602@redhat.com>
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCAyNyBKdWwgMjAyMiAxMDo1ODowNSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi83LzI2IDE1OjIxLCBYdWFuIFpodW8g5YaZ
6YGTOgo+ID4gVGhlcmUgaXMgY3VycmVudGx5IG9ubHkgb25lIHBsYWNlIHRvIHJlZmVyZW5jZSBf
X3ZyaW5nX25ld192aXJ0cXVldWUoKQo+ID4gZGlyZWN0bHkgZnJvbSB0aGUgb3V0c2lkZSBvZiB2
aXJ0aW8gY29yZS4gQW5kIGhlcmUgdnJpbmdfbmV3X3ZpcnRxdWV1ZSgpCj4gPiBjYW4gYmUgdXNl
ZCBpbnN0ZWFkLgo+ID4KPiA+IFN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsIG1vZGlmeSBfX3ZyaW5n
X25ld192aXJ0cXVldWUsIHNvIHN0b3AgaXQgYXMgYW4KPiA+IGV4cG9ydCBzeW1ib2wgZm9yIG5v
dy4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAyNSAr
KysrKysrKysrKysrKysrLS0tLS0tLS0tCj4gPiAgIGluY2x1ZGUvbGludXgvdmlydGlvX3Jpbmcu
aCAgfCAxMCAtLS0tLS0tLS0tCj4gPiAgIHRvb2xzL3ZpcnRpby92aXJ0aW9fdGVzdC5jICAgfCAg
NCArKy0tCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRp
b25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBpbmRleCAwYWQzNWVjYTBkMzkuLjRl
NTRlZDdlZTdmYiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
PiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IEBAIC0yMDQsNiArMjA0
LDE0IEBAIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgewo+ID4gICAjZW5kaWYKPiA+ICAgfTsKPiA+
Cj4gPiArc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNp
Z25lZCBpbnQgaW5kZXgsCj4gPiArCQkJCQkgICAgICAgc3RydWN0IHZyaW5nIHZyaW5nLAo+ID4g
KwkJCQkJICAgICAgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ID4gKwkJCQkJICAgICAg
IGJvb2wgd2Vha19iYXJyaWVycywKPiA+ICsJCQkJCSAgICAgICBib29sIGNvbnRleHQsCj4gPiAr
CQkJCQkgICAgICAgYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+ICsJCQkJ
CSAgICAgICB2b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPiArCQkJCQkg
ICAgICAgY29uc3QgY2hhciAqbmFtZSk7Cj4gPgo+ID4gICAvKgo+ID4gICAgKiBIZWxwZXJzLgo+
ID4gQEAgLTIxOTcsMTQgKzIyMDUsMTQgQEAgaXJxcmV0dXJuX3QgdnJpbmdfaW50ZXJydXB0KGlu
dCBpcnEsIHZvaWQgKl92cSkKPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwodnJpbmdfaW50ZXJydXB0
KTsKPiA+Cj4gPiAgIC8qIE9ubHkgYXZhaWxhYmxlIGZvciBzcGxpdCByaW5nICovCj4gPiAtc3Ry
dWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwK
PiA+IC0JCQkJCXN0cnVjdCB2cmluZyB2cmluZywKPiA+IC0JCQkJCXN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2LAo+ID4gLQkJCQkJYm9vbCB3ZWFrX2JhcnJpZXJzLAo+ID4gLQkJCQkJYm9vbCBj
b250ZXh0LAo+ID4gLQkJCQkJYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+
IC0JCQkJCXZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+IC0JCQkJCWNv
bnN0IGNoYXIgKm5hbWUpCj4gPiArc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3
X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiArCQkJCQkgICAgICAgc3RydWN0IHZy
aW5nIHZyaW5nLAo+ID4gKwkJCQkJICAgICAgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+
ID4gKwkJCQkJICAgICAgIGJvb2wgd2Vha19iYXJyaWVycywKPiA+ICsJCQkJCSAgICAgICBib29s
IGNvbnRleHQsCj4gPiArCQkJCQkgICAgICAgYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1
ZSAqKSwKPiA+ICsJCQkJCSAgICAgICB2b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUg
KiksCj4gPiArCQkJCQkgICAgICAgY29uc3QgY2hhciAqbmFtZSkKPiA+ICAgewo+ID4gICAJc3Ry
dWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnE7Cj4gPgo+ID4gQEAgLTIyNzIsNyArMjI4MCw2IEBAIHN0
cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgs
Cj4gPiAgIAlrZnJlZSh2cSk7Cj4gPiAgIAlyZXR1cm4gTlVMTDsKPiA+ICAgfQo+ID4gLUVYUE9S
VF9TWU1CT0xfR1BMKF9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSk7Cj4gPgo+ID4gICBzdHJ1Y3Qgdmly
dHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlKAo+ID4gICAJdW5zaWduZWQgaW50IGluZGV4
LAo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX3JpbmcuaCBiL2luY2x1ZGUv
bGludXgvdmlydGlvX3JpbmcuaAo+ID4gaW5kZXggYjQ4NWIxM2ZhNTBiLi44YjhhZjFhMzg5OTEg
MTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19yaW5nLmgKPiA+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvdmlydGlvX3JpbmcuaAo+ID4gQEAgLTc2LDE2ICs3Niw2IEBAIHN0cnVjdCB2
aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ID4g
ICAJCQkJCSB2b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKnZxKSwKPiA+ICAgCQkJ
CQkgY29uc3QgY2hhciAqbmFtZSk7Cj4gPgo+ID4gLS8qIENyZWF0ZXMgYSB2aXJ0cXVldWUgd2l0
aCBhIGN1c3RvbSBsYXlvdXQuICovCj4gPiAtc3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdf
dmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiA+IC0JCQkJCXN0cnVjdCB2cmluZyB2cmlu
ZywKPiA+IC0JCQkJCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ID4gLQkJCQkJYm9vbCB3
ZWFrX2JhcnJpZXJzLAo+ID4gLQkJCQkJYm9vbCBjdHgsCj4gPiAtCQkJCQlib29sICgqbm90aWZ5
KShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4gLQkJCQkJdm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3Qg
dmlydHF1ZXVlICopLAo+ID4gLQkJCQkJY29uc3QgY2hhciAqbmFtZSk7Cj4gPiAtCj4gPiAgIC8q
Cj4gPiAgICAqIENyZWF0ZXMgYSB2aXJ0cXVldWUgd2l0aCBhIHN0YW5kYXJkIGxheW91dCBidXQg
YSBjYWxsZXItYWxsb2NhdGVkCj4gPiAgICAqIHJpbmcuCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMv
dmlydGlvL3ZpcnRpb190ZXN0LmMgYi90b29scy92aXJ0aW8vdmlydGlvX3Rlc3QuYwo+ID4gaW5k
ZXggMjNmMTQyYWY1NDRhLi44NmE0MTBkZGNlZGQgMTAwNjQ0Cj4gPiAtLS0gYS90b29scy92aXJ0
aW8vdmlydGlvX3Rlc3QuYwo+ID4gKysrIGIvdG9vbHMvdmlydGlvL3ZpcnRpb190ZXN0LmMKPiA+
IEBAIC0xMDIsOCArMTAyLDggQEAgc3RhdGljIHZvaWQgdnFfcmVzZXQoc3RydWN0IHZxX2luZm8g
KmluZm8sIGludCBudW0sIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4KPiA+ICAgCW1l
bXNldChpbmZvLT5yaW5nLCAwLCB2cmluZ19zaXplKG51bSwgNDA5NikpOwo+ID4gICAJdnJpbmdf
aW5pdCgmaW5mby0+dnJpbmcsIG51bSwgaW5mby0+cmluZywgNDA5Nik7Cj4KPgo+IExldCdzIHJl
bW92ZSB0aGUgZHVwbGljYXRlZCB2cmluZ19pbml0KCkgaGVyZS4KPgo+IFdpdGggdGhpcyByZW1v
dmVkOgoKVGhlIHJlYXNvbiBJIGRpZG4ndCBkZWxldGUgdGhpcyB2cmluZ19pbml0KCkgaXMgYmVj
YXVzZSBpbmZvLT52cmluZyBpcyB1c2VkCmVsc2V3aGVyZS4gU28gaXQgY2FuJ3QgYmUgZGVsZXRl
ZCBkaXJlY3RseS4KClRoYW5rcy4KCj4KPiBBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KPgo+Cj4gPiAtCWluZm8tPnZxID0gX192cmluZ19uZXdfdmlydHF1ZXVlKGlu
Zm8tPmlkeCwgaW5mby0+dnJpbmcsIHZkZXYsIHRydWUsCj4gPiAtCQkJCQkgZmFsc2UsIHZxX25v
dGlmeSwgdnFfY2FsbGJhY2ssICJ0ZXN0Iik7Cj4gPiArCWluZm8tPnZxID0gdnJpbmdfbmV3X3Zp
cnRxdWV1ZShpbmZvLT5pZHgsIG51bSwgNDA5NiwgdmRldiwgdHJ1ZSwgZmFsc2UsCj4gPiArCQkJ
CSAgICAgICBpbmZvLT5yaW5nLCB2cV9ub3RpZnksIHZxX2NhbGxiYWNrLCAidGVzdCIpOwo+ID4g
ICAJYXNzZXJ0KGluZm8tPnZxKTsKPiA+ICAgCWluZm8tPnZxLT5wcml2ID0gaW5mbzsKPiA+ICAg
fQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
