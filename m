Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC378C77B7E
	for <virtualization@archiver.kernel.org>; Mon, 29 May 2023 07:25:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6025A417BC;
	Mon, 29 May 2023 07:25:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6025A417BC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=E+CGf+hS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JXw6ErTMtCBc; Mon, 29 May 2023 07:25:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0741D4032C;
	Mon, 29 May 2023 07:25:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0741D4032C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3FCDC0035;
	Mon, 29 May 2023 07:25:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FA5FC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 07:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4881C831F1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 07:25:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4881C831F1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=E+CGf+hS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gPTc-UzkTLPn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 07:25:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BFBA482F99
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BFBA482F99
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 07:25:31 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2af28a07be9so30176631fa.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 00:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685345129; x=1687937129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuA6Mx7qZk6GEXujcE9++nuvrgV08ZyqT/8PAv9VpyQ=;
 b=E+CGf+hSlas2ziMgKKa6jlYK0xVOwshz/Sz6tFHIvkH+2c2Sf06OVcWnyv3eFsh5LO
 xv7MLLUghSxQ3ASwLN2a853fG3gq89bwejLL/Q2oomoxGxFfGNuJirlLsb42Pr2J+WB+
 7hHsxD5ckzCRvIyqWo2VDSRuQFe/rAE/d+PHamsWvIFyn2mtQpFbjhSFW3OI/IBmqOZJ
 ng4Th1aQI1IUHLr1ob4xiD+a1l0PKm0DSm12Iu8uekGM76S9J7Jko0G8Y7rq0iWJJrB5
 wZUhcKyHdJCUnFZkmqFOOF9G3ELP8+LiT+EXDwXntA/b+HcoqMXlQKvdU8ezF/4dOQk+
 9hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685345129; x=1687937129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fuA6Mx7qZk6GEXujcE9++nuvrgV08ZyqT/8PAv9VpyQ=;
 b=LeN6FWFhr9CsGPPc7nCRmobRJFbBRF2okS0v8PM5+wZmhs1jeXYJhgEG2lpPbUbQHH
 BO4bxlENBQ4d+FV8zBMcRV1xO1aLuPDC4cLShtGWVP5uEuGtMJXKPYihwXuI1cs1N6J0
 qeV9Fb+2ZH8SzvIceVW76D+MKnYXzXceYkDicfEUdUXZ1rV20x8ytvKXLqTQAjXnZImI
 AlU0DHVtpTv8Pj7lJhDl3a+aH+U+EePYths85tPsK186G02Ey2+Tmyv3OCk27TDg+2ET
 p9BNV+swDmmN2kJTdID/6besmRrmbykGqtNJOWo+VGz547U9/KHbJWXdzuYe6ZYgrSu1
 3W9g==
X-Gm-Message-State: AC+VfDwPAlHiKLwiaMW5cwf2oDccXtBEpTsYz9rEMeTHukUVYNTMInI/
 Sv/4ZxVqqEQLIHGOVJL7VpDuMQkds+dwSKVJV5A=
X-Google-Smtp-Source: ACHHUZ6WwUCBaQyc2mmNPx0qmJK6CBQV/NW72H05zZW5Tej2BIzwSvwr6Vpj0zCrsm5svhM9IR7t/+qbyA0PaQiPooU=
X-Received: by 2002:a2e:6a18:0:b0:2ab:e50:315a with SMTP id
 f24-20020a2e6a18000000b002ab0e50315amr3293876ljc.51.1685345129439; Mon, 29
 May 2023 00:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <CACGkMEuUTNfHXQPg29eUZFnVBRJEmjjKN4Jmr3=Qnkgjj0B9PQ@mail.gmail.com>
 <20230528022737-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230528022737-mutt-send-email-mst@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 29 May 2023 15:25:16 +0800
Message-ID: <CAKhg4tL1fkb8JR5+XH_toVDx_c79uH4-fXv8XTDe4gpOFc92VA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] virtio_net: Fix an unsafe reference to the
 page chain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gU3VuLCBNYXkgMjgsIDIwMjMgYXQgMjoyOeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBNYXkgMjYsIDIwMjMgYXQgMDI6Mzg6NTRQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIEZyaSwgTWF5IDI2LCAyMDIzIGF0IDE6
NDbigK9QTSBMaWFuZyBDaGVuIDxsaWFuZ2NoZW4ubGludXhAZ21haWwuY29tPiB3cm90ZToKPiA+
ID4KPiA+ID4gInByaXZhdGUiIG9mIGJ1ZmZlciBwYWdlIGlzIGN1cnJlbnRseSB1c2VkIGZvciBi
aWcgbW9kZSB0byBjaGFpbiBwYWdlcy4KPiA+ID4gQnV0IGluIG1lcmdlYWJsZSBtb2RlLCB0aGF0
IG9mZnNldCBvZiBwYWdlIGNvdWxkIG1lYW4gc29tZXRoaW5nIGVsc2UsCj4gPiA+IGUuZy4gd2hl
biBwYWdlX3Bvb2wgcGFnZSBpcyB1c2VkIGluc3RlYWQuIFNvIGV4Y2x1ZGluZyBtZXJnZWFibGUg
bW9kZSB0bwo+ID4gPiBhdm9pZCBzdWNoIGEgcHJvYmxlbS4KPiA+Cj4gPiBJZiB0aGlzIGlzc3Vl
IGhhcHBlbnMgb25seSBpbiB0aGUgY2FzZSBvZiBwYWdlX3Bvb2wsIGl0IHdvdWxkIGJlCj4gPiBi
ZXR0ZXIgdG8gc3F1YXNoIGl0IHRoZXJlLgo+ID4KPiA+IFRoYW5rcwo+Cj4KPiBUaGlzIGlzIGEg
dGlueSBwYXRjaCBzbyBJIGRvbid0IGNhcmUuIEdlbmVyYWxseSBpdCdzIG9rCj4gdG8gZmlyc3Qg
cmV3b3JrIGNvZGUgdGhlbiBjaGFuZ2UgZnVuY3Rpb25hbGl0eS4KPiBpbiB0aGlzIGNhc2Ugd2hh
dCBKYXNvbiBzYXlzIG9zIHJpZ2h0IGVzcGVjaWFsbHkgYmVjYXVzZQo+IHlvdSB0aGVuIGRvIG5v
dCBuZWVkIHRvIGV4cGxhaW4gdGhhdCBjdXJyZW50IGNvZGUgaXMgb2suCj4KClN1cmUuIGl0IHdp
bGwgYmUgc3F1YXNoZWQgaW50byB0aGUgcGFnZSBwb29sIGVuYWJsZW1lbnQgcGF0Y2guIFRoYW5r
cyEKCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IExpYW5nIENoZW4gPGxpYW5nY2hlbi5saW51
eEBnbWFpbC5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwg
MiArLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
Cj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gaW5kZXggNWE3ZjdhNzZiOTIwLi5jNWRjYTBkOTJl
NjQgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiArKysg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gQEAgLTQ5Nyw3ICs0OTcsNyBAQCBzdGF0
aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsKPiA+ID4KPiA+ID4gICAg
ICAgICAgICAgICAgIHBhZ2UgPSAoc3RydWN0IHBhZ2UgKilwYWdlLT5wcml2YXRlOwo+ID4gPiAt
ICAgICAgICAgICAgICAgaWYgKHBhZ2UpCj4gPiA+ICsgICAgICAgICAgICAgICBpZiAoIXZpLT5t
ZXJnZWFibGVfcnhfYnVmcyAmJiBwYWdlKQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBn
aXZlX3BhZ2VzKHJxLCBwYWdlKTsKPiA+ID4gICAgICAgICAgICAgICAgIGdvdG8gb2s7Cj4gPiA+
ICAgICAgICAgfQo+ID4gPiAtLQo+ID4gPiAyLjMxLjEKPiA+ID4KPgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
