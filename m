Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED129E0E6;
	Tue, 30 Sep 2025 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759267728; cv=none; b=hD6GNUfrajBpcPppuYqlYLfQv/SEcoZQyT+tUfz/k0IPJEXrgsyBOq9E4vTfeadVSW8XmoH9OYsu/QixfM1x+7kP41kN1YhZ4AHAhdqFmc3p8n1IFjFY6tAKYkl7gSN7/ovo3d7PXr8R8VoXXB/OFrqP0mOOD/NVdXsIFuMBY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759267728; c=relaxed/simple;
	bh=zfIdBcB/dpjzaEpep4X7eK5CAcnmsMfVWj/01hovLLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ+83+3/63LH7IzKbHR0VKp+DXO7B7LApWgAqsqPSUlYiHBoNP8FjLu2kwpB6tpVya3471BqOQ027xfPuIDsdZa8VFZiLaBSnPE05I+nO1mqgJ9SUNIkV7XNZ4VtDSVANO8Y+NKwmUNESWA5P4evY9zUBUAy2FTe6Bgcp+y1txw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfiHIW0D; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfiHIW0D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759267728; x=1790803728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zfIdBcB/dpjzaEpep4X7eK5CAcnmsMfVWj/01hovLLc=;
  b=UfiHIW0DWRD5rQQQKbPwBlfMiYlF6BTzRAY1cm60VmmtC9htoYeAmNGM
   1VE7PYODllHsZxqmGAO0LUHaqcItFw/Gvw5/CpTsNlbh0p2M6k65lerJ0
   07B62txoh0WEhHoXxwyXMGTKxvtN4fzLYSK6b3j4rUjaEmhuE1/n9LXtY
   mXcPOxIPEau2g+HeelqimcjQtaNm5Dvzm/qdAOlH9jMmI1hQhNfkxEtPr
   17fuRaGK6tERnulGztQ84wCuGyNeiFgCUWIYmpxb4goKLhlftw0WikBZ1
   XOI34BjpYznzFGMn668ksF4/PYUqMw3DkMsVEdCuoAOzR49myje1BTQxz
   g==;
X-CSE-ConnectionGUID: EJ+3X3BURTCxSF3uY3SsVA==
X-CSE-MsgGUID: rpvv9ErDRZ2mdffcnHOKjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61702280"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61702280"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 14:28:47 -0700
X-CSE-ConnectionGUID: q10CyoJ6SJ+/5NU0nmLg9A==
X-CSE-MsgGUID: 8gjwNvBERwyFySIzgmzpQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="182917958"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Sep 2025 14:28:42 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3htn-0002Ul-2E;
	Tue, 30 Sep 2025 21:28:39 +0000
Date: Wed, 1 Oct 2025 05:27:40 +0800
From: kernel test robot <lkp@intel.com>
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, xin@zytor.com,
	Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 11/12] x86/paravirt: Don't use pv_ops vector for MSR
 access functions
Message-ID: <202510010555.InsgYDTd-lkp@intel.com>
References: <20250930070356.30695-12-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930070356.30695-12-jgross@suse.com>

Hi Juergen,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on linus/master v6.17]
[cannot apply to kvm/queue kvm/next tip/master kvm/linux-next tip/auto-latest next-20250929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Juergen-Gross/coco-tdx-Rename-MSR-access-helpers/20250930-150753
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20250930070356.30695-12-jgross%40suse.com
patch subject: [PATCH v2 11/12] x86/paravirt: Don't use pv_ops vector for MSR access functions
config: x86_64-buildonly-randconfig-001-20251001 (https://download.01.org/0day-ci/archive/20251001/202510010555.InsgYDTd-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251001/202510010555.InsgYDTd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510010555.InsgYDTd-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:18:
   In file included from include/linux/slab.h:16:
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
>> arch/x86/include/asm/msr.h:327:10: fatal error: 'asm/xen/msr.h' file not found
     327 | #include <asm/xen/msr.h>
         |          ^~~~~~~~~~~~~~~
   1 error generated.
   make[3]: *** [scripts/Makefile.build:182: arch/x86/kernel/asm-offsets.s] Error 1 shuffle=3471495288
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1282: prepare0] Error 2 shuffle=3471495288
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=3471495288
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=3471495288
   make: Target 'prepare' not remade because of errors.


vim +327 arch/x86/include/asm/msr.h

   325	
   326	#ifdef CONFIG_XEN_PV
 > 327	#include <asm/xen/msr.h>
   328	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
