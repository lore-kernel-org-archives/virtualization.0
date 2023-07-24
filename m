Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08FEC001B0
	for <virtualization@archiver.kernel.org>; Mon, 24 Jul 2023 09:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69A2260EAB;
	Mon, 24 Jul 2023 09:16:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69A2260EAB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SihXq1gh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c5f0Lc7BHHJe; Mon, 24 Jul 2023 09:16:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CEE9A60B25;
	Mon, 24 Jul 2023 09:16:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CEE9A60B25
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 973ECC0072;
	Mon, 24 Jul 2023 09:16:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5179DC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 09:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 271B240AA1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 09:16:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 271B240AA1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SihXq1gh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QiOgFYu5aWpu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 09:16:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C78E540465
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 09:16:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C78E540465
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690190191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icRPVMyvz00tO2C7RCJF1Tux1aykT12dt3mhAkPzG2Q=;
 b=SihXq1ghOuWfXab+3414j8fYBPTivasO9/EMvlkERDJRo7AMGXcnoa/j/FQSBt2GEtzM+R
 Y1zN9ej2etiTtiBqUq5Syet9RLY7ZcqfHsWYb15vElfO4ZXv6ERTACTrI8kuCqD3xq+ZFm
 ywxEaJbbsYqGgEcmdVHtJP/Cq9y7O58=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-UjioWR3VNBGCbfVitDDGVw-1; Mon, 24 Jul 2023 05:16:30 -0400
X-MC-Unique: UjioWR3VNBGCbfVitDDGVw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbe590234aso24854375e9.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 02:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690190189; x=1690794989;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=icRPVMyvz00tO2C7RCJF1Tux1aykT12dt3mhAkPzG2Q=;
 b=Gw6ZGslQieLq/7zyemydCcHzBo0Vb2lxebeCSdQrW+IHlvUJAXlNjyI2HEwRcv9J4U
 sJuI2oC3oPZu/ZJJa+JY8LFcsiowZI+/t4xkLUok6yn0wOeu1ETY0wgHaLgrDnqRVXqC
 kfgFRMtqL7xueoDefj1jX/GwX5auP1G1whQTCEf/PFoCB8Kq7EaShB5pTd/FZOsOEG62
 Mur/jVkJWokLIc1hl+tLrxiNTvgI26ImyaGNp+Mx7DyVSjmzZVwGTeyD52MMxSx5aT/B
 +8eO5h/BHg/UyX+QI0KWxUs+pgMyXqVPaBRzpUePfbvRzfROx2u4+ZseDSwoMNmR2V/x
 G7Rw==
X-Gm-Message-State: ABy/qLaJ0mPcuYL41idNPKMtcAMhMkJD8GUIC4g3o5EhPiJPQMOFDkUO
 PIMvb1VLT792NT76VhLPQKMp366zGtS6aOERgmDgUBv6CzchHnSMS0FvuSiKwLtzn1flMFkuY08
 UHQ/I4ZVOiZoICje51tYTJyIm8dfZOKP5en0w/C7+KQ==
X-Received: by 2002:a7b:c8cc:0:b0:3fb:a100:2581 with SMTP id
 f12-20020a7bc8cc000000b003fba1002581mr7384036wml.14.1690190189043; 
 Mon, 24 Jul 2023 02:16:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEyl2PbEYyYEdIUkJYNgJkkvw8hwzDzPetupE0xaqyfvR+woA7PyBQlcGetBSagDtFB50Mn8Q==
X-Received: by 2002:a7b:c8cc:0:b0:3fb:a100:2581 with SMTP id
 f12-20020a7bc8cc000000b003fba1002581mr7384013wml.14.1690190188706; 
 Mon, 24 Jul 2023 02:16:28 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e0:3800:a16e:b2a0:7d06:58aa])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a7bcd0e000000b003fc01f7b415sm12536095wmj.39.2023.07.24.02.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 02:16:27 -0700 (PDT)
Date: Mon, 24 Jul 2023 05:16:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length check
Message-ID: <20230724050005-mutt-send-email-mst@kernel.org>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
 <20230723050656-mutt-send-email-mst@kernel.org>
 <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
 <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
 <20230723055820-mutt-send-email-mst@kernel.org>
 <CACGkMEuGHMu6te3jRfEhhwTrWR1mpqp3hbVhDKQiXK9tgwz3qw@mail.gmail.com>
 <56aa7d5c6d5840aedef83d3dc39f0bb3162bbb58.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <56aa7d5c6d5840aedef83d3dc39f0bb3162bbb58.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Eli Cohen <elic@nvidia.com>,
 "linma@zju.edu.cn" <linma@zju.edu.cn>
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

T24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMDg6Mzg6MDRBTSArMDAwMCwgRHJhZ29zIFRhdHVsZWEg
d3JvdGU6Cj4gCj4gT24gTW9uLCAyMDIzLTA3LTI0IGF0IDE1OjExICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gT24gU3VuLCBKdWwgMjMsIDIwMjMgYXQgNjowMuKAr1BNIE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiAKPiA+ID4gT24gU3VuLCBKdWwg
MjMsIDIwMjMgYXQgMDU6NDg6NDZQTSArMDgwMCwgTGluIE1hIHdyb3RlOgo+ID4gPiA+IAo+ID4g
PiA+ID4gU3VyZSwgdGhhdCBpcyBhbm90aGVyIHVuZGVyZ29pbmcgdGFzayBJJ20gd29ya2luZyBv
bi4gSWYgdGhlIG5sYXR0ciBpcwo+ID4gPiA+ID4gcGFyc2VkIHdpdGgKPiA+ID4gPiA+IE5MX1ZB
TElEQVRFX1VOU1BFQywgYW55IGZvcmdvdHRlbiBubGF0dHIgd2lsbCBiZSByZWplY3RlZCwgdGhl
cmVmb3JlCj4gPiA+ID4gPiAod2hpY2ggaXMgdGhlIGRlZmF1bHQKPiA+ID4gPiA+IGZvciBtb2Rl
cm4gbmxhX3BhcnNlKS4KPiA+ID4gPiAKPiA+ID4gPiBGb3IgdGhlIGdlbmVyYWwgbmV0bGluayBp
bnRlcmZhY2UsIHRoZSBkZWNpZGluZyBmbGFnIHNob3VsZCBiZQo+ID4gPiA+IGdlbmxfb3BzLnZh
bGlkYXRlIGRlZmluZWQgaW4KPiA+ID4gPiBlYWNoIG9wcy4gVGhlIGRlZmF1bHQgdmFsaWRhdGUg
ZmxhZyBpcyBzdHJpY3QsIHdoaWxlIHRoZSBkZXZlbG9wZXIgY2FuCj4gPiA+ID4gb3ZlcndyaXRl
IHRoZSBmbGFnCj4gPiA+ID4gd2l0aCBHRU5MX0RPTlRfVkFMSURBVEVfU1RSSUNUIHRvIGVhc2Ug
dGhlIHZhbGlkYXRpb24uIFRoYXQgaXMgdG8gc2F5LAo+ID4gPiA+IHNhZmVyIGNvZGUgc2hvdWxk
Cj4gPiA+ID4gZW5mb3JjZSBOTF9WQUxJREFURV9TVFJJQ1QgYnkgbm90IG92ZXJ3cml0aW5nIHRo
ZSB2YWxpZGF0ZSBmbGFnLgo+ID4gPiA+IAo+ID4gPiA+IFJlZ3JhZHMKPiA+ID4gPiBMaW4KPiA+
ID4gCj4gPiA+IAo+ID4gPiBPaCBJIHNlZS4KPiA+ID4gCj4gPiA+IEl0IHN0YXJ0ZWQgaGVyZToK
PiA+ID4gCj4gPiA+IGNvbW1pdCAzM2IzNDc1MDNmMDE0ZWJmNzYyNTczMjdjYmM3MDAxYzZiNzIx
OTU2Cj4gPiA+IEF1dGhvcjogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPgo+ID4gPiBE
YXRlOsKgwqAgVHVlIEphbiA1IDEyOjMyOjAwIDIwMjEgKzAyMDAKPiA+ID4gCj4gPiA+IMKgwqDC
oCB2ZHBhOiBEZWZpbmUgdmRwYSBtZ210IGRldmljZSwgb3BzIGFuZCBhIG5ldGxpbmsgaW50ZXJm
YWNlCj4gPiA+IAo+ID4gPiB3aGljaCBkaWQ6Cj4gPiA+IAo+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAudmFsaWRhdGUgPSBHRU5MX0RPTlRfVkFMSURBVEVfU1RSSUNUIHwKPiA+
ID4gR0VOTF9ET05UX1ZBTElEQVRFX0RVTVAsCj4gPiA+IAo+ID4gPiAKPiA+ID4gd2hpY2ggd2Fz
IG1vc3QgbGlrZWx5IGp1c3QgYSBjb3B5IHBhc3RlIGZyb20gc29tZXdoZXJlLCByaWdodCBQYXJh
dj8KPiA+ID4gCj4gPiA+IGFuZCB0aGVuIGV2ZXJ5b25lIGtlcHQgY29weWluZyB0aGlzIGFyb3Vu
ZC4KPiA+ID4gCj4gPiA+IFBhcmF2LCBFbGkgY2FuIHdlIGRyb3AgdGhlc2U/IFRoZXJlJ3MgYSB0
aW55IGNoYW5jZSBvZiBicmVha2luZyBzb21ldGhpbmcKPiA+ID4gYnV0IEkgZmVlbCB0aGVyZSBh
cmVuJ3QgdGhhdCBtYW55IHVzZXJzIG91dHNpZGUgbWx4NSB5ZXQsIHNvIGlmIHlvdQo+ID4gPiBn
dXlzIGNhbiB0ZXN0IG9uIG1seDUgYW5kIGNvbmZpcm0gbm8gYnJlYWthZ2UsIEkgdGhpbmsgd2Ug
YXJlIGdvb2QuCj4gPiAKPiA+IEFkZGluZyBEcmFnb3MuCj4gPiAKPiBJIHdpbGwgY2hlY2suIEp1
c3QgdG8gbWFrZSBzdXJlIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHk6IHlvdSB3YW50IG1lIHRvIGRy
b3AgdGhlCj4gLnZhbGlkYXRlIGZsYWdzIGFsbCB0b2dldGhlciBpbiBhbGwgdmRwYSBvcHMgYW5k
IGNoZWNrLCByaWdodD8KPiAKPiBUaGFua3MsCj4gRHJhZ29zCgp5ZXMgLSBJIHN1c3BlY3QgeW91
IHdpbGwgdGhlbiBuZWVkIHRoaXMgcGF0Y2ggdG8gbWFrZSB0aGluZ3Mgd29yay4KCi0tIApNU1QK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
