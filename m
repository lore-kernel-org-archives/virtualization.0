Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EFBC25B07
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 11:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E704F4194A;
	Thu, 28 Jul 2022 11:27:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E704F4194A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4HwOLnfKyB7e; Thu, 28 Jul 2022 11:27:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CAE734193E;
	Thu, 28 Jul 2022 11:27:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CAE734193E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8A04C0033;
	Thu, 28 Jul 2022 11:27:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 593C5C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 11:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 119BB40A49
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 11:27:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 119BB40A49
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CZneF0uPeV_E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 11:27:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF4C24010C
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF4C24010C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 11:27:45 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VKfSKFm_1659007656; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VKfSKFm_1659007656) by smtp.aliyun-inc.com;
 Thu, 28 Jul 2022 19:27:37 +0800
Message-ID: <1659001321.5738833-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v13 16/42] virtio_ring: split: introduce
 virtqueue_resize_split()
Date: Thu, 28 Jul 2022 17:42:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-17-xuanzhuo@linux.alibaba.com>
 <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
 <1658907413.1860468-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvxsOfiiaWWAR8P68GY1yfwgTvaAbHk1JF7pTw-o2k25w@mail.gmail.com>
 <1658992162.584327-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv-KYieHKXY_Qn0nfcnLMOSF=TowF5PwLKOxESL3KQ40Q@mail.gmail.com>
 <1658995783.1026692-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv6Ptn4zj_F-ww3Nay-VPmCNrXLaf5U98PvupAvo44FpA@mail.gmail.com>
In-Reply-To: <CACGkMEv6Ptn4zj_F-ww3Nay-VPmCNrXLaf5U98PvupAvo44FpA@mail.gmail.com>
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

T24gVGh1LCAyOCBKdWwgMjAyMiAxNzowNDozNiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBKdWwgMjgsIDIwMjIgYXQgNDoxOCBQTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUaHUs
IDI4IEp1bCAyMDIyIDE1OjQyOjUwICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4gT24gVGh1LCBKdWwgMjgsIDIwMjIgYXQgMzoyNCBQTSBYdWFuIFpo
dW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9u
IFRodSwgMjggSnVsIDIwMjIgMTA6Mzg6NTEgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gT24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMzo0NCBQ
TSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gT24gV2VkLCAyNyBKdWwgMjAyMiAxMToxMjoxOSArMDgwMCwgSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiDlnKggMjAyMi83LzI2IDE1OjIxLCBYdWFuIFpodW8g5YaZ6YGTOgo+ID4gPiA+ID4gPiA+
ID4gdmlydGlvIHJpbmcgc3BsaXQgc3VwcG9ydHMgcmVzaXplLgo+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+IE9ubHkgYWZ0ZXIgdGhlIG5ldyB2cmluZyBpcyBzdWNjZXNzZnVsbHkgYWxs
b2NhdGVkIGJhc2VkIG9uIHRoZSBuZXcgbnVtLAo+ID4gPiA+ID4gPiA+ID4gd2Ugd2lsbCByZWxl
YXNlIHRoZSBvbGQgdnJpbmcuIEluIGFueSBjYXNlLCBhbiBlcnJvciBpcyByZXR1cm5lZCwKPiA+
ID4gPiA+ID4gPiA+IGluZGljYXRpbmcgdGhhdCB0aGUgdnJpbmcgc3RpbGwgcG9pbnRzIHRvIHRo
ZSBvbGQgdnJpbmcuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gSW4gdGhlIGNhc2Ug
b2YgYW4gZXJyb3IsIHJlLWluaXRpYWxpemUodmlydHF1ZXVlX3JlaW5pdF9zcGxpdCgpKSB0aGUK
PiA+ID4gPiA+ID4gPiA+IHZpcnRxdWV1ZSB0byBlbnN1cmUgdGhhdCB0aGUgdnJpbmcgY2FuIGJl
IHVzZWQuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+ID4gPiA+ID4gPiA+IEFja2Vk
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+ID4gLS0t
Cj4gPiA+ID4gPiA+ID4gPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAzNCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiA+ID4gPiA+ID4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiA+ID4gPiBpbmRleCBiNmZkYTkxYzgwNTkuLjU4MzU1
ZTFhYzdkNyAxMDA2NDQKPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPiA+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMKPiA+ID4gPiA+ID4gPiA+IEBAIC0yMjAsNiArMjIwLDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0
cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiA+ID4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAo
KmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUpOwo+ID4g
PiA+ID4gPiA+ID4gICBzdGF0aWMgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKnZyaW5nX2FsbG9j
X2Rlc2NfZXh0cmEodW5zaWduZWQgaW50IG51bSk7Cj4gPiA+ID4gPiA+ID4gPiArc3RhdGljIHZv
aWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpOwo+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ICAgLyoKPiA+ID4gPiA+ID4gPiA+ICAgICogSGVscGVycy4KPiA+ID4gPiA+
ID4gPiA+IEBAIC0xMTE3LDYgKzExMTgsMzkgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZy
aW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4gPiA+ID4gPiA+ID4gPiAgICAgcmV0dXJuIHZx
Owo+ID4gPiA+ID4gPiA+ID4gICB9Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gK3N0
YXRpYyBpbnQgdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsIHUz
MiBudW0pCj4gPiA+ID4gPiA+ID4gPiArewo+ID4gPiA+ID4gPiA+ID4gKyAgIHN0cnVjdCB2cmlu
Z192aXJ0cXVldWVfc3BsaXQgdnJpbmdfc3BsaXQgPSB7fTsKPiA+ID4gPiA+ID4gPiA+ICsgICBz
dHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gPiA+ID4gPiA+ID4g
KyAgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0gX3ZxLT52ZGV2Owo+ID4gPiA+ID4gPiA+
ID4gKyAgIGludCBlcnI7Cj4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiArICAgZXJy
ID0gdnJpbmdfYWxsb2NfcXVldWVfc3BsaXQoJnZyaW5nX3NwbGl0LCB2ZGV2LCBudW0sCj4gPiA+
ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnEtPnNwbGl0LnZy
aW5nX2FsaWduLAo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHZxLT5zcGxpdC5tYXlfcmVkdWNlX251bSk7Cj4gPiA+ID4gPiA+ID4gPiArICAgaWYgKGVy
cikKPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgIGdvdG8gZXJyOwo+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJIHRoaW5rIHdlIGRvbid0IG5lZWQgdG8gZG8gYW55
dGhpbmcgaGVyZT8KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gQW0gSSBtaXNzaW5nIHNvbWV0aGlu
Zz8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJIG1lYW50IGl0IGxvb2tzIHRvIG1lIG1vc3Qgb2YgdGhl
IHZpcnRxdWV1ZV9yZWluaXQoKSBpcyB1bm5lY2Vzc2FyeS4KPiA+ID4gPiA+IFdlIHByb2JhYmx5
IG9ubHkgbmVlZCB0byByZWluaXQgYXZhaWwvdXNlZCBpZHggdGhlcmUuCj4gPiA+ID4KPiA+ID4g
Pgo+ID4gPiA+IEluIHRoaXMgZnVuY3Rpb24sIHdlIGNhbiBpbmRlZWQgcmVtb3ZlIHNvbWUgY29k
ZS4KPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgc3RhdGljIHZvaWQgdmlydHF1ZXVlX3JlaW5pdF9z
cGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSkKPiA+ID4gPiA+ICAgICAgIHsKPiA+ID4g
PiA+ICAgICAgICAgICAgICAgaW50IHNpemUsIGk7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gICAgICAg
ICAgICAgICBtZW1zZXQodnEtPnNwbGl0LnZyaW5nLmRlc2MsIDAsIHZxLT5zcGxpdC5xdWV1ZV9z
aXplX2luX2J5dGVzKTsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgICAgICAgIHNpemUgPSBz
aXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQpICogdnEtPnNwbGl0LnZyaW5nLm51
bTsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgbWVtc2V0KHZxLT5zcGxpdC5kZXNjX3N0YXRlLCAw
LCBzaXplKTsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgICAgICAgIHNpemUgPSBzaXplb2Yo
c3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEpICogdnEtPnNwbGl0LnZyaW5nLm51bTsKPiA+ID4gPiA+
ICAgICAgICAgICAgICAgbWVtc2V0KHZxLT5zcGxpdC5kZXNjX2V4dHJhLCAwLCBzaXplKTsKPiA+
ID4gPgo+ID4gPiA+IFRoZXNlIG1lbXNldHMgY2FuIGJlIHJlbW92ZWQsIGFuZCB0aGVvcmV0aWNh
bGx5IGl0IHdpbGwgbm90IGNhdXNlIGFueQo+ID4gPiA+IGV4Y2VwdGlvbnMuCj4gPiA+Cj4gPiA+
IFllcywgb3RoZXJ3aXNlIHdlIGhhdmUgYnVncyBpbiBkZXRhY2hfYnVmKCkuCj4gPiA+Cj4gPiA+
ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+ICAgICAgICAgICAgICAg
Zm9yIChpID0gMDsgaSA8IHZxLT5zcGxpdC52cmluZy5udW0gLSAxOyBpKyspCj4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgdnEtPnNwbGl0LmRlc2NfZXh0cmFbaV0ubmV4dCA9IGkgKyAx
Owo+ID4gPiA+Cj4gPiA+ID4gVGhpcyBjYW4gYWxzbyBiZSByZW1vdmVkLCBidXQgd2UgbmVlZCB0
byByZWNvcmQgZnJlZV9oZWFkIHRoYXQgd2lsbCBiZWVuIHVwZGF0ZQo+ID4gPiA+IGluc2lkZSB2
aXJ0cXVldWVfaW5pdCgpLgo+ID4gPgo+ID4gPiBXZSBjYW4gc2ltcGx5IGtlZXAgZnJlZV9oZWFk
IHVuY2hhbmdlZD8gT3RoZXJ3aXNlIGl0J3MgYSBidWcgc29tZXdoZXJlIEkgZ3Vlc3MuCj4gPiA+
Cj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgICAgICAgIHZpcnRxdWV1
ZV9pbml0KHZxLCB2cS0+c3BsaXQudnJpbmcubnVtKTsKPiA+ID4gPgo+ID4gPiA+IFRoZXJlIGFy
ZSBzb21lIG9wZXJhdGlvbnMgaW4gdGhpcywgd2hpY2ggY2FuIGFsc28gYmUgc2tpcHBlZCwgc3Vj
aCBhcyBzZXR0aW5nCj4gPiA+ID4gdXNlX2RtYV9hcGkuIEJ1dCBJIHRoaW5rIGNhbGxpbmcgdGhp
cyBmdW5jdGlvbiBkaXJlY3RseSB3aWxsIGJlIG1vcmUgY29udmVuaWVudAo+ID4gPiA+IGZvciBt
YWludGVuYW5jZS4KPiA+ID4KPiA+ID4gSSBkb24ndCBzZWUgYW55dGhpbmcgdGhhdCBpcyBuZWNl
c3NhcnkgaGVyZS4KPiA+Cj4gPiBUaGVzZSB0aHJlZSBhcmUgY3VycmVudGx5IGluc2lkZSB2aXJ0
cXVldWVfaW5pdCgpCj4gPgo+ID4gdnEtPmxhc3RfdXNlZF9pZHggPSAwOwo+ID4gdnEtPmV2ZW50
X3RyaWdnZXJlZCA9IGZhbHNlOwo+ID4gdnEtPm51bV9hZGRlZCA9IDA7Cj4KPiBSaWdodC4gTGV0
J3Mga2VlcCBpdCB0aGVyZS4KPgo+IChUaG91Z2ggaXQncyBraW5kIG9mIHN0cmFuZ2UgdGhhdCB0
aGUgbGFzdF91c2VkX2lkeCBpcyBub3QgaW5pdGlhbGl6ZWQKPiBhdCB0aGUgc2FtZSBwbGFjZSB3
aXRoIGF2YWlsX2lkeC9mbGFnc19zaGFkb3csIHdlIGNhbiBvcHRpbWl6ZSBpdCBvbgo+IHRvcCku
CgpJIHB1dCBmcmVlX2hlYWQgPSAwIGluIHRoZSBhdHRhY2ggZnVuY3Rpb24sIGl0IGlzIG9ubHkg
bmVjZXNzYXJ5IHRvIHNldApmcmVlX2hlYWQgPSAwIHdoZW4gYSBuZXcgc3RhdGUvZXh0cmEgaXMg
YXR0YWNoZWQuCgpJbiB0aGlzIHdheSwgd2hlbiB3ZSBjYWxsIHZpcnRxdWV1ZV9pbml0KCksIHdl
IGRvbid0IGhhdmUgdG8gd29ycnkgYWJvdXQKZnJlZV9oZWFkIGJlaW5nIG1vZGlmaWVkLgoKUmV0
aGlua2luZyB0aGlzIHByb2JsZW0sIEkgdGhpbmsgdmlydHF1ZXVlX2luaXQoKSBjYW4gYmUgcmV3
cml0dGVuIGFuZCBzb21lCnZhcmlhYmxlcyB0aGF0IHdpbGwgbm90IGNoYW5nZSBhcmUgcmVtb3Zl
ZCBmcm9tIGl0LiAodXNlX2RtYV9hcGksIGV2ZW50LAp3ZWFrX2JhcnJpZXJzKQoKK3N0YXRpYyB2
b2lkIHZpcnRxdWV1ZV9pbml0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLCB1MzIgbnVtKQor
eworICAgICAgIHZxLT52cS5udW1fZnJlZSA9IG51bTsKKworICAgICAgIGlmICh2cS0+cGFja2Vk
X3JpbmcpCisgICAgICAgICAgICAgICB2cS0+bGFzdF91c2VkX2lkeCA9IDAgfCAoMSA8PCBWUklO
R19QQUNLRURfRVZFTlRfRl9XUkFQX0NUUik7CisgICAgICAgZWxzZQorICAgICAgICAgICAgICAg
dnEtPmxhc3RfdXNlZF9pZHggPSAwOworCisgICAgICAgdnEtPmV2ZW50X3RyaWdnZXJlZCA9IGZh
bHNlOworICAgICAgIHZxLT5udW1fYWRkZWQgPSAwOworCisjaWZkZWYgREVCVUcKKyAgICAgICB2
cS0+aW5fdXNlID0gZmFsc2U7CisgICAgICAgdnEtPmxhc3RfYWRkX3RpbWVfdmFsaWQgPSBmYWxz
ZTsKKyNlbmRpZgorfQorCgpUaGFua3MuCgoKPgo+IFRoYW5rcwo+Cj4gPgo+ID4gVGhhbmtzLgo+
ID4KPiA+Cj4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICAgICAgICB2aXJ0
cXVldWVfdnJpbmdfaW5pdF9zcGxpdCgmdnEtPnNwbGl0LCB2cSk7Cj4gPiA+ID4KPiA+ID4gPiB2
aXJ0cXVldWVfdnJpbmdfaW5pdF9zcGxpdCgpIGlzIG5lY2Vzc2FyeS4KPiA+ID4KPiA+ID4gUmln
aHQuCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ICAgICAgIH0KPiA+ID4gPgo+ID4gPiA+IEFub3Ro
ZXIgbWV0aG9kLCB3ZSBjYW4gdGFrZSBvdXQgYWxsIHRoZSB2YXJpYWJsZXMgdG8gYmUgcmVpbml0
aWFsaXplZAo+ID4gPiA+IHNlcGFyYXRlbHksIGFuZCByZXBhY2thZ2UgdGhlbSBpbnRvIGEgbmV3
IGZ1bmN0aW9uLiBJIGRvbuKAmXQgdGhpbmsgaXTigJlzIHdvcnRoCj4gPiA+ID4gaXQsIGJlY2F1
c2UgdGhpcyBwYXRoIHdpbGwgb25seSBiZSByZWFjaGVkIGlmIHRoZSBtZW1vcnkgYWxsb2NhdGlv
biBmYWlscywgd2hpY2gKPiA+ID4gPiBpcyBhIHJhcmUgb2NjdXJyZW5jZS4gSW4gdGhpcyBjYXNl
LCBkb2luZyBzbyB3aWxsIGluY3JlYXNlIHRoZSBjb3N0IG9mCj4gPiA+ID4gbWFpbnRlbmFuY2Uu
IElmIHlvdSB0aGluayBzbyBhbHNvLCBJIHdpbGwgcmVtb3ZlIHRoZSBhYm92ZSBtZW1zZXQgaW4g
dGhlIG5leHQKPiA+ID4gPiB2ZXJzaW9uLgo+ID4gPgo+ID4gPiBJIGFncmVlLgo+ID4gPgo+ID4g
PiBUaGFua3MKPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcy4KPiA+ID4gPgo+ID4gPiA+Cj4g
PiA+ID4gPgo+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiA+ICsgICBl
cnIgPSB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdCgmdnJpbmdfc3BsaXQpOwo+ID4gPiA+
ID4gPiA+ID4gKyAgIGlmIChlcnIpIHsKPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgIHZyaW5n
X2ZyZWVfc3BsaXQoJnZyaW5nX3NwbGl0LCB2ZGV2KTsKPiA+ID4gPiA+ID4gPiA+ICsgICAgICAg
ICAgIGdvdG8gZXJyOwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJ
IHN1Z2dlc3QgdG8gbW92ZSB2cmluZ19mcmVlX3NwbGl0KCkgaW50byBhIGRlZGljYXRlZCBlcnJv
ciBsYWJlbC4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gV2lsbCBjaGFuZ2UuCj4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+IFRoYW5rcy4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+ICsgICB9Cj4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiArICAgdnJp
bmdfZnJlZSgmdnEtPnZxKTsKPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiA+ICsgICB2
aXJ0cXVldWVfdnJpbmdfaW5pdF9zcGxpdCgmdnJpbmdfc3BsaXQsIHZxKTsKPiA+ID4gPiA+ID4g
PiA+ICsKPiA+ID4gPiA+ID4gPiA+ICsgICB2aXJ0cXVldWVfaW5pdCh2cSwgdnJpbmdfc3BsaXQu
dnJpbmcubnVtKTsKPiA+ID4gPiA+ID4gPiA+ICsgICB2aXJ0cXVldWVfdnJpbmdfYXR0YWNoX3Nw
bGl0KHZxLCAmdnJpbmdfc3BsaXQpOwo+ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4g
KyAgIHJldHVybiAwOwo+ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gK2VycjoKPiA+
ID4gPiA+ID4gPiA+ICsgICB2aXJ0cXVldWVfcmVpbml0X3NwbGl0KHZxKTsKPiA+ID4gPiA+ID4g
PiA+ICsgICByZXR1cm4gLUVOT01FTTsKPiA+ID4gPiA+ID4gPiA+ICt9Cj4gPiA+ID4gPiA+ID4g
PiArCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gICAvKgo+ID4gPiA+ID4gPiA+ID4g
ICAgKiBQYWNrZWQgcmluZyBzcGVjaWZpYyBmdW5jdGlvbnMgLSAqX3BhY2tlZCgpLgo+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+Cj4gPgo+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
