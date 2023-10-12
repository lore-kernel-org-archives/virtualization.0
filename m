Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50447CDB46E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 08:33:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D462A40492;
	Thu, 12 Oct 2023 08:33:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D462A40492
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NKmp_mulomUA; Thu, 12 Oct 2023 08:33:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DF54B40004;
	Thu, 12 Oct 2023 08:33:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF54B40004
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B50B6C0071;
	Thu, 12 Oct 2023 08:33:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C835FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 08:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9CAF6822F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 08:33:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CAF6822F2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8OaITdVvbPaG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 08:33:32 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C84C2822A5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 08:33:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C84C2822A5
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VtzyJcc_1697099604; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VtzyJcc_1697099604) by smtp.aliyun-inc.com;
 Thu, 12 Oct 2023 16:33:25 +0800
Message-ID: <1697099560.6227698-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 00/22] virtio-net: support AF_XDP zero copy
Date: Thu, 12 Oct 2023 16:32:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011100057.535f3834@kernel.org>
 <1697075634.444064-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsadYH8Y-KOxPX6vPic7pBqzj2DLnog5osuBDtypKgEZA@mail.gmail.com>
In-Reply-To: <CACGkMEsadYH8Y-KOxPX6vPic7pBqzj2DLnog5osuBDtypKgEZA@mail.gmail.com>
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

T24gVGh1LCAxMiBPY3QgMjAyMyAxNTo1MDoxMyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgOTo1OOKAr0FNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFdl
ZCwgMTEgT2N0IDIwMjMgMTA6MDA6NTcgLTA3MDAsIEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5l
bC5vcmc+IHdyb3RlOgo+ID4gPiBPbiBXZWQsIDExIE9jdCAyMDIzIDE3OjI3OjA2ICswODAwIFh1
YW4gWmh1byB3cm90ZToKPiA+ID4gPiAjIyBBRl9YRFAKPiA+ID4gPgo+ID4gPiA+IFhEUCBzb2Nr
ZXQoQUZfWERQKSBpcyBhbiBleGNlbGxlbnQgYnlwYXNzIGtlcm5lbCBuZXR3b3JrIGZyYW1ld29y
ay4gVGhlIHplcm8KPiA+ID4gPiBjb3B5IGZlYXR1cmUgb2YgeHNrIChYRFAgc29ja2V0KSBuZWVk
cyB0byBiZSBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlci4gVGhlCj4gPiA+ID4gcGVyZm9ybWFuY2Ug
b2YgemVybyBjb3B5IGlzIHZlcnkgZ29vZC4gbWx4NSBhbmQgaW50ZWwgaXhnYmUgYWxyZWFkeSBz
dXBwb3J0Cj4gPiA+ID4gdGhpcyBmZWF0dXJlLCBUaGlzIHBhdGNoIHNldCBhbGxvd3MgdmlydGlv
LW5ldCB0byBzdXBwb3J0IHhzaydzIHplcm9jb3B5IHhtaXQKPiA+ID4gPiBmZWF0dXJlLgo+ID4g
Pgo+ID4gPiBZb3UncmUgbW92aW5nIHRoZSBkcml2ZXIgYW5kIGFkZGluZyBhIG1ham9yIGZlYXR1
cmUuCj4gPiA+IFRoaXMgcmVhbGx5IG5lZWRzIHRvIGdvIHZpYSBuZXQgb3IgYnBmLgo+ID4gPiBJ
ZiB5b3UgaGF2ZSBkZXBlbmRlbmNpZXMgaW4gb3RoZXIgdHJlZXMgcGxlYXNlIHdhaXQgZm9yCj4g
PiA+IGFmdGVyIHRoZSBtZXJnZSB3aW5kb3cuCj4gPgo+ID4KPiA+IElmIHNvLCBJIGNhbiByZW1v
dmUgdGhlIGZpcnN0IHR3byBjb21taXRzLgo+ID4KPiA+IFRoZW4sIHRoZSBzcSB1c2VzIHRoZSBw
cmVtYXBwZWQgbW9kZSBieSBkZWZhdWx0Lgo+ID4gQW5kIHdlIGNhbiB1c2UgdGhlIGFwaSB2aXJ0
cXVldWVfZG1hX21hcF9zaW5nbGVfYXR0cnMgdG8gcmVwbGFjZSB0aGUKPiA+IHZpcnRxdWV1ZV9k
bWFfbWFwX3BhZ2VfYXR0cnMuCj4gPgo+ID4gQW5kIHRoZW4gSSB3aWxsIGZpeCB0aGF0IG9uIHRo
ZSB0b3AuCj4gPgo+ID4gSGkgTWljaGVhbCBhbmQgSmFzb24sIGlzIHRoYXQgb2sgZm9yIHlvdT8K
Pgo+IEkgd291bGQgZ28gd2l0aCB3aGF0IGxvb2tzIGVhc3kgZm9yIHlvdSBidXQgSSB0aGluayBK
YWt1YiB3YW50cyB0aGUKPiBzZXJpZXMgdG8gZ28gd2l0aCBuZXh0LW5leHQgKHRoaXMgaXMgd2hh
dCB3ZSBkaWQgaW4gdGhlIHBhc3QgZm9yCj4gbmV0d29ya2luZyBzcGVjaWZpYyBmZWF0dXJlcyB0
aGF0IGlzIGRvbmUgaW4gdmlydGlvLW5ldCkuIFNvIHdlIG5lZWQKPiB0byB0d2VhayB0aGUgcHJl
Zml4IHRvIHVzZSBuZXQtbmV4dCBpbnN0ZWFkIG9mIHZob3N0LgoKT0suCgpJIHdpbGwgZml4IHRo
YXQgaW4gbmV4dCB2ZXJzaW9uLgoKVGhhbmtzLgoKPgo+IFRoYW5rcwo+Cj4KPiA+Cj4gPiBUaGFu
a3MuCj4gPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
