Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B89839EB;
	Mon,  8 Jul 2024 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441447; cv=none; b=szli4nEAHoQKy02AHU2L+g70if5KXazfs9kXYY/aLTNtOFP43pOOD5oN1nz5orvUSpfDGW0BKIR8mRY5utgUbXEABIuicfBMt1NOynsrumpmbKi16Ae/U8rqivlKgENRrlf6e03xS1TF7goTC/rDS69bb9Y8dipUbIv7xK38O24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441447; c=relaxed/simple;
	bh=/IliL90H2qNh4Yf+chbRETV+l6MR1v0C/Y6v4NI4YV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/EJJK85uTEH6eo7f126BkhGY3F6Lo3hE72IjavpX8x5Vvxe0HRdli1GI2LKYfetb/FUfzpfx9SJfvE3UjnHVvXRtj/tbmVxaHECByoabAWVRwD0vfqlXhJsyrzM3ww44Q1BI0z+TylKkybL1HhtUdw7VsnbSgfCuAdM2l/rfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UM0RRj0A; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UM0RRj0A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720441445; x=1751977445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/IliL90H2qNh4Yf+chbRETV+l6MR1v0C/Y6v4NI4YV4=;
  b=UM0RRj0A0SDac0/iYDwVhNyJOH04RzM4LqHUhvDy6Nxt/RaggX9q4C7K
   zyxgzugdqRyiKgiBcocNARwmmarPbhEoH445yTl95y1BoGvZF8SED0SbY
   DKziLbbgJvxW+Fj5MTxqGxkVsZD1eoOJ3vIreI9eYacHapJGaoMRGWIeC
   +x1BTTMnhHsEP1SrLJ8vitQV4iVyRDSRu3L73d1Me1HIrlhZtX6BstM2D
   sD25l3JvwdZVgC6il5z5sEMieBM3i1i5iWN+uRTpAj2G20CQ7iXbuZC/A
   uEDjvaQumlbGxvDrvjxQbCC/0PCVLl5afp5EKn/ywkMSMPsfa9eJSAJHN
   g==;
X-CSE-ConnectionGUID: TSMWpWEHRQOMhIsWLrzyAQ==
X-CSE-MsgGUID: oiH4pm4lTBqbdjsmqqVqaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17510932"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17510932"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 05:24:05 -0700
X-CSE-ConnectionGUID: YgcPJY5GRFuMszYgZFXmkQ==
X-CSE-MsgGUID: Qx7xN1tPQXuLwPQjd/GqyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="78631132"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 08 Jul 2024 05:24:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E2E101AC; Mon, 08 Jul 2024 15:23:58 +0300 (EEST)
Date: Mon, 8 Jul 2024 15:23:58 +0300
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
Subject: Re: [PATCH 2/2] x86/vmware: VMware support for TDX userspace
 hypercalls
Message-ID: <dbbypcttkcgg55rkoxjy4rvdyf3qtychqotmxxrrq3urtgul2j@yzbh62cyv635>
References: <cover.1720046911.git.tim.merrifield@broadcom.com>
 <7f57b0fe002291e3f4b27dfe9f502ed3af296bc2.1720046911.git.tim.merrifield@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f57b0fe002291e3f4b27dfe9f502ed3af296bc2.1720046911.git.tim.merrifield@broadcom.com>

On Wed, Jul 03, 2024 at 11:36:01PM +0000, Tim Merrifield wrote:
> @@ -539,6 +547,24 @@ unsigned long vmware_tdx_hypercall(unsigned long cmd,
>  	return args.r12;
>  }
>  EXPORT_SYMBOL_GPL(vmware_tdx_hypercall);
> +
> +static bool vmware_tdx_user_hcall(struct pt_regs *regs)
> +{
> +	struct tdx_module_args args;

Zero the struct to not leak data to VMM.

> +
> +	vmware_init_tdx_args(&args, true, regs->cx, regs->bx,
> +			     regs->dx, regs->si, regs->di, regs->bp);
> +	__tdx_hypercall(&args);
> +	regs->ax = args.r12;
> +	regs->bx = args.rbx;
> +	regs->cx = args.r13;
> +	regs->dx = args.rdx;
> +	regs->si = args.rsi;
> +	regs->di = args.rdi;
> +	regs->bp = args.r14;
> +
> +	return true;
> +}
>  #endif
>  
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> @@ -586,4 +612,7 @@ const __initconst struct hypervisor_x86 x86_hyper_vmware = {
>  	.runtime.sev_es_hcall_prepare	= vmware_sev_es_hcall_prepare,
>  	.runtime.sev_es_hcall_finish	= vmware_sev_es_hcall_finish,
>  #endif
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +	.runtime.tdx_hcall              = vmware_tdx_user_hcall,
> +#endif
>  };
> -- 
> 2.40.1
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
