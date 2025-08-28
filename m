Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF25CA6B;
	Thu, 28 Aug 2025 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340145; cv=none; b=OZhIkpLHBvxTLZtVqUUxEFAWfwW21nuaipP2lxWRCjKt4WanLAgnTIswMd7Lths4yzfUGJHMWNdcItFinmSQg2c6nv8cfe3/2sg8kjV3aFuPRTI5MDrX+cyjSHFsI6ECu5q/nmVxa1nObnQGgZuqKkUaFgV2b76AmdIT/MJCRyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340145; c=relaxed/simple;
	bh=X15jxw1bjDxbXh3rtpDUG6dcAg8RmRvouUgXO1Lx1nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu9+/KQHOA9wWUbjF8kLgo78fxKEKbdL/4qZktQtscu/BVTmmVs+tl/0y0SBoVxZDQn5yArd0kQj/OAnci7malbR1c1DU5juU+1gm2iRfOJpYZSPwhIp/aM9J9hFgb2QFazGa++oOvFEempgA8z1Pg8le+3fgAFc6NK8uuQpB2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1oa3+Yn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1oa3+Yn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756340143; x=1787876143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X15jxw1bjDxbXh3rtpDUG6dcAg8RmRvouUgXO1Lx1nc=;
  b=e1oa3+YnrBWDzACNc+yrJZBsXZRhTRQl/DJkUVJMfTlRYrCU7Se8aRnc
   wi3udj/+IW5H1TMJkbuMiLtGV19NASgPu5HnWi6mWtsvlan6LhahnHmtg
   aTzKriHtdrdc/5+1IdvfkhqBiJuMGgccdLraRJNp/g4L/eTGTd3cFoX3D
   90m9VhogftZ578kjRHGwIqth5TPguWYmFUhdLmXRqZSXq0w+lgEZ6XSb/
   zQNoRHQAEaJMWBjIIsd2VnzvN7Tyql63HG15g7IEP50CB+bz2HLaLMvO8
   /ewQgHSa73WthDmmzVGxUO7QiUBKs5gHUDXVKXCVVnhprKQzgMqDe0q9F
   A==;
X-CSE-ConnectionGUID: E4ZjRiaQRru3FGZKnK85Kw==
X-CSE-MsgGUID: M8fI6bmVRC6PTP+Oc2wntg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58666239"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58666239"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 17:15:42 -0700
X-CSE-ConnectionGUID: iXetU8geRCSmxvhjry4N3g==
X-CSE-MsgGUID: muBJXXgoTNaRGb7JiqWu9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170360066"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2025 17:15:39 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urQIi-000TIN-2k;
	Thu, 28 Aug 2025 00:15:36 +0000
Date: Thu, 28 Aug 2025 08:15:14 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
	virtualization@lists.linux.dev, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
	yohadt@nvidia.com, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net-next 04/11] virtio_net: Query and set flow filter caps
Message-ID: <202508280749.JlXoz9Mz-lkp@intel.com>
References: <20250827183852.2471-5-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827183852.2471-5-danielj@nvidia.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Jurgens/virtio-pci-Expose-generic-device-capability-operations/20250828-024128
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250827183852.2471-5-danielj%40nvidia.com
patch subject: [PATCH net-next 04/11] virtio_net: Query and set flow filter caps
config: i386-buildonly-randconfig-002-20250828 (https://download.01.org/0day-ci/archive/20250828/202508280749.JlXoz9Mz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250828/202508280749.JlXoz9Mz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508280749.JlXoz9Mz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: include/uapi/linux/virtio_net_ff.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
   make[3]: *** [scripts/Makefile.headersinst:63: usr/include/linux/virtio_net_ff.h] Error 1 shuffle=2238678394
   make[3]: Target '__headers' not remade because of errors.
   make[2]: *** [Makefile:1380: headers] Error 2 shuffle=2238678394
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=2238678394
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=2238678394
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
