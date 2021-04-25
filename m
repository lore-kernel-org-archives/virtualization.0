Return-Path: <SRS0=T5SE=JW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A12C43461
	for <virtualization@archiver.kernel.org>; Sun, 25 Apr 2021 01:43:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23DC161370
	for <virtualization@archiver.kernel.org>; Sun, 25 Apr 2021 01:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DC161370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4CA760903;
	Sun, 25 Apr 2021 01:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vQvcOnbiaW2O; Sun, 25 Apr 2021 01:43:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BDCB60804;
	Sun, 25 Apr 2021 01:43:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4312BC000E;
	Sun, 25 Apr 2021 01:43:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11697C000B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Apr 2021 01:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED77783FE0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Apr 2021 01:43:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WGjIt6BNmZaA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Apr 2021 01:43:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1993183FAA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Apr 2021 01:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619315016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X9SNeh6gyW1M84fzI5vwpJh2K2IpIi8tzyiDHoQ9A5k=;
 b=YGJA+3EiAd5iGYhDgwZ0d62gBDUbpzxxuiFtf7XuNGoTVBzs5YyS/1i5Y8E0taNQvGK+xq
 6ZoJNe+NCMnBkNfRgwIRZzk8NNQ1ldh3Qi4pnMJtzc7bD/qQKSPd5vQgH0q09sHPWijiYz
 MzhoMQrZX6exJcXmbuFaNV9ya6udXdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-IO1z8ijeMsOJOjWuTu6gLw-1; Sat, 24 Apr 2021 21:43:34 -0400
X-MC-Unique: IO1z8ijeMsOJOjWuTu6gLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 452968030B5;
 Sun, 25 Apr 2021 01:43:32 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-44.pek2.redhat.com
 [10.72.13.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71BBB19C46;
 Sun, 25 Apr 2021 01:43:19 +0000 (UTC)
Subject: Re: [RFC PATCH 0/7] Untrusted device support for virtio
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210421032117.5177-1-jasowang@redhat.com>
 <20210422063128.GB4176641@infradead.org>
 <0c61dcbb-ac5b-9815-a4a1-5f93ae640011@redhat.com>
 <20210423161114-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <708f1a31-b4dd-d0b9-cb1e-e94b75a5a752@redhat.com>
Date: Sun, 25 Apr 2021 09:43:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210423161114-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de,
 martin.radev@aisec.fraunhofer.de, kvm@vger.kernel.org, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, xieyongji@bytedance.com,
 stefanha@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzQvMjQg5LiK5Y2INDoxNCwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiBP
biBUaHUsIEFwciAyMiwgMjAyMSBhdCAwNDoxOToxNlBNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+PiDlnKggMjAyMS80LzIyIOS4i+WNiDI6MzEsIENocmlzdG9waCBIZWxsd2lnIOWGmemBkzoK
Pj4+IE9uIFdlZCwgQXByIDIxLCAyMDIxIGF0IDExOjIxOjEwQU0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4+Pj4gVGhlIGJlaGFpdm9yIGZvciBub24gRE1BIEFQSSBpcyBrZXB0IGZvciBtaW5p
bWl6aW5nIHRoZSBwZXJmb3JtYW5jZQo+Pj4+IGltcGFjdC4KPj4+IE5BSy4gIEV2ZXJ5b25lIHNo
b3VsZCBiZSB1c2luZyB0aGUgRE1BIEFQSSBpbiBhIG1vZGVybiB3b3JsZC4gIFNvCj4+PiB0cmVh
dGluZyB0aGUgRE1BIEFQSSBwYXRoIHdvcnNlIHRoYW4gdGhlIGJyb2tlbiBsZWdhY3kgcGF0aCBk
b2VzIG5vdAo+Pj4gbWFrZSBhbnkgc2Vuc2Ugd2hhdHNvZXZlci4KPj4KPj4gSSB0aGluayB0aGUg
Z29hbCBpcyBub3QgdHJlYXQgRE1BIEFQSSBwYXRoIHdvcnNlIHRoYW4gbGVnYWN5LiBUaGUgaXNz
dWUgaXMKPj4gdGhhdCB0aGUgbWFuYWdlbWVudCBsYXllciBzaG91bGQgZ3VhcmFudGVlIHRoYXQg
QUNDRVNTX1BMQVRGT1JNIGlzIHNldCBzbwo+PiBETUEgQVBJIGlzIGd1YXJhbnRlZWQgdG8gYmUg
dXNlZCBieSB0aGUgZHJpdmVyLiBTbyBJJ20gbm90IHN1cmUgaG93IG11Y2gKPj4gdmFsdWUgd2Ug
Y2FuIGdhaW4gZnJvbSB0cnlpbmcgdG8gJ2ZpeCcgdGhlIGxlZ2FjeSBwYXRoLiBCdXQgSSBjYW4g
Y2hhbmdlIHRoZQo+PiBiZWhhdmlvciBvZiBsZWdhY3kgcGF0aCB0byBtYXRjaCBETUEgQVBJIHBh
dGguCj4+Cj4+IFRoYW5rcwo+IEkgdGhpbmsgYmVmb3JlIHdlIG1haW50YWluIGRpZmZlcmVudCBw
YXRocyB3aXRoL3dpdGhvdXQgQUNDRVNTX1BMQVRGT1JNCj4gaXQncyB3b3J0aCBjaGVja2luZyB3
aGV0aGVyIGl0J3MgZXZlbiBhIG5ldCBnYWluLiBBdm9pZGluZyBzaGFyaW5nCj4gYnkgc3Rvcmlu
ZyBkYXRhIGluIHByaXZhdGUgbWVtb3J5IGNhbiBhY3R1YWxseSB0dXJuIG91dCB0byBiZQo+IGEg
bmV0IGdhaW4gZXZlbiB3aXRob3V0IERNQSBBUEkuCgoKSSBhZ3JlZS4KCgo+Cj4gSXQgaXMgd29y
dGggY2hlY2tpbmcgd2hhdCBpcyB0aGUgcGVyZm9ybWFuY2UgZWZmZWN0IG9mIHRoaXMgcGF0Y2gu
CgoKU28gSSd2ZSBwb3N0ZWQgdjIsIHdoZXJlIHByaXZhdGUgbWVtb3J5IGlzIHVzZWQgaW4gbm8g
RE1BIEFQSSBwYXRoIChhcyAKd2hhdCBoYXMgYmVlbiBkb25lIGluIHBhY2tlZCkuCgpQa3RnZW4g
YW5kIG5ldHBlcmYgZG9lbnMndCBzZWUgb2J2aW91cyBkaWZmZXJlbmNlLgoKVGhhbmtzCgoKPgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
