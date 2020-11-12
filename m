Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAE6C56201
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 16:44:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315AA22227
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 16:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iz/k5B0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315AA22227
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 82F3E877C1;
	Thu, 12 Nov 2020 16:44:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tczbn4Iqz2ll; Thu, 12 Nov 2020 16:44:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F0C70877C3;
	Thu, 12 Nov 2020 16:44:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D767CC0889;
	Thu, 12 Nov 2020 16:44:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC2D4C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 16:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 78F082E209
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 16:44:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6lCtE2Id8xlM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 16:44:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 973442036C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605199493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oBaJhrVAS26Rm76b8qfX/jPZQo0xctgs1+BzsCLEDzc=;
 b=iz/k5B0xNQWja3Ml7pVT02uN8jbb0++Vtf14EtConmEyPZEsxrcLYXzMu6h7ILD0BMD79M
 gdoGVC3ZrkTkQDl4BoPVgVUzrx7UjWowNwHWJc6s33zlfBN9pUlERoBzNsZKJmwfaNYQaP
 Tkyc8H0RsjC147frFdqBsvxK//Ux70A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-pc9ViHAwPxuGCTldgmL-CA-1; Thu, 12 Nov 2020 11:44:51 -0500
X-MC-Unique: pc9ViHAwPxuGCTldgmL-CA-1
Received: by mail-wm1-f72.google.com with SMTP id a130so3992548wmf.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 08:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=oBaJhrVAS26Rm76b8qfX/jPZQo0xctgs1+BzsCLEDzc=;
 b=sMd4OYooy9QKJ8CdDbw+0gSNYDuHCvbWaUVVyYXS+BJcc1Gc4uFHxQB6NIPO7SKuk1
 K3qGkd/cJ5Jxb5V0K/O2ZIrAym6ZMVjPKOIQ+lVJUbdkKiDjTIHwCuS+ntmc8Qrr5bMM
 22Gz6bzk4OwhrdLeVL7I0bY35Ea1Lnlv9aRX8Y5ErE2qBzg+sh2smVPgPtbrv3gS/DHG
 UFmxPp1eYP5oYSXGDS8Fht2aEjpzk6YqhoOiwTgOVcxg3dC9kP+RFQmLBsxn68VjvXGP
 DRTTXXs8ecEqdF8LntcwivDZgJDY6KIhhWHlJmIfu06+xj0zQIlaKlOpEy2CMfLXUaWz
 I+0w==
X-Gm-Message-State: AOAM532fVwpScOxcF3HGiKk88S+kgnmFEWAGMVOQEm5kW2rzQ2H3O57F
 /fDXJX+Ky78QmZDA30ug1d24PGVn4xECh96DV5nJFE3o+5VsReaFNjCBvDv5sF/6SgVK1yjOTLu
 Iena7lks2i4keJ+4Gn4EFr0SObCg78mulNes3BGSt8Q==
X-Received: by 2002:a1c:ddd7:: with SMTP id u206mr509462wmg.27.1605199490672; 
 Thu, 12 Nov 2020 08:44:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwejZcKtx6F+o5hHeSMVHcvBzx8/ntsqvQ7ohWy6THyGvnfCHkeEWFtHXBT1nj5ZKtcZTpVUA==
X-Received: by 2002:a1c:ddd7:: with SMTP id u206mr509445wmg.27.1605199490460; 
 Thu, 12 Nov 2020 08:44:50 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id m3sm3190396wrv.6.2020.11.12.08.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 08:44:49 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2 10/17] x86/hyperv: implement and use hv_smp_prepare_cpus
In-Reply-To: <20201105165814.29233-11-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-11-wei.liu@kernel.org>
Date: Thu, 12 Nov 2020 17:44:48 +0100
Message-ID: <87y2j6wmm7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H.
 Peter Anvin" <hpa@zytor.com>, Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Borislav Petkov <bp@alien8.de>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Lillian Grassin-Drake <ligrassi@microsoft.com>
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

> Microsoft Hypervisor requires the root partition to make a few
> hypercalls to setup application processors before they can be used.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> CPU hotplug and unplug is not yet supported in this setup, so those
> paths remain untouched.
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index f7633e1e4c82..4795e54550e6 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -31,6 +31,7 @@
>  #include <asm/reboot.h>
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
> +#include <asm/numa.h>
>  
>  struct ms_hyperv_info ms_hyperv;
>  EXPORT_SYMBOL_GPL(ms_hyperv);
> @@ -208,6 +209,30 @@ static void __init hv_smp_prepare_boot_cpu(void)
>  	hv_init_spinlocks();
>  #endif
>  }
> +
> +static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +#if defined(CONFIG_X86_64)

'#ifdef CONFIG_X86_64' is equally good as you can't compile x86_64
support as a module :-)

> +	int i;
> +	int ret;
> +
> +	native_smp_prepare_cpus(max_cpus);
> +

So hypotetically, if hv_root_partition is true but 'ifdef CONFIG_X86_64'
is false, we won't even be doing native_smp_prepare_cpus()? This doesn't
sound right. Either move it outside of #ifdef or put the #ifdef around
'smp_ops.smp_prepare_cpus' assignment too.

> +	for_each_present_cpu(i) {
> +		if (i == 0)
> +			continue;
> +		ret = hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(i));
> +		BUG_ON(ret);
> +	}
> +
> +	for_each_present_cpu(i) {
> +		if (i == 0)
> +			continue;
> +		ret = hv_call_create_vp(numa_cpu_node(i), hv_current_partition_id, i, i);
> +		BUG_ON(ret);
> +	}
> +#endif
> +}
>  #endif
>  
>  static void __init ms_hyperv_init_platform(void)
> @@ -364,6 +389,8 @@ static void __init ms_hyperv_init_platform(void)
>  
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
> +	if (hv_root_partition)
> +		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
>  # endif
>  
>  	/*

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
