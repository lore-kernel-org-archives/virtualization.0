Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC6BC433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 16:14:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93388233CE
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 16:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93388233CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4E65E86FF7;
	Wed, 20 Jan 2021 16:14:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zPpCDSoB+xRu; Wed, 20 Jan 2021 16:14:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A802486FD8;
	Wed, 20 Jan 2021 16:14:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E8D5C08A1;
	Wed, 20 Jan 2021 16:14:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3927C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 16:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A9BFA81B19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 16:14:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id saVyp9SmV0On
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 16:14:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1D2F3847C3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 16:14:05 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id n6so11326822edt.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q3YaCJQ8LfKzkGjKHvvi/q44WKBCWlUY5g3M93ES9N4=;
 b=Qt+31s0k7Mjn6X5fLAPTZQBwGj66PX2q4gx9kZJM9UU0Fj9zKf9iGeB0nLS2LYGKMg
 LWmex1RpYlfY9c7UusCIbs5ju8pv3J++sSocIjMB0TZeXaiOMpwKWUVIWcYTMDBCKshV
 KjCry0XhhdgozhMjbeK7T8OsOyK3HHOJ+FpG/iMZXDHOmzjR91e20ux83TWKRlkXNvni
 weYgzqBxlQMq5jxc7aAh1xOhFkoVzr449eIWCGojiBzCQMwEra67oRs/VMHKqTTvdp1/
 WqdjBF3YCBKno8Fy90iju+Cvm4YwOeOtDaQ98rEw5RykZWJLVHF0vaAlgEtzzw2llV+X
 YTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q3YaCJQ8LfKzkGjKHvvi/q44WKBCWlUY5g3M93ES9N4=;
 b=n0Z6M5WD+PQ02y9D0DaIsonY45KD/23EbxBA0sTlq8qPtJ+dHfRhMQMcuKWZ5X/IUK
 fscWKUf+kf8KlUX/Kg7/9wJQuf4PyfKbQpbu46j/pjqkPKWvGqegtUvmookoJ1Kw530/
 s2J2RM+7wTzC5ctl2ZhlDhQKAxG+OvOPOY3ZtChZMBcR5lnr8NmBlrQYuAqxhQOY0tWH
 FDFGzQ11pPVk5sgZ5wyG8HyVherR3/+4c4z0Lqps9agBwaR1SrJ35EYkrTUMJxmn4q/z
 QPiW58YOC12PYv80/X/4m+9HZxve2+flY6nFrpVFMzXIyLVp5ZP5YREs9rBttUmyVDe8
 BozQ==
X-Gm-Message-State: AOAM530ibVvVIscBa/Ld7O4F8Sam9iQYRvt2cuClMJRtolCmt45Fj3o1
 hbp3mO0rR6GSRG1j7vq7jGFIq4CT6/cgWTUOrPFDOg==
X-Google-Smtp-Source: ABdhPJwSZ/KSHBr1sBpNSdWGO8It3AqUEuSIdP5w2bhyco9/KW73LkGrKMnaE5mNEUQEA2lqr+GLf+3ATR5p3G98/nA=
X-Received: by 2002:aa7:d803:: with SMTP id v3mr7702645edq.153.1611159243691; 
 Wed, 20 Jan 2021 08:14:03 -0800 (PST)
MIME-Version: 1.0
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-6-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-6-wei.liu@kernel.org>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 20 Jan 2021 11:13:28 -0500
Message-ID: <CA+CK2bBTjUWEOrFKi4pYpEe355sve6b7AjKGc7cQRRe3c-DTrQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/16] clocksource/hyperv: use MSR-based access if
 running as root
To: Wei Liu <wei.liu@kernel.org>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
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

On Wed, Jan 20, 2021 at 7:01 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> When Linux runs as the root partition, the setup required for TSC page
> is different.

Why would we need a TSC page as a clock source for root partition at
all? I think the above can be removed.

 Luckily Linux also has access to the MSR based
> clocksource. We can just disable the TSC page clocksource if Linux is
> the root partition.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/hyperv_timer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index ba04cb381cd3..269a691bd2c4 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -426,6 +426,9 @@ static bool __init hv_init_tsc_clocksource(void)
>         if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>                 return false;
>
> +       if (hv_root_partition)
> +               return false;
> +

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
