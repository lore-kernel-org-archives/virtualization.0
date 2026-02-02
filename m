Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F07536EAAB;
	Mon,  2 Feb 2026 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071584; cv=none; b=ivb0cOijOB76wMNMkCmQfC3GoCYyc9RAoMi0L7wumiGtxWxbfw096uswJpWaljj3DOVg3QKJxbyPaczY9t3EazUgxEqiE5w3/xhdDGSJsjRDqez4hrTU6cd5dGJyUbdOTygJAp6ZOMkVYa8TLSMqI1F8uLdgx0s3LMaUbBFCjnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071584; c=relaxed/simple;
	bh=K94Yr5tqFVaHsCYCKnsxMVUvUOkbufB1DVdDJ7sbhdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq9JH+mgG4M5ShiuA6UxYh35iZ+MhrRTtTQQsuWv25rjZFSDfGbb4Hm0axYis+nl2ZGLu9NJatZsHjK85sOx6Eni+sxNajdldDKQxIrqQt/WRmGiDnKbIMidy5jKXpIlm6t2plq4ywr5p0qfPz1oUAp1fzPxfI7227U+mjUbTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKlViKJA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKlViKJA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770071583; x=1801607583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K94Yr5tqFVaHsCYCKnsxMVUvUOkbufB1DVdDJ7sbhdg=;
  b=BKlViKJAVVGto3CtjwFrfkcBkI8FG1P7WHq9O/azjGYnocBOesCY9tiS
   /GVIGMtCnIp81025Wb25B2YYDNcLCRJIZF2VxhKWSvHk8onBEQ2dVD+dn
   6kBBfr3+ZyyZ6VbbjwhM//5XN3sikGxLYxRt5cuzY25KyWPXXg6Ln8v1w
   LchPbAT/HqZsL5/mpbYuWryV1u1PVZIvno2QSl4aSb6/xTNJR/V93GuhF
   Xw8N7qKN7K1yqRwsB4FS6rmtd1dv2GWbrCv2qoqjFD12NtVA4jB5o7rOs
   nQquHg3tQSf34ciZCS0MZzkjgb/TRLgGbfnF6rCUuK0TzOhAMC/OBHMHU
   Q==;
X-CSE-ConnectionGUID: olDvU4euTSOCSqspAOwVFA==
X-CSE-MsgGUID: JRp+Y5gGQliLzQb3mURrSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82348627"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="82348627"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 14:33:02 -0800
X-CSE-ConnectionGUID: f0cfM4HPRO+EXrWtBO5R7A==
X-CSE-MsgGUID: e2M1VSzVScuy0rx2orDXBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="209657809"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 02 Feb 2026 14:32:27 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vn2T3-00000000g1M-0wih;
	Mon, 02 Feb 2026 22:32:25 +0000
Date: Tue, 3 Feb 2026 06:31:40 +0800
From: kernel test robot <lkp@intel.com>
To: Shashank Balaji <shashank.mahadasyam@sony.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev, jailhouse-dev@googlegroups.com,
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
	Rahul Bukte <rahul.bukte@sony.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>,
	Tim Bird <tim.bird@sony.com>
Subject: Re: [PATCH 1/3] x86/x2apic: disable x2apic on resume if the kernel
 expects so
Message-ID: <202602030600.jFhsJyEC-lkp@intel.com>
References: <20260202-x2apic-fix-v1-1-71c8f488a88b@sony.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202-x2apic-fix-v1-1-71c8f488a88b@sony.com>

Hi Shashank,

kernel test robot noticed the following build errors:

[auto build test ERROR on 18f7fcd5e69a04df57b563360b88be72471d6b62]

url:    https://github.com/intel-lab-lkp/linux/commits/Shashank-Balaji/x86-x2apic-disable-x2apic-on-resume-if-the-kernel-expects-so/20260202-181147
base:   18f7fcd5e69a04df57b563360b88be72471d6b62
patch link:    https://lore.kernel.org/r/20260202-x2apic-fix-v1-1-71c8f488a88b%40sony.com
patch subject: [PATCH 1/3] x86/x2apic: disable x2apic on resume if the kernel expects so
config: i386-randconfig-001-20260202 (https://download.01.org/0day-ci/archive/20260203/202602030600.jFhsJyEC-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260203/202602030600.jFhsJyEC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602030600.jFhsJyEC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/apic/apic.c:2463:3: error: call to undeclared function '__x2apic_disable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2463 |                 __x2apic_disable();
         |                 ^
   arch/x86/kernel/apic/apic.c:2463:3: note: did you mean '__x2apic_enable'?
   arch/x86/kernel/apic/apic.c:1896:20: note: '__x2apic_enable' declared here
    1896 | static inline void __x2apic_enable(void) { }
         |                    ^
   1 error generated.


vim +/__x2apic_disable +2463 arch/x86/kernel/apic/apic.c

  2435	
  2436	static void lapic_resume(void *data)
  2437	{
  2438		unsigned int l, h;
  2439		unsigned long flags;
  2440		int maxlvt;
  2441	
  2442		if (!apic_pm_state.active)
  2443			return;
  2444	
  2445		local_irq_save(flags);
  2446	
  2447		/*
  2448		 * IO-APIC and PIC have their own resume routines.
  2449		 * We just mask them here to make sure the interrupt
  2450		 * subsystem is completely quiet while we enable x2apic
  2451		 * and interrupt-remapping.
  2452		 */
  2453		mask_ioapic_entries();
  2454		legacy_pic->mask_all();
  2455	
  2456		if (x2apic_mode) {
  2457			__x2apic_enable();
  2458		} else {
  2459			/*
  2460			 * x2apic may have been re-enabled by the
  2461			 * firmware on resuming from s2ram
  2462			 */
> 2463			__x2apic_disable();
  2464	
  2465			/*
  2466			 * Make sure the APICBASE points to the right address
  2467			 *
  2468			 * FIXME! This will be wrong if we ever support suspend on
  2469			 * SMP! We'll need to do this as part of the CPU restore!
  2470			 */
  2471			if (boot_cpu_data.x86 >= 6) {
  2472				rdmsr(MSR_IA32_APICBASE, l, h);
  2473				l &= ~MSR_IA32_APICBASE_BASE;
  2474				l |= MSR_IA32_APICBASE_ENABLE | mp_lapic_addr;
  2475				wrmsr(MSR_IA32_APICBASE, l, h);
  2476			}
  2477		}
  2478	
  2479		maxlvt = lapic_get_maxlvt();
  2480		apic_write(APIC_LVTERR, ERROR_APIC_VECTOR | APIC_LVT_MASKED);
  2481		apic_write(APIC_ID, apic_pm_state.apic_id);
  2482		apic_write(APIC_DFR, apic_pm_state.apic_dfr);
  2483		apic_write(APIC_LDR, apic_pm_state.apic_ldr);
  2484		apic_write(APIC_TASKPRI, apic_pm_state.apic_taskpri);
  2485		apic_write(APIC_SPIV, apic_pm_state.apic_spiv);
  2486		apic_write(APIC_LVT0, apic_pm_state.apic_lvt0);
  2487		apic_write(APIC_LVT1, apic_pm_state.apic_lvt1);
  2488	#ifdef CONFIG_X86_THERMAL_VECTOR
  2489		if (maxlvt >= 5)
  2490			apic_write(APIC_LVTTHMR, apic_pm_state.apic_thmr);
  2491	#endif
  2492	#ifdef CONFIG_X86_MCE_INTEL
  2493		if (maxlvt >= 6)
  2494			apic_write(APIC_LVTCMCI, apic_pm_state.apic_cmci);
  2495	#endif
  2496		if (maxlvt >= 4)
  2497			apic_write(APIC_LVTPC, apic_pm_state.apic_lvtpc);
  2498		apic_write(APIC_LVTT, apic_pm_state.apic_lvtt);
  2499		apic_write(APIC_TDCR, apic_pm_state.apic_tdcr);
  2500		apic_write(APIC_TMICT, apic_pm_state.apic_tmict);
  2501		apic_write(APIC_ESR, 0);
  2502		apic_read(APIC_ESR);
  2503		apic_write(APIC_LVTERR, apic_pm_state.apic_lvterr);
  2504		apic_write(APIC_ESR, 0);
  2505		apic_read(APIC_ESR);
  2506	
  2507		irq_remapping_reenable(x2apic_mode);
  2508	
  2509		local_irq_restore(flags);
  2510	}
  2511	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
