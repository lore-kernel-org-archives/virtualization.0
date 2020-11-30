Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672BCC64E8A
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 13:52:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B407E2084C
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 13:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIEP+F8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B407E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1A74C872A3;
	Mon, 30 Nov 2020 13:52:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RWg2YIPBzC2v; Mon, 30 Nov 2020 13:52:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 570A4871CF;
	Mon, 30 Nov 2020 13:52:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AD9EC0859;
	Mon, 30 Nov 2020 13:52:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F9E4C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 13:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6A8DF228A0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 13:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zIwh9HJ81LFi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 13:52:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 11E08228AC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 13:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606744337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dd7YyZx6S0r/k7Jv+t4IouJbGqiia4Gb0CDXIGTscz0=;
 b=eIEP+F8F/CuP/KFr1Qfp3NsFB3p4wcZfUGgp1GHDI/PITFACoRoh7tvhzHQsIO2CKOEXOt
 4pZL/qgGrp3TjHkmZjS5rA2E9fp619E54HxxWTyHDRCascOs7X9UhVxlk9LnCDhrHcZBbw
 hD3XyuBL2CdzmD/l7aGCKTlpHwlSbOA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-iGaGEMyEMNyyEnpqjE669A-1; Mon, 30 Nov 2020 08:52:14 -0500
X-MC-Unique: iGaGEMyEMNyyEnpqjE669A-1
Received: by mail-wr1-f71.google.com with SMTP id m2so8489663wro.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 05:52:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dd7YyZx6S0r/k7Jv+t4IouJbGqiia4Gb0CDXIGTscz0=;
 b=DyqOwMQG/H8jDPSQZpBBAv46BpcGFX7h+Amm4Kv9QOAXjETJWkM3JTCIyiVdym0IXm
 xTB9+u4g+VaYhgsQrkmbQ5UwFFh5Lv2J3EOQaMkHQb0E4qQvjJ/ssTLQekQmXUfLMtdV
 aUNq/bPUqdpcNBwbbQ2vwsn+XdhMD1RP+Y95/koWNMtylvXtXzMkjbM+lq0oBmKtbxL0
 WUgjzqLm6RO2I5vxZxfS0atCNA2MOunMxMP2Nwoq7KxWx3+IYnzvYZZwOx5+FAhxco4k
 iDf02YF1ajbLhIw/lxlJmOH7hqSiS7rqB5IAlD7IOoXtD2P8yMiyQQAlgO4ITZymQ9jX
 xb8A==
X-Gm-Message-State: AOAM531J78JEztdVTcv7AEOMpJlnSBIdClaN6jUOGwC9LprgcBjdATC0
 HzDgYdoj2WVHet/A99pGI5z3Et0OITcMKWkgYUsVfWcrDgOEri19IgpuUtuMtJVW9a4UNVGHk0x
 Ae8l9DxTpHpHDs+MsEiHj/cOmjvAfNsA9b4/VisAzIA==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr23439821wmj.76.1606744333518; 
 Mon, 30 Nov 2020 05:52:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDRWnK6zyQVzBKPkyfXvW5Lg7IYkytWYIR8qzu9foUcwM4XjEiPARUAO4ll+Mb92v/wZ91Gw==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr23439788wmj.76.1606744333185; 
 Mon, 30 Nov 2020 05:52:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id i11sm29049398wro.85.2020.11.30.05.52.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Nov 2020 05:52:12 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
To: Greg KH <gregkh@linuxfoundation.org>
References: <20201125153550.810101-1-sashal@kernel.org>
 <20201125153550.810101-22-sashal@kernel.org>
 <25cd0d64-bffc-9506-c148-11583fed897c@redhat.com>
 <20201125180102.GL643756@sasha-vm>
 <9670064e-793f-561e-b032-75b1ab5c9096@redhat.com>
 <20201129041314.GO643756@sasha-vm>
 <7a4c3d84-8ff7-abd9-7340-3a6d7c65cfa7@redhat.com>
 <20201129210650.GP643756@sasha-vm>
 <e499986d-ade5-23bd-7a04-fa5eb3f15a56@redhat.com>
 <X8TzeoIlR3G5awC6@kroah.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17481d8c-c19d-69e3-653d-63a9efec2591@redhat.com>
Date: Mon, 30 Nov 2020 14:52:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X8TzeoIlR3G5awC6@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 30/11/20 14:28, Greg KH wrote:
>>> Lines of code is not everything. If you think that this needs additional
>>> testing then that's fine and we can drop it, but not picking up a fix
>>> just because it's 120 lines is not something we'd do.
>> Starting with the first two steps in stable-kernel-rules.rst:
>>
>> Rules on what kind of patches are accepted, and which ones are not, into the
>> "-stable" tree:
>>
>>   - It must be obviously correct and tested.
>>   - It cannot be bigger than 100 lines, with context.
> We do obviously take patches that are bigger than 100 lines, as there
> are always exceptions to the rules here.  Look at all of the
> spectre/meltdown patches as one such example.  Should we refuse a patch
> just because it fixes a real issue yet is 101 lines long?

Every patch should be "fixing a real issue"---even a new feature.  But 
the larger the patch, the more the submitters and maintainers should be 
trusted rather than a bot.  The line between feature and bugfix 
_sometimes_ is blurry, I would say that in this case it's not, and it 
makes me question how the bot decided that this patch would be 
acceptable for stable (which AFAIK is not something that can be answered).

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
