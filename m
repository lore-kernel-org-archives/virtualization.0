Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E42E822;
	Fri,  7 Mar 2025 03:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316924; cv=none; b=XUh2YRQW7Liexa04XLpcOC89JXUaH0Z+Arq9BSHzHBFWURBZVBIZOTmdT5tbIaZ2HxBpS0WlOSos365/F7kpLYwCt53bMLA1OOJuCIXft4jui7SkEnXnivZehxfjsNXfa3aKtDVpnhBUO0Loq1hEIWpIcf511TKQJdZLglMxMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316924; c=relaxed/simple;
	bh=DcLJ9aKimVNyrW/43nsjmeGTwBj8U+eyVkMor5z0OH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlzJNjFkIrK8bBBgSQh6krkALjWhwNrby3czd3XWAaqJthstuiMAOXu+YY/VkVQvU7v4dg/+0JQxTeoMnNCAEoTxPQYX7lo7TsdMse4P9QPwgfeDC1FarVHDLt+1800mZVDSEF1P1h9AuJSICR2M/e6LJEjzb0eKx+77rqgIJRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmYVNQH1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmYVNQH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741316920; x=1772852920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DcLJ9aKimVNyrW/43nsjmeGTwBj8U+eyVkMor5z0OH0=;
  b=BmYVNQH16msb0sJQ9GcjMHOLg4n+SuJln+cjl6Ke/kh2mO9bb7duYuwM
   r5oNeYB25w8pwb7YbClYDSd5eY9BZrELjd8h3Yca/RY2JDgMDHMkwHJaQ
   b4G3ql67IYQfIRsFyb0tEl+ItKuBaBcVkHoKemBeaiQ9BFxGCxbQhb/wb
   5UTsmhT8ednU81eS40qfqxiBhwqh1GvpXIZJAG/BfpqFeT2te2vRGyxjm
   E/522LTTBSgjHkTZX4nuvt4KGvWllyj2AcskmAoMQIC0DxDK65l4NUwgq
   H9OOTvkjVI6u896BhHXoz78mJmmjKYyNizSA+rnWLcQxCOg8jMyFg3Icb
   A==;
X-CSE-ConnectionGUID: P7CMQSibSoChL0lofLTLAw==
X-CSE-MsgGUID: sMz398i+Tmq3GWh7HcmEog==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="52996206"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="52996206"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 19:08:39 -0800
X-CSE-ConnectionGUID: NYB16Ma0QrSPRJ6pD9Bw5g==
X-CSE-MsgGUID: UPRbNo95TJeuYJ1WV0owAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119130707"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 06 Mar 2025 19:08:35 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqO4d-000O7i-2r;
	Fri, 07 Mar 2025 03:08:31 +0000
Date: Fri, 7 Mar 2025 11:07:31 +0800
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
Message-ID: <202503071022.q1pg7suf-lkp@intel.com>
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
config: i386-buildonly-randconfig-003-20250306 (https://download.01.org/0day-ci/archive/20250307/202503071022.q1pg7suf-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503071022.q1pg7suf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503071022.q1pg7suf-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-mgr-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-bridge-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-region-test.o
ERROR: modpost: "drm_gem_atomic_get_pages" [drivers/gpu/drm/drm_shmem_helper.ko] undefined!
ERROR: modpost: "atomic_vmap" [drivers/gpu/drm/drm_shmem_helper.ko] undefined!
>> ERROR: modpost: "drm_gem_shmem_atomic_vmap" [drivers/gpu/drm/virtio/virtio-gpu.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
