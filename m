Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD0B1FECAC;
	Mon,  2 Dec 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733143316; cv=none; b=Qy1A7/KLHt/cL1znrDMnyprt3owOX5vTgSqmIwMq98LvxNvRIH9sGmjA/aCvw+caoyjTOA9xrbqjO0MMXasFIFSzwW2CGBGGSLdfEMqP/JKO+qXkNLV8a8a4pNk8zREr8m/dYcm+HQmrtGxEDdQJyWtELYQZX7c2la6UQqUWlH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733143316; c=relaxed/simple;
	bh=MemJTRZl5TjeSjQ/ni8puxh+g7YvwKhakiHnwne5UwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYukoLO8ekUVU63/8rXB9EEi/60lYP+RqLgb4lBqGStnckvG7cKIgBDTv4+CCDUvaaeXLB87gJi2foaepNB4fDPuSTfDYgcSkWjZqA4FpaxPp9/J7QIlrMp7vKs6euL4tv80mMOETd+VHMJtEXcCjZsapGjKLeK8SQYjiir7YzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDs6t3kF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDs6t3kF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733143313; x=1764679313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MemJTRZl5TjeSjQ/ni8puxh+g7YvwKhakiHnwne5UwM=;
  b=GDs6t3kFbwuRljv5LdNZlcULEkCeA/v+s2n36pXqm2AWnMCb+1VCyHev
   C0cvSqnkTlGfyxIFb6+FSwrLdrTs+7qk4H1UUavzhBi+afJahvQfNCzKW
   OOdWaYrjsdMVcaLFNnPT1DhVATewBhjZt6doF+WYUnDuSTfzSudeOe7me
   JNCVftlxlKN7xzY0w/R/So90fXubSOlQuF3kk6y8410COxmASGjFh0o/G
   i9+y8g6iUzSw6xFWfdBuwLjUetfKvbou5/RUn7NfBiAQQ6pyIChhpOCLs
   mG/JI7cy24o58BXUjL8DlBUXOoakDE75klHB+M2wlpYYsRfH+Z00W9Po4
   Q==;
X-CSE-ConnectionGUID: Ta4F/5F2Sy+Zx3JuxSl8yQ==
X-CSE-MsgGUID: g8CXbPjoS02cjHSKl+1IMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="43919571"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="43919571"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 04:41:51 -0800
X-CSE-ConnectionGUID: DkRXwkisQfu7IqsG1sjx7g==
X-CSE-MsgGUID: sWl/fmRpQ22pcS64WqzZXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="116355048"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 02 Dec 2024 04:41:49 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tI5kI-0002QG-30;
	Mon, 02 Dec 2024 12:41:46 +0000
Date: Mon, 2 Dec 2024 20:41:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Yuxue Liu yuxue.liu@jaguarmicro.com" <yuxue.liu@jaguarmicro.com>,
	jasowang@redhat.com, mst@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, yuxue.liu@jaguarmicro.com,
	angus.chen@jaguarmicro.com
Subject: Re: [PATCH] vdpa/vp_vdpa: implement kick_vq_with_data callback
Message-ID: <202412022030.EVj2Z5mv-lkp@intel.com>
References: <20241202033611.1374-1-yuxue.liu@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202033611.1374-1-yuxue.liu@jaguarmicro.com>

Hi Yuxue,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.13-rc1 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuxue-Liu-yuxue-liu-jaguarmicro-com/vdpa-vp_vdpa-implement-kick_vq_with_data-callback/20241202-114053
base:   linus/master
patch link:    https://lore.kernel.org/r/20241202033611.1374-1-yuxue.liu%40jaguarmicro.com
patch subject: [PATCH] vdpa/vp_vdpa: implement kick_vq_with_data callback
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241202/202412022030.EVj2Z5mv-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241202/202412022030.EVj2Z5mv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412022030.EVj2Z5mv-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/vdpa/virtio_pci/vp_vdpa.c:12:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/vdpa/virtio_pci/vp_vdpa.c:372:39: error: use of undeclared identifier 'vdpa'
     372 |         struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
         |                                              ^
   4 warnings and 1 error generated.


vim +/vdpa +372 drivers/vdpa/virtio_pci/vp_vdpa.c

   369	
   370	static void vp_vdpa_kick_vq_with_data(struct vdpa_device *vdpa_dev, u32 data)
   371	{
 > 372		struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
   373		u16 qid = data & 0xFFFF;
   374	
   375		vp_iowrite32(data, vp_vdpa->vring[qid].notify);
   376	}
   377	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
