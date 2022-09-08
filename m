Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9DBECAAD5
	for <virtualization@archiver.kernel.org>; Thu,  8 Sep 2022 05:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 99280409ED;
	Thu,  8 Sep 2022 05:19:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 99280409ED
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fDnsrOHQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sDBpHLQBClHP; Thu,  8 Sep 2022 05:19:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1A28D400E2;
	Thu,  8 Sep 2022 05:19:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A28D400E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0306C0032;
	Thu,  8 Sep 2022 05:19:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B64D5C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 05:19:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EDAE83F6E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 05:19:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EDAE83F6E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fDnsrOHQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TBee9baY7vl2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 05:19:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E778483F6C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E778483F6C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 05:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662614368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B1eDsyH0NCED46aCkehmhrnDxVmlGdOirQ4ogyDejUk=;
 b=fDnsrOHQxdFuZMm90vLxW+L2256a2SGdsONildFxUkvS8r/5SXatzGAT2rw0iZeUbGlb2M
 JV3Jx7GGw8/Nn0VOG4/63qYCZWakCO3h4rHxS0sQ6qCta5YjzA5JXlmpYjGOIYIa5ICBjx
 rOODsMgED2uLqzhGcqKBc4cv+aqdQHk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-164-mSvLNFqxPo-yAerm9Ty3kA-1; Thu, 08 Sep 2022 01:19:27 -0400
X-MC-Unique: mSvLNFqxPo-yAerm9Ty3kA-1
Received: by mail-qt1-f198.google.com with SMTP id
 v5-20020ac873c5000000b003434ef0a8c7so13769093qtp.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 22:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=B1eDsyH0NCED46aCkehmhrnDxVmlGdOirQ4ogyDejUk=;
 b=RqF2ekhVDbZ1bn8tvnWAATX7db/ZHMrhB65RXnixU7DWgnR2BHD+PLQUHmzTRUOHWu
 +a83UTIoPgg0oQcoNnXHeuXjzxAUqDap07prHkCG7sUSVITrJeRq7icIQYH/kaVmB/aI
 FUo5+ocuV+ycOtYiABmMV6oqxUKI4Fsa8ryVFvAsB9ZVVrRIbTg+v2PukJBt/1cE+MCH
 5RmsX1Xa7h3LaVk6kKuYzGM17fsztBwV4/FTlViGELvfnGLSFg5/Q902Izv/zOQZ/5f+
 bCW/OyftVbbizLg0oGvuB+8sQX+lw3IHEe8NAnmvxR+2AVUI+S+RWHL8VBYBT+5OHoiV
 wfYg==
X-Gm-Message-State: ACgBeo1EtMi7lrZcts/ak5phsHcRo0NXzzOKdFu9sQuCYdGa1JX87GCY
 qMlSwUbYwxaglP9z5tG48x4gKYsL7IV7jQATkZ37k79m++ihS9gWObg1e5Hakk7WZqjphiVDMtI
 JQ7V29Y3tM0i8bGKI/+8u7lfH6bem9RYyPlTVuXcgUw==
X-Received: by 2002:ad4:5aad:0:b0:4aa:a266:d1a7 with SMTP id
 u13-20020ad45aad000000b004aaa266d1a7mr6185320qvg.70.1662614366711; 
 Wed, 07 Sep 2022 22:19:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4r1VbJFq8CGl7/bxp5VatqXI2qjsFPHqpStma1EuagWySTzIlSshzGyNA5TkIFgOJkVROScA==
X-Received: by 2002:ad4:5aad:0:b0:4aa:a266:d1a7 with SMTP id
 u13-20020ad45aad000000b004aaa266d1a7mr6185310qvg.70.1662614366505; 
 Wed, 07 Sep 2022 22:19:26 -0700 (PDT)
Received: from redhat.com ([45.144.113.243]) by smtp.gmail.com with ESMTPSA id
 a9-20020ac844a9000000b0034305a91aaesm13189404qto.83.2022.09.07.22.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 22:19:25 -0700 (PDT)
Date: Thu, 8 Sep 2022 01:19:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command
 waiting loop
Message-ID: <20220908011858-mutt-send-email-mst@kernel.org>
References: <20220905045341.66191-1-jasowang@redhat.com>
 <20220905031405-mutt-send-email-mst@kernel.org>
 <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
 <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
 <CACGkMEuiDqqOEKUWRN9LvQKv8Jz4mi3aSZMwbhUsJkZp=C-0RQ@mail.gmail.com>
 <c9180ac41b00543e3531a343afae8f5bdca64d8d.camel@redhat.com>
 <20220907034407-mutt-send-email-mst@kernel.org>
 <d32101bb-783f-dbd1-545a-be291c27cb63@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d32101bb-783f-dbd1-545a-be291c27cb63@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Gautam Dawar <gautam.dawar@xilinx.com>, Paolo Abeni <pabeni@redhat.com>,
 davem <davem@davemloft.net>
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

T24gVGh1LCBTZXAgMDgsIDIwMjIgYXQgMTA6MjE6NDVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMi85LzcgMTU6NDYsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4g
PiBPbiBXZWQsIFNlcCAwNywgMjAyMiBhdCAwOTowNzoyMEFNICswMjAwLCBQYW9sbyBBYmVuaSB3
cm90ZToKPiA+ID4gT24gV2VkLCAyMDIyLTA5LTA3IGF0IDEwOjA5ICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiA+IE9uIFR1ZSwgU2VwIDYsIDIwMjIgYXQgNjo1NiBQTSBQYW9sbyBBYmVu
aSA8cGFiZW5pQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gT24gTW9uLCAyMDIyLTA5LTA1
IGF0IDE1OjQ5ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBNb24sIFNl
cCA1LCAyMDIyIGF0IDM6MTUgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4gPiA+ID4gPiA+ID4gT24gTW9uLCBTZXAgMDUsIDIwMjIgYXQgMTI6NTM6NDFQTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IEFkZGluZyBjb25kX3Jlc2No
ZWQoKSB0byB0aGUgY29tbWFuZCB3YWl0aW5nIGxvb3AgZm9yIGEgYmV0dGVyCj4gPiA+ID4gPiA+
ID4gPiBjby1vcGVyYXRpb24gd2l0aCB0aGUgc2NoZWR1bGVyLiBUaGlzIGFsbG93cyB0byBnaXZl
IENQVSBhIGJyZWF0aCB0bwo+ID4gPiA+ID4gPiA+ID4gcnVuIG90aGVyIHRhc2sod29ya3F1ZXVl
KSBpbnN0ZWFkIG9mIGJ1c3kgbG9vcGluZyB3aGVuIHByZWVtcHRpb24gaXMKPiA+ID4gPiA+ID4g
PiA+IG5vdCBhbGxvd2VkLgo+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiBXaGF0J3Mg
bW9yZSBpbXBvcnRhbnQuIFRoaXMgaXMgYSBtdXN0IGZvciBzb21lIHZEUEEgcGFyZW50IHRvIHdv
cmsKPiA+ID4gPiA+ID4gPiA+IHNpbmNlIGNvbnRyb2wgdmlydHF1ZXVlIGlzIGVtdWxhdGVkIHZp
YSBhIHdvcmtxdWV1ZSBmb3IgdGhvc2UgcGFyZW50cy4KPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+
ID4gPiA+ID4gRml4ZXM6IGJkYTMyNGZkMDM3YSAoInZkcGFzaW06IGNvbnRyb2wgdmlydHF1ZXVl
IHN1cHBvcnQiKQo+ID4gPiA+ID4gPiA+IFRoYXQncyBhIHdlaXJkIGNvbW1pdCB0byBmaXguIHNv
IGl0IGZpeGVzIHRoZSBzaW11bGF0b3I/Cj4gPiA+ID4gPiA+IFllcywgc2luY2UgdGhlIHNpbXVs
YXRvciBpcyB1c2luZyBhIHdvcmtxdWV1ZSB0byBoYW5kbGUgY29udHJvbCB2aXJ0dWV1ZS4KPiA+
ID4gPiA+IFVobW0uLi4gdG91Y2hpbmcgYSBkcml2ZXIgZm9yIGEgc2ltdWxhdG9yJ3Mgc2FrZSBs
b29rcyBhIGxpdHRsZSB3ZWlyZC4KPiA+ID4gPiBTaW11bGF0b3IgaXMgbm90IHRoZSBvbmx5IG9u
ZSB0aGF0IGlzIHVzaW5nIGEgd29ya3F1ZXVlIChidXQgc2hvdWxkIGJlCj4gPiA+ID4gdGhlIGZp
cnN0KS4KPiA+ID4gPiAKPiA+ID4gPiBJIGNhbiBzZWUgIHRoYXQgdGhlIG1seDUgdkRQQSBkcml2
ZXIgaXMgdXNpbmcgYSB3b3JrcXVldWUgYXMgd2VsbCAoc2VlCj4gPiA+ID4gbWx4NV92ZHBhX2tp
Y2tfdnEoKSkuCj4gPiA+ID4gCj4gPiA+ID4gQW5kIGluIHRoZSBjYXNlIG9mIFZEVVNFLCBpdCBu
ZWVkcyB0byB3YWl0IGZvciB0aGUgcmVzcG9uc2UgZnJvbSB0aGUKPiA+ID4gPiB1c2Vyc3BhY2Us
IHRoaXMgbWVhbnMgY29uZF9yZXNjaGVkKCkgaXMgcHJvYmFibHkgYSBtdXN0IGZvciB0aGUgY2Fz
ZQo+ID4gPiA+IGxpa2UgVVAuCj4gPiA+ID4gCj4gPiA+ID4gPiBBZGRpdGlvbmFsbHksIGlmIHRo
ZSBidWcgaXMgdmRwYXNpbSwgSSB0aGluayBpdCdzIGJldHRlciB0byB0cnkgdG8KPiA+ID4gPiA+
IHNvbHZlIGl0IHRoZXJlLCBpZiBwb3NzaWJsZS4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gTG9va2lu
ZyBhdCB2ZHBhc2ltX25ldF93b3JrKCkgYW5kIHZkcGFzaW1fYmxrX3dvcmsoKSBpdCBsb29rcyBs
aWtlCj4gPiA+ID4gPiBuZWl0aGVyIG5lZWRzIGEgcHJvY2VzcyBjb250ZXh0LCBzbyBwZXJoYXBz
IHlvdSBjb3VsZCByZXdvcmsgaXQgdG8gcnVuCj4gPiA+ID4gPiB0aGUgd29ya19mbigpIGRpcmVj
dGx5IGZyb20gdmRwYXNpbV9raWNrX3ZxKCksIGF0IGxlYXN0IGZvciB0aGUgY29udHJvbAo+ID4g
PiA+ID4gdmlydHF1ZXVlPwo+ID4gPiA+IEl0J3MgcG9zc2libGUgKGJ1dCByZXF1aXJlIHNvbWUg
cmV3b3JrIG9uIHRoZSBzaW11bGF0b3IgY29yZSkuIEJ1dAo+ID4gPiA+IGNvbnNpZGVyaW5nIHdl
IGhhdmUgb3RoZXIgc2ltaWxhciB1c2UgY2FzZXMsIGl0IGxvb2tzIGJldHRlciB0byBzb2x2ZQo+
ID4gPiA+IGl0IGluIHRoZSB2aXJ0aW8tbmV0IGRyaXZlci4KPiA+ID4gSSBzZWUuCj4gPiA+IAo+
ID4gPiA+IEFkZGl0aW9uYWxseSwgdGhpcyBtYXkgaGF2ZSBiZXR0ZXIgYmVoYXZpb3VyIHdoZW4g
dXNpbmcgZm9yIHRoZSBidWdneQo+ID4gPiA+IGhhcmR3YXJlIChlLmcgdGhlIGNvbnRyb2wgdmly
dHF1ZXVlIHRha2VzIHRvbyBsb25nIHRvIHJlc3BvbmQpLiBXZSBtYXkKPiA+ID4gPiBjb25zaWRl
ciBzd2l0Y2hpbmcgdG8gdXNlIGludGVycnVwdC9zbGVlcCBpbiB0aGUgZnV0dXJlIChidXQgbm90
Cj4gPiA+ID4gc3VpdGFibGUgZm9yIC1uZXQpLgo+ID4gPiBBZ3JlZWQuIFBvc3NpYmx5IGEgdGlt
ZW91dCBjb3VsZCBiZSB1c2VmdWwsIHRvby4KPiA+ID4gCj4gPiA+IENoZWVycywKPiA+ID4gCj4g
PiA+IFBhb2xvCj4gPiAKPiA+IEhtbSB0aW1lb3V0cyBhcmUga2luZCBvZiBhcmJpdHJhcnkuCj4g
PiByZWd1bGFyIGRyaXZlcnMgYmFzaWNhbGx5IGRlcml2ZSB0aGVtIGZyb20gaGFyZHdhcmUKPiA+
IGJlaGF2aW91ciBidXQgd2l0aCBhIGdlbmVyaWMgZHJpdmVyIGxpa2UgdmlydGlvIGl0J3MgaGFy
ZGVyLgo+ID4gSSBndWVzcyB3ZSBjb3VsZCBhZGQgdGltZW91dCBhcyBhIGNvbmZpZyBmaWVsZCwg
aGF2ZQo+ID4gZGV2aWNlIG1ha2UgYSBwcm9taXNlIHRvIHRoZSBkcml2ZXIuCj4gPiAKPiA+IE1h
a2luZyB0aGUgd2FpdCBpbnRlcnJ1cHRpYmxlIHNlZW1zIG1vcmUgcmVhc29uYWJsZS4KPiAKPiAK
PiBZZXMsIGJ1dCBJIHRoaW5rIHdlIHN0aWxsIG5lZWQgdGhpcyBwYXRjaCBmb3IgLW5ldCBhbmQg
LXN0YWJsZS4KPiAKPiBUaGFua3MKCkkgd2FzIHJlZmVycmluZyB0byBQYW9sbydzIGlkZWEgb2Yg
aGF2aW5nIGEgdGltZW91dC4KCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
