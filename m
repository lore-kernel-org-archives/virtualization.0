Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F94C433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:46:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D1864E2B
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D1864E2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 276D683BF6;
	Wed, 24 Feb 2021 06:46:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YXPHMJviHx42; Wed, 24 Feb 2021 06:46:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D29883BAC;
	Wed, 24 Feb 2021 06:46:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5148DC000A;
	Wed, 24 Feb 2021 06:46:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5807C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D452883BBB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:46:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a1rzxky4TEDD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:46:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C217B83BAC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614149200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SrFMsb94vi7hpDJMqK4fNRwcw8r8Q/1jRcohhOym2YA=;
 b=C7oiWYmwW4uvlzsGKP/ETsjWj7dWLNafhyWPzfXxOj0rQd2tDC3l4+3vaV470Cx1JleWwR
 soAeHcCUo1b01K3fF4YkGPJx3P1DiQ1CpxKDDogo4ACAJXCjEexzJLSzJqLCJ6SmWVOA78
 llYUEphdEa29xFGN4suxAX4zrKCPwxE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-oiDPHSn2NHGfKK3nsoRwPw-1; Wed, 24 Feb 2021 01:46:38 -0500
X-MC-Unique: oiDPHSn2NHGfKK3nsoRwPw-1
Received: by mail-wr1-f70.google.com with SMTP id v18so603149wrr.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 22:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=SrFMsb94vi7hpDJMqK4fNRwcw8r8Q/1jRcohhOym2YA=;
 b=DwdIkRW3sPaYl/+eD8sHpLb8zidyAyWuRd38kaWlUnKw9gqrySZ5fYlLYMC9SEHXjA
 XDGRRJ3b5+GtrnKFGZYfMu/SC0FM/G1271xqRm3Jm5rw+q82McIG+KxCYvyncdnAbyrz
 LgqtJzImyolOZd1Pqhmyyig9bnOTPO152tcqIwNeO0Pt3WFbRusY2cm4s9W0SDV+kXlv
 aJFZhYMcALnIzoH3S7QnkssLwnZfBoYxxbUJPTEmAyaDj4Y52mLZN5vFhcdq7LJh37dw
 ZRAjD2jwNzNUw9L7j48d7ol9BXs6CjPYCTZ+mOruo0Jx4DKnFxNj+O4aAGlENXB3S+le
 t5CQ==
X-Gm-Message-State: AOAM530rcTSM1YXjjm734juxIq1eiqxCzsJwDjjExWL0VPDhLnez4FmL
 Ypt+QCGVAWUhI29B0gJubqxrY9D6gCzprogq94P0uOgKFNp5oYvwuoDviHyNm/ki5PJBjBxbZpl
 KCXH/GbrI0uJTfSpOTIZjLlxqjZOVSvuknsjsQJHkMw==
X-Received: by 2002:adf:d0c5:: with SMTP id z5mr8150866wrh.289.1614149196913; 
 Tue, 23 Feb 2021 22:46:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzH56ZjY0BPRYg8d2IZLXaOZCvuJY0zLzqJIHo7nsxt7nkhq54ic8vvmJMjM6bClgLygBvSBA==
X-Received: by 2002:adf:d0c5:: with SMTP id z5mr8150856wrh.289.1614149196761; 
 Tue, 23 Feb 2021 22:46:36 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id i1sm1141060wmq.12.2021.02.23.22.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 22:46:36 -0800 (PST)
Date: Wed, 24 Feb 2021 01:46:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210224014232-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <0559fd8c-ff44-cb7a-8a74-71976dd2ee33@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0559fd8c-ff44-cb7a-8a74-71976dd2ee33@redhat.com>
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

T24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMDI6MDQ6MzZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvMjQgMTowNCDkuIvljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPiA+IE9uIFR1ZSwgRmViIDIzLCAyMDIxIGF0IDExOjM1OjU3QU0gLTA4MDAsIFNpLVdlaSBM
aXUgd3JvdGU6Cj4gPiA+IAo+ID4gPiBPbiAyLzIzLzIwMjEgNToyNiBBTSwgTWljaGFlbCBTLiBU
c2lya2luIHdyb3RlOgo+ID4gPiA+IE9uIFR1ZSwgRmViIDIzLCAyMDIxIGF0IDEwOjAzOjU3QU0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiBPbiAyMDIxLzIvMjMgOToxMiDkuIrl
jYgsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gPiA+ID4gPiA+IE9uIDIvMjEvMjAyMSAxMTozNCBQTSwg
TWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIE1vbiwgRmViIDIyLCAy
MDIxIGF0IDEyOjE0OjE3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4g
PiBPbiAyMDIxLzIvMTkgNzo1NCDkuIvljYgsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gPiA+ID4gPiA+
ID4gPiA+IENvbW1pdCA0NTI2MzlhNjRhZDggKCJ2ZHBhOiBtYWtlIHN1cmUgc2V0X2ZlYXR1cmVz
IGlzIGludm9rZWQKPiA+ID4gPiA+ID4gPiA+ID4gZm9yIGxlZ2FjeSIpIG1hZGUgYW4gZXhjZXB0
aW9uIGZvciBsZWdhY3kgZ3Vlc3RzIHRvIHJlc2V0Cj4gPiA+ID4gPiA+ID4gPiA+IGZlYXR1cmVz
IHRvIDAsIHdoZW4gY29uZmlnIHNwYWNlIGlzIGFjY2Vzc2VkIGJlZm9yZSBmZWF0dXJlcwo+ID4g
PiA+ID4gPiA+ID4gPiBhcmUgc2V0LiBXZSBzaG91bGQgcmVsaWV2ZSB0aGUgdmVyaWZ5X21pbl9m
ZWF0dXJlcygpIGNoZWNrCj4gPiA+ID4gPiA+ID4gPiA+IGFuZCBhbGxvdyBmZWF0dXJlcyByZXNl
dCB0byAwIGZvciB0aGlzIGNhc2UuCj4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4g
PiBJdCdzIHdvcnRoIG5vdGluZyB0aGF0IG5vdCBqdXN0IGxlZ2FjeSBndWVzdHMgY291bGQgYWNj
ZXNzCj4gPiA+ID4gPiA+ID4gPiA+IGNvbmZpZyBzcGFjZSBiZWZvcmUgZmVhdHVyZXMgYXJlIHNl
dC4gRm9yIGluc3RhbmNlLCB3aGVuCj4gPiA+ID4gPiA+ID4gPiA+IGZlYXR1cmUgVklSVElPX05F
VF9GX01UVSBpcyBhZHZlcnRpc2VkIHNvbWUgbW9kZXJuIGRyaXZlcgo+ID4gPiA+ID4gPiA+ID4g
PiB3aWxsIHRyeSB0byBhY2Nlc3MgYW5kIHZhbGlkYXRlIHRoZSBNVFUgcHJlc2VudCBpbiB0aGUg
Y29uZmlnCj4gPiA+ID4gPiA+ID4gPiA+IHNwYWNlIGJlZm9yZSB2aXJ0aW8gZmVhdHVyZXMgYXJl
IHNldC4KPiA+ID4gPiA+ID4gPiA+IFRoaXMgbG9va3MgbGlrZSBhIHNwZWMgdmlvbGF0aW9uOgo+
ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiAiCj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4g
PiA+ID4gPiA+IFRoZSBmb2xsb3dpbmcgZHJpdmVyLXJlYWQtb25seSBmaWVsZCwgbXR1IG9ubHkg
ZXhpc3RzIGlmCj4gPiA+ID4gPiA+ID4gPiBWSVJUSU9fTkVUX0ZfTVRVIGlzCj4gPiA+ID4gPiA+
ID4gPiBzZXQuCj4gPiA+ID4gPiA+ID4gPiBUaGlzIGZpZWxkIHNwZWNpZmllcyB0aGUgbWF4aW11
bSBNVFUgZm9yIHRoZSBkcml2ZXIgdG8gdXNlLgo+ID4gPiA+ID4gPiA+ID4gIgo+ID4gPiA+ID4g
PiA+ID4gCj4gPiA+ID4gPiA+ID4gPiBEbyB3ZSByZWFsbHkgd2FudCB0byB3b3JrYXJvdW5kIHRo
aXM/Cj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPiA+
IEFuZCBhbHNvOgo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IFRoZSBkcml2ZXIgTVVTVCBm
b2xsb3cgdGhpcyBzZXF1ZW5jZSB0byBpbml0aWFsaXplIGEgZGV2aWNlOgo+ID4gPiA+ID4gPiA+
IDEuIFJlc2V0IHRoZSBkZXZpY2UuCj4gPiA+ID4gPiA+ID4gMi4gU2V0IHRoZSBBQ0tOT1dMRURH
RSBzdGF0dXMgYml0OiB0aGUgZ3Vlc3QgT1MgaGFzIG5vdGljZWQgdGhlIGRldmljZS4KPiA+ID4g
PiA+ID4gPiAzLiBTZXQgdGhlIERSSVZFUiBzdGF0dXMgYml0OiB0aGUgZ3Vlc3QgT1Mga25vd3Mg
aG93IHRvIGRyaXZlIHRoZQo+ID4gPiA+ID4gPiA+IGRldmljZS4KPiA+ID4gPiA+ID4gPiA0LiBS
ZWFkIGRldmljZSBmZWF0dXJlIGJpdHMsIGFuZCB3cml0ZSB0aGUgc3Vic2V0IG9mIGZlYXR1cmUg
Yml0cwo+ID4gPiA+ID4gPiA+IHVuZGVyc3Rvb2QgYnkgdGhlIE9TIGFuZCBkcml2ZXIgdG8gdGhl
Cj4gPiA+ID4gPiA+ID4gZGV2aWNlLiBEdXJpbmcgdGhpcyBzdGVwIHRoZSBkcml2ZXIgTUFZIHJl
YWQgKGJ1dCBNVVNUIE5PVCB3cml0ZSkKPiA+ID4gPiA+ID4gPiB0aGUgZGV2aWNlLXNwZWNpZmlj
IGNvbmZpZ3VyYXRpb24KPiA+ID4gPiA+ID4gPiBmaWVsZHMgdG8gY2hlY2sgdGhhdCBpdCBjYW4g
c3VwcG9ydCB0aGUgZGV2aWNlIGJlZm9yZSBhY2NlcHRpbmcgaXQuCj4gPiA+ID4gPiA+ID4gNS4g
U2V0IHRoZSBGRUFUVVJFU19PSyBzdGF0dXMgYml0LiBUaGUgZHJpdmVyIE1VU1QgTk9UIGFjY2Vw
dCBuZXcKPiA+ID4gPiA+ID4gPiBmZWF0dXJlIGJpdHMgYWZ0ZXIgdGhpcyBzdGVwLgo+ID4gPiA+
ID4gPiA+IDYuIFJlLXJlYWQgZGV2aWNlIHN0YXR1cyB0byBlbnN1cmUgdGhlIEZFQVRVUkVTX09L
IGJpdCBpcyBzdGlsbCBzZXQ6Cj4gPiA+ID4gPiA+ID4gb3RoZXJ3aXNlLCB0aGUgZGV2aWNlIGRv
ZXMgbm90Cj4gPiA+ID4gPiA+ID4gc3VwcG9ydCBvdXIgc3Vic2V0IG9mIGZlYXR1cmVzIGFuZCB0
aGUgZGV2aWNlIGlzIHVudXNhYmxlLgo+ID4gPiA+ID4gPiA+IDcuIFBlcmZvcm0gZGV2aWNlLXNw
ZWNpZmljIHNldHVwLCBpbmNsdWRpbmcgZGlzY292ZXJ5IG9mIHZpcnRxdWV1ZXMKPiA+ID4gPiA+
ID4gPiBmb3IgdGhlIGRldmljZSwgb3B0aW9uYWwgcGVyLWJ1cyBzZXR1cCwKPiA+ID4gPiA+ID4g
PiByZWFkaW5nIGFuZCBwb3NzaWJseSB3cml0aW5nIHRoZSBkZXZpY2XigJlzIHZpcnRpbyBjb25m
aWd1cmF0aW9uCj4gPiA+ID4gPiA+ID4gc3BhY2UsIGFuZCBwb3B1bGF0aW9uIG9mIHZpcnRxdWV1
ZXMuCj4gPiA+ID4gPiA+ID4gOC4gU2V0IHRoZSBEUklWRVJfT0sgc3RhdHVzIGJpdC4gQXQgdGhp
cyBwb2ludCB0aGUgZGV2aWNlIGlzIOKAnGxpdmXigJ0uCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4g
PiA+ID4gCj4gPiA+ID4gPiA+ID4gc28gYWNjZXNzaW5nIGNvbmZpZyBzcGFjZSBiZWZvcmUgRkVB
VFVSRVNfT0sgaXMgYSBzcGVjIHZpb2xhdGlvbiwgcmlnaHQ/Cj4gPiA+ID4gPiA+IEl0IGlzLCBi
dXQgaXQncyBub3QgcmVsZXZhbnQgdG8gd2hhdCB0aGlzIGNvbW1pdCB0cmllcyB0byBhZGRyZXNz
LiBJCj4gPiA+ID4gPiA+IHRob3VnaHQgdGhlIGxlZ2FjeSBndWVzdCBzdGlsbCBuZWVkcyB0byBi
ZSBzdXBwb3J0ZWQuCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBIYXZpbmcgc2FpZCwgYSBzZXBh
cmF0ZSBwYXRjaCBoYXMgdG8gYmUgcG9zdGVkIHRvIGZpeCB0aGUgZ3Vlc3QgZHJpdmVyCj4gPiA+
ID4gPiA+IGlzc3VlIHdoZXJlIHRoaXMgZGlzY3JlcGFuY3kgaXMgaW50cm9kdWNlZCB0byB2aXJ0
bmV0X3ZhbGlkYXRlKCkgKHNpbmNlCj4gPiA+ID4gPiA+IGNvbW1pdCBmZTM2Y2JlMDY3KS4gQnV0
IGl0J3Mgbm90IHRlY2huaWNhbGx5IHJlbGF0ZWQgdG8gdGhpcyBwYXRjaC4KPiA+ID4gPiA+ID4g
Cj4gPiA+ID4gPiA+IC1TaXdlaQo+ID4gPiA+ID4gSSB0aGluayBpdCdzIGEgYnVnIHRvIHJlYWQg
Y29uZmlnIHNwYWNlIGluIHZhbGlkYXRlLCB3ZSBzaG91bGQgbW92ZSBpdCB0bwo+ID4gPiA+ID4g
dmlydG5ldF9wcm9iZSgpLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiBJIHRh
a2UgaXQgYmFjaywgcmVhZGluZyBidXQgbm90IHdyaXRpbmcgc2VlbXMgdG8gYmUgZXhwbGljaXRs
eSBhbGxvd2VkIGJ5IHNwZWMuCj4gPiA+ID4gU28gb3VyIHdheSB0byBkZXRlY3QgYSBsZWdhY3kg
Z3Vlc3QgaXMgYm9ndXMsIG5lZWQgdG8gdGhpbmsgd2hhdCBpcwo+ID4gPiA+IHRoZSBiZXN0IHdh
eSB0byBoYW5kbGUgdGhpcy4KPiA+ID4gVGhlbiBtYXliZSByZXZlcnQgY29tbWl0IGZlMzZjYmUw
NjcgYW5kIGZyaWVuZHMsIGFuZCBoYXZlIFFFTVUgZGV0ZWN0IGxlZ2FjeQo+ID4gPiBndWVzdD8g
U3VwcG9zZWRseSBvbmx5IGNvbmZpZyBzcGFjZSB3cml0ZSBhY2Nlc3MgbmVlZHMgdG8gYmUgZ3Vh
cmRlZCBiZWZvcmUKPiA+ID4gc2V0dGluZyBGRUFUVVJFU19PSy4KPiA+ID4gCj4gPiA+IC1TaXdp
ZQo+ID4gRGV0ZWN0aW5nIGl0IGlzbid0IGVub3VnaCB0aG91Z2gsIHdlIHdpbGwgbmVlZCBhIG5l
dyBpb2N0bCB0byBub3RpZnkKPiA+IHRoZSBrZXJuZWwgdGhhdCBpdCdzIGEgbGVnYWN5IGd1ZXN0
LiBVZ2ggOigKPiAKPiAKPiBJJ20gbm90IHN1cmUgSSBnZXQgdGhpcywgaG93IGNhbiB3ZSBrbm93
IGlmIHRoZXJlJ3MgYSBsZWdhY3kgZHJpdmVyIGJlZm9yZQo+IHNldF9mZWF0dXJlcygpPwoKcWVt
dSBrbm93cyBmb3Igc3VyZS4gSXQgZG9lcyBub3QgY29tbXVuaWNhdGUgdGhpcyBpbmZvcm1hdGlv
biB0byB0aGUKa2VybmVsIHJpZ2h0IG5vdyB1bmZvcnR1bmF0ZWx5LgoKPiBBbmQgSSB3b25kZXIg
d2hhdCB3aWxsIGhhcGVlbiBpZiB3ZSBqdXN0IHJldmVydCB0aGUgc2V0X2ZlYXR1cmVzKDApPwo+
IAo+IFRoYW5rcwo+IAo+IAo+ID4gCj4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gUmVqZWN0aW5nIHJl
c2V0IHRvIDAKPiA+ID4gPiA+ID4gPiA+ID4gcHJlbWF0dXJlbHkgY2F1c2VzIGNvcnJlY3QgTVRV
IGFuZCBsaW5rIHN0YXR1cyB1bmFibGUgdG8gbG9hZAo+ID4gPiA+ID4gPiA+ID4gPiBmb3IgdGhl
IHZlcnkgZmlyc3QgY29uZmlnIHNwYWNlIGFjY2VzcywgcmVuZGVyaW5nIGlzc3VlcyBsaWtlCj4g
PiA+ID4gPiA+ID4gPiA+IGd1ZXN0IHNob3dpbmcgaW5hY2N1cmF0ZSBNVFUgdmFsdWUsIG9yIGZh
aWx1cmUgdG8gcmVqZWN0Cj4gPiA+ID4gPiA+ID4gPiA+IG91dC1vZi1yYW5nZSBNVFUuCj4gPiA+
ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRw
YS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yCj4gPiA+ID4gPiA+ID4gPiA+IHN1cHBvcnRlZCBt
bHg1IGRldmljZXMiKQo+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1
IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4gPiA+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4g
PiA+ID4gPiAgIMKgwqAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMTUgKy0t
LS0tLS0tLS0tLS0tCj4gPiA+ID4gPiA+ID4gPiA+ICAgwqDCoCAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDE0IGRlbGV0aW9ucygtKQo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+
ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+
ID4gPiA+ID4gPiA+ID4gPiBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4g
PiA+ID4gPiA+ID4gPiBpbmRleCA3YzFmNzg5Li41NDBkZDY3IDEwMDY0NAo+ID4gPiA+ID4gPiA+
ID4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+ID4g
PiA+ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+
ID4gPiA+IEBAIC0xNDkwLDE0ICsxNDkwLDYgQEAgc3RhdGljIHU2NAo+ID4gPiA+ID4gPiA+ID4g
PiBtbHg1X3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPiA+ID4g
PiA+ID4gPiA+ID4gICDCoMKgwqDCoMKgwqAgcmV0dXJuIG12ZGV2LT5tbHhfZmVhdHVyZXM7Cj4g
PiA+ID4gPiA+ID4gPiA+ICAgwqDCoCB9Cj4gPiA+ID4gPiA+ID4gPiA+IC1zdGF0aWMgaW50IHZl
cmlmeV9taW5fZmVhdHVyZXMoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+ID4gPiA+ID4g
PiA+ID4gPiB1NjQgZmVhdHVyZXMpCj4gPiA+ID4gPiA+ID4gPiA+IC17Cj4gPiA+ID4gPiA+ID4g
PiA+IC3CoMKgwqAgaWYgKCEoZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX0FDQ0VTU19QTEFU
Rk9STSkpKQo+ID4gPiA+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FT1BOT1RT
VVBQOwo+ID4gPiA+ID4gPiA+ID4gPiAtCj4gPiA+ID4gPiA+ID4gPiA+IC3CoMKgwqAgcmV0dXJu
IDA7Cj4gPiA+ID4gPiA+ID4gPiA+IC19Cj4gPiA+ID4gPiA+ID4gPiA+IC0KPiA+ID4gPiA+ID4g
PiA+ID4gICDCoMKgIHN0YXRpYyBpbnQgc2V0dXBfdmlydHF1ZXVlcyhzdHJ1Y3QgbWx4NV92ZHBh
X25ldCAqbmRldikKPiA+ID4gPiA+ID4gPiA+ID4gICDCoMKgIHsKPiA+ID4gPiA+ID4gPiA+ID4g
ICDCoMKgwqDCoMKgwqAgaW50IGVycjsKPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTE1NTgsMTggKzE1
NTAsMTMgQEAgc3RhdGljIGludAo+ID4gPiA+ID4gPiA+ID4gPiBtbHg1X3ZkcGFfc2V0X2ZlYXR1
cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTY0Cj4gPiA+ID4gPiA+ID4gPiA+IGZlYXR1
cmVzKQo+ID4gPiA+ID4gPiA+ID4gPiAgIMKgwqAgewo+ID4gPiA+ID4gPiA+ID4gPiAgIMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsKPiA+
ID4gPiA+ID4gPiA+ID4gICDCoMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYg
PSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4gPiA+ID4gPiA+ID4gPiA+IC3CoMKgwqAgaW50
IGVycjsKPiA+ID4gPiA+ID4gPiA+ID4gICDCoMKgwqDCoMKgwqAgcHJpbnRfZmVhdHVyZXMobXZk
ZXYsIGZlYXR1cmVzLCB0cnVlKTsKPiA+ID4gPiA+ID4gPiA+ID4gLcKgwqDCoCBlcnIgPSB2ZXJp
ZnlfbWluX2ZlYXR1cmVzKG12ZGV2LCBmZWF0dXJlcyk7Cj4gPiA+ID4gPiA+ID4gPiA+IC3CoMKg
wqAgaWYgKGVycikKPiA+ID4gPiA+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiBlcnI7
Cj4gPiA+ID4gPiA+ID4gPiA+IC0KPiA+ID4gPiA+ID4gPiA+ID4gICDCoMKgwqDCoMKgwqAgbmRl
di0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzID0gZmVhdHVyZXMgJgo+ID4gPiA+ID4gPiA+ID4gPiBu
ZGV2LT5tdmRldi5tbHhfZmVhdHVyZXM7Cj4gPiA+ID4gPiA+ID4gPiA+ICAgwqDCoMKgwqDCoMKg
IG5kZXYtPmNvbmZpZy5tdHUgPSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwgbmRldi0+bXR1KTsK
PiA+ID4gPiA+ID4gPiA+ID4gICDCoMKgwqDCoMKgwqAgbmRldi0+Y29uZmlnLnN0YXR1cyB8PSBj
cHVfdG9fbWx4NXZkcGExNihtdmRldiwKPiA+ID4gPiA+ID4gPiA+ID4gVklSVElPX05FVF9TX0xJ
TktfVVApOwo+ID4gPiA+ID4gPiA+ID4gPiAtwqDCoMKgIHJldHVybiBlcnI7Cj4gPiA+ID4gPiA+
ID4gPiA+ICvCoMKgwqAgcmV0dXJuIDA7Cj4gPiA+ID4gPiA+ID4gPiA+ICAgwqDCoCB9Cj4gPiA+
ID4gPiA+ID4gPiA+ICAgwqDCoCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0X2NvbmZpZ19jYihz
dHJ1Y3QgdmRwYV9kZXZpY2UKPiA+ID4gPiA+ID4gPiA+ID4gKnZkZXYsIHN0cnVjdCB2ZHBhX2Nh
bGxiYWNrICpjYikKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
