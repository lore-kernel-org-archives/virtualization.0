Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C4AC433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 00:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4066881A27;
	Thu,  9 Dec 2021 00:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cdOYW3LM3N84; Thu,  9 Dec 2021 00:19:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA65F8271A;
	Thu,  9 Dec 2021 00:19:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C19CC0038;
	Thu,  9 Dec 2021 00:19:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 188DEC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04BB64027F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:19:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QysKsPfdF7g9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:19:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3DBED40143
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639009162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDoJ4BZ4/DkxCZbzgnEUNi4EMWL80ft0a8ylUyJRFaQ=;
 b=EmKkQrWB8W24tnA0fojG96nv2SbsyPQklpQperCV3DNZ4aVx/6QCKWPJ8CGcU5tGlo0hrS
 NZOkpmvczCQcXI9e5RYvOH9s9sCpXWoCih+6fJciWBVqXhHcEXi+2WFY6IYLLrud9I5YNt
 4Ki7qPkZ9NVrJz0BJX6EjSNylKR5LNw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-lApc9CxvP7aBKeqmnKxoeg-1; Wed, 08 Dec 2021 19:19:21 -0500
X-MC-Unique: lApc9CxvP7aBKeqmnKxoeg-1
Received: by mail-wr1-f71.google.com with SMTP id
 h13-20020adfa4cd000000b001883fd029e8so837073wrb.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 16:19:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=SDoJ4BZ4/DkxCZbzgnEUNi4EMWL80ft0a8ylUyJRFaQ=;
 b=uCzQwd4TmXvfRcHcOz3/fiWFRsafV6qlL6SsWh4P6y9PoU+o216d2Jg95um/zxoV3y
 wEeuYHRxQgcdg+XcMPo0ZUbJUBZSgZ4BoVcHMKMreH1C/fd3G5q9H+HD+XXE/kDOrhCz
 Kku5a/Ar/vChE+ya+1l6E4X9uvsR1EO3vEmrpMnQPwArz7gY4h1OpbKJO3fmtOS7vaCW
 dqGLJqsMkSDhJfwhEuAJY5Gatarde0dPOHogVWfOg9YlbvVCV+u9WAwJ2V+XpMSxMiTL
 qWB7iCEjeCFxe1lW8TnOa81BecIRtWILWEVVXK9HtRY+waRaJLE1dCF/iUjvPm6be+Wc
 1ftw==
X-Gm-Message-State: AOAM531OzBERIRGoAyKm3vsDin9/51OnR4LDMYILK9iCBgoJ33w0CogA
 Fw3dTCjWB0Di9OZyPj6nmSOFhcclygqiERcnvqqL+zOuf0MWMR4UF+4S8tTUF24VtoJURwmk1gd
 10WOVlTnn3sfPf9ncquJKtY0eB3xgFqTR6h/LMFX+mQ==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr2252064wrj.554.1639009160003; 
 Wed, 08 Dec 2021 16:19:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1I69euMFDaGt6iLTn6JMNFRKPuMSWoZMFZGVX5FU6p336G/HsvpQ2Moo30YnGZlZzxWcEnA==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr2252041wrj.554.1639009159739; 
 Wed, 08 Dec 2021 16:19:19 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
 by smtp.gmail.com with ESMTPSA id v15sm4222612wro.35.2021.12.08.16.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 16:19:18 -0800 (PST)
Date: Wed, 8 Dec 2021 19:19:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Message-ID: <20211208191239-mutt-send-email-mst@kernel.org>
References: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
 <20211207031217-mutt-send-email-mst@kernel.org>
 <8bbfd029-d969-4632-cb8e-482481d65a2f@linux.alibaba.com>
 <20211208021947-mutt-send-email-mst@kernel.org>
 <dfb712d7-1186-1496-9fcc-a72e23c3409b@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <dfb712d7-1186-1496-9fcc-a72e23c3409b@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCBEZWMgMDgsIDIwMjEgYXQgMDQ6MDQ6MTlQTSArMDgwMCwg546L6LSHIHdyb3RlOgo+
IAo+IAo+IOWcqCAyMDIxLzEyLzgg5LiL5Y2IMzoyMywgTWljaGFlbCBTLiBUc2lya2luIOWGmemB
kzoKPiA+IE9uIFR1ZSwgRGVjIDA3LCAyMDIxIGF0IDA1OjA5OjU2UE0gKzA4MDAsIOeOi+i0hyB3
cm90ZToKPiA+ID4gCj4gPiA+IAo+ID4gPiDlnKggMjAyMS8xMi83IOS4i+WNiDQ6MTMsIE1pY2hh
ZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPiA+ID4gT24gVHVlLCBEZWMgMDcsIDIwMjEgYXQgMDM6
NTE6NDVQTSArMDgwMCwg546L6LSHIHdyb3RlOgo+ID4gPiA+ID4gV2Ugb2JzZXJ2ZWQgaXNzdWVz
IGxpa2U6Cj4gPiA+ID4gPiAgICAgdmlydGlvLXBjaSAwMDAwOjE0OjAwLjA6IHBsYXRmb3JtIGJ1
ZzogbGVnYWN5IHZpcnRpby1tbWlvIG11c3QKPiA+ID4gPiA+ICAgICBub3QgYmUgdXNlZCB3aXRo
IFJBTSBhYm92ZSAweDQwMDBHQgo+ID4gPiA+ID4gCj4gPiA+ID4gPiB3aGVuIHdlIGhhdmUgYSBs
ZWdhY3kgcGNpIGRldmljZSB3aGljaCBkZXNpcmVkIDMyYml0LXBmbiB2cQo+ID4gPiA+ID4gYnV0
IGdhaW4gNjRiaXQtcGZuIGluc3RlYWQsIGxlYWQgaW50byB0aGUgZmFpbHVyZSBvZiBwcm9iZS4K
PiA+ID4gPiA+IAo+ID4gPiA+ID4gdnJpbmdfdXNlX2RtYV9hcGkoKSBpcyBwbGF5aW5nIHRoZSBr
ZXkgcm9sZSBpbiBoZXJlLCB0byBoZWxwIHRoZQo+ID4gPiA+ID4gYWxsb2NhdGlvbiBwcm9jZXNz
IHVuZGVyc3RhbmQgd2hpY2gga2luZCBvZiB2cSBpdCBzaG91bGQgYWxsb2MsCj4gPiA+ID4gPiBo
b3dldmVyLCBpdCBmYWlsZWQgdG8gdGFrZSBjYXJlIHRoZSBsZWdhY3kgcGNpIGRldmljZSwgd2hp
Y2ggb25seQo+ID4gPiA+ID4gaGF2ZSAzMmJpdCBmZWF0dXJlIGZsYWcgYW5kIGNhbiBuZXZlciBo
YXZlIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STQo+ID4gPiA+ID4gc2V0dGVkLgo+ID4gPiA+ID4g
Cj4gPiA+ID4gPiBUaGlzIHBhdGNoIGludHJvZHVjZSBmb3JjZV9kbWEgZmxhZyB0byBoZWxwIHZy
aW5nX3VzZV9kbWFfYXBpKCkKPiA+ID4gPiA+IHVuZGVyc3RhbmRpbmcgdGhlIHJlcXVpcmVtZW50
IGJldHRlciwgdG8gYXZvaWQgdGhlIGZhaWxpbmcuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IE1pY2hhZWwgV2FuZyA8eXVuLndhbmdAbGludXguYWxpYmFiYS5jb20+Cj4gPiA+
ID4gCj4gPiA+ID4gVGhpcyB3aWxsIGJyZWFrIGNvbmZpZ3Mgd2hlcmUgdGhlIGRldmljZSBhcHBl
YXJzIGJlaGluZAo+ID4gPiA+IGEgdmlydHVhbCBpb21tdSwgc28gdGhpcyB3b24ndCBmbHkuCj4g
PiA+ID4gSnVzdCBtYWtlIHlvdXIgZGV2aWNlIHN1cHBvcnQgMS4wLCBlaD8KPiA+ID4gCj4gPiA+
IEhpLCBNaWNoYWVsCj4gPiA+IAo+ID4gPiBUaGFua3MgZm9yIHRoZSBjb21tZW50LCB1bmZvcnR1
bmF0ZWx5IG1vZGlmeSBkZXZpY2UgaXMgbm90IGFuIG9wdGlvbiBmb3IgdXMKPiA+ID4gOi0oCj4g
PiA+IAo+ID4gPiBJcyB0aGVyZSBhbnkgaWRlYSBvbiBob3cgdG8gc29sdmUgdGhpcyBpc3N1ZSBw
cm9wZXJseT8KPiA+ID4gCj4gPiA+IFJlZ2FyZHMsCj4gPiA+IE1pY2hhZWwgV2FuZwo+ID4gCj4g
PiBCeSB0aGUgd2F5LCB0aGVyZSBpcyBhIGJ1ZyBpbiB0aGUgZXJyb3IgbWVzc2FnZS4gV2FudCB0
byBmaXggdGhhdD8KPiAKPiBDb3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgbW9yZSBkZXRhaWwgYWJv
dXQgdGhlIGJ1Zz8gV2UnZCBsaWtlIHRvIGhlbHAgZml4aW5nCj4gaXQgOi0pCj4gCj4gQmVzaWRl
cywgSSd2ZSBjaGVja2VkIHRoYXQgcGF0Y2ggYnV0IGl0IGNhbid0IGFkZHJlc3Mgb3VyIGlzc3Vl
LCB3ZSBhY3R1YWxseQo+IGhhdmUgdGhpcyBsZWdhY3kgcGNpIGRldmljZSBvbiBhcm0gcGxhdGZv
cm0sIGFuZCB0aGUgbWVtb3J5IGxheW91dCBpcwo+IHVuZnJpZW5kbHkgc2luY2UgYWxsb2NhdGlv
biByYXJlbHkgcHJvdmlkaW5nIHBhZ2UtYWRkcmVzcyBiZWxvdyA0NGJpdCwgd2UKPiB1bmRlcnN0
YW5kIHRoZSB2aXJ0aW8taW9tbXUgY2FzZSBzaG91bGQgbm90IGRvIGZvcmNlIGRtYSwgd2hpbGUg
d2UgZG9uJ3QKPiBoYXZlIHRoYXQgc28gaXQncyBqdXN0IHdvcmtpbmcgZmluZS4KPiAKPiBSZWdh
cmRzLAo+IE1pY2hhZWwgV2FuZwoKQlRXIGlzIGl0IGp1c3QgdGhlIHJpbmcgdGhhdCdzIGF0IGlz
c3VlPwpGaWd1cmluZyBvdXQgd2UgaGF2ZSB0aGlzIHByb2JsZW1hdGljIGNvbmZpZyBhbmQgdGhl
biBhbGxvY2F0aW5nIGp1c3QKdGhlIHJpbmcgZnJvbSBjb2hlcmVudCBtZW1vcnkgc2VlbXMgbW9y
ZSBwYWxhdGFibGUuCgpCdXQgcGxlYXNlIG5vdGUgd2Ugc3RpbGwgbmVlZCB0byBkZXRlY3QgY29u
ZmlnIHdpdGggYSB2aXJ0dWFsIGlvbW11IChjYW4KYmUgYW55IGtpbmQgbm90IGp1c3QgdmlydGlv
LWlvbW11LCBzbW11LCB2dGQgYXJlIGFsbCBhZmZlY3RlZCkgYW5kCmRpc2FibGUgdGhlIGhhY2tz
LiBUaGlzIGlzIHdoYXQgdGhlIG5ldyBETUEgQVBJIEkgc3VnZ2VzdGVkIHdvdWxkIGRvLgoKCj4g
PiAKPiA+IAo+ID4gPiA+IAo+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiAgICBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgMTAgKysrKysrKysrKwo+ID4gPiA+ID4gICAgZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYyAgICAgICB8ICAzICsrKwo+ID4gPiA+ID4gICAgaW5jbHVk
ZS9saW51eC92aXJ0aW8uaCAgICAgICAgICAgICB8ICAxICsKPiA+ID4gPiA+ICAgIDMgZmlsZXMg
Y2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQo+ID4gPiA+ID4gCj4gPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+ID4gPiA+ID4gYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jCj4gPiA+ID4gPiBpbmRleCBkNjJlOTgzLi4xMWYy
ZWJmIDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdh
Y3kuYwo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+
ID4gPiA+ID4gQEAgLTI2Myw2ICsyNjMsMTYgQEAgaW50IHZpcnRpb19wY2lfbGVnYWN5X3Byb2Jl
KHN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZQo+ID4gPiA+ID4gKnZwX2RldikKPiA+ID4gPiA+ICAg
IAl2cF9kZXYtPnNldHVwX3ZxID0gc2V0dXBfdnE7Cj4gPiA+ID4gPiAgICAJdnBfZGV2LT5kZWxf
dnEgPSBkZWxfdnE7Cj4gPiA+ID4gPiAKPiA+ID4gPiA+ICsJLyoKPiA+ID4gPiA+ICsJICogVGhl
IGxlZ2FjeSBwY2kgZGV2aWNlIHJlcXVyZSAzMmJpdC1wZm4gdnEsCj4gPiA+ID4gPiArCSAqIG9y
IHNldHVwX3ZxKCkgd2lsbCBmYWlsZWQuCj4gPiA+ID4gPiArCSAqCj4gPiA+ID4gPiArCSAqIFRo
dXMgd2UgbWFrZSBzdXJlIHZyaW5nX3VzZV9kbWFfYXBpKCkgd2lsbAo+ID4gPiA+ID4gKwkgKiBy
ZXR1cm4gdHJ1ZSBkdXJpbmcgdGhlIGFsbG9jYXRpb24gYnkgbWFya2luZwo+ID4gPiA+ID4gKwkg
KiBmb3JjZV9kbWEgaGVyZS4KPiA+ID4gPiA+ICsJICovCj4gPiA+ID4gPiArCXZwX2Rldi0+dmRl
di5mb3JjZV9kbWEgPSB0cnVlOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gICAgCXJldHVybiAwOwo+
ID4gPiA+ID4gCj4gPiA+ID4gPiAgICBlcnJfaW9tYXA6Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMKPiA+ID4gPiA+IGluZGV4IDMwMzViYjYuLjY1NjJlMDEgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiBAQCAtMjQ1LDYgKzI0NSw5IEBAIHN0YXRpYyBp
bmxpbmUgYm9vbCB2aXJ0cXVldWVfdXNlX2luZGlyZWN0KHN0cnVjdAo+ID4gPiA+ID4gdmlydHF1
ZXVlICpfdnEsCj4gPiA+ID4gPiAKPiA+ID4gPiA+ICAgIHN0YXRpYyBib29sIHZyaW5nX3VzZV9k
bWFfYXBpKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4gICAgewo+ID4gPiA+
ID4gKwlpZiAodmRldi0+Zm9yY2VfZG1hKQo+ID4gPiA+ID4gKwkJcmV0dXJuIHRydWU7Cj4gPiA+
ID4gPiArCj4gPiA+ID4gPiAgICAJaWYgKCF2aXJ0aW9faGFzX2RtYV9xdWlyayh2ZGV2KSkKPiA+
ID4gPiA+ICAgIAkJcmV0dXJuIHRydWU7Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ID4gPiA+
ID4gaW5kZXggNDFlZGJjMC4uYTRlYjI5ZCAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL2luY2x1ZGUv
bGludXgvdmlydGlvLmgKPiA+ID4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiA+
ID4gPiA+IEBAIC0xMDksNiArMTA5LDcgQEAgc3RydWN0IHZpcnRpb19kZXZpY2Ugewo+ID4gPiA+
ID4gICAgCWJvb2wgZmFpbGVkOwo+ID4gPiA+ID4gICAgCWJvb2wgY29uZmlnX2VuYWJsZWQ7Cj4g
PiA+ID4gPiAgICAJYm9vbCBjb25maWdfY2hhbmdlX3BlbmRpbmc7Cj4gPiA+ID4gPiArCWJvb2wg
Zm9yY2VfZG1hOwo+ID4gPiA+ID4gICAgCXNwaW5sb2NrX3QgY29uZmlnX2xvY2s7Cj4gPiA+ID4g
PiAgICAJc3BpbmxvY2tfdCB2cXNfbGlzdF9sb2NrOyAvKiBQcm90ZWN0cyBWUXMgbGlzdCBhY2Nl
c3MgKi8KPiA+ID4gPiA+ICAgIAlzdHJ1Y3QgZGV2aWNlIGRldjsKPiA+ID4gPiA+IC0tIAo+ID4g
PiA+ID4gMS44LjMuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
