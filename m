Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC81198E74;
	Thu, 15 Aug 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726344; cv=none; b=p5ykyfMsMFYk0CoRE4qH1jHkPq2E+ZQJaPItW/NGWzfMSlJIH3AuFoVBlOGQfEGdQ7qq+j2iJH/kZnNIdViMI6cm5sFiv2AjgTB1C0XMM9tPlX4K3DeQtBkj6l8wF/ffn0uTQ/FXkpS+pKC1Bvw9wfu+75v6L4J/fC4bSPDSqCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726344; c=relaxed/simple;
	bh=XpvScZzpxZaCIYVn6yo0UudvIu3nKlo5FffJqW2jE1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFWG+fSgN9DyOxkUNjfQKze0Pu5ey49fbW0Jtow14gRcFiA/sdjXR45AJwPavnxLuJfxOk/I/HaCaRMiBSJoUM713mg38QFxoruTcJiB025fPtLmjPfmNU6fh4A1zFN/7EdBFqloo08bNqHDN3IQBhy6HMgyFYlBvtK0g622SKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsNAbT+c; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsNAbT+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723726343; x=1755262343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XpvScZzpxZaCIYVn6yo0UudvIu3nKlo5FffJqW2jE1U=;
  b=jsNAbT+c8QAdjLo9psvFaqgM7Sy9QR+tMFk1pMzZ30zYV4HXo1sGrMmY
   5KXFYznlDh5NQMqCw3ndqUjutKLGtrcRDfkFCgWnj7mq/t8Hd4V2AWuGx
   GOkGVHE9ot3wEF7a4RKgtBFecowfvxAoWSumoa1HEWh8oQX8MhUCVV2RX
   /KOa4cp0MODM5Vsk8M9Oog6XS+p6N8Kq991WRKQNVCxR4N2AV10RJuW8t
   +0Osz9k+vZ9VWdi9n2OK+JCWuBvGcHAMjGAWZT3scCB2woZHdurVKREZj
   /wsE1at5xJaTRSBZ5zYzTp47bIRwGQLu8jxlg0jP/Vd1WwOg+5qKNfQPN
   Q==;
X-CSE-ConnectionGUID: 5yM7kAAbS7SxLK+Dr/bP3g==
X-CSE-MsgGUID: tzMWVD6aQ8iWAgOsA59b0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="33128541"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="33128541"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:52:22 -0700
X-CSE-ConnectionGUID: bIbm6iUSTEy75M6e/5jQ5w==
X-CSE-MsgGUID: tW2zNXktRcWkidgJouN9QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="59299599"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 15 Aug 2024 05:52:18 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seZxg-0003aM-0w;
	Thu, 15 Aug 2024 12:52:16 +0000
Date: Thu, 15 Aug 2024 20:51:22 +0800
From: kernel test robot <lkp@intel.com>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	mingo@redhat.com, tglx@linutronix.de
Cc: oe-kbuild-all@lists.linux.dev, x86@kernel.org, ajay.kaher@broadcom.com,
	bo.gan@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: Re: [PATCH 2/2] x86/vmware: Fix steal time clock under SEV
Message-ID: <202408152054.7LIuKvYe-lkp@intel.com>
References: <20240814210731.761010-2-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814210731.761010-2-alexey.makhalov@broadcom.com>

Hi Alexey,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/vmware]
[also build test ERROR on linus/master v6.11-rc3 next-20240815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexey-Makhalov/x86-vmware-Fix-steal-time-clock-under-SEV/20240815-050918
base:   tip/x86/vmware
patch link:    https://lore.kernel.org/r/20240814210731.761010-2-alexey.makhalov%40broadcom.com
patch subject: [PATCH 2/2] x86/vmware: Fix steal time clock under SEV
config: i386-randconfig-001-20240815 (https://download.01.org/0day-ci/archive/20240815/202408152054.7LIuKvYe-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408152054.7LIuKvYe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408152054.7LIuKvYe-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kernel/cpu/vmware.c: In function 'sev_map_percpu_data':
>> arch/x86/kernel/cpu/vmware.c:313:13: error: 'cc_vendor' undeclared (first use in this function)
     313 |         if (cc_vendor != CC_VENDOR_AMD ||
         |             ^~~~~~~~~
   arch/x86/kernel/cpu/vmware.c:313:13: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86/kernel/cpu/vmware.c:313:26: error: 'CC_VENDOR_AMD' undeclared (first use in this function); did you mean 'X86_VENDOR_AMD'?
     313 |         if (cc_vendor != CC_VENDOR_AMD ||
         |                          ^~~~~~~~~~~~~
         |                          X86_VENDOR_AMD


vim +/cc_vendor +313 arch/x86/kernel/cpu/vmware.c

   308	
   309	static void __init sev_map_percpu_data(void)
   310	{
   311		int cpu;
   312	
 > 313		if (cc_vendor != CC_VENDOR_AMD ||
   314		    !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
   315			return;
   316	
   317		for_each_possible_cpu(cpu) {
   318			early_set_memory_decrypted(
   319				(unsigned long)&per_cpu(vmw_steal_time, cpu),
   320				sizeof(vmw_steal_time));
   321		}
   322	}
   323	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
