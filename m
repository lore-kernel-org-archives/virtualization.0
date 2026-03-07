Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F479CD;
	Sat,  7 Mar 2026 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772890043; cv=none; b=blHCxBRoK7Zct3ggax7HZNzo7cFAFSSSfB8ijDM0CqsUnKtEbHJuskkT00IdhzN2+bFpdGnmorYdFQxm1/gC+gN3KfBuPledGb4veBbLE7N8h1+sr4UmavmFpsRjLdY4SRRK/8n6Lwm7EEMCtaV8o37l4w/qcKZvHx+4AednLCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772890043; c=relaxed/simple;
	bh=vIvT6bQId4zPdoWRJ0P5oTpovgUsdg9ymIKV+oAiH9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp1V4koEYOEQywuFOhD+e9Uvzl4e4NT73cMCX0TL1xNsbEC5wt0gcp4tdJgB/ePj2mA4V+CUCLSctSxanYsBJ1rF0W27UboxUO3O91mIFxSXBLYEqwWv2KviIsHhuSRsSe45wIMHuVnhz7J72oLeUzS4/H1VaXkvqa+oy6zNL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=anwakfsr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anwakfsr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772890042; x=1804426042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vIvT6bQId4zPdoWRJ0P5oTpovgUsdg9ymIKV+oAiH9E=;
  b=anwakfsrV2dNb5CAGHdR9FDFOz8tnrnmdKEDtXNowfJgks7oSaxeq/Kv
   WzwJQJZf9r7mmwmcSzmrKLqBJ/LPNPa3ZPGgF9Pcn+jMFzKFv1lxy7vn2
   iGLggCyxvqc/ssodl9ehJ9NRIzzwyE59BslUA6VaavjHxKJcfmJ/OohLN
   9Dxj+nKlVJUEaoH0JrV5n8AgS8UYGwsnVyAopXQiIDzL1PqP9cSGTqHSr
   S4vTyxai3Q5Rdq5bv5SIv0J0O3znEZ//3XUjsbkWcZsEVnzs0d4qf3Dxc
   7UNmEQFc4zR95BEl7uB6V9W81pDU9pL6bK3pazJZnwZN2KLC01FyAzKLa
   w==;
X-CSE-ConnectionGUID: l+eYmHK9RICvNtwy+T8amA==
X-CSE-MsgGUID: coCutW55SqibLlFb3vVOog==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="74027647"
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="74027647"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 05:27:22 -0800
X-CSE-ConnectionGUID: N1AucRjnT7mxrOb/Ev0EYQ==
X-CSE-MsgGUID: bXFbXXPoTfWZKUIFR3x27w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="219259446"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 07 Mar 2026 05:27:18 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyrgY-0000000021g-0eEz;
	Sat, 07 Mar 2026 13:27:14 +0000
Date: Sat, 7 Mar 2026 21:26:58 +0800
From: kernel test robot <lkp@intel.com>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
	virtualization@lists.linux.dev, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, mingo@redhat.com, tglx@linutronix.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ajay.kaher@broadcom.com, brennan.lamoreaux@broadcom.com,
	bo.gan@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, linux-coco@lists.linux.dev,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: Re: [PATCH 2/4] x86/vmware: Log kmsg dump on panic
Message-ID: <202603072123.02mytKqA-lkp@intel.com>
References: <20260307004238.1181299-3-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307004238.1181299-3-alexey.makhalov@broadcom.com>

Hi Alexey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/master]
[also build test WARNING on linus/master v7.0-rc2 next-20260305]
[cannot apply to tip/x86/vmware tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexey-Makhalov/x86-vmware-Introduce-common-vmware_hypercall/20260307-091038
base:   tip/master
patch link:    https://lore.kernel.org/r/20260307004238.1181299-3-alexey.makhalov%40broadcom.com
patch subject: [PATCH 2/4] x86/vmware: Log kmsg dump on panic
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260307/202603072123.02mytKqA-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603072123.02mytKqA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603072123.02mytKqA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: arch/x86/kernel/cpu/vmware.c:741 function parameter 'dumper' not described in 'kmsg_dumper_vmware_log'
>> Warning: arch/x86/kernel/cpu/vmware.c:741 function parameter 'detail' not described in 'kmsg_dumper_vmware_log'
>> Warning: arch/x86/kernel/cpu/vmware.c:741 function parameter 'dumper' not described in 'kmsg_dumper_vmware_log'
>> Warning: arch/x86/kernel/cpu/vmware.c:741 function parameter 'detail' not described in 'kmsg_dumper_vmware_log'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
