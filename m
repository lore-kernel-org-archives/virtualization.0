Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1618AC433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 07:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B306409F2;
	Wed,  8 Dec 2021 07:23:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YkFopInlhiti; Wed,  8 Dec 2021 07:23:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A8CF24011D;
	Wed,  8 Dec 2021 07:23:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C7B4C002F;
	Wed,  8 Dec 2021 07:23:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3316CC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 07:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1AB9584B2B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 07:23:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FdqjF5Lu1vNa
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 07:23:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCBE584B1F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 07:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638948186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3thlSuxgxJVb1tUf+MaBSf1hCp/SSFCI7BQN+d2CnYY=;
 b=SCGAfoRFUQef5y/AAGfqzizGqObi5AUmoAFubqFRe0nRQDc+TD36ay13G1WEWF9qr3QQf3
 kJEtJQ8Ke7W52V7JabrWy20ZFoAz5tcoLdiYbgvUwAkHp/ubAiaiQHjKDOmezGmc9OOQZe
 pvMLWMaEjXvATjjw+tcTTTq54+MgoeY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-LyDc9mhuP-2hWJf_YV77aQ-1; Wed, 08 Dec 2021 02:23:05 -0500
X-MC-Unique: LyDc9mhuP-2hWJf_YV77aQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 p4-20020aa7d304000000b003e7ef120a37so1323375edq.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Dec 2021 23:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3thlSuxgxJVb1tUf+MaBSf1hCp/SSFCI7BQN+d2CnYY=;
 b=sJokIuLDqweDn0Xd2kQcKWLmfBFGBsBvww6sCdghAVImH690vZ6f00E8OUIXB58nkB
 mCokwOpAuKsLWSmbGrNgmx/a/ZJV7xpKvxwxiHyUfA6R8kn9BYyY/As/GHEaPh7pvPnW
 6DFrfJhadKlbLKrh6ppqLLQmwXVrP5shjFtrUZwiKbVxAv4JLeb6w9TrQBW0rhCg2oEi
 9/EmnaeJDAh3GFR9va5zgGESi+PKVrImJmOZme70KU9VK/aacdvu6GVO9N75OyIDzj76
 b9z3ySPP063bnKjbfyi38UnrlwZn6u9aM+Hg48SK+ftY1I8yH1qH9DOlbjYDSxQJlQNs
 5h0w==
X-Gm-Message-State: AOAM532OeJiUMYdhfj4YJG4JYKBGXnOybc3ta3OAuwNGqX7fQRSrP/z4
 +8zwUHgwi2hDO2Fgyu+HnD1VMZWeTMInfMDP2PPpbzxODNQL5pocARJOaNHYLKQbGM7S1EZ6vl5
 8ekQZrGXAvbrSKAr9pPu2+NbhcxwApkvPORWejQdcaQ==
X-Received: by 2002:a17:906:b304:: with SMTP id
 n4mr5534800ejz.116.1638948184418; 
 Tue, 07 Dec 2021 23:23:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8fXmI2eQ4qLExw30n20BX0hhCuV0j8jCtUu6YqJCm4I3Lf9fKB5w67aZxdmFwHaxkpaof4Q==
X-Received: by 2002:a17:906:b304:: with SMTP id
 n4mr5534779ejz.116.1638948184203; 
 Tue, 07 Dec 2021 23:23:04 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107e:ebdb:5cc6:c351:b05:514f])
 by smtp.gmail.com with ESMTPSA id jg32sm1059703ejc.43.2021.12.07.23.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Dec 2021 23:23:03 -0800 (PST)
Date: Wed, 8 Dec 2021 02:23:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Message-ID: <20211208021947-mutt-send-email-mst@kernel.org>
References: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
 <20211207031217-mutt-send-email-mst@kernel.org>
 <8bbfd029-d969-4632-cb8e-482481d65a2f@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <8bbfd029-d969-4632-cb8e-482481d65a2f@linux.alibaba.com>
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

T24gVHVlLCBEZWMgMDcsIDIwMjEgYXQgMDU6MDk6NTZQTSArMDgwMCwg546L6LSHIHdyb3RlOgo+
IAo+IAo+IOWcqCAyMDIxLzEyLzcg5LiL5Y2INDoxMywgTWljaGFlbCBTLiBUc2lya2luIOWGmemB
kzoKPiA+IE9uIFR1ZSwgRGVjIDA3LCAyMDIxIGF0IDAzOjUxOjQ1UE0gKzA4MDAsIOeOi+i0hyB3
cm90ZToKPiA+ID4gV2Ugb2JzZXJ2ZWQgaXNzdWVzIGxpa2U6Cj4gPiA+ICAgIHZpcnRpby1wY2kg
MDAwMDoxNDowMC4wOiBwbGF0Zm9ybSBidWc6IGxlZ2FjeSB2aXJ0aW8tbW1pbyBtdXN0Cj4gPiA+
ICAgIG5vdCBiZSB1c2VkIHdpdGggUkFNIGFib3ZlIDB4NDAwMEdCCj4gPiA+IAo+ID4gPiB3aGVu
IHdlIGhhdmUgYSBsZWdhY3kgcGNpIGRldmljZSB3aGljaCBkZXNpcmVkIDMyYml0LXBmbiB2cQo+
ID4gPiBidXQgZ2FpbiA2NGJpdC1wZm4gaW5zdGVhZCwgbGVhZCBpbnRvIHRoZSBmYWlsdXJlIG9m
IHByb2JlLgo+ID4gPiAKPiA+ID4gdnJpbmdfdXNlX2RtYV9hcGkoKSBpcyBwbGF5aW5nIHRoZSBr
ZXkgcm9sZSBpbiBoZXJlLCB0byBoZWxwIHRoZQo+ID4gPiBhbGxvY2F0aW9uIHByb2Nlc3MgdW5k
ZXJzdGFuZCB3aGljaCBraW5kIG9mIHZxIGl0IHNob3VsZCBhbGxvYywKPiA+ID4gaG93ZXZlciwg
aXQgZmFpbGVkIHRvIHRha2UgY2FyZSB0aGUgbGVnYWN5IHBjaSBkZXZpY2UsIHdoaWNoIG9ubHkK
PiA+ID4gaGF2ZSAzMmJpdCBmZWF0dXJlIGZsYWcgYW5kIGNhbiBuZXZlciBoYXZlIFZJUlRJT19G
X0FDQ0VTU19QTEFURk9STQo+ID4gPiBzZXR0ZWQuCj4gPiA+IAo+ID4gPiBUaGlzIHBhdGNoIGlu
dHJvZHVjZSBmb3JjZV9kbWEgZmxhZyB0byBoZWxwIHZyaW5nX3VzZV9kbWFfYXBpKCkKPiA+ID4g
dW5kZXJzdGFuZGluZyB0aGUgcmVxdWlyZW1lbnQgYmV0dGVyLCB0byBhdm9pZCB0aGUgZmFpbGlu
Zy4KPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FuZyA8eXVuLndhbmdAbGlu
dXguYWxpYmFiYS5jb20+Cj4gPiAKPiA+IFRoaXMgd2lsbCBicmVhayBjb25maWdzIHdoZXJlIHRo
ZSBkZXZpY2UgYXBwZWFycyBiZWhpbmQKPiA+IGEgdmlydHVhbCBpb21tdSwgc28gdGhpcyB3b24n
dCBmbHkuCj4gPiBKdXN0IG1ha2UgeW91ciBkZXZpY2Ugc3VwcG9ydCAxLjAsIGVoPwo+IAo+IEhp
LCBNaWNoYWVsCj4gCj4gVGhhbmtzIGZvciB0aGUgY29tbWVudCwgdW5mb3J0dW5hdGVseSBtb2Rp
ZnkgZGV2aWNlIGlzIG5vdCBhbiBvcHRpb24gZm9yIHVzCj4gOi0oCj4gCj4gSXMgdGhlcmUgYW55
IGlkZWEgb24gaG93IHRvIHNvbHZlIHRoaXMgaXNzdWUgcHJvcGVybHk/Cj4gCj4gUmVnYXJkcywK
PiBNaWNoYWVsIFdhbmcKCkJ5IHRoZSB3YXksIHRoZXJlIGlzIGEgYnVnIGluIHRoZSBlcnJvciBt
ZXNzYWdlLiBXYW50IHRvIGZpeCB0aGF0PwoKCj4gPiAKPiA+ID4gLS0tCj4gPiA+ICAgZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYyB8IDEwICsrKysrKysrKysKPiA+ID4gICBkcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jICAgICAgIHwgIDMgKysrCj4gPiA+ICAgaW5jbHVkZS9s
aW51eC92aXJ0aW8uaCAgICAgICAgICAgICB8ICAxICsKPiA+ID4gICAzIGZpbGVzIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKykKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcGNpX2xlZ2FjeS5jCj4gPiA+IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9s
ZWdhY3kuYwo+ID4gPiBpbmRleCBkNjJlOTgzLi4xMWYyZWJmIDEwMDY0NAo+ID4gPiAtLS0gYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKPiA+ID4gQEAgLTI2Myw2ICsyNjMsMTYgQEAgaW50IHZp
cnRpb19wY2lfbGVnYWN5X3Byb2JlKHN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZQo+ID4gPiAqdnBf
ZGV2KQo+ID4gPiAgIAl2cF9kZXYtPnNldHVwX3ZxID0gc2V0dXBfdnE7Cj4gPiA+ICAgCXZwX2Rl
di0+ZGVsX3ZxID0gZGVsX3ZxOwo+ID4gPiAKPiA+ID4gKwkvKgo+ID4gPiArCSAqIFRoZSBsZWdh
Y3kgcGNpIGRldmljZSByZXF1cmUgMzJiaXQtcGZuIHZxLAo+ID4gPiArCSAqIG9yIHNldHVwX3Zx
KCkgd2lsbCBmYWlsZWQuCj4gPiA+ICsJICoKPiA+ID4gKwkgKiBUaHVzIHdlIG1ha2Ugc3VyZSB2
cmluZ191c2VfZG1hX2FwaSgpIHdpbGwKPiA+ID4gKwkgKiByZXR1cm4gdHJ1ZSBkdXJpbmcgdGhl
IGFsbG9jYXRpb24gYnkgbWFya2luZwo+ID4gPiArCSAqIGZvcmNlX2RtYSBoZXJlLgo+ID4gPiAr
CSAqLwo+ID4gPiArCXZwX2Rldi0+dmRldi5mb3JjZV9kbWEgPSB0cnVlOwo+ID4gPiArCj4gPiA+
ICAgCXJldHVybiAwOwo+ID4gPiAKPiA+ID4gICBlcnJfaW9tYXA6Cj4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+ID4gPiBpbmRleCAzMDM1YmI2Li42NTYyZTAxIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPiA+ID4gQEAgLTI0NSw2ICsyNDUsOSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgdmly
dHF1ZXVlX3VzZV9pbmRpcmVjdChzdHJ1Y3QKPiA+ID4gdmlydHF1ZXVlICpfdnEsCj4gPiA+IAo+
ID4gPiAgIHN0YXRpYyBib29sIHZyaW5nX3VzZV9kbWFfYXBpKHN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2KQo+ID4gPiAgIHsKPiA+ID4gKwlpZiAodmRldi0+Zm9yY2VfZG1hKQo+ID4gPiArCQly
ZXR1cm4gdHJ1ZTsKPiA+ID4gKwo+ID4gPiAgIAlpZiAoIXZpcnRpb19oYXNfZG1hX3F1aXJrKHZk
ZXYpKQo+ID4gPiAgIAkJcmV0dXJuIHRydWU7Cj4gPiA+IAo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC92aXJ0aW8uaCBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiA+ID4gaW5kZXgg
NDFlZGJjMC4uYTRlYjI5ZCAxMDA2NDQKPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW8u
aAo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiA+IEBAIC0xMDksNiArMTA5
LDcgQEAgc3RydWN0IHZpcnRpb19kZXZpY2Ugewo+ID4gPiAgIAlib29sIGZhaWxlZDsKPiA+ID4g
ICAJYm9vbCBjb25maWdfZW5hYmxlZDsKPiA+ID4gICAJYm9vbCBjb25maWdfY2hhbmdlX3BlbmRp
bmc7Cj4gPiA+ICsJYm9vbCBmb3JjZV9kbWE7Cj4gPiA+ICAgCXNwaW5sb2NrX3QgY29uZmlnX2xv
Y2s7Cj4gPiA+ICAgCXNwaW5sb2NrX3QgdnFzX2xpc3RfbG9jazsgLyogUHJvdGVjdHMgVlFzIGxp
c3QgYWNjZXNzICovCj4gPiA+ICAgCXN0cnVjdCBkZXZpY2UgZGV2Owo+ID4gPiAtLSAKPiA+ID4g
MS44LjMuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
