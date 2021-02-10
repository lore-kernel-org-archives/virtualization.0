Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F4CC433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 12:12:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AFF064E31
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 12:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFF064E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB79E6F600
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 12:12:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id InMMcNKZzscp for <virtualization@archiver.kernel.org>;
	Wed, 10 Feb 2021 12:12:46 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id D41EC6F4B9; Wed, 10 Feb 2021 12:12:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADE806ED1C;
	Wed, 10 Feb 2021 12:12:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81B5EC0174;
	Wed, 10 Feb 2021 12:12:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AFABC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 12:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 09F1A87148
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 12:12:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BYiwMsOAWjA6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 12:12:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3FDA08712C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 12:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612959158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fo185b+KWk8zT3SUUKGeVFpd35TVy7HrhZIt8uxdMU0=;
 b=dTllJmQc5kfX0b4uf8MeyCdNs00B0+63FDox50ON0vH2KozQoOUZ3C9tM+SIVru+Vdh38N
 wfjt/U3B2x4kZtEqW4uS+Kq9QIMA7nNhee6T5TxkNxdjaNI1Z5piko99Qd91x10+TCiqLs
 6kYUNHW6Y1/HRQAzA8z73H9JkZHci7o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-HZR9gaNZMQGtUnYN1aUNZQ-1; Wed, 10 Feb 2021 07:12:36 -0500
X-MC-Unique: HZR9gaNZMQGtUnYN1aUNZQ-1
Received: by mail-wm1-f70.google.com with SMTP id y18so1271639wma.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=fo185b+KWk8zT3SUUKGeVFpd35TVy7HrhZIt8uxdMU0=;
 b=AiQBfwrFCTJB/uTSigYi6n0dKbiSajSySELvlrWldY1EN4hpNEtYaoINPVUEglrdY2
 6sDKSouem9A/saUdiYXKVGVOpPUh3uJ83N9ZJ0JtwpNj3ngM0sp2sTfQOYY/B6K9jgSM
 WebYyFPhhVt86oJGN9DUZzsxoRGeqBtYb4d4pScfb81RrOMPYO34rGYe7DmltGwQuUma
 uOtNT1MJk8sCvkuj6HM/PAg1PNhjdkXRCOtxu6cND+J8KUdKM/yQejqcSbMvqnbDnaWH
 /O0/nPBtl88uc73TZjLGVjeskknrbUoxe9FKps2+pDYpbtLLZWZlEVgkAIOjAWgixtNA
 1BSg==
X-Gm-Message-State: AOAM530e0d7mqtiDy95Mu846KsKc9D43SKXQaJLuYhoec8Q6qKH3FYGl
 kqqqdnniLjy6pD3G4LyNRJpImwB/Ie47+O3jWTeqWyfE41M4YsrfxT8znXQ4F0UoR6xm7CYEhoy
 W4YARKCxS93babakK2L9C+fuC0VhAtOCcPMwQOQHICw==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr2730116wma.132.1612959155134; 
 Wed, 10 Feb 2021 04:12:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqJ1zRXwLt0V7vMoyUlpyzWYnYnT3tXF+r0Hdj1LTI3bX10t05o4NRDt3JSbViSeLbfsdcxQ==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr2730098wma.132.1612959154945; 
 Wed, 10 Feb 2021 04:12:34 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id w4sm2695060wrt.69.2021.02.10.04.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Feb 2021 04:12:34 -0800 (PST)
Date: Wed, 10 Feb 2021 07:12:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210210071129-mutt-send-email-mst@kernel.org>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210209054302.GA210455@mtl-vdi-166.wap.labs.mlnx>
 <20210209090014.xolf5kxri3xdmacz@steredhat>
 <cdd75885-3610-8685-14f3-5467a8ef1501@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cdd75885-3610-8685-14f3-5467a8ef1501@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

T24gV2VkLCBGZWIgMTAsIDIwMjEgYXQgMTI6MTc6MTlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvOSDkuIvljYg1OjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4gPiBPbiBUdWUsIEZlYiAwOSwgMjAyMSBhdCAwNzo0MzowMkFNICswMjAwLCBFbGkgQ29oZW4g
d3JvdGU6Cj4gPiA+IE9uIE1vbiwgRmViIDA4LCAyMDIxIGF0IDA1OjE3OjQxUE0gKzAxMDAsIFN0
ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiA+ID4gPiBJdCdzIGxlZ2FsIHRvIGhhdmUgJ29mZnNl
dCArIGxlbicgZXF1YWwgdG8KPiA+ID4gPiBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmln
KSwgc2luY2UgJ25kZXYtPmNvbmZpZycgaXMgYQo+ID4gPiA+ICdzdHJ1Y3QgdmlydGlvX25ldF9j
b25maWcnLCBzbyB3ZSBjYW4gc2FmZWx5IGNvcHkgaXRzIGNvbnRlbnQgdW5kZXIKPiA+ID4gPiB0
aGlzIGNvbmRpdGlvbi4KPiA+ID4gPiAKPiA+ID4gPiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRw
YS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZAo+ID4gPiA+IG1seDUgZGV2aWNl
cyIpCj4gPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gPiA+IAo+ID4g
PiBBY2tlZC1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4gPiA+IAo+ID4gPiBCVFcs
IHNhbWUgZXJyb3IgaW4gdmRwYV9zaW0geW91IG1heSB3YW50IHRvIGZpeC4KPiA+ID4gCj4gPiAK
PiA+IENvbW1pdCA2NWI3MDk1ODZlMjIgKCJ2ZHBhX3NpbTogYWRkIGdldF9jb25maWcgY2FsbGJh
Y2sgaW4KPiA+IHZkcGFzaW1fZGV2X2F0dHIiKSB1bmludGVudGlvbmFsbHkgc29sdmVkIGl0Lgo+
ID4gCj4gPiBTaW5jZSBpdCdzIGEgc2ltdWxhdG9yLCBtYXliZSB3ZSBjYW4gYXZvaWQgc29sdmlu
ZyBpdCBpbiB0aGUgc3RhYmxlCj4gPiBicmFuY2hlcy4gT3IgZG9lcyBpdCBtYXR0ZXI/Cj4gCj4g
Cj4gSSB0aGluayBub3QsIHNpbmNlIHRoZSBtb2R1bGUgZGVwZW5kcyBvbiBSVU5USU1FX1RFU1RJ
TkdfTUVOVS4KPiAKPiBUaGFua3MKPiAKCldlbGwgcGVvcGxlIHVzZSB0aGUgc2ltdWxhdG9yIGZv
ciBkZXZlbG9wbWVudC4uLgpJJ20gbm90IGdvaW5nIHRvIGJsb2NrIHRoaXMgcGF0Y2ggb24gaXQs
IGJ1dCBpZiBzb21lb25lCmhhcyB0aGUgY3ljbGVzIHRvIHBvc3QgYSBzdGFibGUgYnJhbmNoIHBh
dGNoLCB0aGF0IHdvdWxkIGJlCmdyZWF0LgoKCj4gCj4gCj4gPiAKPiA+IFRoYW5rcywKPiA+IFN0
ZWZhbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
