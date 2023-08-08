Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470BDC001B0
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 03:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79FC681EF4;
	Tue,  8 Aug 2023 03:57:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79FC681EF4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C91fJGSHV9Yi; Tue,  8 Aug 2023 03:57:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CB2CF81BD4;
	Tue,  8 Aug 2023 03:57:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB2CF81BD4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94179C0072;
	Tue,  8 Aug 2023 03:57:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7766C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8C1460EE0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:57:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8C1460EE0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RvDar6xo6F7e
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:57:27 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4409260E5F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 03:57:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4409260E5F
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R451e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VpJX3c3_1691467039; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VpJX3c3_1691467039) by smtp.aliyun-inc.com;
 Tue, 08 Aug 2023 11:57:20 +0800
Message-ID: <1691466855.2312648-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 8 Aug 2023 11:54:15 +0800
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
In-Reply-To: <CACGkMEvUJ+GhhfkOB4Ux7-bDaPHvkA3xnvnMMQ+dYfWE4ZzFyw@mail.gmail.com>
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

T24gVHVlLCA4IEF1ZyAyMDIzIDExOjQ5OjA4ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiBPbiBUdWUsIEF1ZyA4LCAyMDIzIGF0IDExOjEy4oCvQU0gWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVHVl
LCA4IEF1ZyAyMDIzIDExOjA4OjA5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4gT24gVHVlLCBBdWcgOCwgMjAyMyBhdCAxMDo1MuKAr0FNIFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4g
T24gVHVlLCA4IEF1ZyAyMDIzIDEwOjI2OjA0ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+IE9uIE1vbiwgQXVnIDcsIDIwMjMgYXQgMjoxNeKA
r1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiBPbiBXZWQsIDIgQXVnIDIwMjMgMDk6NDk6MzEgKzA4MDAsIFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9u
IFR1ZSwgMSBBdWcgMjAyMyAxMjoxNzo0NyAtMDQwMCwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1z
dEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IE9uIEZyaSwgSnVsIDI4LCAyMDIz
IGF0IDAyOjAyOjMzUE0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4g
T24gVHVlLCAyNSBKdWwgMjAyMyAxOTowNzoyMyArMDgwMCwgWHVhbiBaaHVvIDx4dWFuemh1b0Bs
aW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCAyNSBK
dWwgMjAyMyAwMzozNDozNCAtMDQwMCwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDI1LCAyMDIzIGF0
IDEwOjEzOjQ4QU0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gT24gTW9uLCAyNCBKdWwgMjAyMyAwOTo0Mzo0MiAtMDcwMCwgQ2hyaXN0b3BoIEhlbGx3aWcg
PGhjaEBpbmZyYWRlYWQub3JnPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBU
aHUsIEp1bCAyMCwgMjAyMyBhdCAwMToyMTowN1BNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXZWxsIEkgdGhpbmsgd2UgY2FuIGFk
ZCB3cmFwcGVycyBsaWtlIHZpcnRpb19kbWFfc3luYyBhbmQgc28gb24uCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBUaGVyZSBhcmUgTk9QIGZvciBub24tZG1hIHNvIHBhc3NpbmcgdGhlIGRt
YSBkZXZpY2UgaXMgaGFybWxlc3MuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBZZXMsIHBsZWFzZS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSSBhbSBub3Qgc3Vy
ZSBJIGdvdCB0aGlzIGZ1bGx5Lgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBBcmUgeW91IG1lYW4gdGhpczoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwMjE0MDcyNzA0LjEyNjY2MC04LXh1YW56aHVv
QGxpbnV4LmFsaWJhYmEuY29tLwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyMzAyMTQwNzI3MDQuMTI2NjYwLTkteHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20vCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IFRoZW4gdGhlIGRyaXZlciBtdXN0IGRvIGRtYSBvcGVyYXRpb24obWFwIGFuZCBzeW5jKSBieSB0
aGVzZSB2aXJ0aW9fZG1hXyogQVBJcy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gTm8gY2FyZSB0
aGUgZGV2aWNlIGlzIG5vbi1kbWEgZGV2aWNlIG9yIGRtYSBkZXZpY2UuCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4geWVzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGVuIHRoZSBBRl9YRFAgbXVzdCB1c2UgdGhlc2Ugdmly
dGlvX2RtYV8qIEFQSXMgZm9yIHZpcnRpbyBkZXZpY2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gV2UnbGwgd29ycnkgYWJvdXQgQUZfWERQIHdoZW4gdGhlIHBh
dGNoIGlzIHBvc3RlZC4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IFlF
Uy4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IFdlIGRpc2N1c3NlZCBp
dC4gVGhleSB2b3RlZCAnbm8nLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gaHR0cDovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA0MjQwODI4NTYuMTVjMWU1OTNAa2Vy
bmVsLm9yZwo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPiBIaSBndXlzLCB0aGlzIHRvcGljIGlzIHN0dWNrIGFnYWluLiBIb3cgc2hvdWxkIEkgcHJv
Y2VlZCB3aXRoIHRoaXMgd29yaz8KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
TGV0IG1lIGJyaWVmbHkgc3VtbWFyaXplOgo+ID4gPiA+ID4gPiA+ID4gPiAxLiBUaGUgcHJvYmxl
bSB3aXRoIGFkZGluZyB2aXJ0aW9fZG1hX3ttYXAsIHN5bmN9IGFwaSBpcyB0aGF0LCBmb3IgQUZf
WERQIGFuZAo+ID4gPiA+ID4gPiA+ID4gPiB0aGUgZHJpdmVyIGxheWVyLCB3ZSBuZWVkIHRvIHN1
cHBvcnQgdGhlc2UgQVBJcy4gVGhlIGN1cnJlbnQgY29uY2x1c2lvbiBvZgo+ID4gPiA+ID4gPiA+
ID4gPiBBRl9YRFAgaXMgbm8uCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IDIu
IFNldCBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50LCB0aGVuIHdlIGNhbiB1c2UgRE1BIEFQSSB1
bmlmb3JtbHkgaW5zaWRlCj4gPiA+ID4gPiA+ID4gPiA+IGRyaXZlci4gVGhpcyBpZGVhIHNlZW1z
IHRvIGJlIGluY29uc2lzdGVudCB3aXRoIHRoZSBmcmFtZXdvcmsgZGVzaWduIG9mIERNQS4gVGhl
Cj4gPiA+ID4gPiA+ID4gPiA+IGNvbmNsdXNpb24gaXMgbm8uCj4gPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+IDMuIFdlIG5vdGljZWQgdGhhdCBpZiB0aGUgdmlydGlvIGRldmljZSBz
dXBwb3J0cyBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0sIGl0Cj4gPiA+ID4gPiA+ID4gPiA+IHVz
ZXMgRE1BIEFQSS4gQW5kIHRoaXMgdHlwZSBvZiBkZXZpY2UgaXMgdGhlIGZ1dHVyZSBkaXJlY3Rp
b24sIHNvIHdlIG9ubHkKPiA+ID4gPiA+ID4gPiA+ID4gc3VwcG9ydCBETUEgcHJlbWFwcGVkIGZv
ciB0aGlzIHR5cGUgb2YgdmlydGlvIGRldmljZS4gVGhlIHByb2JsZW0gd2l0aCB0aGlzCj4gPiA+
ID4gPiA+ID4gPiA+IHNvbHV0aW9uIGlzIHRoYXQgdmlydHF1ZXVlX2RtYV9kZXYoKSBvbmx5IHJl
dHVybnMgZGV2IGluIHNvbWUgY2FzZXMsIGJlY2F1c2UKPiA+ID4gPiA+ID4gPiA+ID4gVklSVElP
X0ZfQUNDRVNTX1BMQVRGT1JNIGlzIHN1cHBvcnRlZCBpbiBzdWNoIGNhc2VzLgo+ID4gPiA+ID4K
PiA+ID4gPiA+IENvdWxkIHlvdSBleHBsYWluIHRoZSBpc3N1ZSBhIGxpdHRsZSBiaXQgbW9yZT8K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBFLmcgaWYgd2UgbGltaXQgQUZfWERQIHRvIEFDRVNTX1BMQVRG
Uk9NIG9ubHksIHdoeSBkb2VzCj4gPiA+ID4gPiB2aXJ0cXVldWVfZG1hX2RldigpIG9ubHkgcmV0
dXJuIGRldiBpbiBzb21lIGNhc2VzPwo+ID4gPiA+Cj4gPiA+ID4gVGhlIGJlaGF2aW9yIG9mIHZp
cnRxdWV1ZV9kbWFfZGV2KCkgaXMgbm90IHJlbGF0ZWQgdG8gQUZfWERQLgo+ID4gPiA+Cj4gPiA+
ID4gVGhlIHJldHVybiB2YWx1ZSBvZiB2aXJ0cXVldWVfZG1hX2RldigpIGlzIHVzZWQgZm9yIHRo
ZSBETUEgQVBJcy4gU28gaXQgY2FuCj4gPiA+ID4gcmV0dXJuIGRtYSBkZXYgd2hlbiB0aGUgdmly
dGlvIGlzIHdpdGggQUNDRVNTX1BMQVRGT1JNLiBJZiB2aXJ0aW8gaXMgd2l0aG91dAo+ID4gPiA+
IEFDQ0VTU19QTEFURk9STSB0aGVuIGl0IE1VU1QgcmV0dXJuIE5VTEwuCj4gPiA+ID4KPiA+ID4g
PiBJbiB0aGUgdmlydGlvLW5ldCBkcml2ZXIsIGlmIHRoZSB2aXJ0cXVldWVfZG1hX2RldigpIHJl
dHVybnMgZG1hIGRldiwKPiA+ID4gPiB3ZSBjYW4gZW5hYmxlIEFGX1hEUC4gSWYgbm90LCB3ZSBy
ZXR1cm4gZXJyb3IgdG8gQUZfWERQLgo+ID4gPgo+ID4gPiBZZXMsIGFzIGRpc2N1c3NlZCwganVz
dCBoYXZpbmcgd3JhcHBlcnMgaW4gdGhlIHZpcnRpb19yaW5nIGFuZCBkb2luZwo+ID4gPiB0aGUg
c3dpdGNoIHRoZXJlLiBUaGVuIGNhbiB2aXJ0aW8tbmV0IHVzZSB0aGVtIHdpdGhvdXQgd29ycnlp
bmcgYWJvdXQKPiA+ID4gRE1BIGRldGFpbHM/Cj4gPgo+ID4KPiA+IFllcy4gSW4gdGhlIHZpcnRp
byBkcml2ZXJzLCB3ZSBjYW4gdXNlIHRoZSB3cmFwcGVycy4gVGhhdCBpcyBvay4KPiA+Cj4gPiBC
dXQgd2UgYWxzbyBuZWVkIHRvIHN1cHBvcnQgdmlydHF1ZXVlX2RtYV9kZXYoKSBmb3IgQUZfWERQ
LCBiZWNhdXNlIHRoYXQgdGhlCj4gPiBBRl9YRFAgd2lsbCBub3QgdXNlIHRoZSB3cmFwcGVycy4K
Pgo+IFlvdSBtZWFuIEFGX1hEUCBjb3JlIG9yIG90aGVyPyBDb3VsZCB5b3UgZ2l2ZSBtZSBhbiBl
eGFtcGxlPwoKClllcy4gVGhlIEFGX1hEUCBjb3JlLgoKTm93IHRoZSBBRl9YRFAgY29yZSB3aWxs
IGRvIHRoZSBkbWEgb3BlcmF0aW9uLiAgQmVjYXVzZSB0aGF0IHRoZSBtZW1vcnkgaXMKYWxsb2Nh
dGVkIGJ5IHRoZSB1c2VyIGZyb20gdGhlIHVzZXIgc3BhY2UuICBTbyBiZWZvcmUgcHV0dGluZyB0
aGUgbWVtb3J5IHRvIHRoZQpkcml2ZXIsIHRoZSBBRl9YRFAgd2lsbCBkbyB0aGUgZG1hIG1hcHBp
bmcuCgoKaW50IHhwX2RtYV9tYXAoc3RydWN0IHhza19idWZmX3Bvb2wgKnBvb2wsIHN0cnVjdCBk
ZXZpY2UgKmRldiwKCSAgICAgICB1bnNpZ25lZCBsb25nIGF0dHJzLCBzdHJ1Y3QgcGFnZSAqKnBh
Z2VzLCB1MzIgbnJfcGFnZXMpCnsKCXN0cnVjdCB4c2tfZG1hX21hcCAqZG1hX21hcDsKCWRtYV9h
ZGRyX3QgZG1hOwoJaW50IGVycjsKCXUzMiBpOwoKCWRtYV9tYXAgPSB4cF9maW5kX2RtYV9tYXAo
cG9vbCk7CglpZiAoZG1hX21hcCkgewoJCWVyciA9IHhwX2luaXRfZG1hX2luZm8ocG9vbCwgZG1h
X21hcCk7CgkJaWYgKGVycikKCQkJcmV0dXJuIGVycjsKCgkJcmVmY291bnRfaW5jKCZkbWFfbWFw
LT51c2Vycyk7CgkJcmV0dXJuIDA7Cgl9CgoJZG1hX21hcCA9IHhwX2NyZWF0ZV9kbWFfbWFwKGRl
diwgcG9vbC0+bmV0ZGV2LCBucl9wYWdlcywgcG9vbC0+dW1lbSk7CglpZiAoIWRtYV9tYXApCgkJ
cmV0dXJuIC1FTk9NRU07CgoJZm9yIChpID0gMDsgaSA8IGRtYV9tYXAtPmRtYV9wYWdlc19jbnQ7
IGkrKykgewoJCWRtYSA9IGRtYV9tYXBfcGFnZV9hdHRycyhkZXYsIHBhZ2VzW2ldLCAwLCBQQUdF
X1NJWkUsCgkJCQkJIERNQV9CSURJUkVDVElPTkFMLCBhdHRycyk7CgkJaWYgKGRtYV9tYXBwaW5n
X2Vycm9yKGRldiwgZG1hKSkgewoJCQlfX3hwX2RtYV91bm1hcChkbWFfbWFwLCBhdHRycyk7CgkJ
CXJldHVybiAtRU5PTUVNOwoJCX0KCQlpZiAoZG1hX25lZWRfc3luYyhkZXYsIGRtYSkpCgkJCWRt
YV9tYXAtPmRtYV9uZWVkX3N5bmMgPSB0cnVlOwoJCWRtYV9tYXAtPmRtYV9wYWdlc1tpXSA9IGRt
YTsKCX0KCglpZiAocG9vbC0+dW5hbGlnbmVkKQoJCXhwX2NoZWNrX2RtYV9jb250aWd1aXR5KGRt
YV9tYXApOwoKCWVyciA9IHhwX2luaXRfZG1hX2luZm8ocG9vbCwgZG1hX21hcCk7CglpZiAoZXJy
KSB7CgkJX194cF9kbWFfdW5tYXAoZG1hX21hcCwgYXR0cnMpOwoJCXJldHVybiBlcnI7Cgl9CgoJ
cmV0dXJuIDA7Cn0KRVhQT1JUX1NZTUJPTCh4cF9kbWFfbWFwKTsKClRoYW5rcy4KCgo+Cj4gVGhh
bmtzCj4KPiA+Cj4gPiBTbyB0aGF0IGlzIG9rIGZvciB5b3U/Cj4gPgo+ID4gVGhhbmtzLgo+ID4K
PiA+ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBUaGFua3MKPiA+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+
ID4KPiA+ID4gPiA+ID5PdGhlcndpc2UgTlVMTCBpcyByZXR1cm5lZC4KPiA+ID4gPiA+ID4gPiA+
ID4gVGhpcyBvcHRpb24gaXMgY3VycmVudGx5IE5PLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gPiBTbyBJJ20gd29uZGVyaW5nIHdoYXQgc2hvdWxkIEkgZG8sIGZyb20gYSBETUEg
cG9pbnQgb2YgdmlldywgaXMgdGhlcmUgYW55Cj4gPiA+ID4gPiA+ID4gPiA+IHNvbHV0aW9uIGlu
IGNhc2Ugb2YgdXNpbmcgRE1BIEFQST8KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
ID4gVGhhbmsgeW91Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+IEkgdGhpbmsgaXQncyBvayBhdCB0aGlzIHBvaW50LCBDaHJpc3RvcGgganVzdCBhc2tlZCB5
b3UKPiA+ID4gPiA+ID4gPiA+IHRvIGFkZCB3cmFwcGVycyBmb3IgbWFwL3VubWFwIGZvciB1c2Ug
aW4gdmlydGlvIGNvZGUuCj4gPiA+ID4gPiA+ID4gPiBTZWVtcyBsaWtlIGEgY29zbWV0aWMgY2hh
bmdlLCBzaG91bGRuJ3QgYmUgaGFyZC4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFllcywg
dGhhdCBpcyBub3QgaGFyZCwgSSBoYXMgdGhpcyBjb2RlLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gQnV0LCB5b3UgbWVhbiB0aGF0IHRoZSB3cmFwcGVycyBpcyBqdXN0IHVzZWQgZm9yIHRo
ZSB2aXJ0aW8gZHJpdmVyIGNvZGU/Cj4gPiA+ID4gPiA+ID4gQW5kIHdlIGFsc28gb2ZmZXIgdGhl
ICBBUEkgdmlydHF1ZXVlX2RtYV9kZXYoKSBhdCB0aGUgc2FtZSB0aW1lPwo+ID4gPiA+ID4gPiA+
IFRoZW4gdGhlIGRyaXZlciB3aWxsIGhhcyB0d28gY2hvb3NlcyB0byBkbyBETUEuCj4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiBJcyB0aGF0IHNvPwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBQ
aW5nLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBPdGhlcndpc2UgSSBoYXZlbid0IHNl
ZW4gc2lnbmlmaWNhbnQgY29tbWVudHMuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+IENocmlzdG9waCBkbyBJIHN1bW1hcml6ZSB3aGF0IHlvdSBhcmUgc2F5
aW5nIGNvcnJlY3RseT8KPiA+ID4gPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiA+ID4gPiBNU1QKPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4K
PiA+ID4KPiA+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
