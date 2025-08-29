Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3089D10F1;
	Fri, 29 Aug 2025 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427350; cv=none; b=NlRwHjm0z/p+CaPYPejZROxjn9oxdciab6Fpi3KUMGaGoKnQu+F2hAP7y0kfK8MqRB2CZLDu0cPwAoUL2fPWJ490wBugBqcpYVimg0Rs1N9vZp52bT163kk6PjB6n5FzAEEv2h/s5Y0v6vZL8zZs3ch0AwR7mqwJNWl6LJLVWHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427350; c=relaxed/simple;
	bh=YUwK84tw5EkVarhoBPCjE4csTzyi8Zj7MlqXZvjMQa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ir25j3pFfRVW4TcA9VbU8tD2Tu0JFJUHX0bygz8D2ZUMxyxwvMkeV5nsS78Igz02bQr027RVwZWxMO+Bd6PkNUYwFAYiS3u/tebU1fgT/6fmogoNyW7lhLcMEOCkUUT4GyB314bckWW/yIp6BPptwGVsQka8nXNAaQU6jMkOXxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZT5Vz1P; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZT5Vz1P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756427347; x=1787963347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YUwK84tw5EkVarhoBPCjE4csTzyi8Zj7MlqXZvjMQa0=;
  b=eZT5Vz1PpjIsGpdJgJxnIqovsvORWbLHjQw/cAPY5gczphVxPfi1j9if
   wWa5brIfGm4UgAdOqUObrVYfufVhoI9cCNaSS30jhjoWDF+uzvUJXhDtk
   evVz5n9re46PiTVxdLFfse/G1mLmYbtbgexW6V/APKDAU03F3iBcK7h3x
   8vB5Nw57A1C+6u3OV+t75gJXx6pDL3DsJUfLwurAanC3kQzxbUkEGfrWM
   A/XF2XwVro3EZ+0FEg5fCnvspEaTSN9ky1meDWVr4IVWQ60pk+bwhiWGu
   Lb7nd0cckCmUyX2FDXOQ6+VrZ3yEDvRHp/daToYWMtox7E53TSAq27F12
   A==;
X-CSE-ConnectionGUID: Or83vWlPSVmflKBFUbvumQ==
X-CSE-MsgGUID: g79f96hHRVioZc2Hl4e0fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69421877"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69421877"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 17:29:06 -0700
X-CSE-ConnectionGUID: WM9HIX/hQqStPpBAiqTUBA==
X-CSE-MsgGUID: 4smKbMRsRmq6HRiQlaGhHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169545775"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 28 Aug 2025 17:29:03 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urmyj-000UBn-04;
	Fri, 29 Aug 2025 00:28:34 +0000
Date: Fri, 29 Aug 2025 08:27:42 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
	virtualization@lists.linux.dev, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
	yohadt@nvidia.com, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net-next 08/11] virtio_net: Implement IPv4 ethtool flow
 rules
Message-ID: <202508290723.Hs6BN2g9-lkp@intel.com>
References: <20250827183852.2471-9-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827183852.2471-9-danielj@nvidia.com>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Jurgens/virtio-pci-Expose-generic-device-capability-operations/20250828-024128
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250827183852.2471-9-danielj%40nvidia.com
patch subject: [PATCH net-next 08/11] virtio_net: Implement IPv4 ethtool flow rules
config: x86_64-randconfig-121-20250828 (https://download.01.org/0day-ci/archive/20250829/202508290723.Hs6BN2g9-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250829/202508290723.Hs6BN2g9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508290723.Hs6BN2g9-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/virtio_net/virtio_net_ff.c: note: in included file (through include/linux/virtio_admin.h):
   include/uapi/linux/virtio_net_ff.h:47:48: sparse: sparse: array of flexible structures
   include/uapi/linux/virtio_net_ff.h:67:48: sparse: sparse: array of flexible structures
   drivers/net/virtio_net/virtio_net_ff.c:180:24: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/virtio_net/virtio_net_ff.c:257:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] vq_index @@     got unsigned long long @@
   drivers/net/virtio_net/virtio_net_ff.c:257:27: sparse:     expected restricted __le16 [usertype] vq_index
   drivers/net/virtio_net/virtio_net_ff.c:257:27: sparse:     got unsigned long long
>> drivers/net/virtio_net/virtio_net_ff.c:361:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] h_proto @@     got int @@
   drivers/net/virtio_net/virtio_net_ff.c:361:32: sparse:     expected restricted __be16 [usertype] h_proto
   drivers/net/virtio_net/virtio_net_ff.c:361:32: sparse:     got int
   drivers/net/virtio_net/virtio_net_ff.c:506:24: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/virtio_net/virtio_net_ff.c:635:13: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/virtio_net/virtio_net_ff.c:635:13: sparse: sparse: cast to restricted __le32
   drivers/net/virtio_net/virtio_net_ff.c:639:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] groups_limit @@     got int @@
   drivers/net/virtio_net/virtio_net_ff.c:639:35: sparse:     expected restricted __le32 [usertype] groups_limit
   drivers/net/virtio_net/virtio_net_ff.c:639:35: sparse:     got int

vim +361 drivers/net/virtio_net/virtio_net_ff.c

   347	
   348	static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
   349					  u8 *key,
   350					  const struct ethtool_rx_flow_spec *fs,
   351					  int num_hdrs)
   352	{
   353		struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
   354		struct ethhdr *eth_k = (struct ethhdr *)key;
   355	
   356		selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
   357		selector->length = sizeof(struct ethhdr);
   358	
   359		if (num_hdrs > 1) {
   360			eth_m->h_proto = cpu_to_be16(0xffff);
 > 361			eth_k->h_proto = ETH_P_IP;
   362		} else {
   363			memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
   364			memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
   365		}
   366	}
   367	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
