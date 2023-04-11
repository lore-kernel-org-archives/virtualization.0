Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63607C76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 05:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 037D981B52;
	Tue, 11 Apr 2023 05:24:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 037D981B52
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CF4UVRXH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gSQUlohQP9Um; Tue, 11 Apr 2023 05:24:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A07EF81B70;
	Tue, 11 Apr 2023 05:24:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A07EF81B70
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7702AC0036;
	Tue, 11 Apr 2023 05:24:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3E9BC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B84981B70
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:24:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B84981B70
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rXCUBNwA6FRV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:24:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BBD8681B52
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BBD8681B52
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681190656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DVhWWieG2vkXVLOuG6DQVebw7i6yeNydJngBNWHNr0=;
 b=CF4UVRXHBroEImfiZREFbiV1endoOGBFoX7LBH1sFg5zZB6t5YQ+Qvqkyy9jZb9qx5Kd+u
 i9fbK4dGoFjIvL6m0/vsuSS5RIdDNVEZsViNAW4aTWg+2W9bEvQUFRKM7N44WVZXs7LlQF
 ICKuOf3QGemmCzl3yf+oHwhSKILJF34=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-sAcxkIKfNPWAPJNTGIT8qQ-1; Tue, 11 Apr 2023 01:24:15 -0400
X-MC-Unique: sAcxkIKfNPWAPJNTGIT8qQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 r77-20020a4a3750000000b0053b5762f31cso2320772oor.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 22:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681190654; x=1683782654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/DVhWWieG2vkXVLOuG6DQVebw7i6yeNydJngBNWHNr0=;
 b=l0R8AuqFsZLBFrVRrS0fSxyXUUiQD63BDpqThSP5EZeq1BW93uckcvvBfNFrLfr1mN
 40+dWDDHnO8HCa0tDgC0PSYQmEDs7rLkgKPEBvAub38Z5nmZFeY6JbP9RhQD80Bsfyaq
 CrEfX4te3U97gzU3z9bjhqEzeQpYnY9jsN0C+JvMthrC5ctJo54nn6IFMIRUmfXAqn1K
 bl2HxhsHakU00rQBu0HZJXWsb+kzZ2bmwBAv58Y2/lJH2tVbVGEKZSC8zb88sgNh66IS
 RKjIdwEGg/AdqSJWNihKQ1DhuH7oFl4VUld9A2NbX/DZR0Iqlz1hg1UEjDKffAEFjmOq
 8nog==
X-Gm-Message-State: AAQBX9ePGz/RpADgT7rJuhwaiB56Swuu/NJ3hFQhga8t+P8H5mBKIm6T
 TpDMIV77pOktFariL02cxarhLvt92WqiR/bu7cHzrl4h+IcAblazzRHrdBWk/l+KQrW7c8mIc3T
 M7W3As0O9i+u30ztkD9b9nqG9Bu+Wi1aw24TRX07sQmHN8x96dNfmq7DeOQ==
X-Received: by 2002:a05:6830:1d9:b0:698:f988:7c30 with SMTP id
 r25-20020a05683001d900b00698f9887c30mr3156636ota.2.1681190654566; 
 Mon, 10 Apr 2023 22:24:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350a1ZyD/uTYCVLx4tYIF7obhSms66g3rjlqu9z003DbPezPPYRqzgDKer1skAg+fkXm6Q8CFSeHsXJF4/vGHx/I=
X-Received: by 2002:a05:6830:1d9:b0:698:f988:7c30 with SMTP id
 r25-20020a05683001d900b00698f9887c30mr3156634ota.2.1681190654349; Mon, 10 Apr
 2023 22:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Apr 2023 13:24:03 +0800
Message-ID: <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
To: Angus Chen <angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgOTozOeKAr0FNIEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5A
amFndWFybWljcm8uY29tPiB3cm90ZToKPgo+IFdlIHJlYWQgdGhlIHN0YXR1cyBvZiBkZXZpY2Ug
YWZ0ZXIgcmVzZXQsCj4gSXQgaXMgbm90IGd1YXJhbnRlZWQgdGhhdCB0aGUgZGV2aWNlIGJlIHJl
c2V0ZWQgc3VjY2Vzc2Z1bGx5Lgo+IFdlIGNhbiB1c2UgYSB3aGlsZSBsb29wIHRvIG1ha2Ugc3Vy
ZSB0aGF0LGxpa2UgdGhlIG1vZGVybiBkZXZpY2UgZGlkLgo+IFRoZSBzcGVjIGlzIG5vdCByZXF1
ZXN0IGl0ICxidXQgaXQgd29yay4KClRoZSBvbmx5IGNvbmNlcm4gaXMgaWYgaXQncyB0b28gbGF0
ZSB0byBkbyB0aGlzLgoKQnR3LCBhbnkgcmVhc29uIHlvdSB3YW50IHRvIGhhdmUgYSBsZWdhY3kg
aGFyZHdhcmUgaW1wbGVtZW50YXRpb24uIEl0CndpbGwgYmUgdmVyeSB0cmlja3kgdG8gd29yayBj
b3JyZWN0bHkuCgpUaGFua3MKCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmd1cyBDaGVuIDxhbmd1cy5j
aGVuQGphZ3Vhcm1pY3JvLmNvbT4KPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9s
ZWdhY3kuYyB8IDQgKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdh
Y3kuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKPiBpbmRleCAyMjU3ZjFi
M2Q4YWUuLmYyZDI0MTU2M2U0ZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX2xlZ2FjeS5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+
IEBAIC0xNCw2ICsxNCw3IEBACj4gICAqICBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQu
Y29tPgo+ICAgKi8KPgo+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KPiAgI2luY2x1ZGUgImxp
bnV4L3ZpcnRpb19wY2lfbGVnYWN5LmgiCj4gICNpbmNsdWRlICJ2aXJ0aW9fcGNpX2NvbW1vbi5o
Igo+Cj4gQEAgLTk3LDcgKzk4LDggQEAgc3RhdGljIHZvaWQgdnBfcmVzZXQoc3RydWN0IHZpcnRp
b19kZXZpY2UgKnZkZXYpCj4gICAgICAgICB2cF9sZWdhY3lfc2V0X3N0YXR1cygmdnBfZGV2LT5s
ZGV2LCAwKTsKPiAgICAgICAgIC8qIEZsdXNoIG91dCB0aGUgc3RhdHVzIHdyaXRlLCBhbmQgZmx1
c2ggaW4gZGV2aWNlIHdyaXRlcywKPiAgICAgICAgICAqIGluY2x1ZGluZyBNU2ktWCBpbnRlcnJ1
cHRzLCBpZiBhbnkuICovCj4gLSAgICAgICB2cF9sZWdhY3lfZ2V0X3N0YXR1cygmdnBfZGV2LT5s
ZGV2KTsKPiArICAgICAgIHdoaWxlICh2cF9sZWdhY3lfZ2V0X3N0YXR1cygmdnBfZGV2LT5sZGV2
KSkKPiArICAgICAgICAgICAgICAgbXNsZWVwKDEpOwo+ICAgICAgICAgLyogRmx1c2ggcGVuZGlu
ZyBWUS9jb25maWd1cmF0aW9uIGNhbGxiYWNrcy4gKi8KPiAgICAgICAgIHZwX3N5bmNocm9uaXpl
X3ZlY3RvcnModmRldik7Cj4gIH0KPiAtLQo+IDIuMjUuMQo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
