Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CB1A3179
	for <virtualization@lists.linux.dev>; Wed,  7 Jan 2026 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767817167; cv=none; b=mm6Q6VqmUhAZFr6tCIR5aqM6HvdaNfKfRQGPT+zcsbpvckT5b1NZBbGPfqPlcPBZhIrtvEl2htX/6Pqksd0EUVlRBkgmJM/xGKR1lqz4hfwn8NHskm3TZFBgnLPPtR9Kle+9lQ48Tbf0kRoy6JBmqrfY7TwsiGmgalseFMr7JO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767817167; c=relaxed/simple;
	bh=WgO72s1ynGcwkNsytWGBOWu6FCETUWC+LF6+sDMT2sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrlktbRufBtSCfuDjkoLCEKezWqVxO7uVrVNIwGtbVjoC89Dw7b19FwtiDggenbKirzBIn53gw3I6aROoDYpavDU4Mn6hl2n4vQV5xIkicp3DCNrgzuDWGIMAgGl0R0WEVM/kopBo/V0aSS7EaDQ3KaaoHDrCeBSlsJuhn11s3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KIdgyZBP; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KIdgyZBP"
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-88fe44cce7eso19678816d6.3
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 12:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767817165; x=1768421965;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+D0U0I/QMaRvqdVI4kOajEvXFaO+vpLvikp7KFwDvI=;
        b=kI2gMcg5Vp9WDREQwreM95RHtG/i+WGFTuqhot0/5iNlF4hhKbCWHuwEzs7lW+IQ1p
         6gsWEC2PMILAPDAHTjfkWGP82OimeAHhh6yKIYzkcCjJm8ww2YybsME4nVtXzNFvCqgm
         U4eW59cnDfFxT1RpLjT0nDow0lXnejFtd4ft5matnZ8RMtBkZ48ERdjh4EDwE7Ex6kvt
         4vbXxWqiqhuAMgj6VTyJZtVrLiRZmq8gFoofssq4fH77EyjPmdKc2S5k5WKzNalN1pJb
         5ZQm3OFyxRlRD3TJEyReW1KqYNCg4KDOdWFJ7uIpfj/F4FCf4E7dUdTZj8T3PidZsXSU
         EIwA==
X-Forwarded-Encrypted: i=1; AJvYcCUb3WOv+fWSp/fbi3KzscFuaSgbYHZxoI8nQNz1cjiUtvop7XYChsVdm0S2q4vw9NOP6Wn7ws973ukEGlvO1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxI8kjf1avJ3iaNHFaHvmzsEJe5YZUV4CYBK8vfCmi2Bhn+iuT/
	2YnhFu7CtJ6W4F1GqVMb6r30XDoQmMoFVa+4xGZbS97b3E3k1McgtQFwFd7h3yfEPMev3W9mYmk
	k483inO8nLJRwru0NAig8UnWN8pVFf0V0ggZhb0OhOC/4p1E2fu56sbxZ1Ezs42s5P3hlZSL62p
	LB7rfdP5GZTIoJg7dN0piQnaL40wg6FfjwhdioZfjFNOUaSdNNJyy1KGjgNHzDlC6bkCLy/ycsn
	V2sb7xjzphMKd0ffYaXtCPpMQ==
X-Gm-Gg: AY/fxX6fwobnVNV1cy16v+cSH4fv9mhLaM/X8GAaPG7evGw43cRF2UuHr/kZ9i8pFPb
	/JJaa0ffWEqFJs1x54OPBfFm+NvFWjH3EahDF9fWljtpM2Ulnbu/tzLQ6D53ER1P8Ho9Q1ZhRwS
	PyOycAHpGNxcCbD8lBnMPh0vZYSI8Hq7uh87IV/b8Uatqp2z0f7c69sqcLzh4jX3pxPizs36Wve
	oHYD/TRzyqokZX/NRbPS4JENxjiV/6Z5fSHo5I5CNeVTrQasliKE0Y0sD2qfhTmz8xaqd3oKSyK
	+DqPA/725lI9Cae/FyTLEljpH3GY41mYxySZHCMLHY0OaWZEQlW7dShVSpzO/5BtKnMi0aDoRdH
	LbechO6j08IRT0Z57iHlZDEbJrNj8bntCHNhBasPfFgVvAK4Gpiyy0yV/KB2y/o4pMNaNMz8gP/
	6UwwwuMX2eTjAHY99gko/nqqC9A7dqLhFfdg4kryUW4uMtROPA/g4=
X-Google-Smtp-Source: AGHT+IEVTEqdfWox4FfsCNTNscx22R3YI2EdsrQ2jfjDvTudifqTcCfjD30v6dwKudkb6sw2E0SB/Lp6tcn5
X-Received: by 2002:a05:6214:590f:b0:888:3d1e:f95 with SMTP id 6a1803df08f44-8908426ac55mr50624736d6.32.1767817164676;
        Wed, 07 Jan 2026 12:19:24 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8907715cdc9sm7211936d6.28.2026.01.07.12.19.24
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2026 12:19:24 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ac3019faadso5726099eec.1
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 12:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767817163; x=1768421963; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z+D0U0I/QMaRvqdVI4kOajEvXFaO+vpLvikp7KFwDvI=;
        b=KIdgyZBPhYyRoGC6A0+65EkNmq1eU7wRvbal/6O1tp30ySC8ISCqJ0N3liZA6vs6VW
         kZpc7VS5udlK4dUxm6kHhUP0aG7JCSEgweq0DTGDijO6CTXaYgWwUKXJOSX2q62F66nr
         /G5GLdQIUmJQd1I9xJNrugeWEq1uvRBxoq0rs=
X-Forwarded-Encrypted: i=1; AJvYcCVS7uVfToex+LRqEsT8hNI13i7VpdXx/4mkPWVenCyhJ+1FkczgVROy7xDPjIyY8wsE+0RmyVPyscHYw2WH3A==@lists.linux.dev
X-Received: by 2002:a05:693c:6085:b0:2ae:5020:afe1 with SMTP id 5a478bee46e88-2b17d2080bdmr2430468eec.14.1767817163213;
        Wed, 07 Jan 2026 12:19:23 -0800 (PST)
X-Received: by 2002:a05:693c:6085:b0:2ae:5020:afe1 with SMTP id 5a478bee46e88-2b17d2080bdmr2430455eec.14.1767817162698;
        Wed, 07 Jan 2026 12:19:22 -0800 (PST)
Received: from [10.66.193.70] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707d57aasm6888830eec.30.2026.01.07.12.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 12:19:22 -0800 (PST)
Message-ID: <89115e05-16ac-4520-afbb-b9b2c86bd6a7@broadcom.com>
Date: Wed, 7 Jan 2026 12:19:19 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/2] x86/paravirt: Remove trailing semicolons from
 alternative asm templates
To: Uros Bizjak <ubizjak@gmail.com>, bcm-kernel-feedback-list@broadcom.com,
 virtualization@lists.linux.dev, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20260105093944.52387-1-ubizjak@gmail.com>
Content-Language: en-US
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20260105093944.52387-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 1/5/26 1:39 AM, Uros Bizjak wrote:
> GCC inline asm treats semicolons as instruction separators, so a
> semicolon after the last instruction is not required.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Cc: Ajay Kaher <ajay.kaher@broadcom.com>
> Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>   arch/x86/include/asm/paravirt.h       | 20 ++++++++++----------
>   arch/x86/include/asm/paravirt_types.h |  2 +-
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index b5e59a7ba0d0..4f6ec60b4cb3 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -151,7 +151,7 @@ static inline void write_cr0(unsigned long x)
>   static __always_inline unsigned long read_cr2(void)
>   {
>   	return PVOP_ALT_CALLEE0(unsigned long, mmu.read_cr2,
> -				"mov %%cr2, %%rax;", ALT_NOT_XEN);
> +				"mov %%cr2, %%rax", ALT_NOT_XEN);
>   }
>   
>   static __always_inline void write_cr2(unsigned long x)
> @@ -162,7 +162,7 @@ static __always_inline void write_cr2(unsigned long x)
>   static inline unsigned long __read_cr3(void)
>   {
>   	return PVOP_ALT_CALL0(unsigned long, mmu.read_cr3,
> -			      "mov %%cr3, %%rax;", ALT_NOT_XEN);
> +			      "mov %%cr3, %%rax", ALT_NOT_XEN);
>   }
>   
>   static inline void write_cr3(unsigned long x)
> @@ -560,7 +560,7 @@ static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *lock,
>   static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
>   {
>   	PVOP_ALT_VCALLEE1(lock.queued_spin_unlock, lock,
> -			  "movb $0, (%%" _ASM_ARG1 ");",
> +			  "movb $0, (%%" _ASM_ARG1 ")",
>   			  ALT_NOT(X86_FEATURE_PVUNLOCK));
>   }
>   
> @@ -577,7 +577,7 @@ static __always_inline void pv_kick(int cpu)
>   static __always_inline bool pv_vcpu_is_preempted(long cpu)
>   {
>   	return PVOP_ALT_CALLEE1(bool, lock.vcpu_is_preempted, cpu,
> -				"xor %%" _ASM_AX ", %%" _ASM_AX ";",
> +				"xor %%" _ASM_AX ", %%" _ASM_AX,
>   				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
>   }
>   
> @@ -657,18 +657,18 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
>   #ifdef CONFIG_PARAVIRT_XXL
>   static __always_inline unsigned long arch_local_save_flags(void)
>   {
> -	return PVOP_ALT_CALLEE0(unsigned long, irq.save_fl, "pushf; pop %%rax;",
> +	return PVOP_ALT_CALLEE0(unsigned long, irq.save_fl, "pushf; pop %%rax",
>   				ALT_NOT_XEN);
>   }
>   
>   static __always_inline void arch_local_irq_disable(void)
>   {
> -	PVOP_ALT_VCALLEE0(irq.irq_disable, "cli;", ALT_NOT_XEN);
> +	PVOP_ALT_VCALLEE0(irq.irq_disable, "cli", ALT_NOT_XEN);
>   }
>   
>   static __always_inline void arch_local_irq_enable(void)
>   {
> -	PVOP_ALT_VCALLEE0(irq.irq_enable, "sti;", ALT_NOT_XEN);
> +	PVOP_ALT_VCALLEE0(irq.irq_enable, "sti", ALT_NOT_XEN);
>   }
>   
>   static __always_inline unsigned long arch_local_irq_save(void)
> @@ -713,9 +713,9 @@ void native_pv_lock_init(void) __init;
>   	call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);
>   .endm
>   
> -#define SAVE_FLAGS ALTERNATIVE_2 "PARA_IRQ_save_fl;",			\
> -				 "ALT_CALL_INSTR;", ALT_CALL_ALWAYS,	\
> -				 "pushf; pop %rax;", ALT_NOT_XEN
> +#define SAVE_FLAGS ALTERNATIVE_2 "PARA_IRQ_save_fl",			\
> +				 "ALT_CALL_INSTR", ALT_CALL_ALWAYS,	\
> +				 "pushf; pop %rax", ALT_NOT_XEN
>   #endif
>   #endif /* CONFIG_PARAVIRT_XXL */
>   #endif	/* CONFIG_X86_64 */
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index 3502939415ad..e82dba084198 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -250,7 +250,7 @@ extern struct paravirt_patch_template pv_ops;
>    */
>   #define PARAVIRT_CALL					\
>   	ANNOTATE_RETPOLINE_SAFE "\n\t"			\
> -	"call *%[paravirt_opptr];"
> +	"call *%[paravirt_opptr]"
>   
>   /*
>    * These macros are intended to wrap calls through one of the paravirt


Acked-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
