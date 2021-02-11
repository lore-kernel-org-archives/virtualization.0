Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2F6C433E9
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 15:39:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497D364E8B
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 15:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497D364E8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09B1D6F6E4
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 15:39:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d87H-Ed7c4FM for <virtualization@archiver.kernel.org>;
	Thu, 11 Feb 2021 15:39:12 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 6065F6F696; Thu, 11 Feb 2021 15:39:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F95E6F641;
	Thu, 11 Feb 2021 15:39:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 218A5C0174;
	Thu, 11 Feb 2021 15:39:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74DD7C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 15:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 70EB786DEC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 15:39:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t53Yj2EHMMP7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 15:39:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BA25086DA2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 15:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613057946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gs1a/tfbUH/PEd0iLsgDabgczhYAOe2MzROMxzb4Y+s=;
 b=BJ/BSIYHxBZ8cCvbyA7wSWyDp9TavKyIr5SvwH2OeLn2y2nZMLwwTuKNFL2ux9ACFJ+wfR
 YD7yPDal72iff26VU6NiXP0o6Ffg7xMaSv5de+IeVz/7Np0orOY96ophX2iwY9LBCSK5m/
 1hTwJq4i4qkzN6fcyh7Bj/xGuKFlMWM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-Dei0UMaEOXWIUeVgsvNtdA-1; Thu, 11 Feb 2021 10:39:04 -0500
X-MC-Unique: Dei0UMaEOXWIUeVgsvNtdA-1
Received: by mail-ej1-f70.google.com with SMTP id gv53so4916342ejc.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 07:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Gs1a/tfbUH/PEd0iLsgDabgczhYAOe2MzROMxzb4Y+s=;
 b=nR7JbBADhoOV2SdGpywhYfvyrHN2r7xfcZ5+NHX6h88Iy3qqRooZk4Z77B6g88rrw+
 f1YacsCgtV96+heD10XtiCad/tHxShIpHNCyFDUXS6txYskDPHhfue5Ns9YRntOVzKUD
 2ZSlIkSuibD78SD/EIebaQecm+USYaK4x9K8LUMwfvLWfPdk8h8B0ZYcc5M1AfWEAUjh
 cNdznpUmm/K/dYpjYnJmlgRd5jsn1tauyaPyvsPBbjvbjiT5AG5jR2pfDIAMcDRuCpZ2
 o9vo1ukSBbDs2DEzVeOZ2H7SD669/96xB7YkWRZMRRmgMhGqkJ7MJbMAWZ0eGQud/KWQ
 YJWQ==
X-Gm-Message-State: AOAM532YqjCY9+1GIlZXpKiu4x1KBUiYQewCG96jUAEeQALMqT1OuqAz
 Oxjjax/zLa/9mAkpeWnDuPft2Y+A9mrnPA68d3Bs5AnW8J2QsCuGqggZfTWhh7ZMGZqB69uqwFH
 z6U5ZQp5MqIjBb0y0M6GWmc9M2Fvsvt0cwFYcTxdx2Q==
X-Received: by 2002:a05:6402:4382:: with SMTP id
 o2mr9044867edc.371.1613057943710; 
 Thu, 11 Feb 2021 07:39:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxW9DLr3Fwvy/0i2Ny6ozJLK40wr3ifKDYjwGfcSlxo4Hey4OMqRrCfpwF7GiQUNMtt0jAnpg==
X-Received: by 2002:a05:6402:4382:: with SMTP id
 o2mr9044847edc.371.1613057943458; 
 Thu, 11 Feb 2021 07:39:03 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id u18sm4626476ejc.76.2021.02.11.07.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 07:39:03 -0800 (PST)
Date: Thu, 11 Feb 2021 16:39:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210211153900.tzmyxw5wlxxk7vbl@steredhat>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210209054302.GA210455@mtl-vdi-166.wap.labs.mlnx>
 <20210209090014.xolf5kxri3xdmacz@steredhat>
 <cdd75885-3610-8685-14f3-5467a8ef1501@redhat.com>
 <20210210071129-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210210071129-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
 virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBGZWIgMTAsIDIwMjEgYXQgMDc6MTI6MzFBTSAtMDUwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+T24gV2VkLCBGZWIgMTAsIDIwMjEgYXQgMTI6MTc6MTlQTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPj4KPj4gT24gMjAyMS8yLzkg5LiL5Y2INTowMCwgU3RlZmFubyBHYXJ6
YXJlbGxhIHdyb3RlOgo+PiA+IE9uIFR1ZSwgRmViIDA5LCAyMDIxIGF0IDA3OjQzOjAyQU0gKzAy
MDAsIEVsaSBDb2hlbiB3cm90ZToKPj4gPiA+IE9uIE1vbiwgRmViIDA4LCAyMDIxIGF0IDA1OjE3
OjQxUE0gKzAxMDAsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPj4gPiA+ID4gSXQncyBsZWdh
bCB0byBoYXZlICdvZmZzZXQgKyBsZW4nIGVxdWFsIHRvCj4+ID4gPiA+IHNpemVvZihzdHJ1Y3Qg
dmlydGlvX25ldF9jb25maWcpLCBzaW5jZSAnbmRldi0+Y29uZmlnJyBpcyBhCj4+ID4gPiA+ICdz
dHJ1Y3QgdmlydGlvX25ldF9jb25maWcnLCBzbyB3ZSBjYW4gc2FmZWx5IGNvcHkgaXRzIGNvbnRl
bnQgdW5kZXIKPj4gPiA+ID4gdGhpcyBjb25kaXRpb24uCj4+ID4gPiA+Cj4+ID4gPiA+IEZpeGVz
OiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVk
Cj4+ID4gPiA+IG1seDUgZGV2aWNlcyIpCj4+ID4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnCj4+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVA
cmVkaGF0LmNvbT4KPj4gPiA+Cj4+ID4gPiBBY2tlZC1ieTogRWxpIENvaGVuIDxlbGljQG52aWRp
YS5jb20+Cj4+ID4gPgo+PiA+ID4gQlRXLCBzYW1lIGVycm9yIGluIHZkcGFfc2ltIHlvdSBtYXkg
d2FudCB0byBmaXguCj4+ID4gPgo+PiA+Cj4+ID4gQ29tbWl0IDY1YjcwOTU4NmUyMiAoInZkcGFf
c2ltOiBhZGQgZ2V0X2NvbmZpZyBjYWxsYmFjayBpbgo+PiA+IHZkcGFzaW1fZGV2X2F0dHIiKSB1
bmludGVudGlvbmFsbHkgc29sdmVkIGl0Lgo+PiA+Cj4+ID4gU2luY2UgaXQncyBhIHNpbXVsYXRv
ciwgbWF5YmUgd2UgY2FuIGF2b2lkIHNvbHZpbmcgaXQgaW4gdGhlIHN0YWJsZQo+PiA+IGJyYW5j
aGVzLiBPciBkb2VzIGl0IG1hdHRlcj8KPj4KPj4KPj4gSSB0aGluayBub3QsIHNpbmNlIHRoZSBt
b2R1bGUgZGVwZW5kcyBvbiBSVU5USU1FX1RFU1RJTkdfTUVOVS4KPj4KPj4gVGhhbmtzCj4+Cj4K
PldlbGwgcGVvcGxlIHVzZSB0aGUgc2ltdWxhdG9yIGZvciBkZXZlbG9wbWVudC4uLgo+SSdtIG5v
dCBnb2luZyB0byBibG9jayB0aGlzIHBhdGNoIG9uIGl0LCBidXQgaWYgc29tZW9uZQo+aGFzIHRo
ZSBjeWNsZXMgdG8gcG9zdCBhIHN0YWJsZSBicmFuY2ggcGF0Y2gsIHRoYXQgd291bGQgYmUKPmdy
ZWF0Lgo+CgpPa2F5LCBJJ2xsIGRvIGl0LgoKVGhhbmtzLApTdGVmYW5vCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
