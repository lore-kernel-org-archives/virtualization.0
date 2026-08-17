Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2133002AB;
	Mon, 17 Aug 2026 04:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786941799; cv=none; b=QYIpsfKpMPSBB4nqqGiefmBmSSnIMNeUYV0jaZU8iDICVhELdi0loVtls8ktofrgWiB0yFinL+kGvpN0W8wqi3tPudog1JuRwUdutZWZVAWv2Wb97umozp+9rpFU0qY/ljc/TyDr/ywkJb0SuEBeOJgm0zNfD/Hyo9x064Yij8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786941799; c=relaxed/simple;
	bh=UNr0WqQQ4LJxUBaTbPsNIgkkxHQNCsswdCTMUgWZVk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDbVyhpPadjKf4Xlu8+TWlN5WtT3N40cFAmh+zDbl5mg1ENUT9fC3W2QRmADlnlNTZZg464/i15s9NsBuj0S/C87f9DU92UGZJzKBYozsjIIHcPYz4b87BEUyHfhO8O8u0fRNntX7sn3tXCprRPF5pINgpF1nQbIQ7KkouU6u9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODG9GF4e; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODG9GF4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786941798; x=1818477798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UNr0WqQQ4LJxUBaTbPsNIgkkxHQNCsswdCTMUgWZVk4=;
  b=ODG9GF4edWSfd+XlfSWIcb6rWd1+HqVN/VnpRowRAjDoNfG8+PCVJ2yX
   4kFC2OMluQES7rbv33CiytrFKqF4Zj5gS/Wxq4/ILkvq57m5Nfbl5rRXO
   y01fatOviRfAkLZVBs5n2xq+DZMvzorh3W2+v2EVzBT6eoict6xFi7jxZ
   3xRVIna2GtzqyOCM8VeXT6Y6nxUpKoJ8cqMEPQQjPm+YoKxpdq8fYZCIb
   UA7JgzwAs+gBugd33w3eAaNsYNlzfjEi4G+YvpPWAtQ2GMCq1BpHGTc4a
   9HgQkNEIwjPnQBC5VKsyd1mfbMwNkuTjETy0pQdOm2uTSIvhFNHac05C2
   Q==;
X-CSE-ConnectionGUID: XB/2DBbwQwyKAKU0qA4NXw==
X-CSE-MsgGUID: HLPqeJI+StKr1C7835/gUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87170323"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87170323"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 21:43:17 -0700
X-CSE-ConnectionGUID: SpDoziGAS0GX9hXWAkS+1w==
X-CSE-MsgGUID: vt9sgPe4RHmQp1s1WxUpiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="269069343"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 16 Aug 2026 21:43:15 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvpBo-00000000dIY-3Hn2;
	Mon, 17 Aug 2026 04:43:12 +0000
Date: Mon, 17 Aug 2026 12:42:55 +0800
From: kernel test robot <lkp@intel.com>
To: LiMing Wu <liming.wu@jaguarmicro.com>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: oe-kbuild-all@lists.linux.dev, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux.dev,
	iommu@lists.linux.dev, angus.chen@jaguarmicro.com,
	Liming Wu <liming.wu@jaguarmicro.com>
Subject: Re: [PATCH] iommu/virtio: Add debugfs state dump
Message-ID: <202608171219.4vMy8i3D-lkp@intel.com>
References: <20260731014838.31187-1-liming.wu@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731014838.31187-1-liming.wu@jaguarmicro.com>

Hi LiMing,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on arm-perf/for-next/perf v7.2-rc7 next-20260814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/LiMing-Wu/iommu-virtio-Add-debugfs-state-dump/20260815-175817
base:   linus/master
patch link:    https://lore.kernel.org/r/20260731014838.31187-1-liming.wu%40jaguarmicro.com
patch subject: [PATCH] iommu/virtio: Add debugfs state dump
config: i386-buildonly-randconfig-002-20260817 (https://download.01.org/0day-ci/archive/20260817/202608171219.4vMy8i3D-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260817/202608171219.4vMy8i3D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608171219.4vMy8i3D-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iommu/virtio-iommu.c: In function 'viommu_debugfs_status_show':
>> drivers/iommu/virtio-iommu.c:164:41: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
     164 |         seq_printf(s, "input_range: %#llx-%#llx\n",
         |                                     ~~~~^
         |                                         |
         |                                         long long unsigned int
         |                                     %#x
     165 |                    viommu->geometry.aperture_start,
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                    |
         |                                    dma_addr_t {aka unsigned int}
   drivers/iommu/virtio-iommu.c:164:47: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
     164 |         seq_printf(s, "input_range: %#llx-%#llx\n",
         |                                           ~~~~^
         |                                               |
         |                                               long long unsigned int
         |                                           %#x
     165 |                    viommu->geometry.aperture_start,
     166 |                    viommu->geometry.aperture_end);
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                    |
         |                                    dma_addr_t {aka unsigned int}
   In file included from include/linux/limits.h:7,
                    from include/linux/overflow.h:6,
                    from include/linux/bits.h:32,
                    from include/linux/bitops.h:6,
                    from include/linux/log2.h:12,
                    from arch/x86/include/asm/div64.h:8,
                    from include/linux/math.h:6,
                    from include/linux/delay.h:12,
                    from drivers/iommu/virtio-iommu.c:10:
   drivers/iommu/virtio-iommu.c: In function 'viommu_debugfs_count_mappings':
   include/vdso/limits.h:16:25: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
      16 | #define ULLONG_MAX      (~0ULL)
         |                         ^~~~~~~
   drivers/iommu/virtio-iommu.c:242:69: note: in expansion of macro 'ULLONG_MAX'
     242 |         for (node = interval_tree_iter_first(&vdomain->mappings, 0, ULLONG_MAX);
         |                                                                     ^~~~~~~~~~
   include/vdso/limits.h:16:25: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
      16 | #define ULLONG_MAX      (~0ULL)
         |                         ^~~~~~~
   drivers/iommu/virtio-iommu.c:243:60: note: in expansion of macro 'ULLONG_MAX'
     243 |              node; node = interval_tree_iter_next(node, 0, ULLONG_MAX))
         |                                                            ^~~~~~~~~~
   drivers/iommu/virtio-iommu.c: In function 'viommu_debugfs_print_domain':
   drivers/iommu/virtio-iommu.c:260:75: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 7 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
     260 |                    "id=%u type=%s endpoints=%lu mappings=%lu aperture=%#llx-%#llx pgsize_bitmap=%#lx map_flags=%#x\n",
         |                                                                       ~~~~^
         |                                                                           |
         |                                                                           long long unsigned int
         |                                                                       %#x
   ......
     263 |                    vdomain->domain.geometry.aperture_start,
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                 
         |                                            |
         |                                            dma_addr_t {aka unsigned int}
   drivers/iommu/virtio-iommu.c:260:81: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 8 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
     260 |                    "id=%u type=%s endpoints=%lu mappings=%lu aperture=%#llx-%#llx pgsize_bitmap=%#lx map_flags=%#x\n",
         |                                                                             ~~~~^
         |                                                                                 |
         |                                                                                 long long unsigned int
         |                                                                             %#x
   ......
     264 |                    vdomain->domain.geometry.aperture_end,
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                         
         |                                            |
         |                                            dma_addr_t {aka unsigned int}
   drivers/iommu/virtio-iommu.c: In function 'viommu_debugfs_print_mapping':
   include/vdso/limits.h:16:25: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
      16 | #define ULLONG_MAX      (~0ULL)
         |                         ^~~~~~~
   drivers/iommu/virtio-iommu.c:296:69: note: in expansion of macro 'ULLONG_MAX'
     296 |         for (node = interval_tree_iter_first(&vdomain->mappings, 0, ULLONG_MAX);
         |                                                                     ^~~~~~~~~~
   include/vdso/limits.h:16:25: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
      16 | #define ULLONG_MAX      (~0ULL)
         |                         ^~~~~~~
   drivers/iommu/virtio-iommu.c:297:60: note: in expansion of macro 'ULLONG_MAX'
     297 |              node; node = interval_tree_iter_next(node, 0, ULLONG_MAX)) {
         |                                                            ^~~~~~~~~~


vim +164 drivers/iommu/virtio-iommu.c

   158	
   159	static int viommu_debugfs_status_show(struct seq_file *s, void *unused)
   160	{
   161		struct viommu_dev *viommu = s->private;
   162	
   163		seq_printf(s, "device: %s\n", virtio_bus_name(viommu->vdev));
 > 164		seq_printf(s, "input_range: %#llx-%#llx\n",
   165			   viommu->geometry.aperture_start,
   166			   viommu->geometry.aperture_end);
   167		seq_printf(s, "page_size_mask: %#llx\n", viommu->pgsize_bitmap);
   168		seq_printf(s, "domain_range: %u-%u\n", viommu->first_domain,
   169			   viommu->last_domain);
   170		seq_printf(s, "identity_domain_id: %u\n",
   171			   viommu->identity_domain_id);
   172		seq_printf(s, "probe_size: %u\n", viommu->probe_size);
   173		seq_printf(s, "map_flags: %#x\n", viommu->map_flags);
   174		seq_puts(s, "features:\n");
   175		viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_MAP_UNMAP,
   176				       "map_unmap");
   177		viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_INPUT_RANGE,
   178				       "input_range");
   179		viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_DOMAIN_RANGE,
   180				       "domain_range");
   181		viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_PROBE, "probe");
   182		viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_MMIO, "mmio");
   183		viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_BYPASS_CONFIG,
   184				       "bypass_config");
   185	
   186		return 0;
   187	}
   188	DEFINE_SHOW_ATTRIBUTE(viommu_debugfs_status);
   189	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
