Return-Path: <SRS0=C5bb=M4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73B6C4338F
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 08:18:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D24F61078
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 08:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D24F61078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FA56403CD;
	Thu,  5 Aug 2021 08:18:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yLCSvKQ3CJj8; Thu,  5 Aug 2021 08:18:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8428D403A2;
	Thu,  5 Aug 2021 08:18:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54A6AC0010;
	Thu,  5 Aug 2021 08:18:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A897CC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 08:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82649403C8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 08:18:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4CARfuMdh88k
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 08:18:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0FDC5403A2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 08:18:40 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F0196104F;
 Thu,  5 Aug 2021 08:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1628151520;
 bh=3Qyqz/XehSHX/KN//v96jroYOCaR+p2m3HMTILA0UBA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1tfTAD2SzzVKWhuczBMWWCBkLmJujhVs6ns1DA/ZOSo0U1X148bi5U7Tw/q0OrooI
 fejyLXMwHkCrIrbtlW97iHgOA0bXRKN2IF340MROLRuSypoXuueXE/6sTbuuy6aRu+
 umdeCMGPzCKRl1oD9ddTkCi+WD9x7kM4XxVtbiqA=
Date: Thu, 5 Aug 2021 10:18:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH v3 1/2] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YQue3tK98e6fAqwP@kroah.com>
References: <20210804025453.93543-1-xianting.tian@linux.alibaba.com>
 <0f26a1c3-53e8-9282-69e8-8d81a9cafc59@kernel.org>
 <40f78d10-0a57-4620-e7e2-f806bd61abca@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <40f78d10-0a57-4620-e7e2-f806bd61abca@linux.alibaba.com>
Cc: arnd@arndb.de, amit@kernel.org, Jiri Slaby <jirislaby@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, osandov@fb.com
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

T24gVGh1LCBBdWcgMDUsIDIwMjEgYXQgMDQ6MDg6NDZQTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3
cm90ZToKPiAKPiDlnKggMjAyMS84LzUg5LiL5Y2IMzo1OCwgSmlyaSBTbGFieSDlhpnpgZM6Cj4g
PiBIaSwKPiA+IAo+ID4gT24gMDQuIDA4LiAyMSwgNDo1NCwgWGlhbnRpbmcgVGlhbiB3cm90ZToK
PiA+ID4gQEAgLTkzMyw2ICs5NDksMTYgQEAgc3RydWN0IGh2Y19zdHJ1Y3QgKmh2Y19hbGxvYyh1
aW50MzJfdCB2dGVybW5vLAo+ID4gPiBpbnQgZGF0YSwKPiA+ID4gwqDCoMKgwqDCoCBocC0+b3V0
YnVmX3NpemUgPSBvdXRidWZfc2l6ZTsKPiA+ID4gwqDCoMKgwqDCoCBocC0+b3V0YnVmID0gJigo
Y2hhciAqKWhwKVtBTElHTihzaXplb2YoKmhwKSwgc2l6ZW9mKGxvbmcpKV07Cj4gPiA+IMKgICvC
oMKgwqAgLyoKPiA+ID4gK8KgwqDCoMKgICogaHZjX2Nvbl9vdXRidWYgaXMgZ3VhcmFudGVlZCB0
byBiZSBhbGlnbmVkIGF0IGxlYXN0IHRvIHRoZQo+ID4gPiArwqDCoMKgwqAgKiBzaXplKE5fT1VU
QlVGKSBieSBrbWFsbG9jKCkuCj4gPiA+ICvCoMKgwqDCoCAqLwo+ID4gPiArwqDCoMKgIGhwLT5o
dmNfY29uX291dGJ1ZiA9IGt6YWxsb2MoTl9PVVRCVUYsIEdGUF9LRVJORUwpOwo+ID4gPiArwqDC
oMKgIGlmICghaHAtPmh2Y19jb25fb3V0YnVmKQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IEVSUl9QVFIoLUVOT01FTSk7Cj4gPiAKPiA+IFRoaXMgbGVha3MgaHAsIHJpZ2h0Pwo+ID4gCj4g
PiBCVFcgeW91ciAyIHBhdGNoZXMgYXJlIHN0aWxsIG5vdCB0aHJlYWRlZCwgdGhhdCBpcyBoYXJk
IHRvIGZvbGxvdy4KPiAKPiB5ZXMsIHRoYW5rcywgSSBmb3VuZCB0aGUgYnVnLCBJIGFtIHByZXBh
cmluZyB0byBkbyB0aGlzIGluIHY0Lgo+IAo+IEl0IGlzIHRoZSBmaXJzdCB0aW1lIEkgc2VuZCBz
ZXJpZXMgcGF0Y2hlcyhudW1iZXIgPjEpLCBJIGNoZWNrZWQgdGhlIG1ldGhvZAo+IGZvciBzZW5k
aW5nIHNlcmllcyBwYXRjaCBvbiBMS01MLm9yZywgSSBzaG91bGQgc2VuZCAnMC8yJyB3aGljaCBp
cyB0aGUKPiBoaXN0b3J5IGluZm8gZm9yIHNlcmllcyBwYXRjaGVzLgoKUGxlYXNlIHVzZSAnZ2l0
IHNlbmQtZW1haWwnIHRvIHNlbmQgdGhlIGZ1bGwgc2VyaWVzIGFsbCBhdCBvbmNlLApvdGhlcndp
c2UgaXQgaXMgaGFyZCB0byBtYWtlIHRoZSBlbWFpbHMgdGhyZWFkZWQgImJ5IGhhbmQiIGlmIHlv
dSBkbyBub3QKZG8gc28uCgp0aGFua3MsCgpncmVnIGstaApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
