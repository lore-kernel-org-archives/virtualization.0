Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB65FC2B9F4
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 05:55:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03A4613B9
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 05:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03A4613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6835D6075F;
	Thu, 17 Jun 2021 05:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vxp0imRHhWNx; Thu, 17 Jun 2021 05:55:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 245D460761;
	Thu, 17 Jun 2021 05:55:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07664C000D;
	Thu, 17 Jun 2021 05:55:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1490EC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 05:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E26CE83D73
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 05:55:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WU4AQTgtWh7O
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 05:55:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FA8583D70
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 05:55:01 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0UcguTXL_1623909298; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UcguTXL_1623909298) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 17 Jun 2021 13:54:58 +0800
MIME-Version: 1.0
Message-Id: <1623909234.193789-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 13/15] virtio-net: support AF_XDP zc rx
Date: Thu, 17 Jun 2021 13:53:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <d036be55-6d85-f64c-21c5-926403e18ff4@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

T24gVGh1LCAxNyBKdW4gMjAyMSAxMToyMzo1MiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMS82LzEwIOS4i+WNiDQ6MjIsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBDb21wYXJlZCB0byB0aGUgY2FzZSBvZiB4c2sgdHgsIHRoZSBjYXNlIG9m
IHhzayB6YyByeCBpcyBtb3JlCj4gPiBjb21wbGljYXRlZC4KPiA+Cj4gPiBXaGVuIHdlIHByb2Nl
c3MgdGhlIGJ1ZiByZWNlaXZlZCBieSB2cSwgd2UgbWF5IGVuY291bnRlciBvcmRpbmFyeQo+ID4g
YnVmZmVycywgb3IgeHNrIGJ1ZmZlcnMuIFdoYXQgbWFrZXMgdGhlIHNpdHVhdGlvbiBtb3JlIGNv
bXBsaWNhdGVkIGlzCj4gPiB0aGF0IGluIHRoZSBjYXNlIG9mIG1lcmdlYWJsZSwgd2hlbiBudW1f
YnVmZmVyID4gMSwgd2UgbWF5IHN0aWxsCj4gPiBlbmNvdW50ZXIgdGhlIGNhc2Ugd2hlcmUgeHNr
IGJ1ZmZlciBpcyBtaXhlZCB3aXRoIG9yZGluYXJ5IGJ1ZmZlci4KPiA+Cj4gPiBBbm90aGVyIHRo
aW5nIHRoYXQgbWFrZXMgdGhlIHNpdHVhdGlvbiBtb3JlIGNvbXBsaWNhdGVkIGlzIHRoYXQgd2hl
biB3ZQo+ID4gZ2V0IGFuIHhzayBidWZmZXIgZnJvbSB2cSwgdGhlIHhzayBib3VuZCB0byB0aGlz
IHhzayBidWZmZXIgbWF5IGhhdmUKPiA+IGJlZW4gdW5ib3VuZC4KPiA+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+Cj4KPiBUaGlzIGlz
IHNvbWVob3cgc2ltaWxhciB0byB0aGUgY2FzZSBvZiB0eCB3aGVyZSB3ZSBkb24ndCBoYXZlIHBl
ciB2cSByZXNldC4KPgo+IFsuLi5dCj4KPiA+Cj4gPiAtCWlmICh2aS0+bWVyZ2VhYmxlX3J4X2J1
ZnMpCj4gPiArCWlmIChpc194c2tfY3R4KGN0eCkpCj4gPiArCQlza2IgPSByZWNlaXZlX3hzayhk
ZXYsIHZpLCBycSwgYnVmLCBsZW4sIHhkcF94bWl0LCBzdGF0cyk7Cj4gPiArCWVsc2UgaWYgKHZp
LT5tZXJnZWFibGVfcnhfYnVmcykKPiA+ICAgCQlza2IgPSByZWNlaXZlX21lcmdlYWJsZShkZXYs
IHZpLCBycSwgYnVmLCBjdHgsIGxlbiwgeGRwX3htaXQsCj4gPiAgIAkJCQkJc3RhdHMpOwo+ID4g
ICAJZWxzZSBpZiAodmktPmJpZ19wYWNrZXRzKQo+ID4gQEAgLTExNzUsNiArMTI5NiwxNCBAQCBz
dGF0aWMgYm9vbCB0cnlfZmlsbF9yZWN2KHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1Y3Qg
cmVjZWl2ZV9xdWV1ZSAqcnEsCj4gPiAgIAlpbnQgZXJyOwo+ID4gICAJYm9vbCBvb207Cj4gPgo+
ID4gKwkvKiBCZWNhdXNlIHZpcnRpby1uZXQgZG9lcyBub3QgeWV0IHN1cHBvcnQgZmxvdyBkaXJl
Y3QsCj4KPgo+IE5vdGUgdGhhdCB0aGlzIGlzIG5vdCB0aGUgY2FzZSBhbnkgbW9yZS4gUlNTIGhh
cyBiZWVuIHN1cHBvcnRlZCBieQo+IHZpcnRpbyBzcGVjIGFuZCBxZW11L3Zob3N0L3RhcCBub3cu
IFdlIGp1c3QgbmVlZCBzb21lIHdvcmsgb24gdGhlCj4gdmlydGlvLW5ldCBkcml2ZXIgcGFydCAo
ZS5nIHRoZSBldGhvb2wgaW50ZXJmYWNlKS4KCk9oLCBhcmUgdGhlcmUgYW55IHBsYW5zPyBXaG8g
aXMgZG9pbmcgdGhpcyB3b3JrLCBjYW4gSSBoZWxwPwoKVGhhbmtzLgoKPgo+IFRoYW5rcwo+Cj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
