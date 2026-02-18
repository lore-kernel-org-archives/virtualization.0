Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B8328246;
	Wed, 18 Feb 2026 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771422601; cv=none; b=AiXNbT5RtHFuCwa4lQCqnesMgiYxX1v6SwnWeEP79OQg7XHxP4V3x0YSz+VHJH/gw2akgxB5cqUGRlfTAQehzBgLba6fqKhu4GgTqgbI1F4BwzbQ+DJ3Usb14jstzj2hb/20wAv/z4oOMfr5QTNzrqUX3Vu5HzvruuOXYKD11/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771422601; c=relaxed/simple;
	bh=KH4zMOJPwjTtPf39tsvzXs+s/Vii+VkH6Xw4jUFevqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pssP4dFISBJ8QEj7CE3Bdsk1PWg5yQyakqK2N91H91xoKWoK5M0u4cDjq1A8GNltGDo8eHTHgpOQUzj4KLgN68kHWqRX2v2nRTKCE57p9a+q1pwvGCNEhglTaMYs95vnEz8M5t8ZeTbPsvaFQdQhQhrHjuJJZZRFz6Qm8yAiFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEjXGY5C; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEjXGY5C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771422598; x=1802958598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KH4zMOJPwjTtPf39tsvzXs+s/Vii+VkH6Xw4jUFevqQ=;
  b=oEjXGY5CtgV9aM8u0bkuUrfAYsjzlUXOG7psIg53RycgpRqFfF7MZ5Ob
   w8lYCiAacWIkAC/h7PMPgolvwqsSVm0/IT5WnIrXVqSB0we4yV/chqG0I
   hF/T2gC9QIWIbkPuMfCmxOcG3d/S9ShsWIBDJJmwNb2c4UUIOl1ysKMlX
   tUzZr3uJ0j/meMxo/sb9tV2t0y8z30jNKSHkPGQn/NB6ydmlB98iSHLqa
   9BEtsSSyqVwf8kraw8gjkHP5Qw+9aeSpoGqIqP6HxCqAxHBJ726Divf6y
   2qDWaKS3YCOjj4SYzAvgUnt6CyJBatV3y0hWF19pzxdKe2TxcQ6sSV4MA
   Q==;
X-CSE-ConnectionGUID: dLeg1vKmQGCXawKDGrD4Mg==
X-CSE-MsgGUID: PFQKMsJwR6OUBUtACsPXjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83120848"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="83120848"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 05:49:57 -0800
X-CSE-ConnectionGUID: z8L7LaUXTSOxqPO0m7x8IA==
X-CSE-MsgGUID: WS67VaQPTyCoOopmfxoI2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="218040472"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2026 05:49:54 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vshw7-000000012Om-15KH;
	Wed, 18 Feb 2026 13:49:51 +0000
Date: Wed, 18 Feb 2026 21:49:36 +0800
From: kernel test robot <lkp@intel.com>
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 16/16] x86/paravirt: Use alternatives for MSR access
 with paravirt
Message-ID: <202602182111.84MpXRx4-lkp@intel.com>
References: <20260218082133.400602-17-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218082133.400602-17-jgross@suse.com>

Hi Juergen,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on next-20260217]
[cannot apply to tip/x86/core kvm/queue kvm/next kvm/linux-next tip/x86/tdx v6.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Juergen-Gross/x86-alternative-Support-alt_replace_call-with-instructions-after-call/20260218-163031
base:   linus/master
patch link:    https://lore.kernel.org/r/20260218082133.400602-17-jgross%40suse.com
patch subject: [PATCH v3 16/16] x86/paravirt: Use alternatives for MSR access with paravirt
config: x86_64-randconfig-001-20260218 (https://download.01.org/0day-ci/archive/20260218/202602182111.84MpXRx4-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260218/202602182111.84MpXRx4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602182111.84MpXRx4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:18:
   In file included from include/linux/slab.h:17:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:22:
   In file included from include/linux/mm_types.h:16:
   In file included from include/linux/uprobes.h:18:
   In file included from include/linux/timer.h:6:
   In file included from include/linux/ktime.h:25:
   In file included from include/linux/jiffies.h:10:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:6:
   In file included from arch/x86/include/asm/tsc.h:11:
   In file included from arch/x86/include/asm/msr.h:300:
>> arch/x86/include/asm/paravirt-msr.h:114:23: error: unsupported inline asm: input with type 'u64' (aka 'unsigned long long') matching output with type 'int'
     114 |                 PV_WRMSR_CONST(msr, val, EX_TYPE_WRMSR, write_msr, err);
         |                                     ^~~                            ~~~
   arch/x86/include/asm/paravirt-msr.h:91:16: note: expanded from macro 'PV_WRMSR_CONST'
      89 |                 : [err] "=a" (__err), "=d" (rdx), ASM_CALL_CONSTRAINT   \
         |                               ~~~~~
      90 |                 : paravirt_ptr(pv_ops_msr, __func),                     \
      91 |                   [val] "0" (__val), "1" ((__val) >> 32),               \
         |                              ^~~~~
   arch/x86/include/asm/paravirt-msr.h:116:21: error: unsupported inline asm: input with type 'u64' (aka 'unsigned long long') matching output with type 'int'
     116 |                 PV_WRMSR_VAR(msr, val, EX_TYPE_WRMSR, write_msr, err);
         |                                   ^~~                            ~~~
   arch/x86/include/asm/paravirt-msr.h:73:10: note: expanded from macro 'PV_WRMSR_VAR'
      71 |                 : [err] "=a" (__err), "=d" (rdx), ASM_CALL_CONSTRAINT   \
         |                               ~~~~~
      72 |                 : paravirt_ptr(pv_ops_msr, __func),                     \
      73 |                   "0" (__val), "1" ((__val) >> 32), "c" (__msr)         \
         |                        ^~~~~
   arch/x86/include/asm/paravirt-msr.h:136:23: error: unsupported inline asm: input with type 'u64' (aka 'unsigned long long') matching output with type 'int'
     136 |                 PV_WRMSR_CONST(msr, val, EX_TYPE_WRMSR_SAFE, write_msr_safe, err);
         |                                     ^~~                                      ~~~
   arch/x86/include/asm/paravirt-msr.h:91:16: note: expanded from macro 'PV_WRMSR_CONST'
      89 |                 : [err] "=a" (__err), "=d" (rdx), ASM_CALL_CONSTRAINT   \
         |                               ~~~~~
      90 |                 : paravirt_ptr(pv_ops_msr, __func),                     \
      91 |                   [val] "0" (__val), "1" ((__val) >> 32),               \
         |                              ^~~~~
   arch/x86/include/asm/paravirt-msr.h:138:21: error: unsupported inline asm: input with type 'u64' (aka 'unsigned long long') matching output with type 'int'
     138 |                 PV_WRMSR_VAR(msr, val, EX_TYPE_WRMSR_SAFE, write_msr_safe, err);
         |                                   ^~~                                      ~~~
   arch/x86/include/asm/paravirt-msr.h:73:10: note: expanded from macro 'PV_WRMSR_VAR'
      71 |                 : [err] "=a" (__err), "=d" (rdx), ASM_CALL_CONSTRAINT   \
         |                               ~~~~~
      72 |                 : paravirt_ptr(pv_ops_msr, __func),                     \
      73 |                   "0" (__val), "1" ((__val) >> 32), "c" (__msr)         \
         |                        ^~~~~
   In file included from arch/x86/kernel/asm-offsets.c:10:
   In file included from include/crypto/aria.h:22:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/x86/include/asm/elf.h:10:
   In file included from arch/x86/include/asm/ia32.h:7:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:13:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/x86/kernel/asm-offsets.c:10:
   In file included from include/crypto/aria.h:22:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/x86/include/asm/elf.h:10:
   In file included from arch/x86/include/asm/ia32.h:7:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:13:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/x86/kernel/asm-offsets.c:10:
   In file included from include/crypto/aria.h:22:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/x86/include/asm/elf.h:10:
   In file included from arch/x86/include/asm/ia32.h:7:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:13:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/x86/kernel/asm-offsets.c:10:
   In file included from include/crypto/aria.h:22:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/x86/include/asm/elf.h:10:
   In file included from arch/x86/include/asm/ia32.h:7:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:5:


vim +114 arch/x86/include/asm/paravirt-msr.h

   108	
   109	static __always_inline void write_msr(u32 msr, u64 val)
   110	{
   111		int err;
   112	
   113		if (__builtin_constant_p(msr))
 > 114			PV_WRMSR_CONST(msr, val, EX_TYPE_WRMSR, write_msr, err);
   115		else
   116			PV_WRMSR_VAR(msr, val, EX_TYPE_WRMSR, write_msr, err);
   117	}
   118	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
