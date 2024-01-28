Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE26DF60;
	Sun, 28 Jan 2024 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706434768; cv=none; b=l3VOvNNPHXIa3skNPWu2beLgWxWR/UvGYAziVXZM5nBwj4/+/eSX8B7SukCfnYtrFP5BsTySQuFf4veeHGF0XOjemaTzmMyEBH77TMMK/u9lXx9qr3jkFFB4CzQg3VOWKLL7/ewGRN6UwY+FJtFyvggeQMFodQF7KqcoZHi/ZhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706434768; c=relaxed/simple;
	bh=fdCtoglZXG7iKsGa+puUFV3eAFQc046my63SuMWnsd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+qY/GteZ0WM1p1N/slnbtsQq9YzHNPkLVMy/WF6I2RV2u1JCRZsXKH0tJ/pmjK2xqxS3HIukYHHOUTnpRehOhXOqZ7imOkq08iu6KK9e+Xlb/36G1vHZbV82HQmsKT6RhDV9qLaYareGjyU9slzfndxViKM5c9zGovnY5Y88Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7PFbpsO; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7PFbpsO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706434767; x=1737970767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fdCtoglZXG7iKsGa+puUFV3eAFQc046my63SuMWnsd4=;
  b=h7PFbpsOUZLPx0R3ogO7ZFFU8rwDkKINQmNrFm7OiQ8rw1IXm7DNWAGa
   pGIwVSVR2HhmBen31i/8z0+x6Bx4oDx5p0qEPYtYu2kOp+cfj8DEJpXdo
   35CCshNVUcgQwK5Nb8Ui+0vZKwhGnVuzY2vnPD89fzLsAxKAenAhJSZ3y
   P48L0/VkAaZ2z52XQEy4q/lKn0KwrNdsAjUW8p67U64K8M53tTrI2cMaZ
   Xvz0kGyo0ejz0amSEo1WceSr9B1Hffk1zPu17c2cn7cB/V3Yj22ubRobG
   o7Z9H9iMKiRk5FaMkluaekaxm1NIm+V3l3rTWXjBIxnxm9LxxaiASCCH4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="433919596"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="433919596"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 01:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="910763413"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="910763413"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Jan 2024 01:39:22 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU1dI-0003Hq-1o;
	Sun, 28 Jan 2024 09:39:20 +0000
Date: Sun, 28 Jan 2024 17:39:06 +0800
From: kernel test robot <lkp@intel.com>
To: Yunjian Wang <wangyunjian@huawei.com>, mst@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	kuba@kernel.org, davem@davemloft.net, magnus.karlsson@intel.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, xudingke@huawei.com,
	Yunjian Wang <wangyunjian@huawei.com>
Subject: Re: [PATCH net-next 2/2] tun: AF_XDP Rx zero-copy support
Message-ID: <202401281735.bX1dign9-lkp@intel.com>
References: <1706089075-16084-1-git-send-email-wangyunjian@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706089075-16084-1-git-send-email-wangyunjian@huawei.com>

Hi Yunjian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunjian-Wang/xsk-Remove-non-zero-dma_page-check-in-xp_assign_dev/20240124-174011
base:   net-next/main
patch link:    https://lore.kernel.org/r/1706089075-16084-1-git-send-email-wangyunjian%40huawei.com
patch subject: [PATCH net-next 2/2] tun: AF_XDP Rx zero-copy support
config: i386-randconfig-062-20240127 (https://download.01.org/0day-ci/archive/20240128/202401281735.bX1dign9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401281735.bX1dign9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281735.bX1dign9-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/tun.c:1298:5: sparse: sparse: symbol 'tun_xsk_pool_setup' was not declared. Should it be static?
   drivers/net/tun.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +/tun_xsk_pool_setup +1298 drivers/net/tun.c

  1297	
> 1298	int tun_xsk_pool_setup(struct net_device *dev, struct xsk_buff_pool *pool,
  1299			       u16 qid)
  1300	{
  1301		return pool ? tun_xsk_pool_enable(dev, pool, qid) :
  1302			tun_xsk_pool_disable(dev, qid);
  1303	}
  1304	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
