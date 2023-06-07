Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB74C7EE29
	for <virtualization@archiver.kernel.org>; Wed,  7 Jun 2023 02:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0077D81E07;
	Wed,  7 Jun 2023 02:11:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0077D81E07
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JEoU1KHV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qAFVOMlFRSBj; Wed,  7 Jun 2023 02:11:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5E30A81DF5;
	Wed,  7 Jun 2023 02:11:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E30A81DF5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F435C007A;
	Wed,  7 Jun 2023 02:11:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0A79C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 02:11:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3BFB60D4C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 02:11:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3BFB60D4C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JEoU1KHV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vUfamwsZB1jD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 02:11:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B013960B5D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B013960B5D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 02:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686103878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RAd4y5+O3eSImifxafNCf4uviOOzmlDcfI8xA59qR88=;
 b=JEoU1KHV9NJ4hY/EO9Ow8FMnowiZRndPZr+JL7ynyZlnZ7wMT5Ze1ISo7eSUceQJug2r8J
 Y4p7f78wbfBPd7I0mVIVo/FHg3ZR7/Cu66RAekRxIZDwtIeEB1Zky6zMvBR3vdnVs+JyX7
 AJFUiN/Jjw1HKgdVc6f00Flcl/JVAwg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-DQS4nJl2MoqQzAO2B-9qkQ-1; Tue, 06 Jun 2023 22:11:16 -0400
X-MC-Unique: DQS4nJl2MoqQzAO2B-9qkQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b1b1693338so32702651fa.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Jun 2023 19:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686103875; x=1688695875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RAd4y5+O3eSImifxafNCf4uviOOzmlDcfI8xA59qR88=;
 b=BK0vYN1+ZJhhTLqS2uIEPFHTT1F14Ad+yQXPjieBRy8ZPU0z8UVSj+dluGmgWzA0nU
 swNWElWl8TZEngeJ9VROL28nY/1xcwhXGN/cxRFfiXu1RXbDVKa5+YtpUmm0QBomk1aX
 JacBIons8h9PGP+gkSHi2R03cBVscXz+WiAU01BEwTYEBNNMqPisTbBSn5MV53QRxxBq
 4FD5geoJPxBoFDmEL8iNu4Rk3vnqi4JZVUAd5HZGie+68aM+lJ5h3+/1IwecEbhjB5oI
 43Ow83JLNPpYQTtRCyfCccmIs7vC+6T/gKWbcCQcTZg8Lni7UYzW/HnQ3W07OAkO+hS3
 CtAg==
X-Gm-Message-State: AC+VfDzYedosMOnykz9ldGC6DyX/VjmLSFS/KJD4/Y21Eio9y+K3c+ET
 mLba+yC3wbLdShDh1929ERJg64/DYVlU8xwC79eWPGD34bIWK+y006lCzohcsBdJ/JT9xJBlzsu
 yBWWVmKyxN/f8ctq1+X7y+nBfpRS2m9ppLewGjnSvX65+MpnNZEOYDh40sQ==
X-Received: by 2002:a2e:8ec5:0:b0:2b1:bacc:b3de with SMTP id
 e5-20020a2e8ec5000000b002b1baccb3demr1831488ljl.4.1686103875353; 
 Tue, 06 Jun 2023 19:11:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6R+ZVVNrV5JR/0mOo1J8T/eUXHMmTwBuEzsfzyI0zoS2SnPw2Hkxq9qXSvE2H4n13HyHfoP6+ksOC/s7B78NM=
X-Received: by 2002:a2e:8ec5:0:b0:2b1:bacc:b3de with SMTP id
 e5-20020a2e8ec5000000b002b1baccb3demr1831482ljl.4.1686103875058; Tue, 06 Jun
 2023 19:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230602073442.1765-1-angus.chen@jaguarmicro.com>
 <CACGkMEtCr-LGVH9QJRaMJ2VF3fyDX2zEVwOSJtb-gB_VtSTV2A@mail.gmail.com>
 <SG2PR06MB342012C05627EA6456EF59B18552A@SG2PR06MB3420.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB342012C05627EA6456EF59B18552A@SG2PR06MB3420.apcprd06.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Jun 2023 10:11:04 +0800
Message-ID: <CACGkMEsWkyMOUmnFks9C73BMZB3i86Kg0ig745N3OjJs35PAuw@mail.gmail.com>
Subject: Re: [PATCH] vp_vdpa: Check queue number of vdpa device from add_config
To: Angus Chen <angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>
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

T24gVHVlLCBKdW4gNiwgMjAyMyBhdCAyOjE54oCvUE0gQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBq
YWd1YXJtaWNyby5jb20+IHdyb3RlOgo+Cj4gSGksSmFzb24uCj4KPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+
ID4gU2VudDogTW9uZGF5LCBKdW5lIDUsIDIwMjMgMjo1NCBQTQo+ID4gVG86IEFuZ3VzIENoZW4g
PGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPgo+ID4gQ2M6IG1zdEByZWRoYXQuY29tOyB2aXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsKPiA+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcKPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZwX3ZkcGE6IENoZWNrIHF1
ZXVlIG51bWJlciBvZiB2ZHBhIGRldmljZSBmcm9tCj4gPiBhZGRfY29uZmlnCj4gPgo+ID4gT24g
RnJpLCBKdW4gMiwgMjAyMyBhdCAzOjM14oCvUE0gQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1
YXJtaWNyby5jb20+Cj4gPiB3cm90ZToKPiA+ID4KPiA+ID4gV2hlbiBhZGQgdmlydGlvX3BjaSB2
ZHBhIGRldmljZSxjaGVjayB0aGUgdnFzIG51bWJlciBvZiBkZXZpY2UgY2FwCj4gPiA+IGFuZCBt
YXhfdnFfcGFpcnMgZnJvbSBhZGRfY29uZmlnLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBB
bmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4KPiA+ID4gLS0tCj4gPiA+ICBk
cml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMgfCAxMSArKysrKysrKystLQo+ID4gPiAg
MSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+ID4KPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+ID4gYi9k
cml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMKPiA+ID4gaW5kZXggMjgxMjg3ZmFlODlm
Li40YmYxYWI2MzdkMzIgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNp
L3ZwX3ZkcGEuYwo+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMK
PiA+ID4gQEAgLTQ3OCw3ICs0NzgsNyBAQCBzdGF0aWMgaW50IHZwX3ZkcGFfZGV2X2FkZChzdHJ1
Y3QgdmRwYV9tZ210X2Rldgo+ID4gKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPiA+ID4gICAg
ICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Owo+ID4gPiAgICAgICAgIHN0cnVj
dCB2cF92ZHBhICp2cF92ZHBhID0gTlVMTDsKPiA+ID4gICAgICAgICB1NjQgZGV2aWNlX2ZlYXR1
cmVzOwo+ID4gPiAtICAgICAgIGludCByZXQsIGk7Cj4gPiA+ICsgICAgICAgaW50IHJldCwgaSwg
cXVldWVzOwo+ID4gPgo+ID4gPiAgICAgICAgIHZwX3ZkcGEgPSB2ZHBhX2FsbG9jX2RldmljZShz
dHJ1Y3QgdnBfdmRwYSwgdmRwYSwKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZGV2LCAmdnBfdmRwYV9vcHMsIDEsIDEsIG5hbWUsCj4gPiBmYWxzZSk7Cj4gPiA+IEBA
IC00OTEsNyArNDkxLDE0IEBAIHN0YXRpYyBpbnQgdnBfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBh
X21nbXRfZGV2Cj4gPiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+ID4gPiAgICAgICAgIHZw
X3ZkcGFfbWd0ZGV2LT52cF92ZHBhID0gdnBfdmRwYTsKPiA+ID4KPiA+ID4gICAgICAgICB2cF92
ZHBhLT52ZHBhLmRtYV9kZXYgPSAmcGRldi0+ZGV2Owo+ID4gPiAtICAgICAgIHZwX3ZkcGEtPnF1
ZXVlcyA9IHZwX21vZGVybl9nZXRfbnVtX3F1ZXVlcyhtZGV2KTsKPiA+ID4gKyAgICAgICBxdWV1
ZXMgPSB2cF9tb2Rlcm5fZ2V0X251bV9xdWV1ZXMobWRldik7Cj4gPiA+ICsgICAgICAgaWYgKGFk
ZF9jb25maWctPm1hc2sgJgo+ID4gQklUX1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFYX1ZR
UCkpIHsKPiA+ID4gKyAgICAgICAgICAgICAgIGlmIChhZGRfY29uZmlnLT5uZXQubWF4X3ZxX3Bh
aXJzID4gcXVldWVzIC8gMikKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7Cj4gPiA+ICsgICAgICAgICAgICAgICBxdWV1ZXMgPSBtaW5fdCh1MzIsIHF1ZXVlcywg
MiAqCj4gPiBhZGRfY29uZmlnLT5uZXQubWF4X3ZxX3BhaXJzKTsKPiA+Cj4gPiBMb29rcyBsaWtl
IHlvdSB3YW50IHRvIG1lZGlhdGUgdGhlIG1heF92cXAgaGVyZSwgYnV0IHdoYXQgaGFwcGVuczoK
PiA+Cj4gPiAxKSBoYXJ3YXJlIGhhdmUgNCBxdWV1ZSBwYXJpcwo+ID4gMikgdnBfdmRwYSBjYXAg
aXQgaW50byAyIHF1ZXVlIHBhaXJzCj4gPiAzKSBndWVzdCBtYXkgc3RpbGwgdHJ5IHRvIGVuYWJs
ZSA0IHF1ZXVlIHBhcmlzCj4gPgo+IFllc++8jHlvdSBhcmUgcmlnaHTvvIx0aGlzIHNpdHVhdGlv
biBjYW4gb2NjdXIuCj4gPiBGb3IgMyksIHRoZSBrZXJuZWwgbmVlZHMgdG8gbWVkaWF0ZSB0aGUg
Y29udHJvbCB2aXJ0cXVldWUgd2hpY2ggc2VlbXMgbm90Cj4gPiBlYXN5Lgo+ID4KPiA+IEhvdyBh
Ym91dCBzaW1wbHkgc3RhcnRpbmcgZnJvbSBmYWlsaW5nIGlmIHRoZSBwcm92aXNpb25lZCAjcXAg
aXMgbm90Cj4gPiBlcXVhbCB0byB0aGUgb25lIHRoYXQgaGFyZHdhcmUgaGFzPwo+IE9rLFlvdSBt
ZWFuIHdlIGp1c3QgY2hlY2sgaXQgaW4gdnBfdmRwYSBvciBjaGVjayBpdCBpbiBhbGwgb3RoZXIg
dmRwYSBuZXQgZHJpdmVycz8KCnZwX3ZkcGEgb25seSwgc2luY2UgaW4gc29tZSBvdGhlciBraW5k
IG9mIHBhcmVudHMsICNxcHMgY291bGQgYmUgcHJvdmlzaW9uZWQuCgpUaGFua3MKCj4gPgo+ID4g
VGhhbmtzCj4gPgo+ID4gPiArICAgICAgIH0KPiA+ID4gKwo+ID4gPiArICAgICAgIHZwX3ZkcGEt
PnF1ZXVlcyA9IHF1ZXVlczsKPiA+ID4gICAgICAgICB2cF92ZHBhLT5tZGV2ID0gbWRldjsKPiA+
ID4KPiA+ID4gICAgICAgICBkZXZpY2VfZmVhdHVyZXMgPSB2cF9tb2Rlcm5fZ2V0X2ZlYXR1cmVz
KG1kZXYpOwo+ID4gPiAtLQo+ID4gPiAyLjI1LjEKPiA+ID4KPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
