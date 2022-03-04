Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990EEC433FE
	for <virtualization@archiver.kernel.org>; Fri,  4 Mar 2022 16:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51C89841A2;
	Fri,  4 Mar 2022 16:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l8WFrW3W3aUP; Fri,  4 Mar 2022 16:56:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 020DF83312;
	Fri,  4 Mar 2022 16:56:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDD80C0012;
	Fri,  4 Mar 2022 16:56:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E2A1C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B6FF60F8A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:56:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iiNaWSAe_pwl
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:56:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 37FCC60A79
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:56:49 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 bi14-20020a05600c3d8e00b00386f2897400so1777782wmb.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Mar 2022 08:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=OeG+ww/Pdl38zR6EndtrKnHOChw4NiKGrdOcb/INWpM=;
 b=UMOLRWI2FdlLVH6TCzeS4kpeBRdBi4juFCEroIm0oaa9CA6iyntAXKeauE+Ee6zFzp
 nR0XKPembJQcTFnlmU/ZEldn9+lU1O7YMLhV/S8e2JS0asxXKMOOoZ5DgugFAd9kw2S4
 RH+KAn8eayIRlvE31Y2XkjVCYMh/WJ4lHnAu5Ayb62Bur6cdhPtUbiLILVb44SzWPDOa
 2z2yIYRGlAc4lFtAc/bsdIfm3TN/EGUNGqqj+oegKaIjfnn0ntYyfiHPzy0lzHPRs1cA
 OPcdNm7C/IkHPbZA/XLaXlIwT+BWEKkSUCwIrcfrHsYUdJXqJPgTELJYugjTCstr94VH
 BzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OeG+ww/Pdl38zR6EndtrKnHOChw4NiKGrdOcb/INWpM=;
 b=4q3phUZqRB/wuPqwRWiXlfKreveltuCveyqyLAANoyqURoX7M4C6UgCepgzz3UBDTT
 jJWPzIhV1lReIZ6xVSFL70ezgJ7LvRQbQci1MB1kIZHDplfxOH9wqs1/hR33UgmHVmTC
 0nqZ19V/u/TscAPd+vSDF/wkkuMvvtihhdTuBTX4SZeatnY4WHytbA/84Orw2P4q5aNe
 8mo0123h9a5I0Pemkw+GT0n+qDxa5+YNUcK3Lz0OH+XZqG0h10QwxrAE0ZctBjGRPBFY
 NKz1cZJgjPf71lFO4j3ZdO3zpUryDmKYUGTZHzun3KCh1D9qaXavh2CYqq4Vdn3U1q9l
 NZiQ==
X-Gm-Message-State: AOAM53181H+0UuAMqGOESBh/dCT8hsWiBd5i2hd/A0r0k5JF2uCTgUpS
 q9lB5nEneYLrAvJWnUict3y1Lw==
X-Google-Smtp-Source: ABdhPJyMtgycuIr7vOgYL0Dp0iSnVrXZOJULcr8VvGwrH6xblkcMJwOAVAoqNil1zst8+h6cfCcjWw==
X-Received: by 2002:a1c:e916:0:b0:37c:f44f:573 with SMTP id
 q22-20020a1ce916000000b0037cf44f0573mr8795252wmc.179.1646413007235; 
 Fri, 04 Mar 2022 08:56:47 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 p3-20020a05600c358300b003897e440047sm2501809wmq.28.2022.03.04.08.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 08:56:46 -0800 (PST)
Date: Fri, 4 Mar 2022 16:56:44 +0000
From: Lee Jones <lee.jones@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <YiJEzLKlEY3NECKk@google.com>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220304114718-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220304114718-mutt-send-email-mst@kernel.org>
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCAwNCBNYXIgMjAyMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgoKPiBPbiBXZWQs
IE1hciAwMiwgMjAyMiBhdCAwNzo1NDoyMUFNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiB2
aG9zdF92c29ja19oYW5kbGVfdHhfa2ljaygpIGFscmVhZHkgaG9sZHMgdGhlIG11dGV4IGR1cmlu
ZyBpdHMgY2FsbAo+ID4gdG8gdmhvc3RfZ2V0X3ZxX2Rlc2MoKS4gIEFsbCB3ZSBoYXZlIHRvIGRv
IGlzIHRha2UgdGhlIHNhbWUgbG9jawo+ID4gZHVyaW5nIHZpcnRxdWV1ZSBjbGVhbi11cCBhbmQg
d2UgbWl0aWdhdGUgdGhlIHJlcG9ydGVkIGlzc3Vlcy4KPiA+IAo+ID4gTGluazogaHR0cHM6Ly9z
eXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTI3OTQzMmQzMGQ4MjVlNjNiYTAwCj4gPiAK
PiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4KPiA+IFJlcG9ydGVkLWJ5OiBzeXpib3Qr
YWRjM2NiMzIzODU1ODZiZWM4NTlAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQo+ID4gU2lnbmVk
LW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiAKPiBPSyBzbyBwbGVh
c2UgcG9zdCBzZXJpZXMgd2l0aCB0aGlzIGFuZCB0aGUgd2FybmluZwo+IGNsZWFuZWQgdXAgY29t
bWVudHMgYW5kIGNvbW1pdCBsb2dzIGV4cGxhaW5pbmcgdGhhdAo+IHRoaXMgaXMganVzdCB0byBt
YWtlIGRlYnVnZ2luZyBlYXNpZXIgaW4gY2FzZQo+IHdlIGhhdmUgaXNzdWVzIGluIHRoZSBmdXR1
cmUsIGl0J3Mgbm90IGEgYnVnZml4LgoKTm8gcHJvYmxlbS4KCkp1c3QgdG8gY2xhcmlmeSwgZHJv
cCBDYzogU3RhYmxlIGFsc28/CgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dClByaW5jaXBhbCBU
ZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3JnIOKUgiBPcGVuIHNv
dXJjZSBzb2Z0d2FyZSBmb3IgQXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0
dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
