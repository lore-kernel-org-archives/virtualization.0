Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D536BC43462
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 08:03:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAB761158
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 08:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAB761158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D27B840678;
	Wed, 21 Apr 2021 08:03:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fm8QSubrrgw3; Wed, 21 Apr 2021 08:03:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D7A440674;
	Wed, 21 Apr 2021 08:03:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2E99C000F;
	Wed, 21 Apr 2021 08:03:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE207C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC69283DD8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:03:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jVCZ59eyEQPq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:03:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B97CF83DDC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618992211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPKgP7klNWLubS6sd3edyUmumJ6vttCicSRo4mXzd7s=;
 b=cioiDVHbDACrkXz1s1hr3z2EBLkbWAWuEfeNF0DIgUgpvCkNoFVNOdRTpb4vhUCZud66+0
 O+I1zKmJm1J+xLfn61Lqvn98b9HtpUB1jdTVRF0A9aeny9Hi2pWSo9mMGtLkTq/TTViLAN
 JZbP9sgENEc4/muMyeQS+WMYGAru7Rs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-HRSCRZwDPqqR3kKaK51SwA-1; Wed, 21 Apr 2021 04:03:30 -0400
X-MC-Unique: HRSCRZwDPqqR3kKaK51SwA-1
Received: by mail-wr1-f70.google.com with SMTP id
 t14-20020adff04e0000b0290103307c23e1so12270843wro.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 01:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mPKgP7klNWLubS6sd3edyUmumJ6vttCicSRo4mXzd7s=;
 b=OxFfxfNl0ao4SlFjxIAb3BzlZdKIhxAE1GAh3h5PHAUkL7MpslaKVaol++CibFsa1t
 T59IcXLaeR5wTEyjOxmbbXflg7EhDAPZ9Jy+Mh+cMOIDox9P9BhCh/JNd/oORGl7JvKG
 /bLoDnkY05Q+z0lEp3Y9QDB8scY7z0kMo4KCNQQscIF5P74PTUBcTXwiWAffzLQddsBF
 91NAThrChBiwOnhgUNXYwUgL+duuZSR2mCoXi4phrXQRnTHEdID9Jyq2DlMbHXZVsXHP
 XcNl6nynt7R2M+GFghbPFvfwkYnRCWSWVerxW64iMHkoQy2107qbc/h86lp6SK3utM33
 Rk6w==
X-Gm-Message-State: AOAM531zlq79Z7XdXjE0qOwhPRGzoaJO7t07Er2Uyv7LfV3R5f0z0809
 x2gQ9dGNreaGF7y3rNm1u5PWmeytEOU8gpumLAFkYt0ifP/5HpQZPlUSA7Ml7BSl9gNEVEVc/Dc
 FS/GjqHGKGL3ryWLPONSZuHqruJiOXWJPhEHSlVj49Q==
X-Received: by 2002:a1c:a9d5:: with SMTP id s204mr8617795wme.24.1618992208787; 
 Wed, 21 Apr 2021 01:03:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPhLH1AFcxrJDYFlw8cZzL5sqgwpmbbTELoYTAUZjcc9YuFlY4dLf0fFPHK5u383kwpxaQ0w==
X-Received: by 2002:a1c:a9d5:: with SMTP id s204mr8617775wme.24.1618992208600; 
 Wed, 21 Apr 2021 01:03:28 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
 by smtp.gmail.com with ESMTPSA id x189sm1442422wmg.17.2021.04.21.01.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 01:03:27 -0700 (PDT)
Date: Wed, 21 Apr 2021 04:03:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
Message-ID: <20210421035331-mutt-send-email-mst@kernel.org>
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210408115834-mutt-send-email-mst@kernel.org>
 <a6a4ab68-c958-7266-c67c-142960222b67@redhat.com>
 <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
 <20210412050730-mutt-send-email-mst@kernel.org>
 <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com>
 <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: elic@nvidia.com, linux-kernel@vger.kernel.org, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, virtualization@lists.linux-foundation.org
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

T24gV2VkLCBBcHIgMjEsIDIwMjEgYXQgMDM6NDE6MzZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS80LzEyIOS4i+WNiDU6MjMsIEphc29uIFdhbmcg5YaZ6YGTOgo+ID4g
Cj4gPiDlnKggMjAyMS80LzEyIOS4i+WNiDU6MDksIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6
Cj4gPiA+IE9uIE1vbiwgQXByIDEyLCAyMDIxIGF0IDAyOjM1OjA3UE0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiA+ID4g5ZyoIDIwMjEvNC8xMCDkuIrljYgxMjowNCwgTWljaGFlbCBTLiBU
c2lya2luIOWGmemBkzoKPiA+ID4gPiA+IE9uIEZyaSwgQXByIDA5LCAyMDIxIGF0IDEyOjQ3OjU1
UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+IOWcqCAyMDIxLzQvOCDkuIvl
jYgxMTo1OSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4gPiA+ID4gPiBPbiBUaHUs
IEFwciAwOCwgMjAyMSBhdCAwNDoyNjo0OFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4g
PiA+ID4gPiA+ID4gVGhpcyBwYXRjaCBtYW5kYXRlcyAxLjAgZm9yIHZEUEEgZGV2aWNlcy4gVGhl
IGdvYWwgaXMgdG8gaGF2ZSB0aGUKPiA+ID4gPiA+ID4gPiA+IHNlbWFudGljIG9mIG5vcm1hdGl2
ZSBzdGF0ZW1lbnQgaW4gdGhlIHZpcnRpbwo+ID4gPiA+ID4gPiA+ID4gc3BlYyBhbmQgZWxpbWlu
YXRlIHRoZQo+ID4gPiA+ID4gPiA+ID4gYnVyZGVuIG9mIHRyYW5zaXRpb25hbCBkZXZpY2UgZm9y
IGJvdGggdkRQQSBidXMgYW5kIHZEUEEgcGFyZW50Lgo+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4g
PiA+ID4gPiB1QVBJIHNlZW1zIGZpbmUgc2luY2UgYWxsIHRoZSB2RFBBIHBhcmVudCBtYW5kYXRl
cwo+ID4gPiA+ID4gPiA+ID4gVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIHdoaWNoIGltcGxpZXMg
MS4wIGRldmljZXMuCj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+IEZvciBsZWdhY3kg
Z3Vlc3RzLCBpdCBjYW4gc3RpbGwgd29yayBzaW5jZSBRZW11IHdpbGwgbWVkaWF0ZSB3aGVuCj4g
PiA+ID4gPiA+ID4gPiBuZWNlc3NhcnkgKGUuZyBkb2luZyB0aGUgZW5kaWFuIGNvbnZlcnNpb24p
Lgo+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+IEhtbS4gSWYgd2UgZG8gdGhp
cywgZG9uJ3Qgd2Ugc3RpbGwgaGF2ZSBhIHByb2JsZW0gd2l0aAo+ID4gPiA+ID4gPiA+IGxlZ2Fj
eSBkcml2ZXJzIHdoaWNoIGRvbid0IGFjayAxLjA/Cj4gPiA+ID4gPiA+IFllcywgYnV0IGl0J3Mg
bm90IHNvbWV0aGluZyB0aGF0IGlzIGludHJvZHVjZWQgaW4gdGhpcwo+ID4gPiA+ID4gPiBjb21t
aXQuIFRoZSBsZWdhY3kKPiA+ID4gPiA+ID4gZHJpdmVyIG5ldmVyIHdvcmsgLi4uCj4gPiA+ID4g
PiBNeSBwb2ludCBpcyB0aGlzIG5laXRoZXIgZml4ZXMgb3IgcHJldmVudHMgdGhpcy4KPiA+ID4g
PiA+IAo+ID4gPiA+ID4gU28gbXkgc3VnZ2VzdGlvbiBpcyB0byBmaW5hbGx5IGFkZCBpb2N0bHMg
YWxvbmcgdGhlIGxpbmVzCj4gPiA+ID4gPiBvZiBQUk9UT0NPTF9GRUFUVVJFUyBvZiB2aG9zdC11
c2VyLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBUaGVuIHRoYXQgb25lIGNhbiBoYXZlIGJpdHMgZm9y
IGxlZ2FjeSBsZSwgbGVnYWN5IGJlIGFuZCBtb2Rlcm4uCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEJU
VyBJIGxvb2tlZCBhdCB2aG9zdC11c2VyIGFuZCBpdCBkb2VzIG5vdCBsb29rIGxpa2UgdGhhdAo+
ID4gPiA+ID4gaGFzIGEgc29sdXRpb24gZm9yIHRoaXMgcHJvYmxlbSBlaXRoZXIsIHJpZ2h0Pwo+
ID4gPiA+IAo+ID4gPiA+IFJpZ2h0Lgo+ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+ID4gCj4gPiA+
ID4gPiA+ID4gTm90ZSAxLjAgYWZmZWN0cyByaW5nIGVuZGlhbm5lc3Mgd2hpY2ggaXMgbm90IG1l
ZGlhdGVkIGluIFFFTVUKPiA+ID4gPiA+ID4gPiBzbyBRRU1VIGNhbid0IHByZXRlbmQgdG8gZGV2
aWNlIGd1ZXN0IGlzIDEuMC4KPiA+ID4gPiA+ID4gUmlnaHQsIEkgcGxhbiB0byBzZW5kIHBhdGNo
ZXMgdG8gZG8gbWVkaWF0aW9uIGluIHRoZQo+ID4gPiA+ID4gPiBRZW11IHRvIHVuYnJlYWsgbGVn
YWN5Cj4gPiA+ID4gPiA+IGRyaXZlcnMuCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBUaGFua3MK
PiA+ID4gPiA+IEkgZnJhbmtseSB0aGluayB3ZSdsbCBuZWVkIFBST1RPQ09MX0ZFQVRVUkVTIGFu
eXdheSwgaXQncwo+ID4gPiA+ID4gdG9vIHVzZWZ1bCAuLi4KPiA+ID4gPiA+IHNvIHdoeSBub3Qg
dGVhY2ggZHJpdmVycyBhYm91dCBpdCBhbmQgYmUgZG9uZSB3aXRoIGl0PyBZb3UKPiA+ID4gPiA+
IGNhbid0IGVtdWxhdGUKPiA+ID4gPiA+IGxlZ2FjeSBvbiBtb2Rlcm4gaW4gYSBjcm9zcyBlbmRp
YW4gc2l0dWF0aW9uIGJlY2F1c2Ugb2YgdnJpbmcKPiA+ID4gPiA+IGVuZGlhbi1uZXNzIC4uLgo+
ID4gPiA+IAo+ID4gPiA+IFNvIHRoZSBwcm9ibGVtIHN0aWxsLiBUaGlzIGNhbiBvbmx5IHdvcmsg
d2hlbiB0aGUgaGFyZHdhcmUgY2FuIHN1cHBvcnQKPiA+ID4gPiBsZWdhY3kgdnJpbmcgZW5kaWFu
LW5lc3MuCj4gPiA+ID4gCj4gPiA+ID4gQ29uc2lkZXI6Cj4gPiA+ID4gCj4gPiA+ID4gMSkgdGhl
IGxlYWdjeSBkcml2ZXIgc3VwcG9ydCBpcyBub24tbm9ybWF0aXZlIGluIHRoZSBzcGVjCj4gPiA+
ID4gMikgc3VwcG9ydCBhIHRyYW5zaXRpb25hbCBkZXZpY2UgaW4gdGhlIGtlbnJlbCBtYXkgcmVx
dWlyZXMgdGhlCj4gPiA+ID4gaGFyZHdhcmUKPiA+ID4gPiBzdXBwb3J0IGFuZCBhIGJ1cmRlbiBv
ZiBrZXJuZWwgY29kZXMKPiA+ID4gPiAKPiA+ID4gPiBJJ2QgcmF0aGVyIHNpbXBseSBkcm9wIHRo
ZSBsZWdhY3kgZHJpdmVyIHN1cHBvcnQKPiA+ID4gCj4gPiA+IE15IHBvaW50IGlzIHRoaXMgcGF0
Y2ggZG9lcyBub3QgZHJvcCBsZWdhY3kgc3VwcG9ydC4gSXQgbWVyZWx5IG1hbmRhdGVzCj4gPiA+
IG1vZGVybiBzdXBwb3J0Lgo+ID4gCj4gPiAKPiA+IEkgYW0gbm90IHN1cmUgSSBnZXQgaGVyZS4g
VGhpcyBwYXRjaCBmYWlscyB0aGUgc2V0X2ZlYXR1cmUgaWYgVkVSU0lPTl8xCj4gPiBpcyBub3Qg
bmVnb3RpYXRlZC4gVGhpcyBtZWFuczoKPiA+IAo+ID4gMSkgdkRQQSBwcmVzZW50cyBhIG1vZGVy
biBkZXZpY2UgaW5zdGVhZCBvZiB0cmFuc2l0b25hbCBkZXZpY2UKPiA+IDIpIGxlZ2FjeSBkcml2
ZXIgY2FuJ3QgYmUgcHJvYmVkCj4gPiAKPiA+IFdoYXQgSSdtIG1pc3Npbmc/Cj4gCj4gCj4gSGkg
TWljaGFlbDoKPiAKPiBEbyB5b3UgYWdyZWUgdG8gZmluZCB0aGUgd2F5IHRvIHByZXNlbnQgbW9k
ZXJuIGRldmljZT8gV2UgbmVlZCBhIGNvbmNsdXNpb24KPiB0byBtYWtlIHRoZSBuZXRsaW5rIEFQ
SSB3b3JrIHRvIG1vdmUgZm9yd2FyZC4KPiAKPiBUaGFua3MKCkkgdGhpbmsgd2UgbmVlZCBhIHdh
eSB0byBzdXBwb3J0IGxlZ2FjeSB3aXRoIG5vIGRhdGEgcGF0aCBvdmVyaGVhZC4gcWVtdQpzZXR0
aW5nIFZFUlNJT05fMSBmb3IgYSBsZWdhY3kgZ3Vlc3QgYWZmZWN0cyB0aGUgcmluZyBmb3JtYXQg
c28gaXQgZG9lcwpub3QgcmVhbGx5IHdvcmsuIFRoaXMgc2VlbXMgdG8gcnVsZSBvdXQgZW11bGF0
aW5nIGNvbmZpZyBzcGFjZSBlbnRpcmVseQppbiB1c2Vyc3BhY2UuCgpTbyBJIHRoaW5rIHdlIHNo
b3VsZCBhZGQgYW4gaW9jdGwgYWxvbmcgdGhlIGxpbmVzIG9mCnByb3RvY29sIGZlYXR1cmVzLiBU
aGVuIEkgdGhpbmsgd2UgY2FuIHJlc2VydmUgZmVhdHVyZSBiaXRzCmZvciBjb25maWcgc3BhY2Ug
Zm9ybWF0OiBsZWdhY3kgTEUsIGxlZ2FjeSBCRSwgbW9kZXJuLgoKUXVlcnlpbmcgdGhlIGZlYXR1
cmUgYml0cyB3aWxsIHByb3ZpZGUgdXMgd2l0aCBpbmZvIGFib3V0CndoYXQgZG9lcyB0aGUgZGV2
aWNlIHN1cHBvcnQuIEFja2luZyB0aGVtIHdpbGwgdGVsbCBkZXZpY2UKd2hhdCBkb2VzIGd1ZXN0
IG5lZWQuCgoKCgoKPiAKPiA+IAo+ID4gCj4gPiA+IAo+ID4gPiA+IHRvIGhhdmUgYSBzaW1wbGUg
YW5kIGVhc3kKPiA+ID4gPiBhYnN0YXJjdGlvbiBpbiB0aGUga2VucmVsLiBGb3IgbGVnYWN5IGRy
aXZlciBpbiB0aGUgZ3Vlc3QsCj4gPiA+ID4gaHlwZXJ2aXNvciBpcyBpbgo+ID4gPiA+IGNoYXJn
ZSBvZiB0aGUgbWVkaWF0aW9uOgo+ID4gPiA+IAo+ID4gPiA+IDEpIGNvbmZpZyBzcGFjZSBhY2Nl
c3MgZW5kaWFuIGNvbnZlcnNpb24KPiA+ID4gPiAyKSB1c2luZyBzaGFkb3cgdmlydHF1ZXVlIHRv
IGNoYW5nZSB0aGUgZW5kaWFuIGluIHRoZSB2cmluZwo+ID4gPiA+IAo+ID4gPiA+IFRoYW5rcwo+
ID4gPiBJJ2QgbGlrZSB0byBhdm9pZCBzaGFkb3cgdmlydHF1ZXVlIGhhY2tzIGlmIGF0IGFsbCBw
b3NzaWJsZS4KPiA+ID4gTGFzdCBJIGNoZWNrZWQgcGVyZm9ybWFuY2Ugd2Fzbid0IG11Y2ggYmV0
dGVyIHRoYW4ganVzdCBlbXVsYXRpbmcKPiA+ID4gdmlydGlvIGluIHNvZnR3YXJlLgo+ID4gCj4g
PiAKPiA+IEkgdGhpbmsgdGhlIGxlZ2FjeSBkcml2ZXIgc3VwcG9ydCBpcyBqdXN0IGEgbmljZSB0
byBoYXZlLiBPciBkbyB5b3Ugc2VlCj4gPiBhbnkgdmFsdWUgdG8gdGhhdD8gSSBndWVzcyBmb3Ig
bWVsbGFub3ggYW5kIGludGVsLCBvbmx5IG1vZGVybiBkZXZpY2UgaXMKPiA+IHN1cHBvcnRlZCBp
biB0aGUgaGFyZHdhcmUuCj4gPiAKPiA+IFRoYW5rcwo+ID4gCj4gPiAKPiA+ID4gCj4gPiA+ID4g
PiAKPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+
ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gwqDCoMKgIGluY2x1ZGUvbGludXgvdmRwYS5oIHwg
NiArKysrKysKPiA+ID4gPiA+ID4gPiA+IMKgwqDCoCAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspCj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gPiA+ID4gPiA+ID4gPiBp
bmRleCAwZmVmZWI5NzY4NzcuLmNmZGU0ZWM5OTliNCAxMDA2NDQKPiA+ID4gPiA+ID4gPiA+IC0t
LSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gPiA+ID4gPiA+ID4gPiArKysgYi9pbmNsdWRlL2xp
bnV4L3ZkcGEuaAo+ID4gPiA+ID4gPiA+ID4gQEAgLTYsNiArNiw3IEBACj4gPiA+ID4gPiA+ID4g
PiDCoMKgwqAgI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgo+ID4gPiA+ID4gPiA+ID4gwqDCoMKg
ICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KPiA+ID4gPiA+ID4gPiA+IMKgwqDCoCAjaW5j
bHVkZSA8bGludXgvdmhvc3RfaW90bGIuaD4KPiA+ID4gPiA+ID4gPiA+ICsjaW5jbHVkZSA8dWFw
aS9saW51eC92aXJ0aW9fY29uZmlnLmg+Cj4gPiA+ID4gPiA+ID4gPiDCoMKgwqAgLyoqCj4gPiA+
ID4gPiA+ID4gPiDCoMKgwqDCoCAqIHZEUEEgY2FsbGJhY2sgZGVmaW5pdGlvbi4KPiA+ID4gPiA+
ID4gPiA+IEBAIC0zMTcsNiArMzE4LDExIEBAIHN0YXRpYyBpbmxpbmUgaW50Cj4gPiA+ID4gPiA+
ID4gPiB2ZHBhX3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NAo+ID4g
PiA+ID4gPiA+ID4gZmVhdHVyZXMpCj4gPiA+ID4gPiA+ID4gPiDCoMKgwqAgewo+ID4gPiA+ID4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3Bz
ICpvcHMgPSB2ZGV2LT5jb25maWc7Cj4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgLyog
TWFuZGF0aW5nIDEuMCB0byBoYXZlIHNlbWFudGljcyBvZgo+ID4gPiA+ID4gPiA+ID4gbm9ybWF0
aXZlIHN0YXRlbWVudHMgaW4KPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgICogdGhl
IHNwZWMuICovCj4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgaWYgKCEoZmVhdHVyZXMg
JiBCSVRfVUxMKFZJUlRJT19GX1ZFUlNJT05fMSkpKQo+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiAtRUlOVkFMOwo+ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4g
wqDCoMKgwqDCoMKgwqAgdmRldi0+ZmVhdHVyZXNfdmFsaWQgPSB0cnVlOwo+ID4gPiA+ID4gPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gb3BzLT5zZXRfZmVhdHVyZXModmRldiwg
ZmVhdHVyZXMpOwo+ID4gPiA+ID4gPiA+ID4gwqDCoMKgIH0KPiA+ID4gPiA+ID4gPiA+IC0tIAo+
ID4gPiA+ID4gPiA+ID4gMi4yNS4xCj4gPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
