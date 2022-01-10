Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF50C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 09:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 649FA81D73;
	Mon, 10 Jan 2022 09:49:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8yuinOXLY5fq; Mon, 10 Jan 2022 09:49:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F151781A39;
	Mon, 10 Jan 2022 09:49:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1718C002F;
	Mon, 10 Jan 2022 09:49:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0C40C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 09:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C63D3404CF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 09:49:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M9ldrEAM_Qfq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 09:49:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E41B4038C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641808174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TS5iUAOicFwTyQWMCANZuH9sC0m9R2mhAyEEP7T/JcU=;
 b=iiHq0CIgSioln9leKYPrY/PRCbPcZq0x+x0cnZFZDBGJMrH+laiOxnTP5bJDGjFes3awVa
 73Fmg6GO311Kg6V17yYliUqqKrq2kr+6xEp/UAdVzFjTuPal4+QeMWaSQmW1SGIshZwQw3
 BZhp2FJSLwUVE/cxP5Hd+Diufn0Gfzo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-ZlEnYB2CMtaT9HK8I1NRIg-1; Mon, 10 Jan 2022 04:49:30 -0500
X-MC-Unique: ZlEnYB2CMtaT9HK8I1NRIg-1
Received: by mail-ed1-f72.google.com with SMTP id
 v18-20020a056402349200b003f8d3b7ee8dso9667064edc.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 01:49:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=TS5iUAOicFwTyQWMCANZuH9sC0m9R2mhAyEEP7T/JcU=;
 b=sdIJsh7XeKWq/rrPFJx8zgY+A772mqHRBJIaIkXTN68UwaqS0gD6F5KbhmMHi87Mt+
 WeWhAb/rkrMbrK5ebfITUy2G1sjXUJEfAN3yV0KbxyAoebo+4XXqUSC7dB+Kjhzzks87
 G52Li8XZ2kteNGSxFb+B2M4e78JAA2IXMtah5qL0AX2B+abI+F7B8NlzLmAEc4x7c/DZ
 aVs20ALiBd7vlLlEd4bDuy2qrQu4wMMf2pIx4+slZdto00fLZRG8x2hdXkqIdVhNYqWl
 wialDaKso+AFs1tegUP5Juo26GBNIRqd9mDdvKFXf9lZf+LAyqGt8d68cKG4TuEdVxKh
 L/UQ==
X-Gm-Message-State: AOAM531Ec2iZw/2w+1mEygtsfcBjCzDvtgUQxXvdKAsfesViFJU7FxdI
 gO7L9KytU7oo9b2h4jIUBM5GzyzjbXSKmIxjOUppNbI1HcN1en+ZRSxvH9JWkVKQdc9/zQ0zK5Q
 h9C5ZhLwW9MVUhC8JTjRJFuLFOUTymme/Yi1cEtMydQ==
X-Received: by 2002:a17:907:6218:: with SMTP id
 ms24mr59208668ejc.520.1641808169424; 
 Mon, 10 Jan 2022 01:49:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwy+ppIAf+s4A0b3MfZPiDI5aDmxrYpYyNIVYfuH+8+i2xVZ+RFa+zb6qqaQo+h2KBMe/Phjw==
X-Received: by 2002:a17:907:6218:: with SMTP id
 ms24mr59208658ejc.520.1641808169186; 
 Mon, 10 Jan 2022 01:49:29 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107d:b60c:c297:16fe:7528:e989])
 by smtp.gmail.com with ESMTPSA id s4sm3282276edr.67.2022.01.10.01.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jan 2022 01:49:28 -0800 (PST)
Date: Mon, 10 Jan 2022 04:49:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 2/6] virtio: split: alloc indirect desc with extra
Message-ID: <20220110044217-mutt-send-email-mst@kernel.org>
References: <CACGkMEu4MPe9DQbaphMrd3T16V9FF+Pu9uhpBue8-Pz9Q6Jk1A@mail.gmail.com>
 <1641806593.3066823-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1641806593.3066823-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

T24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMDU6MjM6MTNQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3Rl
Ogo+IE9uIE1vbiwgMTAgSmFuIDIwMjIgMTY6NTQ6NTggKzA4MDAsIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMzo1OSBQ
TSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+ID4KPiA+
ID4gT24gTW9uLCAxMCBKYW4gMjAyMiAxNTo0MToyNyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gT24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMzoy
NCBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+ID4g
PiA+Cj4gPiA+ID4gPiBPbiBNb24sIDEwIEphbiAyMDIyIDE0OjQzOjM5ICswODAwLCBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
5ZyoIDIwMjIvMS83IOS4i+WNiDI6MzMsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4g
SW4gdGhlIHNjZW5hcmlvIHdoZXJlIGluZGlyZWN0IGlzIG5vdCB1c2VkLCBlYWNoIGRlc2MgY29y
cmVzcG9uZHMgdG8gYW4KPiA+ID4gPiA+ID4gPiBleHRyYSwgd2hpY2ggaXMgdXNlZCB0byByZWNv
cmQgaW5mb3JtYXRpb24gc3VjaCBhcyBkbWEsIGZsYWdzLCBhbmQKPiA+ID4gPiA+ID4gPiBuZXh0
Lgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSW4gdGhlIHNjZW5hcmlvIG9mIHVzaW5nIGlu
ZGlyZWN0LCB0aGUgYXNzaWduZWQgZGVzYyBkb2VzIG5vdCBoYXZlIHRoZQo+ID4gPiA+ID4gPiA+
IGNvcnJlc3BvbmRpbmcgZXh0cmEgcmVjb3JkIGRtYSBpbmZvcm1hdGlvbiwgYW5kIHRoZSBkbWEg
aW5mb3JtYXRpb24gbXVzdAo+ID4gPiA+ID4gPiA+IGJlIG9idGFpbmVkIGZyb20gdGhlIGRlc2Mg
d2hlbiB1bm1hcC4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggYWxsb2Nh
dGVzIHRoZSBjb3JyZXNwb25kaW5nIGV4dHJhIGFycmF5IHdoZW4gaW5kaXJlY3QgZGVzYyBpcwo+
ID4gPiA+ID4gPiA+IGFsbG9jYXRlZC4gVGhpcyBoYXMgdGhlc2UgYWR2YW50YWdlczoKPiA+ID4g
PiA+ID4gPiAxLiBSZWNvcmQgdGhlIGRtYSBpbmZvcm1hdGlvbiBvZiBkZXNjLCBubyBuZWVkIHRv
IHJlYWQgZGVzYyB3aGVuIHVubWFwCj4gPiA+ID4gPiA+ID4gMi4gSXQgd2lsbCBiZSBtb3JlIGNv
bnZlbmllbnQgYW5kIHVuaWZpZWQgaW4gcHJvY2Vzc2luZwo+ID4gPiA+ID4gPiA+IDMuIFNvbWUg
YWRkaXRpb25hbCBpbmZvcm1hdGlvbiBjYW4gYmUgcmVjb3JkZWQgaW4gZXh0cmEsIHdoaWNoIHdp
bGwgYmUKPiA+ID4gPiA+ID4gPiAgICAgdXNlZCBpbiBzdWJzZXF1ZW50IHBhdGNoZXMuCj4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFR3byBxdWVzdGlvbnM6Cj4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+IDEpIElzIHRoZXJlIGFueSBwZXJmb3JtYW5jZSBudW1iZXIgZm9yIHRoaXMg
Y2hhbmdlPyBJIGd1ZXNzIGl0IGdpdmVzCj4gPiA+ID4gPiA+IG1vcmUgc3RyZXNzIG9uIHRoZSBj
YWNoZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJIHdpbGwgYWRkIHBlcmZvcm1hbmNlIHRlc3QgZGF0
YSBpbiB0aGUgbmV4dCB2ZXJzaW9uLgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4gMikgSXMgdGhlcmUg
YSByZXF1aXJlbWVudCB0byBtaXggdGhlIHByZSBtYXBwZWQgc2cgd2l0aCB1bm1hcHBlZCBzZz8g
SWYKPiA+ID4gPiA+ID4gbm90LCBhIHBlciB2aXJ0cXVldWUgZmxhZyBsb29rcyBzdWZmaWNpZW50
Cj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhlcmUgaXMgdGhpcyByZXF1aXJlbWVudC4gRm9yIGV4YW1w
bGUsIGluIHRoZSBjYXNlIG9mIEFGX1hEUCwgYSBwYXRja2V0Cj4gPiA+ID4gPiBjb250YWlucyB0
d28gcGFydHMsIG9uZSBpcyB2aXJ0aW9fbmV0X2hkciwgYW5kIHRoZSBvdGhlciBpcyB0aGUgYWN0
dWFsIGRhdGEKPiA+ID4gPiA+IHBhY2tldCBmcm9tIEFGX1hEUC4gVGhlIGZvcm1lciBpcyB1bm1h
cHBlZCBzZywgYW5kIHRoZSBsYXR0ZXIgaXMgcHJlIG1hcHBlZCBzZy4KPiA+ID4gPgo+ID4gPiA+
IEFueSBjaGFuY2UgdG8gbWFwIHZpcnRpb19uZXRfaGRyKCkgbWFudWFsbHkgYnkgQUZfWERQIHJv
dXRpbmUgaW4gdGhpcyBjYXNlPwo+ID4gPgo+ID4gPiBXZWxsLCBpdCBpcyBpbmRlZWQgcG9zc2li
bGUgdG8gZG8gc28uIEluIHRoZSBpbmRpcmVjdCBzY2VuYXJpbywgd2UgY2FuIHJlY29yZCBpdAo+
ID4gPiBpbiB2cmluZy0+c3BsaXQuZGVzY19leHRyYVtoZWFkXS5mbGFncwo+ID4gPgo+ID4gPiBU
aGVuIHdlIGhhdmUgdG8gYWdyZWUgdGhhdCB0aGVyZSBjYW4gYmUgbm8gbWl4ZWQgc2l0dWF0aW9u
Lgo+ID4KPiA+IEkgdGhpbmsgaXQgd291bGQgYmUgZWFzaWVyIGFuZCBsZXNzIHBlcmZvcm1hbmNl
IHJlZ3Jlc3Npb24gaWYgd2UgZG9uJ3QKPiA+IGRvIGh1Z2UgY2hhbmdlcyBpbiB0aGUgY29yZSB1
bmxlc3MgaXQncyBhIG11c3QuCj4gPgo+IAo+IE9rLCBJIHBsYW4gdG8gYWRkIHR3byBuZXcgaW50
ZXJmYWNlIHZpcnRxdWV1ZV9hZGRfb3V0YnVmX2ZsYWcoKSwKPiB2aXJ0cXVldWVfYWRkX2luYnVm
X2ZsYWcoKSBwYXNzIGEgZmxhZyBwYXJhbWV0ZXIgdG8gdmlydHF1ZXVlX2FkZCgpIHRvCj4gbWFy
ayBzZ3MgYWRkciBpcyBwcmVkbWEuCgpJIHdvdWxkIG1heWJlIGp1c3QgZG8gYSB2YXJpYW50IHdv
cmtpbmcgd2l0aCBtYXBwZWQgU0dzLgoKPiBJIGRvbid0IHdhbnQgdG8gdXNlIHNnLT5kbWFfYWRk
cmVzcywgc28gd2UgaGF2ZSB0byBjaGVjayB3aGV0aGVyIGVhY2ggc2cgdXNlcwo+IGRtYV9hZGRy
ZXNzLiBJZiBpdCBpcyBub3QgdW5pZmllZCwgd2Ugd2lsbCBhbHNvIGhhbmRsZSBleGNlcHRpb24u
Cj4gCj4gPiBCdHcsIEkgZm9yZ290IHRoZSBjb25jbHVzaW9uIG9mIHRoZSBsYXN0IEFGX1hEUCBz
ZXJpZXMuIFdoeSBpcyBpdAo+ID4gYmV0dGVyIHRvIGNoYW5nZSB2aXJ0aW9fcmluZyBpbnN0ZWFk
IG9mIEFGX1hEUCAod2hpY2ggc2VlbXMgZWFzaWVyKS4KPiAKPiBSZWdhcmRpbmcgdGhpcyBxdWVz
dGlvbiwgSSdtIGd1ZXNzaW5nIHlvdSBtZWFuIHRvIG1ha2UgQUZfWERQIG5vdCB1c2UgRE1BCj4g
YWRkcmVzc2VzPyBJbnN0ZWFkIHBhc3MgdmlydHVhbCBhZGRyZXNzZXMgdG8gdmlydGlvLgo+IAo+
IEl0IHdvdWxkIGNlcnRhaW5seSBiZSBzaW1wbGVyLCBidXQgSSB0aGluayB0aGVyZSBpcyBhIHBl
cmZvcm1hbmNlIGdhaW4gaW4gZG9pbmcKPiB0aGUgRE1BIG1hcHBpbmcgYWhlYWQgb2YgdGltZS4K
PiAKPiBUaGFua3MuCgpUaGF0IHdvdWxkIGF0IGxlYXN0IGluIHBhcnQgZGVwZW5kIG9uIHdoZXRo
ZXIgRE1BIG1hcHBpbmcgaXMgZXZlbnR1YWxseSB1c2VkIDspClRlc3RpbmcgdGhlIGFjdHVhbCBn
YWluIGJlZm9yZSB3ZSBpbnRyb2R1Y2UgY29tcGxleGl0eSBhbmQgaW5jbHVkaW5nCnRoYXQgaW5m
byBpbiB0aGUgY29tbWl0IGxvZyBpcyBub3QgYSBiYWQgaWRlYS4KCj4gCj4gPgo+ID4gVGhhbmtz
Cj4gPgo+ID4gPgo+ID4gPiBUaGFua3MuCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBUaGFua3MKPiA+
ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4g
Pgo+ID4gPgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
