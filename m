Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A51FCF41;
	Thu,  7 Aug 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589366; cv=none; b=em6tKknu2T+OHgrfXH4H0v5G6psDeOPNn9RQiOY+j5fLB0P0Yfq7W7LlQ53vGpx7ywZPkQ1zxMOrC5muREVxu4B02TZ0SN+0x1YtzX1SfAAUbC5RZBUquRCVJoAMWH3Nf9Z2713Bls1CrAFGh/rEmyjgQMwVsO9SKr7kZ50Whzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589366; c=relaxed/simple;
	bh=TAXqubzsBEIA8arpECTj6N2IP2QqQQyNT2bLiy8zTkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKvC14hl/6ZuMuUtZjZ17kqBrQTUFvzyzh0sLD4X6ZYBxaCtSXiFkvgTA1mw7LgPieYzJ3i1Y04G48uJanOs4kmUeH92tDOI6gjFJVGVP/Y6zCC5qsFw5UkZJ71LMRWktBdeBp6WgEVR6wQyh3gL1CTpfnXfYNRereUqiBsmkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6M8D/Vf; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6M8D/Vf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754589365; x=1786125365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TAXqubzsBEIA8arpECTj6N2IP2QqQQyNT2bLiy8zTkI=;
  b=O6M8D/VfNFZLPPDqqj/mL4eThO9xG4HxF+fbpyANd3f4ybMP/ryCMWeO
   8ArMb1vF9kSOciwhEurUnKIsnjSYCBzWZWMHIg+Nffqc/3u9VrOmuBRE1
   t1DnKISsH7NEn/PW2YwVDx7p852m8driMuiVSiNpfR3uL7fqcdOwbG2Gi
   yHdfIUpEDftcsulm6oEMnfXk9Ice94FmKtUp5Pwtv9zFsqNkDUztY5KF7
   HnJvHXyvj7oWbvEe+Xftiy0jX2bDpmUR5f3ThS+eK41z0q3tfDuubigKj
   23uqgG8xjKpEGeDmd+ZoF2R9hkgw2slCuAL0b8kMVpW4kY1ZHtJPVXNVB
   g==;
X-CSE-ConnectionGUID: emvnQ27pQCOpyWYoqq2RIw==
X-CSE-MsgGUID: oBJDQWr8SZykkZKjyYQ6xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56141672"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56141672"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 10:56:04 -0700
X-CSE-ConnectionGUID: sgd3Ks+xRWWyEHltsJTu+w==
X-CSE-MsgGUID: 3Dd3cOroRKuj9Wq4M4u96A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165139305"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 07 Aug 2025 10:56:00 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uk4qG-00034I-2D;
	Thu, 07 Aug 2025 17:55:55 +0000
Date: Fri, 8 Aug 2025 01:55:35 +0800
From: kernel test robot <lkp@intel.com>
To: Shyam Saini <shyamsaini@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, jgg@ziepe.ca, will@kernel.org,
	jacob.pan@linux.microsoft.com, eric.auger@redhat.com,
	code@tyhicks.com, eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com, bboscaccy@linux.microsoft.com
Subject: Re: [PATCH v3 3/3] arm-smmu: select suitable MSI IOVA
Message-ID: <202508080104.M1bnmiMo-lkp@intel.com>
References: <20250806215539.1240561-4-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806215539.1240561-4-shyamsaini@linux.microsoft.com>

Hi Shyam,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.16 next-20250807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shyam-Saini/arm-smmu-move-MSI_IOVA-macro-definitions/20250807-055741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20250806215539.1240561-4-shyamsaini%40linux.microsoft.com
patch subject: [PATCH v3 3/3] arm-smmu: select suitable MSI IOVA
config: um-randconfig-r071-20250807 (https://download.01.org/0day-ci/archive/20250808/202508080104.M1bnmiMo-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7b8dea265e72c3037b6b1e54d5ab51b7e14f328b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250808/202508080104.M1bnmiMo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508080104.M1bnmiMo-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iommu/arm/arm-smmu/arm-smmu.c:24:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
   drivers/iommu/arm/arm-smmu/arm-smmu.c:1602:35: error: use of undeclared identifier 'MSI_IOVA_BASE'
    1602 |         static const u64 msi_bases[] = { MSI_IOVA_BASE, MSI_IOVA_BASE2 };
         |                                          ^~~~~~~~~~~~~
>> drivers/iommu/arm/arm-smmu/arm-smmu.c:1602:50: error: use of undeclared identifier 'MSI_IOVA_BASE2'
    1602 |         static const u64 msi_bases[] = { MSI_IOVA_BASE, MSI_IOVA_BASE2 };
         |                                                         ^~~~~~~~~~~~~~
>> drivers/iommu/arm/arm-smmu/arm-smmu.c:1610:23: error: invalid application of 'sizeof' to an incomplete type 'const u64[]' (aka 'const unsigned long long[]')
    1610 |         for (int i = 0; i != ARRAY_SIZE(msi_bases); i++) {
         |                              ^~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^~~~~
   drivers/iommu/arm/arm-smmu/arm-smmu.c:1613:44: error: use of undeclared identifier 'MSI_IOVA_LENGTH'
    1613 |                 if (resv_region_intersects(msi_bases[i], MSI_IOVA_LENGTH, head))
         |                                                          ^~~~~~~~~~~~~~~
   drivers/iommu/arm/arm-smmu/arm-smmu.c:1616:50: error: use of undeclared identifier 'MSI_IOVA_LENGTH'
    1616 |                 region = iommu_alloc_resv_region(msi_bases[i], MSI_IOVA_LENGTH, prot,
         |                                                                ^~~~~~~~~~~~~~~
   1 warning and 5 errors generated.


vim +/MSI_IOVA_BASE2 +1602 drivers/iommu/arm/arm-smmu/arm-smmu.c

  1596	
  1597	static void arm_smmu_get_resv_regions(struct device *dev,
  1598					      struct list_head *head)
  1599	{
  1600		int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
  1601	
> 1602		static const u64 msi_bases[] = { MSI_IOVA_BASE, MSI_IOVA_BASE2 };
  1603	
  1604		iommu_dma_get_resv_regions(dev, head);
  1605	
  1606		/*
  1607		 * Use the first msi_base that does not intersect with a platform
  1608		 * reserved region. The SW MSI base selection is entirely arbitrary.
  1609		 */
> 1610		for (int i = 0; i != ARRAY_SIZE(msi_bases); i++) {
  1611			struct iommu_resv_region *region;
  1612	
  1613			if (resv_region_intersects(msi_bases[i], MSI_IOVA_LENGTH, head))
  1614				continue;
  1615	
  1616			region = iommu_alloc_resv_region(msi_bases[i], MSI_IOVA_LENGTH, prot,
  1617							 IOMMU_RESV_SW_MSI, GFP_KERNEL);
  1618			if (!region)
  1619				return;
  1620	
  1621			list_add_tail(&region->list, head);
  1622			return;
  1623		}
  1624	}
  1625	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
