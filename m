Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237FB2D837C;
	Fri,  6 Feb 2026 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770360231; cv=none; b=OasbAYMfkVRAL+FcbxvBhr5qx7o7rFS2VbQq+Zoc7A6c5PaKGI+aLceA5GrjpdBv+MoJnKztuO4WC8kBU6J7IToNrqmFw50tiYhYJzegInCBC1jMEj+WYrlt1HXsQ/oGIT/2SluIXzAB8rqJMs0WsEY3QZfnwQ7s2/HJTnUa4UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770360231; c=relaxed/simple;
	bh=/JWP8MF5qF7SIJnI8qbIfcSi4SrL1bMOyFdN2GUdhK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fThNIQ5ZuwwavOASII7/mULApE+L833NI8EVPB18DqhUv+XdQTDDNGzWkWnp21M74ZTLA3sc/ZPeKUEKA7+jS8Dm3osxiSUqiExmlb91UcUsfn9jJk9FoX3S64KjK7XMDBT9+8L58FUcFPpv0B8958IPo9MIlwizc7bStQBxZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzIchnlM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzIchnlM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770360231; x=1801896231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/JWP8MF5qF7SIJnI8qbIfcSi4SrL1bMOyFdN2GUdhK4=;
  b=CzIchnlMoX7Ow4NwS3LnOttidSK7yZ7K+oXkiUW8/NiYRLtx31m01HAo
   ztgk/Tyq1dtJpJOBZPInss0TLZPok5hUrvS2GSE/nCjiaKmLxWvoP51qa
   mG9hbwvCCU5w4lEKqCqCLnmi2JxEN2UxQYiJ4YkeznKiR1c4rVpiNBGZb
   h536Zp9At9ysF4lxzwJDp2lPf1UNt427ukCvzJV2QBG+unJ4XjU/L5Bzw
   itR4iUBXbDD1X3BYUc9Fusu9pA+djUepGEvEifI1ZfWEo25KN9nJeWegd
   EvoKPhB6bzC6ksZKwBtXDUFF+TN/ilWOLEdZvQplH9OHanX+1C1nMnKcu
   g==;
X-CSE-ConnectionGUID: NrrFGVotRbS5w/Vys6m3TQ==
X-CSE-MsgGUID: hi1gAPYJR8Cz9qTOuSavhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82304804"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="82304804"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 22:43:50 -0800
X-CSE-ConnectionGUID: ipUoCHChTBKsww9tNlWH3w==
X-CSE-MsgGUID: V+H+I/KqTpmb/7VwfJNTiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="214951233"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Feb 2026 22:43:46 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voFZ9-00000000kUU-3CAV;
	Fri, 06 Feb 2026 06:43:43 +0000
Date: Fri, 6 Feb 2026 14:43:21 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
	Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net-next v20 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <202602061444.jFWR3roe-lkp@intel.com>
References: <20260205224707.16995-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205224707.16995-6-danielj@nvidia.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Jurgens/virtio_pci-Remove-supported_cap-size-build-assert/20260206-065356
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260205224707.16995-6-danielj%40nvidia.com
patch subject: [PATCH net-next v20 05/12] virtio_net: Query and set flow filter caps
config: arm64-randconfig-002-20260206 (https://download.01.org/0day-ci/archive/20260206/202602061444.jFWR3roe-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260206/202602061444.jFWR3roe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602061444.jFWR3roe-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/virtio_net_ff.h:9:10: fatal error: 'uapi/linux/stddef.h' file not found
       9 | #include <uapi/linux/stddef.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
