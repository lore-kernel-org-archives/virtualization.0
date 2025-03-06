Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E29F243379;
	Thu,  6 Mar 2025 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741305496; cv=none; b=aZg/IeBc5wHbsFcQNcxU+yiRDJcvfgeoRpifaTk2Izk8exyX6NrtoFjGYvkcq1CYonFu0nfmHXK6OsqNA9zSsoxIL0+3kooiYb1cWY8hUM61/kPJBw6XoEtAjFVmdFjLM5AHc6gjxvN8RuVUTOZFE/R0DulBfMsZaPZ324wfGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741305496; c=relaxed/simple;
	bh=Ysfi3IJpWU0q4KuMX92m4SfIaDX+nhzcOw9b5BXdpgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKeiDq1fqEfyVuaafOuh3FckpVtO//6PRHoVVnYv88qfFhnuBgyiBS3xh1JdRF6qa75R2wLkC/+Gvk+9qumb9u3xSMPz2Mi3gdzaWcjujVXq/cW6dwX3/vz36f1sb9c4Y8JSDRLq86pvgup2Qu+lqgowq7hchV4wEB3rqnsB0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PP0Y9EzO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PP0Y9EzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741305495; x=1772841495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ysfi3IJpWU0q4KuMX92m4SfIaDX+nhzcOw9b5BXdpgM=;
  b=PP0Y9EzOvYKPLTeblmqg/7YZr/GUHTw8+ZVvJQT2b2wJDnqtSq2XuMPQ
   b7D8BmRrb4YaZhwsLdGYHYJTiOS0QkWg19k7i58a82sxyhcZ2tsf+PaEn
   hktBEy0PKD94hZSdRYblCFvbP8PlPvUZf0ZmcWr2Ezt7bSMZhaOGoWav8
   SrTN8vP8pYwLPVqIlko/dByCJJHHA4I2TCCnbgHckE5JHeud8jFIfgbXB
   KuCH7yrlOkV4ItOamO3S1NtbRhvc1Bdmr+OPdkyvoVrlsp3zq8milQlxT
   ELFkkHxbxherh4RFxDFqsYStRsAxnUvWofuLtZMGMIkg3AVtk7GvSw0sh
   A==;
X-CSE-ConnectionGUID: rSWrR/f0RfqoT2sBcNNaNw==
X-CSE-MsgGUID: NauFf8XOTl2SSzZDgmc1Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42051275"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42051275"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 15:58:14 -0800
X-CSE-ConnectionGUID: iOrXB3uPQIS9LIc4TsgJ+Q==
X-CSE-MsgGUID: +4LUmdnKRg2IMCJ5r/qOkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="149965485"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Mar 2025 15:58:10 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqL6A-000NmU-29;
	Thu, 06 Mar 2025 23:58:04 +0000
Date: Fri, 7 Mar 2025 07:56:54 +0800
From: kernel test robot <lkp@intel.com>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	dmitry.osipenko@collabora.com, jfalempe@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ryosuke Yasuoka <ryasuoka@redhat.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH drm-next 2/2] drm/virtio: Use atomic_vmap to work
 drm_panic in GUI
Message-ID: <202503070700.ePiUr1E6-lkp@intel.com>
References: <20250305152555.318159-3-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305152555.318159-3-ryasuoka@redhat.com>

Hi Ryosuke,

kernel test robot noticed the following build errors:

[auto build test ERROR on e21cba704714c301d04c5fd37a693734b623872a]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryosuke-Yasuoka/vmalloc-Add-atomic_vmap/20250305-232918
base:   e21cba704714c301d04c5fd37a693734b623872a
patch link:    https://lore.kernel.org/r/20250305152555.318159-3-ryasuoka%40redhat.com
patch subject: [PATCH drm-next 2/2] drm/virtio: Use atomic_vmap to work drm_panic in GUI
config: i386-buildonly-randconfig-001-20250306 (https://download.01.org/0day-ci/archive/20250307/202503070700.ePiUr1E6-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503070700.ePiUr1E6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503070700.ePiUr1E6-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-mgr-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-bridge-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-region-test.o
>> ERROR: modpost: "drm_gem_atomic_get_pages" [drivers/gpu/drm/drm_shmem_helper.ko] undefined!
>> ERROR: modpost: "atomic_vmap" [drivers/gpu/drm/drm_shmem_helper.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
