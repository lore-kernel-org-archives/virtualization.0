Return-Path: <SRS0=Zxjt=CY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1021AC43461
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 10:17:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769F521D24
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 10:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFSgoida"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769F521D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1B18286691;
	Tue, 15 Sep 2020 10:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HwiVxXn-IA5D; Tue, 15 Sep 2020 10:17:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 658B086689;
	Tue, 15 Sep 2020 10:17:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52E92C0864;
	Tue, 15 Sep 2020 10:17:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31F8DC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 10:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2781886228
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 10:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jjuuzpa7mAgg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 10:17:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D841F85EAF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600165023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lvDxiNfszvjzZ71NMuSHhOpWhvbYiEYO1BfYGhw1hYw=;
 b=bFSgoidacUQBpsh3c7jcYbCvWPPpmd6JXw+fsdVD4t4bEjhiB1AznJQIX/T3PQZGRoroYp
 ew3yYdKKauo2MiqLn0QuL3dbNAbCJVZJ94n1tfw1GY6cchS0QbIhroAk9Wn9lXECsK1k4o
 9lvpoRv1CSNP1S9uiG+CC2s0yhL2mHA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-RchgA8-sOf-fJrU0ID3imw-1; Tue, 15 Sep 2020 06:17:02 -0400
X-MC-Unique: RchgA8-sOf-fJrU0ID3imw-1
Received: by mail-wr1-f71.google.com with SMTP id 33so1039510wrk.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 03:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=lvDxiNfszvjzZ71NMuSHhOpWhvbYiEYO1BfYGhw1hYw=;
 b=J2bkTZkjD5gWvw3qG4Xp+VarkhS7uv8sA1p4eqQDkHMTv5fRfq3Jlo/EBYLgzwZ+bR
 7VbiAJD0sRvZ247bYDRf4QKHuB8FQhRgVnnPf51Gov4vlZhJr9KkxElYJHNcDboWFvMz
 kwu1GQMTJHJxMz2SGv71jGRHveLXfjgxQKU8nnOizpTWLlibdpuXhVESmLntNPN9h7NZ
 xNF2gNqbJd0wskLF4dA7Ifpve16cX6im66lTAANFpFJ7pEy//PUJ2UjEvilgs7jrEfUd
 WFEbBinXvJSIfaHdZvGzgmnEXx7c4owMyUFtbn5alCA8U+N97xgDeNfK3Ne7Z7qRZC+V
 a8fw==
X-Gm-Message-State: AOAM533EbrdLvWExb/YyGkJZ7JyAP66bQ6AYZFguwYaNXc/Dm956Qetj
 tsk7bkg5jfq/+yV6e9oCGDnmZCb+KvNLaz2fMHZdLhLT+yNZFkEsl7r0tfmK0+CS4yNSKuhaGRb
 7/6KAyDs0yiqu8RFhslyuq27R5Wzr39Eje80Ax/ZLOg==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr20381520wrt.160.1600165020818; 
 Tue, 15 Sep 2020 03:17:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbSRV/JarLXH4jdQkPEdpmjY/jHaczd6pEh5Z7HCZ1RyRuon98yVLOetuc0w33FBKkbh666g==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr20381495wrt.160.1600165020611; 
 Tue, 15 Sep 2020 03:17:00 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id t17sm1559921wrx.82.2020.09.15.03.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 03:17:00 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH RFC v1 06/18] x86/hyperv: allocate output arg pages if
 required
In-Reply-To: <20200914112802.80611-7-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-7-wei.liu@kernel.org>
Date: Tue, 15 Sep 2020 12:16:58 +0200
Message-ID: <871rj3l4yt.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0.004
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

> When Linux runs as the root partition, it will need to make hypercalls
> which return data from the hypervisor.
>
> Allocate pages for storing results when Linux runs as the root
> partition.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/hv_init.c       | 45 +++++++++++++++++++++++++++++----
>  arch/x86/include/asm/mshyperv.h |  1 +
>  2 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index cac8e4c56261..ebba4be4185d 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -45,6 +45,9 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>  void  __percpu **hyperv_pcpu_input_arg;
>  EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>  
> +void  __percpu **hyperv_pcpu_output_arg;
> +EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
> +
>  u32 hv_max_vp_index;
>  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>  
> @@ -75,14 +78,29 @@ static int hv_cpu_init(unsigned int cpu)
>  	u64 msr_vp_index;
>  	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
>  	void **input_arg;
> -	struct page *pg;
> +	struct page *input_pg;
>  
>  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> -	pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
> -	if (unlikely(!pg))
> +	input_pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
> +	if (unlikely(!input_pg))
>  		return -ENOMEM;
> -	*input_arg = page_address(pg);
> +	*input_arg = page_address(input_pg);
> +
> +	if (hv_root_partition) {
> +		struct page *output_pg;
> +		void **output_arg;
> +
> +		output_pg = alloc_page(irqs_disabled() ? GFP_ATOMIC :
>  	GFP_KERNEL);

To simplify the code, can we just rename 'input_arg' to 'hypercall_args'
and do alloc_pages(rqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, 1) to
allocate two pages above?

> +		if (unlikely(!output_pg)) {
> +			free_page((unsigned long)*input_arg);
> +			*input_arg = NULL;
> +			return -ENOMEM;
> +		}
> +
> +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		*output_arg = page_address(output_pg);
> +	}
>  
>  	hv_get_vp_index(msr_vp_index);
>  
> @@ -209,14 +227,25 @@ static int hv_cpu_die(unsigned int cpu)
>  	unsigned int new_cpu;
>  	unsigned long flags;
>  	void **input_arg;
> -	void *input_pg = NULL;
> +	void *input_pg = NULL, *output_pg = NULL;
>  
>  	local_irq_save(flags);
>  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	input_pg = *input_arg;
>  	*input_arg = NULL;
> +
> +	if (hv_root_partition) {
> +		void **output_arg;
> +
> +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		output_pg = *output_arg;
> +		*output_arg = NULL;
> +	}
> +
>  	local_irq_restore(flags);
> +
>  	free_page((unsigned long)input_pg);
> +	free_page((unsigned long)output_pg);
>  
>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> @@ -350,6 +379,12 @@ void __init hyperv_init(void)
>  
>  	BUG_ON(hyperv_pcpu_input_arg == NULL);
>  
> +	/* Allocate the per-CPU state for output arg for root */
> +	if (hv_root_partition) {
> +		hyperv_pcpu_output_arg = alloc_percpu(void  *);
					redundant space ^^^^^

> +		BUG_ON(hyperv_pcpu_output_arg == NULL);
> +	}
> +
>  	/* Allocate percpu VP index */
>  	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
>  				    GFP_KERNEL);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 2a2cc81beac6..f5c62140f28d 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -63,6 +63,7 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
>  #if IS_ENABLED(CONFIG_HYPERV)
>  extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
> +extern void  __percpu  **hyperv_pcpu_output_arg;
>  
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
