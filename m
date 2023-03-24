Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA48C77B61
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 07:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B511760AE4;
	Fri, 24 Mar 2023 07:38:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B511760AE4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n-flIIxGFq0Y; Fri, 24 Mar 2023 07:38:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F74D60AD0;
	Fri, 24 Mar 2023 07:38:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F74D60AD0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29B9CC0035;
	Fri, 24 Mar 2023 07:38:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 583F2C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3374C60AE4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:38:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3374C60AE4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iXucMWrMrxZ6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:38:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7368360AD0
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7368360AD0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:38:28 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VeWlt6a_1679643502; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeWlt6a_1679643502) by smtp.aliyun-inc.com;
 Fri, 24 Mar 2023 15:38:23 +0800
Message-ID: <1679643491.3237138-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v5 05/11] virtio_ring: packed: support premapped
Date: Fri, 24 Mar 2023 15:38:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230324063010.48670-1-xuanzhuo@linux.alibaba.com>
 <20230324063010.48670-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEtoii-vXeFfdcYQ8VMk-PomqNMdpcZ9ymVvZ39zZ=6s0g@mail.gmail.com>
 <1679640931.657412-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEt8JfzdHpcUb=1qY61ho4hdVzjXWoavQ2EPW1bD0SW=YA@mail.gmail.com>
In-Reply-To: <CACGkMEt8JfzdHpcUb=1qY61ho4hdVzjXWoavQ2EPW1bD0SW=YA@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gRnJpLCAyNCBNYXIgMjAyMyAxNTozNzowOCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMjo1N+KAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIEZy
aSwgMjQgTWFyIDIwMjMgMTQ6NDc6NTYgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPiBPbiBGcmksIE1hciAyNCwgMjAyMyBhdCAyOjMw4oCvUE0gWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4g
PiB2aXJ0aW8gY29yZSBvbmx5IHN1cHBvcnRzIHZpcnR1YWwgYWRkcmVzc2VzLCBkbWEgaXMgY29t
cGxldGVkIGluIHZpcnRpbwo+ID4gPiA+IGNvcmUuCj4gPiA+ID4KPiA+ID4gPiBJbiBzb21lIHNj
ZW5hcmlvcyAoc3VjaCBhcyB0aGUgQUZfWERQKSwgdGhlIG1lbW9yeSBpcyBhbGxvY2F0ZWQKPiA+
ID4gPiBhbmQgRE1BIG1hcHBpbmcgaXMgY29tcGxldGVkIGluIGFkdmFuY2UsIHNvIGl0IGlzIG5l
Y2Vzc2FyeSBmb3IgdXMgdG8KPiA+ID4gPiBzdXBwb3J0IHBhc3NpbmcgdGhlIERNQSBhZGRyZXNz
IHRvIHZpcnRpbyBjb3JlLgo+ID4gPiA+Cj4gPiA+ID4gRHJpdmVzIGNhbiB1c2Ugc2ctPmRtYV9h
ZGRyZXNzIHRvIHBhc3MgdGhlIG1hcHBlZCBkbWEgYWRkcmVzcyB0byB2aXJ0aW8KPiA+ID4gPiBj
b3JlLiBJZiBvbmUgc2ctPmRtYV9hZGRyZXNzIGlzIHVzZWQgdGhlbiBhbGwgc2dzIG11c3QgdXNl
Cj4gPiA+ID4gc2ctPmRtYV9hZGRyZXNzLCBvdGhlcndpc2UgYWxsIG11c3QgYmUgbnVsbCB3aGVu
IHBhc3NpbmcgaXQgdG8gdGhlIEFQSXMKPiA+ID4gPiBvZiB2aXJ0aW8uCj4gPiA+ID4KPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+
ID4gPiA+IC0tLQo+ID4gPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMTcgKysr
KysrKysrKysrKystLS0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCj4gPiA+ID4KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gPiBp
bmRleCAxYzMwODRhOGY0ZTMuLmRmNmQ1MTRhNjgxYSAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYwo+ID4gPiA+IEBAIC03OCw2ICs3OCw3IEBAIHN0cnVjdCB2cmluZ19kZXNjX3N0
YXRlX3NwbGl0IHsKPiA+ID4gPiAgc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfcGFja2VkIHsKPiA+
ID4gPiAgICAgICAgIHZvaWQgKmRhdGE7ICAgICAgICAgICAgICAgICAgICAgLyogRGF0YSBmb3Ig
Y2FsbGJhY2suICovCj4gPiA+ID4gICAgICAgICBzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rlc2MgKmlu
ZGlyX2Rlc2M7IC8qIEluZGlyZWN0IGRlc2NyaXB0b3IsIGlmIGFueS4gKi8KPiA+ID4gPiArICAg
ICAgIHU2NCBmbGFnczsgICAgICAgICAgICAgICAgICAgICAgLyogU3RhdGUgZmxhZ3MuICovCj4g
PiA+Cj4gPiA+IEknZCB1c2UgdTMyIHRoZW4gdGhlcmUgd291bGQgYmUgbm8gbmVlZCBmb3IgdGhl
IGNvbXBpbGVyIHRvIHBhZCB0aGUKPiA+ID4gc3RydWN0dXJlIGluIGJvdGggMzIgYW5kIDY0IGJp
dCBhcmNocy4KPiA+Cj4gPgo+ID4gT0suCj4gPgo+ID4gSSBqdXN0IHRyeSB0byBrZWVwIHRoZSBz
YW1lIGFzIHNwbGl0LiBNYXliZSBJIHNob3VsZCBhZGQgc29tZSBub3RlcywKPiA+IGluZGljYXRp
bmcgdGhhdCB0aGVyZSBpcyBzb21lIGRpZmZlcmVuY2UgYmV0d2VlbiBzcGxpdC4KPgo+IEl0IHdv
dWxkIGJlIGJldHRlciB0byB1c2UgYSB1MzIgKyBleHBsaWNpdCBwYWQgZm9yIHNwbGl0IGluIHRo
aXMgY2FzZS4KCldpbGwgZml4LgoKVGhhbmtzLgoKCj4KPiBUaGFua3MKPgo+ID4KPiA+Cj4gPiBU
aGFua3MuCj4gPgo+ID4KPiA+ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPgo+Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
