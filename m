Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8905C55ABD
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 09:56:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182B1221FE
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 09:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJ0+2ZMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182B1221FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6B30E20470;
	Thu, 12 Nov 2020 09:56:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x7oVVigQvU4J; Thu, 12 Nov 2020 09:56:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0854F20398;
	Thu, 12 Nov 2020 09:56:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBBE8C08A1;
	Thu, 12 Nov 2020 09:56:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B74DC0889
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 09:56:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6A5A886D31
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 09:56:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QdBTxjHfPSij
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 09:56:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BF7B18602E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 09:56:20 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id k2so5333237wrx.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 01:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cxDZR78f1uAjoaTSqfFbkuzSwbFVGDkZXidPHX71G9c=;
 b=YJ0+2ZMBF11Z542eqUsAqitgHb1xPMZ9lech+gtY3w1F7OShr8zrOCrXG/V2z/Vf9D
 HvJMT0pS3sKdFvG56bx1LvN6uF/lhDOzA1YfuOcJrkfOS77zNBxHMGj8IusEA8/Evn9n
 vEUDFgaNl0eXFe71Zx5ivyXt/FVmjekvELTABnl8IThNTg4mQZES6Ls1Sj+/CCnAaW8s
 D/poUG+CS3XKDKNfiUrnWUKSQX2FNYipld7UOIAeSpgaQ152qnUGHktwJPgARaTmEEWL
 eZN+kAZ3YTV4KiBAUS62tIvHl3nYE2Ii0u3zoEFmkOd5nNkEQTgKsjtihGwlp/GcxvrL
 G9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cxDZR78f1uAjoaTSqfFbkuzSwbFVGDkZXidPHX71G9c=;
 b=ekoOPCqNLx6qIF/kvYT6j5KTOPglj4tDY2EeSvgJ8oJBXvVJhFbr1kagj+RGTpHatq
 lzZAWmHWWZzpERhANpgVexuz+2R2ZKQmkrwg6r/iqR1dkr+dBlDN54Dtyt75XfHqrOfb
 U/wkexq5zIOC2X2805KXkuphsGC57GqVE/3P5gWd0claw4n/tdobFBeYNocRfxKiLPSa
 5Y3XGWGl4NDPnGhBZ+uEgZrntfN/OxMq6v6TcWK7+BVtyzc0IbtacjeaWJTxPraKfVQc
 HMwEIrYCJPMpP/+wc+M3W/vi5Mhx76nh6yVjxnhwuW1LqG97VQFEMxyXhzPIeR58u69N
 lA6Q==
X-Gm-Message-State: AOAM5332ug0EcB/k295//FxW2BTvR6yBvC27eizMBdlow0uQrP6S3Dmt
 pdgCuUAwvH4Fp8p4cYUipa/49g==
X-Google-Smtp-Source: ABdhPJwZ8/k2DYgb9fv+4YPP3KOxKbE1pra7CozavXciwAz8421GIRgYfLL5qZ+6yrj+dSeMgUX0Pw==
X-Received: by 2002:adf:9d44:: with SMTP id o4mr36796016wre.229.1605174979204; 
 Thu, 12 Nov 2020 01:56:19 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96?
 ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
 by smtp.googlemail.com with ESMTPSA id m126sm5866401wmm.0.2020.11.12.01.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2020 01:56:18 -0800 (PST)
Subject: Re: [PATCH v2 05/17] clocksource/hyperv: use MSR-based access if
 running as root
To: Wei Liu <wei.liu@kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-6-wei.liu@kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3527e98a-faab-2360-f521-aa04bbe92edf@linaro.org>
Date: Thu, 12 Nov 2020 10:56:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105165814.29233-6-wei.liu@kernel.org>
Content-Language: en-US
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

T24gMDUvMTEvMjAyMCAxNzo1OCwgV2VpIExpdSB3cm90ZToKPiBTaWduZWQtb2ZmLWJ5OiBXZWkg
TGl1IDx3ZWkubGl1QGtlcm5lbC5vcmc+Cj4gLS0tCgpJIHdvdWxkIGxpa2UgdG8gYXBwbHkgdGhp
cyBwYXRjaCBidXQgdGhlIGNoYW5nZWxvZyBpcyB0b28gc2hvcnQgKG9uZSBsaW5lKS4KClBsZWFz
ZSBhZGQgYSBzbWFsbCBwYXJhZ3JhcGggKG5vIG5lZWQgdG8gcmVzZW5kIGp1c3QgYW5zd2VyIGhl
cmUsIEkgd2lsbAphbWVuZCB0aGUgbG9nIG15c2VsZi4KCj4gIGRyaXZlcnMvY2xvY2tzb3VyY2Uv
aHlwZXJ2X3RpbWVyLmMgfCAzICsrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
Cj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMgYi9k
cml2ZXJzL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5jCj4gaW5kZXggYmEwNGNiMzgxY2QzLi4y
NjlhNjkxYmQyYzQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBlcnZfdGlt
ZXIuYwo+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMKPiBAQCAtNDI2
LDYgKzQyNiw5IEBAIHN0YXRpYyBib29sIF9faW5pdCBodl9pbml0X3RzY19jbG9ja3NvdXJjZSh2
b2lkKQo+ICAJaWYgKCEobXNfaHlwZXJ2LmZlYXR1cmVzICYgSFZfTVNSX1JFRkVSRU5DRV9UU0Nf
QVZBSUxBQkxFKSkKPiAgCQlyZXR1cm4gZmFsc2U7Cj4gIAo+ICsJaWYgKGh2X3Jvb3RfcGFydGl0
aW9uKQo+ICsJCXJldHVybiBmYWxzZTsKPiArCj4gIAlodl9yZWFkX3JlZmVyZW5jZV9jb3VudGVy
ID0gcmVhZF9odl9jbG9ja190c2M7Cj4gIAlwaHlzX2FkZHIgPSB2aXJ0X3RvX3BoeXMoaHZfZ2V0
X3RzY19wYWdlKCkpOwo+ICAKPiAKCgotLSAKPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFy
by5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFy
bzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0
dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5h
cm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
