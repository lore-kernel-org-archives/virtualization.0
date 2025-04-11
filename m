Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E9E22126B;
	Fri, 11 Apr 2025 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744414873; cv=none; b=bqyv8HMExViLsmSU7zKLbFemlKZ1c+/RZs/aPsKG2GUZ88BQdSIs3LrP6eRWEGRyqMTx9OYhmGrZijrpW51gA+VTHkgbchFW7zPaa7bZfSQIRlcA/6dgg7izU+4WETYfaCv2PDkWuUML5o4leA3bdLQ4Ql0w1/Ns4mFVGFOlXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744414873; c=relaxed/simple;
	bh=DWUjtR2ftgxqvFrIhCE165hC8BZaXWmvSsovH5UcaMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9DKQsUBanCCTOoysbgr9V4bLmfYFgO6jAehHmxOrRgMto9VxOl5NyHf7yt8HZJXFlUJXMdeFhJb820GTi7/0pu9Wv16fV32HAuZM8gTp3eYA2FX9HIGZ9OLjUuEDa66KeWabXG+LgO9uoztt54DvKfA5AAFkEnrIjUqjMKCd4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoeRzMbY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoeRzMbY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744414871; x=1775950871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DWUjtR2ftgxqvFrIhCE165hC8BZaXWmvSsovH5UcaMs=;
  b=eoeRzMbY2GdP4vZCy3AYdn9SMfOEZBBEwkCFIGuToS0TUq6nZrD41EcY
   bttVDdt0HL6leOxnUQsAceHZrAlaRQ+3ib8a1T7Zr0rxtRVI99d1WSxPR
   uwwEhpUJejt2j0zMsFHw2N/7Q1uhvIumFc+tzNheBiY5lDqRkwFMdAGIu
   Fy1p9BRSSQvEKuhCL/qkRQrIBfU+UiC24cwKypOIL0ZUvWLrVk/3CsZ7o
   BBxnSCIqMJCgepbDjQmeVxyMqe2qYBmQmkkB78x+mA6EFHd8CAbgVZ7sR
   iXtvkbS6sZjXd7Pm13uSGGbyH7lIVfX6jnqJGOq0cRHMKDKZWVchFa4mo
   w==;
X-CSE-ConnectionGUID: WVTwXi/gRgSA/XfSKE7OVA==
X-CSE-MsgGUID: /EAn5Q+kS2eKuQCQNfaFzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45214916"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45214916"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 16:41:10 -0700
X-CSE-ConnectionGUID: 0qt2RC1dQ6qs2p+GCM63Mg==
X-CSE-MsgGUID: SBo1nEdNTBSc5C0oAKKNdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129876944"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 11 Apr 2025 16:41:07 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3Nzc-000BRS-1A;
	Fri, 11 Apr 2025 23:41:04 +0000
Date: Sat, 12 Apr 2025 07:40:10 +0800
From: kernel test robot <lkp@intel.com>
To: Shyam Saini <shyamsaini@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, jgg@ziepe.ca, will@kernel.org,
	jacob.pan@linux.microsoft.com, eric.auger@redhat.com,
	code@tyhicks.com, eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 3/3] arm-smmu: select suitable MSI IOVA
Message-ID: <202504120727.1ZmvnvO2-lkp@intel.com>
References: <20250410225030.2528385-4-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410225030.2528385-4-shyamsaini@linux.microsoft.com>

Hi Shyam,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.15-rc1 next-20250411]
[cannot apply to soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shyam-Saini/arm-smmu-move-MSI_IOVA-macro-definitions/20250411-070014
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250410225030.2528385-4-shyamsaini%40linux.microsoft.com
patch subject: [PATCH v2 3/3] arm-smmu: select suitable MSI IOVA
config: arm-randconfig-002-20250412 (https://download.01.org/0day-ci/archive/20250412/202504120727.1ZmvnvO2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250412/202504120727.1ZmvnvO2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504120727.1ZmvnvO2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/fork.c:103:0:
   include/linux/iommu.h: In function 'select_msi_iova_base':
>> include/linux/iommu.h:1573:1: warning: no return statement in function returning non-void [-Wreturn-type]
    }
    ^


vim +1573 include/linux/iommu.h

  1570	
  1571	static inline u32 select_msi_iova_base(u32 erratic_iova_addr)
  1572	{
> 1573	}
  1574	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
