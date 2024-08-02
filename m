Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107091E3CA1;
	Fri,  2 Aug 2024 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602846; cv=none; b=YMaehudGpDI4Pw6NyywecWOgz9fP5t3qJKxh+NGbbg+r2tw4jvoMZWiFF7dDhXZizMbgLrOEFJ/DhAt1c0l8iuWSC5GGErSgBRVL0BqS9zU4tB4i0lnGDSAQHUbKqwO0Rdydlmlwynrdzw74gBox3DDVh0HIWbgJtQ2Xmca4OnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602846; c=relaxed/simple;
	bh=T3dNCXJURRRkxySqwgtV8ojNjDh9wCEAmFfwbrdC/8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPIIEmkmIwY8adAKZmy3YuSyKOOMwe9t1vgT7zeR9tP/Q2wgo3yYyIJ5YEw64fuJv1gzUmhNCaqytdz6w7/SRrHmR5ntQiFNKIRYY5cbc/xy8T2P7Ixplr28IfKLXGXmkf/meCa5fbcyefj9BYYSJr91h2VGv+ST/Ep9c6JYkXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMzr/r2s; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMzr/r2s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722602845; x=1754138845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T3dNCXJURRRkxySqwgtV8ojNjDh9wCEAmFfwbrdC/8k=;
  b=iMzr/r2sYR8k7BJPQm3Pbz4m6e00zD7POYp+lBvYvntMInoC2asX7Q7W
   cY79EFxNHf5SaQxgQeW3/rSV9Yb0t/qZhusyBdaDzIu5gunpX2RJC4Kv3
   3hxZ3G6JZDT7LHcPa78wg/mW/388NNGeWf9Kai3X2yZNah1RkJbi1fcoT
   rd1GMPRyd8ithn6EusHXWmtFAg3i1V5ruSxz/BIa+MRTYTLPqWjuhak04
   T6MpK33A4l+QpjtHwtkH9kivywZrB2TunARaJUm26mPqCEPL4CGM8/Jin
   7nyuPJufVUbeU0SGIU7pqv5ELpjBHu4CTWc8PxLGVPSVuFJZddkFdQ+j1
   g==;
X-CSE-ConnectionGUID: /Bl549O9Qk+PX7hTCF2iog==
X-CSE-MsgGUID: HOd02/+HT/mtaD1kwP1W9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="31995647"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="31995647"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 05:47:24 -0700
X-CSE-ConnectionGUID: NaDYw3I0Sg+OqUuONhJFww==
X-CSE-MsgGUID: mStR05z2TvaPico6O1qerQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="59724145"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 02 Aug 2024 05:47:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7DCD4268; Fri, 02 Aug 2024 15:47:17 +0300 (EEST)
Date: Fri, 2 Aug 2024 15:47:17 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Tim Merrifield <tim.merrifield@broadcom.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, alex.james@broadcom.com, 
	doug.covelli@broadcom.com, jeffrey.sheldon@broadcom.com, kevin.christopher@broadcom.com, 
	aravind-as.srinivasan@broadcom.com, ravindra.kumar@broadcom.com
Subject: Re: [PATCH v2 1/2] Add prctl to allow userlevel TDX hypercalls
Message-ID: <djcj4rubfrjdha64bdea5mvujfbtf2j5lgipywvkkdugbrl5u5@xbg5ofqfp6ix>
References: <cover.1722019360.git.tim.merrifield@broadcom.com>
 <651ceb5a89721621d522419e8a5d901632a78a22.1722019360.git.tim.merrifield@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651ceb5a89721621d522419e8a5d901632a78a22.1722019360.git.tim.merrifield@broadcom.com>

On Fri, Jul 26, 2024 at 06:58:00PM +0000, Tim Merrifield wrote:
> Add a new process-level prctl option to enable/disable user-level
> hypercalls when running in a confidential VM. Add support for
> checking this flag on VMCALL #VE for TDX and transfer control to
> a hypervisor vendor-specific handler.

We need more context from the cover letter here.

> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index f63f8fd00a91..198431919fd2 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -1042,6 +1042,24 @@ unsigned long __get_wchan(struct task_struct *p)
>  	return addr;
>  }
>  
> +static int get_coco_user_hcall_mode(void)
> +{
> +	return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
> +			&current->mm->context.flags);

Hm. Why "!"?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
