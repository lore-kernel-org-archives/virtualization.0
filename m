Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A6BC433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 17:08:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2722D233EB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 17:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2722D233EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 81C7985C28;
	Wed, 20 Jan 2021 17:08:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hIM4ma2XISnQ; Wed, 20 Jan 2021 17:08:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A98DC859BE;
	Wed, 20 Jan 2021 17:08:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B1AAC088B;
	Wed, 20 Jan 2021 17:08:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BD25C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 17:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 72047203A6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 17:08:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lAakBm36KTeL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 17:08:54 +0000 (UTC)
X-Greylist: delayed 01:04:59 by SQLgrey-1.7.6
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by silver.osuosl.org (Postfix) with ESMTPS id 2353520397
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 17:08:54 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id a10so17922511ejg.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 09:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qaBbcFFWtwH73KKkHPV2dAAEp83v3RAFbPyaNgV/jIA=;
 b=on1TzcIQfB0S+jMkItagEJtX8hz1tNnjBcnUtaJWlF9V6USnFvBrmlsf+hgKeuoHzg
 fHXarQilEi/Z1srXltN0diMlHMbSDa0P1lRdEw2fafXT9lYdDcUCNJCdWXc9aXmvvjie
 BRVYlaez6uS7Xpon2IXP3iVJMV1PHrWsQXZ6PAA0SdZLYh31u/j2HbzbttRSevVbCqn+
 nV8DpomSlRxtSnh4hLOliPHOECsNLhUPi2JYLCTO8X+jnNqakzuTardr31/bn0B45K6K
 jm0UELIHadLwshBArvF3Layo+XQsGrbgjxf7OiPKuwCJKVR/XQjK2YcWIJM1l5VjgATz
 ksiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qaBbcFFWtwH73KKkHPV2dAAEp83v3RAFbPyaNgV/jIA=;
 b=Rio40A2aI8ZWLOdJQIs74UEC6UpsMbpguR6LtCK1CHFy0vupG1Ssr8PTy1EbntmxZH
 2FRepOZGEYe3yxvw1v17ZxZoUqmcbxWTk7qDNDSwvmSs3BHqjhemRVJccR7buY2NCFQi
 9GNkKyXy32bhGD6tVeUASZ4BZVnn4S1K1cfZtzuPZ6DE6iWZ1VJGgc4K59AfsRIm16WB
 xX621xz6GwVR7+KfrCEZPRBT1VgCrgsg2F3T6VJXmJMVxligPEQALzhFq8zvhWwRvqDU
 KibbQD5TZrHYUCWGOolR87Qmmp7eWCqd/gJlqYep2VCmTOu8rvX0zo08ZaVpaFdXgjyw
 8d9w==
X-Gm-Message-State: AOAM5304VgQ/FzBBEzSau2MXaDQYZypGvxmm91wjHK3a0i6oTccoGAsZ
 o47B9YpHDsYFsJLFPbvabRMdiEELdNf7eSk1YTwSex0AacLiEg==
X-Google-Smtp-Source: ABdhPJz49BI1HhzhHVlsG76ZtgvDppRgVafvcapbZeJzfe0AK+OqaaTzGsJ0BE7BJebcMbhE517Q3MPcEI8WBx1tDMA=
X-Received: by 2002:a17:906:eb95:: with SMTP id
 mh21mr6793469ejb.175.1611158633954; 
 Wed, 20 Jan 2021 08:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-3-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-3-wei.liu@kernel.org>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 20 Jan 2021 11:03:18 -0500
Message-ID: <CA+CK2bDHYxTr_ttbC88u1OvT-=cm5do5RmyoxC+joz=GjK1WtA@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] x86/hyperv: detect if Linux is the root partition
To: Wei Liu <wei.liu@kernel.org>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
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

On Wed, Jan 20, 2021 at 7:01 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> For now we can use the privilege flag to check. Stash the value to be
> used later.
>
> Put in a bunch of defines for future use when we want to have more
> fine-grained detection.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v3: move hv_root_partition to mshyperv.c
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 10 ++++++++++
>  arch/x86/include/asm/mshyperv.h    |  2 ++
>  arch/x86/kernel/cpu/mshyperv.c     | 20 ++++++++++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 6bf42aed387e..204010350604 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -21,6 +21,7 @@
>  #define HYPERV_CPUID_FEATURES                  0x40000003
>  #define HYPERV_CPUID_ENLIGHTMENT_INFO          0x40000004
>  #define HYPERV_CPUID_IMPLEMENT_LIMITS          0x40000005
> +#define HYPERV_CPUID_CPU_MANAGEMENT_FEATURES   0x40000007
>  #define HYPERV_CPUID_NESTED_FEATURES           0x4000000A
>
>  #define HYPERV_CPUID_VIRT_STACK_INTERFACE      0x40000081
> @@ -110,6 +111,15 @@
>  /* Recommend using enlightened VMCS */
>  #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED            BIT(14)
>
> +/*
> + * CPU management features identification.
> + * These are HYPERV_CPUID_CPU_MANAGEMENT_FEATURES.EAX bits.
> + */
> +#define HV_X64_START_LOGICAL_PROCESSOR                 BIT(0)
> +#define HV_X64_CREATE_ROOT_VIRTUAL_PROCESSOR           BIT(1)
> +#define HV_X64_PERFORMANCE_COUNTER_SYNC                        BIT(2)
> +#define HV_X64_RESERVED_IDENTITY_BIT                   BIT(31)
> +
>  /*
>   * Virtual processor will never share a physical core with another virtual
>   * processor, except for virtual processors that are reported as sibling SMT
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ffc289992d1b..ac2b0d110f03 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -237,6 +237,8 @@ int hyperv_fill_flush_guest_mapping_list(
>                 struct hv_guest_mapping_flush_list *flush,
>                 u64 start_gfn, u64 end_gfn);
>
> +extern bool hv_root_partition;
> +
>  #ifdef CONFIG_X86_64
>  void hv_apic_init(void);
>  void __init hv_init_spinlocks(void);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index f628e3dc150f..c376d191a260 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -32,6 +32,10 @@
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
>
> +/* Is Linux running as the root partition? */
> +bool hv_root_partition;
> +EXPORT_SYMBOL_GPL(hv_root_partition);
> +
>  struct ms_hyperv_info ms_hyperv;
>  EXPORT_SYMBOL_GPL(ms_hyperv);
>
> @@ -237,6 +241,22 @@ static void __init ms_hyperv_init_platform(void)
>         pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
>                  ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
>
> +       /*
> +        * Check CPU management privilege.
> +        *
> +        * To mirror what Windows does we should extract CPU management
> +        * features and use the ReservedIdentityBit to detect if Linux is the
> +        * root partition. But that requires negotiating CPU management
> +        * interface (a process to be finalized).

Is this comment relevant? Do we have to mirror what Windows does?

> +        *
> +        * For now, use the privilege flag as the indicator for running as
> +        * root.
> +        */
> +       if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_CPU_MANAGEMENT) {
> +               hv_root_partition = true;
> +               pr_info("Hyper-V: running as root partition\n");
> +       }
> +

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

>         /*
>          * Extract host information.
>          */
> --
> 2.20.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
