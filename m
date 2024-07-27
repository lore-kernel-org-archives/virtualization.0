Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ACF2C6BD;
	Sat, 27 Jul 2024 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722064467; cv=none; b=Golppq4h06s0N9qONTlkC/SF8xDzOrBKbRVNq9tGcmWyaQX1NdlqSpesEac1qb2+JUuadlHv5XrEbQZCTIiPwhi+PC88TQtSOGzoU4GV3ITwouIv8ZXWzCOGpPnSpkoGTpNNAyMcEzBpMwpD8rrakQikE7t784wpY+XJYyjE2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722064467; c=relaxed/simple;
	bh=PDrDSG679tZgrgzWDkMYt0FDb+JhOwYtt2rOW8etHWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYkypEaiq/0jptIiUaSANfR1u8zhWGNqAVwhlu+hGfbbDlmWq5q5yxpb01UhK9DnoONh+sqflJ4zxyAfF71VWApOXolfcgum6L5Gx2sx9BA1eo9jnNWgRD3BYrrJVyM/gR/b3kGhDIsWIp88+eOxKtJzDB2ynk4zu0FzKeCsJYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGH90k3i; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGH90k3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722064465; x=1753600465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PDrDSG679tZgrgzWDkMYt0FDb+JhOwYtt2rOW8etHWk=;
  b=RGH90k3iU6FtjA6LpvOnGZCL6uxS1qWucbsmAHW719fD66t/1MtIlO6g
   QoMgeHqsJZsBrhU9ZF804cgpJhcWP2nEhnvsjsR0JPuAr/jzIxsA+SvLo
   CKiJqeadT7zXXhhxULG9+kRNCoEM4nmthUbJq+JOb1F0OBETyjZqXTAgf
   hJWw3ldxt17x6M7uI6SMhAdvBwDqHLmMOs53d+2daVugRLZoHtsBFb/e0
   CNghZ41pQZNG+p24j+gNhvMa9c1GyUfTY/ZBRPggpyT+L/TawIPr+GSgb
   +QN2hxJChCQvJy6MKWx74mfZnv5IB1xZ6Av6j3O7RkhpLDQ6NhgGnILPk
   w==;
X-CSE-ConnectionGUID: Z0wVFYPgR7mVcQD4Y1XdKw==
X-CSE-MsgGUID: 8uc0vySrTT+4T7migFuwUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="30474620"
X-IronPort-AV: E=Sophos;i="6.09,240,1716274800"; 
   d="scan'208";a="30474620"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 00:14:24 -0700
X-CSE-ConnectionGUID: K4q1gM87SDGxQEzAl3vBjg==
X-CSE-MsgGUID: 6QD6XAxERwisc8lAKMYJtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,240,1716274800"; 
   d="scan'208";a="53150571"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 27 Jul 2024 00:14:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXbd9-000phs-2e;
	Sat, 27 Jul 2024 07:14:15 +0000
Date: Sat, 27 Jul 2024 15:13:52 +0800
From: kernel test robot <lkp@intel.com>
To: Tim Merrifield <tim.merrifield@broadcom.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin3.li@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Brian Gerst <brgerst@gmail.com>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, alex.james@broadcom.com,
	doug.covelli@broadcom.com, jeffrey.sheldon@broadcom.com,
	kevin.christopher@broadcom.com, aravind-as.srinivasan@broadcom.com,
	ravindra.kumar@broadcom.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/2] Add prctl to allow userlevel TDX hypercalls
Message-ID: <202407271423.sLLB8VXR-lkp@intel.com>
References: <651ceb5a89721621d522419e8a5d901632a78a22.1722019360.git.tim.merrifield@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651ceb5a89721621d522419e8a5d901632a78a22.1722019360.git.tim.merrifield@broadcom.com>

Hi Tim,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/vmware]
[also build test ERROR on tip/x86/tdx linus/master v6.10 next-20240726]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tim-Merrifield/Add-prctl-to-allow-userlevel-TDX-hypercalls/20240727-025221
base:   tip/x86/vmware
patch link:    https://lore.kernel.org/r/651ceb5a89721621d522419e8a5d901632a78a22.1722019360.git.tim.merrifield%40broadcom.com
patch subject: [PATCH v2 1/2] Add prctl to allow userlevel TDX hypercalls
config: i386-buildonly-randconfig-001-20240727 (https://download.01.org/0day-ci/archive/20240727/202407271423.sLLB8VXR-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240727/202407271423.sLLB8VXR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407271423.sLLB8VXR-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:23,
                    from arch/x86/kernel/process.c:5:
   arch/x86/kernel/process.c: In function 'get_coco_user_hcall_mode':
>> arch/x86/kernel/process.c:1041:46: error: 'mm_context_t' has no member named 'flags'
    1041 |                         &current->mm->context.flags);
         |                                              ^
   include/linux/bitops.h:45:44: note: in definition of macro 'bitop'
      45 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   arch/x86/kernel/process.c:1040:17: note: in expansion of macro 'test_bit'
    1040 |         return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
         |                 ^~~~~~~~
>> arch/x86/kernel/process.c:1041:46: error: 'mm_context_t' has no member named 'flags'
    1041 |                         &current->mm->context.flags);
         |                                              ^
   include/linux/bitops.h:46:23: note: in definition of macro 'bitop'
      46 |           (uintptr_t)(addr) != (uintptr_t)NULL &&                       \
         |                       ^~~~
   arch/x86/kernel/process.c:1040:17: note: in expansion of macro 'test_bit'
    1040 |         return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
         |                 ^~~~~~~~
>> arch/x86/kernel/process.c:1041:46: error: 'mm_context_t' has no member named 'flags'
    1041 |                         &current->mm->context.flags);
         |                                              ^
   include/linux/bitops.h:47:57: note: in definition of macro 'bitop'
      47 |           __builtin_constant_p(*(const unsigned long *)(addr))) ?       \
         |                                                         ^~~~
   arch/x86/kernel/process.c:1040:17: note: in expansion of macro 'test_bit'
    1040 |         return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
         |                 ^~~~~~~~
>> arch/x86/kernel/process.c:1041:46: error: 'mm_context_t' has no member named 'flags'
    1041 |                         &current->mm->context.flags);
         |                                              ^
   include/linux/bitops.h:48:24: note: in definition of macro 'bitop'
      48 |          const##op(nr, addr) : op(nr, addr))
         |                        ^~~~
   arch/x86/kernel/process.c:1040:17: note: in expansion of macro 'test_bit'
    1040 |         return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
         |                 ^~~~~~~~
>> arch/x86/kernel/process.c:1041:46: error: 'mm_context_t' has no member named 'flags'
    1041 |                         &current->mm->context.flags);
         |                                              ^
   include/linux/bitops.h:48:39: note: in definition of macro 'bitop'
      48 |          const##op(nr, addr) : op(nr, addr))
         |                                       ^~~~
   arch/x86/kernel/process.c:1040:17: note: in expansion of macro 'test_bit'
    1040 |         return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
         |                 ^~~~~~~~
   arch/x86/kernel/process.c: In function 'set_coco_user_hcall_mode':
   arch/x86/kernel/process.c:1048:46: error: 'mm_context_t' has no member named 'flags'
    1048 |                         &current->mm->context.flags);
         |                                              ^
   arch/x86/kernel/process.c:1051:48: error: 'mm_context_t' has no member named 'flags'
    1051 |                           &current->mm->context.flags);
         |                                                ^
   arch/x86/kernel/process.c: In function 'get_coco_user_hcall_mode':
>> arch/x86/kernel/process.c:1042:1: warning: control reaches end of non-void function [-Wreturn-type]
    1042 | }
         | ^


vim +1041 arch/x86/kernel/process.c

  1037	
  1038	static int get_coco_user_hcall_mode(void)
  1039	{
  1040		return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
> 1041				&current->mm->context.flags);
> 1042	}
  1043	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
