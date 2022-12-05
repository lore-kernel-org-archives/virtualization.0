Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DF7C4332F
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 18:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02FBB60BB8;
	Mon,  5 Dec 2022 18:53:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 02FBB60BB8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Fm9dfwrF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fwnaiG8dtc0Y; Mon,  5 Dec 2022 18:53:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 96555600D1;
	Mon,  5 Dec 2022 18:53:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96555600D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76A3DC0033;
	Mon,  5 Dec 2022 18:53:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AD3EC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 18:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC99D60706
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 18:53:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC99D60706
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zQu62r2cPxSB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 18:53:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC3CE600D1
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC3CE600D1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 18:53:54 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 k88-20020a17090a4ce100b00219d0b857bcso3767595pjh.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 10:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hN16r2JqgO0aUt9hEV33NLw/555dF70HALoTZ9f98ns=;
 b=Fm9dfwrFeIHNqJDczZ8ygOt/Uha01dMRWprhcIoeUWieIM4pkz1xky0EJcPnQBQWe0
 m7GUZoU0/2aCb+0E0+M6kltGs6hlEENaCX5gfWhRnXRd0rye5mK3KgRvIyM/2Oob5UlE
 38SmhTUgfCQay5hI4WIf3FEGQSsP7+pCWGiu3ohS05iL+h2v7+4MM6ftNKTC3q+ULBws
 nL39f0K0e/CH9ck/0WnWtdA3yoVKa3Ds36+G8AkqXJGYa6Ma+P2vAgd/4nl8Sjjj7ig4
 xXJQXoxqZJQ1eNNeKYHnnOqVcnXQ7tDUkUNigzrEsoOXLZHKOOwqgr2IQdgxEPpBBKfc
 HsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hN16r2JqgO0aUt9hEV33NLw/555dF70HALoTZ9f98ns=;
 b=sgwi3M9xfMbPq9/uORTtIu+3Ouj8HfhSXemX+Pfc9cdTNJZFWUMa/k3UqxUjvWv9Nw
 61i5JE3EVWBV1wsdkNTq23GbYUS0Y6M51pZH2ae85ereGH56qU5BupIa/Ywxh38fFftc
 GwzNT+rbRHkUg5b5P2a/YVnzLK6HPV3xzmbBh40uG6dguLkKwP2zYrvAtJgv+z3Onw/2
 7Sh64wFwSwHRrOaMzVRHfHWFG+PsEFNdD80ozSq8VRust31nY2TeWvb0rWChGYvS8GkO
 tkBgSqNq2VV2lYp7VR9yZlGCpsbxqdaaCic4CAQhLHtbA8zIod9WNJKltDJ/rfmF8LM+
 oVYQ==
X-Gm-Message-State: ANoB5pntuhofZrjVoLFZZ5w1aLGPbITXK5FdwKS2HuwgA2vIUkv582oN
 Pf3VF4m6lmHdqdKxEm3/H42lGg==
X-Google-Smtp-Source: AA0mqf4PO6AFHe2UJAtP+NKsy/VfRk3d594BgBjTrOZGH8U7h8+eNxk2+VLeleDwTNhV8wJgpjSYkQ==
X-Received: by 2002:a17:902:e411:b0:189:8796:7813 with SMTP id
 m17-20020a170902e41100b0018987967813mr40667373ple.110.1670266434300; 
 Mon, 05 Dec 2022 10:53:54 -0800 (PST)
Received: from ?IPV6:2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a?
 ([2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a170902778800b00189a7fbff33sm10880935pll.170.2022.12.05.10.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Dec 2022 10:53:53 -0800 (PST)
Message-ID: <23c98c7c-3ed0-0d26-24c0-ed8a63266dcc@kernel.dk>
Date: Mon, 5 Dec 2022 11:53:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Content-Language: en-US
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <fe2800f1-aaae-33e8-aaf0-83fd034162d5@kernel.dk>
 <CAJs=3_AKOMWBpvKqvX6_c=zN1cwEM7x9dzGr7na=i-5_16rdEg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAJs=3_AKOMWBpvKqvX6_c=zN1cwEM7x9dzGr7na=i-5_16rdEg@mail.gmail.com>
Cc: linux-scsi@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

T24gMTIvNS8yMiAxMTozNuKAr0FNLCBBbHZhcm8gS2Fyc3ogd3JvdGU6Cj4gSGksCj4gCj4+IElz
IHRoaXMgYmFzZWQgb24gc29tZSBzcGVjPyBCZWNhdXNlIGl0IGxvb2tzIHByZXR0eSBvZGQgdG8g
bWUuIFRoZXJlCj4+IGNhbiBiZSBhIHByZXR0eSB3aWRlIHJhbmdlIG9mIHR3by90aHJlZS9ldGMg
bGV2ZWwgY2VsbHMgd2l0aCB3aWxkbHkKPj4gZGlmZmVyZW50IHJhbmdlcyBvZiBkdXJhYmlsaXR5
LiBBbmQgdGhlcmUncyByZWFsbHkgbm90IGEgbG90IG9mIHNsYwo+PiBmb3IgZ2VuZXJpYyBkZXZp
Y2VzIHRoZXNlIGRheXMsIGlmIGFueS4KPiAKPiBZZXMsIHRoaXMgaXMgYmFzZWQgb24gdGhlIHZp
cnRpbyBzcGVjCj4gaHR0cHM6Ly9kb2NzLm9hc2lzLW9wZW4ub3JnL3ZpcnRpby92aXJ0aW8vdjEu
Mi9jc2QwMS92aXJ0aW8tdjEuMi1jc2QwMS5odG1sCj4gc2VjdGlvbiAgNS4yLjYKCkFuZCB3aGVy
ZSBkaWQgdGhpcyBjb21lIGZyb20/CgotLSAKSmVucyBBeGJvZQoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
