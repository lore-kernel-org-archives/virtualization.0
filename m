Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242ECC77B7D
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 05:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85194845DF;
	Wed, 10 May 2023 05:33:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85194845DF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BSx6gP9M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kE3WyBpjglIR; Wed, 10 May 2023 05:33:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DF3E4845C5;
	Wed, 10 May 2023 05:33:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF3E4845C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 983BEC0036;
	Wed, 10 May 2023 05:33:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 216B6C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 05:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E72BF4018F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 05:33:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E72BF4018F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BSx6gP9M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zsJ4kjt-h5vM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 05:33:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9DD5D40186
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9DD5D40186
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 05:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683696782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfR3pdTnrmVcxjx1/XCpuBAbDSlJT7L6QiQpFvOxED0=;
 b=BSx6gP9MiDLr9IJcrQvxP7BF3YI4CsJveJSJpa2ybBHspYUUCXUmD7kDjg0nr7U8G48NRN
 EVxdZAmcEIZBeuCSq9pXlYXuGtdDTuxj8E8A56v/C6nWpyivQXQ0wPiQxB3x594zZnoAcl
 8p3GAyE6+4zIYMusqy0nkefkpwfRLRI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-sYeHmlBcNoeHfI-sBbHPdw-1; Wed, 10 May 2023 01:33:01 -0400
X-MC-Unique: sYeHmlBcNoeHfI-sBbHPdw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-50d89279d95so10743790a12.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 May 2023 22:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683696780; x=1686288780;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CfR3pdTnrmVcxjx1/XCpuBAbDSlJT7L6QiQpFvOxED0=;
 b=HGnlBVKdnZfSyoUrBKNuqRnBoCXS4vBMbeXRt7385W84Z7er5F8OAufZajeY4leS/f
 QB3qDUorTLoDtCYV8WIKOeFSb4N7cax7d/4z0mZxMgJWaTz7idWWE/EbYV3xDrQ1glJR
 rZgOA/KV8m3ECdLCMR7mCagvv7XjY3dViAXyO8t6Un0doOVbLaD38XjSASr58H25FYs3
 4+YwuzSUqLVRicgiBUIqLgiblGYnZI/xHi+2g1DZoGmPqaCdYDCFOy8vM2qHCUvth5Nm
 dxLpKScLS+zN1f0dOJkJCpPOFTIFW5sOlowktiE47EruvFhBhhJNTRC5RNkfpW1/J1Ct
 ETyQ==
X-Gm-Message-State: AC+VfDwC8ixxhZcfhBENUdwL9/s7sdqN0vGB1X8sflrYFAewhCj3tIB6
 Mdg0uaaOpXrJBETb3+bjBuBqCryZ/n7iv3Nb50/X6mlsWdS9+qdOZZD12osw5bhURdwOITYupbV
 RgZsuvNB1sFpb3dQeb8l3cSjj/b9WZA2cHuPyP4YtOA==
X-Received: by 2002:a05:6402:3587:b0:50c:1603:654 with SMTP id
 y7-20020a056402358700b0050c16030654mr14748677edc.16.1683696779949; 
 Tue, 09 May 2023 22:32:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6V4Bg09XaNc7Uq/10va+cr/YvgkAVnRjG5KK8NmISXyPQ+XKlfBDvcGuJ6+QR7dyAWLxXywg==
X-Received: by 2002:a05:6402:3587:b0:50c:1603:654 with SMTP id
 y7-20020a056402358700b0050c16030654mr14748657edc.16.1683696779652; 
 Tue, 09 May 2023 22:32:59 -0700 (PDT)
Received: from redhat.com ([176.119.195.36]) by smtp.gmail.com with ESMTPSA id
 sa40-20020a1709076d2800b00965d4b2bd4csm2230865ejc.141.2023.05.09.22.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 May 2023 22:32:58 -0700 (PDT)
Date: Wed, 10 May 2023 01:32:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230510012951-mutt-send-email-mst@kernel.org>
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-2-jasowang@redhat.com>
 <20230413121525-mutt-send-email-mst@kernel.org>
 <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
 <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, edumazet@google.com, maxime.coquelin@redhat.com,
 kuba@kernel.org, pabeni@redhat.com, david.marchand@redhat.com,
 davem@davemloft.net
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

T24gTW9uLCBBcHIgMTcsIDIwMjMgYXQgMTE6NDA6NThBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBGcmksIEFwciAxNCwgMjAyMyBhdCAzOjIx4oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gRnJpLCBBcHIgMTQsIDIwMjMgYXQg
MDE6MDQ6MTVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gRm9yZ2V0IHRvIGNjIG5l
dGRldiwgYWRkaW5nLgo+ID4gPgo+ID4gPiBPbiBGcmksIEFwciAxNCwgMjAyMyBhdCAxMjoyNeKA
r0FNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4g
PiA+ID4gT24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgMDI6NDA6MjZQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiA+IFRoaXMgcGF0Y2ggY29udmVydCByeCBtb2RlIHNldHRpbmcgdG8g
YmUgZG9uZSBpbiBhIHdvcmtxdWV1ZSwgdGhpcyBpcwo+ID4gPiA+ID4gYSBtdXN0IGZvciBhbGxv
dyB0byBzbGVlcCB3aGVuIHdhaXRpbmcgZm9yIHRoZSBjdnEgY29tbWFuZCB0bwo+ID4gPiA+ID4g
cmVzcG9uc2Ugc2luY2UgY3VycmVudCBjb2RlIGlzIGV4ZWN1dGVkIHVuZGVyIGFkZHIgc3BpbiBs
b2NrLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+Cj4gPiA+ID4KPiA+ID4gPiBJIGRvbid0IGxpa2UgdGhpcyBmcmFua2x5
LiBUaGlzIG1lYW5zIHRoYXQgc2V0dGluZyBSWCBtb2RlIHdoaWNoIHdvdWxkCj4gPiA+ID4gcHJl
dmlvdXNseSBiZSByZWxpYWJsZSwgbm93IGJlY29tZXMgdW5yZWxpYWJsZS4KPiA+ID4KPiA+ID4g
SXQgaXMgInVucmVsaWFibGUiIGJ5IGRlc2lnbjoKPiA+ID4KPiA+ID4gICAgICAgdm9pZCAgICAg
ICAgICAgICAgICAgICAgKCpuZG9fc2V0X3J4X21vZGUpKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYp
Owo+ID4gPgo+ID4gPiA+IC0gZmlyc3Qgb2YgYWxsIGNvbmZpZ3VyYXRpb24gaXMgbm8gbG9uZ2Vy
IGltbWVkaWF0ZQo+ID4gPgo+ID4gPiBJcyBpbW1lZGlhdGUgYSBoYXJkIHJlcXVpcmVtZW50PyBJ
IGNhbiBzZWUgYSB3b3JrcXVldWUgaXMgdXNlZCBhdCBsZWFzdDoKPiA+ID4KPiA+ID4gbWx4NWUs
IGlwb2liLCBlZngsIC4uLgo+ID4gPgo+ID4gPiA+ICAgYW5kIHRoZXJlIGlzIG5vIHdheSBmb3Ig
ZHJpdmVyIHRvIGZpbmQgb3V0IHdoZW4KPiA+ID4gPiAgIGl0IGFjdHVhbGx5IHRvb2sgZWZmZWN0
Cj4gPiA+Cj4gPiA+IEJ1dCB3ZSBrbm93IHJ4IG1vZGUgaXMgYmVzdCBlZmZvcnQgZS5nIGl0IGRv
ZXNuJ3Qgc3VwcG9ydCB2aG9zdCBhbmQgd2UKPiA+ID4gc3Vydml2ZSBmcm9tIHRoaXMgZm9yIHll
YXJzLgo+ID4gPgo+ID4gPiA+IC0gc2Vjb25kLCBpZiBkZXZpY2UgZmFpbHMgY29tbWFuZCwgdGhp
cyBpcyBhbHNvIG5vdAo+ID4gPiA+ICAgcHJvcGFnYXRlZCB0byBkcml2ZXIsIGFnYWluIG5vIHdh
eSBmb3IgZHJpdmVyIHRvIGZpbmQgb3V0Cj4gPiA+ID4KPiA+ID4gPiBWRFVTRSBuZWVkcyB0byBi
ZSBmaXhlZCB0byBkbyB0cmlja3MgdG8gZml4IHRoaXMKPiA+ID4gPiB3aXRob3V0IGJyZWFraW5n
IG5vcm1hbCBkcml2ZXJzLgo+ID4gPgo+ID4gPiBJdCdzIG5vdCBzcGVjaWZpYyB0byBWRFVTRS4g
Rm9yIGV4YW1wbGUsIHdoZW4gdXNpbmcgdmlydGlvLW5ldCBpbiB0aGUKPiA+ID4gVVAgZW52aXJv
bm1lbnQgd2l0aCBhbnkgc29mdHdhcmUgY3ZxIChsaWtlIG1seDUgdmlhIHZEUEEgb3IgY21hCj4g
PiA+IHRyYW5zcG9ydCkuCj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4KPiA+IEhtbS4gQ2FuIHdlIGRp
ZmZlcmVudGlhdGUgYmV0d2VlbiB0aGVzZSB1c2UtY2FzZXM/Cj4gCj4gSXQgZG9lc24ndCBsb29r
IGVhc3kgc2luY2Ugd2UgYXJlIGRyaXZlcnMgZm9yIHZpcnRpbyBidXMuIFVuZGVybGF5ZXIKPiBk
ZXRhaWxzIHdlcmUgaGlkZGVuIGZyb20gdmlydGlvLW5ldC4KPiAKPiBPciBkbyB5b3UgaGF2ZSBh
bnkgaWRlYXMgb24gdGhpcz8KPiAKPiBUaGFua3MKCkkgZG9uJ3Qga25vdywgcGFzcyBzb21lIGtp
bmQgb2YgZmxhZyBpbiBzdHJ1Y3QgdmlydHF1ZXVlPwoJImJvb2wgc2xvdzsgLyogVGhpcyB2cSBj
YW4gYmUgdmVyeSBzbG93IHNvbWV0aW1lcy4gRG9uJ3Qgd2FpdCBmb3IgaXQhICovIgoKPwoKLS0g
Ck1TVAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
