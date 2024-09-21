Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9A176FDB;
	Sat, 21 Sep 2024 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726939743; cv=none; b=WPDDYvWJ3TNNOw8YHn9G7/8HIs+3Ni0dkjkh/4W70RV3UtWeR2lMFq257ctHtDkS9IX6ezToCQPRqpDFIONub14Tp5cG7twtk6geNHEAxZ7axYF+OZiJNrFkgINWRVK4h1zCPz8x1ENE+0QSEwei3ImvHXbqMPW3FwTI2hScPt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726939743; c=relaxed/simple;
	bh=XkZ8EqP3YUt9TcIO8/N9L/IuUrNSlk9YL/IUUQn9iOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiGKpp4WBRiVqeC0ZNkTptwTCFfzoP8WJBFXAEOTk5qXVb1MMdnsfxG5/V66wh70MlLgeyRL0u8G6IDWAFm/C5iCH3w2eGMF6b5pNB1gXDRCidlJLByCilPYRcQ5xBhvg1N1aC3rGZIzedLRnh/9rcjXM7k0jf0nKLi4RdoK6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OFyejPFo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OFyejPFo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726939741; x=1758475741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XkZ8EqP3YUt9TcIO8/N9L/IuUrNSlk9YL/IUUQn9iOI=;
  b=OFyejPFoj0sUXHiL4kS0PkpuVdXfNIGVlhyMvz4XYDZ95lP6wtwupKdQ
   CZxEY5ZhMFZk/cLGdKEUElvsq+Z7RVLU13SWVdZLKN/0EqTOcEyFijoVJ
   Fo4asxs4PQ1rPg2qsGkHtw7BMw6ViMKCaXA5Oc/ePiPeFPnhtIG2L7Qca
   +lWSMe1krwl+J8Sav8OsQApwRBZJEex1zf7arW1SuVvml0dhU4iOI2aL5
   Z8tBvpGWT/LLQFrm9jBMWp0ckVbMivHYMeOdHhprYgTVptItoF8ybFcsU
   qJfUmBlfHnXpsRys0u9OYHvZ+hwu6RdudYBcCvT8iPCe1Zkac6s8CUB7c
   A==;
X-CSE-ConnectionGUID: gwOOU64STPWZ2HptZHep8w==
X-CSE-MsgGUID: 7xqWmOZVSqG+Z7ZPugeMzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="29719652"
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="29719652"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 10:29:01 -0700
X-CSE-ConnectionGUID: yQNEjcEbQOaj15Zd8ov60A==
X-CSE-MsgGUID: mJr0SVTNRAC6LaO1gJyAFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="70914300"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2024 10:28:58 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ss3ui-000Fdp-0H;
	Sat, 21 Sep 2024 17:28:56 +0000
Date: Sun, 22 Sep 2024 01:28:00 +0800
From: kernel test robot <lkp@intel.com>
To: Srujana Challa <schalla@marvell.com>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
	eperezma@redhat.com, ndabilpuram@marvell.com, jerinj@marvell.com
Subject: Re: [PATCH v2 1/2] vhost-vdpa: introduce module parameter for
 no-IOMMU mode
Message-ID: <202409220134.x63FmsHx-lkp@intel.com>
References: <20240920140530.775307-2-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920140530.775307-2-schalla@marvell.com>

Hi Srujana,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.11 next-20240920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Srujana-Challa/vhost-vdpa-introduce-module-parameter-for-no-IOMMU-mode/20240920-220751
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20240920140530.775307-2-schalla%40marvell.com
patch subject: [PATCH v2 1/2] vhost-vdpa: introduce module parameter for no-IOMMU mode
config: x86_64-randconfig-122-20240921 (https://download.01.org/0day-ci/archive/20240922/202409220134.x63FmsHx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240922/202409220134.x63FmsHx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409220134.x63FmsHx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/vhost/vdpa.c:39:6: sparse: sparse: symbol 'vhost_vdpa_noiommu' was not declared. Should it be static?

vim +/vhost_vdpa_noiommu +39 drivers/vhost/vdpa.c

    38	
  > 39	bool vhost_vdpa_noiommu;
    40	module_param_named(enable_vhost_vdpa_unsafe_noiommu_mode,
    41			   vhost_vdpa_noiommu, bool, 0644);
    42	MODULE_PARM_DESC(enable_vhost_vdpa_unsafe_noiommu_mode, "Enable UNSAFE, no-IOMMU mode.  This mode provides no device isolation, no DMA translation, no host kernel protection, cannot be used for device assignment to virtual machines, requires RAWIO permissions, and will taint the kernel.  If you do not know what this is for, step away. (default: false)");
    43	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
