Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D5334CF5;
	Wed,  2 Jul 2025 05:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433687; cv=none; b=Pi83rTvPufjO249n6DuwhjY24dAINTu8GiBgmgfNeqv/iO0yNpzYvkC65OSKK2CcFHlFy9VWUqQpHwmgj7MXpI3oWmBAaGHH2dGgDwtcTVZ3rZkNLvnp8EaiNvhiwpgD//YBGlzKeenyU/x7gxgSWGmKy4aJuqt99I8f+vq0ifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433687; c=relaxed/simple;
	bh=feK/K2n7DIMj6aXmfAF0kmVID+1whHLPSMDKpZeWv0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oc0sIaWtYP38okLPPh0afKDe3qXP3ZYzvsxn+5foWm8hD5hgH0GwHe0wAf8JipWZAVQzt7tOM3PuBfGfSnLrObZb8AmQTuOKxQnGsM3uNQNPw8UqV6dvDUWf69Scxkze/hb8QB85JatSFOWv6UgXYaJ2835qHx2/nLyJhCSuBoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3yp9Emp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3yp9Emp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751433685; x=1782969685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=feK/K2n7DIMj6aXmfAF0kmVID+1whHLPSMDKpZeWv0Q=;
  b=C3yp9EmpRhezSUcAKmHnCjuka07WvBtMtgOWvgWPXnbLwshIbyOa+fGP
   lnZrer5uqYnSezp9wiaqrNwivxPOlc2jI5uOekuv6g5/dem1c5n55kXBk
   U6Erqhr5L4HXXf0YVdDPMyE2r6V41hzXPYUMiP4hYnjxbwnqZibGTIqWJ
   WpGjggZHCqsNYwojgh53tZEfXv5I7f0q42ffhnxsrNMzYZDsS8FmDXp9S
   3wb47rIsx9ZH9Uo6h+YH5Ux3uPKsdQEQnDZyW5ltsSVA3VUtupx3U7TcU
   NqgGCnhOm9YWu/OBni76iNyIwQt9kcHYDagHFGIpy3tM5mHB3fdpKKZLh
   A==;
X-CSE-ConnectionGUID: Mq5Npj9iTx2g43j2gaUWEQ==
X-CSE-MsgGUID: pqshj3d/SAGUe0JEHNFdzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="64763636"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="64763636"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 22:21:24 -0700
X-CSE-ConnectionGUID: H6qZhEfURiq7QU6M9EVqVQ==
X-CSE-MsgGUID: tzvrjbQBTg2chRmXmKRbCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="158349052"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 01 Jul 2025 22:21:21 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWpuI-0000D5-0N;
	Wed, 02 Jul 2025 05:21:18 +0000
Date: Wed, 2 Jul 2025 13:20:55 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org, xieyongji@bytedance.com
Subject: Re: [PATCH 8/9] vdpa: introduce map ops
Message-ID: <202507021212.rhQmuuvi-lkp@intel.com>
References: <20250701011401.74851-9-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701011401.74851-9-jasowang@redhat.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on mst-vhost/linux-next]
[also build test ERROR on linus/master v6.16-rc4 next-20250701]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Wang/virtio_ring-constify-virtqueue-pointer-for-DMA-helpers/20250701-091746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20250701011401.74851-9-jasowang%40redhat.com
patch subject: [PATCH 8/9] vdpa: introduce map ops
config: x86_64-randconfig-073-20250702 (https://download.01.org/0day-ci/archive/20250702/202507021212.rhQmuuvi-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250702/202507021212.rhQmuuvi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507021212.rhQmuuvi-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/vdpa/mlx5/net/mlx5_vnet.c:3405:21: error: no member named 'dma_dev' in 'struct vdpa_device'
    3405 |         return mvdev->vdev.dma_dev;
         |                ~~~~~~~~~~~ ^
   drivers/vdpa/mlx5/net/mlx5_vnet.c:3687:3: error: field designator 'get_vq_dma_dev' does not refer to any field in type 'const struct vdpa_config_ops'
    3687 |         .get_vq_dma_dev = mlx5_get_vq_dma_dev,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/vdpa/mlx5/net/mlx5_vnet.c:3880:59: error: too few arguments provided to function-like macro invocation
    3880 |                                  MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
         |                                                                                       ^
   include/linux/vdpa.h:471:9: note: macro 'vdpa_alloc_device' defined here
     471 | #define vdpa_alloc_device(dev_struct, member, parent, config, map, \
         |         ^
>> drivers/vdpa/mlx5/net/mlx5_vnet.c:3879:9: error: use of undeclared identifier 'vdpa_alloc_device'; did you mean '__vdpa_alloc_device'?
    3879 |         ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mgtdev->vdpa_ops,
         |                ^~~~~~~~~~~~~~~~~
         |                __vdpa_alloc_device
   include/linux/vdpa.h:449:21: note: '__vdpa_alloc_device' declared here
     449 | struct vdpa_device *__vdpa_alloc_device(struct device *parent,
         |                     ^
   drivers/vdpa/mlx5/net/mlx5_vnet.c:3966:14: error: no member named 'dma_dev' in 'struct vdpa_device'
    3966 |         mvdev->vdev.dma_dev = &mdev->pdev->dev;
         |         ~~~~~~~~~~~ ^
   5 errors generated.


vim +3879 drivers/vdpa/mlx5/net/mlx5_vnet.c

bc9a2b3e686e32 Eli Cohen           2023-06-07  3817  
d8ca2fa5be1bdb Parav Pandit        2021-10-26  3818  static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
d8ca2fa5be1bdb Parav Pandit        2021-10-26  3819  			     const struct vdpa_dev_set_config *add_config)
1a86b377aa2147 Eli Cohen           2020-08-04  3820  {
58926c8aab104d Eli Cohen           2021-04-08  3821  	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
1a86b377aa2147 Eli Cohen           2020-08-04  3822  	struct virtio_net_config *config;
7c9f131f366ab4 Eli Cohen           2021-04-22  3823  	struct mlx5_core_dev *pfmdev;
1a86b377aa2147 Eli Cohen           2020-08-04  3824  	struct mlx5_vdpa_dev *mvdev;
1a86b377aa2147 Eli Cohen           2020-08-04  3825  	struct mlx5_vdpa_net *ndev;
58926c8aab104d Eli Cohen           2021-04-08  3826  	struct mlx5_core_dev *mdev;
deeacf35c922da Si-Wei Liu          2023-02-06  3827  	u64 device_features;
1a86b377aa2147 Eli Cohen           2020-08-04  3828  	u32 max_vqs;
246fd1caf0f442 Eli Cohen           2021-09-09  3829  	u16 mtu;
1a86b377aa2147 Eli Cohen           2020-08-04  3830  	int err;
1a86b377aa2147 Eli Cohen           2020-08-04  3831  
58926c8aab104d Eli Cohen           2021-04-08  3832  	if (mgtdev->ndev)
58926c8aab104d Eli Cohen           2021-04-08  3833  		return -ENOSPC;
58926c8aab104d Eli Cohen           2021-04-08  3834  
58926c8aab104d Eli Cohen           2021-04-08  3835  	mdev = mgtdev->madev->mdev;
deeacf35c922da Si-Wei Liu          2023-02-06  3836  	device_features = mgtdev->mgtdev.supported_features;
deeacf35c922da Si-Wei Liu          2023-02-06  3837  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
deeacf35c922da Si-Wei Liu          2023-02-06  3838  		if (add_config->device_features & ~device_features) {
deeacf35c922da Si-Wei Liu          2023-02-06  3839  			dev_warn(mdev->device,
deeacf35c922da Si-Wei Liu          2023-02-06  3840  				 "The provisioned features 0x%llx are not supported by this device with features 0x%llx\n",
deeacf35c922da Si-Wei Liu          2023-02-06  3841  				 add_config->device_features, device_features);
deeacf35c922da Si-Wei Liu          2023-02-06  3842  			return -EINVAL;
deeacf35c922da Si-Wei Liu          2023-02-06  3843  		}
deeacf35c922da Si-Wei Liu          2023-02-06  3844  		device_features &= add_config->device_features;
791a1cb7b8591e Eli Cohen           2023-03-21  3845  	} else {
791a1cb7b8591e Eli Cohen           2023-03-21  3846  		device_features &= ~BIT_ULL(VIRTIO_NET_F_MRG_RXBUF);
deeacf35c922da Si-Wei Liu          2023-02-06  3847  	}
deeacf35c922da Si-Wei Liu          2023-02-06  3848  	if (!(device_features & BIT_ULL(VIRTIO_F_VERSION_1) &&
deeacf35c922da Si-Wei Liu          2023-02-06  3849  	      device_features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM))) {
deeacf35c922da Si-Wei Liu          2023-02-06  3850  		dev_warn(mdev->device,
deeacf35c922da Si-Wei Liu          2023-02-06  3851  			 "Must provision minimum features 0x%llx for this device",
deeacf35c922da Si-Wei Liu          2023-02-06  3852  			 BIT_ULL(VIRTIO_F_VERSION_1) | BIT_ULL(VIRTIO_F_ACCESS_PLATFORM));
deeacf35c922da Si-Wei Liu          2023-02-06  3853  		return -EOPNOTSUPP;
deeacf35c922da Si-Wei Liu          2023-02-06  3854  	}
deeacf35c922da Si-Wei Liu          2023-02-06  3855  
879753c816dbbd Eli Cohen           2021-08-11  3856  	if (!(MLX5_CAP_DEV_VDPA_EMULATION(mdev, virtio_queue_type) &
879753c816dbbd Eli Cohen           2021-08-11  3857  	    MLX5_VIRTIO_EMULATION_CAP_VIRTIO_QUEUE_TYPE_SPLIT)) {
879753c816dbbd Eli Cohen           2021-08-11  3858  		dev_warn(mdev->device, "missing support for split virtqueues\n");
879753c816dbbd Eli Cohen           2021-08-11  3859  		return -EOPNOTSUPP;
879753c816dbbd Eli Cohen           2021-08-11  3860  	}
879753c816dbbd Eli Cohen           2021-08-11  3861  
acde3929492bcb Eli Cohen           2022-05-16  3862  	max_vqs = min_t(int, MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues),
acde3929492bcb Eli Cohen           2022-05-16  3863  			1 << MLX5_CAP_GEN(mdev, log_max_rqt_size));
75560522eaef2f Eli Cohen           2022-01-05  3864  	if (max_vqs < 2) {
75560522eaef2f Eli Cohen           2022-01-05  3865  		dev_warn(mdev->device,
75560522eaef2f Eli Cohen           2022-01-05  3866  			 "%d virtqueues are supported. At least 2 are required\n",
75560522eaef2f Eli Cohen           2022-01-05  3867  			 max_vqs);
75560522eaef2f Eli Cohen           2022-01-05  3868  		return -EAGAIN;
75560522eaef2f Eli Cohen           2022-01-05  3869  	}
75560522eaef2f Eli Cohen           2022-01-05  3870  
75560522eaef2f Eli Cohen           2022-01-05  3871  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
75560522eaef2f Eli Cohen           2022-01-05  3872  		if (add_config->net.max_vq_pairs > max_vqs / 2)
75560522eaef2f Eli Cohen           2022-01-05  3873  			return -EINVAL;
75560522eaef2f Eli Cohen           2022-01-05  3874  		max_vqs = min_t(u32, max_vqs, 2 * add_config->net.max_vq_pairs);
75560522eaef2f Eli Cohen           2022-01-05  3875  	} else {
75560522eaef2f Eli Cohen           2022-01-05  3876  		max_vqs = 2;
75560522eaef2f Eli Cohen           2022-01-05  3877  	}
1a86b377aa2147 Eli Cohen           2020-08-04  3878  
03dd63c8fae459 Dragos Tatulea      2023-10-18 @3879  	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mgtdev->vdpa_ops,
8fcd20c307042b Eli Cohen           2022-07-14 @3880  				 MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
1a86b377aa2147 Eli Cohen           2020-08-04  3881  	if (IS_ERR(ndev))
74c9729dd892a1 Leon Romanovsky     2020-10-04  3882  		return PTR_ERR(ndev);
1a86b377aa2147 Eli Cohen           2020-08-04  3883  
1a86b377aa2147 Eli Cohen           2020-08-04  3884  	ndev->mvdev.max_vqs = max_vqs;
1a86b377aa2147 Eli Cohen           2020-08-04  3885  	mvdev = &ndev->mvdev;
1a86b377aa2147 Eli Cohen           2020-08-04  3886  	mvdev->mdev = mdev;
439252e167ac45 Konstantin Shkolnyy 2025-02-04  3887  	/* cpu_to_mlx5vdpa16() below depends on this flag */
439252e167ac45 Konstantin Shkolnyy 2025-02-04  3888  	mvdev->actual_features =
439252e167ac45 Konstantin Shkolnyy 2025-02-04  3889  			(device_features & BIT_ULL(VIRTIO_F_VERSION_1));
75560522eaef2f Eli Cohen           2022-01-05  3890  
75560522eaef2f Eli Cohen           2022-01-05  3891  	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
75560522eaef2f Eli Cohen           2022-01-05  3892  	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
75560522eaef2f Eli Cohen           2022-01-05  3893  	if (!ndev->vqs || !ndev->event_cbs) {
75560522eaef2f Eli Cohen           2022-01-05  3894  		err = -ENOMEM;
75560522eaef2f Eli Cohen           2022-01-05  3895  		goto err_alloc;
75560522eaef2f Eli Cohen           2022-01-05  3896  	}
1835ed4a5d49d2 Dragos Tatulea      2024-06-26  3897  	ndev->cur_num_vqs = MLX5V_DEFAULT_VQ_COUNT;
75560522eaef2f Eli Cohen           2022-01-05  3898  
4a19f2942a0fe5 Dragos Tatulea      2024-06-26  3899  	mvqs_set_defaults(ndev);
bc9a2b3e686e32 Eli Cohen           2023-06-07  3900  	allocate_irqs(ndev);
759ae7f9bf1e6b Eli Cohen           2022-05-18  3901  	init_rwsem(&ndev->reslock);
1a86b377aa2147 Eli Cohen           2020-08-04  3902  	config = &ndev->config;
1e00e821e4ca63 Eli Cohen           2022-02-21  3903  
1e00e821e4ca63 Eli Cohen           2022-02-21  3904  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
1e00e821e4ca63 Eli Cohen           2022-02-21  3905  		err = config_func_mtu(mdev, add_config->net.mtu);
1e00e821e4ca63 Eli Cohen           2022-02-21  3906  		if (err)
759ae7f9bf1e6b Eli Cohen           2022-05-18  3907  			goto err_alloc;
1e00e821e4ca63 Eli Cohen           2022-02-21  3908  	}
1e00e821e4ca63 Eli Cohen           2022-02-21  3909  
deeacf35c922da Si-Wei Liu          2023-02-06  3910  	if (device_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
246fd1caf0f442 Eli Cohen           2021-09-09  3911  		err = query_mtu(mdev, &mtu);
1a86b377aa2147 Eli Cohen           2020-08-04  3912  		if (err)
759ae7f9bf1e6b Eli Cohen           2022-05-18  3913  			goto err_alloc;
1a86b377aa2147 Eli Cohen           2020-08-04  3914  
246fd1caf0f442 Eli Cohen           2021-09-09  3915  		ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
033779a708f0b0 Si-Wei Liu          2023-02-06  3916  	}
1a86b377aa2147 Eli Cohen           2020-08-04  3917  
deeacf35c922da Si-Wei Liu          2023-02-06  3918  	if (device_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
edf747affc41a1 Eli Cohen           2021-09-09  3919  		if (get_link_state(mvdev))
edf747affc41a1 Eli Cohen           2021-09-09  3920  			ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
edf747affc41a1 Eli Cohen           2021-09-09  3921  		else
edf747affc41a1 Eli Cohen           2021-09-09  3922  			ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
033779a708f0b0 Si-Wei Liu          2023-02-06  3923  	}
edf747affc41a1 Eli Cohen           2021-09-09  3924  
a007d940040c0b Eli Cohen           2021-10-26  3925  	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
a007d940040c0b Eli Cohen           2021-10-26  3926  		memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
deeacf35c922da Si-Wei Liu          2023-02-06  3927  	/* No bother setting mac address in config if not going to provision _F_MAC */
deeacf35c922da Si-Wei Liu          2023-02-06  3928  	} else if ((add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) == 0 ||
deeacf35c922da Si-Wei Liu          2023-02-06  3929  		   device_features & BIT_ULL(VIRTIO_NET_F_MAC)) {
1a86b377aa2147 Eli Cohen           2020-08-04  3930  		err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
1a86b377aa2147 Eli Cohen           2020-08-04  3931  		if (err)
759ae7f9bf1e6b Eli Cohen           2022-05-18  3932  			goto err_alloc;
a007d940040c0b Eli Cohen           2021-10-26  3933  	}
1a86b377aa2147 Eli Cohen           2020-08-04  3934  
7c9f131f366ab4 Eli Cohen           2021-04-22  3935  	if (!is_zero_ether_addr(config->mac)) {
7c9f131f366ab4 Eli Cohen           2021-04-22  3936  		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
7c9f131f366ab4 Eli Cohen           2021-04-22  3937  		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
7c9f131f366ab4 Eli Cohen           2021-04-22  3938  		if (err)
759ae7f9bf1e6b Eli Cohen           2022-05-18  3939  			goto err_alloc;
deeacf35c922da Si-Wei Liu          2023-02-06  3940  	} else if ((add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) == 0) {
deeacf35c922da Si-Wei Liu          2023-02-06  3941  		/*
deeacf35c922da Si-Wei Liu          2023-02-06  3942  		 * We used to clear _F_MAC feature bit if seeing
deeacf35c922da Si-Wei Liu          2023-02-06  3943  		 * zero mac address when device features are not
deeacf35c922da Si-Wei Liu          2023-02-06  3944  		 * specifically provisioned. Keep the behaviour
deeacf35c922da Si-Wei Liu          2023-02-06  3945  		 * so old scripts do not break.
deeacf35c922da Si-Wei Liu          2023-02-06  3946  		 */
deeacf35c922da Si-Wei Liu          2023-02-06  3947  		device_features &= ~BIT_ULL(VIRTIO_NET_F_MAC);
deeacf35c922da Si-Wei Liu          2023-02-06  3948  	} else if (device_features & BIT_ULL(VIRTIO_NET_F_MAC)) {
deeacf35c922da Si-Wei Liu          2023-02-06  3949  		/* Don't provision zero mac address for _F_MAC */
deeacf35c922da Si-Wei Liu          2023-02-06  3950  		mlx5_vdpa_warn(&ndev->mvdev,
deeacf35c922da Si-Wei Liu          2023-02-06  3951  			       "No mac address provisioned?\n");
deeacf35c922da Si-Wei Liu          2023-02-06  3952  		err = -EINVAL;
deeacf35c922da Si-Wei Liu          2023-02-06  3953  		goto err_alloc;
7c9f131f366ab4 Eli Cohen           2021-04-22  3954  	}
7c9f131f366ab4 Eli Cohen           2021-04-22  3955  
1e8dac7bb6ca9c Dragos Tatulea      2024-06-26  3956  	if (device_features & BIT_ULL(VIRTIO_NET_F_MQ)) {
acde3929492bcb Eli Cohen           2022-05-16  3957  		config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
1e8dac7bb6ca9c Dragos Tatulea      2024-06-26  3958  		ndev->rqt_size = max_vqs / 2;
1e8dac7bb6ca9c Dragos Tatulea      2024-06-26  3959  	} else {
1e8dac7bb6ca9c Dragos Tatulea      2024-06-26  3960  		ndev->rqt_size = 1;
1e8dac7bb6ca9c Dragos Tatulea      2024-06-26  3961  	}
deeacf35c922da Si-Wei Liu          2023-02-06  3962  
1fcdf43ea69e97 Dragos Tatulea      2024-08-16  3963  	mlx5_cmd_init_async_ctx(mdev, &mvdev->async_ctx);
1fcdf43ea69e97 Dragos Tatulea      2024-08-16  3964  
deeacf35c922da Si-Wei Liu          2023-02-06  3965  	ndev->mvdev.mlx_features = device_features;
7d23dcdf213c2e Eli Cohen           2021-06-06  3966  	mvdev->vdev.dma_dev = &mdev->pdev->dev;
1a86b377aa2147 Eli Cohen           2020-08-04  3967  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
1a86b377aa2147 Eli Cohen           2020-08-04  3968  	if (err)
83e445e64f48bd Dragos Tatulea      2024-11-05  3969  		goto err_alloc;
1a86b377aa2147 Eli Cohen           2020-08-04  3970  
f30a1232b6979c Dragos Tatulea      2024-08-30  3971  	err = mlx5_vdpa_init_mr_resources(mvdev);
f30a1232b6979c Dragos Tatulea      2024-08-30  3972  	if (err)
83e445e64f48bd Dragos Tatulea      2024-11-05  3973  		goto err_alloc;
f16d65124380ac Dragos Tatulea      2023-12-25  3974  
6f5312f801836e Eli Cohen           2021-06-02  3975  	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
049cbeab861ef4 Dragos Tatulea      2023-10-18  3976  		err = mlx5_vdpa_create_dma_mr(mvdev);
1a86b377aa2147 Eli Cohen           2020-08-04  3977  		if (err)
83e445e64f48bd Dragos Tatulea      2024-11-05  3978  			goto err_alloc;
6f5312f801836e Eli Cohen           2021-06-02  3979  	}
6f5312f801836e Eli Cohen           2021-06-02  3980  
1f5d6476f12152 Dragos Tatulea      2024-06-26  3981  	err = alloc_fixed_resources(ndev);
6f5312f801836e Eli Cohen           2021-06-02  3982  	if (err)
83e445e64f48bd Dragos Tatulea      2024-11-05  3983  		goto err_alloc;
1a86b377aa2147 Eli Cohen           2020-08-04  3984  
55ebf0d60e3cc6 Jason Wang          2022-03-29  3985  	ndev->cvq_ent.mvdev = mvdev;
55ebf0d60e3cc6 Jason Wang          2022-03-29  3986  	INIT_WORK(&ndev->cvq_ent.work, mlx5_cvq_kick_handler);
218bdd20e56cab Eli Cohen           2021-09-09  3987  	mvdev->wq = create_singlethread_workqueue("mlx5_vdpa_wq");
5262912ef3cfc5 Eli Cohen           2021-08-23  3988  	if (!mvdev->wq) {
5262912ef3cfc5 Eli Cohen           2021-08-23  3989  		err = -ENOMEM;
83e445e64f48bd Dragos Tatulea      2024-11-05  3990  		goto err_alloc;
5262912ef3cfc5 Eli Cohen           2021-08-23  3991  	}
5262912ef3cfc5 Eli Cohen           2021-08-23  3992  
58926c8aab104d Eli Cohen           2021-04-08  3993  	mvdev->vdev.mdev = &mgtdev->mgtdev;
acde3929492bcb Eli Cohen           2022-05-16  3994  	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
1a86b377aa2147 Eli Cohen           2020-08-04  3995  	if (err)
1a86b377aa2147 Eli Cohen           2020-08-04  3996  		goto err_reg;
1a86b377aa2147 Eli Cohen           2020-08-04  3997  
58926c8aab104d Eli Cohen           2021-04-08  3998  	mgtdev->ndev = ndev;
ffb1aae43ed507 Dragos Tatulea      2024-06-26  3999  
ffb1aae43ed507 Dragos Tatulea      2024-06-26  4000  	/* For virtio-vdpa, the device was set up during device register. */
ffb1aae43ed507 Dragos Tatulea      2024-06-26  4001  	if (ndev->setup)
ffb1aae43ed507 Dragos Tatulea      2024-06-26  4002  		return 0;
ffb1aae43ed507 Dragos Tatulea      2024-06-26  4003  
ffb1aae43ed507 Dragos Tatulea      2024-06-26  4004  	down_write(&ndev->reslock);
ffb1aae43ed507 Dragos Tatulea      2024-06-26  4005  	err = setup_vq_resources(ndev, false);
ffb1aae43ed507 Dragos Tatulea      2024-06-26  4006  	up_write(&ndev->reslock);
ffb1aae43ed507 Dragos Tatulea      2024-06-26  4007  	if (err)
ffb1aae43ed507 Dragos Tatulea      2024-06-26  4008  		goto err_setup_vq_res;
ffb1aae43ed507 Dragos Tatulea      2024-06-26  4009  
74c9729dd892a1 Leon Romanovsky     2020-10-04  4010  	return 0;
1a86b377aa2147 Eli Cohen           2020-08-04  4011  
ffb1aae43ed507 Dragos Tatulea      2024-06-26  4012  err_setup_vq_res:
ffb1aae43ed507 Dragos Tatulea      2024-06-26  4013  	_vdpa_unregister_device(&mvdev->vdev);
1a86b377aa2147 Eli Cohen           2020-08-04  4014  err_reg:
5262912ef3cfc5 Eli Cohen           2021-08-23  4015  	destroy_workqueue(mvdev->wq);
75560522eaef2f Eli Cohen           2022-01-05  4016  err_alloc:
1a86b377aa2147 Eli Cohen           2020-08-04  4017  	put_device(&mvdev->vdev.dev);
74c9729dd892a1 Leon Romanovsky     2020-10-04  4018  	return err;
1a86b377aa2147 Eli Cohen           2020-08-04  4019  }
1a86b377aa2147 Eli Cohen           2020-08-04  4020  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
