Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC904C4338F
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 04:50:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3395A60EE2
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 04:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3395A60EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E60BB40544;
	Thu, 12 Aug 2021 04:50:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uHjKSVuPrEGt; Thu, 12 Aug 2021 04:50:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 77B034020E;
	Thu, 12 Aug 2021 04:50:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50CC7C001A;
	Thu, 12 Aug 2021 04:50:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82040C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 04:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C615606E6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 04:50:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PgVXiEqL5qYg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 04:50:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AFCEB60A69
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 04:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628743812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3EdCh8jUcOhbmGjP/pel54QwoWirthHm42Spak8Fu+8=;
 b=ZTHtbCvVYWnkFBGemqlbGPe5/NlVvVyIVRrj1ZIpMRX0p7Nfpnu8gt8rgQx8fvDmB4rQNU
 YDaM94UFCwLSmIL1V/6u4HUx8fpxaniyr0cJOPXH0rlUOSClcfotjkTU73Mf2EN0wrsuvC
 XoTOwMERDi1uXdyq8E8gGxBxPHKJaX8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-cXp2KREeM4iQXe4K8pIimA-1; Thu, 12 Aug 2021 00:50:09 -0400
X-MC-Unique: cXp2KREeM4iQXe4K8pIimA-1
Received: by mail-ed1-f71.google.com with SMTP id
 y39-20020a50bb2a0000b02903bc05daccbaso2415351ede.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 21:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3EdCh8jUcOhbmGjP/pel54QwoWirthHm42Spak8Fu+8=;
 b=Y/jznUTPPbRpkJRrkwMtpU/YNT6ekw3rCsWBll0KkAMHERLH6HaWt3xVSh5ifccjC3
 FDFMSf/QrtmoKqhHNkZ1uyMSmrz7PzdQO12muhjLdzWHdxOROSYUdMf73OO6eqhMr/2B
 cOIt78PU798sivOwiSpIq4A69NOWaBbtazAAZpqkVbNoaTCsK8p9429pdpvnVEkY2dGI
 MqNGT7Tm/09IWExu9NEs/aeyVT54BkiGU4Hv4R21me6+vLn25V9AfzxNE19K1GEm31Ad
 DMk6fh0V+ZZHFziwgbqz+rsellSQqpJNr73GmCjAhnuASBQC9m/t47F2uesdGfL9nOEG
 SwZw==
X-Gm-Message-State: AOAM530NCsMiRClJ+oPYJuG5CUnfCnkkmw6WM08Ci0/sz+KYDdhpht8G
 Ea44xdJ/UFPt0/UVNeKMs0sCRi06WbRwDto9/JU5R0GfPSDQhXfG7GdsWrDdv7vyvAEAgg/u5lh
 DGpdUDVU0jNgkCKzSaJXYe+U3mX/ZzbSEwgpjF6+4rQ==
X-Received: by 2002:a17:906:7209:: with SMTP id
 m9mr1547129ejk.387.1628743808135; 
 Wed, 11 Aug 2021 21:50:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz91E0jQ/THuDZMxVBENUTarq0cDXA5MCRzrG+Zz2hon71s0/8E+SBP/0DQrOIwM4NFPdSj+w==
X-Received: by 2002:a17:906:7209:: with SMTP id
 m9mr1547120ejk.387.1628743807976; 
 Wed, 11 Aug 2021 21:50:07 -0700 (PDT)
Received: from redhat.com ([2.55.129.96])
 by smtp.gmail.com with ESMTPSA id t25sm544780edi.65.2021.08.11.21.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 21:50:07 -0700 (PDT)
Date: Thu, 12 Aug 2021 00:50:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH] virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
Message-ID: <20210812004655-mutt-send-email-mst@kernel.org>
References: <20210811081623.9832-1-jasowang@redhat.com>
 <20210811151754.030a22a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <aa3e2aca-05a9-aed7-59ec-eb4bd32d8f76@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aa3e2aca-05a9-aed7-59ec-eb4bd32d8f76@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: willemb@google.com, netdev@vger.kernel.org, ivan@prestigetransportation.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
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

T24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMTE6MjM6MDRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS84LzEyIOS4iuWNiDY6MTcsIEpha3ViIEtpY2luc2tpIOWGmemBkzoK
PiA+IE9uIFdlZCwgMTEgQXVnIDIwMjEgMTY6MTY6MjMgKzA4MDAgSmFzb24gV2FuZyB3cm90ZToK
PiA+ID4gVHJ5IHRvIGZpeCB0aGlzIGJ5IHVzaW5nIE5FVElGX0ZfR1JPX0hXIGluc3RlYWQgc28g
d2UncmUgbm90Cj4gPiA+IGd1YXJhbnRlZWQgdG8gYmUgcmUtc2VnbWVudGVkIGFzIG9yaWdpbmFs
Lgo+ID4gVGhpcyBzZW50ZW5jZSBtYXkgbmVlZCByZXBocmFzaW5nLgo+IAo+IAo+IFJpZ2h0LCBh
Y3R1YWxseSwgSSBtZWFudDoKPiAKPiAKPiBUcnkgdG8gZml4IHRoaXMgYnkgdXNpbmcgTkVUSUZf
Rl9HUk9fSFcgaW5zdGVhZC4gQnV0IHdlJ3JlIG5vdCBzdXJlIHRoZQo+IHBhY2tldCBjb3VsZCBi
ZSByZS1zZWdtZW50ZWQgdG8gdGhlIGV4YWN0IG9yaWdpbmFsIHBhY2tldCBzdHJlYW0uIFNpbmNl
IGl0J3MKPiByZWFsbHkgZGVwZW5kcyBvbiB0aGUgYmFrY2VuZCBpbXBsZW1lbnRhdGlvbi4KPiAK
PiAKPiA+IAo+ID4gPiBPciB3ZSBtYXkgd2FudCBhIG5ldyBuZXRkZXYKPiA+ID4gZmVhdHVyZSBs
aWtlIFJYX0dTTyBzaW5jZSB0aGUgZ3Vlc3Qgb2ZmbG9hZHMgZm9yIHZpcnRpby1uZXQgaXMKPiA+
ID4gYWN0dWFsbHkgdG8gcmVjZWl2ZSBHU08gcGFja2V0Lgo+ID4gPiAKPiA+ID4gT3Igd2UgY2Fu
IHRyeSBub3QgYWR2ZXJ0aXNlIExSTyBpcyBjb250cm9sIGd1ZXN0IG9mZmxvYWRzIGlzIG5vdAo+
ID4gPiBlbmFibGVkLiBUaGlzIHNvbHZlcyB0aGUgd2FybmluZyBidXQgd2lsbCBzdGlsbCBzbG93
IGRvd24gdGhlIHRyYWZmaWMuCj4gPiBJTU8gZ3JvLWh3IGZpdHMgcHJldHR5IHdlbGwsIHBhdGNo
IGxvb2tzIGdvb2QuCj4gCj4gCj4gSWYgdGhlIHJlLXNlZ21lbnRhdGlvbiBpcyBub3QgYSBpc3N1
ZS4gSSB3aWxsIHBvc3QgYSBmb3JtYWwgcGF0Y2guCj4gCj4gVGhhbmtzCgoKSXQgaXMgYnV0IHRo
ZSBwb2ludCBpcyBldmVuIHRob3VnaCBzcGVjIGRpZCBub3QgcmVxdWlyZSB0aGlzCndlIGFsd2F5
cyBhbGxvd2VkIHRoZXNlIGNvbmZpZ3VyYXRpb25zCmluIHRoZSBwYXN0IHNvIGhvcGVmdWxseSBt
b3N0IG9mIHRoZW0gYXJlIG5vdCBicm9rZW4gYW5kIGNvbWJpbmUKcGFja2V0cyBpbiB0aGUgc2Ft
ZSB3YXkgYXMgR1JPLiBMZXQncyBub3QgYnJlYWsgdGhlbSBhbGwKaW4gYW4gYXR0ZW1wdCB0byBj
YXRjaCBiYWQgY29uZmlncywgYW5kIG1lYW53aGlsZSBhbWVuZAp0aGUgc3BlYyB0byByZWNvbW1l
bmQgZG9pbmcgR1cgR1JPLgoKPiAKPiA+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
