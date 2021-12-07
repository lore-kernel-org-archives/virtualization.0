Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21B6C433EF
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 10:44:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB5A240553;
	Tue,  7 Dec 2021 10:44:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A21NwexrosAx; Tue,  7 Dec 2021 10:44:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 27B2E402E0;
	Tue,  7 Dec 2021 10:44:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9F5BC002F;
	Tue,  7 Dec 2021 10:44:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B438C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 10:44:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B05640104
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 10:44:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tNUKg-QS1o-y
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 10:44:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 183A640264
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 10:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638873870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OJtOGTM6hpba13AFJA6DOM5gH4zdsII7eyxr1fYY86Q=;
 b=Tp/6wuZv3A/5uApWqNCNZe8UmAB+70o+wsBieRvX0OlKMBnx3MTY7gKZ9S2kAgGddPPX4R
 dXQgIrPGu+vm03APkDaXP+yfAKnM4bZJ/vrKsZ8Pmr2v+mclMZ5qVIih5umxDxCv1HyCTD
 gEkyzKD+HW3OXHHdOfB2kZSRDTVb33Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-pfL10shZNUe-3Gp64oPqlg-1; Tue, 07 Dec 2021 05:44:27 -0500
X-MC-Unique: pfL10shZNUe-3Gp64oPqlg-1
Received: by mail-ed1-f71.google.com with SMTP id
 m17-20020aa7d351000000b003e7c0bc8523so11088093edr.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Dec 2021 02:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OJtOGTM6hpba13AFJA6DOM5gH4zdsII7eyxr1fYY86Q=;
 b=OK43W7+rLbya4a2VyruZQ/vUF08sj4oMnICOCtVuivmPW3sUJyQctQJs3OvJYwllFH
 OmEvrtLrCqAb45XIbPiUyjVrZYoMSatgHCNB53QCxQcIUyE+gvWkoZsEqA44ifrow6gk
 WiKt7h01dHkcj/ikvocYotZtv2WhfGAuxW9bzNZ+RPPrlR6Tfo7HhIEVIUm3dZZkbUBi
 b3uD8/o/pvgPbt9MThsJintzZIcXEXC88I6klTwN7yfe973yTw820iKB6NjT4pMcc/di
 iCaJguVwFo78Sq1Cg7NoWiEfWMSmTFD6bfEYfuw0ch5XRVavQo/5QYyzI3ALlwuhL3Zr
 ZaQw==
X-Gm-Message-State: AOAM533ZBaHm+AalRCkGmVMIsCS9Fsa1W3azurBHj8AuP2mii1nZjdC/
 Vw6vHEtDfBny3zD1mpC73kACq3mgajyEI8XJHzAxaXdeu6lZBUMzSoyEi1BTZ0AHSfi5IG7Lu25
 zJfw71mKVmJE1QsbKYc/t+VsYsYgdLzkh+CawspMmPw==
X-Received: by 2002:a05:6402:1e93:: with SMTP id
 f19mr8065712edf.60.1638873866535; 
 Tue, 07 Dec 2021 02:44:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5DkMy9wFULjbVZU5J33CwH+/vEuqydZgEIfpXKY+R1VUt4hgAX2Q0wFWxDoZXGCKF1rme/A==
X-Received: by 2002:a05:6402:1e93:: with SMTP id
 f19mr8065681edf.60.1638873866246; 
 Tue, 07 Dec 2021 02:44:26 -0800 (PST)
Received: from redhat.com ([2a0e:1c80:7::36])
 by smtp.gmail.com with ESMTPSA id j17sm10254172edj.0.2021.12.07.02.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Dec 2021 02:44:25 -0800 (PST)
Date: Tue, 7 Dec 2021 05:44:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Message-ID: <20211207053846-mutt-send-email-mst@kernel.org>
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
PiBNaWNoYWVsIFdhbmcKClRoZXJlJ3MgYW4gb2xkIGlkZWE6Cmh0dHBzOi8vd3d3LnNwaW5pY3Mu
bmV0L2xpc3RzL2tlcm5lbC9tc2czMjQ4ODAwLmh0bWwKCgo+ID4gCj4gPiA+IC0tLQo+ID4gPiAg
IGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgfCAxMCArKysrKysrKysrCj4gPiA+
ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyAgICAgICB8ICAzICsrKwo+ID4gPiAgIGlu
Y2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgICAgICAgfCAgMSArCj4gPiA+ICAgMyBmaWxlcyBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspCj4gPiA+IAo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+ID4gPiBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfbGVnYWN5LmMKPiA+ID4gaW5kZXggZDYyZTk4My4uMTFmMmViZiAxMDA2NDQKPiA+ID4g
LS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+ID4gPiArKysgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jCj4gPiA+IEBAIC0yNjMsNiArMjYzLDE2IEBA
IGludCB2aXJ0aW9fcGNpX2xlZ2FjeV9wcm9iZShzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UKPiA+
ID4gKnZwX2RldikKPiA+ID4gICAJdnBfZGV2LT5zZXR1cF92cSA9IHNldHVwX3ZxOwo+ID4gPiAg
IAl2cF9kZXYtPmRlbF92cSA9IGRlbF92cTsKPiA+ID4gCj4gPiA+ICsJLyoKPiA+ID4gKwkgKiBU
aGUgbGVnYWN5IHBjaSBkZXZpY2UgcmVxdXJlIDMyYml0LXBmbiB2cSwKPiA+ID4gKwkgKiBvciBz
ZXR1cF92cSgpIHdpbGwgZmFpbGVkLgo+ID4gPiArCSAqCj4gPiA+ICsJICogVGh1cyB3ZSBtYWtl
IHN1cmUgdnJpbmdfdXNlX2RtYV9hcGkoKSB3aWxsCj4gPiA+ICsJICogcmV0dXJuIHRydWUgZHVy
aW5nIHRoZSBhbGxvY2F0aW9uIGJ5IG1hcmtpbmcKPiA+ID4gKwkgKiBmb3JjZV9kbWEgaGVyZS4K
PiA+ID4gKwkgKi8KPiA+ID4gKwl2cF9kZXYtPnZkZXYuZm9yY2VfZG1hID0gdHJ1ZTsKPiA+ID4g
Kwo+ID4gPiAgIAlyZXR1cm4gMDsKPiA+ID4gCj4gPiA+ICAgZXJyX2lvbWFwOgo+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMKPiA+ID4gaW5kZXggMzAzNWJiNi4uNjU2MmUwMSAxMDA2NDQKPiA+ID4gLS0t
IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiArKysgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gPiA+IEBAIC0yNDUsNiArMjQ1LDkgQEAgc3RhdGljIGlubGluZSBi
b29sIHZpcnRxdWV1ZV91c2VfaW5kaXJlY3Qoc3RydWN0Cj4gPiA+IHZpcnRxdWV1ZSAqX3ZxLAo+
ID4gPiAKPiA+ID4gICBzdGF0aWMgYm9vbCB2cmluZ191c2VfZG1hX2FwaShzdHJ1Y3QgdmlydGlv
X2RldmljZSAqdmRldikKPiA+ID4gICB7Cj4gPiA+ICsJaWYgKHZkZXYtPmZvcmNlX2RtYSkKPiA+
ID4gKwkJcmV0dXJuIHRydWU7Cj4gPiA+ICsKPiA+ID4gICAJaWYgKCF2aXJ0aW9faGFzX2RtYV9x
dWlyayh2ZGV2KSkKPiA+ID4gICAJCXJldHVybiB0cnVlOwo+ID4gPiAKPiA+ID4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvdmlydGlvLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiA+
IGluZGV4IDQxZWRiYzAuLmE0ZWIyOWQgMTAwNjQ0Cj4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgv
dmlydGlvLmgKPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ID4gPiBAQCAtMTA5
LDYgKzEwOSw3IEBAIHN0cnVjdCB2aXJ0aW9fZGV2aWNlIHsKPiA+ID4gICAJYm9vbCBmYWlsZWQ7
Cj4gPiA+ICAgCWJvb2wgY29uZmlnX2VuYWJsZWQ7Cj4gPiA+ICAgCWJvb2wgY29uZmlnX2NoYW5n
ZV9wZW5kaW5nOwo+ID4gPiArCWJvb2wgZm9yY2VfZG1hOwo+ID4gPiAgIAlzcGlubG9ja190IGNv
bmZpZ19sb2NrOwo+ID4gPiAgIAlzcGlubG9ja190IHZxc19saXN0X2xvY2s7IC8qIFByb3RlY3Rz
IFZRcyBsaXN0IGFjY2VzcyAqLwo+ID4gPiAgIAlzdHJ1Y3QgZGV2aWNlIGRldjsKPiA+ID4gLS0g
Cj4gPiA+IDEuOC4zLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
