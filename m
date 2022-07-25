Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84646CCA491
	for <virtualization@archiver.kernel.org>; Mon, 25 Jul 2022 07:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25A368146C;
	Mon, 25 Jul 2022 07:23:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25A368146C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Spj85XRYdQf; Mon, 25 Jul 2022 07:23:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8AEDD8145A;
	Mon, 25 Jul 2022 07:23:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8AEDD8145A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C35FC0033;
	Mon, 25 Jul 2022 07:23:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEB5BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D664A60E21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:23:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D664A60E21
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X37FSQubV-Dh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:23:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC84560B99
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC84560B99
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:23:34 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R661e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VKJTorY_1658733806; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VKJTorY_1658733806) by smtp.aliyun-inc.com;
 Mon, 25 Jul 2022 15:23:27 +0800
Message-ID: <1658733700.3892667-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v12 38/40] virtio_net: support rx queue resize
Date: Mon, 25 Jul 2022 15:21:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-39-xuanzhuo@linux.alibaba.com>
 <726a5056-789a-b445-a2c6-879008ad270a@redhat.com>
 <1658731116.1695666-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvsAyR5uRprobv-bQYPOKKOM4sZzQ-Vw5ZiETMjiCkdRQ@mail.gmail.com>
In-Reply-To: <CACGkMEvsAyR5uRprobv-bQYPOKKOM4sZzQ-Vw5ZiETMjiCkdRQ@mail.gmail.com>
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
 Vasily Gorbik <gor@linux.ibm.com>, Kangjie Xu <kangjie.xu@linux.alibaba.com>,
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

T24gTW9uLCAyNSBKdWwgMjAyMiAxNDo1NzoxMSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gTW9uLCBKdWwgMjUsIDIwMjIgYXQgMjo0MyBQTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUaHUs
IDIxIEp1bCAyMDIyIDE3OjI1OjU5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4g5ZyoIDIwMjIvNy8yMCAxMTowNCwgWHVhbiBaaHVvIOWG
memBkzoKPiA+ID4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIHJlc2l6ZSBmdW5jdGlvbiBv
ZiB0aGUgcnggcXVldWVzLgo+ID4gPiA+IEJhc2VkIG9uIHRoaXMgZnVuY3Rpb24sIGl0IGlzIHBv
c3NpYmxlIHRvIG1vZGlmeSB0aGUgcmluZyBudW0gb2YgdGhlCj4gPiA+ID4gcXVldWUuCj4gPiA+
ID4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwg
MjIgKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGlu
c2VydGlvbnMoKykKPiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiBpbmRleCBmZTRkYzQz
YzA1YTEuLjExMTVhOGI1OWEwOCAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiBA
QCAtMjc4LDYgKzI3OCw4IEBAIHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+ID4gPiA+ICAgICBj
aGFyIHBhZGRpbmdbMTJdOwo+ID4gPiA+ICAgfTsKPiA+ID4gPgo+ID4gPiA+ICtzdGF0aWMgdm9p
ZCB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAq
YnVmKTsKPiA+ID4gPiArCj4gPiA+ID4gICBzdGF0aWMgYm9vbCBpc194ZHBfZnJhbWUodm9pZCAq
cHRyKQo+ID4gPiA+ICAgewo+ID4gPiA+ICAgICByZXR1cm4gKHVuc2lnbmVkIGxvbmcpcHRyICYg
VklSVElPX1hEUF9GTEFHOwo+ID4gPiA+IEBAIC0xODQ2LDYgKzE4NDgsMjYgQEAgc3RhdGljIG5l
dGRldl90eF90IHN0YXJ0X3htaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZp
Y2UgKmRldikKPiA+ID4gPiAgICAgcmV0dXJuIE5FVERFVl9UWF9PSzsKPiA+ID4gPiAgIH0KPiA+
ID4gPgo+ID4gPiA+ICtzdGF0aWMgaW50IHZpcnRuZXRfcnhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0
X2luZm8gKnZpLAo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcmVjZWl2
ZV9xdWV1ZSAqcnEsIHUzMiByaW5nX251bSkKPiA+ID4gPiArewo+ID4gPiA+ICsgICBpbnQgZXJy
LCBxaW5kZXg7Cj4gPiA+ID4gKwo+ID4gPiA+ICsgICBxaW5kZXggPSBycSAtIHZpLT5ycTsKPiA+
ID4gPiArCj4gPiA+ID4gKyAgIG5hcGlfZGlzYWJsZSgmcnEtPm5hcGkpOwo+ID4gPgo+ID4gPgo+
ID4gPiBXZSBuZWVkIHRvIGRpc2FibGUgcmVmaWxsIHdvcmsgYXMgd2VsbC4gU28gdGhpcyBzZXJp
ZXMgbWlnaHQgbmVlZAo+ID4gPiByZWJhc2luZyBvbiB0b3Agb2YKPiA+ID4KPiA+ID4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjIwNzA0MDc0ODU5LjE2OTEyLTEtamFzb3dhbmdA
cmVkaGF0LmNvbS8KPiA+Cj4gPiBJIHVuZGVyc3RhbmQgdGhhdCB5b3VyIHBhdGNoIGlzIHVzZWQg
dG8gc29sdmUgdGhlIHNpdHVhdGlvbiB3aGVyZSBkZXYgaXMKPiA+IGRlc3RvcnllZCBidXQgcmVm
aWxsIHdvcmsgaXMgcnVubmluZy4KPiA+Cj4gPiBBbmQgaXMgdGhlcmUgc3VjaCBhIHBvc3NpYmls
aXR5IGhlcmU/Cj4KPiBFLmcgdGhlIHJlZmlsbCB3b3JrIHJ1bnMgaW4gcGFyYWxsZWwgd2l0aCB0
aGlzIGZ1bmN0aW9uPwoKbmFwaV9kaXNhYmxlIGVuYWJsZXMgbG9jay1saWtlIGZ1bmN0aW9uYWxp
dHkuIFNvIEkgdGhpbmsgaXQncyBzYWZlLgoKVGhhbmtzLgoKPgo+IFRoYW5rcwo+Cj4gPiBPciBp
cyB0aGVyZSBhbnkgb3RoZXIgc2NlbmFyaW8gdGhhdCBJJ20KPiA+IG5vdCBleHBlY3Rpbmc/Cj4g
Pgo+ID4gVGhhbmtzLgo+ID4KPiA+Cj4gPiA+Cj4gPiA+IEkgd2lsbCBzZW5kIGEgbmV3IHZlcnNp
b24gKHByb2JhYmx5IHRvbW9ycm93KS4KPiA+ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+Cj4g
PiA+ID4gKwo+ID4gPiA+ICsgICBlcnIgPSB2aXJ0cXVldWVfcmVzaXplKHJxLT52cSwgcmluZ19u
dW0sIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKTsKPiA+ID4gPiArICAgaWYgKGVycikKPiA+
ID4gPiArICAgICAgICAgICBuZXRkZXZfZXJyKHZpLT5kZXYsICJyZXNpemUgcnggZmFpbDogcngg
cXVldWUgaW5kZXg6ICVkIGVycjogJWRcbiIsIHFpbmRleCwgZXJyKTsKPiA+ID4gPiArCj4gPiA+
ID4gKyAgIGlmICghdHJ5X2ZpbGxfcmVjdih2aSwgcnEsIEdGUF9LRVJORUwpKQo+ID4gPiA+ICsg
ICAgICAgICAgIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygmdmktPnJlZmlsbCwgMCk7Cj4gPiA+ID4g
Kwo+ID4gPiA+ICsgICB2aXJ0bmV0X25hcGlfZW5hYmxlKHJxLT52cSwgJnJxLT5uYXBpKTsKPiA+
ID4gPiArICAgcmV0dXJuIGVycjsKPiA+ID4gPiArfQo+ID4gPiA+ICsKPiA+ID4gPiAgIC8qCj4g
PiA+ID4gICAgKiBTZW5kIGNvbW1hbmQgdmlhIHRoZSBjb250cm9sIHZpcnRxdWV1ZSBhbmQgY2hl
Y2sgc3RhdHVzLiAgQ29tbWFuZHMKPiA+ID4gPiAgICAqIHN1cHBvcnRlZCBieSB0aGUgaHlwZXJ2
aXNvciwgYXMgaW5kaWNhdGVkIGJ5IGZlYXR1cmUgYml0cywgc2hvdWxkCj4gPiA+Cj4gPgo+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
