Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8310FC7EE24
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 06:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 191DA60AF1;
	Mon,  8 May 2023 06:28:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 191DA60AF1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CGiXTM5Fw9dI; Mon,  8 May 2023 06:28:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 89CCB60F33;
	Mon,  8 May 2023 06:28:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89CCB60F33
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67255C0037;
	Mon,  8 May 2023 06:28:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA5A8C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8827D410C2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:28:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8827D410C2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U6t5Uvb33byx
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:28:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82787410A6
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82787410A6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:28:15 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vi.ayqL_1683527290; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vi.ayqL_1683527290) by smtp.aliyun-inc.com;
 Mon, 08 May 2023 14:28:11 +0800
Message-ID: <1683526688.7492425-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: set default mtu to 1500 when 'Device maximum
 MTU' bigger than 1500
Date: Mon, 8 May 2023 14:18:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230506021529.396812-1-chenh@yusur.tech>
 <1683341417.0965195-4-xuanzhuo@linux.alibaba.com>
 <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
 <20230507045627-mutt-send-email-mst@kernel.org>
 <1683511319.099806-2-xuanzhuo@linux.alibaba.com>
 <20230508020953-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230508020953-mutt-send-email-mst@kernel.org>
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

T24gTW9uLCA4IE1heSAyMDIzIDAyOjE1OjQ2IC0wNDAwLCAiTWljaGFlbCBTLiBUc2lya2luIiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+IE9uIE1vbiwgTWF5IDA4LCAyMDIzIGF0IDEwOjAxOjU5
QU0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPiA+IE9uIFN1biwgNyBNYXkgMjAyMyAwNDo1ODo1
OCAtMDQwMCwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+
ID4gT24gU2F0LCBNYXkgMDYsIDIwMjMgYXQgMDQ6NTY6MzVQTSArMDgwMCwgSGFvIENoZW4gd3Jv
dGU6Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IOWcqCAyMDIzLzUvNiAxMDo1MCwgWHVhbiBaaHVv
IOWGmemBkzoKPiA+ID4gPiA+IE9uIFNhdCwgIDYgTWF5IDIwMjMgMTA6MTU6MjkgKzA4MDAsIEhh
byBDaGVuIDxjaGVuaEB5dXN1ci50ZWNoPiB3cm90ZToKPiA+ID4gPiA+ID4gV2hlbiBWSVJUSU9f
TkVUX0ZfTVRVKDMpIERldmljZSBtYXhpbXVtIE1UVSByZXBvcnRpbmcgaXMgc3VwcG9ydGVkLgo+
ID4gPiA+ID4gPiBJZiBvZmZlcmVkIGJ5IHRoZSBkZXZpY2UsIGRldmljZSBhZHZpc2VzIGRyaXZl
ciBhYm91dCB0aGUgdmFsdWUgb2YgaXRzCj4gPiA+ID4gPiA+IG1heGltdW0gTVRVLiBJZiBuZWdv
dGlhdGVkLCB0aGUgZHJpdmVyIHVzZXMgbXR1IGFzIHRoZSBtYXhpbXVtCj4gPiA+ID4gPiA+IE1U
VSB2YWx1ZS4gQnV0IHRoZXJlIHRoZSBkcml2ZXIgYWxzbyB1c2VzIGl0IGFzIGRlZmF1bHQgbXR1
LAo+ID4gPiA+ID4gPiBzb21lIGRldmljZXMgbWF5IGhhdmUgYSBtYXhpbXVtIE1UVSBncmVhdGVy
IHRoYW4gMTUwMCwgdGhpcyBtYXkKPiA+ID4gPiA+ID4gY2F1c2Ugc29tZSBsYXJnZSBwYWNrYWdl
cyB0byBiZSBkaXNjYXJkZWQsCj4gPiA+ID4gPgo+ID4gPiA+ID4gWW91IG1lYW4gdHggcGFja2V0
Pwo+ID4gPiA+IFllcy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJZiB5ZXMsIEkgZG8gbm90IHRoaW5r
IHRoaXMgaXMgdGhlIHByb2JsZW0gb2YgZHJpdmVyLgo+ID4gPiA+ID4KPiA+ID4gPiA+IE1heWJl
IHlvdSBzaG91bGQgZ2l2ZSBtb3JlIGRldGFpbHMgYWJvdXQgdGhlIGRpc2NhcmQuCj4gPiA+ID4g
Pgo+ID4gPiA+IEluIHRoZSBjdXJyZW50IGNvZGUsIGlmIHRoZSBtYXhpbXVtIE1UVSBzdXBwb3J0
ZWQgYnkgdGhlIHZpcnRpbyBuZXQgaGFyZHdhcmUKPiA+ID4gPiBpcyA5MDAwLCB0aGUgZGVmYXVs
dCBNVFUgb2YgdGhlIHZpcnRpbyBuZXQgZHJpdmVyIHdpbGwgYWxzbyBiZSBzZXQgdG8gOTAwMC4K
PiA+ID4gPiBXaGVuIHNlbmRpbmcgcGFja2V0cyB0aHJvdWdoICJwaW5nIC1zIDUwMDAiLCBpZiB0
aGUgcGVlciByb3V0ZXIgZG9lcyBub3QKPiA+ID4gPiBzdXBwb3J0IG5lZ290aWF0aW5nIGEgcGF0
aCBNVFUgdGhyb3VnaCBJQ01QIHBhY2tldHMsIHRoZSBwYWNrZXRzIHdpbGwgYmUKPiA+ID4gPiBk
aXNjYXJkZWQuIElmIHRoZSBwZWVyIHJvdXRlciBzdXBwb3J0cyBuZWdvdGlhdGluZyBwYXRoIG10
dSB0aHJvdWdoIElDTVAKPiA+ID4gPiBwYWNrZXRzLCB0aGUgaG9zdCBzaWRlIHdpbGwgcGVyZm9y
bSBwYWNrZXQgc2hhcmRpbmcgcHJvY2Vzc2luZyBiYXNlZCBvbiB0aGUKPiA+ID4gPiBuZWdvdGlh
dGVkIHBhdGggbXR1LCB3aGljaCBpcyBnZW5lcmFsbHkgd2l0aGluIDE1MDAuCj4gPiA+ID4gVGhp
cyBpcyBub3QgYSBidWdmaXggcGF0Y2gsIEkgdGhpbmsgc2V0dGluZyB0aGUgZGVmYXVsdCBtdHUg
dG8gd2l0aGluIDE1MDAKPiA+ID4gPiB3b3VsZCBiZSBtb3JlIHN1aXRhYmxlIGhlcmUuVGhhbmtz
Lgo+ID4gPgo+ID4gPiBJIGRvbid0IHRoaW5rIFZJUlRJT19ORVRfRl9NVFUgaXMgYXBwcm9wcmlh
dGUgZm9yIHN1cHBvcnQgZm9yIGp1bWJvIHBhY2tldHMuCj4gPiA+IFRoZSBzcGVjIHNheXM6Cj4g
PiA+IAlUaGUgZGV2aWNlIE1VU1QgZm9yd2FyZCB0cmFuc21pdHRlZCBwYWNrZXRzIG9mIHVwIHRv
IG10dSAocGx1cyBsb3cgbGV2ZWwgZXRoZXJuZXQgaGVhZGVyIGxlbmd0aCkgc2l6ZSB3aXRoCj4g
PiA+IAlnc29fdHlwZSBOT05FIG9yIEVDTiwgYW5kIGRvIHNvIHdpdGhvdXQgZnJhZ21lbnRhdGlv
biwgYWZ0ZXIgVklSVElPX05FVF9GX01UVSBoYXMgYmVlbiBzdWNjZXNzLQo+ID4gPiAJZnVsbHkg
bmVnb3RpYXRlZC4KPiA+ID4gVklSVElPX05FVF9GX01UVSBoYXMgYmVlbiBkZXNpZ25lZCBmb3Ig
YWxsIGtpbmQgb2YgdHVubmVsaW5nIGRldmljZXMsCj4gPiA+IGFuZCB0aGlzIGlzIHdoeSB3ZSBz
ZXQgbXR1IHRvIG1heCBieSBkZWZhdWx0Lgo+ID4gPgo+ID4gPiBGb3IgdGhpbmdzIGxpa2UganVt
Ym8gZnJhbWVzIHdoZXJlIE1UVSBtaWdodCBvciBtaWdodCBub3QgYmUgYXZhaWxhYmxlLAo+ID4g
PiBhIG5ldyBmZWF0dXJlIHdvdWxkIGJlIG1vcmUgYXBwcm9wcmlhdGUuCj4gPgo+ID4KPiA+IFNv
IGZvciBqdW1ibyBmcmFtZSwgd2hhdCBpcyB0aGUgcHJvYmxlbT8KPiA+Cj4gPiBXZSBhcmUgdHJ5
aW5nIHRvIGRvIHRoaXMuIEBIZW5nCj4gPgo+ID4gVGhhbmtzLgo+Cj4gSXQgaXMgbm90IGEgcHJv
YmxlbSBhcyBzdWNoLiBCdXQgVklSVElPX05FVF9GX01UVSB3aWxsIHNldCB0aGUKPiBkZWZhdWx0
IE1UVSBub3QganVzdCB0aGUgbWF4aW11bSBvbmUsIGJlY2F1c2Ugc3BlYyBzZWVtcyB0bwo+IHNh
eSBpdCBjYW4uCgpJIHNlZS4KCkluIHRoZSBjYXNlIG9mIEp1bWJvIEZyYW1lLCB3ZSBhbHNvIGhv
cGUgdGhhdCB0aGUgZHJpdmVyIHdpbGwgc2V0IHRoZSBkZWZhdWx0CmRpcmVjdGx5IHRvIHRoZSBt
YXggbXR1LiBKdXN0IGxpa2Ugd2hhdCB5b3Ugc2FpZCAiQmlnZ2VyIHBhY2tldHMgPSBiZXR0ZXIK
cGVyZm9ybWFuY2UuIgoKSSBkb24ndCBrbm93LCBpbiBhbnkgc2NlbmFyaW8sIHdoZW4gdGhlIGhh
cmR3YXJlIHN1cHBvcnRzIGEgbGFyZ2UgbXR1LCBidXQgd2UgZG8Kbm90IHdhbnQgdGhlIHVzZXIg
dG8gdXNlIGl0IGJ5IGRlZmF1bHQuIE9mIGNvdXJzZSwgdGhlIHNjZW5lIHRoYXQgdGhpcyBwYXRj
aAp3YW50cyB0byBoYW5kbGUgZG9lcyBleGlzdCwgYnV0IEkgaGF2ZSBuZXZlciB0aG91Z2h0IHRo
YXQgdGhpcyBpcyBhIHByb2JsZW0gYXQKdGhlIGRyaXZlciBsZXZlbC4KClRoYW5rcy4KCgo+Cj4K
PiA+Cj4gPiA+Cj4gPiA+ID4gPiA+IHNvIEkgY2hhbmdlZCB0aGUgTVRVIHRvIGEgbW9yZQo+ID4g
PiA+ID4gPiBnZW5lcmFsIDE1MDAgd2hlbiAnRGV2aWNlIG1heGltdW0gTVRVJyBiaWdnZXIgdGhh
biAxNTAwLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYW8gQ2hlbiA8
Y2hlbmhAeXVzdXIudGVjaD4KPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ICAgZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIHwgNSArKysrLQo+ID4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+ID4gPiA+ID4gPiBpbmRleCA4ZDgwMzg1MzhmYzQuLmU3MWM3ZDFiNWYyOSAxMDA2NDQK
PiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gPiBAQCAtNDA0MCw3ICs0MDQw
LDEwIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRl
dikKPiA+ID4gPiA+ID4gICAJCQlnb3RvIGZyZWU7Cj4gPiA+ID4gPiA+ICAgCQl9Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+IC0JCWRldi0+bXR1ID0gbXR1Owo+ID4gPiA+ID4gPiArCQlpZiAobXR1
ID4gMTUwMCkKPiA+ID4gPiA+Cj4gPiA+ID4gPiBzLzE1MDAvRVRIX0RBVEFfTEVOLwo+ID4gPiA+
ID4KPiA+ID4gPiA+IFRoYW5rcy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ICsJCQlkZXYtPm10dSA9
IDE1MDA7Cj4gPiA+ID4gPiA+ICsJCWVsc2UKPiA+ID4gPiA+ID4gKwkJCWRldi0+bXR1ID0gbXR1
Owo+ID4gPiA+ID4gPiAgIAkJZGV2LT5tYXhfbXR1ID0gbXR1Owo+ID4gPiA+ID4gPiAgIAl9Cj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiA+IDIuMjcuMAo+ID4gPiA+ID4gPgo+
ID4gPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
