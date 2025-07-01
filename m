Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CEF1C84C5;
	Tue,  1 Jul 2025 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405186; cv=none; b=Cu2RpPcOZQgICsvDZQLdZ6xiNtcqyUrf5F7W3ECasfM343fdVq+4x5Xh6RVlbJRTklFRDyNGcjoYeAlPXfl9aY/ckv0m+FLCaSHzUkVdDqcXI+fIbG4z/HO6dQ0ZVOm+u4zWMkDyGmazx986A8tYHHJhkKVZxU6E9cozdZfgo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405186; c=relaxed/simple;
	bh=R8n6arEGcVswxLhU83lkKsbJgDWgzGUs6I6rRw/rX1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xa5Tq7TRbbhellPimYdd/MEGasrGJ8K0zv1PGJAn/pgURo6qFniDYsXpsILkyUH0rf4Ze/c9uYW+fwoDuzN5ksG/HQHJBnydqBFQMdtbm3IyLWdLncrAl8rBb9vDRGSiW2qnAoG/93mkFUpiD3AmQ0f74aPelgNoLUJb/fgX6b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCqWnndB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCqWnndB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751405185; x=1782941185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=R8n6arEGcVswxLhU83lkKsbJgDWgzGUs6I6rRw/rX1c=;
  b=eCqWnndBCxk5fw9dghWBt8CbY4x+Mls8sZO5QtfGtIqYSBn20yrSz5NK
   L1J/IGU3pX5xxC621ffReXlfzUocIginTi7GF7vOMsSIpyvtHITaoAY4o
   44FjGVWqBAUiOx11s8b/2FZSFHoKL0EMQuF+IQJ/RJQNaNmdY2T8O8WSQ
   eesbrZ0poXHz06jkwD0PBugNiM3c/cFL75iN74Dsn0iL7XxaUdWQPHQqn
   PThFu8acQ+v7T5UuOqxyN4Fth6qP2n0KTFhCGJyMTDfvO25+mu9JcM++f
   MzFLhPWF1XXysF/75SeyPZBGfudAsf1m9agqQgks8toBFJyedVUNI224M
   Q==;
X-CSE-ConnectionGUID: RYK8z/KeRXmnAx0HKnBYLw==
X-CSE-MsgGUID: qT9v7+UGSwuRib5Kpi88Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="57365413"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="57365413"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 14:26:24 -0700
X-CSE-ConnectionGUID: p8Re8qrHSWKaLTO/ZB8WAQ==
X-CSE-MsgGUID: U3wKPwmWSaeo1juvCZWoCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153982061"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 01 Jul 2025 14:26:21 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWiUd-000afq-0u;
	Tue, 01 Jul 2025 21:26:19 +0000
Date: Wed, 2 Jul 2025 05:25:35 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	xieyongji@bytedance.com
Subject: Re: [PATCH 7/9] vdpa: rename dma_dev to map_token
Message-ID: <202507020521.PEt0EuaY-lkp@intel.com>
References: <20250701011401.74851-8-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701011401.74851-8-jasowang@redhat.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on mst-vhost/linux-next]
[also build test ERROR on linus/master v6.16-rc4 next-20250701]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Wang/virtio_ring-constify-virtqueue-pointer-for-DMA-helpers/20250701-091746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20250701011401.74851-8-jasowang%40redhat.com
patch subject: [PATCH 7/9] vdpa: rename dma_dev to map_token
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250702/202507020521.PEt0EuaY-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250702/202507020521.PEt0EuaY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507020521.PEt0EuaY-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/vdpa/mlx5/net/mlx5_vnet.c: In function 'mlx5_get_vq_dma_dev':
   drivers/vdpa/mlx5/net/mlx5_vnet.c:3405:28: error: 'struct vdpa_device' has no member named 'dma_dev'; did you mean 'mdev'?
    3405 |         return mvdev->vdev.dma_dev;
         |                            ^~~~~~~
         |                            mdev
   drivers/vdpa/mlx5/net/mlx5_vnet.c: At top level:
   drivers/vdpa/mlx5/net/mlx5_vnet.c:3687:10: error: 'const struct vdpa_config_ops' has no member named 'get_vq_dma_dev'; did you mean 'get_vq_ready'?
    3687 |         .get_vq_dma_dev = mlx5_get_vq_dma_dev,
         |          ^~~~~~~~~~~~~~
         |          get_vq_ready
>> drivers/vdpa/mlx5/net/mlx5_vnet.c:3687:27: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
    3687 |         .get_vq_dma_dev = mlx5_get_vq_dma_dev,
         |                           ^~~~~~~~~~~~~~~~~~~
   drivers/vdpa/mlx5/net/mlx5_vnet.c:3687:27: note: (near initialization for 'mlx5_vdpa_ops')
   drivers/vdpa/mlx5/net/mlx5_vnet.c:3687:27: error: initialization of 'void (*)(struct vdpa_device *)' from incompatible pointer type 'struct device * (*)(struct vdpa_device *, u16)' {aka 'struct device * (*)(struct vdpa_device *, short unsigned int)'} [-Werror=incompatible-pointer-types]
   drivers/vdpa/mlx5/net/mlx5_vnet.c:3687:27: note: (near initialization for 'mlx5_vdpa_ops.unbind_mm')
   drivers/vdpa/mlx5/net/mlx5_vnet.c: In function 'mlx5_vdpa_dev_add':
   drivers/vdpa/mlx5/net/mlx5_vnet.c:3966:21: error: 'struct vdpa_device' has no member named 'dma_dev'; did you mean 'mdev'?
    3966 |         mvdev->vdev.dma_dev = &mdev->pdev->dev;
         |                     ^~~~~~~
         |                     mdev
   drivers/vdpa/mlx5/net/mlx5_vnet.c: In function 'mlx5_get_vq_dma_dev':
>> drivers/vdpa/mlx5/net/mlx5_vnet.c:3406:1: warning: control reaches end of non-void function [-Wreturn-type]
    3406 | }
         | ^
   cc1: some warnings being treated as errors


vim +3687 drivers/vdpa/mlx5/net/mlx5_vnet.c

8fcd20c307042b Eli Cohen          2022-07-14  3652  
1a86b377aa2147 Eli Cohen          2020-08-04  3653  static const struct vdpa_config_ops mlx5_vdpa_ops = {
1a86b377aa2147 Eli Cohen          2020-08-04  3654  	.set_vq_address = mlx5_vdpa_set_vq_address,
1a86b377aa2147 Eli Cohen          2020-08-04  3655  	.set_vq_num = mlx5_vdpa_set_vq_num,
1a86b377aa2147 Eli Cohen          2020-08-04  3656  	.kick_vq = mlx5_vdpa_kick_vq,
1a86b377aa2147 Eli Cohen          2020-08-04  3657  	.set_vq_cb = mlx5_vdpa_set_vq_cb,
1a86b377aa2147 Eli Cohen          2020-08-04  3658  	.set_vq_ready = mlx5_vdpa_set_vq_ready,
1a86b377aa2147 Eli Cohen          2020-08-04  3659  	.get_vq_ready = mlx5_vdpa_get_vq_ready,
1a86b377aa2147 Eli Cohen          2020-08-04  3660  	.set_vq_state = mlx5_vdpa_set_vq_state,
1a86b377aa2147 Eli Cohen          2020-08-04  3661  	.get_vq_state = mlx5_vdpa_get_vq_state,
1892a3d425bf52 Eli Cohen          2022-05-18  3662  	.get_vendor_vq_stats = mlx5_vdpa_get_vendor_vq_stats,
1a86b377aa2147 Eli Cohen          2020-08-04  3663  	.get_vq_notification = mlx5_get_vq_notification,
1a86b377aa2147 Eli Cohen          2020-08-04  3664  	.get_vq_irq = mlx5_get_vq_irq,
1a86b377aa2147 Eli Cohen          2020-08-04  3665  	.get_vq_align = mlx5_vdpa_get_vq_align,
d4821902e43453 Gautam Dawar       2022-03-30  3666  	.get_vq_group = mlx5_vdpa_get_vq_group,
03dd63c8fae459 Dragos Tatulea     2023-10-18  3667  	.get_vq_desc_group = mlx5_vdpa_get_vq_desc_group, /* Op disabled if not supported. */
a64917bc2e9b1e Eli Cohen          2022-01-05  3668  	.get_device_features = mlx5_vdpa_get_device_features,
c695964474f3a8 Eugenio Pérez      2023-07-03  3669  	.get_backend_features = mlx5_vdpa_get_backend_features,
a64917bc2e9b1e Eli Cohen          2022-01-05  3670  	.set_driver_features = mlx5_vdpa_set_driver_features,
a64917bc2e9b1e Eli Cohen          2022-01-05  3671  	.get_driver_features = mlx5_vdpa_get_driver_features,
1a86b377aa2147 Eli Cohen          2020-08-04  3672  	.set_config_cb = mlx5_vdpa_set_config_cb,
1a86b377aa2147 Eli Cohen          2020-08-04  3673  	.get_vq_num_max = mlx5_vdpa_get_vq_num_max,
1a86b377aa2147 Eli Cohen          2020-08-04  3674  	.get_device_id = mlx5_vdpa_get_device_id,
1a86b377aa2147 Eli Cohen          2020-08-04  3675  	.get_vendor_id = mlx5_vdpa_get_vendor_id,
1a86b377aa2147 Eli Cohen          2020-08-04  3676  	.get_status = mlx5_vdpa_get_status,
1a86b377aa2147 Eli Cohen          2020-08-04  3677  	.set_status = mlx5_vdpa_set_status,
0686082dbf7a20 Xie Yongji         2021-08-31  3678  	.reset = mlx5_vdpa_reset,
2eacf4b5e3ebe7 Si-Wei Liu         2023-10-21  3679  	.compat_reset = mlx5_vdpa_compat_reset,
442706f9f94d28 Stefano Garzarella 2021-03-15  3680  	.get_config_size = mlx5_vdpa_get_config_size,
1a86b377aa2147 Eli Cohen          2020-08-04  3681  	.get_config = mlx5_vdpa_get_config,
1a86b377aa2147 Eli Cohen          2020-08-04  3682  	.set_config = mlx5_vdpa_set_config,
1a86b377aa2147 Eli Cohen          2020-08-04  3683  	.get_generation = mlx5_vdpa_get_generation,
1a86b377aa2147 Eli Cohen          2020-08-04  3684  	.set_map = mlx5_vdpa_set_map,
2eacf4b5e3ebe7 Si-Wei Liu         2023-10-21  3685  	.reset_map = mlx5_vdpa_reset_map,
8fcd20c307042b Eli Cohen          2022-07-14  3686  	.set_group_asid = mlx5_set_group_asid,
36871fb92b7059 Jason Wang         2023-01-19 @3687  	.get_vq_dma_dev = mlx5_get_vq_dma_dev,
1a86b377aa2147 Eli Cohen          2020-08-04  3688  	.free = mlx5_vdpa_free,
cae15c2ed8e6e0 Eli Cohen          2022-07-14  3689  	.suspend = mlx5_vdpa_suspend,
145096937b8a6a Dragos Tatulea     2023-12-25  3690  	.resume = mlx5_vdpa_resume, /* Op disabled if not supported. */
1a86b377aa2147 Eli Cohen          2020-08-04  3691  };
1a86b377aa2147 Eli Cohen          2020-08-04  3692  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
