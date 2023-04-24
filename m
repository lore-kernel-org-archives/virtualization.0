Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F72C7618E
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 09:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C324481E76;
	Mon, 24 Apr 2023 09:53:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C324481E76
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PdXvYd8o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6BkVjcBt0ROx; Mon, 24 Apr 2023 09:53:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3BEDC81D16;
	Mon, 24 Apr 2023 09:53:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3BEDC81D16
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F402C0036;
	Mon, 24 Apr 2023 09:53:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8604C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 09:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D63540252
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 09:53:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D63540252
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PdXvYd8o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UqcBF2YfKgSX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 09:53:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17FB44023C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17FB44023C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 09:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682329992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMHqiiqTDgFA3ZlBc80dKtrtbEBlbpJyT408XZXVJ3k=;
 b=PdXvYd8o9l3dlGsB2p/B+F/kQIm/J869T2YS/Wdfz/YItwnIiVk+8cpbzCNVvtzOzb+GBS
 ifWvvQHZrvmnoidPBF1T8/MkhuPalbVGkNEIhuEztNrwIlyIyTN0ONb/oMjZAVCKgt5ES7
 GP4Q/UbUiHCLOqEmFzs3JkpGzSHj1vw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-SGDI0CO4OhSdTc8pLbirDQ-1; Mon, 24 Apr 2023 05:53:11 -0400
X-MC-Unique: SGDI0CO4OhSdTc8pLbirDQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f1754de18cso24241015e9.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 02:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682329990; x=1684921990;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yMHqiiqTDgFA3ZlBc80dKtrtbEBlbpJyT408XZXVJ3k=;
 b=O3YGKDDT0U05aJNtkrV3D84tBq3Rh9XTzwnzkNXQRo9yJ2UcrxYQREVS+qeMNIB8N5
 UHLv87cXtB6hQSoxyWWbrY7rUSZ0SbnvOgHSGXgM2LaqlZ3C2Anq1IxjZ6k7mbKyzpcE
 VxH+jRm2qW69btUKOXP1s9VxItgFIh5CIJiIlYC5Apeg6OTUfpq7UQnGgmWgJQBcGjMM
 oob74ksctxxxKo6RYx+GX3fXvGPnuUv3UynbbnmKOKD4n6EU1TA+tvIyqLN5o4EzHPwG
 zgk5epFV0dGp8JuX+Z7u31mbaQvVaVQigA3ybtYVBHtxXHZ94HhHqzszJq9883ZUzwo+
 GRJg==
X-Gm-Message-State: AAQBX9dtIck1S+n7tUtsY3eGpOXNu8FZpRatWJTAcEIF7VjV9DULKE7p
 NqRW41KG3KYrGx7Nf0d1CkR0tRsgUOAqbu/mchIRZVnUl5zvgQlBm8WKOQDka3bsur9vrZcEsqQ
 KVRTQ4VFL9kPlb8ccThEUvT5efJIRmLRIjrUxAe02OQ==
X-Received: by 2002:a1c:7c13:0:b0:3f0:7f4f:2aa8 with SMTP id
 x19-20020a1c7c13000000b003f07f4f2aa8mr7317760wmc.9.1682329990062; 
 Mon, 24 Apr 2023 02:53:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350bJhpZV83xAGFCArCvXPi6GrkFEhnUwxX6xFYxWTlwUsJK8cEvYoFSYcYBBXuaPZpRphwB0pA==
X-Received: by 2002:a1c:7c13:0:b0:3f0:7f4f:2aa8 with SMTP id
 x19-20020a1c7c13000000b003f07f4f2aa8mr7317743wmc.9.1682329989725; 
 Mon, 24 Apr 2023 02:53:09 -0700 (PDT)
Received: from redhat.com ([2.55.61.39]) by smtp.gmail.com with ESMTPSA id
 z16-20020a05600c221000b003ee1b2ab9a0sm11735139wml.11.2023.04.24.02.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Apr 2023 02:53:09 -0700 (PDT)
Date: Mon, 24 Apr 2023 05:53:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/5] vDPA/ifcvf: implement immediate initialization
 mechanism
Message-ID: <20230424055134-mutt-send-email-mst@kernel.org>
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
 <CACGkMEstNJ1TJtTApniJLyN872gF9ZpAbj3hEKUw6yX3ZpPiFg@mail.gmail.com>
 <cf384aed-7ac4-02af-c2b5-b66c03a86aa9@intel.com>
 <c939205a-adc3-75eb-de16-617d6d001e18@intel.com>
 <CACGkMEsHDZAiOHi31gOV=OLF4sbQGY3sRLDkReQMmRAP322gBw@mail.gmail.com>
 <20230424005242-mutt-send-email-mst@kernel.org>
 <CACGkMEvu=sRmXQaJ55FTi_8nXT4s5azFmrngOAbb=OzF_3gL3g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvu=sRmXQaJ55FTi_8nXT4s5azFmrngOAbb=OzF_3gL3g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

T24gTW9uLCBBcHIgMjQsIDIwMjMgYXQgMDE6MjA6MTJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBNb24sIEFwciAyNCwgMjAyMyBhdCAxMjo1M+KAr1BNIE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwgQXByIDI0LCAyMDIzIGF0
IDExOjUwOjIwQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIFRodSwgQXByIDIw
LCAyMDIzIGF0IDU6MTfigK9QTSBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29t
PiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBPbiA0LzMvMjAyMyA2OjEw
IFBNLCBaaHUsIExpbmdzaGFuIHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBP
biA0LzMvMjAyMyAxOjI4IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4+IE9uIEZyaSwg
TWFyIDMxLCAyMDIzIGF0IDg6NDnigK9QTSBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRl
bC5jb20+Cj4gPiA+ID4gPj4gd3JvdGU6Cj4gPiA+ID4gPj4+IEZvcm1lcmx5LCBpZmN2ZiBkcml2
ZXIgaGFzIGltcGxlbWVudGVkIGEgbGF6eS1pbml0aWFsaXphdGlvbiBtZWNoYW5pc20KPiA+ID4g
PiA+Pj4gZm9yIHRoZSB2aXJ0cXVldWVzIGFuZCBvdGhlciBjb25maWcgc3BhY2UgY29udGVudHMs
Cj4gPiA+ID4gPj4+IGl0IHdvdWxkIHN0b3JlIGFsbCBjb25maWd1cmF0aW9ucyB0aGF0IHBhc3Nl
ZCBkb3duIGZyb20gdGhlIHVzZXJzcGFjZSwKPiA+ID4gPiA+Pj4gdGhlbiBsb2FkIHRoZW0gdG8g
dGhlIGRldmljZSBjb25maWcgc3BhY2UgdXBvbiBEUklWRVJfT0suCj4gPiA+ID4gPj4+Cj4gPiA+
ID4gPj4+IFRoaXMgY2FuIG5vdCBzZXJ2ZSBsaXZlIG1pZ3JhdGlvbiwgc28gdGhpcyBzZXJpZXMg
aW1wbGVtZW50IGFuCj4gPiA+ID4gPj4+IGltbWVkaWF0ZSBpbml0aWFsaXphdGlvbiBtZWNoYW5p
c20sIHdoaWNoIG1lYW5zIHJhdGhlciB0aGFuIHRoZQo+ID4gPiA+ID4+PiBmb3JtZXIgc3RvcmUt
bG9hZCBwcm9jZXNzLCB0aGUgdmlydGlvIG9wZXJhdGlvbnMgbGlrZSB2cSBvcHMKPiA+ID4gPiA+
Pj4gd291bGQgdGFrZSBpbW1lZGlhdGUgYWN0aW9ucyBieSBhY2Nlc3MgdGhlIHZpcnRpbyByZWdp
c3RlcnMuCj4gPiA+ID4gPj4gSXMgdGhlcmUgYW55IGNoYW5jZSB0aGF0IGlmY3ZmIGNhbiB1c2Ug
dmlydGlvX3BjaV9tb2Rlcm5fZGV2IGxpYnJhcnk/Cj4gPiA+ID4gPj4KPiA+ID4gPiA+PiBUaGVu
IHdlIGRvbid0IG5lZWQgdG8gZHVwbGljYXRlIHRoZSBjb2Rlcy4KPiA+ID4gPiA+Pgo+ID4gPiA+
ID4+IE5vdGUgdGhhdCBwZHNfdmRwYSB3aWxsIGJlIHRoZSBzZWNvbmQgdXNlciBmb3IgdmlydGlv
X3BjaV9tb2Rlcm5fZGV2Cj4gPiA+ID4gPj4gbGlicmFyeSAoYW5kIHRoZSBmaXJzdCB2RFBBIHBh
cmVudCB0byB1c2UgdGhhdCBsaWJyYXJ5KS4KPiA+ID4gPiA+IFllcyBJIGFncmVlIHRoaXMgbGli
cmFyeSBjYW4gaGVscCBhIGxvdCBmb3IgYSBzdGFuZGFyZCB2aXJ0aW8gcGNpIGRldmljZS4KPiA+
ID4gPiA+IEJ1dCB0aGlzIGNoYW5nZSB3b3VsZCBiZSBodWdlLCBpdHMgbGlrZSByZXF1aXJlIHRv
IGNoYW5nZSBldmVyeSBsaW5lIG9mCj4gPiA+ID4gPiB0aGUgZHJpdmVyLiBGb3IgZXhhbXBsZSBj
dXJyZW50IGRyaXZlciBmdW5jdGlvbnMgd29yayBvbiB0aGUgYWRhcHRlciBhbmQKPiA+ID4gPiA+
IGlmY3ZmX2h3LCBpZiB3ZSB3YW50cyB0byByZXVzZSB0aGUgbGliLCB3ZSBuZWVkIHRoZSBkcml2
ZXIgd29yayBvbgo+ID4gPiA+ID4gc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZS4KPiA+
ID4gPiA+IEFsbW9zdCBuZWVkIHRvIHJlLXdyaXRlIHRoZSBkcml2ZXIuCj4gPiA+ID4gPgo+ID4g
PiA+ID4gQ2FuIHdlIHBsYW4gdGhpcyBodWdlIGNoYW5nZSBpbiBmb2xsb3dpbmcgc2VyaWVzPwo+
ID4gPiA+IHBpbmcKPiA+ID4KPiA+ID4gV2lsbCBnbyB0aHJvdWdoIHRoaXMgdGhpcyB3ZWVrLgo+
ID4gPgo+ID4gPiBUaGFua3MKPiA+Cj4gPiB3aHkgZG8geW91IGV4cGVjdCBpdCB0byBnbyB0aHJv
dWdoLCB5b3UgZGlkbid0IGFjaz8KPiAKPiBJIG1lYW50IEkgd2lsbCBoYXZlIGEgbG9vayBhdCBp
dCB0aGlzIHdlZWssCj4gCj4gKEdvb2dsZSB0b2xkIG1lICJnbyB0aHJvdWdoIiBtZWFudCAidG8g
bG9vayBhdCBvciBleGFtaW5lIHNvbWV0aGluZyBjYXJlZnVsbHkiKQo+IAo+IFRoYW5rcwoKT2gs
IEkgbWlzcmVhZCB3aGF0IHlvdSB3cm90ZS4gSW5kZWVkLiBGb3Igc29tZSByZWFzb24gSSByZWFk
ICJ0aGlzIHdpbGwKZ28gdGhyb3VnaCB0aGlzIHdlZWsiLiBUaGF0IHdvdWxkIGhhdmUgYmVlbiBk
aWZmZXJlbnQuCgoKPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhhbmtzLAo+ID4gPiA+ID4gWmh1
IExpbmdzaGFuCj4gPiA+ID4gPj4KPiA+ID4gPiA+PiBUaGFua3MKPiA+ID4gPiA+Pgo+ID4gPiA+
ID4+PiBUaGlzIHNlcmllcyBhbHNvIGltcGxlbWVudCBpcnEgc3luY2hyb25pemF0aW9uIGluIHRo
ZSByZXNldAo+ID4gPiA+ID4+PiByb3V0aW5lCj4gPiA+ID4gPj4+Cj4gPiA+ID4gPj4+IFpodSBM
aW5nc2hhbiAoNSk6Cj4gPiA+ID4gPj4+ICAgIHZpcnQgcXVldWUgb3BzIHRha2UgaW1tZWRpYXRl
IGFjdGlvbnMKPiA+ID4gPiA+Pj4gICAgZ2V0X2RyaXZlcl9mZWF0dXJlcyBmcm9tIHZpcml0byBy
ZWdpc3RlcnMKPiA+ID4gPiA+Pj4gICAgcmV0aXJlIGlmY3ZmX3N0YXJ0X2RhdGFwYXRoIGFuZCBp
ZmN2Zl9hZGRfc3RhdHVzCj4gPiA+ID4gPj4+ICAgIHN5bmNocm9uaXplIGlycXMgaW4gdGhlIHJl
c2V0IHJvdXRpbmUKPiA+ID4gPiA+Pj4gICAgYSB2ZW5kb3IgZHJpdmVyIHNob3VsZCBub3Qgc2V0
IF9DT05GSUdfU19GQUlMRUQKPiA+ID4gPiA+Pj4KPiA+ID4gPiA+Pj4gICBkcml2ZXJzL3ZkcGEv
aWZjdmYvaWZjdmZfYmFzZS5jIHwgMTYyCj4gPiA+ID4gPj4+ICsrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tCj4gPiA+ID4gPj4+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2Uu
aCB8ICAxNiArKy0tCj4gPiA+ID4gPj4+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4u
YyB8ICA5NyArKysrLS0tLS0tLS0tLS0tLS0tCj4gPiA+ID4gPj4+ICAgMyBmaWxlcyBjaGFuZ2Vk
LCAxMjIgaW5zZXJ0aW9ucygrKSwgMTUzIGRlbGV0aW9ucygtKQo+ID4gPiA+ID4+Pgo+ID4gPiA+
ID4+PiAtLQo+ID4gPiA+ID4+PiAyLjM5LjEKPiA+ID4gPiA+Pj4KPiA+ID4gPiA+Cj4gPiA+ID4K
PiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
