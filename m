Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78046C001B0
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 04:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E430C40950;
	Tue,  8 Aug 2023 04:14:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E430C40950
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iKQIA7Fq5TCu; Tue,  8 Aug 2023 04:14:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C9F9D40953;
	Tue,  8 Aug 2023 04:14:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9F9D40953
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92F60C0072;
	Tue,  8 Aug 2023 04:14:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 873E5C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 04:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 492A06105C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 04:14:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 492A06105C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hYeDzSvJr_fP
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 04:13:59 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4465560F2C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 04:13:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4465560F2C
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VpJZ.Ln_1691468031; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VpJZ.Ln_1691468031) by smtp.aliyun-inc.com;
 Tue, 08 Aug 2023 12:13:52 +0800
Message-ID: <1691467643.9424193-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 8 Aug 2023 12:07:23 +0800
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
 <1691462837.6043541-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsM4cPaMHz-XowU+qpKZL2atZUwYzcUMUfr7N-GN+J2nQ@mail.gmail.com>
 <1691464183.5436294-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvUJ+GhhfkOB4Ux7-bDaPHvkA3xnvnMMQ+dYfWE4ZzFyw@mail.gmail.com>
 <1691466855.2312648-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtf8SHZUdpGwDgtWv=Pf02t7RCLSZusFmsyi93TZ7dFkw@mail.gmail.com>
In-Reply-To: <CACGkMEtf8SHZUdpGwDgtWv=Pf02t7RCLSZusFmsyi93TZ7dFkw@mail.gmail.com>
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

T24gVHVlLCA4IEF1ZyAyMDIzIDExOjU5OjA0ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiBPbiBUdWUsIEF1ZyA4LCAyMDIzIGF0IDExOjU34oCvQU0gWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVHVl
LCA4IEF1ZyAyMDIzIDExOjQ5OjA4ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4gT24gVHVlLCBBdWcgOCwgMjAyMyBhdCAxMToxMuKAr0FNIFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4g
T24gVHVlLCA4IEF1ZyAyMDIzIDExOjA4OjA5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+IE9uIFR1ZSwgQXVnIDgsIDIwMjMgYXQgMTA6NTLi
gK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gT24gVHVlLCA4IEF1ZyAyMDIzIDEwOjI2OjA0ICswODAwLCBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBNb24s
IEF1ZyA3LCAyMDIzIGF0IDI6MTXigK9QTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBPbiBXZWQsIDIg
QXVnIDIwMjMgMDk6NDk6MzEgKzA4MDAsIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFi
YS5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIDEgQXVnIDIwMjMgMTI6MTc6
NDcgLTA0MDAsICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gT24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgMDI6MDI6MzNQTSArMDgw
MCwgWHVhbiBaaHVvIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCAyNSBKdWwg
MjAyMyAxOTowNzoyMyArMDgwMCwgWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNv
bT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgMjUgSnVsIDIwMjMgMDM6
MzQ6MzQgLTA0MDAsICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMTA6MTM6
NDhBTSArMDgwMCwgWHVhbiBaaHVvIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
T24gTW9uLCAyNCBKdWwgMjAyMyAwOTo0Mzo0MiAtMDcwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBpbmZyYWRlYWQub3JnPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24g
VGh1LCBKdWwgMjAsIDIwMjMgYXQgMDE6MjE6MDdQTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdlbGwgSSB0aGluayB3ZSBj
YW4gYWRkIHdyYXBwZXJzIGxpa2UgdmlydGlvX2RtYV9zeW5jIGFuZCBzbyBvbi4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGVyZSBhcmUgTk9QIGZvciBub24tZG1hIHNvIHBhc3Np
bmcgdGhlIGRtYSBkZXZpY2UgaXMgaGFybWxlc3MuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFllcywgcGxlYXNlLgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBJIGFtIG5vdCBzdXJlIEkgZ290IHRoaXMgZnVsbHkuCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQXJlIHlvdSBt
ZWFuIHRoaXM6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyMzAyMTQwNzI3MDQuMTI2NjYwLTgteHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20vCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyMzAyMTQwNzI3MDQuMTI2NjYwLTkteHVhbnpodW9AbGludXguYWxpYmFiYS5jb20vCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhl
biB0aGUgZHJpdmVyIG11c3QgZG8gZG1hIG9wZXJhdGlvbihtYXAgYW5kIHN5bmMpIGJ5IHRoZXNl
IHZpcnRpb19kbWFfKiBBUElzLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gTm8gY2FyZSB0
aGUgZGV2aWNlIGlzIG5vbi1kbWEgZGV2aWNlIG9yIGRtYSBkZXZpY2UuCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB5ZXMKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhlbiB0aGUgQUZfWERQIG11
c3QgdXNlIHRoZXNlIHZpcnRpb19kbWFfKiBBUElzIGZvciB2aXJ0aW8gZGV2aWNlLgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gV2UnbGwgd29ycnkg
YWJvdXQgQUZfWERQIHdoZW4gdGhlIHBhdGNoIGlzIHBvc3RlZC4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gWUVTLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXZSBkaXNjdXNzZWQgaXQuIFRoZXkgdm90ZWQgJ25v
Jy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaHR0cDov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA0MjQwODI4NTYuMTVjMWU1OTNAa2VybmVsLm9yZwo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBIaSBndXlzLCB0aGlzIHRvcGljIGlzIHN0dWNrIGFnYWluLiBIb3cgc2hvdWxkIEkg
cHJvY2VlZCB3aXRoIHRoaXMgd29yaz8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBMZXQgbWUgYnJpZWZseSBzdW1tYXJpemU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiAxLiBUaGUgcHJvYmxlbSB3aXRoIGFkZGluZyB2aXJ0aW9fZG1hX3ttYXAsIHN5bmN9IGFwaSBp
cyB0aGF0LCBmb3IgQUZfWERQIGFuZAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdGhlIGRyaXZlciBs
YXllciwgd2UgbmVlZCB0byBzdXBwb3J0IHRoZXNlIEFQSXMuIFRoZSBjdXJyZW50IGNvbmNsdXNp
b24gb2YKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEFGX1hEUCBpcyBuby4KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAyLiBTZXQgZG1hX3NldF9tYXNrX2FuZF9jb2hl
cmVudCwgdGhlbiB3ZSBjYW4gdXNlIERNQSBBUEkgdW5pZm9ybWx5IGluc2lkZQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gZHJpdmVyLiBUaGlzIGlkZWEgc2VlbXMgdG8gYmUgaW5jb25zaXN0ZW50IHdp
dGggdGhlIGZyYW1ld29yayBkZXNpZ24gb2YgRE1BLiBUaGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IGNvbmNsdXNpb24gaXMgbm8uCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gMy4gV2Ugbm90aWNlZCB0aGF0IGlmIHRoZSB2aXJ0aW8gZGV2aWNlIHN1cHBvcnRzIFZJ
UlRJT19GX0FDQ0VTU19QTEFURk9STSwgaXQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHVzZXMgRE1B
IEFQSS4gQW5kIHRoaXMgdHlwZSBvZiBkZXZpY2UgaXMgdGhlIGZ1dHVyZSBkaXJlY3Rpb24sIHNv
IHdlIG9ubHkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHN1cHBvcnQgRE1BIHByZW1hcHBlZCBmb3Ig
dGhpcyB0eXBlIG9mIHZpcnRpbyBkZXZpY2UuIFRoZSBwcm9ibGVtIHdpdGggdGhpcwo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gc29sdXRpb24gaXMgdGhhdCB2aXJ0cXVldWVfZG1hX2RldigpIG9ubHkg
cmV0dXJucyBkZXYgaW4gc29tZSBjYXNlcywgYmVjYXVzZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
VklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGlzIHN1cHBvcnRlZCBpbiBzdWNoIGNhc2VzLgo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gQ291bGQgeW91IGV4cGxhaW4gdGhlIGlzc3VlIGEgbGl0
dGxlIGJpdCBtb3JlPwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gRS5nIGlmIHdlIGxpbWl0
IEFGX1hEUCB0byBBQ0VTU19QTEFURlJPTSBvbmx5LCB3aHkgZG9lcwo+ID4gPiA+ID4gPiA+IHZp
cnRxdWV1ZV9kbWFfZGV2KCkgb25seSByZXR1cm4gZGV2IGluIHNvbWUgY2FzZXM/Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+IFRoZSBiZWhhdmlvciBvZiB2aXJ0cXVldWVfZG1hX2RldigpIGlzIG5v
dCByZWxhdGVkIHRvIEFGX1hEUC4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhlIHJldHVybiB2
YWx1ZSBvZiB2aXJ0cXVldWVfZG1hX2RldigpIGlzIHVzZWQgZm9yIHRoZSBETUEgQVBJcy4gU28g
aXQgY2FuCj4gPiA+ID4gPiA+IHJldHVybiBkbWEgZGV2IHdoZW4gdGhlIHZpcnRpbyBpcyB3aXRo
IEFDQ0VTU19QTEFURk9STS4gSWYgdmlydGlvIGlzIHdpdGhvdXQKPiA+ID4gPiA+ID4gQUNDRVNT
X1BMQVRGT1JNIHRoZW4gaXQgTVVTVCByZXR1cm4gTlVMTC4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gSW4gdGhlIHZpcnRpby1uZXQgZHJpdmVyLCBpZiB0aGUgdmlydHF1ZXVlX2RtYV9kZXYoKSBy
ZXR1cm5zIGRtYSBkZXYsCj4gPiA+ID4gPiA+IHdlIGNhbiBlbmFibGUgQUZfWERQLiBJZiBub3Qs
IHdlIHJldHVybiBlcnJvciB0byBBRl9YRFAuCj4gPiA+ID4gPgo+ID4gPiA+ID4gWWVzLCBhcyBk
aXNjdXNzZWQsIGp1c3QgaGF2aW5nIHdyYXBwZXJzIGluIHRoZSB2aXJ0aW9fcmluZyBhbmQgZG9p
bmcKPiA+ID4gPiA+IHRoZSBzd2l0Y2ggdGhlcmUuIFRoZW4gY2FuIHZpcnRpby1uZXQgdXNlIHRo
ZW0gd2l0aG91dCB3b3JyeWluZyBhYm91dAo+ID4gPiA+ID4gRE1BIGRldGFpbHM/Cj4gPiA+ID4K
PiA+ID4gPgo+ID4gPiA+IFllcy4gSW4gdGhlIHZpcnRpbyBkcml2ZXJzLCB3ZSBjYW4gdXNlIHRo
ZSB3cmFwcGVycy4gVGhhdCBpcyBvay4KPiA+ID4gPgo+ID4gPiA+IEJ1dCB3ZSBhbHNvIG5lZWQg
dG8gc3VwcG9ydCB2aXJ0cXVldWVfZG1hX2RldigpIGZvciBBRl9YRFAsIGJlY2F1c2UgdGhhdCB0
aGUKPiA+ID4gPiBBRl9YRFAgd2lsbCBub3QgdXNlIHRoZSB3cmFwcGVycy4KPiA+ID4KPiA+ID4g
WW91IG1lYW4gQUZfWERQIGNvcmUgb3Igb3RoZXI/IENvdWxkIHlvdSBnaXZlIG1lIGFuIGV4YW1w
bGU/Cj4gPgo+ID4KPiA+IFllcy4gVGhlIEFGX1hEUCBjb3JlLgo+ID4KPiA+IE5vdyB0aGUgQUZf
WERQIGNvcmUgd2lsbCBkbyB0aGUgZG1hIG9wZXJhdGlvbi4gIEJlY2F1c2UgdGhhdCB0aGUgbWVt
b3J5IGlzCj4gPiBhbGxvY2F0ZWQgYnkgdGhlIHVzZXIgZnJvbSB0aGUgdXNlciBzcGFjZS4gIFNv
IGJlZm9yZSBwdXR0aW5nIHRoZSBtZW1vcnkgdG8gdGhlCj4gPiBkcml2ZXIsIHRoZSBBRl9YRFAg
d2lsbCBkbyB0aGUgZG1hIG1hcHBpbmcuCj4gPgo+ID4KPiA+IGludCB4cF9kbWFfbWFwKHN0cnVj
dCB4c2tfYnVmZl9wb29sICpwb29sLCBzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gPiAgICAgICAgICAg
ICAgICB1bnNpZ25lZCBsb25nIGF0dHJzLCBzdHJ1Y3QgcGFnZSAqKnBhZ2VzLCB1MzIgbnJfcGFn
ZXMpCj4gPiB7Cj4KPiBJIHRoaW5rIGl0J3MgdGhlIGRyaXZlciB3aG8gcGFzc2VzIHRoZSBkZXZp
Y2UgcG9pbnRlciBoZXJlLiBBbnl0aGluZyBJIG1pc3NlZD8KCllFUy4KCldoZW4gdGhlIEFGX1hQ
RCBpcyBib25kaW5nIHRvIHRoZSBkZXZpY2UgcXVldWUsIHRoZSBkcml2ZXIgc2hvdWxkIGNhbGwg
dGhpcyB0bwpkbyB0aGUgZG1hIGluc2lkZSB0aGUgQUZfWERQIGNvcmUsIGFuZCB0aGUgZGV2IGlz
IHJlY29yZGVkICBieSB0aGUgQUZfWERQIGNvcmUuCgpUaGUgQUZfWERQIHdpbGwgY2FsbCBkbWFf
c3luYyBBUElzIHdoZW4gdGhlIGRyaXZlciByZWFkcyB0aGUgYnVmZmVycyBmcm9tIHRoZSByeApx
dWV1ZSBhbmQgdGhlIGRyaXZlciB4bWl0IHRoZSBidWZmZXJzIHRvIHRoZSBkZXZpY2UuCgpUaGUg
QUZfWERQIHdpbGwgZG8gc29tZSBETUEgb3BlcmF0aW9uIGF1dG9tYXRpY2FsbHkuClRoZSBETUEg
QVBJcyBpcyB1c2VkIGJ5IHRoZSBBRl9YRFAgY29yZS4KClRoYW5rcy4KCgoKCgo+Cj4gVGhhbmtz
Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
