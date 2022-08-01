Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45B4C00144
	for <virtualization@archiver.kernel.org>; Mon,  1 Aug 2022 06:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B84E4199F;
	Mon,  1 Aug 2022 06:13:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B84E4199F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KYltCovNP3Px; Mon,  1 Aug 2022 06:13:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2115941992;
	Mon,  1 Aug 2022 06:13:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2115941992
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE79CC0032;
	Mon,  1 Aug 2022 06:13:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EB76C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BECD80E3F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:13:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BECD80E3F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fuJVjg6XROOX
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:13:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DAE7B8239A
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DAE7B8239A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:13:24 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R281e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VL1bvjS_1659334393; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VL1bvjS_1659334393) by smtp.aliyun-inc.com;
 Mon, 01 Aug 2022 14:13:15 +0800
Message-ID: <1659334300.4209104-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v13 16/42] virtio_ring: split: introduce
 virtqueue_resize_split()
Date: Mon, 1 Aug 2022 14:11:40 +0800
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
 <1659001321.5738833-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvcRxbqJ01sjC50muW3cQJiJKUJW+67QrsOP662FCgi0g@mail.gmail.com>
In-Reply-To: <CACGkMEvcRxbqJ01sjC50muW3cQJiJKUJW+67QrsOP662FCgi0g@mail.gmail.com>
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

T24gTW9uLCAxIEF1ZyAyMDIyIDEyOjQ5OjEyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiBPbiBUaHUsIEp1bCAyOCwgMjAyMiBhdCA3OjI3IFBNIFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFRodSwg
MjggSnVsIDIwMjIgMTc6MDQ6MzYgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPiBPbiBUaHUsIEp1bCAyOCwgMjAyMiBhdCA0OjE4IFBNIFh1YW4gWmh1
byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24g
VGh1LCAyOCBKdWwgMjAyMiAxNTo0Mjo1MCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiBPbiBUaHUsIEp1bCAyOCwgMjAyMiBhdCAzOjI0IFBN
IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiBPbiBUaHUsIDI4IEp1bCAyMDIyIDEwOjM4OjUxICswODAwLCBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBXZWQsIEp1
bCAyNywgMjAyMiBhdCAzOjQ0IFBNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IE9uIFdlZCwgMjcgSnVs
IDIwMjIgMTE6MTI6MTkgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiDlnKggMjAyMi83LzI2IDE1
OjIxLCBYdWFuIFpodW8g5YaZ6YGTOgo+ID4gPiA+ID4gPiA+ID4gPiA+IHZpcnRpbyByaW5nIHNw
bGl0IHN1cHBvcnRzIHJlc2l6ZS4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiA+IE9ubHkgYWZ0ZXIgdGhlIG5ldyB2cmluZyBpcyBzdWNjZXNzZnVsbHkgYWxsb2NhdGVkIGJh
c2VkIG9uIHRoZSBuZXcgbnVtLAo+ID4gPiA+ID4gPiA+ID4gPiA+IHdlIHdpbGwgcmVsZWFzZSB0
aGUgb2xkIHZyaW5nLiBJbiBhbnkgY2FzZSwgYW4gZXJyb3IgaXMgcmV0dXJuZWQsCj4gPiA+ID4g
PiA+ID4gPiA+ID4gaW5kaWNhdGluZyB0aGF0IHRoZSB2cmluZyBzdGlsbCBwb2ludHMgdG8gdGhl
IG9sZCB2cmluZy4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IEluIHRo
ZSBjYXNlIG9mIGFuIGVycm9yLCByZS1pbml0aWFsaXplKHZpcnRxdWV1ZV9yZWluaXRfc3BsaXQo
KSkgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gdmlydHF1ZXVlIHRvIGVuc3VyZSB0aGF0IHRoZSB2
cmluZyBjYW4gYmUgdXNlZC4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gPiA+ID4gICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwo+ID4gPiA+ID4gPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMo
KykKPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ID4gPiA+ID4gPiA+ID4gPiA+IGluZGV4IGI2ZmRhOTFjODA1OS4uNTgzNTVlMWFjN2Q3IDEw
MDY0NAo+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMKPiA+ID4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTIyMCw2ICsyMjAsNyBAQCBzdGF0aWMgc3RydWN0IHZp
cnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiA+ID4g
PiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4gPiA+ID4gPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpu
YW1lKTsKPiA+ID4gPiA+ID4gPiA+ID4gPiAgIHN0YXRpYyBzdHJ1Y3QgdnJpbmdfZGVzY19leHRy
YSAqdnJpbmdfYWxsb2NfZGVzY19leHRyYSh1bnNpZ25lZCBpbnQgbnVtKTsKPiA+ID4gPiA+ID4g
PiA+ID4gPiArc3RhdGljIHZvaWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpOwo+
ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gICAvKgo+ID4gPiA+ID4gPiA+
ID4gPiA+ICAgICogSGVscGVycy4KPiA+ID4gPiA+ID4gPiA+ID4gPiBAQCAtMTExNyw2ICsxMTE4
LDM5IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3Nw
bGl0KAo+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICByZXR1cm4gdnE7Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gICB9Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiArc3RhdGljIGlu
dCB2aXJ0cXVldWVfcmVzaXplX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwgdTMyIG51bSkK
PiA+ID4gPiA+ID4gPiA+ID4gPiArewo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICBzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlX3NwbGl0IHZyaW5nX3NwbGl0ID0ge307Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
KyAgIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gKyAgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0gX3ZxLT52ZGV2Owo+ID4g
PiA+ID4gPiA+ID4gPiA+ICsgICBpbnQgZXJyOwo+ID4gPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4g
PiA+ID4gPiA+ID4gPiArICAgZXJyID0gdnJpbmdfYWxsb2NfcXVldWVfc3BsaXQoJnZyaW5nX3Nw
bGl0LCB2ZGV2LCBudW0sCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZxLT5zcGxpdC52cmluZ19hbGlnbiwKPiA+ID4gPiA+ID4gPiA+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnEtPnNwbGl0Lm1heV9yZWR1Y2VfbnVt
KTsKPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgaWYgKGVycikKPiA+ID4gPiA+ID4gPiA+ID4gPiAr
ICAgICAgICAgICBnb3RvIGVycjsKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gSSB0aGluayB3ZSBkb24ndCBuZWVkIHRvIGRvIGFueXRoaW5nIGhl
cmU/Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gQW0gSSBtaXNzaW5nIHNvbWV0aGlu
Zz8KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEkgbWVhbnQgaXQgbG9va3MgdG8gbWUgbW9z
dCBvZiB0aGUgdmlydHF1ZXVlX3JlaW5pdCgpIGlzIHVubmVjZXNzYXJ5Lgo+ID4gPiA+ID4gPiA+
IFdlIHByb2JhYmx5IG9ubHkgbmVlZCB0byByZWluaXQgYXZhaWwvdXNlZCBpZHggdGhlcmUuCj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEluIHRoaXMgZnVuY3Rpb24sIHdlIGNh
biBpbmRlZWQgcmVtb3ZlIHNvbWUgY29kZS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAgICAg
ICBzdGF0aWMgdm9pZCB2aXJ0cXVldWVfcmVpbml0X3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxKQo+ID4gPiA+ID4gPiA+ICAgICAgIHsKPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAg
IGludCBzaXplLCBpOwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBt
ZW1zZXQodnEtPnNwbGl0LnZyaW5nLmRlc2MsIDAsIHZxLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5
dGVzKTsKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgc2l6ZSA9IHNp
emVvZihzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxpdCkgKiB2cS0+c3BsaXQudnJpbmcubnVt
Owo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgbWVtc2V0KHZxLT5zcGxpdC5kZXNjX3N0YXRl
LCAwLCBzaXplKTsKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgc2l6
ZSA9IHNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSkgKiB2cS0+c3BsaXQudnJpbmcubnVt
Owo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgbWVtc2V0KHZxLT5zcGxpdC5kZXNjX2V4dHJh
LCAwLCBzaXplKTsKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhlc2UgbWVtc2V0cyBjYW4gYmUg
cmVtb3ZlZCwgYW5kIHRoZW9yZXRpY2FsbHkgaXQgd2lsbCBub3QgY2F1c2UgYW55Cj4gPiA+ID4g
PiA+IGV4Y2VwdGlvbnMuCj4gPiA+ID4gPgo+ID4gPiA+ID4gWWVzLCBvdGhlcndpc2Ugd2UgaGF2
ZSBidWdzIGluIGRldGFjaF9idWYoKS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgdnEtPnNwbGl0LnZyaW5nLm51bSAtIDE7IGkrKykKPiA+ID4gPiA+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgdnEtPnNwbGl0LmRlc2NfZXh0cmFbaV0ubmV4dCA9
IGkgKyAxOwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGlzIGNhbiBhbHNvIGJlIHJlbW92ZWQs
IGJ1dCB3ZSBuZWVkIHRvIHJlY29yZCBmcmVlX2hlYWQgdGhhdCB3aWxsIGJlZW4gdXBkYXRlCj4g
PiA+ID4gPiA+IGluc2lkZSB2aXJ0cXVldWVfaW5pdCgpLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFdl
IGNhbiBzaW1wbHkga2VlcCBmcmVlX2hlYWQgdW5jaGFuZ2VkPyBPdGhlcndpc2UgaXQncyBhIGJ1
ZyBzb21ld2hlcmUgSSBndWVzcy4KPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICB2aXJ0cXVldWVfaW5pdCh2cSwg
dnEtPnNwbGl0LnZyaW5nLm51bSk7Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoZXJlIGFyZSBz
b21lIG9wZXJhdGlvbnMgaW4gdGhpcywgd2hpY2ggY2FuIGFsc28gYmUgc2tpcHBlZCwgc3VjaCBh
cyBzZXR0aW5nCj4gPiA+ID4gPiA+IHVzZV9kbWFfYXBpLiBCdXQgSSB0aGluayBjYWxsaW5nIHRo
aXMgZnVuY3Rpb24gZGlyZWN0bHkgd2lsbCBiZSBtb3JlIGNvbnZlbmllbnQKPiA+ID4gPiA+ID4g
Zm9yIG1haW50ZW5hbmNlLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEkgZG9uJ3Qgc2VlIGFueXRoaW5n
IHRoYXQgaXMgbmVjZXNzYXJ5IGhlcmUuCj4gPiA+ID4KPiA+ID4gPiBUaGVzZSB0aHJlZSBhcmUg
Y3VycmVudGx5IGluc2lkZSB2aXJ0cXVldWVfaW5pdCgpCj4gPiA+ID4KPiA+ID4gPiB2cS0+bGFz
dF91c2VkX2lkeCA9IDA7Cj4gPiA+ID4gdnEtPmV2ZW50X3RyaWdnZXJlZCA9IGZhbHNlOwo+ID4g
PiA+IHZxLT5udW1fYWRkZWQgPSAwOwo+ID4gPgo+ID4gPiBSaWdodC4gTGV0J3Mga2VlcCBpdCB0
aGVyZS4KPiA+ID4KPiA+ID4gKFRob3VnaCBpdCdzIGtpbmQgb2Ygc3RyYW5nZSB0aGF0IHRoZSBs
YXN0X3VzZWRfaWR4IGlzIG5vdCBpbml0aWFsaXplZAo+ID4gPiBhdCB0aGUgc2FtZSBwbGFjZSB3
aXRoIGF2YWlsX2lkeC9mbGFnc19zaGFkb3csIHdlIGNhbiBvcHRpbWl6ZSBpdCBvbgo+ID4gPiB0
b3ApLgo+ID4KPiA+IEkgcHV0IGZyZWVfaGVhZCA9IDAgaW4gdGhlIGF0dGFjaCBmdW5jdGlvbiwg
aXQgaXMgb25seSBuZWNlc3NhcnkgdG8gc2V0Cj4gPiBmcmVlX2hlYWQgPSAwIHdoZW4gYSBuZXcg
c3RhdGUvZXh0cmEgaXMgYXR0YWNoZWQuCj4KPiBPaywgc28gSSBtZWFudCBJIHRlbmQgdG8ga2Vl
cCBpdCB0byBtYWtlIHRoaXMgc2VyaWVzIGNvbnZlcmdlIHNvb24gOikKCgpPaywgb3RoZXIgdGhh
biB0aGlzLCBhbmQgd2hhdCB3ZSBkaXNjdXNzZWQsIG5vIG1vcmUgZml4ZXMgd2lsbCBiZSBhZGRl
ZC4KClRoYW5rcy4KCgo+Cj4gV2UgY2FuIGRvIG9wdGltaXphdGlvbiBvbiB0b3AgYW55aG93Lgo+
Cj4gVGhhbmtzCj4KPiA+Cj4gPiBJbiB0aGlzIHdheSwgd2hlbiB3ZSBjYWxsIHZpcnRxdWV1ZV9p
bml0KCksIHdlIGRvbid0IGhhdmUgdG8gd29ycnkgYWJvdXQKPiA+IGZyZWVfaGVhZCBiZWluZyBt
b2RpZmllZC4KPiA+Cj4gPiBSZXRoaW5raW5nIHRoaXMgcHJvYmxlbSwgSSB0aGluayB2aXJ0cXVl
dWVfaW5pdCgpIGNhbiBiZSByZXdyaXR0ZW4gYW5kIHNvbWUKPiA+IHZhcmlhYmxlcyB0aGF0IHdp
bGwgbm90IGNoYW5nZSBhcmUgcmVtb3ZlZCBmcm9tIGl0LiAodXNlX2RtYV9hcGksIGV2ZW50LAo+
ID4gd2Vha19iYXJyaWVycykKPiA+Cj4gPiArc3RhdGljIHZvaWQgdmlydHF1ZXVlX2luaXQoc3Ry
dWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsIHUzMiBudW0pCj4gPiArewo+ID4gKyAgICAgICB2cS0+
dnEubnVtX2ZyZWUgPSBudW07Cj4gPiArCj4gPiArICAgICAgIGlmICh2cS0+cGFja2VkX3Jpbmcp
Cj4gPiArICAgICAgICAgICAgICAgdnEtPmxhc3RfdXNlZF9pZHggPSAwIHwgKDEgPDwgVlJJTkdf
UEFDS0VEX0VWRU5UX0ZfV1JBUF9DVFIpOwo+ID4gKyAgICAgICBlbHNlCj4gPiArICAgICAgICAg
ICAgICAgdnEtPmxhc3RfdXNlZF9pZHggPSAwOwo+ID4gKwo+ID4gKyAgICAgICB2cS0+ZXZlbnRf
dHJpZ2dlcmVkID0gZmFsc2U7Cj4gPiArICAgICAgIHZxLT5udW1fYWRkZWQgPSAwOwo+ID4gKwo+
ID4gKyNpZmRlZiBERUJVRwo+ID4gKyAgICAgICB2cS0+aW5fdXNlID0gZmFsc2U7Cj4gPiArICAg
ICAgIHZxLT5sYXN0X2FkZF90aW1lX3ZhbGlkID0gZmFsc2U7Cj4gPiArI2VuZGlmCj4gPiArfQo+
ID4gKwo+ID4KPiA+IFRoYW5rcy4KPiA+Cj4gPgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4KPiA+
ID4gPgo+ID4gPiA+IFRoYW5rcy4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgdmlydHF1ZXVlX3ZyaW5n
X2luaXRfc3BsaXQoJnZxLT5zcGxpdCwgdnEpOwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiB2aXJ0
cXVldWVfdnJpbmdfaW5pdF9zcGxpdCgpIGlzIG5lY2Vzc2FyeS4KPiA+ID4gPiA+Cj4gPiA+ID4g
PiBSaWdodC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gICAgICAgfQo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiBBbm90aGVyIG1ldGhvZCwgd2UgY2FuIHRha2Ugb3V0IGFsbCB0
aGUgdmFyaWFibGVzIHRvIGJlIHJlaW5pdGlhbGl6ZWQKPiA+ID4gPiA+ID4gc2VwYXJhdGVseSwg
YW5kIHJlcGFja2FnZSB0aGVtIGludG8gYSBuZXcgZnVuY3Rpb24uIEkgZG9u4oCZdCB0aGluayBp
dOKAmXMgd29ydGgKPiA+ID4gPiA+ID4gaXQsIGJlY2F1c2UgdGhpcyBwYXRoIHdpbGwgb25seSBi
ZSByZWFjaGVkIGlmIHRoZSBtZW1vcnkgYWxsb2NhdGlvbiBmYWlscywgd2hpY2gKPiA+ID4gPiA+
ID4gaXMgYSByYXJlIG9jY3VycmVuY2UuIEluIHRoaXMgY2FzZSwgZG9pbmcgc28gd2lsbCBpbmNy
ZWFzZSB0aGUgY29zdCBvZgo+ID4gPiA+ID4gPiBtYWludGVuYW5jZS4gSWYgeW91IHRoaW5rIHNv
IGFsc28sIEkgd2lsbCByZW1vdmUgdGhlIGFib3ZlIG1lbXNldCBpbiB0aGUgbmV4dAo+ID4gPiA+
ID4gPiB2ZXJzaW9uLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEkgYWdyZWUuCj4gPiA+ID4gPgo+ID4g
PiA+ID4gVGhhbmtzCj4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGFua3MuCj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGFua3MK
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgIGVy
ciA9IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3NwbGl0KCZ2cmluZ19zcGxpdCk7Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gKyAgIGlmIChlcnIpIHsKPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAg
ICB2cmluZ19mcmVlX3NwbGl0KCZ2cmluZ19zcGxpdCwgdmRldik7Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gKyAgICAgICAgICAgZ290byBlcnI7Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+IEkgc3VnZ2VzdCB0byBtb3ZlIHZyaW5nX2ZyZWVfc3BsaXQo
KSBpbnRvIGEgZGVkaWNhdGVkIGVycm9yIGxhYmVsLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+IFdpbGwgY2hhbmdlLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFRoYW5r
cy4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gPiArICAgfQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+
ID4gPiA+ID4gPiArICAgdnJpbmdfZnJlZSgmdnEtPnZxKTsKPiA+ID4gPiA+ID4gPiA+ID4gPiAr
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgIHZpcnRxdWV1ZV92cmluZ19pbml0X3NwbGl0KCZ2cmlu
Z19zcGxpdCwgdnEpOwo+ID4gPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiA+ID4gPiAr
ICAgdmlydHF1ZXVlX2luaXQodnEsIHZyaW5nX3NwbGl0LnZyaW5nLm51bSk7Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gKyAgIHZpcnRxdWV1ZV92cmluZ19hdHRhY2hfc3BsaXQodnEsICZ2cmluZ19zcGxp
dCk7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICByZXR1cm4g
MDsKPiA+ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+ID4gK2VycjoKPiA+ID4g
PiA+ID4gPiA+ID4gPiArICAgdmlydHF1ZXVlX3JlaW5pdF9zcGxpdCh2cSk7Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gKyAgIHJldHVybiAtRU5PTUVNOwo+ID4gPiA+ID4gPiA+ID4gPiA+ICt9Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
ICAvKgo+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICogUGFja2VkIHJpbmcgc3BlY2lmaWMgZnVuY3Rp
b25zIC0gKl9wYWNrZWQoKS4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4KPiA+Cj4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
