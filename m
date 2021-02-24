Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AB7C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 05:18:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C7564D9A
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 05:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C7564D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C25224307F;
	Wed, 24 Feb 2021 05:18:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w8nMFy6ma6rZ; Wed, 24 Feb 2021 05:18:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C2A643077;
	Wed, 24 Feb 2021 05:18:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D762DC000B;
	Wed, 24 Feb 2021 05:18:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEFAFC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 05:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A92074EBBE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 05:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZzmIb_wwi1QE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 05:18:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7EB604EBB9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 05:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614143885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+FQbzfl8xPTmpVnSjFrXH2vFi0y7Xcyj00X2gFWzBM=;
 b=DKdgbPfp5+zii2eIIcLMZ3AupauIQm/a7+BJWAqIhgq5q6z/HaYPIoWqWwhU6oD+TOU72o
 hFPXcZs7pzChUi4uxWVUb6wWes485KoH/3LrNO+vA+Z9sw3BEjRzS11nTzz8pjCFw/a/cZ
 W5XD1mSzRALr13dkK/RUFD7+ajuVe/Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-c97QMaImOOWNlx1pyAbJKw-1; Wed, 24 Feb 2021 00:18:03 -0500
X-MC-Unique: c97QMaImOOWNlx1pyAbJKw-1
Received: by mail-wm1-f72.google.com with SMTP id r21so53361wmq.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 21:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=v+FQbzfl8xPTmpVnSjFrXH2vFi0y7Xcyj00X2gFWzBM=;
 b=tN5n4Qd3l8pJDTgXiA7Ol3dmWkCG3jOpFKnhK01aGa10xJ6+8nV2CwhHNg5HUHf3Fz
 zLT8UkNI//SJIBkT2OghHV+F4Yf21L49tSCFSvmeJpwIeLpTpZQc7tObEWFLCPj9yWQA
 JRkqvMAlyCkDN7saMLkQ4KRFDPcsoqPEnldliyyCUyAiybLv5IBHJxQinoyIPvGYL9tw
 BVzxB/MOyGf9xmxIOjmKUqIx2PsOJ8yFDD+vNAMc0Cej1Tp+8jaymBdo6CvjvOfGJRWi
 KAw/O0FFY38yzxSiQ2nEqZyf1KuqkyWNtKZer+QSqfiCBA05+RCPsltUqIELjSMTHuHr
 D6Xg==
X-Gm-Message-State: AOAM532LewQUKdbdGvoAx8jMWuYhIfeDExS6CKHSADDBTUjyaIYbAg6X
 zi8o1DBkJFIwi8X1KU54sMrADv1KMjfjJ5jG5tglBRn3yj65pkj6UXLle5fq0BQfatWSm7bHpIb
 Jk3hXBj/EIFgIFCjPoC2yY0e+NxL5IyWYAVsUo3JxEA==
X-Received: by 2002:a05:6000:108f:: with SMTP id
 y15mr29792487wrw.195.1614143882045; 
 Tue, 23 Feb 2021 21:18:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZj5iXghX2KMaamnnLepYpAma4TuhSeDZ/aKLhkf/u9BKoEKXshIrFgkMUlDiGNv+eKdEvMQ==
X-Received: by 2002:a05:6000:108f:: with SMTP id
 y15mr29792474wrw.195.1614143881889; 
 Tue, 23 Feb 2021 21:18:01 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id z13sm935723wmi.45.2021.02.23.21.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 21:18:01 -0800 (PST)
Date: Wed, 24 Feb 2021 00:17:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210224000528-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <7e6291a4-30b1-6b59-a2bf-713e7b56826d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7e6291a4-30b1-6b59-a2bf-713e7b56826d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org, elic@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMTE6MjA6MDFBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvMjQgMzozNSDkuIrljYgsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gPiAK
PiA+IAo+ID4gT24gMi8yMy8yMDIxIDU6MjYgQU0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToK
PiA+ID4gT24gVHVlLCBGZWIgMjMsIDIwMjEgYXQgMTA6MDM6NTdBTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiBPbiAyMDIxLzIvMjMgOToxMiDkuIrljYgsIFNpLVdlaSBMaXUgd3Jv
dGU6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IE9uIDIvMjEvMjAyMSAxMTozNCBQTSwgTWljaGFlbCBT
LiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBNb24sIEZlYiAyMiwgMjAyMSBhdCAxMjox
NDoxN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIDIwMjEvMi8x
OSA3OjU0IOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IENvbW1pdCA0
NTI2MzlhNjRhZDggKCJ2ZHBhOiBtYWtlIHN1cmUgc2V0X2ZlYXR1cmVzIGlzIGludm9rZWQKPiA+
ID4gPiA+ID4gPiA+IGZvciBsZWdhY3kiKSBtYWRlIGFuIGV4Y2VwdGlvbiBmb3IgbGVnYWN5IGd1
ZXN0cyB0byByZXNldAo+ID4gPiA+ID4gPiA+ID4gZmVhdHVyZXMgdG8gMCwgd2hlbiBjb25maWcg
c3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1cmVzCj4gPiA+ID4gPiA+ID4gPiBhcmUgc2V0
LiBXZSBzaG91bGQgcmVsaWV2ZSB0aGUgdmVyaWZ5X21pbl9mZWF0dXJlcygpIGNoZWNrCj4gPiA+
ID4gPiA+ID4gPiBhbmQgYWxsb3cgZmVhdHVyZXMgcmVzZXQgdG8gMCBmb3IgdGhpcyBjYXNlLgo+
ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiBJdCdzIHdvcnRoIG5vdGluZyB0aGF0IG5v
dCBqdXN0IGxlZ2FjeSBndWVzdHMgY291bGQgYWNjZXNzCj4gPiA+ID4gPiA+ID4gPiBjb25maWcg
c3BhY2UgYmVmb3JlIGZlYXR1cmVzIGFyZSBzZXQuIEZvciBpbnN0YW5jZSwgd2hlbgo+ID4gPiA+
ID4gPiA+ID4gZmVhdHVyZSBWSVJUSU9fTkVUX0ZfTVRVIGlzIGFkdmVydGlzZWQgc29tZSBtb2Rl
cm4gZHJpdmVyCj4gPiA+ID4gPiA+ID4gPiB3aWxsIHRyeSB0byBhY2Nlc3MgYW5kIHZhbGlkYXRl
IHRoZSBNVFUgcHJlc2VudCBpbiB0aGUgY29uZmlnCj4gPiA+ID4gPiA+ID4gPiBzcGFjZSBiZWZv
cmUgdmlydGlvIGZlYXR1cmVzIGFyZSBzZXQuCj4gPiA+ID4gPiA+ID4gVGhpcyBsb29rcyBsaWtl
IGEgc3BlYyB2aW9sYXRpb246Cj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gIgo+ID4gPiA+
ID4gPiA+IAo+ID4gPiA+ID4gPiA+IFRoZSBmb2xsb3dpbmcgZHJpdmVyLXJlYWQtb25seSBmaWVs
ZCwgbXR1IG9ubHkgZXhpc3RzIGlmCj4gPiA+ID4gPiA+ID4gVklSVElPX05FVF9GX01UVSBpcwo+
ID4gPiA+ID4gPiA+IHNldC4KPiA+ID4gPiA+ID4gPiBUaGlzIGZpZWxkIHNwZWNpZmllcyB0aGUg
bWF4aW11bSBNVFUgZm9yIHRoZSBkcml2ZXIgdG8gdXNlLgo+ID4gPiA+ID4gPiA+ICIKPiA+ID4g
PiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBEbyB3ZSByZWFsbHkgd2FudCB0byB3b3JrYXJvdW5kIHRo
aXM/Cj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+IEFuZCBh
bHNvOgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gVGhlIGRyaXZlciBNVVNUIGZvbGxvdyB0aGlz
IHNlcXVlbmNlIHRvIGluaXRpYWxpemUgYSBkZXZpY2U6Cj4gPiA+ID4gPiA+IDEuIFJlc2V0IHRo
ZSBkZXZpY2UuCj4gPiA+ID4gPiA+IDIuIFNldCB0aGUgQUNLTk9XTEVER0Ugc3RhdHVzIGJpdDog
dGhlIGd1ZXN0IE9TIGhhcwo+ID4gPiA+ID4gPiBub3RpY2VkIHRoZSBkZXZpY2UuCj4gPiA+ID4g
PiA+IDMuIFNldCB0aGUgRFJJVkVSIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBrbm93cyBob3cg
dG8gZHJpdmUgdGhlCj4gPiA+ID4gPiA+IGRldmljZS4KPiA+ID4gPiA+ID4gNC4gUmVhZCBkZXZp
Y2UgZmVhdHVyZSBiaXRzLCBhbmQgd3JpdGUgdGhlIHN1YnNldCBvZiBmZWF0dXJlIGJpdHMKPiA+
ID4gPiA+ID4gdW5kZXJzdG9vZCBieSB0aGUgT1MgYW5kIGRyaXZlciB0byB0aGUKPiA+ID4gPiA+
ID4gZGV2aWNlLiBEdXJpbmcgdGhpcyBzdGVwIHRoZSBkcml2ZXIgTUFZIHJlYWQgKGJ1dCBNVVNU
IE5PVCB3cml0ZSkKPiA+ID4gPiA+ID4gdGhlIGRldmljZS1zcGVjaWZpYyBjb25maWd1cmF0aW9u
Cj4gPiA+ID4gPiA+IGZpZWxkcyB0byBjaGVjayB0aGF0IGl0IGNhbiBzdXBwb3J0IHRoZSBkZXZp
Y2UgYmVmb3JlIGFjY2VwdGluZyBpdC4KPiA+ID4gPiA+ID4gNS4gU2V0IHRoZSBGRUFUVVJFU19P
SyBzdGF0dXMgYml0LiBUaGUgZHJpdmVyIE1VU1QgTk9UIGFjY2VwdCBuZXcKPiA+ID4gPiA+ID4g
ZmVhdHVyZSBiaXRzIGFmdGVyIHRoaXMgc3RlcC4KPiA+ID4gPiA+ID4gNi4gUmUtcmVhZCBkZXZp
Y2Ugc3RhdHVzIHRvIGVuc3VyZSB0aGUgRkVBVFVSRVNfT0sgYml0IGlzIHN0aWxsIHNldDoKPiA+
ID4gPiA+ID4gb3RoZXJ3aXNlLCB0aGUgZGV2aWNlIGRvZXMgbm90Cj4gPiA+ID4gPiA+IHN1cHBv
cnQgb3VyIHN1YnNldCBvZiBmZWF0dXJlcyBhbmQgdGhlIGRldmljZSBpcyB1bnVzYWJsZS4KPiA+
ID4gPiA+ID4gNy4gUGVyZm9ybSBkZXZpY2Utc3BlY2lmaWMgc2V0dXAsIGluY2x1ZGluZyBkaXNj
b3Zlcnkgb2YgdmlydHF1ZXVlcwo+ID4gPiA+ID4gPiBmb3IgdGhlIGRldmljZSwgb3B0aW9uYWwg
cGVyLWJ1cyBzZXR1cCwKPiA+ID4gPiA+ID4gcmVhZGluZyBhbmQgcG9zc2libHkgd3JpdGluZyB0
aGUgZGV2aWNl4oCZcyB2aXJ0aW8gY29uZmlndXJhdGlvbgo+ID4gPiA+ID4gPiBzcGFjZSwgYW5k
IHBvcHVsYXRpb24gb2YgdmlydHF1ZXVlcy4KPiA+ID4gPiA+ID4gOC4gU2V0IHRoZSBEUklWRVJf
T0sgc3RhdHVzIGJpdC4gQXQgdGhpcyBwb2ludCB0aGUgZGV2aWNlIGlzIOKAnGxpdmXigJ0uCj4g
PiA+ID4gPiA+IAo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gc28gYWNjZXNzaW5nIGNvbmZpZyBz
cGFjZSBiZWZvcmUgRkVBVFVSRVNfT0sgaXMgYSBzcGVjCj4gPiA+ID4gPiA+IHZpb2xhdGlvbiwg
cmlnaHQ/Cj4gPiA+ID4gPiBJdCBpcywgYnV0IGl0J3Mgbm90IHJlbGV2YW50IHRvIHdoYXQgdGhp
cyBjb21taXQgdHJpZXMgdG8gYWRkcmVzcy4gSQo+ID4gPiA+ID4gdGhvdWdodCB0aGUgbGVnYWN5
IGd1ZXN0IHN0aWxsIG5lZWRzIHRvIGJlIHN1cHBvcnRlZC4KPiA+ID4gPiA+IAo+ID4gPiA+ID4g
SGF2aW5nIHNhaWQsIGEgc2VwYXJhdGUgcGF0Y2ggaGFzIHRvIGJlIHBvc3RlZCB0byBmaXggdGhl
IGd1ZXN0IGRyaXZlcgo+ID4gPiA+ID4gaXNzdWUgd2hlcmUgdGhpcyBkaXNjcmVwYW5jeSBpcyBp
bnRyb2R1Y2VkIHRvCj4gPiA+ID4gPiB2aXJ0bmV0X3ZhbGlkYXRlKCkgKHNpbmNlCj4gPiA+ID4g
PiBjb21taXQgZmUzNmNiZTA2NykuIEJ1dCBpdCdzIG5vdCB0ZWNobmljYWxseSByZWxhdGVkIHRv
IHRoaXMgcGF0Y2guCj4gPiA+ID4gPiAKPiA+ID4gPiA+IC1TaXdlaQo+ID4gPiA+IAo+ID4gPiA+
IEkgdGhpbmsgaXQncyBhIGJ1ZyB0byByZWFkIGNvbmZpZyBzcGFjZSBpbiB2YWxpZGF0ZSwgd2Ug
c2hvdWxkCj4gPiA+ID4gbW92ZSBpdCB0bwo+ID4gPiA+IHZpcnRuZXRfcHJvYmUoKS4KPiA+ID4g
PiAKPiA+ID4gPiBUaGFua3MKPiA+ID4gSSB0YWtlIGl0IGJhY2ssIHJlYWRpbmcgYnV0IG5vdCB3
cml0aW5nIHNlZW1zIHRvIGJlIGV4cGxpY2l0bHkKPiA+ID4gYWxsb3dlZCBieSBzcGVjLgo+ID4g
PiBTbyBvdXIgd2F5IHRvIGRldGVjdCBhIGxlZ2FjeSBndWVzdCBpcyBib2d1cywgbmVlZCB0byB0
aGluayB3aGF0IGlzCj4gPiA+IHRoZSBiZXN0IHdheSB0byBoYW5kbGUgdGhpcy4KPiA+IFRoZW4g
bWF5YmUgcmV2ZXJ0IGNvbW1pdCBmZTM2Y2JlMDY3IGFuZCBmcmllbmRzLCBhbmQgaGF2ZSBRRU1V
IGRldGVjdAo+ID4gbGVnYWN5IGd1ZXN0PyBTdXBwb3NlZGx5IG9ubHkgY29uZmlnIHNwYWNlIHdy
aXRlIGFjY2VzcyBuZWVkcyB0byBiZQo+ID4gZ3VhcmRlZCBiZWZvcmUgc2V0dGluZyBGRUFUVVJF
U19PSy4KPiAKPiAKPiBJIGFncmVlLiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgYWxsIHZEUEEg
bXVzdCBiZSBtb2Rlcm4gZGV2aWNlIChzaW5jZQo+IFZJUklUT19GX0FDQ0VTU19QTEFURk9STSBp
cyBtYW5kYXRlZCkgaW5zdGVhZCBvZiB0cmFuc2l0aW9uYWwgZGV2aWNlLgo+IAo+IFRoYW5rcwoK
V2VsbCBtbHg1IGhhcyBzb21lIGNvZGUgdG8gaGFuZGxlIGxlZ2FjeSBndWVzdHMgLi4uCkVsaSwg
Y291bGQgeW91IGNvbW1lbnQ/IElzIHRoYXQgc3VwcG9ydCB1bnVzZWQgcmlnaHQgbm93PwoKCj4g
Cj4gPiAKPiA+IC1TaXdpZQo+ID4gCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gUmVqZWN0
aW5nIHJlc2V0IHRvIDAKPiA+ID4gPiA+ID4gPiA+IHByZW1hdHVyZWx5IGNhdXNlcyBjb3JyZWN0
IE1UVSBhbmQgbGluayBzdGF0dXMgdW5hYmxlIHRvIGxvYWQKPiA+ID4gPiA+ID4gPiA+IGZvciB0
aGUgdmVyeSBmaXJzdCBjb25maWcgc3BhY2UgYWNjZXNzLCByZW5kZXJpbmcgaXNzdWVzIGxpa2UK
PiA+ID4gPiA+ID4gPiA+IGd1ZXN0IHNob3dpbmcgaW5hY2N1cmF0ZSBNVFUgdmFsdWUsIG9yIGZh
aWx1cmUgdG8gcmVqZWN0Cj4gPiA+ID4gPiA+ID4gPiBvdXQtb2YtcmFuZ2UgTVRVLgo+ID4gPiA+
ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1
OiBBZGQgVkRQQSBkcml2ZXIgZm9yCj4gPiA+ID4gPiA+ID4gPiBzdXBwb3J0ZWQgbWx4NSBkZXZp
Y2VzIikKPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5s
aXVAb3JhY2xlLmNvbT4KPiA+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gwqDCoMKg
IGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDE1ICstLS0tLS0tLS0tLS0tLQo+
ID4gPiA+ID4gPiA+ID4gwqDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTQg
ZGVsZXRpb25zKC0pCj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+ID4gPiA+IGIvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+ID4gPiBpbmRleCA3YzFm
Nzg5Li41NDBkZDY3IDEwMDY0NAo+ID4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL21s
eDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+ID4gPiA+IEBAIC0xNDkwLDE0ICsxNDkwLDYgQEAg
c3RhdGljIHU2NAo+ID4gPiA+ID4gPiA+ID4gbWx4NV92ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkZXYpCj4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
bXZkZXYtPm1seF9mZWF0dXJlczsKPiA+ID4gPiA+ID4gPiA+IMKgwqDCoCB9Cj4gPiA+ID4gPiA+
ID4gPiAtc3RhdGljIGludCB2ZXJpZnlfbWluX2ZlYXR1cmVzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2
ICptdmRldiwKPiA+ID4gPiA+ID4gPiA+IHU2NCBmZWF0dXJlcykKPiA+ID4gPiA+ID4gPiA+IC17
Cj4gPiA+ID4gPiA+ID4gPiAtwqDCoMKgIGlmICghKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9f
Rl9BQ0NFU1NfUExBVEZPUk0pKSkKPiA+ID4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoCByZXR1
cm4gLUVPUE5PVFNVUFA7Cj4gPiA+ID4gPiA+ID4gPiAtCj4gPiA+ID4gPiA+ID4gPiAtwqDCoMKg
IHJldHVybiAwOwo+ID4gPiA+ID4gPiA+ID4gLX0KPiA+ID4gPiA+ID4gPiA+IC0KPiA+ID4gPiA+
ID4gPiA+IMKgwqDCoCBzdGF0aWMgaW50IHNldHVwX3ZpcnRxdWV1ZXMoc3RydWN0IG1seDVfdmRw
YV9uZXQgKm5kZXYpCj4gPiA+ID4gPiA+ID4gPiDCoMKgwqAgewo+ID4gPiA+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgwqAgaW50IGVycjsKPiA+ID4gPiA+ID4gPiA+IEBAIC0xNTU4LDE4ICsxNTUwLDEz
IEBAIHN0YXRpYyBpbnQKPiA+ID4gPiA+ID4gPiA+IG1seDVfdmRwYV9zZXRfZmVhdHVyZXMoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQKPiA+ID4gPiA+ID4gPiA+IGZlYXR1cmVzKQo+ID4g
PiA+ID4gPiA+ID4gwqDCoMKgIHsKPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+ID4gPiA+ID4gPiA+ID4g
wqDCoMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFf
bmRldihtdmRldik7Cj4gPiA+ID4gPiA+ID4gPiAtwqDCoMKgIGludCBlcnI7Cj4gPiA+ID4gPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoCBwcmludF9mZWF0dXJlcyhtdmRldiwgZmVhdHVyZXMsIHRydWUp
Owo+ID4gPiA+ID4gPiA+ID4gLcKgwqDCoCBlcnIgPSB2ZXJpZnlfbWluX2ZlYXR1cmVzKG12ZGV2
LCBmZWF0dXJlcyk7Cj4gPiA+ID4gPiA+ID4gPiAtwqDCoMKgIGlmIChlcnIpCj4gPiA+ID4gPiA+
ID4gPiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPiA+ID4gPiA+ID4gPiA+IC0KPiA+ID4g
PiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcyA9IGZl
YXR1cmVzICYKPiA+ID4gPiA+ID4gPiA+IG5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlczsKPiA+ID4g
PiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIG5kZXYtPmNvbmZpZy5tdHUgPSBjcHVfdG9fbWx4NXZk
cGExNihtdmRldiwgbmRldi0+bXR1KTsKPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIG5k
ZXYtPmNvbmZpZy5zdGF0dXMgfD0gY3B1X3RvX21seDV2ZHBhMTYobXZkZXYsCj4gPiA+ID4gPiA+
ID4gPiBWSVJUSU9fTkVUX1NfTElOS19VUCk7Cj4gPiA+ID4gPiA+ID4gPiAtwqDCoMKgIHJldHVy
biBlcnI7Cj4gPiA+ID4gPiA+ID4gPiArwqDCoMKgIHJldHVybiAwOwo+ID4gPiA+ID4gPiA+ID4g
wqDCoMKgIH0KPiA+ID4gPiA+ID4gPiA+IMKgwqDCoCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0
X2NvbmZpZ19jYihzdHJ1Y3QgdmRwYV9kZXZpY2UKPiA+ID4gPiA+ID4gPiA+ICp2ZGV2LCBzdHJ1
Y3QgdmRwYV9jYWxsYmFjayAqY2IpCj4gPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
