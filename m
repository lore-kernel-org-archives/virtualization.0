Return-Path: <SRS0=JeE0=EJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F48C388F7
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 19:46:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 213C6206CB
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 19:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chwpTUtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213C6206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D733786451;
	Tue,  3 Nov 2020 19:46:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YcT1rIL2SEKk; Tue,  3 Nov 2020 19:46:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1780786101;
	Tue,  3 Nov 2020 19:46:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED3F2C088B;
	Tue,  3 Nov 2020 19:46:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1227FC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 19:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E51E8214FD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 19:46:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G8sQrRd8pqkY
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 19:46:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id C6C58207A8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 19:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604432778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXGHvDYwh9NMkyXNB/mXiydEr8BiB4sd5uCcFnHHQZg=;
 b=chwpTUtqHwO02E0vi3/Q7iXNI88a/J1qSQNV/ZpXJ8DOipuh0xSFZjIo4qlN9FlCW1PLof
 P9mmx6hwaluMP2xkOYijiBlxSyka+bF+ZDW60DaeVcnBWPyeOCMlbg1ZjdPcII361h0IW2
 EyJRna6Q14KM5jGfCYZJuhUGVamgCQ8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-TQ_LK1sWPoWVZhbN-Gm1mg-1; Tue, 03 Nov 2020 14:46:17 -0500
X-MC-Unique: TQ_LK1sWPoWVZhbN-Gm1mg-1
Received: by mail-qv1-f72.google.com with SMTP id s4so5163085qvn.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Nov 2020 11:46:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hXGHvDYwh9NMkyXNB/mXiydEr8BiB4sd5uCcFnHHQZg=;
 b=Gz1WPFrf2Tc09uaHntMr9iP/kKO9C8jd/R3qfCItu75LflrqHKnhsgt76q0zNkVDSh
 73ZBz0Q8xGiBR7VfZ+oW/ihCBF8QbaT5ghSjVsJm/GFRTXvebybnzPFP5vQCF2sBjq9J
 KRkLMNL+DKowJMRvkkIgeG1rl1l6XXkRZAihId2wKomBc1kKytLrFi888mVaf+in9sq0
 KX3/sBHVT92mPnRRkLAPA9wLIB5bDtrqWDUcZfMP4sACVBchw+7B67R8lezbTGfDgSY1
 AoCIpQgg3CuqQRiT42FHLMQ77vpt30q2d+YcSJeSBrhZaX6lKd9zkt0al03m2IyuEyB/
 RkRw==
X-Gm-Message-State: AOAM532uwVqebNfYm+1YhhK+KiOQAxPFq55yiZl3XvsJdpg64wQoCB9e
 keUPKaEZBAicmAVRtj1za+H+3W43l3L6W0Z+MJ8iw+Fj4sxYcLvDk28IxMV5BNolc4OVbsRmx0g
 qFzKRjafPorMV5LFFI3/zMbDVIY+gHCyM0HF+NmbL0A==
X-Received: by 2002:ae9:f402:: with SMTP id y2mr20621903qkl.459.1604432776433; 
 Tue, 03 Nov 2020 11:46:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHrx/4K1ur2emSikIwCSW6QoSh0HGIlNgos3cwaHoIzJ12L9uFjx7qLeKQUNbiJ0RTQKVuVA==
X-Received: by 2002:ae9:f402:: with SMTP id y2mr20621874qkl.459.1604432776110; 
 Tue, 03 Nov 2020 11:46:16 -0800 (PST)
Received: from xz-x1
 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
 by smtp.gmail.com with ESMTPSA id i70sm11572985qke.11.2020.11.03.11.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 11:46:15 -0800 (PST)
Date: Tue, 3 Nov 2020 14:46:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/vsock: add IOTLB API support
Message-ID: <20201103194613.GK20600@xz-x1>
References: <20201029174351.134173-1-sgarzare@redhat.com>
 <751cc074-ae68-72c8-71de-a42458058761@redhat.com>
 <20201030105422.ju2aj2bmwsckdufh@steredhat>
 <278f4732-e561-2b4f-03ee-b26455760b01@redhat.com>
 <20201102171104.eiovmkj23fle5ioj@steredhat>
 <8648a2e3-1052-3b5b-11ce-87628ac8dd33@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8648a2e3-1052-3b5b-11ce-87628ac8dd33@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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

T24gVHVlLCBOb3YgMDMsIDIwMjAgYXQgMDU6MDQ6MjNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzExLzMg5LiK5Y2IMToxMSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+ID4gT24gRnJpLCBPY3QgMzAsIDIwMjAgYXQgMDc6NDQ6NDNQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gCj4gPiA+IE9uIDIwMjAvMTAvMzAg5LiL5Y2INjo1NCwgU3RlZmFubyBH
YXJ6YXJlbGxhIHdyb3RlOgo+ID4gPiA+IE9uIEZyaSwgT2N0IDMwLCAyMDIwIGF0IDA2OjAyOjE4
UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IE9uIDIwMjAv
MTAvMzAg5LiK5Y2IMTo0MywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4gPiA+ID4gPiBU
aGlzIHBhdGNoIGVuYWJsZXMgdGhlIElPVExCIEFQSSBzdXBwb3J0IGZvciB2aG9zdC12c29jayBk
ZXZpY2VzLAo+ID4gPiA+ID4gPiBhbGxvd2luZyB0aGUgdXNlcnNwYWNlIHRvIGVtdWxhdGUgYW4g
SU9NTVUgZm9yIHRoZSBndWVzdC4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IFRoZXNlIGNoYW5n
ZXMgd2VyZSBtYWRlIGZvbGxvd2luZyB2aG9zdC1uZXQsIGluIGRldGFpbHMgdGhpcyBwYXRjaDoK
PiA+ID4gPiA+ID4gLSBleHBvc2VzIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBmZWF0dXJlIGFu
ZCBpbml0cyB0aGUgaW90bGIKPiA+ID4gPiA+ID4gwqAgZGV2aWNlIGlmIHRoZSBmZWF0dXJlIGlz
IGFja2VkCj4gPiA+ID4gPiA+IC0gaW1wbGVtZW50cyBWSE9TVF9HRVRfQkFDS0VORF9GRUFUVVJF
UyBhbmQKPiA+ID4gPiA+ID4gwqAgVkhPU1RfU0VUX0JBQ0tFTkRfRkVBVFVSRVMgaW9jdGxzCj4g
PiA+ID4gPiA+IC0gY2FsbHMgdnFfbWV0YV9wcmVmZXRjaCgpIGJlZm9yZSB2cSBwcm9jZXNzaW5n
IHRvIHByZWZldGNoIHZxCj4gPiA+ID4gPiA+IMKgIG1ldGFkYXRhIGFkZHJlc3MgaW4gSU9UTEIK
PiA+ID4gPiA+ID4gLSBwcm92aWRlcyAucmVhZF9pdGVyLCAud3JpdGVfaXRlciwgYW5kIC5wb2xs
IGNhbGxiYWNrcyBmb3IgdGhlCj4gPiA+ID4gPiA+IMKgIGNoYXJkZXY7IHRoZXkgYXJlIHVzZWQg
YnkgdGhlIHVzZXJzcGFjZSB0byBleGNoYW5nZSBJT1RMQiBtZXNzYWdlcwo+ID4gPiA+ID4gPiAK
PiA+ID4gPiA+ID4gVGhpcyBwYXRjaCB3YXMgdGVzdGVkIHdpdGggUUVNVSBhbmQgYSBwYXRjaCBh
cHBsaWVkIFsxXSB0byBmaXggYQo+ID4gPiA+ID4gPiBzaW1wbGUgaXNzdWU6Cj4gPiA+ID4gPiA+
IMKgwqDCoCAkIHFlbXUgLU0gcTM1LGFjY2VsPWt2bSxrZXJuZWwtaXJxY2hpcD1zcGxpdCBcCj4g
PiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC1kcml2ZSBmaWxlPWZlZG9yYS5xY293Mixm
b3JtYXQ9cWNvdzIsaWY9dmlydGlvIFwKPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LWRldmljZSBpbnRlbC1pb21tdSxpbnRyZW1hcD1vbiBcCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC1kZXZpY2Ugdmhvc3QtdnNvY2stcGNpLGd1ZXN0LWNpZD0zLGlvbW11X3BsYXRm
b3JtPW9uCj4gPiA+ID4gPiAKPiA+ID4gPiA+IAo+ID4gPiA+ID4gUGF0Y2ggbG9va3MgZ29vZCwg
YnV0IGEgcXVlc3Rpb246Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IEl0IGxvb2tzIHRvIG1lIHlvdSBk
b24ndCBlbmFibGUgQVRTIHdoaWNoIG1lYW5zIHZob3N0IHdvbid0Cj4gPiA+ID4gPiBnZXQgYW55
IGludmFsaWRhdGlvbiByZXF1ZXN0IG9yIGRpZCBJIG1pc3MgYW55dGhpbmc/Cj4gPiA+ID4gPiAK
PiA+ID4gPiAKPiA+ID4gPiBZb3UncmUgcmlnaHQsIEkgZGlkbid0IHNlZSBpbnZhbGlkYXRpb24g
cmVxdWVzdHMsIG9ubHkgbWlzcyBhbmQKPiA+ID4gPiB1cGRhdGVzLgo+ID4gPiA+IE5vdyBJIGhh
dmUgdHJpZWQgdG8gZW5hYmxlICdhdHMnIGFuZCAnZGV2aWNlLWlvdGxiJyBidXQgSSBzdGlsbAo+
ID4gPiA+IGRvbid0IHNlZSBhbnkgaW52YWxpZGF0aW9uLgo+ID4gPiA+IAo+ID4gPiA+IEhvdyBj
YW4gSSB0ZXN0IGl0PyAoU29ycnkgYnV0IEkgZG9uJ3QgaGF2ZSBtdWNoIGV4cGVyaWVuY2UgeWV0
Cj4gPiA+ID4gd2l0aCB2SU9NTVUpCj4gPiA+IAo+ID4gPiAKPiA+ID4gSSBndWVzcyBpdCdzIGJl
Y2F1c2UgdGhlIGJhdGNoZWQgdW5tYXAuIE1heWJlIHlvdSBjYW4gdHJ5IHRvIHVzZQo+ID4gPiAi
aW50ZWxfaW9tbXU9c3RyaWN0IiBpbiBndWVzdCBrZXJuZWwgY29tbWFuZCBsaW5lIHRvIHNlZSBp
ZiBpdAo+ID4gPiB3b3Jrcy4KPiA+ID4gCj4gPiA+IEJ0dywgbWFrZSBzdXJlIHRoZSBxZW11IGNv
bnRhaW5zIHRoZSBwYXRjaCBbMV0uIE90aGVyd2lzZSBBVFMgd29uJ3QKPiA+ID4gYmUgZW5hYmxl
ZCBmb3IgcmVjZW50IExpbnV4IEtlcm5lbCBpbiB0aGUgZ3Vlc3QuCj4gPiAKPiA+IFRoZSBwcm9i
bGVtIHdhcyBteSBrZXJuZWwsIGl0IHdhcyBidWlsdCB3aXRoIGEgdGlueSBjb25maWd1cmF0aW9u
Lgo+ID4gVXNpbmcgZmVkb3JhIHN0b2NrIGtlcm5lbCBJIGNhbiBzZWUgdGhlICdpbnZhbGlkYXRl
JyByZXF1ZXN0cywgYnV0IEkKPiA+IGFsc28gaGFkIHRoZSBmb2xsb3dpbmcgaXNzdWVzLgo+ID4g
Cj4gPiBEbyB0aGV5IG1ha2UgeW91IHJpbmcgYW55IGJlbGxzPwo+ID4gCj4gPiAkIC4vcWVtdSAt
bSA0RyAtc21wIDQgLU0gcTM1LGFjY2VsPWt2bSxrZXJuZWwtaXJxY2hpcD1zcGxpdCBcCj4gPiDC
oMKgwqAgLWRyaXZlIGZpbGU9ZmVkb3JhLnFjb3cyLGZvcm1hdD1xY293MixpZj12aXJ0aW8gXAo+
ID4gwqDCoMKgIC1kZXZpY2UgaW50ZWwtaW9tbXUsaW50cmVtYXA9b24sZGV2aWNlLWlvdGxiPW9u
IFwKPiA+IMKgwqDCoCAtZGV2aWNlIHZob3N0LXZzb2NrLXBjaSxndWVzdC1jaWQ9Nixpb21tdV9w
bGF0Zm9ybT1vbixhdHM9b24saWQ9djEKPiA+IAo+ID4gwqDCoMKgIHFlbXUtc3lzdGVtLXg4Nl82
NDogdnRkX2lvdmFfdG9fc2xwdGU6IGRldGVjdGVkIElPVkEgb3ZlcmZsb3cgwqDCoMKgCj4gPiAo
aW92YT0weDFkNDAwMDAwMzBjMCkKPiAKPiAKPiBJdCdzIGEgaGludCB0aGF0IElPVkEgZXhjZWVk
cyB0aGUgQVcuIEl0IG1pZ2h0IGJlIHdvcnRoIHRvIGNoZWNrIHdoZXRoZXIgdGhlCj4gbWlzc2Vk
IElPVkEgcmVwb3J0ZWQgZnJvbSBJT1RMQiBpcyBsZWdhbC4KClllYWguICBCeSBkZWZhdWx0IHRo
ZSBRRU1VIHZJT01NVSBzaG91bGQgb25seSBzdXBwb3J0IDM5Yml0cyB3aWR0aCBmb3IgZ3Vlc3QK
aW92YSBhZGRyZXNzIHNwYWNlLiAgVG8gZXh0ZW5kIGl0LCB3ZSBjYW4gdXNlOgoKICAtZGV2aWNl
IGludGVsLWlvbW11LGF3LWJpdHM9NDgKClNvIHdlJ2xsIGVuYWJsZSA0LWxldmVsIGlvbW11IHBn
dGFibGUuCgpIZXJlIHRoZSBpb3ZhIGlzIG9idmlvdXMgbG9uZ2VyIHRoYW4gdGhpcywgc28gaXQn
bGwgYmUgaW50ZXJlc3RpbmcgdG8ga25vdyB3aHkKdGhhdCBpb3ZhIGlzIGFsbG9jYXRlZCBpbiB0
aGUgZ3Vlc3QgZHJpdmVyIHNpbmNlIHRoZSBkcml2ZXIgc2hvdWxkIGtub3cgc29tZWhvdwp0aGF0
IHRoaXMgaW92YSBpcyBiZXlvbmQgd2hhdCdzIHN1cHBvcnRlZCAoZ3Vlc3QgaW9tbXUgZHJpdmVy
IHNob3VsZCBiZSBhYmxlIHRvCnByb2JlIHZpb21tdSBjYXBhYmlsaXR5IG9uIHRoaXMgd2lkdGgg
aW5mb3JtYXRpb24gdG9vKS4KCi0tIApQZXRlciBYdQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
