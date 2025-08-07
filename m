Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61359230264;
	Thu,  7 Aug 2025 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577229; cv=none; b=O1HXHErISJuC9j6ffJXYWs7sm5g4rRxp7nsNZGk6Jm5j2w2UUVr2Z2lv5ApX79bEoctGioAX6ct+kJQFkz3D55HZR4xIRe1QTh3fsiH+PIieq5cuYFb3inPKmFMwbr39XyN4K9O0TbaF10tDdgcLMS11zk9oaXlli6OFYIfvE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577229; c=relaxed/simple;
	bh=Wb1Mj5eB9a3PVIkwcblhXlBnzqloEY/YGjLzscQcGsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkqQgbWoeveeyukv/ZxxTUZtyoGBaDKjYVMsWO1LjPMpBH5yAKIIZ3zfQ9I2J18MfLY7KxdlyyieqrUiEz+esIiEUmtLIn5Bqhf+rm/huR+2RN/bMWOBL+y0Ym4sM/8hgYUSiBe9B6mxrsxEFkrK1qtrMh/BWM7PXmJWkZj+jrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEULi165; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEULi165"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754577228; x=1786113228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wb1Mj5eB9a3PVIkwcblhXlBnzqloEY/YGjLzscQcGsI=;
  b=AEULi165dE4I44zvLFSox44e8zDa6I3E2IBGAZ1XqEHfLEyqr9PV0DWv
   Tcmy+prs+5xnMnmDdLX2muvqnaJ8vmadUTwO0710vzNPa1nAFKV2HcWi1
   Tgv4XVRco8zzxRLWn3MVE0qfawGBBzxbxgYugGhzfwPitLHC1AuuXGujH
   lmo0t2iANX3D/8TqTqm+eG+ZPi21xOHdMBzJiSTtjaa3/3hidxuHHwA0o
   a8AiXd8w6RLS48UI1lgui3fj2pU3CLN5gH6EpTSMS4RvcUqf31RC82LB5
   3K4L3V4hFvYGSQAIaA9d+gdLxDh/AJgEgz/cfTMTGa5jvd5rnJ/i/1uJq
   Q==;
X-CSE-ConnectionGUID: dBJRj+NvQHi5dUsrhjMfqQ==
X-CSE-MsgGUID: +KVgINGeSW2KifkJ0AGf2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="68288328"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="68288328"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 07:33:47 -0700
X-CSE-ConnectionGUID: 9Us8bKFQSI+xgOF3SRwvCA==
X-CSE-MsgGUID: JQBwjP7BRQusc2Djw8PMcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="169281764"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 07 Aug 2025 07:33:44 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uk1gb-0002sw-1Q;
	Thu, 07 Aug 2025 14:33:41 +0000
Date: Thu, 7 Aug 2025 22:32:42 +0800
From: kernel test robot <lkp@intel.com>
To: Shyam Saini <shyamsaini@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, jgg@ziepe.ca, will@kernel.org,
	jacob.pan@linux.microsoft.com, eric.auger@redhat.com,
	code@tyhicks.com, eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com, bboscaccy@linux.microsoft.com
Subject: Re: [PATCH v3 1/3] arm-smmu: move MSI_IOVA macro definitions
Message-ID: <202508072221.zOvuARaV-lkp@intel.com>
References: <20250806215539.1240561-2-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806215539.1240561-2-shyamsaini@linux.microsoft.com>

Hi Shyam,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.16 next-20250807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shyam-Saini/arm-smmu-move-MSI_IOVA-macro-definitions/20250807-055741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20250806215539.1240561-2-shyamsaini%40linux.microsoft.com
patch subject: [PATCH v3 1/3] arm-smmu: move MSI_IOVA macro definitions
config: um-randconfig-r071-20250807 (https://download.01.org/0day-ci/archive/20250807/202508072221.zOvuARaV-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7b8dea265e72c3037b6b1e54d5ab51b7e14f328b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508072221.zOvuARaV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508072221.zOvuARaV-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iommu/arm/arm-smmu/arm-smmu.c:24:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/iommu/arm/arm-smmu/arm-smmu.c:1603:35: error: use of undeclared identifier 'MSI_IOVA_BASE'
    1603 |         region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
         |                                          ^~~~~~~~~~~~~
   drivers/iommu/arm/arm-smmu/arm-smmu.c:1603:50: error: use of undeclared identifier 'MSI_IOVA_LENGTH'
    1603 |         region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
         |                                                         ^~~~~~~~~~~~~~~
   1 warning and 2 errors generated.


vim +/MSI_IOVA_BASE +1603 drivers/iommu/arm/arm-smmu/arm-smmu.c

021bb8420d44cf drivers/iommu/arm-smmu.c              Robin Murphy 2016-09-14  1596  
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1597  static void arm_smmu_get_resv_regions(struct device *dev,
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1598  				      struct list_head *head)
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1599  {
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1600  	struct iommu_resv_region *region;
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1601  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1602  
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19 @1603  	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
0251d0107cfb0b drivers/iommu/arm/arm-smmu/arm-smmu.c Lu Baolu     2022-10-19  1604  					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1605  	if (!region)
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1606  		return;
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1607  
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1608  	list_add_tail(&region->list, head);
273df9635385b2 drivers/iommu/arm-smmu.c              Robin Murphy 2017-03-16  1609  
273df9635385b2 drivers/iommu/arm-smmu.c              Robin Murphy 2017-03-16  1610  	iommu_dma_get_resv_regions(dev, head);
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1611  }
f3ebee80b3131d drivers/iommu/arm-smmu.c              Eric Auger   2017-01-19  1612  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
