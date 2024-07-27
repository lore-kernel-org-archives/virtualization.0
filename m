Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85483374EA;
	Sat, 27 Jul 2024 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722065128; cv=none; b=JGHG+Y4zcblbjGaMUjcW1W1vDuNgH6M4h4qgU5WqchuZfQlxzRZhukfStDSn0jYFR+NmIqCB7oXTIPiL8TdoW/3Fu4FB2bNTS09dQavb3uW3wLzIvucSghvqw2Jtfj8ahUskoP1V2mRescKfG7NNSnHYlvinE0FQYgjoC+kz+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722065128; c=relaxed/simple;
	bh=N8sbAXOrGNq9MafR41Ns3GNaJEO1tU2bnnRUrxQXi5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+TmFTbRRmONZx2QRxAGt0nQX8zvA9vL6nrtg1DbbEJVjcr6sdthPQYSaq+l6qdLRbaUtiOydXepE/s8lzYgPynf7GWlQn/FsNfOup/llJ9GeK3M20vRuQKLWr2khCYZWlgpXzCVS5Wajht1Mbzf1Zk4tfkMT1NdMhJoLKXo2Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jR9Xk8dP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jR9Xk8dP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722065126; x=1753601126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N8sbAXOrGNq9MafR41Ns3GNaJEO1tU2bnnRUrxQXi5A=;
  b=jR9Xk8dPSFmmk3kwVTLVJRDtn6FLgDcGiSfO5xQXL38o50t/HYpTXtcW
   S0DhC98k57vMV6vQO+Zti9qHR/3zaiXqh+25EUUMQd0eeTKv5/7Hv0ngR
   uum+5Qw9PvfAZPlwF7zt8R8J94AEGiBVkHw04VNH2hehhy2YanZX2Q2ww
   Yu7/IM2/syidZLFCT0fth8kgrAPlrZak8kmBSfFgzbHqQf6gevNXTuZA9
   yG+0w7XEaTWVEoWXRcVLUchKfwiRNlxIsEIgUXlKRMseERuM2Cdbp+S6V
   A5gdDRlpjL8ai0mGlDTNwOba5zwaQq0lz8Nq6hl+jLfkfNuZNX0rMGOO2
   w==;
X-CSE-ConnectionGUID: q26qctsjQO2+ViNwOYjE6w==
X-CSE-MsgGUID: ozT5/Cf5St6SMH/oJHcnig==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="20051414"
X-IronPort-AV: E=Sophos;i="6.09,240,1716274800"; 
   d="scan'208";a="20051414"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 00:25:26 -0700
X-CSE-ConnectionGUID: F7qawGQUTz2BRCzV8TI8Xw==
X-CSE-MsgGUID: miuXKPi+SdyZwTPHTUeAVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,240,1716274800"; 
   d="scan'208";a="58288846"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 27 Jul 2024 00:25:19 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXbno-000piS-07;
	Sat, 27 Jul 2024 07:25:16 +0000
Date: Sat, 27 Jul 2024 15:24:33 +0800
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
Message-ID: <202407271528.NcCDP6PG-lkp@intel.com>
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
config: i386-buildonly-randconfig-003-20240727 (https://download.01.org/0day-ci/archive/20240727/202407271528.NcCDP6PG-lkp@intel.com/config)
compiler: gcc-8 (Ubuntu 8.4.0-3ubuntu2) 8.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240727/202407271528.NcCDP6PG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407271528.NcCDP6PG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:23,
                    from arch/x86/kernel/process.c:5:
   arch/x86/kernel/process.c: In function 'get_coco_user_hcall_mode':
>> arch/x86/kernel/process.c:1041:25: error: 'mm_context_t' {aka 'struct <anonymous>'} has no member named 'flags'
       &current->mm->context.flags);
                            ^
   include/linux/bitops.h:45:37: note: in definition of macro 'bitop'
       __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
                                        ^~~~
   arch/x86/kernel/process.c:1040:10: note: in expansion of macro 'test_bit'
     return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
             ^~~~~~~~
>> arch/x86/kernel/process.c:1041:25: error: 'mm_context_t' {aka 'struct <anonymous>'} has no member named 'flags'
       &current->mm->context.flags);
                            ^
   include/linux/bitops.h:46:16: note: in definition of macro 'bitop'
       (uintptr_t)(addr) != (uintptr_t)NULL &&   \
                   ^~~~
   arch/x86/kernel/process.c:1040:10: note: in expansion of macro 'test_bit'
     return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
             ^~~~~~~~
>> arch/x86/kernel/process.c:1041:25: error: 'mm_context_t' {aka 'struct <anonymous>'} has no member named 'flags'
       &current->mm->context.flags);
                            ^
   include/linux/bitops.h:47:50: note: in definition of macro 'bitop'
       __builtin_constant_p(*(const unsigned long *)(addr))) ? \
                                                     ^~~~
   arch/x86/kernel/process.c:1040:10: note: in expansion of macro 'test_bit'
     return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
             ^~~~~~~~
>> arch/x86/kernel/process.c:1041:25: error: 'mm_context_t' {aka 'struct <anonymous>'} has no member named 'flags'
       &current->mm->context.flags);
                            ^
   include/linux/bitops.h:48:17: note: in definition of macro 'bitop'
      const##op(nr, addr) : op(nr, addr))
                    ^~~~
   arch/x86/kernel/process.c:1040:10: note: in expansion of macro 'test_bit'
     return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
             ^~~~~~~~
>> arch/x86/kernel/process.c:1041:25: error: 'mm_context_t' {aka 'struct <anonymous>'} has no member named 'flags'
       &current->mm->context.flags);
                            ^
   include/linux/bitops.h:48:32: note: in definition of macro 'bitop'
      const##op(nr, addr) : op(nr, addr))
                                   ^~~~
   arch/x86/kernel/process.c:1040:10: note: in expansion of macro 'test_bit'
     return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
             ^~~~~~~~
   arch/x86/kernel/process.c: In function 'set_coco_user_hcall_mode':
   arch/x86/kernel/process.c:1048:25: error: 'mm_context_t' {aka 'struct <anonymous>'} has no member named 'flags'
       &current->mm->context.flags);
                            ^
   arch/x86/kernel/process.c:1051:27: error: 'mm_context_t' {aka 'struct <anonymous>'} has no member named 'flags'
         &current->mm->context.flags);
                              ^
   arch/x86/kernel/process.c: In function 'get_coco_user_hcall_mode':
   arch/x86/kernel/process.c:1042:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^


vim +1041 arch/x86/kernel/process.c

  1037	
  1038	static int get_coco_user_hcall_mode(void)
  1039	{
  1040		return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
> 1041				&current->mm->context.flags);
  1042	}
  1043	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
