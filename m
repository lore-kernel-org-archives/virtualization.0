Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3B1A0BE5;
	Wed, 23 Oct 2024 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729724247; cv=none; b=K9xmSzLf2KX/GNw/OR2FZPCZpHNDW1v8HCPHQTABoE2Nm55XL9AfwCGIUZkw3bcdT6ZocSRIRQDnkgOoqAeDhPOlbR/rpIx+qWu/950bZ0pI9vqo/4R5Vk6jC+wnC+hjOp7xcXf2Cvg0+HFsLM+S1GgN5Z+oIOkoWfYe4PbjLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729724247; c=relaxed/simple;
	bh=XQXk+It6cqZrXhHUXXAtXR0ZZZqStInBATuN5lci9Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcBso2TiOT+wvftPVZtWmujLiVgnkONYZCHlfwEX1zchM9tj/l8AUAaKzWitBxka5YMS/hsGJxx4Sd84LLT0w5w3pBIsC6KOjlTYqiydt7XF9iEPn/p16en1sgqNn4Yl2OAc5L3r3BJiGahdJratRgK9VcGtaXsoNkhQmbpYPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SV2UoLYT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SV2UoLYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729724245; x=1761260245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XQXk+It6cqZrXhHUXXAtXR0ZZZqStInBATuN5lci9Fs=;
  b=SV2UoLYTWP45Gm/P3oV7q1mNmh51gIVca0f82keuu+Mcfvh54BEpAd9Z
   YwDkT9bl1KoERO3d/O/WwY5ge1d9ga3z/FnQ8ZHu66jg9OSI5k9e+mE0r
   pTy9/mZ5h7bwy+ZALBty6k2wzz0/TEX4y49sL2igHGOtLWiHQR+UAqea/
   YKUDFX8CEkxjAvYwuvzr8w9wYgp8Gh/2+3tHx05/wQI1+NDkq/QLewOKj
   hQt16PNSPSARmHJJ8v/ZhFaCNySS8QabonHSCIl9+fZdvbyfGO5mketgx
   qvQYElr5MTcKupbCUB+RMiP/G+MRWwHqBmKsMrQsSctL/rHKrSl7glI9S
   A==;
X-CSE-ConnectionGUID: OLny8DbmRmy26mFNQnUqyQ==
X-CSE-MsgGUID: c5AREqjVSqmxtJL2ybwJ9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29199724"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29199724"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 15:57:25 -0700
X-CSE-ConnectionGUID: Qimsdc3sS5SqCvGC6dyF1g==
X-CSE-MsgGUID: 7VhNUX0WQKWYYkX82FPRsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="84970092"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 23 Oct 2024 15:57:21 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3kI3-000Vgm-2P;
	Wed, 23 Oct 2024 22:57:19 +0000
Date: Thu, 24 Oct 2024 06:57:13 +0800
From: kernel test robot <lkp@intel.com>
To: Yuanchu Xie <yuanchu@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, Wei Liu <liuwe@microsoft.com>,
	Rob Bradford <rbradford@rivosinc.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, dev@lists.cloudhypervisor.org,
	Yuanchu Xie <yuanchu@google.com>
Subject: Re: [PATCH v4 1/2] virt: pvmemcontrol: control guest physical memory
 properties
Message-ID: <202410240605.Hr0JFxmp-lkp@intel.com>
References: <20241021204849.1580384-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021204849.1580384-1-yuanchu@google.com>

Hi Yuanchu,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc4 next-20241023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuanchu-Xie/virt-pvmemcontrol-add-Yuanchu-and-Pasha-as-maintainers/20241022-045035
base:   linus/master
patch link:    https://lore.kernel.org/r/20241021204849.1580384-1-yuanchu%40google.com
patch subject: [PATCH v4 1/2] virt: pvmemcontrol: control guest physical memory properties
config: powerpc-randconfig-002-20241024 (https://download.01.org/0day-ci/archive/20241024/202410240605.Hr0JFxmp-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241024/202410240605.Hr0JFxmp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410240605.Hr0JFxmp-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/virt/pvmemcontrol/pvmemcontrol.c:455:1: warning: data definition has no type or storage class
     455 | module_pci_driver(pvmemcontrol_pci_driver);
         | ^~~~~~~~~~~~~~~~~
>> drivers/virt/pvmemcontrol/pvmemcontrol.c:455:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Wimplicit-int]
>> drivers/virt/pvmemcontrol/pvmemcontrol.c:455:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
>> drivers/virt/pvmemcontrol/pvmemcontrol.c:449:26: warning: 'pvmemcontrol_pci_driver' defined but not used [-Wunused-variable]
     449 | static struct pci_driver pvmemcontrol_pci_driver = {
         |                          ^~~~~~~~~~~~~~~~~~~~~~~


vim +455 drivers/virt/pvmemcontrol/pvmemcontrol.c

   448	
 > 449	static struct pci_driver pvmemcontrol_pci_driver = {
   450		.name = "pvmemcontrol",
   451		.id_table = pvmemcontrol_pci_id_tbl,
   452		.probe = pvmemcontrol_pci_probe,
   453		.remove = pvmemcontrol_pci_remove,
   454	};
 > 455	module_pci_driver(pvmemcontrol_pci_driver);
   456	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
