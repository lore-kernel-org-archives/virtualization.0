Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5C2EB64DC
	for <virtualization@archiver.kernel.org>; Wed, 28 Jun 2023 06:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75D9982012;
	Wed, 28 Jun 2023 06:02:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75D9982012
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id saLGIEN_yCIe; Wed, 28 Jun 2023 06:02:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F135E82073;
	Wed, 28 Jun 2023 06:02:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F135E82073
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5046C0072;
	Wed, 28 Jun 2023 06:02:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 826B8C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 06:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F91B60F11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 06:02:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F91B60F11
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 599_cgskIDQx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 06:02:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15DF460B9B
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15DF460B9B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 06:01:58 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vm8Rt9b_1687932111; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vm8Rt9b_1687932111) by smtp.aliyun-inc.com;
 Wed, 28 Jun 2023 14:01:51 +0800
Message-ID: <1687932052.6412272-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 03/10] virtio_ring: split: support add premapped
 buf
Date: Wed, 28 Jun 2023 14:00:52 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEtFiutSpM--2agR1YhS0MxreH4vFFAEdCaC6E8qxyjZ4g@mail.gmail.com>
 <1687856491.8062844-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEsmxax+kOdQA=e4D_xT0WkTPRcooxRHNvsi6xpaV+8ahQ@mail.gmail.com>
In-Reply-To: <CACGkMEsmxax+kOdQA=e4D_xT0WkTPRcooxRHNvsi6xpaV+8ahQ@mail.gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

T24gV2VkLCAyOCBKdW4gMjAyMyAxMjowNzoxMCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gVHVlLCBKdW4gMjcsIDIwMjMgYXQgNTowNeKAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1
ZSwgMjcgSnVuIDIwMjMgMTY6MDM6MjYgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPiBPbiBGcmksIEp1biAyLCAyMDIzIGF0IDU6MjLigK9QTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+
IElmIHRoZSB2cSBpcyB0aGUgcHJlbWFwcGVkIG1vZGUsIHVzZSB0aGUgc2dfZG1hX2FkZHJlc3Mo
KSBkaXJlY3RseS4KPiA+ID4gPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVh
bnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+ID4gLS0tCj4gPiA+ID4gIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMgfCA0NiArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9u
cygtKQo+ID4gPiA+Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gaW5kZXggMmFmZGZi
OWUzZTMwLi4xODIxMmMzZTA1NmIgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYwo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
PiA+ID4gPiBAQCAtNTk4LDggKzU5OCwxMiBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVf
YWRkX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiA+ID4gPiAgICAgICAgICAgICAgICAg
Zm9yIChzZyA9IHNnc1tuXTsgc2c7IHNnID0gc2dfbmV4dChzZykpIHsKPiA+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBkbWFfYWRkcl90IGFkZHI7Cj4gPiA+ID4KPiA+ID4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICBpZiAodnJpbmdfbWFwX29uZV9zZyh2cSwgc2csIERNQV9UT19ERVZJ
Q0UsICZhZGRyKSkKPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
dW5tYXBfcmVsZWFzZTsKPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAodnEtPnBy
ZW1hcHBlZCkgewo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRkciA9
IHNnX2RtYV9hZGRyZXNzKHNnKTsKPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICB9IGVs
c2Ugewo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZyaW5nX21h
cF9vbmVfc2codnEsIHNnLCBETUFfVE9fREVWSUNFLCAmYWRkcikpCj4gPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gdW5tYXBfcmVsZWFzZTsKPiA+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICB9Cj4gPiA+Cj4gPiA+IEJ0dywgSSB3b25kZXIgd2hl
dGhlciBvciBub3QgaXQgd291bGQgYmUgc2ltcGxlIHRvIGltcGxlbWVudCB0aGUKPiA+ID4gdnEt
PnByZW1hcHBlZCBjaGVjayBpbnNpZGUgdnJpbmdfbWFwX29uZV9zZygpIGFzc3VtaW5nIHRoZQo+
ID4gPiAhdXNlX2RtYV9hcGkgaXMgZG9uZSB0aGVyZSBhcyB3ZWxsLgo+ID4KPiA+Cj4gPiBZRVMs
Cj4gPgo+ID4gVGhhdCB3aWxsIG1vcmUgc2ltcGxlIGZvciB0aGUgY2FsbGVyLgo+ID4KPiA+IEJ1
dCB3ZSB3aWxsIGhhdmUgdGhpbmdzIGxpa2U6Cj4gPgo+ID4gaW50IGZ1bmMoYm9vbCBkbykKPiA+
IHsKPiA+IGlmICghZG8pCj4gPiAgICAgcmV0dXJuOwo+ID4gfQo+ID4KPiA+IEkgbGlrZSB0aGlz
IHdheSwgYnV0IHlvdSBkb24ndCBsaWtlIGl0IGluIGxhc3QgdmVyc2lvbi4KPgo+IEkgc2VlIDop
Cj4KPiBTbyBJIHRoaW5rIGl0IGRlcGVuZHMgb24gdGhlIGVycm9yIGhhbmRsaW5nIHBhdGgsIHdl
IHNob3VsZCBjaG9vc2UgYQo+IHdheSB0aGF0IGNhbiBsZXQgdXMgZWFzaWx5IGRlYWwgd2l0aCBl
cnJvcnMuCj4KPiBGb3IgZXhhbXBsZSwgaXQgc2VlbXMgdGhlIGN1cnJlbnQgYXBwcm9hY2ggaXMg
YmV0dGVyIHNpbmNlIGl0IGRvZXNuJ3QKPiBuZWVkIHRvIGNoYW5nZSB0aGUgdW5tYXBfcmVsZWFz
ZS4KCk5PLAoKVGhlIHVubWFwX3JlbGVhc2UgaXMgc2FtZSBmb3IgdHdvIHdheS4KClRoYW5rcy4K
Cgo+Cj4gVGhhbmtzCj4KPiA+Cj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICBwcmV2ID0gaTsKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBOb3Rl
IHRoYXQgd2UgdHJ1c3QgaW5kaXJlY3QgZGVzY3JpcHRvcgo+ID4gPiA+IEBAIC02MTQsOCArNjE4
LDEyIEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0IHZpcnRx
dWV1ZSAqX3ZxLAo+ID4gPiA+ICAgICAgICAgICAgICAgICBmb3IgKHNnID0gc2dzW25dOyBzZzsg
c2cgPSBzZ19uZXh0KHNnKSkgewo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9h
ZGRyX3QgYWRkcjsKPiA+ID4gPgo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmICh2
cmluZ19tYXBfb25lX3NnKHZxLCBzZywgRE1BX0ZST01fREVWSUNFLCAmYWRkcikpCj4gPiA+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHVubWFwX3JlbGVhc2U7Cj4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZxLT5wcmVtYXBwZWQpIHsKPiA+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZHIgPSBzZ19kbWFfYWRkcmVzcyhzZyk7
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsKPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgRE1B
X0ZST01fREVWSUNFLCAmYWRkcikpCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGdvdG8gdW5tYXBfcmVsZWFzZTsKPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICB9Cj4gPiA+ID4KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBwcmV2ID0g
aTsKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBOb3RlIHRoYXQgd2UgdHJ1c3Qg
aW5kaXJlY3QgZGVzY3JpcHRvcgo+ID4gPiA+IEBAIC02ODksMjEgKzY5NywyMyBAQCBzdGF0aWMg
aW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiA+
ID4gPiAgICAgICAgIHJldHVybiAwOwo+ID4gPiA+Cj4gPiA+ID4gIHVubWFwX3JlbGVhc2U6Cj4g
PiA+ID4gLSAgICAgICBlcnJfaWR4ID0gaTsKPiA+ID4gPiArICAgICAgIGlmICghdnEtPnByZW1h
cHBlZCkgewo+ID4gPgo+ID4gPiBDYW4gdnEtPnByZW1hcHBlZCBiZSB0cnVlIGhlcmU/IFRoZSBs
YWJlbCBpcyBuYW1lZCBhcyAidW5tYXBfcmVsYXNlIgo+ID4gPiB3aGljaCBpbXBsaWVzICJtYXAi
IGJlZm9yZWhhbmQgd2hpY2ggc2VlbXMgbm90IHRoZSBjYXNlIGZvcgo+ID4gPiBwcmVtYXBwaW5n
Lgo+ID4KPiA+IEkgc2VlLgo+ID4KPiA+IFJldGhpbmsgYWJvdXQgdGhpcywgdGhlcmUgaXMgYSBi
ZXR0ZXIgd2F5Lgo+ID4gSSB3aWxsIGZpeCBpbiBuZXh0IHZlcnNpb24uCj4gPgo+ID4KPiA+IFRo
YW5rcy4KPiA+Cj4gPgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4KPiA+ID4gPiArICAg
ICAgICAgICAgICAgZXJyX2lkeCA9IGk7Cj4gPiA+ID4KPiA+ID4gPiAtICAgICAgIGlmIChpbmRp
cmVjdCkKPiA+ID4gPiAtICAgICAgICAgICAgICAgaSA9IDA7Cj4gPiA+ID4gLSAgICAgICBlbHNl
Cj4gPiA+ID4gLSAgICAgICAgICAgICAgIGkgPSBoZWFkOwo+ID4gPiA+IC0KPiA+ID4gPiAtICAg
ICAgIGZvciAobiA9IDA7IG4gPCB0b3RhbF9zZzsgbisrKSB7Cj4gPiA+ID4gLSAgICAgICAgICAg
ICAgIGlmIChpID09IGVycl9pZHgpCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7Cj4gPiA+ID4gLSAgICAgICAgICAgICAgIGlmIChpbmRpcmVjdCkgewo+ID4gPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgIHZyaW5nX3VubWFwX29uZV9zcGxpdF9pbmRpcmVjdCh2cSwgJmRl
c2NbaV0pOwo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGkgPSB2aXJ0aW8xNl90b19j
cHUoX3ZxLT52ZGV2LCBkZXNjW2ldLm5leHQpOwo+ID4gPiA+IC0gICAgICAgICAgICAgICB9IGVs
c2UKPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICBpID0gdnJpbmdfdW5tYXBfb25lX3Nw
bGl0KHZxLCBpKTsKPiA+ID4gPiArICAgICAgICAgICAgICAgaWYgKGluZGlyZWN0KQo+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIGkgPSAwOwo+ID4gPiA+ICsgICAgICAgICAgICAgICBl
bHNlCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaSA9IGhlYWQ7Cj4gPiA+ID4gKwo+
ID4gPiA+ICsgICAgICAgICAgICAgICBmb3IgKG4gPSAwOyBuIDwgdG90YWxfc2c7IG4rKykgewo+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChpID09IGVycl9pZHgpCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBpZiAoaW5kaXJlY3QpIHsKPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZyaW5nX3VubWFwX29uZV9zcGxpdF9pbmRpcmVjdCh2cSwgJmRlc2NbaV0p
Owo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaSA9IHZpcnRpbzE2X3Rv
X2NwdShfdnEtPnZkZXYsIGRlc2NbaV0ubmV4dCk7Cj4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgfSBlbHNlCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpID0g
dnJpbmdfdW5tYXBfb25lX3NwbGl0KHZxLCBpKTsKPiA+ID4gPiArICAgICAgICAgICAgICAgfQo+
ID4gPiA+ICAgICAgICAgfQo+ID4gPiA+Cj4gPiA+ID4gICAgICAgICBpZiAoaW5kaXJlY3QpCj4g
PiA+ID4gLS0KPiA+ID4gPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4gPiA+ID4KPiA+ID4KPiA+Cj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
