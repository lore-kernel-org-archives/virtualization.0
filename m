Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3485C3BBEB;
	Mon, 15 Apr 2024 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183608; cv=none; b=ZvkAmc6b6MbxwYPGXEQP2WEF6fkRBS/Iu7V89jgN4KPAeYw6/COFtmAVNu+bVp9tGGVSDB5YUA99Sl1H2n/QxqyWu7q9hpe8y/ioRWRR73bQft3peuL/TC8KytMV8b7gsIDkLp247D4s7c9wd7XgwEsyU93oCDfbcAHMqZG7EQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183608; c=relaxed/simple;
	bh=2d6p0ZMgD+s1w2DpwQ3LkeXSFpyTWnyon6xYuvcCjTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLhHvIBiGn/KHAthH36dsUfIwRWkuT/XhCUzj01I/h6KZnz0DGVf1AnZ/Wa9dkEMfxJ6GpGnuwkZz/C5PzWgt+BU/7DlQ8ED/ZAWzxP3JO0I+gOBHK5halVNlMl4WLNrp+wNu7E11pgDeqqaxy+d7F7BiZKi57d4OYxvhCZVVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hWMk9t7Z; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWMk9t7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713183607; x=1744719607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2d6p0ZMgD+s1w2DpwQ3LkeXSFpyTWnyon6xYuvcCjTA=;
  b=hWMk9t7ZKNthskuLz7DQNAMzDlv2xYeEFa0MpHbWf6M4ckgRFHcyrnL+
   2L+BFTPyLjslcWdxr8hpfkwZmIN86EBjNqijYeQsL0Xsx1/Mg5f24iV6D
   +ruEJH/W8ps2dSEbt1gYYO0TQEoqC5pk2acWdGeQsd973McFcESsVwOjM
   UH5d12jUmgVQSejCRGgI0Wz6vBeB3Hx1znB138DBJEdasj0ZPSN+JwiB5
   R0KxZJMEkBgRehJwVm63piL8XoaD/aoM6QoH4oqJFv7xLHTpEJddUbkUQ
   DGEgwB3+syA78HIB0l8iIAhFrK9DDnVfy9N3l5k5vTFW39xyyhNXdLUGx
   g==;
X-CSE-ConnectionGUID: NT5NVNiASPS5o4ZImGsj1g==
X-CSE-MsgGUID: /rgRygQNSjag2Yn4hc1qCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8440021"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8440021"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 05:20:06 -0700
X-CSE-ConnectionGUID: ISsIXDq5T5umuXrLrFCGPg==
X-CSE-MsgGUID: tH3kMjU/TY25M3rhF1JUtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="53100893"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 15 Apr 2024 05:20:02 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwLJX-0004AC-0r;
	Mon, 15 Apr 2024 12:19:59 +0000
Date: Mon, 15 Apr 2024 20:19:18 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v7 2/4] ethtool: provide customized dim profile
 management
Message-ID: <202404152018.KkOQ39NY-lkp@intel.com>
References: <20240415093638.123962-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415093638.123962-3-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/linux-dim-move-useful-macros-to-h-file/20240415-173921
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240415093638.123962-3-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v7 2/4] ethtool: provide customized dim profile management
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240415/202404152018.KkOQ39NY-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240415/202404152018.KkOQ39NY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404152018.KkOQ39NY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ethtool/coalesce.c:324:32: warning: 'coalesce_set_profile_policy' defined but not used [-Wunused-const-variable=]
     324 | static const struct nla_policy coalesce_set_profile_policy[] = {
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/coalesce_set_profile_policy +324 net/ethtool/coalesce.c

   323	
 > 324	static const struct nla_policy coalesce_set_profile_policy[] = {
   325		[ETHTOOL_A_MODERATION_USEC]	= {.type = NLA_U32},
   326		[ETHTOOL_A_MODERATION_PKTS]	= {.type = NLA_U32},
   327		[ETHTOOL_A_MODERATION_COMPS]	= {.type = NLA_U32},
   328	};
   329	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
