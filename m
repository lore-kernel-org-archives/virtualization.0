Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AF726CE05;
	Mon, 17 Aug 2026 03:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786938181; cv=none; b=AF6Q/yGLojwReMtERYdz2oQvwjKkrJ7kLfgBQQB4X9XCuiqJ/o4EnvVnYzk/7r7SxacultY5Ygy1GUunUAE7SDWv0UKZqUYFJakt4omncfEAwQjBu1ACTJJkEeGDR5wKgvcmoszEnvrH4Phol/iXbYdFIqY2+wt/q/tjpxWGM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786938181; c=relaxed/simple;
	bh=EOSrGCtHavRxv/H+5lc0NwtUfIULbsCDZofDEHB+59g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6SuID6BkzoIA29eSvm+FluT3IaP2XSbIUqJVWnA5TGEf5JL9t5Rs4FjHvfD8UYCPNQVM8CXQi1oO4APEraZdz6SSkMtKr/yueH7kSqRZ3LAMTbZrfRhC31Zz4JOYSHU9lof2jLHh8qAuBcMXaDT7sVDwINJLe4UxBgEEcn/JYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlQeqTrM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlQeqTrM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786938180; x=1818474180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EOSrGCtHavRxv/H+5lc0NwtUfIULbsCDZofDEHB+59g=;
  b=GlQeqTrMvBiZ2hrbOyXQ79kNIezmr6FCoTP2PRwduPBC2FFryNf2CG64
   ncvFJZPRiH8MZkazkpBBSaVav6Ph7yE4Y7W+LEl2sbnkM4QS+HEi++bMs
   iqs9a9tPjE1rOlmD2xYlxMsYPtFXB412HLZw2tKrZK5giB5nO7npbKMk2
   tdaNsoGxSefQXw0tTuGh/MhQIyuDUGwmwH/1gGTl2aze9QIa1G71Ht/HG
   mQ0JQyndL5aXZz+FaB/SQ82VYU7HLCtuaB+fwFrdW6tD9exzwQCN6ntAL
   oE3z32il+320gtV6zjPok1QOQI/JIcYLczDuwQNXvtcziI+gxqkm9v5fr
   A==;
X-CSE-ConnectionGUID: neJBoHKjRNutwwf+E5aKAw==
X-CSE-MsgGUID: rghLhq07Tn2Oj5cQ1RxBlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98924235"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="98924235"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 20:42:51 -0700
X-CSE-ConnectionGUID: LT8Q1vA0TW+TswP7amppGA==
X-CSE-MsgGUID: Eo3je0FOTNqyFXh6yGSEMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="294711622"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Aug 2026 20:41:59 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvoEV-00000000dHS-41QH;
	Mon, 17 Aug 2026 03:41:55 +0000
Date: Mon, 17 Aug 2026 11:41:45 +0800
From: kernel test robot <lkp@intel.com>
To: LiMing Wu <liming.wu@jaguarmicro.com>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: oe-kbuild-all@lists.linux.dev, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux.dev,
	iommu@lists.linux.dev, angus.chen@jaguarmicro.com,
	Liming Wu <liming.wu@jaguarmicro.com>
Subject: Re: [PATCH] iommu/virtio: Add debugfs state dump
Message-ID: <202608171132.xtGhKM9V-lkp@intel.com>
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
config: i386-randconfig-141-20260817 (https://download.01.org/0day-ci/archive/20260817/202608171132.xtGhKM9V-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260817/202608171132.xtGhKM9V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608171132.xtGhKM9V-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/virtio-iommu.c:165:6: warning: format specifies type 'unsigned long long' but the argument has type 'dma_addr_t' (aka 'unsigned int') [-Wformat]
     164 |         seq_printf(s, "input_range: %#llx-%#llx\n",
         |                                     ~~~~~
         |                                     %#x
     165 |                    viommu->geometry.aperture_start,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/virtio-iommu.c:166:6: warning: format specifies type 'unsigned long long' but the argument has type 'dma_addr_t' (aka 'unsigned int') [-Wformat]
     164 |         seq_printf(s, "input_range: %#llx-%#llx\n",
         |                                           ~~~~~
         |                                           %#x
     165 |                    viommu->geometry.aperture_start,
     166 |                    viommu->geometry.aperture_end);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/virtio-iommu.c:242:62: warning: implicit conversion from 'unsigned long long' to 'unsigned long' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
     242 |         for (node = interval_tree_iter_first(&vdomain->mappings, 0, ULLONG_MAX);
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~                        ^~~~~~~~~~
   include/vdso/limits.h:16:21: note: expanded from macro 'ULLONG_MAX'
      16 | #define ULLONG_MAX      (~0ULL)
         |                          ^~~~~
   drivers/iommu/virtio-iommu.c:243:53: warning: implicit conversion from 'unsigned long long' to 'unsigned long' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
     243 |              node; node = interval_tree_iter_next(node, 0, ULLONG_MAX))
         |                           ~~~~~~~~~~~~~~~~~~~~~~~          ^~~~~~~~~~
   include/vdso/limits.h:16:21: note: expanded from macro 'ULLONG_MAX'
      16 | #define ULLONG_MAX      (~0ULL)
         |                          ^~~~~
   drivers/iommu/virtio-iommu.c:263:6: warning: format specifies type 'unsigned long long' but the argument has type 'dma_addr_t' (aka 'unsigned int') [-Wformat]
     260 |                    "id=%u type=%s endpoints=%lu mappings=%lu aperture=%#llx-%#llx pgsize_bitmap=%#lx map_flags=%#x\n",
         |                                                                       ~~~~~
         |                                                                       %#x
     261 |                    vdomain->id, viommu_domain_type_name(vdomain->domain.type),
     262 |                    vdomain->nr_endpoints, mappings,
     263 |                    vdomain->domain.geometry.aperture_start,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/virtio-iommu.c:264:6: warning: format specifies type 'unsigned long long' but the argument has type 'dma_addr_t' (aka 'unsigned int') [-Wformat]
     260 |                    "id=%u type=%s endpoints=%lu mappings=%lu aperture=%#llx-%#llx pgsize_bitmap=%#lx map_flags=%#x\n",
         |                                                                             ~~~~~
         |                                                                             %#x
     261 |                    vdomain->id, viommu_domain_type_name(vdomain->domain.type),
     262 |                    vdomain->nr_endpoints, mappings,
     263 |                    vdomain->domain.geometry.aperture_start,
     264 |                    vdomain->domain.geometry.aperture_end,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/virtio-iommu.c:296:62: warning: implicit conversion from 'unsigned long long' to 'unsigned long' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
     296 |         for (node = interval_tree_iter_first(&vdomain->mappings, 0, ULLONG_MAX);
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~                        ^~~~~~~~~~
   include/vdso/limits.h:16:21: note: expanded from macro 'ULLONG_MAX'
      16 | #define ULLONG_MAX      (~0ULL)
         |                          ^~~~~
   drivers/iommu/virtio-iommu.c:297:53: warning: implicit conversion from 'unsigned long long' to 'unsigned long' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
     297 |              node; node = interval_tree_iter_next(node, 0, ULLONG_MAX)) {
         |                           ~~~~~~~~~~~~~~~~~~~~~~~          ^~~~~~~~~~
   include/vdso/limits.h:16:21: note: expanded from macro 'ULLONG_MAX'
      16 | #define ULLONG_MAX      (~0ULL)
         |                          ^~~~~
   8 warnings generated.


vim +165 drivers/iommu/virtio-iommu.c

   158	
   159	static int viommu_debugfs_status_show(struct seq_file *s, void *unused)
   160	{
   161		struct viommu_dev *viommu = s->private;
   162	
   163		seq_printf(s, "device: %s\n", virtio_bus_name(viommu->vdev));
   164		seq_printf(s, "input_range: %#llx-%#llx\n",
 > 165			   viommu->geometry.aperture_start,
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
   190	static void viommu_debugfs_print_endpoint(struct seq_file *s,
   191						  struct viommu_endpoint *vdev)
   192	{
   193		int i;
   194		u32 domain_id = 0;
   195		const char *domain_type = "none";
   196		struct iommu_group *group;
   197		struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
   198	
   199		if (vdev->vdomain) {
   200			domain_type = viommu_domain_type_name(vdev->vdomain->domain.type);
   201			if (vdev->vdomain == &viommu_identity_domain)
   202				domain_id = vdev->viommu->identity_domain_id;
   203			else
   204				domain_id = vdev->vdomain->id;
   205		}
   206	
   207		group = iommu_group_get(vdev->dev);
   208		seq_printf(s, "endpoint=%s group_id=%d domain_type=%s",
   209			   dev_name(vdev->dev), group ? iommu_group_id(group) : -1,
   210			   domain_type);
   211		if (vdev->vdomain)
   212			seq_printf(s, " domain_id=%u", domain_id);
   213		if (fwspec) {
   214			seq_puts(s, " ids=");
   215			for (i = 0; i < fwspec->num_ids; i++)
   216				seq_printf(s, "%s%u", i ? "," : "", fwspec->ids[i]);
   217		}
   218		seq_putc(s, '\n');
   219	
   220		iommu_group_put(group);
   221	}
   222	
   223	static int viommu_debugfs_endpoints_show(struct seq_file *s, void *unused)
   224	{
   225		struct viommu_dev *viommu = s->private;
   226		struct viommu_endpoint *vdev;
   227	
   228		mutex_lock(&viommu->debugfs_lock);
   229		list_for_each_entry(vdev, &viommu->debugfs_endpoints, debugfs_node)
   230			viommu_debugfs_print_endpoint(s, vdev);
   231		mutex_unlock(&viommu->debugfs_lock);
   232	
   233		return 0;
   234	}
   235	DEFINE_SHOW_ATTRIBUTE(viommu_debugfs_endpoints);
   236	
   237	static unsigned long viommu_debugfs_count_mappings(struct viommu_domain *vdomain)
   238	{
   239		unsigned long count = 0;
   240		struct interval_tree_node *node;
   241	
 > 242		for (node = interval_tree_iter_first(&vdomain->mappings, 0, ULLONG_MAX);
   243		     node; node = interval_tree_iter_next(node, 0, ULLONG_MAX))
   244			count++;
   245	
   246		return count;
   247	}
   248	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
