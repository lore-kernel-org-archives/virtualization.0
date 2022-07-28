Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD00C19F29
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 08:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23E1F83396;
	Thu, 28 Jul 2022 08:18:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23E1F83396
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p8WKWaQvITNG; Thu, 28 Jul 2022 08:18:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 909A3833A7;
	Thu, 28 Jul 2022 08:18:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 909A3833A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64A5AC0035;
	Thu, 28 Jul 2022 08:18:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F8A6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 08:18:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71A95606A9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 08:18:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71A95606A9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8qQZnwqQd1a7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 08:18:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8627E60608
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8627E60608
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 08:18:17 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R721e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VKefuGf_1658996289; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VKefuGf_1658996289) by smtp.aliyun-inc.com;
 Thu, 28 Jul 2022 16:18:10 +0800
Message-ID: <1658995783.1026692-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v13 16/42] virtio_ring: split: introduce
 virtqueue_resize_split()
Date: Thu, 28 Jul 2022 16:09:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-17-xuanzhuo@linux.alibaba.com>
 <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
 <1658907413.1860468-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvxsOfiiaWWAR8P68GY1yfwgTvaAbHk1JF7pTw-o2k25w@mail.gmail.com>
 <1658992162.584327-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv-KYieHKXY_Qn0nfcnLMOSF=TowF5PwLKOxESL3KQ40Q@mail.gmail.com>
In-Reply-To: <CACGkMEv-KYieHKXY_Qn0nfcnLMOSF=TowF5PwLKOxESL3KQ40Q@mail.gmail.com>
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

T24gVGh1LCAyOCBKdWwgMjAyMiAxNTo0Mjo1MCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBKdWwgMjgsIDIwMjIgYXQgMzoyNCBQTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUaHUs
IDI4IEp1bCAyMDIyIDEwOjM4OjUxICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4gT24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMzo0NCBQTSBYdWFuIFpo
dW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9u
IFdlZCwgMjcgSnVsIDIwMjIgMTE6MTI6MTkgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IOWcqCAyMDIyLzcvMjYgMTU6MjEs
IFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+ID4gPiA+IHZpcnRpbyByaW5nIHNwbGl0IHN1cHBvcnRz
IHJlc2l6ZS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gT25seSBhZnRlciB0aGUgbmV3IHZyaW5n
IGlzIHN1Y2Nlc3NmdWxseSBhbGxvY2F0ZWQgYmFzZWQgb24gdGhlIG5ldyBudW0sCj4gPiA+ID4g
PiA+IHdlIHdpbGwgcmVsZWFzZSB0aGUgb2xkIHZyaW5nLiBJbiBhbnkgY2FzZSwgYW4gZXJyb3Ig
aXMgcmV0dXJuZWQsCj4gPiA+ID4gPiA+IGluZGljYXRpbmcgdGhhdCB0aGUgdnJpbmcgc3RpbGwg
cG9pbnRzIHRvIHRoZSBvbGQgdnJpbmcuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEluIHRoZSBj
YXNlIG9mIGFuIGVycm9yLCByZS1pbml0aWFsaXplKHZpcnRxdWV1ZV9yZWluaXRfc3BsaXQoKSkg
dGhlCj4gPiA+ID4gPiA+IHZpcnRxdWV1ZSB0byBlbnN1cmUgdGhhdCB0aGUgdnJpbmcgY2FuIGJl
IHVzZWQuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8
eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+ID4gPiA+IEFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gICBk
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwo+ID4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCsp
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+ID4gPiBpbmRl
eCBiNmZkYTkxYzgwNTkuLjU4MzU1ZTFhYzdkNyAxMDA2NDQKPiA+ID4gPiA+ID4gLS0tIGEvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiA+IEBAIC0yMjAsNiArMjIwLDcgQEAgc3RhdGljIHN0
cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgs
Cj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2
b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPiA+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lKTsKPiA+
ID4gPiA+ID4gICBzdGF0aWMgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKnZyaW5nX2FsbG9jX2Rl
c2NfZXh0cmEodW5zaWduZWQgaW50IG51bSk7Cj4gPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCB2cmlu
Z19mcmVlKHN0cnVjdCB2aXJ0cXVldWUgKl92cSk7Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ICAg
LyoKPiA+ID4gPiA+ID4gICAgKiBIZWxwZXJzLgo+ID4gPiA+ID4gPiBAQCAtMTExNyw2ICsxMTE4
LDM5IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3Nw
bGl0KAo+ID4gPiA+ID4gPiAgICAgcmV0dXJuIHZxOwo+ID4gPiA+ID4gPiAgIH0KPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gK3N0YXRpYyBpbnQgdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdChzdHJ1Y3Qg
dmlydHF1ZXVlICpfdnEsIHUzMiBudW0pCj4gPiA+ID4gPiA+ICt7Cj4gPiA+ID4gPiA+ICsgICBz
dHJ1Y3QgdnJpbmdfdmlydHF1ZXVlX3NwbGl0IHZyaW5nX3NwbGl0ID0ge307Cj4gPiA+ID4gPiA+
ICsgICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gPiA+ID4g
PiArICAgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYgPSBfdnEtPnZkZXY7Cj4gPiA+ID4gPiA+
ICsgICBpbnQgZXJyOwo+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ICsgICBlcnIgPSB2cmluZ19h
bGxvY19xdWV1ZV9zcGxpdCgmdnJpbmdfc3BsaXQsIHZkZXYsIG51bSwKPiA+ID4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5zcGxpdC52cmluZ19hbGlnbiwKPiA+
ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5zcGxpdC5tYXlf
cmVkdWNlX251bSk7Cj4gPiA+ID4gPiA+ICsgICBpZiAoZXJyKQo+ID4gPiA+ID4gPiArICAgICAg
ICAgICBnb3RvIGVycjsKPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gSSB0aGluayB3ZSBk
b24ndCBuZWVkIHRvIGRvIGFueXRoaW5nIGhlcmU/Cj4gPiA+ID4KPiA+ID4gPiBBbSBJIG1pc3Np
bmcgc29tZXRoaW5nPwo+ID4gPgo+ID4gPiBJIG1lYW50IGl0IGxvb2tzIHRvIG1lIG1vc3Qgb2Yg
dGhlIHZpcnRxdWV1ZV9yZWluaXQoKSBpcyB1bm5lY2Vzc2FyeS4KPiA+ID4gV2UgcHJvYmFibHkg
b25seSBuZWVkIHRvIHJlaW5pdCBhdmFpbC91c2VkIGlkeCB0aGVyZS4KPiA+Cj4gPgo+ID4gSW4g
dGhpcyBmdW5jdGlvbiwgd2UgY2FuIGluZGVlZCByZW1vdmUgc29tZSBjb2RlLgo+ID4KPiA+ID4g
ICAgICAgc3RhdGljIHZvaWQgdmlydHF1ZXVlX3JlaW5pdF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlICp2cSkKPiA+ID4gICAgICAgewo+ID4gPiAgICAgICAgICAgICAgIGludCBzaXplLCBp
Owo+ID4gPgo+ID4gPiAgICAgICAgICAgICAgIG1lbXNldCh2cS0+c3BsaXQudnJpbmcuZGVzYywg
MCwgdnEtPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMpOwo+ID4gPgo+ID4gPiAgICAgICAgICAg
ICAgIHNpemUgPSBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQpICogdnEtPnNw
bGl0LnZyaW5nLm51bTsKPiA+ID4gICAgICAgICAgICAgICBtZW1zZXQodnEtPnNwbGl0LmRlc2Nf
c3RhdGUsIDAsIHNpemUpOwo+ID4gPgo+ID4gPiAgICAgICAgICAgICAgIHNpemUgPSBzaXplb2Yo
c3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEpICogdnEtPnNwbGl0LnZyaW5nLm51bTsKPiA+ID4gICAg
ICAgICAgICAgICBtZW1zZXQodnEtPnNwbGl0LmRlc2NfZXh0cmEsIDAsIHNpemUpOwo+ID4KPiA+
IFRoZXNlIG1lbXNldHMgY2FuIGJlIHJlbW92ZWQsIGFuZCB0aGVvcmV0aWNhbGx5IGl0IHdpbGwg
bm90IGNhdXNlIGFueQo+ID4gZXhjZXB0aW9ucy4KPgo+IFllcywgb3RoZXJ3aXNlIHdlIGhhdmUg
YnVncyBpbiBkZXRhY2hfYnVmKCkuCj4KPiA+Cj4gPiA+Cj4gPiA+Cj4gPiA+Cj4gPiA+ICAgICAg
ICAgICAgICAgZm9yIChpID0gMDsgaSA8IHZxLT5zcGxpdC52cmluZy5udW0gLSAxOyBpKyspCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICB2cS0+c3BsaXQuZGVzY19leHRyYVtpXS5uZXh0ID0g
aSArIDE7Cj4gPgo+ID4gVGhpcyBjYW4gYWxzbyBiZSByZW1vdmVkLCBidXQgd2UgbmVlZCB0byBy
ZWNvcmQgZnJlZV9oZWFkIHRoYXQgd2lsbCBiZWVuIHVwZGF0ZQo+ID4gaW5zaWRlIHZpcnRxdWV1
ZV9pbml0KCkuCj4KPiBXZSBjYW4gc2ltcGx5IGtlZXAgZnJlZV9oZWFkIHVuY2hhbmdlZD8gT3Ro
ZXJ3aXNlIGl0J3MgYSBidWcgc29tZXdoZXJlIEkgZ3Vlc3MuCj4KPgo+ID4KPiA+ID4KPiA+ID4g
ICAgICAgICAgICAgICB2aXJ0cXVldWVfaW5pdCh2cSwgdnEtPnNwbGl0LnZyaW5nLm51bSk7Cj4g
Pgo+ID4gVGhlcmUgYXJlIHNvbWUgb3BlcmF0aW9ucyBpbiB0aGlzLCB3aGljaCBjYW4gYWxzbyBi
ZSBza2lwcGVkLCBzdWNoIGFzIHNldHRpbmcKPiA+IHVzZV9kbWFfYXBpLiBCdXQgSSB0aGluayBj
YWxsaW5nIHRoaXMgZnVuY3Rpb24gZGlyZWN0bHkgd2lsbCBiZSBtb3JlIGNvbnZlbmllbnQKPiA+
IGZvciBtYWludGVuYW5jZS4KPgo+IEkgZG9uJ3Qgc2VlIGFueXRoaW5nIHRoYXQgaXMgbmVjZXNz
YXJ5IGhlcmUuCgpUaGVzZSB0aHJlZSBhcmUgY3VycmVudGx5IGluc2lkZSB2aXJ0cXVldWVfaW5p
dCgpCgp2cS0+bGFzdF91c2VkX2lkeCA9IDA7CnZxLT5ldmVudF90cmlnZ2VyZWQgPSBmYWxzZTsK
dnEtPm51bV9hZGRlZCA9IDA7CgpUaGFua3MuCgoKPgo+ID4KPiA+Cj4gPiA+ICAgICAgICAgICAg
ICAgdmlydHF1ZXVlX3ZyaW5nX2luaXRfc3BsaXQoJnZxLT5zcGxpdCwgdnEpOwo+ID4KPiA+IHZp
cnRxdWV1ZV92cmluZ19pbml0X3NwbGl0KCkgaXMgbmVjZXNzYXJ5Lgo+Cj4gUmlnaHQuCj4KPiA+
Cj4gPiA+ICAgICAgIH0KPiA+Cj4gPiBBbm90aGVyIG1ldGhvZCwgd2UgY2FuIHRha2Ugb3V0IGFs
bCB0aGUgdmFyaWFibGVzIHRvIGJlIHJlaW5pdGlhbGl6ZWQKPiA+IHNlcGFyYXRlbHksIGFuZCBy
ZXBhY2thZ2UgdGhlbSBpbnRvIGEgbmV3IGZ1bmN0aW9uLiBJIGRvbuKAmXQgdGhpbmsgaXTigJlz
IHdvcnRoCj4gPiBpdCwgYmVjYXVzZSB0aGlzIHBhdGggd2lsbCBvbmx5IGJlIHJlYWNoZWQgaWYg
dGhlIG1lbW9yeSBhbGxvY2F0aW9uIGZhaWxzLCB3aGljaAo+ID4gaXMgYSByYXJlIG9jY3VycmVu
Y2UuIEluIHRoaXMgY2FzZSwgZG9pbmcgc28gd2lsbCBpbmNyZWFzZSB0aGUgY29zdCBvZgo+ID4g
bWFpbnRlbmFuY2UuIElmIHlvdSB0aGluayBzbyBhbHNvLCBJIHdpbGwgcmVtb3ZlIHRoZSBhYm92
ZSBtZW1zZXQgaW4gdGhlIG5leHQKPiA+IHZlcnNpb24uCj4KPiBJIGFncmVlLgo+Cj4gVGhhbmtz
Cj4KPiA+Cj4gPiBUaGFua3MuCj4gPgo+ID4KPiA+ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+
ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ICsgICBlcnIg
PSB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdCgmdnJpbmdfc3BsaXQpOwo+ID4gPiA+ID4g
PiArICAgaWYgKGVycikgewo+ID4gPiA+ID4gPiArICAgICAgICAgICB2cmluZ19mcmVlX3NwbGl0
KCZ2cmluZ19zcGxpdCwgdmRldik7Cj4gPiA+ID4gPiA+ICsgICAgICAgICAgIGdvdG8gZXJyOwo+
ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJIHN1Z2dlc3QgdG8gbW92ZSB2cmluZ19mcmVl
X3NwbGl0KCkgaW50byBhIGRlZGljYXRlZCBlcnJvciBsYWJlbC4KPiA+ID4gPgo+ID4gPiA+IFdp
bGwgY2hhbmdlLgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzLgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4g
PiA+Cj4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPiArICAg
fQo+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ICsgICB2cmluZ19mcmVlKCZ2cS0+dnEpOwo+ID4g
PiA+ID4gPiArCj4gPiA+ID4gPiA+ICsgICB2aXJ0cXVldWVfdnJpbmdfaW5pdF9zcGxpdCgmdnJp
bmdfc3BsaXQsIHZxKTsKPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiArICAgdmlydHF1ZXVlX2lu
aXQodnEsIHZyaW5nX3NwbGl0LnZyaW5nLm51bSk7Cj4gPiA+ID4gPiA+ICsgICB2aXJ0cXVldWVf
dnJpbmdfYXR0YWNoX3NwbGl0KHZxLCAmdnJpbmdfc3BsaXQpOwo+ID4gPiA+ID4gPiArCj4gPiA+
ID4gPiA+ICsgICByZXR1cm4gMDsKPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiArZXJyOgo+ID4g
PiA+ID4gPiArICAgdmlydHF1ZXVlX3JlaW5pdF9zcGxpdCh2cSk7Cj4gPiA+ID4gPiA+ICsgICBy
ZXR1cm4gLUVOT01FTTsKPiA+ID4gPiA+ID4gK30KPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiAgIC8qCj4gPiA+ID4gPiA+ICAgICogUGFja2VkIHJpbmcgc3BlY2lmaWMgZnVu
Y3Rpb25zIC0gKl9wYWNrZWQoKS4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4KPiA+Cj4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
