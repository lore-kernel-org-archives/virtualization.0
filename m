Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347ECC2D0A3
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:35:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E572224B
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiQIDqhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E572224B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 21119877FF;
	Thu, 12 Nov 2020 15:35:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ASYimzyi-4xu; Thu, 12 Nov 2020 15:35:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 90D5787800;
	Thu, 12 Nov 2020 15:35:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A796C088B;
	Thu, 12 Nov 2020 15:35:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68FC6C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5CA2D87800
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:35:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jrej3Q-xASZT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:35:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A8452877FF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605195353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kY0AiU5FU6oVbA1XAM3cZ9/C4ZQ8vxNIxYPcv88wzRE=;
 b=iiQIDqhPJjxo+gbWGltOR3qhNy2trAZqsHDL7nln0VJ33o6VhJQBBwC2zg+DpTXIvASdye
 ofLV/7IdB46xDbFi1lNh0Pc/SH6gph5S0aMmb7BwGcnDbsUnW696+841KTDOuTG2l4Nah9
 aC9JcXg5P1x9eKokbLfuqXTW41oAdow=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-I9fgOvdEM42EjhO_acLvLQ-1; Thu, 12 Nov 2020 10:35:52 -0500
X-MC-Unique: I9fgOvdEM42EjhO_acLvLQ-1
Received: by mail-wr1-f70.google.com with SMTP id k1so2086598wrg.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 07:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=kY0AiU5FU6oVbA1XAM3cZ9/C4ZQ8vxNIxYPcv88wzRE=;
 b=dEkAeFcTT2wecrrSmzHaEWhN+h6y9tfZEmCqBg54jh7VD1dk2O2l/IXTYIyF2WvC5R
 I2EBgjWgtZSaDibf42Sn9PChlM6+fnVY6s8/+1/E/BCwO3M/7gSKJiw2XrDMG7m1Dckg
 1+mn65U00ASf5b9ZwTzwTpkSmOULF7PXR8RjoMmYbvH5+mki88vY7j4VL5PK/YxReRjI
 vyAD3fUgJJC6mZ3Z8PhGjnerAoQVQPCc0fmyJ9EMPMq+uXLewf5O+9Np+RhDoWu8ihMq
 v3xRlJhnCbBkOlf4ru2KrYFSlqhxuRORVn3lEf2t7uBY4GX9to+b5PUUdKR62DElC3IK
 zDPw==
X-Gm-Message-State: AOAM533dGIHjapW4r+q/HhYKILeR0vNnX1RS2G0CUYrSOupaQz3h/8c1
 ARJuYB1m5VK0y+DG9fOpqLxXqHO2XBVJSlvwEgXo9WzkBooKF7/yjGlGOscnxs5ee716WwGZaAr
 OVZGr4pu19VtTqTwNvI+1cMeisxjFqB3EKHtWye/a1w==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr60527wrv.299.1605195350614;
 Thu, 12 Nov 2020 07:35:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyX+g1Xxy4OaSz6R8CmLM779s2IPaL2uIDtQKDL0WAaJDiYdwAr+Qec54DwIygNSmyCPc/rjA==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr60496wrv.299.1605195350447;
 Thu, 12 Nov 2020 07:35:50 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id 60sm4066744wrs.69.2020.11.12.07.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 07:35:49 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2 06/17] x86/hyperv: allocate output arg pages if required
In-Reply-To: <20201105165814.29233-7-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-7-wei.liu@kernel.org>
Date: Thu, 12 Nov 2020 16:35:48 +0100
Message-ID: <87a6vmy4dn.fsf@vitty.brq.redhat.com>
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
> v2: Address Vitaly's comments
> ---
>  arch/x86/hyperv/hv_init.c       | 35 ++++++++++++++++++++++++++++-----
>  arch/x86/include/asm/mshyperv.h |  1 +
>  2 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 533fe9e887f2..7a2e37f025b0 100644
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
> @@ -77,12 +80,19 @@ static int hv_cpu_init(unsigned int cpu)
>  	void **input_arg;
>  	struct page *pg;
>  
> -	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> -	pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
> +	pg = alloc_pages(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, hv_root_partition ? 1 : 0);
>  	if (unlikely(!pg))
>  		return -ENOMEM;
> +
> +	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	*input_arg = page_address(pg);
> +	if (hv_root_partition) {
> +		void **output_arg;
> +
> +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		*output_arg = page_address(pg + 1);
> +	}
>  
>  	hv_get_vp_index(msr_vp_index);
>  
> @@ -209,14 +219,23 @@ static int hv_cpu_die(unsigned int cpu)
>  	unsigned int new_cpu;
>  	unsigned long flags;
>  	void **input_arg;
> -	void *input_pg = NULL;
> +	void *pg;
>  
>  	local_irq_save(flags);
>  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> -	input_pg = *input_arg;
> +	pg = *input_arg;
>  	*input_arg = NULL;
> +
> +	if (hv_root_partition) {
> +		void **output_arg;
> +
> +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		*output_arg = NULL;
> +	}
> +
>  	local_irq_restore(flags);
> -	free_page((unsigned long)input_pg);
> +
> +	free_page((unsigned long)pg);
>  

Hm, but in case we've allocated output_arg, don't we need to do
	free_pages((unsigned long)pg, 1);

instead?

>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> @@ -350,6 +369,12 @@ void __init hyperv_init(void)
>  
>  	BUG_ON(hyperv_pcpu_input_arg == NULL);
>  
> +	/* Allocate the per-CPU state for output arg for root */
> +	if (hv_root_partition) {
> +		hyperv_pcpu_output_arg = alloc_percpu(void *);
> +		BUG_ON(hyperv_pcpu_output_arg == NULL);
> +	}
> +
>  	/* Allocate percpu VP index */
>  	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
>  				    GFP_KERNEL);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ac2b0d110f03..62d9390f1ddf 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -76,6 +76,7 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
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
