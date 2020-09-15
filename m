Return-Path: <SRS0=Zxjt=CY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111AEC43461
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 11:14:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA1621D7B
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 11:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuPt6Fxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA1621D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 094D187148;
	Tue, 15 Sep 2020 11:14:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fx8vp3Rp97ZV; Tue, 15 Sep 2020 11:14:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1D16B87131;
	Tue, 15 Sep 2020 11:14:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3D30C0859;
	Tue, 15 Sep 2020 11:14:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20210C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1C310860C1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:14:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n5d2x-VWQuZZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:14:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F24BC85C4F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600168463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yepvtMKn+6+XBcz8DK1yijuVwPuVaYyQMfi00UvSTyw=;
 b=cuPt6Fxlr0IjcEMbApoGXh5BDM3Kys5oMUsHq6h52vMrmonf4QxJt6s3uUGB+vHwx7g0cV
 o4H2TqBF8fhDEgDvwZr+cwIeNQWkcWshmdeJasdc8+UAFWVat94p85vAWMVOFBPg4P7egv
 iHxX8TdsWRO8jlyz+th85CXDf7tpmPQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-j1WUNbT0P6-2P9-ExD9krw-1; Tue, 15 Sep 2020 07:14:20 -0400
X-MC-Unique: j1WUNbT0P6-2P9-ExD9krw-1
Received: by mail-wm1-f69.google.com with SMTP id x81so773861wmg.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 04:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=yepvtMKn+6+XBcz8DK1yijuVwPuVaYyQMfi00UvSTyw=;
 b=G+bkuSqZKrZGQjeWvYlHa65hmRDC93iXzS+kWFnrIoFq3FR2vGEOJNlIr3RhJ2RMPC
 2bVZDrnAg6Tb0dMFzt2xJrx40Nyh/BsaOp9DiBNcJRvw6e/3yMPwfsblv26lOuMboZbw
 0pvHJGRASOtKYImQYUwdnE2sTbJRQT3fLR+VkKVpbljnic/20uJcOEvTxHgiSP90TtLE
 tXmcRvpJhxeDUPLsDaa+8ndrDgEaQdHihtt0MCMdu5ohWfkChm8wEY3kddXdiunm+1Ua
 VxUEibxxVUb9EreneGgynpI9EvwOH/KhA/P+DMud7eix29SM0cpSLzPj8EeYCdV8mIiE
 0ckg==
X-Gm-Message-State: AOAM5302xSWzn+kGVGxszA0gzCnW5NiM1o6yFfxCR6s+az0+SBfNXZ1+
 1dW4Nvc1UqL8337QVnw5FB4TVeWOw7Ms9Sr/zp/OXsZMEj48bqMXs+w9oGTxobS+/Df4/R4XeJl
 wNQuM4YLlxMw5v/sNyAbaGCvOw/s79pQfBnTxjKcTXA==
X-Received: by 2002:a1c:2403:: with SMTP id k3mr4031966wmk.153.1600168458786; 
 Tue, 15 Sep 2020 04:14:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOzi3Ja62k21YvM26bciVJnHAtZqdXuOel1sIRIJNA9BcjPXAZhIRYZguDOvo2rTnyovo1Uw==
X-Received: by 2002:a1c:2403:: with SMTP id k3mr4031937wmk.153.1600168458576; 
 Tue, 15 Sep 2020 04:14:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id o6sm27250404wrm.76.2020.09.15.04.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 04:14:18 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH RFC v1 10/18] x86/hyperv: implement and use
 hv_smp_prepare_cpus
In-Reply-To: <20200914115928.83184-2-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914115928.83184-2-wei.liu@kernel.org>
Date: Tue, 15 Sep 2020 13:14:16 +0200
Message-ID: <87mu1rjnqv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Nuno Das Neves <nudasnev@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Borislav Petkov <bp@alien8.de>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>,
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
> index 1bf57d310f78..7522cae02759 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -203,6 +203,31 @@ static void __init hv_smp_prepare_boot_cpu(void)
>  	hv_init_spinlocks();
>  #endif
>  }
> +
> +static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +#if defined(CONFIG_X86_64)

I think it makes little sense to try to make Linux work as Hyper-V root
partition when !CONFIG_X86_64. If we still care about Hyper-V enablement
for !CONFIG_X86_64 we can probably introduce something like
CONFIG_HYPERV_ROOT and enable it automatically, e.g.

config HYPERV_ROOT
        def_bool HYPERV && X86_64

and use it instead.

> +	int i;
> +	int vp_index = 1;
> +	int ret;
> +
> +	native_smp_prepare_cpus(max_cpus);
> +
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
> +		ret = hv_call_create_vp(numa_cpu_node(i), hv_current_partition_id, vp_index++, i);

So vp_index variable is needed here to make sure there are no gaps? (or
we could've just used 'i')?

> +		BUG_ON(ret);
> +	}
> +#endif
> +}
>  #endif
>  
>  static void __init ms_hyperv_init_platform(void)
> @@ -359,6 +384,8 @@ static void __init ms_hyperv_init_platform(void)
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
