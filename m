Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5401C433B4
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 14:03:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4849861353
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 14:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4849861353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A8CB40646;
	Tue, 13 Apr 2021 14:03:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bRkWQboMuHOg; Tue, 13 Apr 2021 14:03:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id C51B540527;
	Tue, 13 Apr 2021 14:03:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E04EC000C;
	Tue, 13 Apr 2021 14:03:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCD65C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AA911400F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1wqR7vvpWnbE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:03:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C4E01400D7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618322582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swYl2fUsBiiVjxnatT+LNRdbKdi4oKKSZ6QxSoSZPJk=;
 b=PbW37CKZJrihJFDXw9T6d/RD5Z3O3OZXjTkONTsnCzOzb/EP1T2efX0+uu1rqoANsAOhTN
 GosoBEWXhAIG45dizq+8pds5Ms3AW8cgPsW9BxckidefBNKredetNNQGg/woQ41ttRPSSm
 t1gCTmyzDeeWwStjP97zLtzMTj7XcPg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-dViiA7eAOH-LwFCHOSDIRQ-1; Tue, 13 Apr 2021 10:03:00 -0400
X-MC-Unique: dViiA7eAOH-LwFCHOSDIRQ-1
Received: by mail-wr1-f72.google.com with SMTP id h30so816216wrh.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=swYl2fUsBiiVjxnatT+LNRdbKdi4oKKSZ6QxSoSZPJk=;
 b=s6m4vzvNEYA57TLDTTEZyPcOTGFshX+6t3Hy0w+BVxmado2tptTNHkZuuednp9NfYm
 K/BS+Loa5u9mcQJRBgo2BYN+QCjVfhhkrIvIRjlWTw9IdH67TWevA4k0QbdrzAmCrlMG
 I1bxN/3jsIo0OpZ59NNCvi5TRXbmpwpAu+2l+xuTGDj2gWhdOYawSnQxyxAKJ8WXqirs
 PrUHLq6SNH8qE5z6sHDVfif0kfCzsWDyUzg98rScIMwSR9ggYvaMp0AypIEXl0Z+lHtv
 SrJFFp/+WDoTLrKdFe4UG69xAFFxALmiu9fCT+p5EyQsJOidKq4lD4XxNcIJ4pq3Y7yL
 P+kQ==
X-Gm-Message-State: AOAM532AkxTbh6haTGgYgl4kGCOAVKHpYoUror2NiyQYcBspBnw3C7wk
 pSFwQSBeQpmcmsULEylnEigK+XrOxT58ze/K5iGcGXAiIFmKmoub0gpp/1wi2ldhX1TbV8C6xV8
 BXCMiFB+uxY1Y1Bq/H9CiQSisYZvkrlVzE6hqvUU4Jw==
X-Received: by 2002:a05:600c:2312:: with SMTP id
 18mr188044wmo.68.1618322579652; 
 Tue, 13 Apr 2021 07:02:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytEpDKGiR9o7JztK9xr/CiCIDyo4VVVhCw7mpf/3UO/HzypD1HWJ5i0ZPENNve3YfdPorFWg==
X-Received: by 2002:a05:600c:2312:: with SMTP id
 18mr188006wmo.68.1618322579419; 
 Tue, 13 Apr 2021 07:02:59 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id q20sm2867997wmq.2.2021.04.13.07.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 07:02:58 -0700 (PDT)
Date: Tue, 13 Apr 2021 10:02:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC v2 3/4] virtio_net: move tx vq operation under tx
 queue lock
Message-ID: <20210413100222-mutt-send-email-mst@kernel.org>
References: <20210413054733.36363-1-mst@redhat.com>
 <20210413054733.36363-4-mst@redhat.com>
 <805053bf-960f-3c34-ce23-012d121ca937@redhat.com>
MIME-Version: 1.0
In-Reply-To: <805053bf-960f-3c34-ce23-012d121ca937@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
 David Miller <davem@davemloft.net>
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

T24gVHVlLCBBcHIgMTMsIDIwMjEgYXQgMDQ6NTQ6NDJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS80LzEzIOS4i+WNiDE6NDcsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnp
gZM6Cj4gPiBJdCdzIHVuc2FmZSB0byBvcGVyYXRlIGEgdnEgZnJvbSBtdWx0aXBsZSB0aHJlYWRz
Lgo+ID4gVW5mb3J0dW5hdGVseSB0aGlzIGlzIGV4YWN0bHkgd2hhdCB3ZSBkbyB3aGVuIGludm9r
aW5nCj4gPiBjbGVhbiB0eCBwb2xsIGZyb20gcnggbmFwaS4KPiA+IEFzIGEgZml4IG1vdmUgZXZl
cnl0aGluZyB0aGF0IGRlYWxzIHdpdGggdGhlIHZxIHRvIHVuZGVyIHR4IGxvY2suCj4gPiAKPiA+
IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4gPiAt
LS0KPiA+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMjIgKysrKysrKysrKysrKysrKysr
KysrLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPiBpbmRleCAxNmQ1YWJlZDU4MmMuLjQ2MGNjZGJiODQwZSAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPiBAQCAtMTUwNSw2ICsxNTA1LDggQEAgc3RhdGljIGludCB2
aXJ0bmV0X3BvbGxfdHgoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLCBpbnQgYnVkZ2V0KQo+ID4g
ICAJc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBzcS0+dnEtPnZkZXYtPnByaXY7Cj4gPiAgIAl1
bnNpZ25lZCBpbnQgaW5kZXggPSB2cTJ0eHEoc3EtPnZxKTsKPiA+ICAgCXN0cnVjdCBuZXRkZXZf
cXVldWUgKnR4cTsKPiA+ICsJaW50IG9wYXF1ZTsKPiA+ICsJYm9vbCBkb25lOwo+ID4gICAJaWYg
KHVubGlrZWx5KGlzX3hkcF9yYXdfYnVmZmVyX3F1ZXVlKHZpLCBpbmRleCkpKSB7Cj4gPiAgIAkJ
LyogV2UgZG9uJ3QgbmVlZCB0byBlbmFibGUgY2IgZm9yIFhEUCAqLwo+ID4gQEAgLTE1MTQsMTAg
KzE1MTYsMjggQEAgc3RhdGljIGludCB2aXJ0bmV0X3BvbGxfdHgoc3RydWN0IG5hcGlfc3RydWN0
ICpuYXBpLCBpbnQgYnVkZ2V0KQo+ID4gICAJdHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZSh2aS0+
ZGV2LCBpbmRleCk7Cj4gPiAgIAlfX25ldGlmX3R4X2xvY2sodHhxLCByYXdfc21wX3Byb2Nlc3Nv
cl9pZCgpKTsKPiA+ICsJdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3EtPnZxKTsKPiA+ICAgCWZyZWVf
b2xkX3htaXRfc2ticyhzcSwgdHJ1ZSk7Cj4gPiArCj4gPiArCW9wYXF1ZSA9IHZpcnRxdWV1ZV9l
bmFibGVfY2JfcHJlcGFyZShzcS0+dnEpOwo+ID4gKwo+ID4gKwlkb25lID0gbmFwaV9jb21wbGV0
ZV9kb25lKG5hcGksIDApOwo+ID4gKwo+ID4gKwlpZiAoIWRvbmUpCj4gPiArCQl2aXJ0cXVldWVf
ZGlzYWJsZV9jYihzcS0+dnEpOwo+ID4gKwo+ID4gICAJX19uZXRpZl90eF91bmxvY2sodHhxKTsK
PiA+IC0JdmlydHF1ZXVlX25hcGlfY29tcGxldGUobmFwaSwgc3EtPnZxLCAwKTsKPiAKPiAKPiBT
byBJIHdvbmRlciB3aHkgbm90IHNpbXBseSBtb3ZlIF9fbmV0aWZfdHhfdW5sb2NrKCkgYWZ0ZXIK
PiB2aXJ0cXVldWVfbmFwaV9jb21wbGV0ZSgpPwo+IAo+IFRoYW5rcwo+IAoKCkJlY2F1c2UgdGhh
dCBjYWxscyB0eCBwb2xsIHdoaWNoIGFsc28gdGFrZXMgdHggbG9jayBpbnRlcm5hbGx5IC4uLgoK
Cj4gPiArCWlmIChkb25lKSB7Cj4gPiArCQlpZiAodW5saWtlbHkodmlydHF1ZXVlX3BvbGwoc3Et
PnZxLCBvcGFxdWUpKSkgewo+ID4gKwkJCWlmIChuYXBpX3NjaGVkdWxlX3ByZXAobmFwaSkpIHsK
PiA+ICsJCQkJX19uZXRpZl90eF9sb2NrKHR4cSwgcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSk7Cj4g
PiArCQkJCXZpcnRxdWV1ZV9kaXNhYmxlX2NiKHNxLT52cSk7Cj4gPiArCQkJCV9fbmV0aWZfdHhf
dW5sb2NrKHR4cSk7Cj4gPiArCQkJCV9fbmFwaV9zY2hlZHVsZShuYXBpKTsKPiA+ICsJCQl9Cj4g
PiArCQl9Cj4gPiArCX0KPiA+ICAgCWlmIChzcS0+dnEtPm51bV9mcmVlID49IDIgKyBNQVhfU0tC
X0ZSQUdTKQo+ID4gICAJCW5ldGlmX3R4X3dha2VfcXVldWUodHhxKTsKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
