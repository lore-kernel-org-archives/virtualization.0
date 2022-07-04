Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2E4C43334
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 02:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11A7440961;
	Mon,  4 Jul 2022 02:20:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 11A7440961
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id INhEYOkeNJCh; Mon,  4 Jul 2022 02:20:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 292724094B;
	Mon,  4 Jul 2022 02:20:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 292724094B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5B69C0032;
	Mon,  4 Jul 2022 02:20:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FC12C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 231D44094B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:20:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 231D44094B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EZXBnrjzku8p
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:20:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C6BA40946
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C6BA40946
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:20:50 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VIEJAfc_1656901242; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VIEJAfc_1656901242) by smtp.aliyun-inc.com;
 Mon, 04 Jul 2022 10:20:43 +0800
Message-ID: <1656900812.860175-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 21/40] virtio_ring: packed: introduce
 virtqueue_resize_packed()
Date: Mon, 4 Jul 2022 10:13:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-22-xuanzhuo@linux.alibaba.com>
 <de7cf56d-acbd-1a2b-2226-a9fdd89afb78@redhat.com>
In-Reply-To: <de7cf56d-acbd-1a2b-2226-a9fdd89afb78@redhat.com>
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

T24gRnJpLCAxIEp1bCAyMDIyIDE3OjI3OjQ4ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiB2aXJ0aW8gcmluZyBwYWNrZWQgc3VwcG9ydHMgcmVzaXplLgo+ID4KPiA+IE9ubHkg
YWZ0ZXIgdGhlIG5ldyB2cmluZyBpcyBzdWNjZXNzZnVsbHkgYWxsb2NhdGVkIGJhc2VkIG9uIHRo
ZSBuZXcgbnVtLAo+ID4gd2Ugd2lsbCByZWxlYXNlIHRoZSBvbGQgdnJpbmcuIEluIGFueSBjYXNl
LCBhbiBlcnJvciBpcyByZXR1cm5lZCwKPiA+IGluZGljYXRpbmcgdGhhdCB0aGUgdnJpbmcgc3Rp
bGwgcG9pbnRzIHRvIHRoZSBvbGQgdnJpbmcuCj4gPgo+ID4gSW4gdGhlIGNhc2Ugb2YgYW4gZXJy
b3IsIHJlLWluaXRpYWxpemUoYnkgdmlydHF1ZXVlX3JlaW5pdF9wYWNrZWQoKSkgdGhlCj4gPiB2
aXJ0cXVldWUgdG8gZW5zdXJlIHRoYXQgdGhlIHZyaW5nIGNhbiBiZSB1c2VkLgo+ID4KPiA+IFNp
Z25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAt
LS0KPiA+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDI5ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspCj4g
Pgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBpbmRleCA2NTBmNzAxYTU0ODAuLjQ4NjA3ODcyODZk
YiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IEBAIC0yMDQyLDYgKzIwNDIsMzUgQEAg
c3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+
ID4gICAJcmV0dXJuIE5VTEw7Cj4gPiAgIH0KPiA+Cj4gPiArc3RhdGljIGludCB2aXJ0cXVldWVf
cmVzaXplX3BhY2tlZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBudW0pCj4gPiArewo+ID4g
KwlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlX3BhY2tlZCB2cmluZyA9IHt9Owo+ID4gKwlzdHJ1Y3Qg
dnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gKwlzdHJ1Y3QgdmlydGlvX2Rl
dmljZSAqdmRldiA9IF92cS0+dmRldjsKPiA+ICsJaW50IGVycjsKPiA+ICsKPiA+ICsJaWYgKHZy
aW5nX2FsbG9jX3F1ZXVlX3BhY2tlZCgmdnJpbmcsIHZkZXYsIG51bSkpCj4gPiArCQlnb3RvIGVy
cl9yaW5nOwo+ID4gKwo+ID4gKwllcnIgPSB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9wYWNrZWQo
JnZyaW5nKTsKPiA+ICsJaWYgKGVycikKPiA+ICsJCWdvdG8gZXJyX3N0YXRlX2V4dHJhOwo+ID4g
Kwo+ID4gKwl2cmluZ19mcmVlKCZ2cS0+dnEpOwo+ID4gKwo+ID4gKwl2aXJ0cXVldWVfaW5pdCh2
cSwgdnJpbmcudnJpbmcubnVtKTsKPiA+ICsJdmlydHF1ZXVlX3ZyaW5nX2F0dGFjaF9wYWNrZWQo
dnEsICZ2cmluZyk7Cj4gPiArCXZpcnRxdWV1ZV92cmluZ19pbml0X3BhY2tlZCh2cSk7Cj4gPiAr
Cj4gPiArCXJldHVybiAwOwo+ID4gKwo+ID4gK2Vycl9zdGF0ZV9leHRyYToKPiA+ICsJdnJpbmdf
ZnJlZV9wYWNrZWQoJnZyaW5nLCB2ZGV2KTsKPiA+ICtlcnJfcmluZzoKPiA+ICsJdmlydHF1ZXVl
X3JlaW5pdF9wYWNrZWQodnEpOwo+Cj4KPiBTbyBkZXNjX3N0YXRlIGFuZCBkZXNjX2V4dHJhIGhh
cyBiZWVuIGZyZWVkIHZyaW5nX2ZyZWVfcGFja2VkKCkgd2hlbgo+IHZyaW5nX2FsbG9jX3N0YXRl
X2V4dHJhX3BhY2tlZCgpIGZhaWxzLiBXZSBtaWdodCBnZXQgdXNlLWFmdGVyLWZyZWUgaGVyZT8K
CnZyaW5nX2ZyZWVfcGFja2VkKCkgZnJlZXMgdGhlIHRlbXBvcmFyeSBzdHJ1Y3R1cmUgdnJpbmcu
IEl0IGRvZXMgbm90IGFmZmVjdApkZXNjX3N0YXRlIGFuZCBkZXNjX2V4dHJhIG9mIHZxLiBTbyBp
dCBpcyBzYWZlLgoKPgo+IEFjdHVhbGx5LCBJIHRoaW5rIGZvciByZXNpemUgd2UgbmVlZAo+Cj4g
MSkgZGV0YWNoIG9sZAo+IDIpIGFsbG9jYXRlIG5ldwo+IDMpIGlmIDIpIHN1Y2NlZWQsIGF0dGFj
aCBuZXcgb3RoZXJ3aXNlIGF0dGFjaCBvbGQKCgpUaGUgaW1wbGVtZW50YXRpb24gaXMgbm93OgoK
MS4gYWxsb2NhdGUgbmV3CjIuIGZyZWUgb2xkIChkZXRhY2ggb2xkKQozLiBhdHRhY2ggbmV3Cgpl
cnJvcjoKMS4gZnJlZSB0ZW1wb3JhcnkKMi4gcmVpbml0IG9sZAoKRG8geW91IHRoaW5rIHRoaXMg
aXMgb2s/IFdlIG5lZWQgdG8gYWRkIGEgbmV3IHZhcmlhYmxlIHRvIHNhdmUgdGhlIG9sZCB2cmlu
ZyBpbgp0aGUgcHJvY2VzcyB5b3UgbWVudGlvbmVkLCB0aGVyZSBpcyBub3QgbXVjaCBkaWZmZXJl
bmNlIGluIG90aGVyLgoKVGhhbmtzLgoKCj4KPiBUaGlzIHNlZW1zIG1vcmUgY2xlYXJlciB0aGFu
IHRoZSBjdXJyZW50IGxvZ2ljPwo+Cj4gVGhhbmtzCj4KPgo+ID4gKwlyZXR1cm4gLUVOT01FTTsK
PiA+ICt9Cj4gPiArCj4gPgo+ID4gICAvKgo+ID4gICAgKiBHZW5lcmljIGZ1bmN0aW9ucyBhbmQg
ZXhwb3J0ZWQgc3ltYm9scy4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
