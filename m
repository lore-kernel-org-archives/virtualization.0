Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC834C433ED
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 04:44:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E328613AF
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 04:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E328613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B21840640;
	Tue, 13 Apr 2021 04:44:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KHIGQeW_nRjT; Tue, 13 Apr 2021 04:44:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 864CB4062C;
	Tue, 13 Apr 2021 04:44:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67A20C000B;
	Tue, 13 Apr 2021 04:44:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8448C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 04:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC70C84315
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 04:44:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GVrBavgBbqHR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 04:44:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0DB4A842D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 04:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618289095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wDczzAK1tN32uP9QkN5horeOETv54ia6Z1jxE80Xo9k=;
 b=EeGaBh7qLqXEDmROYSXyo8UIOY41VZY/V9KQwtfJUMWr8rxR9e4EJXwlkpwNBQe4woW2F/
 TvPN+Ujl34MDY5bPpCMbi9Jw62SL17nEtMLKNog/Lfc1z3eSwBGiYc5kE+AG6Yv9Gq0wyj
 5aDJOB6mmxoEzFaPqwrnuOEsZ+nabmU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-VJP0-Al4MHiNHLiODE_83A-1; Tue, 13 Apr 2021 00:44:53 -0400
X-MC-Unique: VJP0-Al4MHiNHLiODE_83A-1
Received: by mail-wr1-f72.google.com with SMTP id h30so262643wrh.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 21:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=wDczzAK1tN32uP9QkN5horeOETv54ia6Z1jxE80Xo9k=;
 b=Gk/8Xgpz8PgemEGM5piyYh6QGzce1zevVDfLD06bXNQxJUXtnWnGH0h8Vyek1YllGC
 Ze+L1S2GYmTMgO3mDSWSXiL8Qor9HgTrK9UB9DVAamhR6qHbDa13W3A9YxPHnfxcnmEa
 TK5WVrwg9L6cKH1P40EyqWKxqPm/4Y7ESlRaj7h8o60CtA7FO63IJOQpLFj1MVTmW/fa
 Gu3Eu+DUABUloZFqzILqwdmOh16OteeNth+srsUTKkLfqEqRso7lNzJqRhytQzIklJ+N
 8RiLxZeR/yf4QMPMTMnRnlD6tEESbZ98mx+ICnCyOyVLKTmnMXde6ZqCKJXzTUyV5zvP
 9JQw==
X-Gm-Message-State: AOAM533tMezsB/WpTPBJf4Lz05S6EKhXallSnanxHm8pyZUXaZT9rBGB
 3gfFoVespNUlYZ97YlLNh3FIHNGUvfqBGdtiFKncH4On7mK3AmzIRjmfWMOeeo2X6WFtzMY3rdc
 zqcDJYne0wF2ERWfuSO9ukbZHJ24lhPRJ4BIxkmB7JQ==
X-Received: by 2002:a7b:c357:: with SMTP id l23mr2095295wmj.152.1618289091985; 
 Mon, 12 Apr 2021 21:44:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIuOFwgHGR4OSNafdGLRvynZxABYUO6EySinwlp1D/tpmx1kJ86ngnWhf1GIs2M9saDpLrEA==
X-Received: by 2002:a7b:c357:: with SMTP id l23mr2095285wmj.152.1618289091786; 
 Mon, 12 Apr 2021 21:44:51 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id b5sm18169130wri.57.2021.04.12.21.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 21:44:51 -0700 (PDT)
Date: Tue, 13 Apr 2021 00:44:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: virtio-net: locking in tx napi
Message-ID: <20210413004420-mutt-send-email-mst@kernel.org>
References: <20210412175341-mutt-send-email-mst@kernel.org>
 <20210412183054-mutt-send-email-mst@kernel.org>
 <cebebed3-7a92-5471-117f-774286731cf5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cebebed3-7a92-5471-117f-774286731cf5@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>,
 virtualization@lists.linux-foundation.org
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

T24gVHVlLCBBcHIgMTMsIDIwMjEgYXQgMTA6Mjk6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS80LzEzIOS4iuWNiDY6MzEsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnp
gZM6Cj4gPiBPbiBNb24sIEFwciAxMiwgMjAyMSBhdCAwNjowMzo1MFBNIC0wNDAwLCBNaWNoYWVs
IFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+IEkgd2FzIHdvcmtpbmcgb24gdGhlIHNwdXJpb3MgaW50
ZXJydXB0IHByb2JsZW0gYW5kCj4gPiA+IEkgbm90aWNlZCBzb21ldGhpbmcgd2VpcmQuCj4gPiA+
IAo+ID4gPiBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbF90eChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5h
cGksIGludCBidWRnZXQpCj4gPiA+IHsKPiA+ID4gICAgICAgICAgc3RydWN0IHNlbmRfcXVldWUg
KnNxID0gY29udGFpbmVyX29mKG5hcGksIHN0cnVjdCBzZW5kX3F1ZXVlLCBuYXBpKTsKPiA+ID4g
ICAgICAgICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBzcS0+dnEtPnZkZXYtPnByaXY7Cj4g
PiA+ICAgICAgICAgIHVuc2lnbmVkIGludCBpbmRleCA9IHZxMnR4cShzcS0+dnEpOwo+ID4gPiAg
ICAgICAgICBzdHJ1Y3QgbmV0ZGV2X3F1ZXVlICp0eHE7Cj4gPiA+IAo+ID4gPiAgICAgICAgICBp
ZiAodW5saWtlbHkoaXNfeGRwX3Jhd19idWZmZXJfcXVldWUodmksIGluZGV4KSkpIHsKPiA+ID4g
ICAgICAgICAgICAgICAgICAvKiBXZSBkb24ndCBuZWVkIHRvIGVuYWJsZSBjYiBmb3IgWERQICov
Cj4gPiA+ICAgICAgICAgICAgICAgICAgbmFwaV9jb21wbGV0ZV9kb25lKG5hcGksIDApOwo+ID4g
PiAgICAgICAgICAgICAgICAgIHJldHVybiAwOwo+ID4gPiAgICAgICAgICB9Cj4gPiA+IAo+ID4g
PiAgICAgICAgICB0eHEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVlKHZpLT5kZXYsIGluZGV4KTsKPiA+
ID4gICAgICAgICAgX19uZXRpZl90eF9sb2NrKHR4cSwgcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSk7
Cj4gPiA+ICAgICAgICAgIGZyZWVfb2xkX3htaXRfc2ticyhzcSwgdHJ1ZSk7Cj4gPiA+ICAgICAg
ICAgIF9fbmV0aWZfdHhfdW5sb2NrKHR4cSk7Cj4gPiA+ICAgICAgICAgIHZpcnRxdWV1ZV9uYXBp
X2NvbXBsZXRlKG5hcGksIHNxLT52cSwgMCk7Cj4gPiA+ICAgICAgICAgIGlmIChzcS0+dnEtPm51
bV9mcmVlID49IDIgKyBNQVhfU0tCX0ZSQUdTKQo+ID4gPiAgICAgICAgICAgICAgICAgIG5ldGlm
X3R4X3dha2VfcXVldWUodHhxKTsKPiA+ID4gICAgICAgICAgcmV0dXJuIDA7Cj4gPiA+IH0KPiA+
ID4gCj4gPiA+IFNvIHZpcnRxdWV1ZV9uYXBpX2NvbXBsZXRlIGlzIGNhbGxlZCB3aGVuIHR4cSBp
cyBub3QgbG9ja2VkLAo+ID4gPiB0aGlua2FibHkgc3RhcnRfeG1pdCBjYW4gaGFwcGVuIHJpZ2h0
Pwo+IAo+IAo+IFllcywgSSB0aGluayBzby4KPiAKPiAKPiA+ID4gCj4gPiA+IE5vdyB2aXJ0cXVl
dWVfbmFwaV9jb21wbGV0ZQo+ID4gPiAKPiA+ID4gc3RhdGljIHZvaWQgdmlydHF1ZXVlX25hcGlf
Y29tcGxldGUoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLAo+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRxdWV1ZSAqdnEsIGludCBwcm9jZXNzZWQp
Cj4gPiA+IHsKPiA+ID4gICAgICAgICAgaW50IG9wYXF1ZTsKPiA+ID4gCj4gPiA+ICAgICAgICAg
IG9wYXF1ZSA9IHZpcnRxdWV1ZV9lbmFibGVfY2JfcHJlcGFyZSh2cSk7Cj4gPiA+ICAgICAgICAg
IGlmIChuYXBpX2NvbXBsZXRlX2RvbmUobmFwaSwgcHJvY2Vzc2VkKSkgewo+ID4gPiAgICAgICAg
ICAgICAgICAgIGlmICh1bmxpa2VseSh2aXJ0cXVldWVfcG9sbCh2cSwgb3BhcXVlKSkpCj4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0cXVldWVfbmFwaV9zY2hlZHVsZShuYXBpLCB2
cSk7Cj4gPiA+ICAgICAgICAgIH0gZWxzZSB7Cj4gPiA+ICAgICAgICAgICAgICAgICAgdmlydHF1
ZXVlX2Rpc2FibGVfY2IodnEpOwo+ID4gPiAgICAgICAgICB9Cj4gPiA+IH0KPiA+ID4gCj4gPiA+
IAo+ID4gPiBTbyBpdCBpcyBjYWxsaW5nIHZpcnRxdWV1ZV9lbmFibGVfY2JfcHJlcGFyZSBidXQg
dHggcXVldWUKPiA+ID4gY291bGQgYmUgcnVubmluZyBhbmQgY2FuIHByb2Nlc3MgdGhpbmdzIGlu
IHBhcmFsbGVsIC4uLgo+ID4gPiBXaGF0IGdpdmVzPyBJIHN1c3BlY3QgdGhpcyBjb3JydXB0cyB0
aGUgcmluZywgYW5kIGV4cGxhaW5zCj4gPiA+IHdoeSB3ZSBhcmUgc2VlaW5nIHdlaXJkIGhhbmdz
IHdpdGggdmhvc3QgcGFja2VkIHJpbmcgLi4uCj4gPiA+IAo+ID4gPiBKYXNvbj8KPiAKPiAKPiBJ
dCBtaWdodCBjYXVzZSB0aGUgaW50ZXJydXB0IHRvIGJlIGRpc2FibGVkIHVuZXhwZWN0ZWRseSBJ
IHRoaW5rLgo+IAo+IAo+ID4gPiAKPiA+ID4gCj4gPiA+IC0tIAo+ID4gPiBNU1QKPiA+IGFuZCB3
b3VsZG4ndCB0aGUgZm9sbG93aW5nIHVudGVzdGVkIHBhdGNoIG1ha2Ugc2Vuc2UgdGhlbj8KPiA+
IAo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPiBpbmRleCA4MmU1MjBkMmNiMTIuLmMyMzM0MWIxOGViNSAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPiBAQCAtMTUwNCw2ICsxNTA1LDggQEAgc3RhdGljIGludCB2
aXJ0bmV0X3BvbGxfdHgoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLCBpbnQgYnVkZ2V0KQo+ID4g
ICAJc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBzcS0+dnEtPnZkZXYtPnByaXY7Cj4gPiAgIAl1
bnNpZ25lZCBpbnQgaW5kZXggPSB2cTJ0eHEoc3EtPnZxKTsKPiA+ICAgCXN0cnVjdCBuZXRkZXZf
cXVldWUgKnR4cTsKPiA+ICsJaW50IG9wYXF1ZTsKPiA+ICsJYm9vbCBkb25lOwo+ID4gICAJaWYg
KHVubGlrZWx5KGlzX3hkcF9yYXdfYnVmZmVyX3F1ZXVlKHZpLCBpbmRleCkpKSB7Cj4gPiAgIAkJ
LyogV2UgZG9uJ3QgbmVlZCB0byBlbmFibGUgY2IgZm9yIFhEUCAqLwo+ID4gQEAgLTE1MTQsOSAr
MTUxNywyNiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbF90eChzdHJ1Y3QgbmFwaV9zdHJ1Y3Qg
Km5hcGksIGludCBidWRnZXQpCj4gPiAgIAl0eHEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVlKHZpLT5k
ZXYsIGluZGV4KTsKPiA+ICAgCV9fbmV0aWZfdHhfbG9jayh0eHEsIHJhd19zbXBfcHJvY2Vzc29y
X2lkKCkpOwo+ID4gICAJZnJlZV9vbGRfeG1pdF9za2JzKHNxLCB0cnVlKTsKPiA+ICsKPiA+ICsJ
b3BhcXVlID0gdmlydHF1ZXVlX2VuYWJsZV9jYl9wcmVwYXJlKHNxLT52cSk7Cj4gPiArCj4gPiAr
CWRvbmUgPSBuYXBpX2NvbXBsZXRlX2RvbmUobmFwaSwgMCk7Cj4gPiArCj4gPiArCWlmICghZG9u
ZSkKPiA+ICsJCXZpcnRxdWV1ZV9kaXNhYmxlX2NiKHNxLT52cSk7Cj4gPiArCj4gPiAgIAlfX25l
dGlmX3R4X3VubG9jayh0eHEpOwo+ID4gLQl2aXJ0cXVldWVfbmFwaV9jb21wbGV0ZShuYXBpLCBz
cS0+dnEsIDApOwo+ID4gKwlpZiAoZG9uZSkgewo+ID4gKwkJaWYgKHVubGlrZWx5KHZpcnRxdWV1
ZV9wb2xsKHZxLCBvcGFxdWUpKSkgewo+ID4gKwkJCWlmIChuYXBpX3NjaGVkdWxlX3ByZXAobmFw
aSkpIHsKPiA+ICsJCQkJX19uZXRpZl90eF9sb2NrKHR4cSwgcmF3X3NtcF9wcm9jZXNzb3JfaWQo
KSk7Cj4gPiArCQkJCXZpcnRxdWV1ZV9kaXNhYmxlX2NiKHNxLT52cSk7Cj4gPiArCQkJCV9fbmV0
aWZfdHhfdW5sb2NrKHR4cSk7Cj4gPiArCQkJCV9fbmFwaV9zY2hlZHVsZShuYXBpKTsKPiA+ICsJ
CQl9Cj4gPiArCQl9Cj4gPiArCX0KPiA+ICAgCWlmIChzcS0+dnEtPm51bV9mcmVlID49IDIgKyBN
QVhfU0tCX0ZSQUdTKQo+ID4gICAJCW5ldGlmX3R4X3dha2VfcXVldWUodHhxKTsKPiAKPiAKPiBJ
IHdvbmRlciB3aHkgbm90IHNpbXBseSBwcm90ZWN0IHRoZSB3aG9sZSBwb2xsX3R4IHdpdGggdHgg
bG9jayBpbiB0aGlzIGNhc2U/Cj4gCj4gVGhhbmtzCj4gCgpXZWxsIGl0IHRha2VzIF9fbmV0aWZf
dHhfbG9jayBpbnRlcm5hbGx5IGRvZXMgaXQgbm90PyBTb3VuZHMgbGlrZSBhCmRlYWRsb2NrIHRv
IG1lIC4uLAoKLS0gCk1TVAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
