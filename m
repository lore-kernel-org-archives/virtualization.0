Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0201D52B;
	Mon,  8 Jul 2024 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441203; cv=none; b=iBN2+uf5Z5NGSjNWbi9tfzoX9tYoQ85IZ4fdN9noLN3yx42Pzg7rUiVaMBRMfv0WO8MzrxAb/n1f27ALdf2jkIGM9/m2Q7oOlRIw5A2top5LDWIO64PFMD4r2O3IiYQLf4sqpQfqg5caBBedPvEZmNSP6WY0Myes2mMpjCxLolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441203; c=relaxed/simple;
	bh=wjvU51ptwqEbDa4csd4lwZbWtSADQIQKj+0neUMIwbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlIVqEy5Pu4IePneFlEw8fK2nq5f/rpfdOUOGhjqkUDxVS/bpiK/XzOqlXvLzkHg/YDCqDQI6QWFVIRePwJN8qtqJ9VhZ0otFOPvv9Pqk/8Wr2eSupx8qBh69bWLj+7VZRTBThN1cmcA0VLPkwzNppFrBqHDOjTtbYB9WO2wUoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SW/Czsx3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SW/Czsx3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720441202; x=1751977202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wjvU51ptwqEbDa4csd4lwZbWtSADQIQKj+0neUMIwbk=;
  b=SW/Czsx3+g7XO7bPbErC1YyYQ9PpXISBO37s+UBwQa3CPiOEHN3vazO7
   PMVJRmtT6KFm9lcbjyJ2rl/mKwtkA8rnIg88DJW+MpTxqi6JsnfTf3XdZ
   +i8XBitlRnuyIu6BXw7tFvrOag0h7ydPmKRfhibCBjZNhwrLLCAGBMATm
   nMatTauzEvrrWwmHpsNgTm+OWW+ngK76NRzznImcXVTK5xnBLoZgy9sLk
   vgPe24EkS9ZQcSTsJQQn0sqNPm5YpSMQen1/IWXOu3HaJGw/J/GlDNU4O
   4Ktd/AwJ+Zwr4JM42FpoqkFaVk70tmYHiu0tQFhMJNExfeWWxk0ecls96
   g==;
X-CSE-ConnectionGUID: IuqpEChPTaKja0MZ75r+0g==
X-CSE-MsgGUID: YrLtOeksQbmVHRrc9zZXBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17844213"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17844213"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 05:20:01 -0700
X-CSE-ConnectionGUID: HEZVAEHmTwez08r4zwACwg==
X-CSE-MsgGUID: 6fZXpjtYRNKcITw3+f5wrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="47560213"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 08 Jul 2024 05:19:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D318A1AC; Mon, 08 Jul 2024 15:19:54 +0300 (EEST)
Date: Mon, 8 Jul 2024 15:19:54 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Tim Merrifield <tim.merrifield@broadcom.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, alex.james@broadcom.com, 
	doug.covelli@broadcom.com, jeffrey.sheldon@broadcom.com
Subject: Re: [PATCH 1/2] x86/tdx: Add prctl to allow userlevel TDX hypercalls
Message-ID: <wufxrry6smwk25qmsajabx6vgx4vgsrbvtmun2zw4fxz3lo4b4@nfpkscueapt6>
References: <cover.1720046911.git.tim.merrifield@broadcom.com>
 <90bf00599189c34e77aa77986674be2d5fc19f9c.1720046911.git.tim.merrifield@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90bf00599189c34e77aa77986674be2d5fc19f9c.1720046911.git.tim.merrifield@broadcom.com>

On Wed, Jul 03, 2024 at 11:36:00PM +0000, Tim Merrifield wrote:
> Add a new prctl option to enable/disable user-level hypercalls when
> running in a confidential VM. Add support for checking this flag on
> VMCALL #VE for TDX and transfer control to a hypervisor
> vendor-specific handler.
> 
> Signed-off-by: Tim Merrifield <tim.merrifield@broadcom.com>
> ---
>  arch/x86/coco/tdx/tdx.c            | 18 ++++++++++++++++++
>  arch/x86/include/asm/thread_info.h |  2 ++
>  arch/x86/include/asm/x86_init.h    |  1 +
>  arch/x86/include/uapi/asm/prctl.h  |  3 +++
>  arch/x86/kernel/process.c          | 20 ++++++++++++++++++++
>  5 files changed, 44 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index ef8ec2425998..23111e4c1f91 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -239,6 +239,7 @@ static int ve_instr_len(struct ve_info *ve)
>  	case EXIT_REASON_MSR_WRITE:
>  	case EXIT_REASON_CPUID:
>  	case EXIT_REASON_IO_INSTRUCTION:
> +	case EXIT_REASON_VMCALL:
>  		/* It is safe to use ve->instr_len for #VE due instructions */
>  		return ve->instr_len;
>  	case EXIT_REASON_EPT_VIOLATION:
> @@ -635,6 +636,21 @@ void tdx_get_ve_info(struct ve_info *ve)
>  	ve->instr_info  = upper_32_bits(args.r10);
>  }
>  
> +/*
> + * Handle user-initiated, hypervisor-specific VMCALLs.
> + */
> +static int handle_user_vmcall(struct pt_regs *regs, struct ve_info *ve)
> +{
> +	if (x86_platform.hyper.tdx_hcall &&
> +	    test_thread_flag(TIF_COCO_USER_HCALL)) {
> +		if (!x86_platform.hyper.tdx_hcall(regs))
> +			return -EIO;
> +		return ve_instr_len(ve);
> +	} else {
> +		return -EOPNOTSUPP;
> +	}

Maybe something like this would be more readable:

	if (!x86_platform.hyper.tdx_hcall)
		return -EOPNOTSUPP;

	if (!test_thread_flag(TIF_COCO_USER_HCALL))
		return -EOPNOTSUPP;

	if (!x86_platform.hyper.tdx_hcall(regs))
		return -EIO;

	return ve_instr_len(ve);

BTW, do we want tdx_hcall() to return errno instead of bool?

> +}
> +
>  /*
>   * Handle the user initiated #VE.
>   *
> @@ -646,6 +662,8 @@ static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
>  	switch (ve->exit_reason) {
>  	case EXIT_REASON_CPUID:
>  		return handle_cpuid(regs, ve);
> +	case EXIT_REASON_VMCALL:
> +		return handle_user_vmcall(regs, ve);
>  	default:
>  		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>  		return -EIO;
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 12da7dfd5ef1..9f69a26a5e68 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -106,6 +106,7 @@ struct thread_info {
>  #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
>  #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
>  #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
> +#define TIF_COCO_USER_HCALL     30      /* Userland hypercalls allowed in CoCo */

Tabs instead of spaces for alignment, please.

>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
> @@ -128,6 +129,7 @@ struct thread_info {
>  #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
>  #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
>  #define _TIF_ADDR32		(1 << TIF_ADDR32)
> +#define _TIF_COCO_USER_HCALL    (1 << TIF_COCO_USER_HCALL)

Ditto.

>  
>  /* flags to check in __switch_to() */
>  #define _TIF_WORK_CTXSW_BASE					\
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index 213cf5379a5a..52975bedd33e 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -282,6 +282,7 @@ struct x86_hyper_runtime {
>  	void (*sev_es_hcall_prepare)(struct ghcb *ghcb, struct pt_regs *regs);
>  	bool (*sev_es_hcall_finish)(struct ghcb *ghcb, struct pt_regs *regs);
>  	bool (*is_private_mmio)(u64 addr);
> +	bool (*tdx_hcall)(struct pt_regs *regs);
>  };
>  
>  /**
> diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
> index 384e2cc6ac19..7fa289a1815b 100644
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -16,6 +16,9 @@
>  #define ARCH_GET_XCOMP_GUEST_PERM	0x1024
>  #define ARCH_REQ_XCOMP_GUEST_PERM	0x1025
>  
> +#define ARCH_GET_COCO_USER_HCALL        0x1030
> +#define ARCH_SET_COCO_USER_HCALL        0x1031
> +

Ditto.

>  #define ARCH_XCOMP_TILECFG		17
>  #define ARCH_XCOMP_TILEDATA		18
>  
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 1b3d417cd6c4..16f8ab6cde2e 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -1039,6 +1039,21 @@ unsigned long __get_wchan(struct task_struct *p)
>  	return addr;
>  }
>  
> +static int get_coco_user_hcall_mode(void)
> +{
> +	return !test_thread_flag(TIF_COCO_USER_HCALL);
> +}
> +
> +static int set_coco_user_hcall_mode(unsigned long enabled)
> +{
> +	if (enabled)
> +		set_thread_flag(TIF_COCO_USER_HCALL);
> +	else
> +		clear_thread_flag(TIF_COCO_USER_HCALL);
> +
> +	return 0;
> +}
> +

Hm. Per-thread flag is odd. I think it should be per-process.

>  long do_arch_prctl_common(int option, unsigned long arg2)
>  {
>  	switch (option) {
> @@ -1052,6 +1067,11 @@ long do_arch_prctl_common(int option, unsigned long arg2)
>  	case ARCH_GET_XCOMP_GUEST_PERM:
>  	case ARCH_REQ_XCOMP_GUEST_PERM:
>  		return fpu_xstate_prctl(option, arg2);
> +	case ARCH_GET_COCO_USER_HCALL:
> +		return get_coco_user_hcall_mode();
> +	case ARCH_SET_COCO_USER_HCALL:
> +		return set_coco_user_hcall_mode(arg2);
> +
>  	}
>  
>  	return -EINVAL;
> -- 
> 2.40.1
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
