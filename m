Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE5CE7C4E4
	for <virtualization@archiver.kernel.org>; Wed,  4 Oct 2023 16:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8222860ACC;
	Wed,  4 Oct 2023 16:27:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8222860ACC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bhLa11pN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RDhXmCoFS9VS; Wed,  4 Oct 2023 16:27:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EFEA160634;
	Wed,  4 Oct 2023 16:27:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFEA160634
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7E5AC0039;
	Wed,  4 Oct 2023 16:27:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62563C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Oct 2023 16:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2DE0682F13
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Oct 2023 16:27:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2DE0682F13
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bhLa11pN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Ck0BCq6KMvu
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Oct 2023 16:27:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4905E82EB4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Oct 2023 16:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4905E82EB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696436864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HeOIY+TMASmn87xWV8+r7N8mCnLxXs+pOXJs1mPVrBE=;
 b=bhLa11pNCYZxn8lWK9a2vAfRFNHkyNy4EDfOfQ8Cpxrhh0pf9zCHXsvQ/xhmlciCuauWw1
 jOvDReGNZmGvd9N1aQkhibjkjeRQK9YWkvrQVspkBt6pUfvR6sDiBXys7KdelBdEGaeOXw
 u78SBESWGd5jtgiRyvpQCsVDkgxQyl8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Hl2WJitFPCiGvDudIRtuCg-1; Wed, 04 Oct 2023 12:27:41 -0400
X-MC-Unique: Hl2WJitFPCiGvDudIRtuCg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3172a94b274so35939f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Oct 2023 09:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696436860; x=1697041660;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HeOIY+TMASmn87xWV8+r7N8mCnLxXs+pOXJs1mPVrBE=;
 b=bEyW/CT0BoxNnJRo6KH532kWrlKjRcLkzjwZ0y3GvQxXTPAXcDOeCOnycVmG50rmGQ
 2Wj7McgJ3OJJK+W4oJ8sC6Kzj+Vls+CL7RTDoJkt/NlvrEMVTND1D8Mh2D1+xEri7CrH
 AodRNbghX3ub/9q7ACqb1PNdHN6mceSzbNVOPHM2QP+kpWfiA4Rm+qPPIzavCPHv4SfH
 KIqMja+GH0L/j977BQaCt7eZo4+Wmc0LhGBQ/kssuV8ASoneK150TDW10i2EzyDix7Da
 gGsVkZlYgVQV6cYm7A4EDGDRkwYjVG+My3tN1fE4rgOfRrxDd2tny9IPkUunXKqHWkQC
 3rwQ==
X-Gm-Message-State: AOJu0YwRn8TYAW0Apf8/2M2BAxZc2AoboAGgg+zeH9lcS1EJax591gb6
 eKik8FyJEEZVH7XFAaCJJ+gUbQ50xL1qfZHYCSQmUCAY8Hbjp84WwleRzbGGi0EtNvGYA9MZ9OW
 ihmLelpZPyWG8Qu2C1jMz1EmodKyxWT3LLhFqBCnXSg==
X-Received: by 2002:adf:f08f:0:b0:318:f7a:e3c8 with SMTP id
 n15-20020adff08f000000b003180f7ae3c8mr2966666wro.57.1696436860480; 
 Wed, 04 Oct 2023 09:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrXRDIEuP3VkHPBdR8hK4Narzkji4gpOpXS4wQ4PXY81B0mBGZkcbuxvanEiTrfGdMm7v67A==
X-Received: by 2002:adf:f08f:0:b0:318:f7a:e3c8 with SMTP id
 n15-20020adff08f000000b003180f7ae3c8mr2966646wro.57.1696436860215; 
 Wed, 04 Oct 2023 09:27:40 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a5d4cc6000000b00325c7295450sm4385094wrt.3.2023.10.04.09.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:27:39 -0700 (PDT)
Date: Wed, 4 Oct 2023 12:27:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
Message-ID: <20231004122716-mutt-send-email-mst@kernel.org>
References: <20230703142514.363256-1-eperezma@redhat.com>
 <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com>
 <20230704061356-mutt-send-email-mst@kernel.org>
 <CAJaqyWf7DzJMEUT0NcPeDLQyPkthEJZydnSSPztoCxF6PWEu1w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWf7DzJMEUT0NcPeDLQyPkthEJZydnSSPztoCxF6PWEu1w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, leiyang@redhat.com
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

T24gV2VkLCBPY3QgMDQsIDIwMjMgYXQgMDI6NTY6NTNQTSArMDIwMCwgRXVnZW5pbyBQZXJleiBN
YXJ0aW4gd3JvdGU6Cj4gT24gVHVlLCBKdWwgNCwgMjAyMyBhdCAxMjoxNuKAr1BNIE1pY2hhZWwg
Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwgSnVsIDAz
LCAyMDIzIGF0IDA1OjI2OjAyUE0gLTA3MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gPiA+Cj4gPiA+
Cj4gPiA+IE9uIDcvMy8yMDIzIDg6NDYgQU0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+
ID4gPiBPbiBNb24sIEp1bCAwMywgMjAyMyBhdCAwNDoyNToxNFBNICswMjAwLCBFdWdlbmlvIFDD
qXJleiB3cm90ZToKPiA+ID4gPiA+IE9mZmVyIHRoaXMgYmFja2VuZCBmZWF0dXJlIGFzIG1seDUg
aXMgY29tcGF0aWJsZSB3aXRoIGl0LiBJdCBhbGxvd3MgaXQKPiA+ID4gPiA+IHRvIGRvIGxpdmUg
bWlncmF0aW9uIHdpdGggQ1ZRLCBkeW5hbWljYWxseSBzd2l0Y2hpbmcgYmV0d2VlbiBwYXNzdGhy
b3VnaAo+ID4gPiA+ID4gYW5kIHNoYWRvdyB2aXJ0cXVldWUuCj4gPiA+ID4gPgo+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gPiA+
ID4gU2FtZSBjb21tZW50Lgo+ID4gPiB0byB3aGljaD8KPiA+ID4KPiA+ID4gLVNpd2VpCj4gPgo+
ID4gVkhPU1RfQkFDS0VORF9GX0VOQUJMRV9BRlRFUl9EUklWRVJfT0sgaXMgdG9vIG5hcnJvdyBh
IHVzZS1jYXNlIHRvIGNvbW1pdCB0byBpdAo+ID4gYXMgYSBrZXJuZWwvdXNlcnNwYWNlIEFCSTog
d2hhdCBpZiBvbmUgd2FudHMgdG8gc3RhcnQgcmluZ3MgaW4gc29tZQo+ID4gb3RoZXIgc3BlY2lm
aWMgb3JkZXI/Cj4gPiBBcyB3YXMgZGlzY3Vzc2VkIG9uIGxpc3QsIGEgYmV0dGVyIHByb21pc2Ug
aXMgbm90IHRvIGFjY2VzcyByaW5nCj4gPiB1bnRpbCB0aGUgMXN0IGtpY2suIHZkcGEgY2FuIHRo
ZW4gZG8gYSBraWNrIHdoZW4gaXQgd2FudHMKPiA+IHRoZSBkZXZpY2UgdG8gc3RhcnQgYWNjZXNz
aW5nIHJpbmdzLgo+ID4KPiAKPiBGcmllbmRseSBwaW5nIGFib3V0IHRoaXMgc2VyaWVzLAo+IAo+
IE5vdyB0aGF0IFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVSX09LIGhhcyBiZWVu
IG1lcmdlZCBmb3IKPiB2ZHBhX3NpbSwgZG9lcyBpdCBtYWtlIHNlbnNlIGZvciBtbHggdG9vPwo+
IAo+IFRoYW5rcyEKCkZvciBzdXJlLiBJIHdhcyBqdXN0IGJ1c3kgd2l0aCBhIHFlbXUgcHVsbCwg
d2lsbCBoYW5kbGUgdGhpcyBuZXh0LgoKPiA+ID4gPgo+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiAg
IGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDcgKysrKysrKwo+ID4gPiA+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCj4gPiA+ID4gPgo+ID4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4gaW5kZXggOTEzOGVmMmZiMmM4Li41ZjMw
OWExNmI5ZGMgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMKPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+ID4gPiA+ID4gQEAgLTcsNiArNyw3IEBACj4gPiA+ID4gPiAgICNpbmNsdWRlIDx1YXBpL2xp
bnV4L3ZpcnRpb19uZXQuaD4KPiA+ID4gPiA+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlv
X2lkcy5oPgo+ID4gPiA+ID4gICAjaW5jbHVkZSA8dWFwaS9saW51eC92ZHBhLmg+Cj4gPiA+ID4g
PiArI2luY2x1ZGUgPHVhcGkvbGludXgvdmhvc3RfdHlwZXMuaD4KPiA+ID4gPiA+ICAgI2luY2x1
ZGUgPGxpbnV4L3ZpcnRpb19jb25maWcuaD4KPiA+ID4gPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2F1
eGlsaWFyeV9idXMuaD4KPiA+ID4gPiA+ICAgI2luY2x1ZGUgPGxpbnV4L21seDUvY3EuaD4KPiA+
ID4gPiA+IEBAIC0yNDk5LDYgKzI1MDAsMTEgQEAgc3RhdGljIHZvaWQgdW5yZWdpc3Rlcl9saW5r
X25vdGlmaWVyKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgZmx1c2hfd29ya3F1ZXVlKG5kZXYtPm12ZGV2LndxKTsKPiA+ID4gPiA+ICAgfQo+
ID4gPiA+ID4gK3N0YXRpYyB1NjQgbWx4NV92ZHBhX2dldF9iYWNrZW5kX2ZlYXR1cmVzKGNvbnN0
IHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiA+ID4gPiA+ICt7Cj4gPiA+ID4gPiArIHJldHVy
biBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVSX09LKTsKPiA+ID4g
PiA+ICt9Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiAgIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3NldF9k
cml2ZXJfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpCj4g
PiA+ID4gPiAgIHsKPiA+ID4gPiA+ICAgICAgICAgICBzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZk
ZXYgPSB0b19tdmRldih2ZGV2KTsKPiA+ID4gPiA+IEBAIC0zMTQwLDYgKzMxNDYsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyBtbHg1X3ZkcGFfb3BzID0gewo+ID4gPiA+
ID4gICAgICAgICAgIC5nZXRfdnFfYWxpZ24gPSBtbHg1X3ZkcGFfZ2V0X3ZxX2FsaWduLAo+ID4g
PiA+ID4gICAgICAgICAgIC5nZXRfdnFfZ3JvdXAgPSBtbHg1X3ZkcGFfZ2V0X3ZxX2dyb3VwLAo+
ID4gPiA+ID4gICAgICAgICAgIC5nZXRfZGV2aWNlX2ZlYXR1cmVzID0gbWx4NV92ZHBhX2dldF9k
ZXZpY2VfZmVhdHVyZXMsCj4gPiA+ID4gPiArIC5nZXRfYmFja2VuZF9mZWF0dXJlcyA9IG1seDVf
dmRwYV9nZXRfYmFja2VuZF9mZWF0dXJlcywKPiA+ID4gPiA+ICAgICAgICAgICAuc2V0X2RyaXZl
cl9mZWF0dXJlcyA9IG1seDVfdmRwYV9zZXRfZHJpdmVyX2ZlYXR1cmVzLAo+ID4gPiA+ID4gICAg
ICAgICAgIC5nZXRfZHJpdmVyX2ZlYXR1cmVzID0gbWx4NV92ZHBhX2dldF9kcml2ZXJfZmVhdHVy
ZXMsCj4gPiA+ID4gPiAgICAgICAgICAgLnNldF9jb25maWdfY2IgPSBtbHg1X3ZkcGFfc2V0X2Nv
bmZpZ19jYiwKPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiAyLjM5LjMKPiA+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
