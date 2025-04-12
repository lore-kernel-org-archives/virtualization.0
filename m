Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7EF13AA3C;
	Sat, 12 Apr 2025 03:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744427909; cv=none; b=eTSka/6bJemknLidiSBg+kaXh6cEtd9GgOs5IveyYP931g3v9Ezu/GRuFT7VKNl0AbgyGdVidlRSYIDJdTU7TVeUSaCKVI6hUjEr8bp7XtXgrZc639Wzg57+8HfcorX2lqSiVWl4kdxrVRr+pHvowoiCMsnAsUfhWTi8s5aOAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744427909; c=relaxed/simple;
	bh=5eRW5rxiHznaS29DsjlvBn1/iGmaCk4FYmbVdFXA/TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEMHiz4QFQeG7TmBBUlZPXlN2tVTTyMsfTwIC2/r7Jia+/4HTp1bBbYsZNkzxQY81c46XBGC/B8Js1IvIbebUy72gZREWbil6tsqrhBaGEob+LJYqxUTyj5hBdrAa997zaAkzGNoEQgre9UnsAWG7c/AzzQqPQSz0xYanJawRds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtD2Km53; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtD2Km53"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744427907; x=1775963907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5eRW5rxiHznaS29DsjlvBn1/iGmaCk4FYmbVdFXA/TM=;
  b=YtD2Km53pPK5vFS1jmTXa0f2/j6UGI7k7dOaCNj1CZ3Y90ItaiOXZwHd
   KdsErXw+J0tLxNy38L/3xys/x1/sVXz8x4XThbv7f/nSGnkK69eQRBbu3
   80s5oyBqVbqYub34lOnGjgunUdyQqnxay7+QPxdYhb0bKwj0es3m65gfS
   oyDd4N8mho4yW3rmihnr37XNUx/hpy2xIRSo5KmAxdStzJ8oTON40DET/
   ka98Aiz52UyyiXtxdFT3os4dXXvMN8FhH7GDV9VIg5y1Qgf/N4vCDM17S
   f1yH0INbRxzlhMj3p9mn/THQlnGwGwoTThaiEuu16eqxZX4uYC9MXWAkx
   Q==;
X-CSE-ConnectionGUID: Iiz9NIbgScSnVxdW3ITpQQ==
X-CSE-MsgGUID: VNv3V3TlQGareHZ4HCwQVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45120226"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45120226"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:18:26 -0700
X-CSE-ConnectionGUID: q+jyXXBuRWOmAYFAkaeg5A==
X-CSE-MsgGUID: WaJlrbmWTlSWu6DOVsrunQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="160326412"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 11 Apr 2025 20:18:23 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3RNt-000BXi-0f;
	Sat, 12 Apr 2025 03:18:21 +0000
Date: Sat, 12 Apr 2025 11:17:39 +0800
From: kernel test robot <lkp@intel.com>
To: Shyam Saini <shyamsaini@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jgg@ziepe.ca,
	will@kernel.org, jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 1/3] arm-smmu: move MSI_IOVA macro definitions
Message-ID: <202504121044.VSL6FbCC-lkp@intel.com>
References: <20250410225030.2528385-2-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410225030.2528385-2-shyamsaini@linux.microsoft.com>

Hi Shyam,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.15-rc1 next-20250411]
[cannot apply to soc/for-next joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shyam-Saini/arm-smmu-move-MSI_IOVA-macro-definitions/20250411-070014
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250410225030.2528385-2-shyamsaini%40linux.microsoft.com
patch subject: [PATCH v2 1/3] arm-smmu: move MSI_IOVA macro definitions
config: arm-randconfig-001-20250412 (https://download.01.org/0day-ci/archive/20250412/202504121044.VSL6FbCC-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250412/202504121044.VSL6FbCC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504121044.VSL6FbCC-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iommu/arm/arm-smmu/arm-smmu.c:1597:35: error: use of undeclared identifier 'MSI_IOVA_BASE'
    1597 |         region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
         |                                          ^
>> drivers/iommu/arm/arm-smmu/arm-smmu.c:1597:50: error: use of undeclared identifier 'MSI_IOVA_LENGTH'
    1597 |         region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
         |                                                         ^
   2 errors generated.


vim +/MSI_IOVA_LENGTH +1597 drivers/iommu/arm/arm-smmu/arm-smmu.c

021bb8420d44cf drivers/iommu/arm-smmu.c              Robin Murphy 2016-09-14  1590  
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1591  static void arm_smmu_get_resv_regions(struct device *dev,
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1592  				      struct list_head *head)
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1593  {
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1594  	struct iommu_resv_region *region;
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1595  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1596  
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19 @1597  	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
0251d0107cfb0b drivers/iommu/arm/arm-smmu/arm-smmu.c Lu Baolu     2022-10-19  1598  					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1599  	if (!region)
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1600  		return;
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1601  
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1602  	list_add_tail(&region->list, head);
273df9635385b2 drivers/iommu/arm-smmu.c              Robin Murphy 2017-03-16  1603  
273df9635385b2 drivers/iommu/arm-smmu.c              Robin Murphy 2017-03-16  1604  	iommu_dma_get_resv_regions(dev, head);
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1605  }
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1606  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
