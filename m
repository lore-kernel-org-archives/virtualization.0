Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648C9ECAAA1
	for <virtualization@archiver.kernel.org>; Tue, 30 Aug 2022 22:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DEA7840193;
	Tue, 30 Aug 2022 22:02:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DEA7840193
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DAidZYQL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Obk0VoBIguOL; Tue, 30 Aug 2022 22:02:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 616FC40A9F;
	Tue, 30 Aug 2022 22:02:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 616FC40A9F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21774C0032;
	Tue, 30 Aug 2022 22:02:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBCDCC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 22:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CC1F82925
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 22:02:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CC1F82925
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DAidZYQL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3GodBO8y_Dr2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 22:02:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D46C8291D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D46C8291D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 22:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661896921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=niKK6Em97xEuZCk7i+SitS0TpBbaJZedtrfzlYGJFCI=;
 b=DAidZYQLrufjhNwqFHY9KYat39y0M4DSawGIqVJIQCInEDbuka014BGgW05mpFUblj0xvB
 e9TwpWbh2O0+/kyXg0pf3kwSDYV1G6CarWFYNvXucOieL9z+gvdwwJQrLyK4lgkHG429Y5
 rzBxldIBlrIQTOnYVQRYtoh/Ay2Z8kc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-196-36ljd_N-OgKyv5GoC62QEQ-1; Tue, 30 Aug 2022 18:01:59 -0400
X-MC-Unique: 36ljd_N-OgKyv5GoC62QEQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 i7-20020a1c3b07000000b003a534ec2570so10709253wma.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 15:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=niKK6Em97xEuZCk7i+SitS0TpBbaJZedtrfzlYGJFCI=;
 b=He35/sdSDS5U6wt7yK2TMREG1iFy6XoSdYnb0Jg8iLs8MJ3FW8HttzxThw97GNpo0n
 XftpweelcMpknPt3CcpE0dRui0P9DWgyGSWe9fic1tXW9CTN3kDodKgewuyyBjnKuq22
 XAcbcTv1BGzn9oNBmHHM9VxWTRzK+N1WxRUAGWSKz1YfgPomTQu8L/ExXoYCXi7hipOc
 3HrNYUUTpTGYnyfQzdqFXb/h9JvwRzrvDtYAYi0i3BPsQi5NeLvM/0fhQo4lp4gNjpCU
 KqmPqZLz2a1lBpsvOo3mdFAtefJ7pD4vsIXwYARvw1P/53z8IsN6k7y0t8cJHMhgIe+R
 CWWg==
X-Gm-Message-State: ACgBeo3dE4sUYVzWecRLecqyW2lxftMpSqDgSCngtyXvYnBN80g7iF5P
 p4szzh8zCoPWXN+oEYL519s7x2TBmuCu1p2AOiGBveH/FciXLZTWscAJvtRCk29PUr5y5ijE2zQ
 YIBJ8Lg396PSo2gzXi9IDac6L/AR892P7BlgQ5MWnIw==
X-Received: by 2002:a05:600c:6009:b0:3a5:b069:5d34 with SMTP id
 az9-20020a05600c600900b003a5b0695d34mr35190wmb.115.1661896917657; 
 Tue, 30 Aug 2022 15:01:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7+HjTeGfMX3x3prZqb704Qi0ORuwkQtZkamWHUQSNQsm6v29xQEOF5ZqORPAGl/IsPpTHTBA==
X-Received: by 2002:a05:600c:6009:b0:3a5:b069:5d34 with SMTP id
 az9-20020a05600c600900b003a5b0695d34mr35169wmb.115.1661896917315; 
 Tue, 30 Aug 2022 15:01:57 -0700 (PDT)
Received: from redhat.com ([2.55.191.225]) by smtp.gmail.com with ESMTPSA id
 m9-20020a05600c4f4900b003a84375d0d1sm30633wmq.44.2022.08.30.15.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Aug 2022 15:01:56 -0700 (PDT)
Date: Tue, 30 Aug 2022 18:01:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: RFC: control virtqueue size by the vdpa tool
Message-ID: <20220830180119-mutt-send-email-mst@kernel.org>
References: <DM8PR12MB5400FEB0322A9FD6B3271D45AB799@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220830154938-mutt-send-email-mst@kernel.org>
 <7460d7c7-5b44-661f-7763-3e7a6a15f138@oracle.com>
MIME-Version: 1.0
In-Reply-To: <7460d7c7-5b44-661f-7763-3e7a6a15f138@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "eperezma@redhat.com" <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCBBdWcgMzAsIDIwMjIgYXQgMDI6MDQ6NTVQTSAtMDcwMCwgU2ktV2VpIExpdSB3cm90
ZToKPiAKPiAKPiBPbiA4LzMwLzIwMjIgMTI6NTggUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPiA+IE9uIFR1ZSwgQXVnIDMwLCAyMDIyIGF0IDA2OjIyOjMxQU0gKzAwMDAsIEVsaSBDb2hl
biB3cm90ZToKPiA+ID4gCj4gPiA+IEhpLAo+ID4gPiAKPiA+ID4gCj4gPiA+IEkgaGF2ZSBiZWVu
IGV4cGVyaW1lbnRpbmcgd2l0aCBkaWZmZXJlbnQgcXVldWUgc2l6ZXMgd2l0aCBtbHg1X3ZkcGEg
YW5kIG5vdGljZWQKPiA+ID4gdGhhdCBxdWV1ZSBzaXplIGNhbiBhZmZlY3QgcGVyZm9ybWFuY2Uu
Cj4gPiA+IAo+ID4gPiBJIHdvdWxkIGxpa2UgdG8gcHJvcG9zZSBhbiBleHRlbnNpb24gdG8gdmRw
YSB0b29sIHRvIGFsbG93IHRvIHNwZWNpZnkgdGhlIHF1ZXVlCj4gPiA+IHNpemUuIFZhbGlkIHZh
bHVlcyB3aWxsIGNvbmZvcm0gdG8gdGhlIG1heCBvZiAzMjc2OCBzcGVjaWZpZWQgYnkgdGhlIHNw
ZWMuCj4gPiA+IAo+ID4gPiAKPiA+ID4g4oCcdmRwYSBtZ210ZGV2IHNob3figJ0gd2lsbCBoYXZl
IGFub3RoZXIgbGluZSBzcGVjaWZ5aW5nIHRoZSB2YWxpZCByYW5nZSBmb3IgYQo+ID4gPiBtYW5h
Z2VtZW50IGRldmljZSB3aGljaCBjb3VsZCBiZSBuYXJyb3dlciB0aGFuIHRoZSBzcGVjIGFsbG93
cy4gVGhpcyByYW5nZSB3aWxsCj4gPiA+IGJlIHZhbGlkIGZvciBkYXRhIHF1ZXVlcyBvbmx5IChu
b3QgZm9yIGNvbnRyb2wgVlEpLgo+ID4gPiAKPiA+ID4gQW5vdGhlciBsaW5lIHdpbGwgZGlzcGxh
eSB0aGUgZGVmYXVsdCBxdWV1ZSBzaXplCj4gPiA+IAo+ID4gPiAKPiA+ID4gRXhhbXBsZToKPiA+
ID4gCj4gPiA+ICQgdmRwYSBtZ210ZGV2IHNob3cKPiA+ID4gCj4gPiA+IGF1eGlsaWFyeS9tbHg1
X2NvcmUuc2YuNjoKPiA+ID4gCj4gPiA+ICAgIHN1cHBvcnRlZF9jbGFzc2VzIG5ldAo+ID4gPiAK
PiA+ID4gICAgbWF4X3N1cHBvcnRlZF92cXMgNjUKPiA+ID4gCj4gPiA+ICAgIGRldl9mZWF0dXJl
cyBDU1VNIEdVRVNUX0NTVU0gTVRVIEhPU1RfVFNPNCBIT1NUX1RTTzYgU1RBVFVTIENUUkxfVlEg
Q1RSTF9WTEFOCj4gPiA+IE1RIENUUkxfTUFDX0FERFIgVkVSU0lPTl8xIEFDQ0VTU19QTEFURk9S
TQo+ID4gPiAKPiA+ID4gICAgZGF0YSBxdWV1ZSByYW5nZSAyNTYtNDA5Ngo+ID4gPiAKPiA+ID4g
ICAgZGVmYXVsdCBxdWV1ZSBzaXplIDI1Ngo+ID4gPiAKPiA+ID4gCj4gPiA+IFdoZW4geW91IGNy
ZWF0ZSB0aGUgdmRwYSBkZXZpY2UgeW91IGNhbiBzcGVjaWZ5IHRoZSByZXF1ZXN0ZWQgdmFsdWU6
Cj4gPiA+IAo+ID4gPiAkIHZkcGEgZGV2IGFkZCBuYW1lIHZkcGEtYSBtZ210ZGV2IGF1eGlsaWFy
eS9tbHg1X2NvcmUuc2YuNiBtYXhfdnFwIDEgbXR1IDkwMDAKPiA+ID4gcXVldWVfc2l6ZSAxMDI0
Cj4gPiA+IAo+ID4gCj4gPiBBIGZvbGxvdyB1cCBxdWVzdGlvbjogaXNuJ3QgaXQgZW5vdWdoIHRv
IGNvbnRyb2wgdGhlIHNpemUKPiA+IGZyb20gcWVtdT8gZG8gd2UgbmVlZCBhYmlsaXR5IHRvIGNv
bnRyb2wgaXQgYXQgdGhlIGtlcm5lbCBsZXZlbD8KPiA+IAo+IFJpZ2h0LCBJIHRoaW5rIHRvZGF5
IHdlIGNhbiBvcHRpb25hbGx5IGNvbnRyb2wgdGhlIHF1ZXVlIHNpemUgZnJvbSBxZW11IHZpYQo+
IHJ4X3F1ZXVlX3NpemUgb3IgdHhfcXVldWVfc2l6ZSwgYnV0IGl0IGhhcyBhIGxpbWl0IG9mIDEw
MjQgKGJ0dyB3aHkgaXQgaGFzCj4gc3VjaCBsaW1pdCwgd2hpY2ggaXMgcmVsYXRpdmVseSBsb3dl
ciBpbiBteSBvcGluaW9uKS4gSSB0aGluayB3aGF0IHdhcwo+IG1pc3NpbmcgZm9yIFFFTVUgaXMg
dG8gcXVlcnkgdGhlIG1heCBudW1iZXIgb2YgcXVldWUgc2l6ZSB0aGF0IHRoZSBoYXJkd2FyZQo+
IGNhbiBzdXBwb3J0IGZyb20gdGhlIGJhY2tlbmQuCj4gCj4gLVNpd2VpCj4gCgpva2F5IHN1cmUu
IG15IHF1ZXN0aW9uIGlzIGhvdyBpbXBvcnRhbnQgaXMgaXQgdG8gY29udHJvbCBpdCBpbiB0aGUK
a2VybmVsPwoKLS0gCk1TVAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
