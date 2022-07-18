Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB72DC43334
	for <virtualization@archiver.kernel.org>; Mon, 18 Jul 2022 08:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 45C82403A5;
	Mon, 18 Jul 2022 08:59:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 45C82403A5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GGso-RV2MCx4; Mon, 18 Jul 2022 08:59:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 05C01401C9;
	Mon, 18 Jul 2022 08:59:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05C01401C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6609C0035;
	Mon, 18 Jul 2022 08:59:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3C4EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 08:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C57383E30
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 08:59:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C57383E30
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9jmsDoWjnkYK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 08:59:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1485883E2D
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1485883E2D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jul 2022 08:59:35 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VJgGPA0_1658134768; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VJgGPA0_1658134768) by smtp.aliyun-inc.com;
 Mon, 18 Jul 2022 16:59:29 +0800
Message-ID: <1658134695.4666655-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 38/40] virtio_net: support rx queue resize
Date: Mon, 18 Jul 2022 16:58:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-39-xuanzhuo@linux.alibaba.com>
 <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
 <1656986375.3420787-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEu80KP-ULz_CBvauRk_3XsCubMkkWv0uLnbt-wib5KOnA@mail.gmail.com>
 <1657874178.9766078-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEtF5NSXh-=nnsniLqy0pX2Tpyh413S5Bu5vZ6h=d+aHTA@mail.gmail.com>
In-Reply-To: <CACGkMEtF5NSXh-=nnsniLqy0pX2Tpyh413S5Bu5vZ6h=d+aHTA@mail.gmail.com>
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

T24gTW9uLCAxOCBKdWwgMjAyMiAxNjo1NjoyNCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gRnJpLCBKdWwgMTUsIDIwMjIgYXQgNDozNyBQTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBGcmks
IDggSnVsIDIwMjIgMTQ6MjA6NTIgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPiBPbiBUdWUsIEp1bCA1LCAyMDIyIGF0IDEwOjAwIEFNIFh1YW4gWmh1
byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24g
TW9uLCA0IEp1bCAyMDIyIDExOjQ0OjEyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiDlnKggMjAyMi82LzI5IDE0OjU2LCBY
dWFuIFpodW8g5YaZ6YGTOgo+ID4gPiA+ID4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIHJl
c2l6ZSBmdW5jdGlvbiBvZiB0aGUgcnggcXVldWVzLgo+ID4gPiA+ID4gPiBCYXNlZCBvbiB0aGlz
IGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhlIHJpbmcgbnVtIG9mIHRoZQo+
ID4gPiA+ID4gPiBxdWV1ZS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
WHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+ID4gPiA+ID4gLS0tCj4g
PiA+ID4gPiA+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMjIgKysrKysrKysrKysrKysr
KysrKysrKwo+ID4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspCj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ID4gaW5kZXggOWZlMjIyYTM2
NjNhLi42YWIxNmZkMTkzZTUgMTAwNjQ0Cj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+
ID4gPiA+ID4gQEAgLTI3OCw2ICsyNzgsOCBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiA+
ID4gPiA+ID4gICAgIGNoYXIgcGFkZGluZ1sxMl07Cj4gPiA+ID4gPiA+ICAgfTsKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKHN0
cnVjdCB2aXJ0cXVldWUgKnZxLCB2b2lkICpidWYpOwo+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+
ICAgc3RhdGljIGJvb2wgaXNfeGRwX2ZyYW1lKHZvaWQgKnB0cikKPiA+ID4gPiA+ID4gICB7Cj4g
PiA+ID4gPiA+ICAgICByZXR1cm4gKHVuc2lnbmVkIGxvbmcpcHRyICYgVklSVElPX1hEUF9GTEFH
Owo+ID4gPiA+ID4gPiBAQCAtMTg0Niw2ICsxODQ4LDI2IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBz
dGFydF94bWl0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4g
PiA+ID4gPiA+ICAgICByZXR1cm4gTkVUREVWX1RYX09LOwo+ID4gPiA+ID4gPiAgIH0KPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gK3N0YXRpYyBpbnQgdmlydG5ldF9yeF9yZXNpemUoc3RydWN0IHZp
cnRuZXRfaW5mbyAqdmksCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsIHUzMiByaW5nX251bSkKPiA+ID4gPiA+ID4gK3sKPiA+ID4g
PiA+ID4gKyAgIGludCBlcnIsIHFpbmRleDsKPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiArICAg
cWluZGV4ID0gcnEgLSB2aS0+cnE7Cj4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gKyAgIG5hcGlf
ZGlzYWJsZSgmcnEtPm5hcGkpOwo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBEbyB3ZSBu
ZWVkIHRvIGNhbmNlbCB0aGUgcmVmaWxsIHdvcmsgaGVyZT8KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+
ID4gSSB0aGluayBubywgbmFwaV9kaXNhYmxlIGlzIG11dHVhbGx5IGV4Y2x1c2l2ZSwgd2hpY2gg
ZW5zdXJlcyB0aGF0IHRoZXJlIHdpbGwgYmUKPiA+ID4gPiBubyBjb25mbGljdHMgYmV0d2VlbiB0
aGVtLgo+ID4gPgo+ID4gPiBTbyB0aGlzIHNvdW5kcyBzaW1pbGFyIHRvIHdoYXQgSSd2ZSBmaXhl
ZCByZWNlbnRseS4KPiA+ID4KPiA+ID4gMSkgTkFQSSBzY2hlZHVsZSBkZWxheWVkIHdvcmsuCj4g
PiA+IDIpIHdlIGRpc2FibGUgTkFQSSBoZXJlCj4gPiA+IDMpIGRlbGF5ZWQgd29yayBnZXQgc2No
ZWR1bGUgYW5kIGNhbGwgTkFQSSBhZ2Fpbgo+ID4gPgo+ID4gPiA/Cj4gPgo+ID4gWWVzLCBidXQg
SSBkb24ndCB0aGluayB0aGVyZSBhcmUgYW55IG5lZ2F0aXZlIGVmZmVjdHMuCj4KPiBBbiBpbmZp
bml0ZSB3YWl0IG9uIHRoZSBuYXBpX2Rpc2FibGUoKT8KClllcy4KClRoYW5rcy4KCgo+Cj4gVGhh
bmtzCj4KPiA+Cj4gPiBUaGFua3MuCj4gPgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4g
Pgo+ID4gPiA+IFRoYW5rcy4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcwo+ID4g
PiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gKyAgIGVyciA9IHZpcnRx
dWV1ZV9yZXNpemUocnEtPnZxLCByaW5nX251bSwgdmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYp
Owo+ID4gPiA+ID4gPiArICAgaWYgKGVycikKPiA+ID4gPiA+ID4gKyAgICAgICAgICAgbmV0ZGV2
X2Vycih2aS0+ZGV2LCAicmVzaXplIHJ4IGZhaWw6IHJ4IHF1ZXVlIGluZGV4OiAlZCBlcnI6ICVk
XG4iLCBxaW5kZXgsIGVycik7Cj4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gKyAgIGlmICghdHJ5
X2ZpbGxfcmVjdih2aSwgcnEsIEdGUF9LRVJORUwpKQo+ID4gPiA+ID4gPiArICAgICAgICAgICBz
Y2hlZHVsZV9kZWxheWVkX3dvcmsoJnZpLT5yZWZpbGwsIDApOwo+ID4gPiA+ID4gPiArCj4gPiA+
ID4gPiA+ICsgICB2aXJ0bmV0X25hcGlfZW5hYmxlKHJxLT52cSwgJnJxLT5uYXBpKTsKPiA+ID4g
PiA+ID4gKyAgIHJldHVybiBlcnI7Cj4gPiA+ID4gPiA+ICt9Cj4gPiA+ID4gPiA+ICsKPiA+ID4g
PiA+ID4gICAvKgo+ID4gPiA+ID4gPiAgICAqIFNlbmQgY29tbWFuZCB2aWEgdGhlIGNvbnRyb2wg
dmlydHF1ZXVlIGFuZCBjaGVjayBzdGF0dXMuICBDb21tYW5kcwo+ID4gPiA+ID4gPiAgICAqIHN1
cHBvcnRlZCBieSB0aGUgaHlwZXJ2aXNvciwgYXMgaW5kaWNhdGVkIGJ5IGZlYXR1cmUgYml0cywg
c2hvdWxkCj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+Cj4gPgo+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
