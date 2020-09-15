Return-Path: <SRS0=Zxjt=CY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4953C43461
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 10:10:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C69C20771
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 10:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtHVFklK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C69C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F3DD685FC0;
	Tue, 15 Sep 2020 10:10:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0v99KHQDRKwJ; Tue, 15 Sep 2020 10:10:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6402085C50;
	Tue, 15 Sep 2020 10:10:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46254C0859;
	Tue, 15 Sep 2020 10:10:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16ED9C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 10:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0021287053
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 10:10:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OhfAobtkm0z6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 10:10:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4EBFD87042
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 10:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600164610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PW2WSdBrk/XXLs9riC9q1EjPQLc8T5twwn4fVAgRI5I=;
 b=EtHVFklKRs3FxR/kjFTMP0xx4HqwtXRftYjMQMy4EMxGh2NL/DKBM6Wo7p93CQqH4M4nUZ
 pai5XMjqgz4512ekLeGxWcRl2DvVLf8AIqkPBPA+EhzUIw5l78PxFFPpp8s6dxvrjgt/EG
 qJEbpWp4l9gIDWdFMNdiogBqmrWFgF4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-M6Qik8YSN-GcBfXFk_h-ag-1; Tue, 15 Sep 2020 06:10:08 -0400
X-MC-Unique: M6Qik8YSN-GcBfXFk_h-ag-1
Received: by mail-wr1-f70.google.com with SMTP id o6so1046619wrp.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 03:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=PW2WSdBrk/XXLs9riC9q1EjPQLc8T5twwn4fVAgRI5I=;
 b=CQ3xKm9FYTZX1pWLST4aOnSVzwqBUkiE7GeXLbLBX1ZpnjXLXrlc/GQzW2xmEoFZiM
 G4li7SnXxygfZxi9wRGLgucCYsjpgkicHEfqEF0ecNKnTM9Vp0jffqqy5FMZzAeEOgYS
 WIXU8ZnpN5xO7KZQsPnF0CMaFWjKgRzGauVZOuV/yRlxL1jEpoSUV52kHWNxbHJyd3dY
 xazv+pAl4JSW+3ht6kHjddTX8wZ6rxSLPyhyI274Y8VRR/0LtLZ4YGV2ZeuCcl19RURW
 YYx1xToC0AaMDs043vkf+s20K+nmskXDjJfiudfYB58+8hwGEDmDilxks6uPufHLnnKC
 PpOg==
X-Gm-Message-State: AOAM530tWoMeGdZ1PJKFj46ALlkLc0BTNvVrwKTqPHGarQU4YWHkESQU
 5duJdlVCF/NGkn5jjWmgZ5bYpGbnKu3PIKZzJ5K43u2EO0hMHSMGLl9Xjdi+/FQptKFC1Po+2OG
 Fxf/dLuNr/fuFTFwmic1gkBLTck2/qJX8pehMsyBTfQ==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr3913453wmc.100.1600164607059; 
 Tue, 15 Sep 2020 03:10:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+J82Jd8EMAaV6jdVfRPYNTBzK7waYWJIWEbGPmCe6Da0iBTQvQbeRjA+xD8ipa/CdBYDyPQ==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr3913430wmc.100.1600164606872; 
 Tue, 15 Sep 2020 03:10:06 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id m2sm16387178wrq.25.2020.09.15.03.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 03:10:06 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH RFC v1 05/18] clocksource/hyperv: use MSR-based access if
 running as root
In-Reply-To: <20200914112802.80611-6-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-6-wei.liu@kernel.org>
Date: Tue, 15 Sep 2020 12:10:04 +0200
Message-ID: <874knzl5ab.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 virtualization@lists.linux-foundation.org,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Nuno Das Neves <nudasnev@microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Wei Liu <wei.liu@kernel.org> writes:

> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/clocksource/hyperv_timer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 09aa44cb8a91..fe96082ce85e 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -426,6 +426,9 @@ static bool __init hv_init_tsc_clocksource(void)
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return false;
>  
> +	if (hv_root_partition)
> +		return false;
> +

Out of pure curiosity,

TSC page clocksource seems to be available to the root partition (as
HV_MSR_REFERENCE_TSC_AVAILABLE is set), why don't we use it? (I
understand that with TSC scaling support in modern CPUs even migration
is a no-issue and we can use raw TSC but this all seems to be
independent from root/non-root partition question).

>  	hv_read_reference_counter = read_hv_clock_tsc;
>  	phys_addr = virt_to_phys(hv_get_tsc_page());

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
