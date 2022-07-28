Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BA1C04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 07:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BF9F832D8;
	Thu, 28 Jul 2022 07:24:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BF9F832D8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1aFdfvpssLER; Thu, 28 Jul 2022 07:24:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8CE2D82CA5;
	Thu, 28 Jul 2022 07:24:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CE2D82CA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63C1AC0033;
	Thu, 28 Jul 2022 07:24:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF59AC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9820040B47
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:24:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9820040B47
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X5P-VzouPCsp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:24:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C21A240136
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C21A240136
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:24:52 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VKeO8TX_1658993082; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VKeO8TX_1658993082) by smtp.aliyun-inc.com;
 Thu, 28 Jul 2022 15:24:44 +0800
Message-ID: <1658992162.584327-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v13 16/42] virtio_ring: split: introduce
 virtqueue_resize_split()
Date: Thu, 28 Jul 2022 15:09:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-17-xuanzhuo@linux.alibaba.com>
 <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
 <1658907413.1860468-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvxsOfiiaWWAR8P68GY1yfwgTvaAbHk1JF7pTw-o2k25w@mail.gmail.com>
In-Reply-To: <CACGkMEvxsOfiiaWWAR8P68GY1yfwgTvaAbHk1JF7pTw-o2k25w@mail.gmail.com>
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

T24gVGh1LCAyOCBKdWwgMjAyMiAxMDozODo1MSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMzo0NCBQTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBXZWQs
IDI3IEp1bCAyMDIyIDExOjEyOjE5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4g5ZyoIDIwMjIvNy8yNiAxNToyMSwgWHVhbiBaaHVvIOWG
memBkzoKPiA+ID4gPiB2aXJ0aW8gcmluZyBzcGxpdCBzdXBwb3J0cyByZXNpemUuCj4gPiA+ID4K
PiA+ID4gPiBPbmx5IGFmdGVyIHRoZSBuZXcgdnJpbmcgaXMgc3VjY2Vzc2Z1bGx5IGFsbG9jYXRl
ZCBiYXNlZCBvbiB0aGUgbmV3IG51bSwKPiA+ID4gPiB3ZSB3aWxsIHJlbGVhc2UgdGhlIG9sZCB2
cmluZy4gSW4gYW55IGNhc2UsIGFuIGVycm9yIGlzIHJldHVybmVkLAo+ID4gPiA+IGluZGljYXRp
bmcgdGhhdCB0aGUgdnJpbmcgc3RpbGwgcG9pbnRzIHRvIHRoZSBvbGQgdnJpbmcuCj4gPiA+ID4K
PiA+ID4gPiBJbiB0aGUgY2FzZSBvZiBhbiBlcnJvciwgcmUtaW5pdGlhbGl6ZSh2aXJ0cXVldWVf
cmVpbml0X3NwbGl0KCkpIHRoZQo+ID4gPiA+IHZpcnRxdWV1ZSB0byBlbnN1cmUgdGhhdCB0aGUg
dnJpbmcgY2FuIGJlIHVzZWQuCj4gPiA+ID4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpo
dW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gPiA+IEFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+ICAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspCj4gPiA+ID4KPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gPiBpbmRleCBiNmZkYTkxYzgwNTkuLjU4MzU1ZTFh
YzdkNyAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4g
PiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+IEBAIC0yMjAs
NiArMjIwLDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1
ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hh
ciAqbmFtZSk7Cj4gPiA+ID4gICBzdGF0aWMgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKnZyaW5n
X2FsbG9jX2Rlc2NfZXh0cmEodW5zaWduZWQgaW50IG51bSk7Cj4gPiA+ID4gK3N0YXRpYyB2b2lk
IHZyaW5nX2ZyZWUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKTsKPiA+ID4gPgo+ID4gPiA+ICAgLyoK
PiA+ID4gPiAgICAqIEhlbHBlcnMuCj4gPiA+ID4gQEAgLTExMTcsNiArMTExOCwzOSBAQCBzdGF0
aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+ID4g
PiAgICAgcmV0dXJuIHZxOwo+ID4gPiA+ICAgfQo+ID4gPiA+Cj4gPiA+ID4gK3N0YXRpYyBpbnQg
dmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBudW0pCj4g
PiA+ID4gK3sKPiA+ID4gPiArICAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCB2cmluZ19z
cGxpdCA9IHt9Owo+ID4gPiA+ICsgICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2
cShfdnEpOwo+ID4gPiA+ICsgICBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiA9IF92cS0+dmRl
djsKPiA+ID4gPiArICAgaW50IGVycjsKPiA+ID4gPiArCj4gPiA+ID4gKyAgIGVyciA9IHZyaW5n
X2FsbG9jX3F1ZXVlX3NwbGl0KCZ2cmluZ19zcGxpdCwgdmRldiwgbnVtLAo+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2cS0+c3BsaXQudnJpbmdfYWxpZ24sCj4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5zcGxpdC5tYXlfcmVkdWNl
X251bSk7Cj4gPiA+ID4gKyAgIGlmIChlcnIpCj4gPiA+ID4gKyAgICAgICAgICAgZ290byBlcnI7
Cj4gPiA+Cj4gPiA+Cj4gPiA+IEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0byBkbyBhbnl0aGluZyBo
ZXJlPwo+ID4KPiA+IEFtIEkgbWlzc2luZyBzb21ldGhpbmc/Cj4KPiBJIG1lYW50IGl0IGxvb2tz
IHRvIG1lIG1vc3Qgb2YgdGhlIHZpcnRxdWV1ZV9yZWluaXQoKSBpcyB1bm5lY2Vzc2FyeS4KPiBX
ZSBwcm9iYWJseSBvbmx5IG5lZWQgdG8gcmVpbml0IGF2YWlsL3VzZWQgaWR4IHRoZXJlLgoKCklu
IHRoaXMgZnVuY3Rpb24sIHdlIGNhbiBpbmRlZWQgcmVtb3ZlIHNvbWUgY29kZS4KCj4Jc3RhdGlj
IHZvaWQgdmlydHF1ZXVlX3JlaW5pdF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSkK
Pgl7Cj4JCWludCBzaXplLCBpOwo+Cj4JCW1lbXNldCh2cS0+c3BsaXQudnJpbmcuZGVzYywgMCwg
dnEtPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMpOwo+Cj4JCXNpemUgPSBzaXplb2Yoc3RydWN0
IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQpICogdnEtPnNwbGl0LnZyaW5nLm51bTsKPgkJbWVtc2V0
KHZxLT5zcGxpdC5kZXNjX3N0YXRlLCAwLCBzaXplKTsKPgo+CQlzaXplID0gc2l6ZW9mKHN0cnVj
dCB2cmluZ19kZXNjX2V4dHJhKSAqIHZxLT5zcGxpdC52cmluZy5udW07Cj4JCW1lbXNldCh2cS0+
c3BsaXQuZGVzY19leHRyYSwgMCwgc2l6ZSk7CgpUaGVzZSBtZW1zZXRzIGNhbiBiZSByZW1vdmVk
LCBhbmQgdGhlb3JldGljYWxseSBpdCB3aWxsIG5vdCBjYXVzZSBhbnkKZXhjZXB0aW9ucy4KCj4K
Pgo+Cj4JCWZvciAoaSA9IDA7IGkgPCB2cS0+c3BsaXQudnJpbmcubnVtIC0gMTsgaSsrKQo+CQkJ
dnEtPnNwbGl0LmRlc2NfZXh0cmFbaV0ubmV4dCA9IGkgKyAxOwoKVGhpcyBjYW4gYWxzbyBiZSBy
ZW1vdmVkLCBidXQgd2UgbmVlZCB0byByZWNvcmQgZnJlZV9oZWFkIHRoYXQgd2lsbCBiZWVuIHVw
ZGF0ZQppbnNpZGUgdmlydHF1ZXVlX2luaXQoKS4KCj4KPgkJdmlydHF1ZXVlX2luaXQodnEsIHZx
LT5zcGxpdC52cmluZy5udW0pOwoKVGhlcmUgYXJlIHNvbWUgb3BlcmF0aW9ucyBpbiB0aGlzLCB3
aGljaCBjYW4gYWxzbyBiZSBza2lwcGVkLCBzdWNoIGFzIHNldHRpbmcKdXNlX2RtYV9hcGkuIEJ1
dCBJIHRoaW5rIGNhbGxpbmcgdGhpcyBmdW5jdGlvbiBkaXJlY3RseSB3aWxsIGJlIG1vcmUgY29u
dmVuaWVudApmb3IgbWFpbnRlbmFuY2UuCgoKPgkJdmlydHF1ZXVlX3ZyaW5nX2luaXRfc3BsaXQo
JnZxLT5zcGxpdCwgdnEpOwoKdmlydHF1ZXVlX3ZyaW5nX2luaXRfc3BsaXQoKSBpcyBuZWNlc3Nh
cnkuCgo+CX0KCkFub3RoZXIgbWV0aG9kLCB3ZSBjYW4gdGFrZSBvdXQgYWxsIHRoZSB2YXJpYWJs
ZXMgdG8gYmUgcmVpbml0aWFsaXplZApzZXBhcmF0ZWx5LCBhbmQgcmVwYWNrYWdlIHRoZW0gaW50
byBhIG5ldyBmdW5jdGlvbi4gSSBkb27igJl0IHRoaW5rIGl04oCZcyB3b3J0aAppdCwgYmVjYXVz
ZSB0aGlzIHBhdGggd2lsbCBvbmx5IGJlIHJlYWNoZWQgaWYgdGhlIG1lbW9yeSBhbGxvY2F0aW9u
IGZhaWxzLCB3aGljaAppcyBhIHJhcmUgb2NjdXJyZW5jZS4gSW4gdGhpcyBjYXNlLCBkb2luZyBz
byB3aWxsIGluY3JlYXNlIHRoZSBjb3N0IG9mCm1haW50ZW5hbmNlLiBJZiB5b3UgdGhpbmsgc28g
YWxzbywgSSB3aWxsIHJlbW92ZSB0aGUgYWJvdmUgbWVtc2V0IGluIHRoZSBuZXh0CnZlcnNpb24u
CgpUaGFua3MuCgoKPgo+IFRoYW5rcwo+Cj4gPgo+ID4gPgo+ID4gPgo+ID4gPiA+ICsKPiA+ID4g
PiArICAgZXJyID0gdnJpbmdfYWxsb2Nfc3RhdGVfZXh0cmFfc3BsaXQoJnZyaW5nX3NwbGl0KTsK
PiA+ID4gPiArICAgaWYgKGVycikgewo+ID4gPiA+ICsgICAgICAgICAgIHZyaW5nX2ZyZWVfc3Bs
aXQoJnZyaW5nX3NwbGl0LCB2ZGV2KTsKPiA+ID4gPiArICAgICAgICAgICBnb3RvIGVycjsKPiA+
ID4KPiA+ID4KPiA+ID4gSSBzdWdnZXN0IHRvIG1vdmUgdnJpbmdfZnJlZV9zcGxpdCgpIGludG8g
YSBkZWRpY2F0ZWQgZXJyb3IgbGFiZWwuCj4gPgo+ID4gV2lsbCBjaGFuZ2UuCj4gPgo+ID4gVGhh
bmtzLgo+ID4KPiA+Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4gPgo+ID4gPgo+ID4gPiA+ICsgICB9
Cj4gPiA+ID4gKwo+ID4gPiA+ICsgICB2cmluZ19mcmVlKCZ2cS0+dnEpOwo+ID4gPiA+ICsKPiA+
ID4gPiArICAgdmlydHF1ZXVlX3ZyaW5nX2luaXRfc3BsaXQoJnZyaW5nX3NwbGl0LCB2cSk7Cj4g
PiA+ID4gKwo+ID4gPiA+ICsgICB2aXJ0cXVldWVfaW5pdCh2cSwgdnJpbmdfc3BsaXQudnJpbmcu
bnVtKTsKPiA+ID4gPiArICAgdmlydHF1ZXVlX3ZyaW5nX2F0dGFjaF9zcGxpdCh2cSwgJnZyaW5n
X3NwbGl0KTsKPiA+ID4gPiArCj4gPiA+ID4gKyAgIHJldHVybiAwOwo+ID4gPiA+ICsKPiA+ID4g
PiArZXJyOgo+ID4gPiA+ICsgICB2aXJ0cXVldWVfcmVpbml0X3NwbGl0KHZxKTsKPiA+ID4gPiAr
ICAgcmV0dXJuIC1FTk9NRU07Cj4gPiA+ID4gK30KPiA+ID4gPiArCj4gPiA+ID4KPiA+ID4gPiAg
IC8qCj4gPiA+ID4gICAgKiBQYWNrZWQgcmluZyBzcGVjaWZpYyBmdW5jdGlvbnMgLSAqX3BhY2tl
ZCgpLgo+ID4gPgo+ID4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
