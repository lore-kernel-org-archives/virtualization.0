Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EB11AF0CA;
	Thu, 27 Feb 2025 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673556; cv=none; b=oTXOJcrthu2jTpWEpepiyS9UUmcFmt9ebRd3WvQOKCCBCgUvZNRnCAtcfLqcoeKgPPxHNUOl4qEwu1Tb/2cgzKx30IhXRill7QGWMsGbSe7Br0EoxTApvDpZDgh387as+75invwj1pqi9P/thmb5zgCKLbGvChzxJ1FxfGT1EJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673556; c=relaxed/simple;
	bh=zhNYYeMAow0BtxLxQNwrj/TtNhqr/Fl7bOoE8dZ4AHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbTYuxjuveyq5PyMj2Oq2MaAWbgzejLnbWK3NP1R+oRI+xY/R5YuUZrvgC2LKWRAFLnG2xyIx8E93GiBJ197o04BDNbD4rLitWzbV+D5LGQjSauEGljNKAfUAQF6rw5C0ojo3kKWt1IivI1cS3X99HsC0SZrVicgrWw0+8D/xVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKv2jqK/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKv2jqK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740673555; x=1772209555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zhNYYeMAow0BtxLxQNwrj/TtNhqr/Fl7bOoE8dZ4AHU=;
  b=RKv2jqK/w93NNCgMgNvkMuSiE9WKnN/IsEXJBDdyb5CN+plHlargJZKd
   Jpeh9JtbtVwij1FOlzV5k/LB/vnGBBqAZ8F3NtATkochiQKCr7gJj/U2/
   HA0oOXrxdCA6suiFjagdlMOomup2/XadgG8pPybklUjs/YJLV6hIusN/Y
   rWIXKhdYG3DyybhqpJ9rGZTs1HI4SgZ7JQv3ZonbJCD+nFAQNrW2nmktn
   VZI8Flhgda90JB56FXHfiHRVYWVbnndeC3CNxSa5CHswqYtSg+PD2L7Md
   A/n2qkFsmJAyX18lcE2Hhc4kJJ5BrjqG8Jw/39ENPwACv3Nm70KSyXTz+
   A==;
X-CSE-ConnectionGUID: vAdmvRI5R3OP/Ndi05Tmfg==
X-CSE-MsgGUID: q0+5oKw8QOWdLtnn5RMjBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="66945547"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="66945547"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 08:25:54 -0800
X-CSE-ConnectionGUID: 7IEA9UGeS66Ek9lDDETxMg==
X-CSE-MsgGUID: B3+jANRvR3KSDN2PK8w0mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122313333"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 27 Feb 2025 08:25:46 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnggn-000DgL-1J;
	Thu, 27 Feb 2025 16:25:03 +0000
Date: Fri, 28 Feb 2025 00:19:49 +0800
From: kernel test robot <lkp@intel.com>
To: Vishal Annapurve <vannapurve@google.com>, dave.hansen@linux.intel.com,
	kirill.shutemov@linux.intel.com, jgross@suse.com,
	ajay.kaher@broadcom.com, ak@linux.intel.com, tony.luck@intel.com,
	thomas.lendacky@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, pbonzini@redhat.com,
	seanjc@google.com, kai.huang@intel.com, chao.p.peng@linux.intel.com,
	isaku.yamahata@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, erdemaktas@google.com,
	ackerleytng@google.com, jxgao@google.com, sagis@google.com,
	afranji@google.com, kees@kernel.org, jikos@kernel.org,
	peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v6 2/3] x86/tdx: Fix arch_safe_halt() execution for TDX
 VMs
Message-ID: <202502272346.iiQ6Dptt-lkp@intel.com>
References: <20250225004704.603652-3-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225004704.603652-3-vannapurve@google.com>

Hi Vishal,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on tip/master linus/master v6.14-rc4 next-20250227]
[cannot apply to tip/x86/tdx tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vishal-Annapurve/x86-paravirt-Move-halt-paravirt-calls-under-CONFIG_PARAVIRT/20250225-085043
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20250225004704.603652-3-vannapurve%40google.com
patch subject: [PATCH v6 2/3] x86/tdx: Fix arch_safe_halt() execution for TDX VMs
config: i386-buildonly-randconfig-003-20250227 (https://download.01.org/0day-ci/archive/20250227/202502272346.iiQ6Dptt-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502272346.iiQ6Dptt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502272346.iiQ6Dptt-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/process.c:6:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/kernel/process.c:937:32: error: use of undeclared identifier 'tdx_halt'; did you mean 'tdx_init'?
     937 |                 static_call_update(x86_idle, tdx_halt);
         |                                              ^~~~~~~~
         |                                              tdx_init
   include/linux/static_call.h:154:42: note: expanded from macro 'static_call_update'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                                                 ^
   arch/x86/include/asm/tdx.h:123:20: note: 'tdx_init' declared here
     123 | static inline void tdx_init(void) { }
         |                    ^
   2 warnings and 1 error generated.


vim +937 arch/x86/kernel/process.c

   919	
   920	void __init select_idle_routine(void)
   921	{
   922		if (boot_option_idle_override == IDLE_POLL) {
   923			if (IS_ENABLED(CONFIG_SMP) && __max_threads_per_core > 1)
   924				pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
   925			return;
   926		}
   927	
   928		/* Required to guard against xen_set_default_idle() */
   929		if (x86_idle_set())
   930			return;
   931	
   932		if (prefer_mwait_c1_over_halt()) {
   933			pr_info("using mwait in idle threads\n");
   934			static_call_update(x86_idle, mwait_idle);
   935		} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
   936			pr_info("using TDX aware idle routine\n");
 > 937			static_call_update(x86_idle, tdx_halt);
   938		} else {
   939			static_call_update(x86_idle, default_idle);
   940		}
   941	}
   942	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
