Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19D7EB64DD
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 02:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 694C760E00;
	Tue,  8 Aug 2023 02:52:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 694C760E00
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6xCYX4LHGTse; Tue,  8 Aug 2023 02:52:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CFFE960C02;
	Tue,  8 Aug 2023 02:52:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CFFE960C02
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4D7EC0071;
	Tue,  8 Aug 2023 02:52:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87FF5C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5576860E00
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:52:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5576860E00
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3AmNDcJ6dJfO
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:52:05 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A6DF60C02
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:52:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A6DF60C02
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VpJJxIS_1691463117; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VpJJxIS_1691463117) by smtp.aliyun-inc.com;
 Tue, 08 Aug 2023 10:51:58 +0800
Message-ID: <1691462837.6043541-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 8 Aug 2023 10:47:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230801121543-mutt-send-email-mst@kernel.org>
 <1690940971.9409487-2-xuanzhuo@linux.alibaba.com>
 <1691388845.9121156-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsoivXfBV75whjyB0yreUNh7HeucGLw3Bq9Zvu1NGnj_g@mail.gmail.com>
In-Reply-To: <CACGkMEsoivXfBV75whjyB0yreUNh7HeucGLw3Bq9Zvu1NGnj_g@mail.gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

T24gVHVlLCA4IEF1ZyAyMDIzIDEwOjI2OjA0ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiBPbiBNb24sIEF1ZyA3LCAyMDIzIGF0IDI6MTXigK9QTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBXZWQs
IDIgQXVnIDIwMjMgMDk6NDk6MzEgKzA4MDAsIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+IHdyb3RlOgo+ID4gPiBPbiBUdWUsIDEgQXVnIDIwMjMgMTI6MTc6NDcgLTA0MDAs
ICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gT24g
RnJpLCBKdWwgMjgsIDIwMjMgYXQgMDI6MDI6MzNQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3RlOgo+
ID4gPiA+ID4gT24gVHVlLCAyNSBKdWwgMjAyMyAxOTowNzoyMyArMDgwMCwgWHVhbiBaaHVvIDx4
dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+IE9uIFR1ZSwgMjUg
SnVsIDIwMjMgMDM6MzQ6MzQgLTA0MDAsICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMTA6MTM6
NDhBTSArMDgwMCwgWHVhbiBaaHVvIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCAyNCBK
dWwgMjAyMyAwOTo0Mzo0MiAtMDcwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQu
b3JnPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gT24gVGh1LCBKdWwgMjAsIDIwMjMgYXQgMDE6
MjE6MDdQTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4g
PiA+IFdlbGwgSSB0aGluayB3ZSBjYW4gYWRkIHdyYXBwZXJzIGxpa2UgdmlydGlvX2RtYV9zeW5j
IGFuZCBzbyBvbi4KPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGVyZSBhcmUgTk9QIGZvciBub24tZG1h
IHNvIHBhc3NpbmcgdGhlIGRtYSBkZXZpY2UgaXMgaGFybWxlc3MuCj4gPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiA+IFllcywgcGxlYXNlLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBJIGFtIG5vdCBzdXJlIEkgZ290IHRoaXMgZnVsbHkuCj4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gQXJlIHlvdSBtZWFuIHRoaXM6Cj4gPiA+ID4g
PiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAyMTQwNzI3MDQuMTI2NjYw
LTgteHVhbnpodW9AbGludXguYWxpYmFiYS5jb20vCj4gPiA+ID4gPiA+ID4gPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyMzAyMTQwNzI3MDQuMTI2NjYwLTkteHVhbnpodW9AbGludXgu
YWxpYmFiYS5jb20vCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gVGhlbiB0aGUgZHJp
dmVyIG11c3QgZG8gZG1hIG9wZXJhdGlvbihtYXAgYW5kIHN5bmMpIGJ5IHRoZXNlIHZpcnRpb19k
bWFfKiBBUElzLgo+ID4gPiA+ID4gPiA+ID4gTm8gY2FyZSB0aGUgZGV2aWNlIGlzIG5vbi1kbWEg
ZGV2aWNlIG9yIGRtYSBkZXZpY2UuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiB5ZXMKPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gVGhlbiB0aGUgQUZfWERQIG11c3QgdXNlIHRoZXNl
IHZpcnRpb19kbWFfKiBBUElzIGZvciB2aXJ0aW8gZGV2aWNlLgo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gV2UnbGwgd29ycnkgYWJvdXQgQUZfWERQIHdoZW4gdGhlIHBhdGNoIGlzIHBvc3Rl
ZC4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gWUVTLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBX
ZSBkaXNjdXNzZWQgaXQuIFRoZXkgdm90ZWQgJ25vJy4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
aHR0cDovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA0MjQwODI4NTYuMTVjMWU1OTNAa2VybmVs
Lm9yZwo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBIaSBndXlzLCB0aGlzIHRvcGljIGlz
IHN0dWNrIGFnYWluLiBIb3cgc2hvdWxkIEkgcHJvY2VlZCB3aXRoIHRoaXMgd29yaz8KPiA+ID4g
PiA+Cj4gPiA+ID4gPiBMZXQgbWUgYnJpZWZseSBzdW1tYXJpemU6Cj4gPiA+ID4gPiAxLiBUaGUg
cHJvYmxlbSB3aXRoIGFkZGluZyB2aXJ0aW9fZG1hX3ttYXAsIHN5bmN9IGFwaSBpcyB0aGF0LCBm
b3IgQUZfWERQIGFuZAo+ID4gPiA+ID4gdGhlIGRyaXZlciBsYXllciwgd2UgbmVlZCB0byBzdXBw
b3J0IHRoZXNlIEFQSXMuIFRoZSBjdXJyZW50IGNvbmNsdXNpb24gb2YKPiA+ID4gPiA+IEFGX1hE
UCBpcyBuby4KPiA+ID4gPiA+Cj4gPiA+ID4gPiAyLiBTZXQgZG1hX3NldF9tYXNrX2FuZF9jb2hl
cmVudCwgdGhlbiB3ZSBjYW4gdXNlIERNQSBBUEkgdW5pZm9ybWx5IGluc2lkZQo+ID4gPiA+ID4g
ZHJpdmVyLiBUaGlzIGlkZWEgc2VlbXMgdG8gYmUgaW5jb25zaXN0ZW50IHdpdGggdGhlIGZyYW1l
d29yayBkZXNpZ24gb2YgRE1BLiBUaGUKPiA+ID4gPiA+IGNvbmNsdXNpb24gaXMgbm8uCj4gPiA+
ID4gPgo+ID4gPiA+ID4gMy4gV2Ugbm90aWNlZCB0aGF0IGlmIHRoZSB2aXJ0aW8gZGV2aWNlIHN1
cHBvcnRzIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSwgaXQKPiA+ID4gPiA+IHVzZXMgRE1BIEFQ
SS4gQW5kIHRoaXMgdHlwZSBvZiBkZXZpY2UgaXMgdGhlIGZ1dHVyZSBkaXJlY3Rpb24sIHNvIHdl
IG9ubHkKPiA+ID4gPiA+IHN1cHBvcnQgRE1BIHByZW1hcHBlZCBmb3IgdGhpcyB0eXBlIG9mIHZp
cnRpbyBkZXZpY2UuIFRoZSBwcm9ibGVtIHdpdGggdGhpcwo+ID4gPiA+ID4gc29sdXRpb24gaXMg
dGhhdCB2aXJ0cXVldWVfZG1hX2RldigpIG9ubHkgcmV0dXJucyBkZXYgaW4gc29tZSBjYXNlcywg
YmVjYXVzZQo+ID4gPiA+ID4gVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGlzIHN1cHBvcnRlZCBp
biBzdWNoIGNhc2VzLgo+Cj4gQ291bGQgeW91IGV4cGxhaW4gdGhlIGlzc3VlIGEgbGl0dGxlIGJp
dCBtb3JlPwo+Cj4gRS5nIGlmIHdlIGxpbWl0IEFGX1hEUCB0byBBQ0VTU19QTEFURlJPTSBvbmx5
LCB3aHkgZG9lcwo+IHZpcnRxdWV1ZV9kbWFfZGV2KCkgb25seSByZXR1cm4gZGV2IGluIHNvbWUg
Y2FzZXM/CgpUaGUgYmVoYXZpb3Igb2YgdmlydHF1ZXVlX2RtYV9kZXYoKSBpcyBub3QgcmVsYXRl
ZCB0byBBRl9YRFAuCgpUaGUgcmV0dXJuIHZhbHVlIG9mIHZpcnRxdWV1ZV9kbWFfZGV2KCkgaXMg
dXNlZCBmb3IgdGhlIERNQSBBUElzLiBTbyBpdCBjYW4KcmV0dXJuIGRtYSBkZXYgd2hlbiB0aGUg
dmlydGlvIGlzIHdpdGggQUNDRVNTX1BMQVRGT1JNLiBJZiB2aXJ0aW8gaXMgd2l0aG91dApBQ0NF
U1NfUExBVEZPUk0gdGhlbiBpdCBNVVNUIHJldHVybiBOVUxMLgoKSW4gdGhlIHZpcnRpby1uZXQg
ZHJpdmVyLCBpZiB0aGUgdmlydHF1ZXVlX2RtYV9kZXYoKSByZXR1cm5zIGRtYSBkZXYsCndlIGNh
biBlbmFibGUgQUZfWERQLiBJZiBub3QsIHdlIHJldHVybiBlcnJvciB0byBBRl9YRFAuCgpUaGFu
a3MKCgoKCj4KPiBUaGFua3MKPgo+ID5PdGhlcndpc2UgTlVMTCBpcyByZXR1cm5lZC4KPiA+ID4g
PiA+IFRoaXMgb3B0aW9uIGlzIGN1cnJlbnRseSBOTy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBTbyBJ
J20gd29uZGVyaW5nIHdoYXQgc2hvdWxkIEkgZG8sIGZyb20gYSBETUEgcG9pbnQgb2Ygdmlldywg
aXMgdGhlcmUgYW55Cj4gPiA+ID4gPiBzb2x1dGlvbiBpbiBjYXNlIG9mIHVzaW5nIERNQSBBUEk/
Cj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhhbmsgeW91Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IEkg
dGhpbmsgaXQncyBvayBhdCB0aGlzIHBvaW50LCBDaHJpc3RvcGgganVzdCBhc2tlZCB5b3UKPiA+
ID4gPiB0byBhZGQgd3JhcHBlcnMgZm9yIG1hcC91bm1hcCBmb3IgdXNlIGluIHZpcnRpbyBjb2Rl
Lgo+ID4gPiA+IFNlZW1zIGxpa2UgYSBjb3NtZXRpYyBjaGFuZ2UsIHNob3VsZG4ndCBiZSBoYXJk
Lgo+ID4gPgo+ID4gPiBZZXMsIHRoYXQgaXMgbm90IGhhcmQsIEkgaGFzIHRoaXMgY29kZS4KPiA+
ID4KPiA+ID4gQnV0LCB5b3UgbWVhbiB0aGF0IHRoZSB3cmFwcGVycyBpcyBqdXN0IHVzZWQgZm9y
IHRoZSB2aXJ0aW8gZHJpdmVyIGNvZGU/Cj4gPiA+IEFuZCB3ZSBhbHNvIG9mZmVyIHRoZSAgQVBJ
IHZpcnRxdWV1ZV9kbWFfZGV2KCkgYXQgdGhlIHNhbWUgdGltZT8KPiA+ID4gVGhlbiB0aGUgZHJp
dmVyIHdpbGwgaGFzIHR3byBjaG9vc2VzIHRvIGRvIERNQS4KPiA+ID4KPiA+ID4gSXMgdGhhdCBz
bz8KPiA+Cj4gPiBQaW5nLgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+ID4KPiA+ID4KPiA+ID4gPiBP
dGhlcndpc2UgSSBoYXZlbid0IHNlZW4gc2lnbmlmaWNhbnQgY29tbWVudHMuCj4gPiA+ID4KPiA+
ID4gPgo+ID4gPiA+IENocmlzdG9waCBkbyBJIHN1bW1hcml6ZSB3aGF0IHlvdSBhcmUgc2F5aW5n
IGNvcnJlY3RseT8KPiA+ID4gPiAtLQo+ID4gPiA+IE1TVAo+ID4gPiA+Cj4gPiA+Cj4gPgo+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
