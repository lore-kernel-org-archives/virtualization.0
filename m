Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56EBCCA485
	for <virtualization@archiver.kernel.org>; Fri, 15 Jul 2022 08:37:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FE2682AC6;
	Fri, 15 Jul 2022 08:37:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FE2682AC6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4HS__uAL_GQt; Fri, 15 Jul 2022 08:37:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 03449826AA;
	Fri, 15 Jul 2022 08:37:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03449826AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEB63C0033;
	Fri, 15 Jul 2022 08:37:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9692C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jul 2022 08:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C351A40597
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jul 2022 08:37:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C351A40597
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id srx3IJ_CxzMN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jul 2022 08:37:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B8D4401ED
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B8D4401ED
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jul 2022 08:37:07 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=36; SR=0; TI=SMTPD_---0VJOcj-v_1657874219; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VJOcj-v_1657874219) by smtp.aliyun-inc.com;
 Fri, 15 Jul 2022 16:37:00 +0800
Message-ID: <1657874178.9766078-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 38/40] virtio_net: support rx queue resize
Date: Fri, 15 Jul 2022 16:36:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-39-xuanzhuo@linux.alibaba.com>
 <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
 <1656986375.3420787-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEu80KP-ULz_CBvauRk_3XsCubMkkWv0uLnbt-wib5KOnA@mail.gmail.com>
In-Reply-To: <CACGkMEu80KP-ULz_CBvauRk_3XsCubMkkWv0uLnbt-wib5KOnA@mail.gmail.com>
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm <kvm@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev <netdev@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
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

T24gRnJpLCA4IEp1bCAyMDIyIDE0OjIwOjUyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiBPbiBUdWUsIEp1bCA1LCAyMDIyIGF0IDEwOjAwIEFNIFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwg
NCBKdWwgMjAyMiAxMTo0NDoxMiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IOWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiA+ID4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2Yg
dGhlIHJ4IHF1ZXVlcy4KPiA+ID4gPiBCYXNlZCBvbiB0aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3Nz
aWJsZSB0byBtb2RpZnkgdGhlIHJpbmcgbnVtIG9mIHRoZQo+ID4gPiA+IHF1ZXVlLgo+ID4gPiA+
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJh
LmNvbT4KPiA+ID4gPiAtLS0KPiA+ID4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIy
ICsrKysrKysrKysrKysrKysrKysrKysKPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNl
cnRpb25zKCspCj4gPiA+ID4KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gaW5kZXggOWZlMjIyYTM2
NjNhLi42YWIxNmZkMTkzZTUgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gQEAg
LTI3OCw2ICsyNzgsOCBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiA+ID4gPiAgICAgY2hh
ciBwYWRkaW5nWzEyXTsKPiA+ID4gPiAgIH07Cj4gPiA+ID4KPiA+ID4gPiArc3RhdGljIHZvaWQg
dmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1
Zik7Cj4gPiA+ID4gKwo+ID4gPiA+ICAgc3RhdGljIGJvb2wgaXNfeGRwX2ZyYW1lKHZvaWQgKnB0
cikKPiA+ID4gPiAgIHsKPiA+ID4gPiAgICAgcmV0dXJuICh1bnNpZ25lZCBsb25nKXB0ciAmIFZJ
UlRJT19YRFBfRkxBRzsKPiA+ID4gPiBAQCAtMTg0Niw2ICsxODQ4LDI2IEBAIHN0YXRpYyBuZXRk
ZXZfdHhfdCBzdGFydF94bWl0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYpCj4gPiA+ID4gICAgIHJldHVybiBORVRERVZfVFhfT0s7Cj4gPiA+ID4gICB9Cj4gPiA+
ID4KPiA+ID4gPiArc3RhdGljIGludCB2aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5ldF9p
bmZvICp2aSwKPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHJlY2VpdmVf
cXVldWUgKnJxLCB1MzIgcmluZ19udW0pCj4gPiA+ID4gK3sKPiA+ID4gPiArICAgaW50IGVyciwg
cWluZGV4Owo+ID4gPiA+ICsKPiA+ID4gPiArICAgcWluZGV4ID0gcnEgLSB2aS0+cnE7Cj4gPiA+
ID4gKwo+ID4gPiA+ICsgICBuYXBpX2Rpc2FibGUoJnJxLT5uYXBpKTsKPiA+ID4KPiA+ID4KPiA+
ID4gRG8gd2UgbmVlZCB0byBjYW5jZWwgdGhlIHJlZmlsbCB3b3JrIGhlcmU/Cj4gPgo+ID4KPiA+
IEkgdGhpbmsgbm8sIG5hcGlfZGlzYWJsZSBpcyBtdXR1YWxseSBleGNsdXNpdmUsIHdoaWNoIGVu
c3VyZXMgdGhhdCB0aGVyZSB3aWxsIGJlCj4gPiBubyBjb25mbGljdHMgYmV0d2VlbiB0aGVtLgo+
Cj4gU28gdGhpcyBzb3VuZHMgc2ltaWxhciB0byB3aGF0IEkndmUgZml4ZWQgcmVjZW50bHkuCj4K
PiAxKSBOQVBJIHNjaGVkdWxlIGRlbGF5ZWQgd29yay4KPiAyKSB3ZSBkaXNhYmxlIE5BUEkgaGVy
ZQo+IDMpIGRlbGF5ZWQgd29yayBnZXQgc2NoZWR1bGUgYW5kIGNhbGwgTkFQSSBhZ2Fpbgo+Cj4g
PwoKWWVzLCBidXQgSSBkb24ndCB0aGluayB0aGVyZSBhcmUgYW55IG5lZ2F0aXZlIGVmZmVjdHMu
CgpUaGFua3MuCgo+Cj4gVGhhbmtzCj4KPiA+Cj4gPiBUaGFua3MuCj4gPgo+ID4gPgo+ID4gPiBU
aGFua3MKPiA+ID4KPiA+ID4KPiA+ID4gPiArCj4gPiA+ID4gKyAgIGVyciA9IHZpcnRxdWV1ZV9y
ZXNpemUocnEtPnZxLCByaW5nX251bSwgdmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYpOwo+ID4g
PiA+ICsgICBpZiAoZXJyKQo+ID4gPiA+ICsgICAgICAgICAgIG5ldGRldl9lcnIodmktPmRldiwg
InJlc2l6ZSByeCBmYWlsOiByeCBxdWV1ZSBpbmRleDogJWQgZXJyOiAlZFxuIiwgcWluZGV4LCBl
cnIpOwo+ID4gPiA+ICsKPiA+ID4gPiArICAgaWYgKCF0cnlfZmlsbF9yZWN2KHZpLCBycSwgR0ZQ
X0tFUk5FTCkpCj4gPiA+ID4gKyAgICAgICAgICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZ2aS0+
cmVmaWxsLCAwKTsKPiA+ID4gPiArCj4gPiA+ID4gKyAgIHZpcnRuZXRfbmFwaV9lbmFibGUocnEt
PnZxLCAmcnEtPm5hcGkpOwo+ID4gPiA+ICsgICByZXR1cm4gZXJyOwo+ID4gPiA+ICt9Cj4gPiA+
ID4gKwo+ID4gPiA+ICAgLyoKPiA+ID4gPiAgICAqIFNlbmQgY29tbWFuZCB2aWEgdGhlIGNvbnRy
b2wgdmlydHF1ZXVlIGFuZCBjaGVjayBzdGF0dXMuICBDb21tYW5kcwo+ID4gPiA+ICAgICogc3Vw
cG9ydGVkIGJ5IHRoZSBoeXBlcnZpc29yLCBhcyBpbmRpY2F0ZWQgYnkgZmVhdHVyZSBiaXRzLCBz
aG91bGQKPiA+ID4KPiA+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
