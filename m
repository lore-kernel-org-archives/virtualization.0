Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1457EC433EF
	for <virtualization@archiver.kernel.org>; Mon, 18 Jul 2022 09:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A022F830FB;
	Mon, 18 Jul 2022 09:14:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A022F830FB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dInb3rag1Tae; Mon, 18 Jul 2022 09:14:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0F89182FA9;
	Mon, 18 Jul 2022 09:14:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F89182FA9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7E36C0033;
	Mon, 18 Jul 2022 09:14:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9182DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 09:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6AD9F415BE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 09:14:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6AD9F415BE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BzyTZjqYd4jx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 09:14:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53EC8415BC
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53EC8415BC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 09:14:35 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R811e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VJhAxgV_1658135667; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VJhAxgV_1658135667) by smtp.aliyun-inc.com;
 Mon, 18 Jul 2022 17:14:29 +0800
Message-ID: <1658135504.1522465-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 39/40] virtio_net: support tx queue resize
Date: Mon, 18 Jul 2022 17:11:44 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-40-xuanzhuo@linux.alibaba.com>
 <102d3b83-1ae9-a59a-16ce-251c22b7afb0@redhat.com>
 <1656986432.1164997-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEt8MSS=tcn=Hd6WF9+btT0ccocxEd1ighRgK-V1uiWmCQ@mail.gmail.com>
 <1657873703.9301925-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvgjX+67NxwrUym7CnbNFU2-=CbAXPN_UmtvDOTS1LrHA@mail.gmail.com>
In-Reply-To: <CACGkMEvgjX+67NxwrUym7CnbNFU2-=CbAXPN_UmtvDOTS1LrHA@mail.gmail.com>
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

T24gTW9uLCAxOCBKdWwgMjAyMiAxNjo1Nzo1MyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gRnJpLCBKdWwgMTUsIDIwMjIgYXQgNDozMiBQTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBGcmks
IDggSnVsIDIwMjIgMTQ6MjM6NTcgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPiBPbiBUdWUsIEp1bCA1LCAyMDIyIGF0IDEwOjAxIEFNIFh1YW4gWmh1
byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24g
TW9uLCA0IEp1bCAyMDIyIDExOjQ1OjUyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiDlnKggMjAyMi82LzI5IDE0OjU2LCBY
dWFuIFpodW8g5YaZ6YGTOgo+ID4gPiA+ID4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIHJl
c2l6ZSBmdW5jdGlvbiBvZiB0aGUgdHggcXVldWVzLgo+ID4gPiA+ID4gPiBCYXNlZCBvbiB0aGlz
IGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhlIHJpbmcgbnVtIG9mIHRoZQo+
ID4gPiA+ID4gPiBxdWV1ZS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
WHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+ID4gPiA+ID4gLS0tCj4g
PiA+ID4gPiA+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNDggKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0
OCBpbnNlcnRpb25zKCspCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+
ID4gaW5kZXggNmFiMTZmZDE5M2U1Li5mZDM1ODQ2MmY4MDIgMTAwNjQ0Cj4gPiA+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ID4gQEAgLTEzNSw2ICsxMzUsOSBAQCBzdHJ1Y3Qgc2Vu
ZF9xdWV1ZSB7Cj4gPiA+ID4gPiA+ICAgICBzdHJ1Y3QgdmlydG5ldF9zcV9zdGF0cyBzdGF0czsK
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gICAgIHN0cnVjdCBuYXBpX3N0cnVjdCBuYXBpOwo+ID4g
PiA+ID4gPiArCj4gPiA+ID4gPiA+ICsgICAvKiBSZWNvcmQgd2hldGhlciBzcSBpcyBpbiByZXNl
dCBzdGF0ZS4gKi8KPiA+ID4gPiA+ID4gKyAgIGJvb2wgcmVzZXQ7Cj4gPiA+ID4gPiA+ICAgfTsK
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gICAvKiBJbnRlcm5hbCByZXByZXNlbnRhdGlvbiBvZiBh
IHJlY2VpdmUgdmlydHF1ZXVlICovCj4gPiA+ID4gPiA+IEBAIC0yNzksNiArMjgyLDcgQEAgc3Ry
dWN0IHBhZGRlZF92bmV0X2hkciB7Cj4gPiA+ID4gPiA+ICAgfTsKPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gICBzdGF0aWMgdm9pZCB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3Qgdmly
dHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPiA+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIHZpcnRuZXRf
c3FfZnJlZV91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB2b2lkICpidWYpOwo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiAgIHN0YXRpYyBib29sIGlzX3hkcF9mcmFtZSh2b2lkICpwdHIp
Cj4gPiA+ID4gPiA+ICAgewo+ID4gPiA+ID4gPiBAQCAtMTYwMyw2ICsxNjA3LDExIEBAIHN0YXRp
YyB2b2lkIHZpcnRuZXRfcG9sbF9jbGVhbnR4KHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSkKPiA+
ID4gPiA+ID4gICAgICAgICAgICAgcmV0dXJuOwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAgICAg
aWYgKF9fbmV0aWZfdHhfdHJ5bG9jayh0eHEpKSB7Cj4gPiA+ID4gPiA+ICsgICAgICAgICAgIGlm
IChSRUFEX09OQ0Uoc3EtPnJlc2V0KSkgewo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
IF9fbmV0aWZfdHhfdW5sb2NrKHR4cSk7Cj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAg
cmV0dXJuOwo+ID4gPiA+ID4gPiArICAgICAgICAgICB9Cj4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+
ID4gICAgICAgICAgICAgZG8gewo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIHZpcnRx
dWV1ZV9kaXNhYmxlX2NiKHNxLT52cSk7Cj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ZnJlZV9vbGRfeG1pdF9za2JzKHNxLCB0cnVlKTsKPiA+ID4gPiA+ID4gQEAgLTE4NjgsNiArMTg3
Nyw0NSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcnhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8g
KnZpLAo+ID4gPiA+ID4gPiAgICAgcmV0dXJuIGVycjsKPiA+ID4gPiA+ID4gICB9Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ICtzdGF0aWMgaW50IHZpcnRuZXRfdHhfcmVzaXplKHN0cnVjdCB2aXJ0
bmV0X2luZm8gKnZpLAo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHNlbmRfcXVldWUgKnNxLCB1MzIgcmluZ19udW0pCj4gPiA+ID4gPiA+ICt7Cj4gPiA+ID4gPiA+
ICsgICBzdHJ1Y3QgbmV0ZGV2X3F1ZXVlICp0eHE7Cj4gPiA+ID4gPiA+ICsgICBpbnQgZXJyLCBx
aW5kZXg7Cj4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gKyAgIHFpbmRleCA9IHNxIC0gdmktPnNx
Owo+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ICsgICB2aXJ0bmV0X25hcGlfdHhfZGlzYWJsZSgm
c3EtPm5hcGkpOwo+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ICsgICB0eHEgPSBuZXRkZXZfZ2V0
X3R4X3F1ZXVlKHZpLT5kZXYsIHFpbmRleCk7Cj4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gKyAg
IC8qIDEuIHdhaXQgYWxsIHhpbXQgY29tcGxldGUKPiA+ID4gPiA+ID4gKyAgICAqIDIuIGZpeCB0
aGUgcmFjZSBvZiBuZXRpZl9zdG9wX3N1YnF1ZXVlKCkgdnMgbmV0aWZfc3RhcnRfc3VicXVldWUo
KQo+ID4gPiA+ID4gPiArICAgICovCj4gPiA+ID4gPiA+ICsgICBfX25ldGlmX3R4X2xvY2tfYmgo
dHhxKTsKPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiArICAgLyogUHJldmVudCByeCBwb2xsIGZy
b20gYWNjZXNzaW5nIHNxLiAqLwo+ID4gPiA+ID4gPiArICAgV1JJVEVfT05DRShzcS0+cmVzZXQs
IHRydWUpOwo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBDYW4gd2Ugc2ltcGx5IGRpc2Fi
bGUgUlggTkFQSSBoZXJlPwo+ID4gPiA+Cj4gPiA+ID4gRGlzYWJsZSByeCBuYXBpIGlzIGluZGVl
ZCBhIHNpbXBsZSBzb2x1dGlvbi4gQnV0IEkgaG9wZSB0aGF0IHdoZW4gZGVhbGluZyB3aXRoCj4g
PiA+ID4gdHgsIGl0IHdpbGwgbm90IGFmZmVjdCByeC4KPiA+ID4KPiA+ID4gT2ssIGJ1dCBJIHRo
aW5rIHdlJ3ZlIGFscmVhZHkgc3luY2hyb25pemVkIHdpdGggdHggbG9jayBoZXJlLCBpc24ndCBp
dD8KPiA+Cj4gPiBZZXMsIGRvIHlvdSBoYXZlIGFueSBxdWVzdGlvbnMgYWJvdXQgV1JJVEVfT05D
RSgpPyBUaGVyZSBpcyBhIHNldCBmYWxzZSBvcGVyYXRpb24KPiA+IGxhdGVyLCBJIGRpZCBub3Qg
dXNlIGxvY2sgdGhlcmUsIHNvIEkgdXNlZCBXUklURS9SRUFEX09OQ0UKPiA+IHVuaWZvcm1seS4K
Pgo+IEkgbWVhbiwgc2luY2Ugd2UndmUgYWxyZWFkeSB1c2VkIHR4IGxvY2tzIHNvbWV3aGVyZSwg
d2UnZCBiZXR0ZXIgdXNlCj4gdGhlbSBoZXJlIGFzIHdlbGwgYXQgbGVhc3QgYXMgYSBzdGFydC4K
CgpPSy4gbmV4dCB2ZXJzaW9uIHdpbGwgZml4LgoKVGhhbmtzLgoKK3N0YXRpYyBpbnQgdmlydG5l
dF90eF9yZXNpemUoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCisJCQkgICAgIHN0cnVjdCBzZW5k
X3F1ZXVlICpzcSwgdTMyIHJpbmdfbnVtKQoreworCXN0cnVjdCBuZXRkZXZfcXVldWUgKnR4cTsK
KwlpbnQgZXJyLCBxaW5kZXg7CisKKwlxaW5kZXggPSBzcSAtIHZpLT5zcTsKKworCXZpcnRuZXRf
bmFwaV90eF9kaXNhYmxlKCZzcS0+bmFwaSk7CisKKwl0eHEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVl
KHZpLT5kZXYsIHFpbmRleCk7CisKKwkvKiAxLiB3YWl0IGFsbCB4aW10IGNvbXBsZXRlCisJICog
Mi4gZml4IHRoZSByYWNlIG9mIG5ldGlmX3N0b3Bfc3VicXVldWUoKSB2cyBuZXRpZl9zdGFydF9z
dWJxdWV1ZSgpCisJICovCisJX19uZXRpZl90eF9sb2NrX2JoKHR4cSk7CisKKwlzcS0+cmVzZXQg
PSB0cnVlOworCisJLyogUHJldmVudCB0aGUgdXBwZXIgbGF5ZXIgZnJvbSB0cnlpbmcgdG8gc2Vu
ZCBwYWNrZXRzLiAqLworCW5ldGlmX3N0b3Bfc3VicXVldWUodmktPmRldiwgcWluZGV4KTsKKwor
CV9fbmV0aWZfdHhfdW5sb2NrX2JoKHR4cSk7CisKKwllcnIgPSB2aXJ0cXVldWVfcmVzaXplKHNx
LT52cSwgcmluZ19udW0sIHZpcnRuZXRfc3FfZnJlZV91bnVzZWRfYnVmKTsKKwlpZiAoZXJyKQor
CQluZXRkZXZfZXJyKHZpLT5kZXYsICJyZXNpemUgdHggZmFpbDogdHggcXVldWUgaW5kZXg6ICVk
IGVycjogJWRcbiIsIHFpbmRleCwgZXJyKTsKKworCV9fbmV0aWZfdHhfbG9ja19iaCh0eHEpOwor
CXNxLT5yZXNldCA9IGZhbHNlOworCW5ldGlmX3R4X3dha2VfcXVldWUodHhxKTsKKwlfX25ldGlm
X3R4X3VubG9ja19iaCh0eHEpOworCisJdmlydG5ldF9uYXBpX3R4X2VuYWJsZSh2aSwgc3EtPnZx
LCAmc3EtPm5hcGkpOworCXJldHVybiBlcnI7Cit9CgoKPgo+IFRoYW5rcwo+Cj4gPgo+ID4gVGhh
bmtzLgo+ID4KPiA+ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBUaGFua3Mu
Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4KPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gKyAgIC8qIFByZXZlbnQgdGhlIHVwcGVy
IGxheWVyIGZyb20gdHJ5aW5nIHRvIHNlbmQgcGFja2V0cy4gKi8KPiA+ID4gPiA+ID4gKyAgIG5l
dGlmX3N0b3Bfc3VicXVldWUodmktPmRldiwgcWluZGV4KTsKPiA+ID4gPiA+ID4gKwo+ID4gPiA+
ID4gPiArICAgX19uZXRpZl90eF91bmxvY2tfYmgodHhxKTsKPiA+ID4gPiA+ID4gKwo+ID4gPiA+
ID4gPiArICAgZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZShzcS0+dnEsIHJpbmdfbnVtLCB2aXJ0bmV0
X3NxX2ZyZWVfdW51c2VkX2J1Zik7Cj4gPiA+ID4gPiA+ICsgICBpZiAoZXJyKQo+ID4gPiA+ID4g
PiArICAgICAgICAgICBuZXRkZXZfZXJyKHZpLT5kZXYsICJyZXNpemUgdHggZmFpbDogdHggcXVl
dWUgaW5kZXg6ICVkIGVycjogJWRcbiIsIHFpbmRleCwgZXJyKTsKPiA+ID4gPiA+ID4gKwo+ID4g
PiA+ID4gPiArICAgLyogTWVtb3J5IGJhcnJpZXIgYmVmb3JlIHNldCByZXNldCBhbmQgc3RhcnQg
c3VicXVldWUuICovCj4gPiA+ID4gPiA+ICsgICBzbXBfbWIoKTsKPiA+ID4gPiA+ID4gKwo+ID4g
PiA+ID4gPiArICAgV1JJVEVfT05DRShzcS0+cmVzZXQsIGZhbHNlKTsKPiA+ID4gPiA+ID4gKyAg
IG5ldGlmX3R4X3dha2VfcXVldWUodHhxKTsKPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiArICAg
dmlydG5ldF9uYXBpX3R4X2VuYWJsZSh2aSwgc3EtPnZxLCAmc3EtPm5hcGkpOwo+ID4gPiA+ID4g
PiArICAgcmV0dXJuIGVycjsKPiA+ID4gPiA+ID4gK30KPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4g
PiAgIC8qCj4gPiA+ID4gPiA+ICAgICogU2VuZCBjb21tYW5kIHZpYSB0aGUgY29udHJvbCB2aXJ0
cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4gPiA+ID4gPiA+ICAgICogc3VwcG9y
dGVkIGJ5IHRoZSBoeXBlcnZpc29yLCBhcyBpbmRpY2F0ZWQgYnkgZmVhdHVyZSBiaXRzLCBzaG91
bGQKPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4KPiA+Cj4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
