Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C1CC6FA8F
	for <virtualization@archiver.kernel.org>; Tue, 29 Aug 2023 19:02:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14A728214D;
	Tue, 29 Aug 2023 19:02:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14A728214D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZFYpgEaz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K2upzESqx5y6; Tue, 29 Aug 2023 19:02:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 485BC82140;
	Tue, 29 Aug 2023 19:02:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 485BC82140
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19DDFC0071;
	Tue, 29 Aug 2023 19:02:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9B2AC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 19:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C3E040503
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 19:02:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C3E040503
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZFYpgEaz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kbTq3GjdHNFq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 19:02:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7FC98401A3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 19:02:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7FC98401A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693335765; x=1724871765;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZssVyiuPrzV8HRbNj+dFM/GZZcr2HnyGAqBT1eeT8yU=;
 b=ZFYpgEazbe2nPr1h2cz8cHR0nsTMdw+nxisfHJSCMRGQY0flCOlTi3eJ
 ufnO8iOQCfmIiT1peBbWUetb9dCO+4Hi5u3BVqpfLigP68Il84e1eOUwN
 uQggpZuD4Ffry/h44/Gxv8xZeUYCycqA5xYUPsun5ldrwnEMsYXauVrwH
 UxOLOw04y0/6RX6Ey3xKFdTLUJn2zE9det8eXWzLD7NHsHB8U27Wb+Sn3
 4k+nKAr8NyDKb9+hYohlRclMLa+xhLuAPouW6aVi9g8WUxe7/+zOk7OSG
 qAHNF7xEmQe3cfq6hU9jcixWDotujw0fXGe6xhEve5+PmdHSbCIhzzk0B A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406452260"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; d="scan'208";a="406452260"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2023 12:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="808809395"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; d="scan'208";a="808809395"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
 by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2023 12:02:41 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qb3z6-00090T-2L;
 Tue, 29 Aug 2023 19:02:40 +0000
Date: Wed, 30 Aug 2023 03:02:24 +0800
From: kernel test robot <lkp@intel.com>
To: Dragos Tatulea <dtatulea@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix firmware error on creation of 1k VQs
Message-ID: <202308300241.q7t7Ouf3-lkp@intel.com>
References: <20230829174219.928343-1-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230829174219.928343-1-dtatulea@nvidia.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Saeed Mahameed <saeedm@nvidia.com>, oe-kbuild-all@lists.linux.dev
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Dragos,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5 next-20230829]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dragos-Tatulea/vdpa-mlx5-Fix-firmware-error-on-creation-of-1k-VQs/20230830-014600
base:   linus/master
patch link:    https://lore.kernel.org/r/20230829174219.928343-1-dtatulea%40nvidia.com
patch subject: [PATCH] vdpa/mlx5: Fix firmware error on creation of 1k VQs
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230830/202308300241.q7t7Ouf3-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230830/202308300241.q7t7Ouf3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308300241.q7t7Ouf3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/vdpa/mlx5/net/mlx5_vnet.c: In function 'read_umem_params':
>> drivers/vdpa/mlx5/net/mlx5_vnet.c:658:1: warning: the frame size of 4128 bytes is larger than 2048 bytes [-Wframe-larger-than=]
     658 | }
         | ^


vim +658 drivers/vdpa/mlx5/net/mlx5_vnet.c

   627	
   628	static int read_umem_params(struct mlx5_vdpa_net *ndev)
   629	{
   630		u32 out[MLX5_ST_SZ_DW(query_hca_cap_out)] = {};
   631		u32 in[MLX5_ST_SZ_DW(query_hca_cap_in)] = {};
   632		u16 opmod = (MLX5_CAP_VDPA_EMULATION << 1) | (HCA_CAP_OPMOD_GET_CUR & 0x01);
   633		struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
   634		void *caps;
   635		int err;
   636	
   637		MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
   638		MLX5_SET(query_hca_cap_in, in, op_mod, opmod);
   639		err = mlx5_cmd_exec_inout(mdev, query_hca_cap, in, out);
   640		if (err) {
   641			mlx5_vdpa_warn(&ndev->mvdev,
   642				"Failed reading vdpa umem capabilities with err %d\n", err);
   643			return err;
   644		}
   645	
   646		caps =  MLX5_ADDR_OF(query_hca_cap_out, out, capability);
   647	
   648		ndev->umem_1_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_1_buffer_param_a);
   649		ndev->umem_1_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_1_buffer_param_b);
   650	
   651		ndev->umem_2_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_2_buffer_param_a);
   652		ndev->umem_2_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_2_buffer_param_b);
   653	
   654		ndev->umem_3_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_3_buffer_param_a);
   655		ndev->umem_3_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_3_buffer_param_b);
   656	
   657		return 0;
 > 658	}
   659	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
