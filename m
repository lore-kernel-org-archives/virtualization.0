Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F9AC5519F
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:16:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43BC2074B
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cykmF34j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43BC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E3E288716D;
	Thu, 12 Nov 2020 15:16:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9i9cigrk_cKa; Thu, 12 Nov 2020 15:16:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 25F9787160;
	Thu, 12 Nov 2020 15:16:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07E5CC088B;
	Thu, 12 Nov 2020 15:16:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64F47C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4DD2220461
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:16:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YT-nX3-fXmUS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:16:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 7075120363
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605194196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mgdXZHtHPywKX/a9hS8LUB6+ABxOjrBQbybE/K2MyA4=;
 b=cykmF34jlNHNBZVvhoSww9Es23tWUCsSYO6XS0Sq4RE2aoD2IqMZOJHsknTKVPaAzwS/6v
 BrEuJRhe0JFySqSESnbv/rQ7dz+wJ8Jqwhyr/5aTxV60GJvq+ssLMn0BzHY0DRIjX8W6CG
 O4zFp0oR74EGGXv+DtCi6vkdWDtBpVI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-Vu8M3LZ3NAuE0V7sqTTb6Q-1; Thu, 12 Nov 2020 10:16:34 -0500
X-MC-Unique: Vu8M3LZ3NAuE0V7sqTTb6Q-1
Received: by mail-wr1-f70.google.com with SMTP id h11so2054857wrq.20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 07:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=mgdXZHtHPywKX/a9hS8LUB6+ABxOjrBQbybE/K2MyA4=;
 b=B9Fk6ibZ7aTu4OkXbs2LmCSc2dDnk15epAe5x0pH0KRaxQ1geGXX25A7d/sd+XfWft
 7LsHIxpUehP689pH2ws8XwhI8s1VbVpW/fmSriRUj2txq0+ngsS0yn70TAoQdnQMwn0l
 rmjwHBEfikvr2hvMuQAg3+wAbMWOQ/OVXEKu4NyQ9Jsz+T4yA90X44QFjHjP9ppdwMi1
 rRmjnZOTIjFV1vQemt4PP43fm15mnQbD0Rra16pg5Cdvn+qNwvZBqslP4Gl5u/GOiByj
 I/7am39EGaGxrKZ1EgAX81FqYA7aVzYTN0oDBbEYw64kpQ22w8W2xXcf8zuWUEhwVRz3
 Cw9Q==
X-Gm-Message-State: AOAM530vvMkz1rq8zVh8zC5R7gCKXalekhY8szbx3XEAMlGJe2ZgsCvw
 AwPjO9KeKkdh3VxwKIz5o/Hns2+XtZkAhNw02espMw/6Vq6Jh+U8TMHGkFf6rGlldWtyus6Z8sj
 9Pieg+i48x7c0XhUZ/uQy2247todoLFp9T5zyECJf9w==
X-Received: by 2002:a05:6000:c7:: with SMTP id
 q7mr3765123wrx.137.1605194193097; 
 Thu, 12 Nov 2020 07:16:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBsGbFGQNrYQltDNU47DH7z1aKIl9Jf7c3fN1KWHUXH5NhMqtMHL3KuLKLxVmtzHwryqqqqQ==
X-Received: by 2002:a05:6000:c7:: with SMTP id
 q7mr3765087wrx.137.1605194192885; 
 Thu, 12 Nov 2020 07:16:32 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id y11sm6415716wmj.36.2020.11.12.07.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 07:16:32 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2 02/17] x86/hyperv: detect if Linux is the root partition
In-Reply-To: <20201105165814.29233-3-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-3-wei.liu@kernel.org>
Date: Thu, 12 Nov 2020 16:16:30 +0100
Message-ID: <87lff6y59t.fsf@vitty.brq.redhat.com>
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
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
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

> For now we can use the privilege flag to check. Stash the value to be
> used later.
>
> Put in a bunch of defines for future use when we want to have more
> fine-grained detection.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/hv_init.c          |  4 ++++
>  arch/x86/include/asm/hyperv-tlfs.h | 10 ++++++++++
>  arch/x86/include/asm/mshyperv.h    |  2 ++
>  arch/x86/kernel/cpu/mshyperv.c     | 16 ++++++++++++++++
>  4 files changed, 32 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e04d90af4c27..533fe9e887f2 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -26,6 +26,10 @@
>  #include <linux/syscore_ops.h>
>  #include <clocksource/hyperv_timer.h>
>  
> +/* Is Linux running as the root partition? */
> +bool hv_root_partition;
> +EXPORT_SYMBOL_GPL(hv_root_partition);

(Nitpick and rather a personal preference): I'd prefer
'hv_partition_is_root' for a boolean.

> +
>  void *hv_hypercall_pg;
>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
>  
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 0ed20e8bba9e..41b628b9fb15 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -21,6 +21,7 @@
>  #define HYPERV_CPUID_FEATURES			0x40000003
>  #define HYPERV_CPUID_ENLIGHTMENT_INFO		0x40000004
>  #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
> +#define HYPERV_CPUID_CPU_MANAGEMENT_FEATURES	0x40000007
>  #define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
>  
>  #define HYPERV_HYPERVISOR_PRESENT_BIT		0x80000000
> @@ -103,6 +104,15 @@
>  /* Recommend using enlightened VMCS */
>  #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED		BIT(14)
>  
> +/*
> + * CPU management features identification.
> + * These are HYPERV_CPUID_CPU_MANAGEMENT_FEATURES.EAX bits.
> + */
> +#define HV_X64_START_LOGICAL_PROCESSOR			BIT(0)
> +#define HV_X64_CREATE_ROOT_VIRTUAL_PROCESSOR		BIT(1)
> +#define HV_X64_PERFORMANCE_COUNTER_SYNC			BIT(2)
> +#define HV_X64_RESERVED_IDENTITY_BIT			BIT(31)
> +
>  /*
>   * Virtual processor will never share a physical core with another virtual
>   * processor, except for virtual processors that are reported as sibling SMT
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ffc289992d1b..ac2b0d110f03 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -237,6 +237,8 @@ int hyperv_fill_flush_guest_mapping_list(
>  		struct hv_guest_mapping_flush_list *flush,
>  		u64 start_gfn, u64 end_gfn);
>  
> +extern bool hv_root_partition;

Eventually this is not going to be an x86 only thing I believe?

> +
>  #ifdef CONFIG_X86_64
>  void hv_apic_init(void);
>  void __init hv_init_spinlocks(void);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 05ef1f4550cb..f7633e1e4c82 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -237,6 +237,22 @@ static void __init ms_hyperv_init_platform(void)
>  	pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
>  		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
>  
> +	/*
> +	 * Check CPU management privilege.
> +	 *
> +	 * To mirror what Windows does we should extract CPU management
> +	 * features and use the ReservedIdentityBit to detect if Linux is the
> +	 * root partition. But that requires negotiating CPU management
> +	 * interface (a process to be finalized).
> +	 *
> +	 * For now, use the privilege flag as the indicator for running as
> +	 * root.
> +	 */
> +	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_CPU_MANAGEMENT) {

We may want to cache cpuid_ebx(HYPERV_CPUID_FEATURES) somewhere but we
already had a discussion regading naming for these caches and decided to
wait until TLFS for ARM is out so we don't need to rename again.

> +		hv_root_partition = true;
> +		pr_info("Hyper-V: running as root partition\n");
> +	}
> +
>  	/*
>  	 * Extract host information.
>  	 */

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
