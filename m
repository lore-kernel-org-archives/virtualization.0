Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0655BCD4F45
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 09:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E8C940414;
	Fri, 22 Sep 2023 09:56:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E8C940414
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ch6XJqJ258BN; Fri, 22 Sep 2023 09:56:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 16E2440461;
	Fri, 22 Sep 2023 09:56:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16E2440461
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF675C0071;
	Fri, 22 Sep 2023 09:56:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E4C5C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 09:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72F51836F6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 09:56:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72F51836F6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ar66YiXiaSd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 09:56:17 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7463C830A7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 09:56:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7463C830A7
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0Vsd6I4O_1695376569; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vsd6I4O_1695376569) by smtp.aliyun-inc.com;
 Fri, 22 Sep 2023 17:56:10 +0800
Message-ID: <1695376243.9393134-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 5/6] virtio-net: fix the vq coalescing setting for vq
 resize
Date: Fri, 22 Sep 2023 17:50:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
 <20230919074915.103110-6-hengqi@linux.alibaba.com>
 <CACGkMEuJjxAmr6WC9ETYAw2K9dp0AUoD6LSZCduQyUQ9y7oM3Q@mail.gmail.com>
 <c95274cd-d119-402b-baf1-0c500472c9fb@linux.alibaba.com>
 <CACGkMEv4me_mjRJ8wEd-w_b9tjo370d6idioCTmFwJo-3TH3-A@mail.gmail.com>
In-Reply-To: <CACGkMEv4me_mjRJ8wEd-w_b9tjo370d6idioCTmFwJo-3TH3-A@mail.gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Heng Qi <hengqi@linux.alibaba.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Gavin Li <gavinl@nvidia.com>
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

T24gRnJpLCAyMiBTZXAgMjAyMyAxNTozMjozOSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMTowMuKAr1BNIEhl
bmcgUWkgPGhlbmdxaUBsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4KPiA+Cj4gPiDl
nKggMjAyMy85LzIyIOS4i+WNiDEyOjI5LCBKYXNvbiBXYW5nIOWGmemBkzoKPiA+ID4gT24gVHVl
LCBTZXAgMTksIDIwMjMgYXQgMzo0OeKAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5hbGliYWJh
LmNvbT4gd3JvdGU6Cj4gPiA+PiBBY2NvcmRpbmcgdG8gdGhlIGRlZmluaXRpb24gb2YgdmlydHF1
ZXVlIGNvYWxlc2Npbmcgc3BlY1sxXToKPiA+ID4+Cj4gPiA+PiAgICBVcG9uIGRpc2FibGluZyBh
bmQgcmUtZW5hYmxpbmcgYSB0cmFuc21pdCB2aXJ0cXVldWUsIHRoZSBkZXZpY2UgTVVTVCBzZXQK
PiA+ID4+ICAgIHRoZSBjb2FsZXNjaW5nIHBhcmFtZXRlcnMgb2YgdGhlIHZpcnRxdWV1ZSB0byB0
aG9zZSBjb25maWd1cmVkIHRocm91Z2ggdGhlCj4gPiA+PiAgICBWSVJUSU9fTkVUX0NUUkxfTk9U
Rl9DT0FMX1RYX1NFVCBjb21tYW5kLCBvciwgaWYgdGhlIGRyaXZlciBkaWQgbm90IHNldAo+ID4g
Pj4gICAgYW55IFRYIGNvYWxlc2NpbmcgcGFyYW1ldGVycywgdG8gMC4KPiA+ID4+Cj4gPiA+PiAg
ICBVcG9uIGRpc2FibGluZyBhbmQgcmUtZW5hYmxpbmcgYSByZWNlaXZlIHZpcnRxdWV1ZSwgdGhl
IGRldmljZSBNVVNUIHNldAo+ID4gPj4gICAgdGhlIGNvYWxlc2NpbmcgcGFyYW1ldGVycyBvZiB0
aGUgdmlydHF1ZXVlIHRvIHRob3NlIGNvbmZpZ3VyZWQgdGhyb3VnaCB0aGUKPiA+ID4+ICAgIFZJ
UlRJT19ORVRfQ1RSTF9OT1RGX0NPQUxfUlhfU0VUIGNvbW1hbmQsIG9yLCBpZiB0aGUgZHJpdmVy
IGRpZCBub3Qgc2V0Cj4gPiA+PiAgICBhbnkgUlggY29hbGVzY2luZyBwYXJhbWV0ZXJzLCB0byAw
Lgo+ID4gPj4KPiA+ID4+IFdlIG5lZWQgdG8gYWRkIHRoaXMgc2V0dGluZyBmb3IgdnEgcmVzaXpl
IChldGh0b29sIC1HKSB3aGVyZSB2cV9yZXNldCBoYXBwZW5zLgo+ID4gPj4KPiA+ID4+IFsxXSBo
dHRwczovL2xpc3RzLm9hc2lzLW9wZW4ub3JnL2FyY2hpdmVzL3ZpcnRpby1kZXYvMjAyMzAzL21z
ZzAwNDE1Lmh0bWwKPiA+ID4+Cj4gPiA+PiBGaXhlczogMzk0YmQ4Nzc2NGI2ICgidmlydGlvX25l
dDogc3VwcG9ydCBwZXIgcXVldWUgaW50ZXJydXB0IGNvYWxlc2NlIGNvbW1hbmQiKQo+ID4gPiBJ
J20gbm90IHN1cmUgdGhpcyBpcyBhIHJlYWwgZml4IGFzIHNwZWMgYWxsb3dzIGl0IHRvIGdvIHpl
cm8/Cj4gPgo+ID4gVGhlIHNwZWMgc2F5cyB0aGF0IGlmIHRoZSB1c2VyIGhhcyBjb25maWd1cmVk
IGludGVycnVwdCBjb2FsZXNjaW5nCj4gPiBwYXJhbWV0ZXJzLAo+ID4gcGFyYW1ldGVycyBuZWVk
IHRvIGJlIHJlc3RvcmVkIGFmdGVyIHZxX3Jlc2V0LCBvdGhlcndpc2Ugc2V0IHRvIDAuCj4gPiB2
aS0+aW50cl9jb2FsX3R4IGFuZCB2aS0+aW50cl9jb2FsX3J4IGFsd2F5cyBzYXZlIHRoZSBuZXdl
c3QgZ2xvYmFsCj4gPiBwYXJhbWV0ZXJzLAo+ID4gcmVnYXJkbGVzcyBvZiB3aGV0aGVyIHRoZSBj
b21tYW5kIGlzIHNlbnQgb3Igbm90LiBTbyBJIHRoaW5rIHdlIG5lZWQKPiA+IHRoaXMgcGF0Y2gK
PiA+IGl0IGNvbXBsaWVzIHdpdGggdGhlIHNwZWNpZmljYXRpb24gcmVxdWlyZW1lbnRzLgo+Cj4g
SG93IGNhbiB3ZSBtYWtlIHN1cmUgdGhlIG9sZCBjb2FsZXNjaW5nIHBhcmFtZXRlcnMgc3RpbGwg
bWFrZSBzZW5zZQo+IGZvciB0aGUgbmV3IHJpbmcgc2l6ZT8KCkZvciB0aGUgdXNlciwgSSBkb24n
dCB0aGluayB3ZSBzaG91bGQgZHJvcCB0aGUgY29uZmlnIGZvciB0aGUgY29hbGVzY2luZy4KTWF5
YmUgdGhlIGNvbmZpZyBkb2VzIG5vdCBtYWtlIHNlbnNlIGZvciB0aGUgbmV3IHJpbmcgc2l6ZSwg
YnV0IHdoZW4gdGhlIHVzZXIKanVzdCBjaGFuZ2UgdGhlIHJpbmcgc2l6ZSwgdGhlIGNvbmZpZyBm
b3IgdGhlIGNvYWxlc2luZyBpcyBtaXNzaW5nLCBJIHRoaW5rCnRoYXQgaXMgbm90IGdvb2QuCgpU
aGFua3MuCgoKCgo+Cj4gVGhhbmtzCj4KPiA+Cj4gPiBUaGFua3MhCj4gPgo+ID4gPgo+ID4gPiBU
aGFua3MKPiA+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
