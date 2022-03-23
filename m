Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEABC4332F
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 16:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D677A84190;
	Wed, 23 Mar 2022 16:03:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BEH3AvdYjtZ6; Wed, 23 Mar 2022 16:03:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7007483E04;
	Wed, 23 Mar 2022 16:03:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52865C0012;
	Wed, 23 Mar 2022 16:03:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE7F2C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 16:03:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0F9E418E0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 16:03:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gJU569OHysJm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 16:03:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E7A2418DC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 16:03:54 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id s11so1808430pfu.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=URu1Cld800RCpFArjD3mILx4RS3EOY2glrIHlB2KP8Q=;
 b=VFfXM5YxFWV1n769LQtS6lAB0qgqL8kW45iyrLTKOyu5t09OX//Lc2kgTexCPwxO1m
 DNO1uQtVYMW07nVqiP70fusf6ZNhI64ed4YsTbhAeBGIIV7aNp98yBQ0ltlSZ74Lpjud
 2+hFvqsrpb9Y25jcKBsrfjnKPQwYspqQcVyM5zL5bHijVyY6qFs15Woa5NzsE24q0oCr
 Rkbx+JVO5LwjOfYRfg+5cdghuSGXQ6PQi/d6Lm3Y4UXa6BvLDd0fH3lXvIgi1rwa18rD
 kg5+i306FFdIa9psNvPEBu91D9OSZjRvRynBGzdx5mEQDjvukE8G1MbzsqRPxMXN6ymf
 gJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=URu1Cld800RCpFArjD3mILx4RS3EOY2glrIHlB2KP8Q=;
 b=LlkqqyLa3RgrbjlsJYr77GwPdBjuqTx0JJxXj0BbrMbjtrfb9ooqTfGEU3OXsbyete
 ztdZ/hHPL4wpCXWmfxNrJ/CAiqLP02+6Uai8I8UwtQCnnI/dq8U/zNKseSFoGft+r1XV
 7kvAMsu+VtxD3suFrscShGcc/mCwjftqrOJPt4C3tFm04wxMwDtU/sJ0nzIPnFT3tkmf
 LsqJVuXmU/LDr4jJZ60pXDpIzxJ9KxvCqJrE55Vj2dgTTyWzsq5OYHYAGSF8axYrDe55
 veginki1LVPhSsHeT7pmq/gOw4FJ89DpJfLpT3VVGTcfjSHl4aF5x6gCWlRzcHTXXWKT
 8odQ==
X-Gm-Message-State: AOAM532J7CBbnLl9WLtgoUetSo8e+3M/oIGfozDgKg7xS68hUIAvSxKO
 uWwZCDlGeRZHK+FySJRQEdsUnA==
X-Google-Smtp-Source: ABdhPJwxGfSENN/9Lwi9Dj6rnEjBTulAhjGbko1yBhAsuIBmI8EdYx67EM0pJ0KJ8RIRRT7o4EbRQw==
X-Received: by 2002:a05:6a00:3309:b0:4fa:950b:d011 with SMTP id
 cq9-20020a056a00330900b004fa950bd011mr291249pfb.24.1648051433738; 
 Wed, 23 Mar 2022 09:03:53 -0700 (PDT)
Received: from [10.255.146.117] ([139.177.225.224])
 by smtp.gmail.com with ESMTPSA id
 oa16-20020a17090b1bd000b001c72b632222sm7101041pjb.32.2022.03.23.09.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Mar 2022 09:03:41 -0700 (PDT)
Message-ID: <59113ffd-60c3-8036-d5c8-ca19908f0e65@bytedance.com>
Date: Wed, 23 Mar 2022 23:59:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Re: [PATCH v3 1/6] virtio-crypto: header update
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20220323024912.249789-1-pizhenwei@bytedance.com>
 <20220323024912.249789-2-pizhenwei@bytedance.com>
 <Yjs+7TYdumci1Q9h@redhat.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <Yjs+7TYdumci1Q9h@redhat.com>
Cc: herbert@gondor.apana.org.au, mst@redhat.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 lei he <helei.sig11@bytedance.com>
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

T24gMy8yMy8yMiAyMzozOCwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToKPiBPbiBXZWQsIE1h
ciAyMywgMjAyMiBhdCAxMDo0OTowN0FNICswODAwLCB6aGVud2VpIHBpIHdyb3RlOgo+PiBVcGRh
dGUgaGVhZGVyIGZyb20gbGludXgsIHN1cHBvcnQgYWtjaXBoZXIgc2VydmljZS4KPiAKPiBJJ20g
YXNzdW1pbmcgdGhpcyBpcyB1cGRhdGVkIGZvciAqbm9uLW1lcmdlZCogTGludXggaGVhZGVycywg
c2luY2UKPiBJIGRvbid0IHNlZSB0aGVzZSBjaGFuZ2VzIHByZXNlbnQgaW4gY3VycmVudCBsaW51
eC5naXQKPiAKPj4KSGksCgpUaGUgcmVsYXRlZCBjb250ZXh0IGxpbms6Cmh0dHBzOi8vbGttbC5v
cmcvbGttbC8yMDIyLzMvMS8xNDI1CgotIFRoZSB2aXJ0aW8gY3J5cHRvIHNwZWMgaXMgdGhlIGZp
cnN0IHBhcnQuIEl0IHdpbGwgYmUgZGVmZXJyZWQgdG8gMS4zLgpUaGUgbGF0ZXN0IHZlcnNpb246
IApodHRwczovL3d3dy5vYXNpcy1vcGVuLm9yZy9jb21taXR0ZWVzL2JhbGxvdC5waHA/aWQ9MzY4
MSAobmVlZCBwdXQgCiJfX2xlMzIgYWtjaXBoZXJfYWxnbzsiIGluc3RlYWQgb2YgIl9fbGUzMiBy
ZXNlcnZlOyIgYW5kIHJlcG9zdCkKCi0gQWNjb3JkaW5nIHRvIHRoZSBzcGVjLCB0aGVuIHdlIGNh
biBkZWZpbmUgdGhlIGxpbnV4IGhlYWRlcnMuIChkZXBlbmQgCm9uIHRoZSBzcGVjKQoKLSBVcGRh
dGUgdGhlIGhlYWRlciBmaWxlIGZvciBRRU1VLiAoZGVwZW5kIG9uIHRoZSBsaW51eCBoZWFkZXJz
KQoKQWxsIHRoZSBwYXJ0cyBhcmUgaW4gZGV2ZWxvcG1lbnQuCgotLSAKemhlbndlaSBwaQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
