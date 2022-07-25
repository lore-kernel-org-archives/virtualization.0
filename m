Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819C1C43334
	for <virtualization@archiver.kernel.org>; Mon, 25 Jul 2022 06:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B1E140B7A;
	Mon, 25 Jul 2022 06:43:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B1E140B7A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5TnmlRZh_27I; Mon, 25 Jul 2022 06:43:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7083D401C2;
	Mon, 25 Jul 2022 06:43:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7083D401C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38E52C0035;
	Mon, 25 Jul 2022 06:43:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 581A9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 06:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DE9A40CB0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 06:43:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1DE9A40CB0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xo_Buq-pxgK1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 06:43:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C520401C2
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C520401C2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 06:43:06 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VKIBBAF_1658731375; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VKIBBAF_1658731375) by smtp.aliyun-inc.com;
 Mon, 25 Jul 2022 14:42:56 +0800
Message-ID: <1658731116.1695666-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v12 38/40] virtio_net: support rx queue resize
Date: Mon, 25 Jul 2022 14:38:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-39-xuanzhuo@linux.alibaba.com>
 <726a5056-789a-b445-a2c6-879008ad270a@redhat.com>
In-Reply-To: <726a5056-789a-b445-a2c6-879008ad270a@redhat.com>
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

T24gVGh1LCAyMSBKdWwgMjAyMiAxNzoyNTo1OSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi83LzIwIDExOjA0LCBYdWFuIFpodW8g5YaZ
6YGTOgo+ID4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhl
IHJ4IHF1ZXVlcy4KPiA+IEJhc2VkIG9uIHRoaXMgZnVuY3Rpb24sIGl0IGlzIHBvc3NpYmxlIHRv
IG1vZGlmeSB0aGUgcmluZyBudW0gb2YgdGhlCj4gPiBxdWV1ZS4KPiA+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAg
IGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKysKPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBp
bmRleCBmZTRkYzQzYzA1YTEuLjExMTVhOGI1OWEwOCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBA
QCAtMjc4LDYgKzI3OCw4IEBAIHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+ID4gICAJY2hhciBw
YWRkaW5nWzEyXTsKPiA+ICAgfTsKPiA+Cj4gPiArc3RhdGljIHZvaWQgdmlydG5ldF9ycV9mcmVl
X3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4gPiArCj4gPiAg
IHN0YXRpYyBib29sIGlzX3hkcF9mcmFtZSh2b2lkICpwdHIpCj4gPiAgIHsKPiA+ICAgCXJldHVy
biAodW5zaWduZWQgbG9uZylwdHIgJiBWSVJUSU9fWERQX0ZMQUc7Cj4gPiBAQCAtMTg0Niw2ICsx
ODQ4LDI2IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBzdGFydF94bWl0KHN0cnVjdCBza19idWZmICpz
a2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiAgIAlyZXR1cm4gTkVUREVWX1RYX09LOwo+
ID4gICB9Cj4gPgo+ID4gK3N0YXRpYyBpbnQgdmlydG5ldF9yeF9yZXNpemUoc3RydWN0IHZpcnRu
ZXRfaW5mbyAqdmksCj4gPiArCQkJICAgICBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsIHUzMiBy
aW5nX251bSkKPiA+ICt7Cj4gPiArCWludCBlcnIsIHFpbmRleDsKPiA+ICsKPiA+ICsJcWluZGV4
ID0gcnEgLSB2aS0+cnE7Cj4gPiArCj4gPiArCW5hcGlfZGlzYWJsZSgmcnEtPm5hcGkpOwo+Cj4K
PiBXZSBuZWVkIHRvIGRpc2FibGUgcmVmaWxsIHdvcmsgYXMgd2VsbC4gU28gdGhpcyBzZXJpZXMg
bWlnaHQgbmVlZAo+IHJlYmFzaW5nIG9uIHRvcCBvZgo+Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbmV0ZGV2LzIwMjIwNzA0MDc0ODU5LjE2OTEyLTEtamFzb3dhbmdAcmVkaGF0LmNvbS8KCkkg
dW5kZXJzdGFuZCB0aGF0IHlvdXIgcGF0Y2ggaXMgdXNlZCB0byBzb2x2ZSB0aGUgc2l0dWF0aW9u
IHdoZXJlIGRldiBpcwpkZXN0b3J5ZWQgYnV0IHJlZmlsbCB3b3JrIGlzIHJ1bm5pbmcuCgpBbmQg
aXMgdGhlcmUgc3VjaCBhIHBvc3NpYmlsaXR5IGhlcmU/IE9yIGlzIHRoZXJlIGFueSBvdGhlciBz
Y2VuYXJpbyB0aGF0IEknbQpub3QgZXhwZWN0aW5nPwoKVGhhbmtzLgoKCj4KPiBJIHdpbGwgc2Vu
ZCBhIG5ldyB2ZXJzaW9uIChwcm9iYWJseSB0b21vcnJvdykuCj4KPiBUaGFua3MKPgo+Cj4gPiAr
Cj4gPiArCWVyciA9IHZpcnRxdWV1ZV9yZXNpemUocnEtPnZxLCByaW5nX251bSwgdmlydG5ldF9y
cV9mcmVlX3VudXNlZF9idWYpOwo+ID4gKwlpZiAoZXJyKQo+ID4gKwkJbmV0ZGV2X2Vycih2aS0+
ZGV2LCAicmVzaXplIHJ4IGZhaWw6IHJ4IHF1ZXVlIGluZGV4OiAlZCBlcnI6ICVkXG4iLCBxaW5k
ZXgsIGVycik7Cj4gPiArCj4gPiArCWlmICghdHJ5X2ZpbGxfcmVjdih2aSwgcnEsIEdGUF9LRVJO
RUwpKQo+ID4gKwkJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZ2aS0+cmVmaWxsLCAwKTsKPiA+ICsK
PiA+ICsJdmlydG5ldF9uYXBpX2VuYWJsZShycS0+dnEsICZycS0+bmFwaSk7Cj4gPiArCXJldHVy
biBlcnI7Cj4gPiArfQo+ID4gKwo+ID4gICAvKgo+ID4gICAgKiBTZW5kIGNvbW1hbmQgdmlhIHRo
ZSBjb250cm9sIHZpcnRxdWV1ZSBhbmQgY2hlY2sgc3RhdHVzLiAgQ29tbWFuZHMKPiA+ICAgICog
c3VwcG9ydGVkIGJ5IHRoZSBoeXBlcnZpc29yLCBhcyBpbmRpY2F0ZWQgYnkgZmVhdHVyZSBiaXRz
LCBzaG91bGQKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
