Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2071EB64DD
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 03:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F93981F06;
	Tue,  8 Aug 2023 03:12:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F93981F06
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Co1Sr04lwumU; Tue,  8 Aug 2023 03:12:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DEA0681E4F;
	Tue,  8 Aug 2023 03:12:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DEA0681E4F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD93CC0071;
	Tue,  8 Aug 2023 03:12:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC9B1C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 848AE60E35
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:12:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 848AE60E35
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3YB5yCKe6Q_G
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:12:44 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B78460E02
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:12:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B78460E02
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R371e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VpJKp.g_1691464356; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VpJKp.g_1691464356) by smtp.aliyun-inc.com;
 Tue, 08 Aug 2023 11:12:37 +0800
Message-ID: <1691464183.5436294-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 8 Aug 2023 11:09:43 +0800
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
In-Reply-To: <CACGkMEsM4cPaMHz-XowU+qpKZL2atZUwYzcUMUfr7N-GN+J2nQ@mail.gmail.com>
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

T24gVHVlLCA4IEF1ZyAyMDIzIDExOjA4OjA5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiBPbiBUdWUsIEF1ZyA4LCAyMDIzIGF0IDEwOjUy4oCvQU0gWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVHVl
LCA4IEF1ZyAyMDIzIDEwOjI2OjA0ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4gT24gTW9uLCBBdWcgNywgMjAyMyBhdCAyOjE14oCvUE0gWHVhbiBa
aHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBP
biBXZWQsIDIgQXVnIDIwMjMgMDk6NDk6MzEgKzA4MDAsIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+ID4gT24gVHVlLCAxIEF1ZyAyMDIzIDEyOjE3
OjQ3IC0wNDAwLCAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+
ID4gPiA+ID4gPiBPbiBGcmksIEp1bCAyOCwgMjAyMyBhdCAwMjowMjozM1BNICswODAwLCBYdWFu
IFpodW8gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gT24gVHVlLCAyNSBKdWwgMjAyMyAxOTowNzoyMyAr
MDgwMCwgWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+
ID4gPiA+ID4gPiBPbiBUdWUsIDI1IEp1bCAyMDIzIDAzOjM0OjM0IC0wNDAwLCAiTWljaGFlbCBT
LiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiBPbiBU
dWUsIEp1bCAyNSwgMjAyMyBhdCAxMDoxMzo0OEFNICswODAwLCBYdWFuIFpodW8gd3JvdGU6Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCAyNCBKdWwgMjAyMyAwOTo0Mzo0MiAtMDcwMCwgQ2hy
aXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IE9uIFRodSwgSnVsIDIwLCAyMDIzIGF0IDAxOjIxOjA3UE0gLTA0MDAsIE1pY2hhZWwg
Uy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gV2VsbCBJIHRoaW5rIHdl
IGNhbiBhZGQgd3JhcHBlcnMgbGlrZSB2aXJ0aW9fZG1hX3N5bmMgYW5kIHNvIG9uLgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBUaGVyZSBhcmUgTk9QIGZvciBub24tZG1hIHNvIHBhc3NpbmcgdGhl
IGRtYSBkZXZpY2UgaXMgaGFybWxlc3MuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gWWVzLCBwbGVhc2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IEkgYW0gbm90IHN1cmUgSSBnb3QgdGhpcyBmdWxs
eS4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IEFyZSB5b3UgbWVhbiB0
aGlzOgo+ID4gPiA+ID4gPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIz
MDIxNDA3MjcwNC4xMjY2NjAtOC14dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbS8KPiA+ID4gPiA+
ID4gPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAyMTQwNzI3MDQuMTI2
NjYwLTkteHVhbnpodW9AbGludXguYWxpYmFiYS5jb20vCj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gPiBUaGVuIHRoZSBkcml2ZXIgbXVzdCBkbyBkbWEgb3BlcmF0aW9uKG1h
cCBhbmQgc3luYykgYnkgdGhlc2UgdmlydGlvX2RtYV8qIEFQSXMuCj4gPiA+ID4gPiA+ID4gPiA+
ID4gTm8gY2FyZSB0aGUgZGV2aWNlIGlzIG5vbi1kbWEgZGV2aWNlIG9yIGRtYSBkZXZpY2UuCj4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IHllcwo+ID4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gPiA+IFRoZW4gdGhlIEFGX1hEUCBtdXN0IHVzZSB0aGVzZSB2aXJ0aW9f
ZG1hXyogQVBJcyBmb3IgdmlydGlvIGRldmljZS4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gV2UnbGwgd29ycnkgYWJvdXQgQUZfWERQIHdoZW4gdGhlIHBhdGNoIGlzIHBvc3Rl
ZC4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBZRVMuCj4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gV2UgZGlzY3Vzc2VkIGl0LiBUaGV5IHZvdGVkICdubycuCj4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gaHR0cDovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA0
MjQwODI4NTYuMTVjMWU1OTNAa2VybmVsLm9yZwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiBIaSBndXlzLCB0aGlzIHRvcGljIGlzIHN0dWNrIGFnYWluLiBIb3cgc2hv
dWxkIEkgcHJvY2VlZCB3aXRoIHRoaXMgd29yaz8KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
IExldCBtZSBicmllZmx5IHN1bW1hcml6ZToKPiA+ID4gPiA+ID4gPiAxLiBUaGUgcHJvYmxlbSB3
aXRoIGFkZGluZyB2aXJ0aW9fZG1hX3ttYXAsIHN5bmN9IGFwaSBpcyB0aGF0LCBmb3IgQUZfWERQ
IGFuZAo+ID4gPiA+ID4gPiA+IHRoZSBkcml2ZXIgbGF5ZXIsIHdlIG5lZWQgdG8gc3VwcG9ydCB0
aGVzZSBBUElzLiBUaGUgY3VycmVudCBjb25jbHVzaW9uIG9mCj4gPiA+ID4gPiA+ID4gQUZfWERQ
IGlzIG5vLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gMi4gU2V0IGRtYV9zZXRfbWFza19h
bmRfY29oZXJlbnQsIHRoZW4gd2UgY2FuIHVzZSBETUEgQVBJIHVuaWZvcm1seSBpbnNpZGUKPiA+
ID4gPiA+ID4gPiBkcml2ZXIuIFRoaXMgaWRlYSBzZWVtcyB0byBiZSBpbmNvbnNpc3RlbnQgd2l0
aCB0aGUgZnJhbWV3b3JrIGRlc2lnbiBvZiBETUEuIFRoZQo+ID4gPiA+ID4gPiA+IGNvbmNsdXNp
b24gaXMgbm8uCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAzLiBXZSBub3RpY2VkIHRoYXQg
aWYgdGhlIHZpcnRpbyBkZXZpY2Ugc3VwcG9ydHMgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNLCBp
dAo+ID4gPiA+ID4gPiA+IHVzZXMgRE1BIEFQSS4gQW5kIHRoaXMgdHlwZSBvZiBkZXZpY2UgaXMg
dGhlIGZ1dHVyZSBkaXJlY3Rpb24sIHNvIHdlIG9ubHkKPiA+ID4gPiA+ID4gPiBzdXBwb3J0IERN
QSBwcmVtYXBwZWQgZm9yIHRoaXMgdHlwZSBvZiB2aXJ0aW8gZGV2aWNlLiBUaGUgcHJvYmxlbSB3
aXRoIHRoaXMKPiA+ID4gPiA+ID4gPiBzb2x1dGlvbiBpcyB0aGF0IHZpcnRxdWV1ZV9kbWFfZGV2
KCkgb25seSByZXR1cm5zIGRldiBpbiBzb21lIGNhc2VzLCBiZWNhdXNlCj4gPiA+ID4gPiA+ID4g
VklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGlzIHN1cHBvcnRlZCBpbiBzdWNoIGNhc2VzLgo+ID4g
Pgo+ID4gPiBDb3VsZCB5b3UgZXhwbGFpbiB0aGUgaXNzdWUgYSBsaXR0bGUgYml0IG1vcmU/Cj4g
PiA+Cj4gPiA+IEUuZyBpZiB3ZSBsaW1pdCBBRl9YRFAgdG8gQUNFU1NfUExBVEZST00gb25seSwg
d2h5IGRvZXMKPiA+ID4gdmlydHF1ZXVlX2RtYV9kZXYoKSBvbmx5IHJldHVybiBkZXYgaW4gc29t
ZSBjYXNlcz8KPiA+Cj4gPiBUaGUgYmVoYXZpb3Igb2YgdmlydHF1ZXVlX2RtYV9kZXYoKSBpcyBu
b3QgcmVsYXRlZCB0byBBRl9YRFAuCj4gPgo+ID4gVGhlIHJldHVybiB2YWx1ZSBvZiB2aXJ0cXVl
dWVfZG1hX2RldigpIGlzIHVzZWQgZm9yIHRoZSBETUEgQVBJcy4gU28gaXQgY2FuCj4gPiByZXR1
cm4gZG1hIGRldiB3aGVuIHRoZSB2aXJ0aW8gaXMgd2l0aCBBQ0NFU1NfUExBVEZPUk0uIElmIHZp
cnRpbyBpcyB3aXRob3V0Cj4gPiBBQ0NFU1NfUExBVEZPUk0gdGhlbiBpdCBNVVNUIHJldHVybiBO
VUxMLgo+ID4KPiA+IEluIHRoZSB2aXJ0aW8tbmV0IGRyaXZlciwgaWYgdGhlIHZpcnRxdWV1ZV9k
bWFfZGV2KCkgcmV0dXJucyBkbWEgZGV2LAo+ID4gd2UgY2FuIGVuYWJsZSBBRl9YRFAuIElmIG5v
dCwgd2UgcmV0dXJuIGVycm9yIHRvIEFGX1hEUC4KPgo+IFllcywgYXMgZGlzY3Vzc2VkLCBqdXN0
IGhhdmluZyB3cmFwcGVycyBpbiB0aGUgdmlydGlvX3JpbmcgYW5kIGRvaW5nCj4gdGhlIHN3aXRj
aCB0aGVyZS4gVGhlbiBjYW4gdmlydGlvLW5ldCB1c2UgdGhlbSB3aXRob3V0IHdvcnJ5aW5nIGFi
b3V0Cj4gRE1BIGRldGFpbHM/CgoKWWVzLiBJbiB0aGUgdmlydGlvIGRyaXZlcnMsIHdlIGNhbiB1
c2UgdGhlIHdyYXBwZXJzLiBUaGF0IGlzIG9rLgoKQnV0IHdlIGFsc28gbmVlZCB0byBzdXBwb3J0
IHZpcnRxdWV1ZV9kbWFfZGV2KCkgZm9yIEFGX1hEUCwgYmVjYXVzZSB0aGF0IHRoZQpBRl9YRFAg
d2lsbCBub3QgdXNlIHRoZSB3cmFwcGVycy4KClNvIHRoYXQgaXMgb2sgZm9yIHlvdT8KClRoYW5r
cy4KCj4KPiBUaGFua3MKPgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+Cj4gPgo+ID4KPiA+ID4KPiA+
ID4gVGhhbmtzCj4gPiA+Cj4gPiA+ID5PdGhlcndpc2UgTlVMTCBpcyByZXR1cm5lZC4KPiA+ID4g
PiA+ID4gPiBUaGlzIG9wdGlvbiBpcyBjdXJyZW50bHkgTk8uCj4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiBTbyBJJ20gd29uZGVyaW5nIHdoYXQgc2hvdWxkIEkgZG8sIGZyb20gYSBETUEgcG9p
bnQgb2YgdmlldywgaXMgdGhlcmUgYW55Cj4gPiA+ID4gPiA+ID4gc29sdXRpb24gaW4gY2FzZSBv
ZiB1c2luZyBETUEgQVBJPwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhhbmsgeW91Cj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEkgdGhpbmsgaXQncyBvayBhdCB0aGlz
IHBvaW50LCBDaHJpc3RvcGgganVzdCBhc2tlZCB5b3UKPiA+ID4gPiA+ID4gdG8gYWRkIHdyYXBw
ZXJzIGZvciBtYXAvdW5tYXAgZm9yIHVzZSBpbiB2aXJ0aW8gY29kZS4KPiA+ID4gPiA+ID4gU2Vl
bXMgbGlrZSBhIGNvc21ldGljIGNoYW5nZSwgc2hvdWxkbid0IGJlIGhhcmQuCj4gPiA+ID4gPgo+
ID4gPiA+ID4gWWVzLCB0aGF0IGlzIG5vdCBoYXJkLCBJIGhhcyB0aGlzIGNvZGUuCj4gPiA+ID4g
Pgo+ID4gPiA+ID4gQnV0LCB5b3UgbWVhbiB0aGF0IHRoZSB3cmFwcGVycyBpcyBqdXN0IHVzZWQg
Zm9yIHRoZSB2aXJ0aW8gZHJpdmVyIGNvZGU/Cj4gPiA+ID4gPiBBbmQgd2UgYWxzbyBvZmZlciB0
aGUgIEFQSSB2aXJ0cXVldWVfZG1hX2RldigpIGF0IHRoZSBzYW1lIHRpbWU/Cj4gPiA+ID4gPiBU
aGVuIHRoZSBkcml2ZXIgd2lsbCBoYXMgdHdvIGNob29zZXMgdG8gZG8gRE1BLgo+ID4gPiA+ID4K
PiA+ID4gPiA+IElzIHRoYXQgc28/Cj4gPiA+ID4KPiA+ID4gPiBQaW5nLgo+ID4gPiA+Cj4gPiA+
ID4gVGhhbmtzCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPiBPdGhlcndp
c2UgSSBoYXZlbid0IHNlZW4gc2lnbmlmaWNhbnQgY29tbWVudHMuCj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+IENocmlzdG9waCBkbyBJIHN1bW1hcml6ZSB3aGF0IHlvdSBhcmUg
c2F5aW5nIGNvcnJlY3RseT8KPiA+ID4gPiA+ID4gLS0KPiA+ID4gPiA+ID4gTVNUCj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+Cj4gPgo+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
