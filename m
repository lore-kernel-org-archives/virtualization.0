Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38700C77B75
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 02:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6CD260E15;
	Mon,  8 May 2023 02:04:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6CD260E15
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qn3897ZJyK5g; Mon,  8 May 2023 02:04:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3DDE760F1F;
	Mon,  8 May 2023 02:04:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DDE760F1F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11239C0036;
	Mon,  8 May 2023 02:04:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A955C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 02:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17F3A81FBB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 02:04:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17F3A81FBB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OKXywp0jJtP1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 02:03:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8DAB081E29
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DAB081E29
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 02:03:57 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R491e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vhyt-XW_1683511431; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vhyt-XW_1683511431) by smtp.aliyun-inc.com;
 Mon, 08 May 2023 10:03:52 +0800
Message-ID: <1683511319.099806-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: set default mtu to 1500 when 'Device maximum
 MTU' bigger than 1500
Date: Mon, 8 May 2023 10:01:59 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230506021529.396812-1-chenh@yusur.tech>
 <1683341417.0965195-4-xuanzhuo@linux.alibaba.com>
 <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
 <20230507045627-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230507045627-mutt-send-email-mst@kernel.org>
Cc: zy@yusur.tech, Hao Chen <chenh@yusur.tech>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, hengqi@linux.alibaba.com,
 huangml@yusur.tech, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gU3VuLCA3IE1heSAyMDIzIDA0OjU4OjU4IC0wNDAwLCAiTWljaGFlbCBTLiBUc2lya2luIiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+IE9uIFNhdCwgTWF5IDA2LCAyMDIzIGF0IDA0OjU2OjM1
UE0gKzA4MDAsIEhhbyBDaGVuIHdyb3RlOgo+ID4KPiA+Cj4gPiDlnKggMjAyMy81LzYgMTA6NTAs
IFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+IE9uIFNhdCwgIDYgTWF5IDIwMjMgMTA6MTU6MjkgKzA4
MDAsIEhhbyBDaGVuIDxjaGVuaEB5dXN1ci50ZWNoPiB3cm90ZToKPiA+ID4gPiBXaGVuIFZJUlRJ
T19ORVRfRl9NVFUoMykgRGV2aWNlIG1heGltdW0gTVRVIHJlcG9ydGluZyBpcyBzdXBwb3J0ZWQu
Cj4gPiA+ID4gSWYgb2ZmZXJlZCBieSB0aGUgZGV2aWNlLCBkZXZpY2UgYWR2aXNlcyBkcml2ZXIg
YWJvdXQgdGhlIHZhbHVlIG9mIGl0cwo+ID4gPiA+IG1heGltdW0gTVRVLiBJZiBuZWdvdGlhdGVk
LCB0aGUgZHJpdmVyIHVzZXMgbXR1IGFzIHRoZSBtYXhpbXVtCj4gPiA+ID4gTVRVIHZhbHVlLiBC
dXQgdGhlcmUgdGhlIGRyaXZlciBhbHNvIHVzZXMgaXQgYXMgZGVmYXVsdCBtdHUsCj4gPiA+ID4g
c29tZSBkZXZpY2VzIG1heSBoYXZlIGEgbWF4aW11bSBNVFUgZ3JlYXRlciB0aGFuIDE1MDAsIHRo
aXMgbWF5Cj4gPiA+ID4gY2F1c2Ugc29tZSBsYXJnZSBwYWNrYWdlcyB0byBiZSBkaXNjYXJkZWQs
Cj4gPiA+Cj4gPiA+IFlvdSBtZWFuIHR4IHBhY2tldD8KPiA+IFllcy4KPiA+ID4KPiA+ID4gSWYg
eWVzLCBJIGRvIG5vdCB0aGluayB0aGlzIGlzIHRoZSBwcm9ibGVtIG9mIGRyaXZlci4KPiA+ID4K
PiA+ID4gTWF5YmUgeW91IHNob3VsZCBnaXZlIG1vcmUgZGV0YWlscyBhYm91dCB0aGUgZGlzY2Fy
ZC4KPiA+ID4KPiA+IEluIHRoZSBjdXJyZW50IGNvZGUsIGlmIHRoZSBtYXhpbXVtIE1UVSBzdXBw
b3J0ZWQgYnkgdGhlIHZpcnRpbyBuZXQgaGFyZHdhcmUKPiA+IGlzIDkwMDAsIHRoZSBkZWZhdWx0
IE1UVSBvZiB0aGUgdmlydGlvIG5ldCBkcml2ZXIgd2lsbCBhbHNvIGJlIHNldCB0byA5MDAwLgo+
ID4gV2hlbiBzZW5kaW5nIHBhY2tldHMgdGhyb3VnaCAicGluZyAtcyA1MDAwIiwgaWYgdGhlIHBl
ZXIgcm91dGVyIGRvZXMgbm90Cj4gPiBzdXBwb3J0IG5lZ290aWF0aW5nIGEgcGF0aCBNVFUgdGhy
b3VnaCBJQ01QIHBhY2tldHMsIHRoZSBwYWNrZXRzIHdpbGwgYmUKPiA+IGRpc2NhcmRlZC4gSWYg
dGhlIHBlZXIgcm91dGVyIHN1cHBvcnRzIG5lZ290aWF0aW5nIHBhdGggbXR1IHRocm91Z2ggSUNN
UAo+ID4gcGFja2V0cywgdGhlIGhvc3Qgc2lkZSB3aWxsIHBlcmZvcm0gcGFja2V0IHNoYXJkaW5n
IHByb2Nlc3NpbmcgYmFzZWQgb24gdGhlCj4gPiBuZWdvdGlhdGVkIHBhdGggbXR1LCB3aGljaCBp
cyBnZW5lcmFsbHkgd2l0aGluIDE1MDAuCj4gPiBUaGlzIGlzIG5vdCBhIGJ1Z2ZpeCBwYXRjaCwg
SSB0aGluayBzZXR0aW5nIHRoZSBkZWZhdWx0IG10dSB0byB3aXRoaW4gMTUwMAo+ID4gd291bGQg
YmUgbW9yZSBzdWl0YWJsZSBoZXJlLlRoYW5rcy4KPgo+IEkgZG9uJ3QgdGhpbmsgVklSVElPX05F
VF9GX01UVSBpcyBhcHByb3ByaWF0ZSBmb3Igc3VwcG9ydCBmb3IganVtYm8gcGFja2V0cy4KPiBU
aGUgc3BlYyBzYXlzOgo+IAlUaGUgZGV2aWNlIE1VU1QgZm9yd2FyZCB0cmFuc21pdHRlZCBwYWNr
ZXRzIG9mIHVwIHRvIG10dSAocGx1cyBsb3cgbGV2ZWwgZXRoZXJuZXQgaGVhZGVyIGxlbmd0aCkg
c2l6ZSB3aXRoCj4gCWdzb190eXBlIE5PTkUgb3IgRUNOLCBhbmQgZG8gc28gd2l0aG91dCBmcmFn
bWVudGF0aW9uLCBhZnRlciBWSVJUSU9fTkVUX0ZfTVRVIGhhcyBiZWVuIHN1Y2Nlc3MtCj4gCWZ1
bGx5IG5lZ290aWF0ZWQuCj4gVklSVElPX05FVF9GX01UVSBoYXMgYmVlbiBkZXNpZ25lZCBmb3Ig
YWxsIGtpbmQgb2YgdHVubmVsaW5nIGRldmljZXMsCj4gYW5kIHRoaXMgaXMgd2h5IHdlIHNldCBt
dHUgdG8gbWF4IGJ5IGRlZmF1bHQuCj4KPiBGb3IgdGhpbmdzIGxpa2UganVtYm8gZnJhbWVzIHdo
ZXJlIE1UVSBtaWdodCBvciBtaWdodCBub3QgYmUgYXZhaWxhYmxlLAo+IGEgbmV3IGZlYXR1cmUg
d291bGQgYmUgbW9yZSBhcHByb3ByaWF0ZS4KCgpTbyBmb3IganVtYm8gZnJhbWUsIHdoYXQgaXMg
dGhlIHByb2JsZW0/CgpXZSBhcmUgdHJ5aW5nIHRvIGRvIHRoaXMuIEBIZW5nCgpUaGFua3MuCgoK
Pgo+ID4gPiA+IHNvIEkgY2hhbmdlZCB0aGUgTVRVIHRvIGEgbW9yZQo+ID4gPiA+IGdlbmVyYWwg
MTUwMCB3aGVuICdEZXZpY2UgbWF4aW11bSBNVFUnIGJpZ2dlciB0aGFuIDE1MDAuCj4gPiA+ID4K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYW8gQ2hlbiA8Y2hlbmhAeXVzdXIudGVjaD4KPiA+ID4g
PiAtLS0KPiA+ID4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDUgKysrKy0KPiA+ID4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+ID4g
Pgo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiBpbmRleCA4ZDgwMzg1MzhmYzQuLmU3MWM3ZDFiNWYy
OSAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiAr
KysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiBAQCAtNDA0MCw3ICs0MDQwLDEw
IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikK
PiA+ID4gPiAgIAkJCWdvdG8gZnJlZTsKPiA+ID4gPiAgIAkJfQo+ID4gPiA+Cj4gPiA+ID4gLQkJ
ZGV2LT5tdHUgPSBtdHU7Cj4gPiA+ID4gKwkJaWYgKG10dSA+IDE1MDApCj4gPiA+Cj4gPiA+IHMv
MTUwMC9FVEhfREFUQV9MRU4vCj4gPiA+Cj4gPiA+IFRoYW5rcy4KPiA+ID4KPiA+ID4gPiArCQkJ
ZGV2LT5tdHUgPSAxNTAwOwo+ID4gPiA+ICsJCWVsc2UKPiA+ID4gPiArCQkJZGV2LT5tdHUgPSBt
dHU7Cj4gPiA+ID4gICAJCWRldi0+bWF4X210dSA9IG10dTsKPiA+ID4gPiAgIAl9Cj4gPiA+ID4K
PiA+ID4gPiAtLQo+ID4gPiA+IDIuMjcuMAo+ID4gPiA+Cj4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
