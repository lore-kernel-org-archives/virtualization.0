Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28880C76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 06:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C60F60A5F;
	Tue, 11 Apr 2023 06:14:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C60F60A5F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rv0rv5bcAHIx; Tue, 11 Apr 2023 06:14:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 20A8160750;
	Tue, 11 Apr 2023 06:14:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20A8160750
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC49BC0037;
	Tue, 11 Apr 2023 06:14:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C0FDC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB7A540AB9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:14:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB7A540AB9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zXMa4jFNhBJy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:14:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9B59409E6
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9B59409E6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:14:12 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0VfqyN1t_1681193645; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VfqyN1t_1681193645) by smtp.aliyun-inc.com;
 Tue, 11 Apr 2023 14:14:06 +0800
Message-ID: <1681193477.0633929-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 11 Apr 2023 14:11:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-9-xuanzhuo@linux.alibaba.com>
 <73a24f95-b779-44ac-be28-45b35d1bf540@roeck-us.net>
 <20230407064634-mutt-send-email-mst@kernel.org>
 <1681097397.338332-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
 <ZDQq0pDVkr8TvoTM@infradead.org>
 <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEskNEwD0_AZgoDLS2RBv9cpbH5u1q01=cDuawV0NbhK_w@mail.gmail.com>
 <ZDTUn6TUqzrF06mr@infradead.org>
 <CACGkMEtD0BLBXv7S-TLY-Y483_Lx4UskLyPmEC2wyGa8VE_R6w@mail.gmail.com>
In-Reply-To: <CACGkMEtD0BLBXv7S-TLY-Y483_Lx4UskLyPmEC2wyGa8VE_R6w@mail.gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
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

T24gVHVlLCAxMSBBcHIgMjAyMyAxMTo1Njo0NyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMTE6MzHigK9BTSBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+ID4KPiA+IE9uIFR1
ZSwgQXByIDExLCAyMDIzIGF0IDEwOjA5OjQwQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4g
PiA+IFdlIHdhbnQgdG8gc3VwcG9ydCBBRl9YRFAgZm9yIHZpcnRpby1uZXQuIEl0IG1lYW5zIEFG
X1hEUCBuZWVkcyB0bwo+ID4gPiBrbm93IHRoZSBkbWEgZGV2aWNlIHRvIHBlcmZvcm0gRE1BIG1h
cHBpbmcuIFNvIHdlIGludHJvZHVjZSBhIGhlbHBlcgo+ID4gPiB0byBleHBvc2UgdGhlIGRtYSBk
ZXYgb2YgdGhlIHZpcnRpbyBkZXZpY2UuCj4gPgo+ID4gVGhlIHdob2xlIHZpcnRpbyBhcmNoaXRl
Y3R1cmUgaXMgYmFzZWQgYXJvdW5kIHRoZSBjb3JlIGNvZGUgZG9pbmcKPiA+IHRoZSBETUEgbWFw
cGluZy4gIEkgY2FuJ3Qgc2VlIGhvdyB5b3UgY2FuIGp1c3QgZXhwb3J0IGEgaGVscGVyIHRvCj4g
PiBleHBvc2UgdGhlIGRtYSBkZXZpY2UuICBZb3UnZCBoYXZlIHRvIGNvbXBsZXRlIHJld29yayB0
aGUgbGF5ZXJpbmcKPiA+IG9mIHRoZSB2aXJ0aW8gY29kZSBpZiB5b3Ugd2FudCB0byBkbyBpdCBp
biB0aGUgdXBwZXIgbGV2ZWwgZHJpdmVycy4KPiA+IEFuZCB3aHkgd291bGQgeW91IHdhbnQgdG8g
ZG8gdGhpcz8gIFRoZSBsb3ctbGV2ZWwgY29kZSBpcyB0aGUgb25seQo+ID4gcGllY2UgdGhhdCBj
YW4gYWN0dWFsbHkga25vdyBpZiB5b3UgbmVlZCB0byBkbyBhIGRtYSBtYXBwaW5nLiAgQWxsCj4g
PiB0aGUga2VybmVsIHN1YnN5c3RlbXMgdGhhdCBkb24ndCBkbyBpdCBpbnNpZGUgdGhlIGxvdy1s
ZXZlbCBkcml2ZXJzCj4gPiBvciBoZWxwZXJzIGNsb3NlbHkgYXNzb2NpdGF0ZWQgYXJlIGEgZ2lh
bnQgYW5kIGhhcmQgdG8gZml4IG1hcAo+ID4gKHNlZSB1c2IgZm9yIHRoZSBwcmltZSBleGhpYml0
KS4KPiA+Cj4gPiBTbyB0aGUgZmlyc3QgcXVlc3Rpb24gaXM6ICB3aHkgZG8geW91IHdhbnQgdGhp
cyBmb3IgWEZfQURQLAo+Cj4gWHVhbiwgaXMgaXQgcG9zc2libGUgdG8gc2V0IHVwIHRoZSBETUEg
bWFwcGluZyBpbnNpZGUgdGhlIHZpcnRpbwo+IGRyaXZlciBpdHNlbGY/IEkgdmFndWVseSByZW1l
bWJlciBhdCBsZWFzdCB0aGUgUlggYnVmZmVyIG1hcHBpbmcgaXMKPiBkb25lIGJ5IHRoZSBkcml2
ZXIuIElmIHRoaXMgaXMgdHJ1ZSwgd2UgY2FuIGF2b2lkIGV4cG9zaW5nIERNQSBkZXRhaWxzCj4g
dG8gdGhlIHVwcGVyIGxheWVyLgoKCk5PLCBhbGwgZG1hIG1hcGluZyBpcyBkb25lIGluc2lkZSB4
ZHAgc29ja2V0LiBUaGF0IGlzIGRvbmUKd2hlbiBzZXR1cC4KCldoZW4gYWRkaW5nIHRvIFJYIFJp
bmcsIHhkcCBzb2NrZXQgd2lsbCBjYWxsIERNQSBTWU5DLgoKCj4KPiA+IGFuZAo+ID4gdGhlIG5l
eHQgcXVlc3Rpb24gd2lsbCBiZSBob3cgdG8gZG8gdGhhdCB3aXRob3V0IG1ha2luZyBhIGNvbXBs
ZXRlCj4gPiBtZXNzLgo+ID4KPiA+ID4gVGhpcyB3b3JrcyBmaW5lIGFzIGxvbmcgYXMgVklSVElP
X0ZfQUNDRVNTX1BMQVRGT1JNIGlzIG5lZ290aWF0ZWQuIEJ1dAo+ID4gPiB3aGVuIGl0IGlzIG5v
dCwgdGhlIHZpcnRpbyBkcml2ZXIgbmVlZHMgdG8gdXNlIGEgcGh5c2ljYWwgYWRkcmVzcyBzbwo+
ID4gPiB3ZSB3YW50IHRvIGV4cG9zZSB0aGUgdmlydGlvIGRldmljZSB3aXRob3V0IGRtYV9vcHMg
aW4gdGhlIGhvcGUgdGhhdAo+ID4gPiBpdCB3aWxsIGdvIGZvciBkaXJlY3QgbWFwcGluZyB3aGVy
ZSB0aGUgcGh5c2ljYWwgYWRkcmVzcyBpcyB1c2VkLiBCdXQKPiA+ID4gaXQgbWF5IG5vdCB3b3Jr
IG9uIHNvbWUgc3BlY2lmaWMgc2V0dXBzIChhcmNoZXMgdGhhdCBhc3N1bWUgYW4gSU9NTVUKPiA+
ID4gb3IgaGF2ZSBhcmNoIGRtYSBvcHMpLgo+ID4KPiA+IFRoZSBETUEgZGV2aWNlIGZvciB2aXJ0
aW9fcGNpIGlzIHRoZSB1bmRlcmx5aW5nIFBDSSBkZXZpY2UsIGFsd2F5cy4KPiA+ICFWSVJUSU9f
Rl9BQ0NFU1NfUExBVEZPUk0gbWVhbnMgdGhlcmUgaXMgbm8gZG1hIGRldmljZSBhdCBhbGwuICBC
ZWNhdXNlCj4gPiBvZiBhbGwgdGhlc2UgdGhpbmdzIHlvdSBjYW4ndCBqdXN0IGV4cG9zZSBhIHBv
aW50ZXIgdG8gdGhlIGRtYV9kZXZpY2UKPiA+IGFzIHRoYXQgaXMganVzdCBhIGNvbXBsZXRlbHkg
d3Jvbmcgd2F5IG9mIHRoaW5raW5nIGFib3V0IHRoZSBwcm9ibGVtLgo+Cj4gT2ssIHNvIGlmIHRo
ZXJlJ3Mgbm8gRE1BIGF0IGFsbCB3ZSBzaG91bGQgYXZvaWQgdXNpbmcgdGhlIERNQSBBUEkKPiBj
b21wbGV0ZWx5LiBUaGlzIG1lYW5zIHdlIHNob3VsZCBjaGVjayBkbWFfZGV2IGFnYWluc3QgTlVM
TCBpbgo+IHZpcnRpb19oYXNfZG1hX3F1aXJrKCkuCj4KPiBUaGFua3MKPgo+ID4KPgo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0Cj4gVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKPiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
