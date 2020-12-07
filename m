Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB13C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 03:16:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7151A22CA0
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 03:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7151A22CA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1A8AF87035;
	Mon,  7 Dec 2020 03:16:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OSTOsEFmB5kj; Mon,  7 Dec 2020 03:16:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 89BCD86925;
	Mon,  7 Dec 2020 03:16:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77A89C0FA7;
	Mon,  7 Dec 2020 03:16:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5529DC013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3BA4C8692F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wKC1zFC60YDQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:16:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E1A7986925
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607310994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dx8xPNc5txqLgoNoWkhDZGnh8dCYke8VCzl6Bvht8Zw=;
 b=Zh/izvPeQ8iap9QVDfHTOVryujaqTPziWrV035Iz3ElcylwYz+feo3XtmgwVDLw2EJvA3h
 HXHKPIQ/GY36CSEqBhgPmtcF73oBdrLDRBk+LyX/dDexps9Rzq15EfnJ5PHaZLqzpqavZ4
 wh3sSqJYCtVJkWPQP7XyKQDCtd+J7fg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-rDyZVaG2P06EzToeAzWrug-1; Sun, 06 Dec 2020 22:16:29 -0500
X-MC-Unique: rDyZVaG2P06EzToeAzWrug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37EFB858180;
 Mon,  7 Dec 2020 03:16:28 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C32CC614ED;
 Mon,  7 Dec 2020 03:16:17 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] drivers: gpio: add virtio-gpio guest driver
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <8209ce55-a4aa-f256-b9b9-f7eb3cac877b@redhat.com>
 <96aca1e6-2d5a-deb1-2444-88f938c7a9de@metux.net>
 <20201205142218-mutt-send-email-mst@kernel.org>
 <e69569b5-0c45-e072-5de4-81a4acecdae3@metux.net>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ea3ab147-c975-49dd-72ca-407f3bf86322@redhat.com>
Date: Mon, 7 Dec 2020 11:16:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e69569b5-0c45-e072-5de4-81a4acecdae3@metux.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: stefanha@redhat.com, linux-doc@vger.kernel.org, linus.walleij@linaro.org,
 corbet@lwn.net, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, bgolaszewski@baylibre.com,
 linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org, msuchanek@suse.de,
 "Enrico Weigelt, metux IT consult" <info@metux.net>
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

Ck9uIDIwMjAvMTIvNiDkuIrljYg0OjA1LCBFbnJpY28gV2VpZ2VsdCwgbWV0dXggSVQgY29uc3Vs
dCB3cm90ZToKPiBPbiAwNS4xMi4yMCAyMDozMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
Cj4gSGksCj4KPj4gSXQgc2VlbXMgYSBiaXQgb2YgYSBtZXNzLCBhdCB0aGlzIHBvaW50IEknbSBu
b3QgZW50aXJlbHkgc3VyZSB3aGVuCj4+IHNob3VsZCBkcml2ZXJzIHNlbGVjdCBWSVJUSU8gYW5k
IHdoZW4gZGVwZW5kIG9uIGl0Lgo+IGlmIFZJUlRJTyBqdXN0IGVuYWJsZXMgc29tZXRoaW5nIHRo
YXQgY291bGQgYmUgc2VlbiBhcyBsaWJyYXJ5Cj4gZnVuY3Rpb25zLCB0aGVuIHNlbGVjdCBzaG91
bGQgYmUgcmlnaHQsIElNSE8uCj4KPj4gVGhlIHRleHQgbmVhciBpdCBzYXlzOgo+Pgo+PiAjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKPj4gY29uZmlnIFZJUlRJTwo+PiAg
ICAgICAgICB0cmlzdGF0ZQo+IG9oLCB3YWl0LCBkb2Vzbid0IGhhdmUgYW4gbWVudSB0ZXh0LCBz
byB3ZSBjYW4ndCBldmVuIGV4cGxpY2l0bHkgZW5hYmxlCj4gaXQgKG5vdCBzaG93biBpbiBtZW51
KSAtIG9ubHkgaW1wbGljaXRseS4gV2hpY2ggbWVhbnMgdGhhdCBzb21lIG90aGVyCj4gb3B0aW9u
IG11c3Qgc2VsZWN0IGl0LCBpbiBvcmRlciB0byBiZWNvbWUgYXZhaWxlIGF0IGFsbCwgYW5kIGlu
IG9yZGVyCj4gdG8gbWFrZSBvdGhlcnMgZGVwZW5kaW5nIG9uIGl0IGJlY29taW5nIGF2YWlsYWJs
ZS4KPgo+IElNSE8sIHRoZXJlZm9yZSBzZWxlY3QgaXMgdGhlIGNvcnJlY3QgYXBwcm9hY2guCj4K
Pgo+PiAgICAgICAgICBoZWxwCj4+ICAgICAgICAgICAgVGhpcyBvcHRpb24gaXMgc2VsZWN0ZWQg
YnkgYW55IGRyaXZlciB3aGljaCBpbXBsZW1lbnRzIHRoZSB2aXJ0aW8KPj4gICAgICAgICAgICBi
dXMsIHN1Y2ggYXMgQ09ORklHX1ZJUlRJT19QQ0ksIENPTkZJR19WSVJUSU9fTU1JTywgQ09ORklH
X1JQTVNHCj4+ICAgICAgICAgICAgb3IgQ09ORklHX1MzOTBfR1VFU1QuCj4+Cj4+IFdoaWNoIHNl
ZW1zIGNsZWFyIGVub3VnaCBhbmQgd291bGQgaW5kaWNhdGUgZHJpdmVycyBmb3IgZGV2aWNlcyAq
YmVoaW5kKgo+PiB0aGUgYnVzIHNob3VsZCBub3Qgc2VsZWN0IFZJUlRJTyBhbmQgdGh1cyBwcmVz
dW1hYmx5IHNob3VsZCAiZGVwZW5kIG9uIiBpdC4KPj4gVGhpcyBpcyB2aW9sYXRlZCBpbiB2aXJ0
aW8gY29uc29sZSBhbmQgdmlydGlvIGZzIGRyaXZlcnMuCj4gU2VlIGFib3ZlOiBOQUsuIGJlY2F1
c2UgaXQgY2FuJ3QgZXZlbiBiZSBlbmFibGVkIGRpcmVjdGx5IChieSB0aGUgdXNlcikuCj4gSWYg
aXQgd2Fzbid0IG1lYW50IG90aGVyd2lzZSwgd2UnZCBoYXZlIHRvIGFkZCBhbiBtZW51IHRleHQu
Cj4KPj4gRm9yIGNvbnNvbGUgaXQgc2F5czoKPj4KPj4gY29tbWl0IDlmMzBlYjI5YzUxNDU4OWUx
NmYyOTk5ZWEwNzA1OTg1ODNkMWY2ZWMKPj4gQXV0aG9yOiBNaWNoYWwgU3VjaGFuZWsgPG1zdWNo
YW5la0BzdXNlLmRlPgo+PiBEYXRlOiAgIE1vbiBBdWcgMzEgMTg6NTg6NTAgMjAyMCArMDIwMAo+
Pgo+PiAgICAgIGNoYXI6IHZpcnRpbzogU2VsZWN0IFZJUlRJTyBmcm9tIFZJUlRJT19DT05TT0xF
Lgo+PiAgICAgIAo+PiAgICAgIE1ha2UgaXQgcG9zc2libGUgdG8gaGF2ZSB2aXJ0aW8gY29uc29s
ZSBidWlsdC1pbiB3aGVuCj4+ICAgICAgb3RoZXIgdmlydGlvIGRyaXZlcnMgYXJlIG1vZHVsYXIu
Cj4+ICAgICAgCj4+ICAgICAgU2lnbmVkLW9mZi1ieTogTWljaGFsIFN1Y2hhbmVrIDxtc3VjaGFu
ZWtAc3VzZS5kZT4KPj4gICAgICBSZXZpZXdlZC1ieTogQW1pdCBTaGFoIDxhbWl0QGtlcm5lbC5v
cmc+Cj4+ICAgICAgTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIwMDgzMTE2NTg1
MC4yNjE2My0xLW1zdWNoYW5la0BzdXNlLmRlCj4+ICAgICAgU2lnbmVkLW9mZi1ieTogR3JlZyBL
cm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KPj4KPj4gd2hpY2ggc2Vl
bXMga2luZCBvZiBib2d1cyAtIHdoeSBkbyB3ZSBjYXJlIGFib3V0IGFsbG93aW5nIGEgYnVpbHRp
bgo+PiB2aXJ0aW8gY29uc29sZSBkcml2ZXIgaWYgdGhlIHBjaSB2aXJ0aW8gYnVzIGRyaXZlciBp
cyBhIG1vZHVsZT8KPj4gVGhlcmUgd29uJ3QgYmUgYW55IGRldmljZXMgb24gdGhlIGJ1cyB0byBh
dHRhY2ggdG8gLi4uCj4gV2hlbiB1c2luZyBvdGhlciB0cmFuc3BvcnRzID8KPiBJbiBteSBjdXJy
ZW50IHByb2plY3QsIGVnLiBJJ20gdXNpbmcgbW1pbyAtIG15IGtlcm5lbCBoYXMgcGNpIGNvbXBs
ZXRlbHkKPiBkaXNhYmxlZC4KPgo+PiBJIGFtIGluY2xpbmVkIHRvIGZpeCBjb25zb2xlIGFuZCB2
aXJ0aW8gZnMgdG8gZGVwZW5kIG9uIFZJUlRJTzoKPj4gc2VsZWN0IGlzIGhhcmRlciB0byB1c2Ug
Y29ycmVjdGx5IC4uLgo+IEkgZG9uJ3QgdGhpbmt0IHRoYXQgd291bGQgYmUgZ29vZCAtIGluc3Rl
YWQgZXZlcnlib2R5IHNob3VsZCBqdXN0IHNlbGVjdAo+IFZJUlRJTywgbmV2ZXIgZGVwZW5kIG9u
IGl0IChtYXliZSBkZXBlbmQgb24gVklSVElPX01FTlUgaW5zdGVhZCkKCgpJJ20gZmluZSB3aXRo
IGVpdGhlci4gVGhvdWdoIEkgcHJlZmVyIHRvIHVzZSBzZWxlY3QgYnV0IGl0IGxvb2tzIHRvIG1l
IAphZGRpbmcgYSBwcm9tcHQgYW5kIHVzZSBlbmFibGUgd291bGQgYmUgZWFzaWVyLgoKVGhhbmtz
CgoKPgo+Cj4gLS1tdHgKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
