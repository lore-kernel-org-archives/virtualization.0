Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD02C4332F
	for <virtualization@archiver.kernel.org>; Tue, 29 Nov 2022 17:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 660BE8109C;
	Tue, 29 Nov 2022 17:08:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 660BE8109C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=aB+ZuGMO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6mM4Y8dOUcM; Tue, 29 Nov 2022 17:08:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E5F080CCE;
	Tue, 29 Nov 2022 17:08:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E5F080CCE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E45B0C0032;
	Tue, 29 Nov 2022 17:08:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 468A0C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 17:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D1E980CCE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 17:08:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D1E980CCE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f3zyLzIRimPE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 17:08:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5302F80BFD
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5302F80BFD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 17:08:33 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id z17so9486861pff.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cfz3Mcgxkqb1OqUShW9AvM1bJWJ5IVPUimuhgnHTUfM=;
 b=aB+ZuGMOzbK18zkd0jlC4zEUTSM38tp9K/bCtuVmGeRWETnLRpEwg6Cfsis6G/o8YB
 2HqB7jorwoOw6h/LjLMxu5ed5EZE92927W/9yhpp/QruynXSUNxJp0OMoVkixJnRoaDz
 PSuOZAOkF9I4gSS32lclTss+2DBuTn/ncV2ntYH8YMzg9PF3tm8qf0hVKILYBg2UDCmD
 wbUFp/1Fi7NjOLDWJsNeD/wtnDvCVPYo4knWim39AeNTc1EFLvMkEGW6VYwyktGtW5Qx
 +UBWGG0y4yJft2CYMgbAUi9qHrNg41pvQg2NXxZ0NdMCIm2c1JLzlQ89YLhdvsbn7Bys
 PI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cfz3Mcgxkqb1OqUShW9AvM1bJWJ5IVPUimuhgnHTUfM=;
 b=yWEDFNSnsH4WjNVx8b6ZdOCCHNJE7i2sC5NjQ+ctA7Us1wacFpTTFNzRzWUFrI6qt+
 77JGY7V6uEkvWRy872NQGBlvqWDgpZ+Gay9qe9a/SUL6TT/73CDeePgfP1r7HB6ANiCK
 mZLasWTwaqOVDM1KVbpo6pW23GoMj/I5+6DN8yBoTh/eJC9EtgDxjQMFLgGMb12P7LbH
 78uOoQxmmm713ZCNkYJ0VOAt/6/QPF0R6GYA9rEXYB0QyupVGz5nJqQjU8tuTS66gdZQ
 HVTMODNKqCSRK4GUL79HdcKH3mp6XPVvm8Q2/Ah9px3m1Yo/uFI/OiNsJZlCs/3ULOSs
 mnuw==
X-Gm-Message-State: ANoB5plNydPpqZlfqcpul3CBwBvQ24r8CO39sK3LZtS7Zq9c1CLCHs80
 uho+j6DeYUnY0eq+Y6u2faoIWA==
X-Google-Smtp-Source: AA0mqf5swFLksPgiEDo6TRTvtGl0tdoW1L9fhbh0pRyA3vgdzDg/DHK7jSPhCQbx1VNNnHFBlq3wIw==
X-Received: by 2002:a63:ce58:0:b0:473:e2bb:7fc0 with SMTP id
 r24-20020a63ce58000000b00473e2bb7fc0mr33307253pgi.604.1669741713274; 
 Tue, 29 Nov 2022 09:08:33 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 h23-20020a63e157000000b00434272fe870sm8633883pgk.88.2022.11.29.09.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Nov 2022 09:08:32 -0800 (PST)
Message-ID: <9044e2b7-193f-ade4-b4a3-69e40b12088a@kernel.dk>
Date: Tue, 29 Nov 2022 10:08:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/5] Fix probe failed when modprobe modules
Content-Language: en-US
To: Li Zetao <lizetao1@huawei.com>
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221129160615.3343036-1-lizetao1@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221129160615.3343036-1-lizetao1@huawei.com>
Cc: linux_oss@crudebyte.com, pmorel@linux.vnet.ibm.com,
 dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org,
 edumazet@google.com, airlied@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 olvaffe@gmail.com, st@redhat.com, ericvh@gmail.com, rusty@rustcorp.com.au,
 linux-block@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
 stefanha@redhat.com, airlied@redhat.com, cornelia.huck@de.ibm.com,
 virtualization@lists.linux-foundation.org, pankaj.gupta.linux@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch,
 pbonzini@redhat.com, davem@davemloft.net
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

T24gMTEvMjkvMjIgOTowNuKAr0FNLCBMaSBaZXRhbyB3cm90ZToKPiBUaGlzIHBhdGNoc2V0IGZp
eGVzIHNpbWlsYXIgaXNzdWUsIHRoZSByb290IGNhdXNlIG9mIHRoZQo+IHByb2JsZW0gaXMgdGhh
dCB0aGUgdmlydHF1ZXVlcyBhcmUgbm90IHN0b3BwZWQgb24gZXJyb3IKPiBoYW5kbGluZyBwYXRo
LgoKTm90IHJlbGF0ZWQgdG8ganVzdCB0aGlzIHBhdGNoc2V0LCBidXQgZ3V5cywgSHVhd2VpIHJl
YWxseSAqUkVBTExZKiBuZWVkCnRvIGdldCB0aGUgZW1haWwgc2l0dWF0aW9uIHNvcnRlZC4gSSdt
IGRpZ2dpbmcgd2hvbGUvaGFsZiBwYXRjaHNldHMgb3V0Cm9mIHNwYW0gZXZlcnkgbW9ybmluZy4K
ClRoaXMgaGFzIGJlZW4gYnJvdWdodCB1cCBpbiB0aGUgcGFzdC4gQW5kIG5vLCB0aGUgY2xvdWQg
dmFyaWFudCBvZgp0aGUgZW1haWwgYWxzbyBkb2Vzbid0IHdvcmsgcHJvcGVybHkuCgpUYWxrIHRv
IHlvdXIgSVQgZGVwYXJ0bWVudCwgZ2V0IHRoaXMgc29ydGVkIG9uY2UgYW5kIGZvciBhbGwuIFlv
dSByaXNrCnlvdXIgcGF0Y2hlcyBiZWluZyBkdW1wZWQgb24gdGhlIGZsb29yIGJlY2F1c2UgcGVv
cGxlIGRvbid0IHNlZSB0aGVtLApvciBvbmx5IHNlZSBzbWFsbCBwYXJ0cyBvZiBhIHBhdGNoc2V0
LiBBbmQgaXQncyByZWFsbHkgYW5ub3lpbmcgdG8gaGF2ZQp0byBkZWFsIHdpdGggYXMgYSByZWNp
cGllbnQuCgotLSAKSmVucyBBeGJvZQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
