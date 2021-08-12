Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7A4C4338F
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 03:23:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DD660EE2
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 03:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2DD660EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65B6E401CF;
	Thu, 12 Aug 2021 03:23:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vyJoENzAtmJX; Thu, 12 Aug 2021 03:23:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F2BCF401B9;
	Thu, 12 Aug 2021 03:23:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3AA2C0010;
	Thu, 12 Aug 2021 03:23:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13D9BC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 03:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF21240580
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 03:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wc_toJxLNcSn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 03:23:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55C5E40560
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 03:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628738595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2m2roWrvbYZeRqtABbQ37PaOQOhXAkNprJbXopZhFmQ=;
 b=VIq3nocEpeEuejQkZpeAR55rmstvJxPFGpEUsNkclXXIBifXr6oVQUrZPU+P4D4HiaXwgH
 in+ps3Kcw8qkgQRK3IzKj5WKxnNZBsxhbFU2OgoY9z4XvFPGBKREhIfWdv0wbOhgh13Pfx
 z08c/cXKccS62q4hxzVpPqD4djVrSJc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-Q68rgd4jM9a_MI9cy2fn6w-1; Wed, 11 Aug 2021 23:23:14 -0400
X-MC-Unique: Q68rgd4jM9a_MI9cy2fn6w-1
Received: by mail-pj1-f72.google.com with SMTP id
 v18-20020a17090abb92b0290178fa401bdcso3193797pjr.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2m2roWrvbYZeRqtABbQ37PaOQOhXAkNprJbXopZhFmQ=;
 b=j5b+5Q1y1NI5WVMndDQ6SHU6xO733h9y+FGPFbAQeSKo1Fg+sk52LdcW5zulGiiGvl
 r69H+KP+SsOGvE6pUme9biznjnLwI2e8N4lErFgakA+TZhLzoKdlaraN257op+5hEX39
 R79uZB0YXCw7k3NBZbAj4oWIlwaWC9bCldekjZ5IddA8cEeYv6kujDRnKo09LW03+Pnc
 Tj7W3hmICjOlJL7vDuwX6Id7UaTnl0jNKcyGB+dk2YtEVWDr/1gtmyuSzQRwbtDDopkh
 c+HtNy9Ld1E+Ktm1kVnJoBhhIJ6fey9M1MB69nWVypXWmkXv37mVr0fiomc1DRJ3rYgz
 NucQ==
X-Gm-Message-State: AOAM532z8qZybu12G+sdNyKzTDzlsotFsk3ALh0z+ulLXv3DYpsMbpb4
 frL9Yn7487/0xNqQvGhG4hRMFbiakRzBTOnKgPS/jyFGosI+KaAwHJXI/8eO/UVvehaXhN5uxVb
 Rl1yEyu0/DlC2hHBA9bpo2vY3F3Lpbc0Cp2/j7tzSsw==
X-Received: by 2002:a63:4b20:: with SMTP id y32mr1859083pga.382.1628738593901; 
 Wed, 11 Aug 2021 20:23:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxri0vz1C8dFRUmJIUTNidwykg+eDk8Nwx4EwLANMh4kFarSI6fxHbBC1+cB14MM5x9vm7Uww==
X-Received: by 2002:a63:4b20:: with SMTP id y32mr1859066pga.382.1628738593676; 
 Wed, 11 Aug 2021 20:23:13 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m16sm8395422pjz.30.2021.08.11.20.23.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Aug 2021 20:23:13 -0700 (PDT)
Subject: Re: [RFC PATCH] virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
To: Jakub Kicinski <kuba@kernel.org>
References: <20210811081623.9832-1-jasowang@redhat.com>
 <20210811151754.030a22a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <aa3e2aca-05a9-aed7-59ec-eb4bd32d8f76@redhat.com>
Date: Thu, 12 Aug 2021 11:23:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811151754.030a22a7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: willemb@google.com, mst@redhat.com, netdev@vger.kernel.org,
 ivan@prestigetransportation.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 davem@davemloft.net
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvOC8xMiDJz87nNjoxNywgSmFrdWIgS2ljaW5za2kg0LS1wDoKPiBPbiBXZWQsIDEx
IEF1ZyAyMDIxIDE2OjE2OjIzICswODAwIEphc29uIFdhbmcgd3JvdGU6Cj4+IFRyeSB0byBmaXgg
dGhpcyBieSB1c2luZyBORVRJRl9GX0dST19IVyBpbnN0ZWFkIHNvIHdlJ3JlIG5vdAo+PiBndWFy
YW50ZWVkIHRvIGJlIHJlLXNlZ21lbnRlZCBhcyBvcmlnaW5hbC4KPiBUaGlzIHNlbnRlbmNlIG1h
eSBuZWVkIHJlcGhyYXNpbmcuCgoKUmlnaHQsIGFjdHVhbGx5LCBJIG1lYW50OgoKClRyeSB0byBm
aXggdGhpcyBieSB1c2luZyBORVRJRl9GX0dST19IVyBpbnN0ZWFkLiBCdXQgd2UncmUgbm90IHN1
cmUgdGhlIApwYWNrZXQgY291bGQgYmUgcmUtc2VnbWVudGVkIHRvIHRoZSBleGFjdCBvcmlnaW5h
bCBwYWNrZXQgc3RyZWFtLiBTaW5jZSAKaXQncyByZWFsbHkgZGVwZW5kcyBvbiB0aGUgYmFrY2Vu
ZCBpbXBsZW1lbnRhdGlvbi4KCgo+Cj4+IE9yIHdlIG1heSB3YW50IGEgbmV3IG5ldGRldgo+PiBm
ZWF0dXJlIGxpa2UgUlhfR1NPIHNpbmNlIHRoZSBndWVzdCBvZmZsb2FkcyBmb3IgdmlydGlvLW5l
dCBpcwo+PiBhY3R1YWxseSB0byByZWNlaXZlIEdTTyBwYWNrZXQuCj4+Cj4+IE9yIHdlIGNhbiB0
cnkgbm90IGFkdmVydGlzZSBMUk8gaXMgY29udHJvbCBndWVzdCBvZmZsb2FkcyBpcyBub3QKPj4g
ZW5hYmxlZC4gVGhpcyBzb2x2ZXMgdGhlIHdhcm5pbmcgYnV0IHdpbGwgc3RpbGwgc2xvdyBkb3du
IHRoZSB0cmFmZmljLgo+IElNTyBncm8taHcgZml0cyBwcmV0dHkgd2VsbCwgcGF0Y2ggbG9va3Mg
Z29vZC4KCgpJZiB0aGUgcmUtc2VnbWVudGF0aW9uIGlzIG5vdCBhIGlzc3VlLiBJIHdpbGwgcG9z
dCBhIGZvcm1hbCBwYXRjaC4KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
