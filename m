Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEC6C56201
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:31:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475692224A
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vrvz+NsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475692224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4A80385344;
	Thu, 12 Nov 2020 15:31:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lGDw1UpFUerQ; Thu, 12 Nov 2020 15:31:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B7D5A87811;
	Thu, 12 Nov 2020 15:31:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4F52C088B;
	Thu, 12 Nov 2020 15:31:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F086AC016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E191487135
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:31:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZgAxzZr0bX8Y
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:31:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 56D2587132
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605195063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XHp7Bo10vm0UfwNZa83vSvzkaRjk9257JvNRreDbMPA=;
 b=Vrvz+NsPN9uNUq4lzcKkf8LCw48MoU6+Pta8F4tYeXk/SiM7P8qnDEuuV613OC9cluyyqn
 EiqiY0+++mc41Z3odwBT3yZx2m7U1HvTz0D8gTZpOqx7GCHJctNS71Bzk+UsaY9lQgG+nl
 6FclgK9GsjlFHlcvXV2L0Yx+yrYmY+4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-f0ixWdjoPKSWXiDCvdslHg-1; Thu, 12 Nov 2020 10:31:00 -0500
X-MC-Unique: f0ixWdjoPKSWXiDCvdslHg-1
Received: by mail-wr1-f72.google.com with SMTP id k1so2080066wrg.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 07:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=XHp7Bo10vm0UfwNZa83vSvzkaRjk9257JvNRreDbMPA=;
 b=Ybxqwo0fDHyTWpK/Ksv241kD7QpUL096R7LyFzr+P/WWJaGMKg3MJiqZTZ5Wzw9kni
 uKVLZcBhBZXh88si/YAZRoz6/Vol73ArI0dmzXMUszp6nLyyg+iXQzIZAQB1JifZgFlw
 GDgoVP9pkCQaf+v/Ptj5+TjD4ogFXZr+FSUAvUGwiqUBhUr1BrUE7A0qbCJmXhdw0ZUA
 oid4RSWLNp4eulQbIY4eLUYC99EoaLzUfQ9EJDRgYwEnAxOqh8zKMTW8SniwEw5/qRxI
 TsFXu7nSDUcg+8H5XGa7/vKV9SalJVA0exhsgClVJevG7DqrK6gTSU48Gixs1KAP7LiY
 KZMQ==
X-Gm-Message-State: AOAM5319vQFVsd03ngv/NRH/1C++d61B3vfUNunBELIOGhz4CEWcNdIf
 8TqsvIfpOoh5iI8cegjEnoVeJYjQqrv8x7UsRLdqOCLK29g7yMHm6L4G7hBbOzp+r4WfZfAFtgS
 Z2KIoLcNi7g08dqRQKMRn0WOkhyHGUYssv+rlzUdOJw==
X-Received: by 2002:adf:f542:: with SMTP id j2mr56196wrp.107.1605195059653;
 Thu, 12 Nov 2020 07:30:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1OngyKpQAS+Q4bbI3Hywakt2LTSLrDkVsSOy8wiQ/1aW5MGElsPEZVtZPjFlyvRpBGUIsaQ==
X-Received: by 2002:adf:f542:: with SMTP id j2mr56174wrp.107.1605195059474;
 Thu, 12 Nov 2020 07:30:59 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id c129sm7158288wmd.7.2020.11.12.07.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 07:30:58 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2 05/17] clocksource/hyperv: use MSR-based access if
 running as root
In-Reply-To: <20201105165814.29233-6-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-6-wei.liu@kernel.org>
Date: Thu, 12 Nov 2020 16:30:57 +0100
Message-ID: <87d00iy4lq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Wei Liu <wei.liu@kernel.org> writes:

> Signed-off-by: Wei Liu <wei.liu@kernel.org>

In the missing commit message I'd like to see why we don't use 'TSC
page' clocksource for the root partition. My guess would be that it's
not available and actually we're supposed to use raw TSC value (because
root partitions never migrate) but please spell it out.

> ---
>  drivers/clocksource/hyperv_timer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index ba04cb381cd3..269a691bd2c4 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -426,6 +426,9 @@ static bool __init hv_init_tsc_clocksource(void)
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return false;
>  
> +	if (hv_root_partition)
> +		return false;
> +
>  	hv_read_reference_counter = read_hv_clock_tsc;
>  	phys_addr = virt_to_phys(hv_get_tsc_page());

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
