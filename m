Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A60C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 11:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39C84826B4;
	Thu, 28 Apr 2022 11:04:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XbUn-vMCpKYa; Thu, 28 Apr 2022 11:04:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B4005826EA;
	Thu, 28 Apr 2022 11:04:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83E39C0032;
	Thu, 28 Apr 2022 11:04:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A722FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E54041B3F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:04:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0irAlUy8KCM5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:04:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8811641A21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651143842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pu2kafg8s3Dpw8thSMePtydoo2e/yB3JPGTXgTvagKs=;
 b=ikTLsd8rlIYyEi7Dobf7a/aneRDbXoz+scjlpx7irEmAZpoxAEqCx34bFN7JHCW7ROWMxU
 PS2w2fxloOjoMXXxXM1ZgcKMz9EHLYpuf3XU/cgFR9ZuJhxbgxc7MkkyGmfOOVI8c06JEH
 umojO14chkL3iFLXa9kE8hozCuJlz3U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-pYH9jGFTPDCGYssN2zrVHg-1; Thu, 28 Apr 2022 07:03:59 -0400
X-MC-Unique: pYH9jGFTPDCGYssN2zrVHg-1
Received: by mail-wm1-f71.google.com with SMTP id
 d13-20020a05600c3acd00b0038ff865c043so4232350wms.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 04:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=pu2kafg8s3Dpw8thSMePtydoo2e/yB3JPGTXgTvagKs=;
 b=ZqF/o670Kff7jLTRMn3ssXTK+vasLL3xSEB7qP09vvr+JBwGZuqaaWPOpYanJq1uaF
 VQwt+46SRORiPL9LfNxVMK/NyZoPKsnuQETnOdkqZ7gaoxWxheLU7H1aZNLBRj/rI0+o
 Va+3aeEs8SYw1818oy5Twm4aA+P2mPnpHj09Frzpn3T+7MEzjHzTn6+azOx7R1uBCuuF
 O2Qlq1xsYV3a6MtYKtmDNLxhirTiOZeWqgBDSieZKvmyDiREqoJ8zLw7MhVDLO7Pl4oT
 Y0QZGmL1Ar6Cf1BcQLRmIlD6/HFhR7uU13fx6s4D7n4VoQYenI4uBSlrftUaLDDYLl8V
 z9WA==
X-Gm-Message-State: AOAM5307r0KFs+ozM/RuETgNwXALD2gMczT7k9AgnhGuDR3l9hnbYkme
 PRuUqsMD81OYjdMhqMNAyobZAPBVTc0+xxPuONxNn9pw5AnxISmrcm9Yh1MrI2aa17wPNVbf6KK
 6oikVRnYJzv1kQ7oYwibwI5VFc4ocZ1p2QzezTup2zQ==
X-Received: by 2002:a5d:6388:0:b0:20a:ed44:fd38 with SMTP id
 p8-20020a5d6388000000b0020aed44fd38mr7212098wru.153.1651143837710; 
 Thu, 28 Apr 2022 04:03:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnastE0TZ6WITcJ/eq00hMdksgzT7uwfrmU0vGkPpJVNtnSjzZ7TyLkFOB0HxZizgmJ6RGWg==
X-Received: by 2002:a5d:6388:0:b0:20a:ed44:fd38 with SMTP id
 p8-20020a5d6388000000b0020aed44fd38mr7212079wru.153.1651143837425; 
 Thu, 28 Apr 2022 04:03:57 -0700 (PDT)
Received: from redhat.com ([2.53.18.16]) by smtp.gmail.com with ESMTPSA id
 bg20-20020a05600c3c9400b0037fa5c422c8sm4205877wmb.48.2022.04.28.04.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 04:03:55 -0700 (PDT)
Date: Thu, 28 Apr 2022 07:03:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com>
Subject: Re: [PATCH] virtio-pci: Remove wrong address verification in
 vp_del_vqs()
Message-ID: <20220428070345-mutt-send-email-mst@kernel.org>
References: <20220415023002.49805-1-muriloo@linux.ibm.com>
 <e8620e70-16bb-639c-9446-68dcd199253f@linux.ibm.com>
 <A5CD1C91-F5D0-4109-9894-824184362B5C@redhat.com>
 <B954A683-EE43-4469-B57A-EB8C6B671BEC@redhat.com>
 <2F2EFFE9-5174-49A8-A71F-EE134D387E07@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2F2EFFE9-5174-49A8-A71F-EE134D387E07@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mopsfelder@gmail.com, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Christophe de Dinechin <dinechin@redhat.com>
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

T24gVGh1LCBBcHIgMjgsIDIwMjIgYXQgMTE6NTU6MzFBTSArMDIwMCwgQ2hyaXN0b3BoZSBNYXJp
ZSBGcmFuY29pcyBEdXBvbnQgZGUgRGluZWNoaW4gd3JvdGU6Cj4gCj4gCj4gPiBPbiAyOCBBcHIg
MjAyMiwgYXQgMTE6NTEsIENocmlzdG9waGUgTWFyaWUgRnJhbmNvaXMgRHVwb250IGRlIERpbmVj
aGluIDxjZHVwb250ZEByZWRoYXQuY29tPiB3cm90ZToKPiA+IAo+ID4gCj4gPiAKPiA+PiBPbiAy
OCBBcHIgMjAyMiwgYXQgMTE6NDYsIENocmlzdG9waGUgTWFyaWUgRnJhbmNvaXMgRHVwb250IGRl
IERpbmVjaGluIDxjZHVwb250ZEByZWRoYXQuY29tPiB3cm90ZToKPiA+PiAKPiA+PiAKPiA+PiAK
PiA+Pj4gT24gMTUgQXByIDIwMjIsIGF0IDA1OjUxLCBNdXJpbG8gT3BzZmVsZGVyIEFyYcO6am8g
PG11cmlsb29AbGludXguaWJtLmNvbT4gd3JvdGU6Cj4gPj4+IAo+ID4+PiBPbiA0LzE0LzIyIDIz
OjMwLCBNdXJpbG8gT3BzZmVsZGVyIEFyYXVqbyB3cm90ZToKPiA+Pj4+IEdDQyAxMiBlbmhhbmNl
ZCAtV2FkZHJlc3Mgd2hlbiBjb21wYXJpbmcgYXJyYXkgYWRkcmVzcyB0byBudWxsIFswXSwKPiA+
Pj4+IHdoaWNoIHdhcm5zOgo+ID4+Pj4gZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24u
YzogSW4gZnVuY3Rpb24g4oCYdnBfZGVsX3Zxc+KAmToKPiA+Pj4+IGRyaXZlcnMvdmlydGlvL3Zp
cnRpb19wY2lfY29tbW9uLmM6MjU3OjI5OiB3YXJuaW5nOiB0aGUgY29tcGFyaXNvbiB3aWxsIGFs
d2F5cyBldmFsdWF0ZSBhcyDigJh0cnVl4oCZIGZvciB0aGUgcG9pbnRlciBvcGVyYW5kIGluIOKA
mHZwX2Rldi0+bXNpeF9hZmZpbml0eV9tYXNrcyArIChzaXpldHlwZSkoKGxvbmcgdW5zaWduZWQg
aW50KWkgKiAyNTYp4oCZIG11c3Qgbm90IGJlIE5VTEwgWy1XYWRkcmVzc10KPiA+Pj4+IDI1NyB8
IGlmICh2cF9kZXYtPm1zaXhfYWZmaW5pdHlfbWFza3NbaV0pCj4gPj4+PiB8IF5+fn5+fgo+ID4+
Pj4gSW4gZmFjdCwgdGhlIHZlcmlmaWNhdGlvbiBpcyBjb21wYXJpbmcgdGhlIHJlc3VsdCBvZiBh
IHBvaW50ZXIKPiA+Pj4+IGFyaXRobWV0aWMsIHRoZSBhZGRyZXNzICJtc2l4X2FmZmluaXR5X21h
c2tzICsgaSIsIHdoaWNoIHdpbGwgYWx3YXlzCj4gPj4+PiBldmFsdWF0ZSB0byB0cnVlLgo+ID4+
Pj4gVW5kZXIgdGhlIGhvb2QsIGZyZWVfY3B1bWFza192YXIoKSBjYWxscyBrZnJlZSgpLCB3aGlj
aCBpcyBzYWZlIHRvIHBhc3MKPiA+Pj4+IE5VTEwsIG5vdCByZXF1aXJpbmcgbm9uLW51bGwgdmVy
aWZpY2F0aW9uLiBTbyByZW1vdmUgdGhlIHZlcmlmaWNhdGlvbgo+ID4+Pj4gdG8gbWFrZSBjb21w
aWxlciBoYXBweSAoaGFwcHkgY29tcGlsZXIsIGhhcHB5IGxpZmUpLgo+ID4+Pj4gWzBdIGh0dHBz
Oi8vZ2NjLmdudS5vcmcvYnVnemlsbGEvc2hvd19idWcuY2dpP2lkPTEwMjEwMwo+ID4+Pj4gU2ln
bmVkLW9mZi1ieTogTXVyaWxvIE9wc2ZlbGRlciBBcmF1am8gPG11cmlsb29AbGludXguaWJtLmNv
bT4KPiA+Pj4+IC0tLQo+ID4+Pj4gZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYyB8
IDMgKy0tCj4gPj4+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25z
KC0pCj4gPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24u
YyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiA+Pj4+IGluZGV4IGQ3MjRm
Njc2NjA4Yi4uNTA0NmVmY2ZmYjRjIDEwMDY0NAo+ID4+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9jb21tb24uYwo+ID4+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9jb21tb24uYwo+ID4+Pj4gQEAgLTI1NCw4ICsyNTQsNyBAQCB2b2lkIHZwX2RlbF92cXMoc3Ry
dWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPj4+PiAJaWYgKHZwX2Rldi0+bXNpeF9hZmZpbml0
eV9tYXNrcykgewo+ID4+Pj4gCQlmb3IgKGkgPSAwOyBpIDwgdnBfZGV2LT5tc2l4X3ZlY3RvcnM7
IGkrKykKPiA+Pj4+IC0JCQlpZiAodnBfZGV2LT5tc2l4X2FmZmluaXR5X21hc2tzW2ldKQo+ID4+
Pj4gLQkJCQlmcmVlX2NwdW1hc2tfdmFyKHZwX2Rldi0+bXNpeF9hZmZpbml0eV9tYXNrc1tpXSk7
Cj4gPj4+PiArCQkJZnJlZV9jcHVtYXNrX3Zhcih2cF9kZXYtPm1zaXhfYWZmaW5pdHlfbWFza3Nb
aV0pOwo+ID4+Pj4gCX0KPiA+Pj4+IAlpZiAodnBfZGV2LT5tc2l4X2VuYWJsZWQpIHsKPiA+Pj4g
Cj4gPj4+IEFmdGVyIEkgc2VudCB0aGlzIG1lc3NhZ2UsIEkgcmVhbGl6ZWQgdGhhdCBDaHJpc3Rv
cGhlIChjb3BpZWQgaGVyZSkKPiA+Pj4gaGFkIGFscmVhZHkgcHJvcG9zZWQgYSBmaXg6Cj4gPj4+
IAo+ID4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjIwNDE0MTUwODU1LjI0MDcx
MzctNC1kaW5lY2hpbkByZWRoYXQuY29tLwo+ID4+PiAKPiA+Pj4gQ2hyaXN0b3BoZSwKPiA+Pj4g
Cj4gPj4+IFNpbmNlIGZyZWVfY3B1bWFza192YXIoKSBjYWxscyBrZnJlZSgpIGFuZCBrZnJlZSgp
IGlzIG51bGwtc2FmZSwKPiA+Pj4gY2FuIHdlIGp1c3QgZHJvcCB0aGlzIG51bGwgdmVyaWZpY2F0
aW9uIGFuZCBjYWxsIGZyZWVfY3B1bWFza192YXIoKSByaWdodCBhd2F5Pwo+ID4+IAo+ID4+IEFw
b2xvZ2llcyBmb3IgdGhlIGRlbGF5IGluIHJlc3BvbmRpbmcsIGJyb2tlbiBsYXB0b3DigKYKPiA+
PiAKPiA+PiBJbiB0aGUgY2FzZSB3aGVyZSBDT05GSUdfQ1BVTUFTS19PRkZTVEFDSyBpcyBub3Qg
ZGVmaW5lZCwgd2UgaGF2ZToKPiA+PiAKPiA+PiAJdHlwZWRlZiBzdHJ1Y3QgY3B1bWFzayBjcHVt
YXNrX3Zhcl90WzFdOwo+ID4+IAo+ID4+IFNvIHRoYXQgdnBfZGV2LT5tc2l4X2FmZmluaXR5X21h
c2tzW2ldIGlzIHN0YXRpY2FsbHkgbm90IG51bGwgKHRoYXTigJlzIHRoZSB3YXJuaW5nKQo+ID4+
IGJ1dCBhbHNvIGEgc3RhdGljIHBvaW50ZXIsIHNvIG5vdCBrZnJlZS1zYWZlIElNTy4KPiA+IAo+
ID4g4oCmIHdoaWNoIGFsc28gcmVuZGVycyBteSBvd24gcGF0Y2ggaW52YWxpZCA6LS8KPiA+IAo+
ID4gQ29tcGlsZXIgd2FybmluZ3MgYXJlIGdvb2QuIENsZWFybHkgbm90IHN1ZmZpY2llbnQuCj4g
Cj4gQWgsIEkganVzdCBub3RpY2VkIHRoYXQgZnJlZV9jcHVtYXNrX3ZhciBpcyBhIG5vb3AgaW4g
dGhhdCBjYXNlLgo+IAo+IFNvIHllcywgeW91ciBmaXggaXMgYmV0dGVyIDotKQoKQUNLIHRoZW4/
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
