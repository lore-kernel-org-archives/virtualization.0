Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E3AC001B0
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 09:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 06C0C40BE1;
	Tue, 15 Aug 2023 09:40:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06C0C40BE1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tm5qpbcuDn-a; Tue, 15 Aug 2023 09:40:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AE2674094C;
	Tue, 15 Aug 2023 09:40:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE2674094C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7806DC0071;
	Tue, 15 Aug 2023 09:40:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 437A0C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 09:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A65440B08
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 09:40:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A65440B08
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qRw4lMkUuswb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 09:40:14 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A3FA4094C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 09:40:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A3FA4094C
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VprYifQ_1692092406; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VprYifQ_1692092406) by smtp.aliyun-inc.com;
 Tue, 15 Aug 2023 17:40:07 +0800
Message-ID: <1692091669.428807-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 15 Aug 2023 17:27:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
In-Reply-To: <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
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

T24gVHVlLCAxNSBBdWcgMjAyMyAxNTo1MDoyMyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgMjozMuKAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+Cj4gPiBI
aSwgSmFzb24KPiA+Cj4gPiBDb3VsZCB5b3Ugc2tpcCB0aGlzIHBhdGNoPwo+Cj4gSSdtIGZpbmUg
d2l0aCBlaXRoZXIgbWVyZ2luZyBvciBkcm9wcGluZyB0aGlzLgo+Cj4gPgo+ID4gTGV0IHdlIHJl
dmlldyBvdGhlciBwYXRjaGVzIGZpcnN0bHk/Cj4KPiBJIHdpbGwgYmUgb24gdmFjYXRpb24gc29v
biwgYW5kIHdvbid0IGhhdmUgdGltZSB0byBkbyB0aGlzIHVudGlsIG5leHQgd2Vlay4KCkhhdmUg
YSBoYXBwbHkgdmFjYXRpb24uCgo+Cj4gQnV0IEkgc3BvdCB0d28gcG9zc2libGUgImlzc3VlcyI6
Cj4KPiAxKSB0aGUgRE1BIG1ldGFkYXRhIHdlcmUgc3RvcmVkIGluIHRoZSBoZWFkcm9vbSBvZiB0
aGUgcGFnZSwgdGhpcwo+IGJyZWFrcyBmcmFncyBjb2FsZXNjaW5nLCB3ZSBuZWVkIHRvIGJlbmNo
bWFyayBpdCdzIGltcGFjdAoKTm90IGV2ZXJ5IHBhZ2UsIGp1c3QgdGhlIGZpcnN0IHBhZ2Ugb2Yg
dGhlIENPTVAgcGFnZXMuCgpTbyBJIHRoaW5rIHRoZXJlIGlzIG5vIGltcGFjdC4KCgo+IDIpIHBy
ZSBtYXBwZWQgRE1BIGFkZHJlc3NlcyB3ZXJlIG5vdCByZXVzZWQgaW4gdGhlIGNhc2Ugb2YgWERQ
X1RYL1hEUF9SRURJUkVDVAoKQmVjYXVzZSB0aGF0IHRoZSB0eCBpcyBub3QgdGhlIHByZW1hcHBl
ZCBtb2RlLgoKVGhhbmtzLgoKPgo+IEkgc2VlIE1pY2hhZWwgaGFzIG1lcmdlIHRoaXMgc2VyaWVz
IHNvIEknbSBmaW5lIHRvIGxldCBpdCBnbyBmaXJzdC4KPgo+IFRoYW5rcwo+Cj4gPgo+ID4gVGhh
bmtzLgo+ID4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
