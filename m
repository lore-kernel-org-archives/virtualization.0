Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC53EB64DD
	for <virtualization@archiver.kernel.org>; Wed,  2 Aug 2023 01:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECB6E81F96;
	Wed,  2 Aug 2023 01:47:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ECB6E81F96
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id szYSNBSTu-wC; Wed,  2 Aug 2023 01:47:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 45DBA80C31;
	Wed,  2 Aug 2023 01:47:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 45DBA80C31
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05137C0072;
	Wed,  2 Aug 2023 01:47:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2EABC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 01:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E85681871
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 01:47:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E85681871
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sgK5IEIFoe7J
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 01:47:46 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98F9581F89
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 01:47:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98F9581F89
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R581e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0VosmxL9_1690940857; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VosmxL9_1690940857) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 09:47:38 +0800
Message-ID: <1690940214.7564142-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Wed, 2 Aug 2023 09:36:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
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
 <20230728080305.5fe3737c@kernel.org>
 <CACGkMEs5uc=ct8BsJzV2SEJzAGXqCP__yxo-MBa6d6JzDG4YOg@mail.gmail.com>
 <20230731084651.16ec0a96@kernel.org>
 <1690855424.7821567-1-xuanzhuo@linux.alibaba.com>
 <20230731193606.25233ed9@kernel.org>
 <1690858650.8698683-2-xuanzhuo@linux.alibaba.com>
 <20230801084510.1c2460b9@kernel.org>
In-Reply-To: <20230801084510.1c2460b9@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S.  Miller" <davem@davemloft.net>
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

T24gVHVlLCAxIEF1ZyAyMDIzIDA4OjQ1OjEwIC0wNzAwLCBKYWt1YiBLaWNpbnNraSA8a3ViYUBr
ZXJuZWwub3JnPiB3cm90ZToKPiBPbiBUdWUsIDEgQXVnIDIwMjMgMTA6NTc6MzAgKzA4MDAgWHVh
biBaaHVvIHdyb3RlOgo+ID4gPiBZb3UgaGF2ZSB0aGlzIHdvcmtpbmcgYW5kIGJlbmNobWFya2Vk
IG9yIHRoaXMgaXMganVzdCBhbmQgaWRlYT8KPiA+Cj4gPiBUaGlzIGlzIG5vdCBqdXN0IGFuIGlk
ZWEuIEkgc2FpZCB0aGF0IGhhcyBiZWVuIHVzZWQgb24gbGFyZ2Ugc2NhbGUuCj4gPgo+ID4gVGhp
cyBpcyB0aGUgbGlicmFyeSBmb3IgdGhlIEFQUCB0byB1c2UgdGhlIEFGX1hEUC4gV2UgaGFzIG9w
ZW4gaXQuCj4gPiBodHRwczovL2dpdGVlLmNvbS9hbm9saXMvbGlieHVkcAo+ID4KPiA+IFRoaXMg
aXMgdGhlIEFsaWJhYmEgdmVyc2lvbiBvZiB0aGUgbmdpbnguIFRoYXQgaGFzIGJlZW4gb3BlbmVk
LCB0aGF0IHN1cHBvcnRlZAo+ID4gdG8gd29yayB3aXRoIHRoZSBsaWJyYXkgdG8gdXNlIEFGX1hE
UC4KPiA+IGh0dHA6Ly90ZW5naW5lLnRhb2Jhby5vcmcvCj4gPgo+ID4gSSBzdXBwb3J0ZWQgdGhp
cyBvbiBvdXIga2VybmVsIHJlbGVhc2UgQW5vbGlzL0FsaW51eC4KPgo+IEludGVyZXN0aW5nIQo+
Cj4gPiBUaGUgd29yayB3YXMgZG9uZSBhYm91dCAyIHllYXJzIGFnby4gWW91IGtub3csIEkgcHVz
aGVkIHRoZSBmaXJzdCB2ZXJzaW9uIHRvCj4gPiBlbmFibGUgQUZfWERQIG9uIHZpcnRpby1uZXQg
YWJvdXQgdHdvIHllYXJzIGFnby4gSSBuZXZlciB0aG91Z2h0IHRoZSBqb2Igd291bGQKPiA+IGJl
IHNvIGRpZmZpY3VsdC4KPgo+IE1lIG5laXRoZXIsIGJ1dCBpdCBpcyB3aGF0IGl0IGlzLgo+Cj4g
PiBUaGUgbmljICh2aXJ0aW8tbmV0KSBvZiBBbGlZdW4gY2FuIHJlYWNoIDI0LDAwMCwwMDBQUFMu
Cj4gPiBTbyBJIHRoaW5rIHRoZXJlIGlzIG5vIGRpZmZlcmVudCB3aXRoIHRoZSByZWFsIEhXIG9u
IHRoZSBwZXJmb3JtYW5jZS4KPiA+Cj4gPiBXaXRoIHRoZSBBRl9YRFAsIHRoZSBVRFAgcHBzIGlz
IHNldmVuIHRpbWVzIHRoYXQgb2YgdGhlIGtlcm5lbCB1ZHAgc3RhY2suCj4KPiBVRFAgcHBzIG9y
IFFVSUMgcHBzPyBVRFAgd2l0aCBvciB3aXRob3V0IEdTTz8KClVEUCBQUFMgd2l0aG91dCBHU08u
Cgo+Cj4gRG8geW91IGhhdmUgbWVhc3VyZW1lbnRzIG9mIGhvdyBtdWNoIGl0IHNhdmVzIGluIHJl
YWwgd29ybGQgd29ya2xvYWRzPwo+IEknbSBhc2tpbmcgbW9zdGx5IG91dCBvZiBjdXJpb3NpdHks
IG5vdCB0byBxdWVzdGlvbiB0aGUgdXNlIGNhc2UuCgpZRVPvvIx0aGUgcmVzdWx0IGlzIGFmZmVj
dGVkIGJ5IHRoZSByZXF1ZXN0IHNpemUsIHdlIGNhbiByZWFjaCAxMC00MCUuClRoZSBzbWFsbGVy
IHRoZSByZXF1ZXN0IHNpemUsIHRoZSBsb3dlciB0aGUgcmVzdWx0LgoKPgo+ID4gPiBXaGF0IGFi
b3V0IGlvX3VyaW5nIHplcm8gY29weSB3LyBwcmUtcmVnaXN0ZXJlZCBidWZmZXJzLgo+ID4gPiBZ
b3UnbGwgZ2V0IGNzdW0gb2ZmbG9hZCwgR1NPLCBhbGwgdGhlIG5vcm1hbCBwZXJmIGZlYXR1cmVz
Lgo+ID4KPiA+IFdlIHRyaWVkIGlvLXVyaW5nLCBidXQgaXQgd2FzIG5vdCBzdWl0YWJsZSBmb3Ig
b3VyIHNjZW5hcmlvLgo+ID4KPiA+IFllcywgbm93IHRoZSBBRl9YRFAgZG9lcyBub3Qgc3VwcG9y
dCB0aGUgY3N1bSBvZmZsb2FkIGFuZCBHU08uCj4gPiBUaGlzIGlzIGluZGVlZCBhIHNtYWxsIHBy
b2JsZW0uCj4KPiBDYW4geW91IHNheSBtb3JlIGFib3V0IGlvLXVyaW5nIHN1aXRhYmlsaXR5PyBJ
dCBjYW4gZG8gemVybyBjb3B5Cj4gYW5kIHJlY2VudGx5LWlzaCBQYXZlbCBvcHRpbWl6ZWQgaXQg
cXVpdGUgYSBiaXQuCgpGaXJzdCwgQUZfWERQIGlzIGFsc28gemVyby1jb3B5LiBXZSBhbHNvIHVz
ZSBYRFAgZm9yIGEgZmV3IHRoaW5ncy4KCkFuZCB0aGlzIHdhcyBhbGwgYWJvdXQgdHdvIHllYXJz
IGFnbywgc28gd2UgaGF2ZSB0byBzYXkgc29tZXRoaW5nIGFib3V0IGlvLXVyaW5nCnR3byB5ZWFy
cyBhZ28uCgpBcyBmYXIgYXMgSSBrbm93LCBpby11cmluZyBzdGlsbCB1c2Uga2VybmVsIHVkcCBz
dGFjaywgQUZfWERQIGNhbgpza2lwIGFsbCBrZXJuZWwgc3RhY2sgZGlyZWN0bHkgdG8gZHJpdmVy
LgoKU28gaGVyZSwgaW8tcmluZyBkb2VzIG5vdCBoYXZlIHRvbyBtdWNoIGFkdmFudGFnZS4KClRo
YW5rcy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
