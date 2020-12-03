Return-Path: <SRS0=OlB3=FH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE270C63777
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 10:44:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B43208A9
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 10:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B43208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C99E9874E2;
	Thu,  3 Dec 2020 10:44:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7RSFMem4NhxW; Thu,  3 Dec 2020 10:44:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 50FA88728E;
	Thu,  3 Dec 2020 10:44:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31CAFC0FA8;
	Thu,  3 Dec 2020 10:44:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6679C0FA7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 10:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ADB4C879B4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 10:44:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ThReyIkubbnu
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 10:44:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1768787946
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 10:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606992266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7VeQja9swCsfB3PhqTDwyJ4bV4pwvq3wq0Enpf6L0I=;
 b=hmaIV1x0N4BzwFKJgoJT7lzBMYDM1nVVhKprDAhi5XNqpQ9CFboIi2tNu2PPDx3ouCW1eN
 3oTcvOw3+GFZmYdos8Y9olz/1dxbY+VZanHl4RX6MQEcupFuZ5ZBAJQGN9BOSJ3pz6294v
 pb6LqNIF7/QogMWnP/tGSb0b1c7XngU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-1zF6peAaNyuSGPwi7uKCbQ-1; Thu, 03 Dec 2020 05:44:22 -0500
X-MC-Unique: 1zF6peAaNyuSGPwi7uKCbQ-1
Received: by mail-wr1-f70.google.com with SMTP id x10so1115213wrs.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Dec 2020 02:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=v7VeQja9swCsfB3PhqTDwyJ4bV4pwvq3wq0Enpf6L0I=;
 b=jWyrb/CyjrzB3jl1Dkj0nwaOf45i9Tm/20N8VZNcJ5KbRu43DGdeHN9gtuucz/i22S
 QkCxSE1r9ZElE2v6yo3TsGlk3T8kwHKpZWZIWqPrn/cM7AXuxdPgnParneHzxu96gGPZ
 a8Yt6as2KDnWkWUnLKYBW9wZKRtrTTE13jezm7yoXzFuN5/625mBIfM+KcAFZ+ViSNav
 gDATiCgqjztUYoOu6wsKhQBRt9+3zjnfyX8xdcFH9MhdTPj1X/iMGsITnsHVfsZ/OC+p
 vzkueiz85arXIQqc5SGZpkYRqS7lixSCuC2Vaq49vTwUfGWCoNImShwEIjw5QgVvnwLD
 Vj2g==
X-Gm-Message-State: AOAM532Futy0uHhuYBoq3d1dPhDQ15sF1pIKkhPhetf/YLh1okT1rqhh
 yiKgU3qPXlq5/UaCDKoN196pkjSDO70/oP9KaLZgi6KsvMsqFWtgPgaiPqCtPOzAxMbkfKtRhV0
 54BIDvu9Lp5UoeyPedHNNjHa4F5WK/L5ATbMtfDh98g==
X-Received: by 2002:a1c:c902:: with SMTP id f2mr2644375wmb.130.1606992260987; 
 Thu, 03 Dec 2020 02:44:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgiZ+YA0a+3SUdB0hAWy+TIzjqKgOEcekO5gTV3mLa/6sgQvs6/WfonlWBQbEWZrnSzEd8SQ==
X-Received: by 2002:a1c:c902:: with SMTP id f2mr2644348wmb.130.1606992260670; 
 Thu, 03 Dec 2020 02:44:20 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id a144sm985141wmd.47.2020.12.03.02.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Dec 2020 02:44:19 -0800 (PST)
Date: Thu, 3 Dec 2020 05:44:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201203054330-mutt-send-email-mst@kernel.org>
References: <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
 <20201202041518-mutt-send-email-mst@kernel.org>
 <3e32ef6d-83c9-5866-30e5-f6eeacd5044d@redhat.com>
 <20201202165932-mutt-send-email-mst@kernel.org>
 <20201203064928.GA27404@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20201203064928.GA27404@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>,
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

T24gVGh1LCBEZWMgMDMsIDIwMjAgYXQgMDg6NDk6MjhBTSArMDIwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+IE9uIFdlZCwgRGVjIDAyLCAyMDIwIGF0IDA1OjAwOjIyUE0gLTA1MDAsIE1pY2hhZWwgUy4g
VHNpcmtpbiB3cm90ZToKPiA+IE9uIFdlZCwgRGVjIDAyLCAyMDIwIGF0IDA5OjQ4OjI1UE0gKzA4
MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IAo+ID4gPiBPbiAyMDIwLzEyLzIg5LiL5Y2INToy
MywgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+IE9uIFdlZCwgRGVjIDAyLCAyMDIw
IGF0IDA3OjU3OjE0QU0gKzAyMDAsIEVsaSBDb2hlbiB3cm90ZToKPiA+ID4gPiA+IE9uIFdlZCwg
RGVjIDAyLCAyMDIwIGF0IDEyOjE4OjM2UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+
ID4gPiA+IE9uIDIwMjAvMTIvMSDkuIvljYg1OjIzLCBDaW5keSBMdSB3cm90ZToKPiA+ID4gPiA+
ID4gPiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAxMTozMyBQTSBNaWNoYWVsIFMuIFRzaXJraW48
bXN0QHJlZGhhdC5jb20+ICB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgTm92IDMwLCAy
MDIwIGF0IDA2OjQxOjQ1UE0gKzA4MDAsIENpbmR5IEx1IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4g
PiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCA1OjMzIFBNIE1pY2hhZWwgUy4gVHNpcmtpbjxtc3RA
cmVkaGF0LmNvbT4gIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgTm92IDMwLCAy
MDIwIGF0IDExOjI3OjU5QU0gKzAyMDAsIEVsaSBDb2hlbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0IDA0OjAwOjUxQU0gLTA1MDAsIE1pY2hhZWwg
Uy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCBOb3YgMzAs
IDIwMjAgYXQgMDg6Mjc6NDZBTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IE9uIFN1biwgTm92IDI5LCAyMDIwIGF0IDAzOjA4OjIyUE0gLTA1MDAsIE1p
Y2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFN1
biwgTm92IDI5LCAyMDIwIGF0IDA4OjQzOjUxQU0gKzAyMDAsIEVsaSBDb2hlbiB3cm90ZToKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gV2Ugc2hvdWxkIG5vdCB0cnkgdG8gdXNlIHRoZSBW
RiBNQUMgYWRkcmVzcyBhcyB0aGF0IGlzIHVzZWQgYnkgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IHJlZ3VsYXIgKGUuZy4gbWx4NV9jb3JlKSBOSUMgaW1wbGVtZW50YXRpb24uIElu
c3RlYWQsIHVzZSBhIHJhbmRvbQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBnZW5lcmF0
ZWQgTUFDIGFkZHJlc3MuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBTdWdnZXN0ZWQgYnk6IENpbmR5IEx1PGx1bHVAcmVkaGF0LmNv
bT4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gRml4ZXM6IDFhODZiMzc3YWEyMSAoInZk
cGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuPGVsaWNA
bnZpZGlhLmNvbT4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEkgZGlkbid0IHJlYWxpc2Ug
aXQncyBwb3NzaWJsZSB0byB1c2UgVkYgaW4gdHdvIHdheXMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IHdpdGggYW5kIHdpdGhvdXQgdmRwYS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBV
c2luZyBhIFZGIHlvdSBjYW4gY3JlYXRlIHF1aXRlIGEgZmV3IHJlc291cmNlcywgZS5nLiBzZW5k
IHF1ZXVlcwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHJlY2lldmUgcXVldWVzLCB2aXJ0aW9f
bmV0IHF1ZXVlcyBldGMuIFNvIHlvdSBjYW4gcG9zc2libHkgY3JlYXRlCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gc2V2ZXJhbCBpbnN0YW5jZXMgb2YgdmRwYSBuZXQgZGV2aWNlcyBhbmQgbmlj
IG5ldCBkZXZpY2VzLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gQ291bGQgeW91IGluY2x1ZGUgYSBiaXQgbW9yZSBkZXNjcmlwdGlvbiBvbiB0
aGUgZmFpbHVyZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gbW9kZT8KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBXZWxsLCB1c2luZyB0aGUgTUFDIGFkZHJlc3Mgb2YgdGhlIG5pYyB2cG9y
dCBpcyB3cm9uZyBzaW5jZSB0aGF0IGlzIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE1B
QyBvZiB0aGUgcmVndWxhciBOSUMgaW1wbGVtZW50YXRpb24gb2YgbWx4NV9jb3JlLgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBSaWdodCBidXQgQVRNIGl0IGRvZXNuJ3QgY29leGlzdCB3aXRoIHZk
cGEgc28gd2hhdCdzIHRoZSBwcm9ibGVtPwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IFRoaXMgY2FsbCBpcyB3cm9uZzogIG1seDVfcXVlcnlfbmljX3Zwb3J0
X21hY19hZGRyZXNzKCkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gSXMgc3dpdGNoaW5nIHRvIGEgcmFuZG9tIG1hYyBmb3Igc3VjaCBhbiB1bnVzdWFs
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBjb25maWd1cmF0aW9uIHJlYWxseSBqdXN0aWZp
ZWQ/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU2luY2UgSSBjYW4ndCB1c2UgdGhlIE5JQydz
IE1BQyBhZGRyZXNzLCBJIGhhdmUgdHdvIG9wdGlvbnM6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gMS4gVG8gZ2V0IHRoZSBNQUMgYWRkcmVzcyBhcyB3YXMgY2hvc2VuIGJ5IHRoZSB1c2VyIGFk
bWluaXN0ZXJpbmcgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICBOSUMuIFRoaXMg
c2hvdWxkIGludm9rZSB0aGUgc2V0X2NvbmZpZyBjYWxsYmFjay4gVW5mb3J0dW5hdGVseSB0aGlz
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICBpcyBub3QgaW1wbGVtZW50ZWQgeWV0Lgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IDIuIFVz
ZSBhIHJhbmRvbSBNQUMgYWRkcmVzcy4gVGhpcyBpcyBPSyBzaW5jZSBpZiAoMSkgaXMgaW1wbGVt
ZW50ZWQgaXQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgIGNhbiBhbHdheXMgb3ZlcnJp
ZGUgdGhpcyByYW5kb20gY29uZmlndXJhdGlvbi4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEl0IGxvb2tzIGxpa2UgY2hhbmdpbmcgYSBNQUMg
Y291bGQgYnJlYWsgc29tZSBndWVzdHMsCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBjYW4g
aXQgbm90Pwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gTm8sIGl0IHdpbGwgbm90LiBUaGUgY3VycmVudCB2ZXJzaW9uIG9mIG1seDUgVkRQQSBk
b2VzIG5vdCBhbGxvdyByZWd1bGFyCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gTklDIGRyaXZl
ciBhbmQgVkRQQSB0byBjby1leGlzdC4gSSBoYXZlIHBhdGNoZXMgcmVhZHkgdGhhdCBlbmFibGUg
dGhhdAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGZyb20gc3RlZXJpbmcgcG9pbnQgb2Ygdmll
dy4gSSB3aWxsIHBvc3QgdGhlbSBoZXJlIG9uY2Ugb3RoZXIgcGF0Y2hlcyBvbgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IHdoaWNoIHRoZXkgZGVwZW5kIHdpbGwgYmUgbWVyZ2VkLgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGh0dHBzOi8vcGF0
Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9uZXRkZXYvcGF0Y2gvMjAyMDExMjAyMzAzMzkuNjUx
NjA5LTEyLXNhZWVkbUBudmlkaWEuY29tLwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBDb3VsZCB5
b3UgYmUgbW9yZSBleHBsaWNpdCBvbiB0aGUgZm9sbG93aW5nIHBvaW50czoKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gLSB3aGljaCBjb25maWd1cmF0aW9uIGlzIGJyb2tlbiBBVE0gKGFzIGluLCB0
d28gZGV2aWNlIGhhdmUgaWRlbnRpY2FsCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICBtYWNz
PyBhbnkgb3RoZXIgaXNzdWVzKT8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRoZSBvbmx5IHdyb25n
IHRoaW5nIGlzIHRoZSBjYWxsIHRvICBtbHg1X3F1ZXJ5X25pY192cG9ydF9tYWNfYWRkcmVzcygp
Lgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSXQncyBub3QgYnJlYWtpbmcgYW55dGhpbmcgeWV0IGlz
IHdyb25nLiBUaGUgcmFuZG9tIE1BQyBhZGRyZXNzIHNldHRpbmcKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IGlzIHJlcXVpcmVkIGZvciB0aGUgc3RlZXJpbmcgcGF0Y2hlcy4KPiA+ID4gPiA+ID4gPiA+
ID4gPiBPa2F5IHNvIEknbSBub3Qgc3VyZSB0aGUgRml4ZXMgdGFnIGF0IGxlYXN0IGlzIGFwcHJv
cHJpYXRlIGlmIGl0J3MgYQo+ID4gPiA+ID4gPiA+ID4gPiA+IGRlcGVuZGVuY3kgb2YgYSBuZXcg
ZmVhdHVyZS4KPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLSB3
aHkgd29uJ3QgZGV2aWNlIE1BQyBjaGFuZ2UgZnJvbSBndWVzdCBwb2ludCBvZiB2aWV3Pwo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEl0J3MgbGFjayBvZiBp
bXBsZW1lbnRhdGlvbiBpbiBxZW11IGFzIGZhciBhcyBJIGtub3cuCj4gPiA+ID4gPiA+ID4gPiA+
ID4gU29ycnkgbm90IHN1cmUgSSB1bmRlcnN0YW5kLiBXaGF0J3Mgbm90IGltcGxlbWVudGVkIGlu
IFFFTVU/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+IEhJIE1pY2hhZWws
IHRoZXJlIGFyZSBzb21lIGJ1ZyBpbiBxZW11IHRvIHNldF9jb25maWcsIHRoaXMgd2lsbCBmaXgg
aW4gZnV0dXJlLAo+ID4gPiA+ID4gPiA+ID4gPiBCdXQgdGhpcyBwYXRjaCBpcyBzdGlsbCBuZWVk
ZWQsIGJlY2F1c2Ugd2l0aG91dCB0aGlzIHBhdGNoIHRoZSBtbHgKPiA+ID4gPiA+ID4gPiA+ID4g
ZHJpdmVyIHdpbGwgZ2l2ZSBhbiAwIG1hYyBhZGRyZXNzIHRvIHFlbXUKPiA+ID4gPiA+ID4gPiA+
ID4gYW5kIHFlbXUgd2lsbCBvdmVyd3JpdGUgdGhlIGRlZmF1bHQgbWFjIGFkZHJlc3MuICBUaGlz
IHdpbGwgY2F1c2UgdHJhZmZpYyBkb3duLgo+ID4gPiA+ID4gPiA+ID4gSG1tIHRoZSBwYXRjaCBk
ZXNjcmlwdGlvbiBzYXlzIFZGIG1hYyBhZGRyZXNzLCBub3QgMCBhZGRyZXNzLiBDb25mdXNlZC4K
PiA+ID4gPiA+ID4gPiA+IElmIHRoZXJlJ3Mgbm8gbWFjIHdlIGNhbiBjbGVhciBWSVJUSU9fTkVU
X0ZfTUFDIGFuZCBoYXZlIGd1ZXN0Cj4gPiA+ID4gPiA+ID4gPiB1c2UgYSByYW5kb20gdmFsdWUg
Li4uCj4gPiA+ID4gPiA+IEknbSBub3Qgc3VyZSB0aGlzIGNhbiB3b3JrIGZvciBhbGwgdHlwZXMg
b2YgdkRQQSAoZS5nIGl0IGNvdWxkIG5vdCBiZSBhCj4gPiA+ID4gPiA+IGxlYXJuaW5nIGJyaWRn
ZSBpbiB0aGUgc3d0aWNoKS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+
IGhpIE1pY2hhZWzvvIwKPiA+ID4gPiA+ID4gPiBJIGhhdmUgdHJpZWQgYXMgeW91ciBzdWdnZXN0
aW9uLCBzZWVtcyBldmVuIHJlbW92ZSB0aGUKPiA+ID4gPiA+ID4gPiBWSVJUSU9fTkVUX0ZfTUFD
IHRoZSBxZW11IHdpbGwgc3RpbGwgY2FsbCBnZXRfY2luZmlnIGFuZCBvdmVyd3JpdGUgdGhlCj4g
PiA+ID4gPiA+ID4gZGVmYXVsdCBhZGRyZXNzIGluICBWTSwKPiA+ID4gPiA+ID4gVGhpcyBsb29r
cyBhIGJ1ZyBpbiBxZW11LCBpbiBndWVzdCBkcml2ZXIgd2UgaGFkOgo+ID4gPiA+ID4gPiAKPiA+
ID4gPiA+ID4gIMKgwqDCoCAvKiBDb25maWd1cmF0aW9uIG1heSBzcGVjaWZ5IHdoYXQgTUFDIHRv
IHVzZS7CoCBPdGhlcndpc2UgcmFuZG9tLiAqLwo+ID4gPiA+ID4gPiAgwqDCoMKgIGlmICh2aXJ0
aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX01BQykpCj4gPiA+ID4gPiA+ICDCoMKg
wqAgwqDCoMKgIHZpcnRpb19jcmVhZF9ieXRlcyh2ZGV2LAo+ID4gPiA+ID4gPiAgwqDCoMKgIMKg
wqDCoCDCoMKgwqAgwqDCoMKgIMKgwqAgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmln
LCBtYWMpLAo+ID4gPiA+ID4gPiAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqAgZGV2
LT5kZXZfYWRkciwgZGV2LT5hZGRyX2xlbik7Cj4gPiA+ID4gPiA+ICDCoMKgwqAgZWxzZQo+ID4g
PiA+ID4gPiAgwqDCoMKgIMKgwqDCoCBldGhfaHdfYWRkcl9yYW5kb20oZGV2KTsKPiA+ID4gPiA+
ID4gCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IHRoaXMgcHJvY2VzcyBpcyBsaWtlCj4gPiA+
ID4gPiA+ID4gdmRwYSBfaW5pdCAtLT5xZW11IGNhbGwgZ2V0X2NvbmZpZyAtPm1seCBkcml2ZXIg
d2lsbCBnaXZlICBhbiBtYWMKPiA+ID4gPiA+ID4gPiBhZGRyZXNzIHdpdGggYWxsIDAtLT4KPiA+
ID4gPiA+ID4gPiBxZW11IHdpbGwgbm90IGNoZWNrIHRoaXMgbWFjIGFkZHJlc3MgYW5kIHVzZSBp
dCAtLT4gb3ZlcndyaXRlIHRoZSBtYWMKPiA+ID4gPiA+ID4gPiBhZGRyZXNzIGluIHFlbXUKPiA+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBTbyBmb3IgbXkgdW5kZXJzdGFuZGluZyB0aGVyZSBh
cmUgc2V2ZXJhbCBtZXRob2QgdG8gZml4IHRoaXMgcHJvYmxlbQo+ID4gPiA+ID4gPiA+IAo+ID4g
PiA+ID4gPiA+IDEsIHFlbXUgY2hlY2sgdGhlIG1hYyBhZGRyZXNzLCBpZiB0aGUgbWFjIGFkZHJl
c3MgaXMgYWxsIDAsIHFlbXUgd2lsbAo+ID4gPiA+ID4gPiA+IGlnbm9yZSBpdCBhbmQgc2V0IHRo
ZSByYW5kb20gbWFjIGFkZHJlc3MgdG8gbWx4IGRyaXZlci4KPiA+ID4gPiA+ID4gU28gbXkgdW5k
ZXJzdGFuZGluZyBpcyB0aGF0LCBpZiBtYWMgYWRkcmVzcyBpcyBhbGwgMCwgdkRQQSBwYXJlbnQg
c2hvdWxkIG5vdAo+ID4gPiA+ID4gPiBhZHZlcnRpc2UgVklSVElPX05FVF9GX01BQy4gQW5kIHFl
bXUgc2hvdWxkIGVtdWxhdGUgdGhpcyBmZWF0dXJlIGFzIHlvdSBkaWQ6Cj4gPiA+ID4gPiBUaGlu
a2luZyBpdCBvdmVyLCBhdCBsZWFzdCBpbiBtbHg1LCBJIHNob3VsZCBhbHdheXMgYWR2ZXJ0aXNl
Cj4gPiA+ID4gPiBWSVJUSU9fTkVUX0ZfTUFDIGFuZCBzZXQgYSBub24gemVybyBNQUMgdmFsdWUu
IFRoZSBzb3VyY2Ugb2YgdGhlIE1BQyBjYW4KPiA+ID4gPiA+IGJlIGVpdGhlciByYW5kb21seSBn
ZW5lcmF0ZWQgdmFsdWUgYnkgbWx4NV92ZHBhIG9yIGJ5IGEgbWFuYWdlbWVudCB0b29sLgo+ID4g
PiA+ID4gVGhpcyBpcyBpbXBvcnRhbnQgYmVjYXVhc2Ugd2Ugc2hvdWxkIG5vdCBsZXQgdGhlIFZN
IG1vZGlmeSB0aGUgTUFDLiBJZgo+ID4gPiA+ID4gd2UgZG8gaXQgY2FuIHNldCBhIE1BQyB2YWx1
ZSBpZGVudGljYWwgdG8gdGhlIG1seDUgTklDIGRyaXZlciBhbmQgY2FuCj4gPiA+ID4gPiBraWRu
YXAgdHJhZmZpYyB0aGF0IHdhcyBub3QgZGVzdGluZWQgdG8gaXQuCj4gPiA+ID4gPiAKPiA+ID4g
PiA+IEluIGFkZGl0aW9uLCB3aGVuIFZJUlRJT19ORVRfRl9NQUMgaXMgcHVibGlzaGVkLCBhdHRl
bXB0cyB0byBjaGFuZ2UgdGhlCj4gPiA+ID4gPiBNQUMgYWRkcmVzcyBmcm9tIHRoZSBWTSBzaG91
bGQgcmVzdWx0IGluIGVycm9yLgo+ID4gPiA+IFRoYXQgaXMgbm90IHdoYXQgdGhlIHNwZWMgc2F5
cyB0aG91Z2guCj4gPiA+ID4gVklSVElPX05FVF9GX01BQyBvbmx5IHNheXMgd2hldGhlciBtYWMg
aXMgdmFsaWQgaW4gdGhlIGNvbmZpZyBzcGFjZS4KPiA+ID4gPiBXaGV0aGVyIGd1ZXN0IGNhbiBj
b250cm9sIHRoYXQgZGVwZW5kcyBvbiBWSVJUSU9fTkVUX0ZfQ1RSTF9NQUNfQUREUjoKPiA+ID4g
PiAKPiA+ID4gPiAJVGhlIFZJUlRJT19ORVRfQ1RSTF9NQUNfQUREUl9TRVQgY29tbWFuZCBpcyB1
c2VkIHRvIHNldCB0aGUgZGVmYXVsdCBNQUMgYWRkcmVzcyB3aGljaCByeAo+ID4gPiA+IAlmaWx0
ZXJpbmcgYWNjZXB0cyAoYW5kIGlmIFZJUlRJT19ORVRfRl9NQUNfQUREUiBoYXMgYmVlbiBuZWdv
dGlhdGVkLCB0aGlzIHdpbGwgYmUgcmVmbGVjdGVkIGluIG1hYyBpbgo+ID4gPiA+IAljb25maWcg
c3BhY2UpLgo+ID4gPiA+IAlUaGUgY29tbWFuZC1zcGVjaWZpYy1kYXRhIGZvciBWSVJUSU9fTkVU
X0NUUkxfTUFDX0FERFJfU0VUIGlzIHRoZSA2LWJ5dGUgTUFDIGFkZHJlc3MuCj4gPiA+IAo+ID4g
PiAKPiA+ID4gQ29uc2lkZXIgVklSVElPX05FVF9DVFJMX01BQ19BRERSX1NFVCBpcyBub3Qgc3Vw
cG9ydGVkIG5vdy4gV2hhdCBFbGkKPiA+ID4gcHJvcG9zZWQgaGVyZSBzaG91bGQgd29yaz8KPiA+
ID4gCj4gPiA+IFRoYW5rcwo+ID4gPiAKPiA+IAo+ID4gV2UgY2FuIGhhdmUgbWFuYWdlbWVudCBz
ZXQgYSBNQUMgYWRkcmVzcy4gUmFuZG9taXppbmcgaXQgaW4ga2VybmVsCj4gPiBkb2VzIG5vdCBz
ZWVtIGxpa2UgYSByZWFzb25hYmxlIHBvbGljeSB0byBtZSAuLi4KPiA+IAo+IAo+IFRoaXMgbWFu
YW5nZW1lbnQgc2hvdWxkIGJlIHRoZSBWRFBBIHRvb2wgdGhhdCBQYXJhdiBpcyBwdXNoaW5nLiBX
ZSBjYW4KPiB1c2UgaXQgdG8gc2V0IGEgTUFDIGNob3NlbiBieSB0aGUgdXNlci4gVGhlIG1seDUg
dmRwYSBkcml2ZXIgY2FuIHRoZW4KPiB1c2UgdGhhdCBNQUMgaW5zdGVhZCBvZiByYW5kb21pemlu
ZyBhIHZhbHVlLiBJZiBubyBhZG1pbiB2YWx1ZSBpcyBnaXZlbgo+IHdlIGNhbiB1c2UgYSByYW5k
b20gTUFDLgoKSUlVQyBpbiB0aGlzIG1vZGVsIGRldmljZXMgYXJlIGNyZWF0ZWQgYnkgdGhpcyB0
b29sLCByaWdodD8KV2h5IG5vdCByZXF1aXJlIHRoZSBNQUMgd2hlbiBkZXZpY2UgaXMgY3JlYXRl
ZD8KCj4gPiAKPiA+ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiAKPiA+IAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
