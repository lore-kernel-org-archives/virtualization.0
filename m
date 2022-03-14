Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29018C4332F
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 12:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9715A83DF3;
	Mon, 14 Mar 2022 12:47:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FcPTVZEuLKG0; Mon, 14 Mar 2022 12:47:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3B94881B36;
	Mon, 14 Mar 2022 12:47:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EEE1C0033;
	Mon, 14 Mar 2022 12:47:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6FC4C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 12:47:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A358B4155F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 12:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iwpH0SJonqCb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 12:47:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AF574155D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 12:47:54 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id q14so23785126wrc.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=UcZz3PXNAXNeLX36v/bP5PcZAjppkzTqtYj3JQZLCdA=;
 b=ig3ZPDbuCYDJsY/LgK1lpVFFGCBJvNLc/orKd5+QKvhAz74QdogXuc35H6CwRfnHa+
 hT4a6QXAcVyg2Z83vj3WOEp6qcGbrEEGflCZ39lr6oczDy0B3LoakQsSKEWHEhF25TGl
 8hqA7CALrwlBQeqlQOh45Re1Edl+ybv98yo2khw1rSBH1+PRnC5+dhq1eAaKBczXqlJZ
 ul6xk3BFYCjhk7mvf7OU/zEMtmx7O3AMM19LQu/zS7QSrk84f2LvxIg8IXuLjexhJDQk
 I8Cyu7Kd22U9CgsLcEo1AWInzQOZJKa0GgYkv0oshHsaKztu5Zrw0S35lj3UhbLW2UTT
 zQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=UcZz3PXNAXNeLX36v/bP5PcZAjppkzTqtYj3JQZLCdA=;
 b=h9fVObO0Xoo9Qd2kzr3v2yOk6JwN/lau2uuhu7U99pOfF5hbsCDpGVN2XEE4EZsMMP
 EbqN/KLyduHH3kSyIrYWroN3sz3J62EgvDeZ97dEfACZTTdbXGHFVtjK6WC7T6NQ0GJY
 vr9e6venIxrDNXPBvoTParV85WjnGZTLiirSSgbje3g+W2XcJ2NLif7CTNdNMk3Dxv1t
 rLHCvek43rxiBc1SmPD0tEEHwBG0VYR9Pnit6KzQHIvKSBU1pvRsm10gNZghXBNg+2tE
 lFy9hTbrzkox5ael7tSSttWT9PttFwsQR0I9N55m0EbsDSvthmg4pSAyhgphjDgiScTK
 tuww==
X-Gm-Message-State: AOAM533+G2JelGSo4ipKBLOS2+JkCbGMd/NU/qcL/H+deYZtg6QwELuc
 G5peiYrSw73yv4rOSMbyB5Wzfw==
X-Google-Smtp-Source: ABdhPJxbbfF5IE+ED+j6Qzjup3ymxmcmA/LwEtp0YD0fuDRr/NLeeKHy41JvH6RnmaYRzkrpBmXj8g==
X-Received: by 2002:a5d:6d83:0:b0:203:6a0e:8854 with SMTP id
 l3-20020a5d6d83000000b002036a0e8854mr16161016wrs.259.1647262072830; 
 Mon, 14 Mar 2022 05:47:52 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 f8-20020adfb608000000b0020229d72a4esm12782580wre.38.2022.03.14.05.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Mar 2022 05:47:52 -0700 (PDT)
Date: Mon, 14 Mar 2022 12:47:50 +0000
From: Lee Jones <lee.jones@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <Yi85dls3CCc2i1iK@google.com>
References: <20220314084302.2933167-1-lee.jones@linaro.org>
 <20220314072137-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220314072137-mutt-send-email-mst@kernel.org>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gTW9uLCAxNCBNYXIgMjAyMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgoKPiBPbiBNb24s
IE1hciAxNCwgMjAyMiBhdCAwODo0MzowMkFNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiB2
aG9zdF92c29ja19oYW5kbGVfdHhfa2ljaygpIGFscmVhZHkgaG9sZHMgdGhlIG11dGV4IGR1cmlu
ZyBpdHMgY2FsbAo+ID4gdG8gdmhvc3RfZ2V0X3ZxX2Rlc2MoKS4gIEFsbCB3ZSBoYXZlIHRvIGRv
IGhlcmUgaXMgdGFrZSB0aGUgc2FtZSBsb2NrCj4gPiBkdXJpbmcgdmlydHF1ZXVlIGNsZWFuLXVw
IGFuZCB3ZSBtaXRpZ2F0ZSB0aGUgcmVwb3J0ZWQgaXNzdWVzLgo+ID4gCj4gPiBBbHNvIFdBUk4o
KSBhcyBhIHByZWNhdXRpb25hcnkgbWVhc3VyZS4gIFRoZSBwdXJwb3NlIG9mIHRoaXMgaXMgdG8K
PiA+IGNhcHR1cmUgcG9zc2libGUgZnV0dXJlIHJhY2UgY29uZGl0aW9ucyB3aGljaCBtYXkgcG9w
IHVwIG92ZXIgdGltZS4KPiA+IAo+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPgo+ID4g
U2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiAKPiBQbHMg
cmVmZXIgdG8gbXkgcHJldmlvdXMgcmVzcG9uc2VzIHRvIHRoaXMgcGF0Y2guICBJJ2QgbGlrZSB0
byBzZWUgYW4KPiBhcmd1bWVudCBmb3Igd2h5IHRoaXMgd2lsbCBtYWtlIGZ1dHVyZSBidWdzIGxl
c3MgYW5kIG5vdCBtb3JlIGxpa2VseS4KCklmIHlvdSB0aGluayB0aGUgcHJldmlvdXMgJ2NoZWNr
IG93bmVyJyBwYXRjaCBmaXhlcyBhbGwgb2YgdGhlCmNvbmN1cnJlbmN5IGlzc3VlcywgdGhlbiB0
aGlzIHBhdGNoIGNhbiBiZSBkcm9wcGVkLgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpQcmlu
Y2lwYWwgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMKTGluYXJvLm9yZyDilIIg
T3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29r
IHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
