Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CC1A3C;
	Tue,  2 Jan 2024 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAZtpUnH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704161896; x=1735697896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mDNd5uZ157AwkiZSpl+8cKaipWo9mwt38jhXrnbiw8I=;
  b=hAZtpUnHfjTcrKyoiBG0rT/9F6G4Z/amK8nc7O7TGRCjbvMKWJisHi59
   sq7Kuo9AEVfKvmN+jqkK6wGOwkQ0A7ft7bvJbropBvX84hILN3q1g81Gd
   HxwIeU/DV0sL4XwnjPEqIc38209M8voCWgFcWOY/ZJ+BlFV4cpAUp2fUt
   LPZkcgjEcpBjbNQvodlYJAHnjvoWU4S4cqp+CgFM2rubLm6oiOqhPN15X
   DOjZ9L4wvH12TLi1sahY0KrjzumfjqVHHyAYq+5InBNoZcsKyvynq6cf9
   aAcQdaiBvbMD+fpEfWqfTOqnTm5kkaF7lp/59Sv8wPDL44naPII3kxy3A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="4158707"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="4158707"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 18:18:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="845434104"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="845434104"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jan 2024 18:18:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKUM2-000KhQ-1S;
	Tue, 02 Jan 2024 02:18:06 +0000
Date: Tue, 2 Jan 2024 10:17:55 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH net-next v1 4/6] virtio_net: stats map include driver
 stats
Message-ID: <202401020928.JpmKXuhu-lkp@intel.com>
References: <20231226073103.116153-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226073103.116153-5-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.7-rc8]
[cannot apply to net-next/main horms-ipvs/master next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_net-introduce-device-stats-feature-and-structures/20231226-153227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20231226073103.116153-5-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH net-next v1 4/6] virtio_net: stats map include driver stats
config: x86_64-randconfig-121-20240101 (https://download.01.org/0day-ci/archive/20240102/202401020928.JpmKXuhu-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240102/202401020928.JpmKXuhu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401020928.JpmKXuhu-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/virtio_net.c:3416:83: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __virtio64 [usertype] val @@     got unsigned long long const [usertype] @@
   drivers/net/virtio_net.c:3416:83: sparse:     expected restricted __virtio64 [usertype] val
   drivers/net/virtio_net.c:3416:83: sparse:     got unsigned long long const [usertype]
   drivers/net/virtio_net.c:3500:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __virtio16 [usertype] val @@     got restricted __le16 [usertype] vq_index @@
   drivers/net/virtio_net.c:3500:52: sparse:     expected restricted __virtio16 [usertype] val
   drivers/net/virtio_net.c:3500:52: sparse:     got restricted __le16 [usertype] vq_index
   drivers/net/virtio_net.c:3498:81: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __virtio16 [usertype] val @@     got restricted __le16 [usertype] size @@
   drivers/net/virtio_net.c:3498:81: sparse:     expected restricted __virtio16 [usertype] val
   drivers/net/virtio_net.c:3498:81: sparse:     got restricted __le16 [usertype] size
   drivers/net/virtio_net.c:3549:82: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __virtio64 [usertype] val @@     got restricted __le64 [assigned] [usertype] v @@
   drivers/net/virtio_net.c:3549:82: sparse:     expected restricted __virtio64 [usertype] val
   drivers/net/virtio_net.c:3549:82: sparse:     got restricted __le64 [assigned] [usertype] v

vim +3416 drivers/net/virtio_net.c

  3378	
  3379	static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
  3380				       struct virtnet_stats_ctx *ctx,
  3381				       const u8 *base, bool from_driver, u8 type)
  3382	{
  3383		struct virtnet_stats_map *m;
  3384		const u64_stats_t *v_stat;
  3385		u32 queue_type;
  3386		const u64 *v;
  3387		u64 offset;
  3388		int i, j;
  3389	
  3390		if (qid == vi->max_queue_pairs * 2) {
  3391			offset = 0;
  3392			queue_type = VIRTNET_STATS_Q_TYPE_CQ;
  3393		} else if (qid % 2) {
  3394			offset = ctx->num_cq + ctx->num_rx * vi->curr_queue_pairs + ctx->num_tx * (qid / 2);
  3395			queue_type = VIRTNET_STATS_Q_TYPE_TX;
  3396		} else {
  3397			offset = ctx->num_cq + ctx->num_rx * (qid / 2);
  3398			queue_type = VIRTNET_STATS_Q_TYPE_RX;
  3399		}
  3400	
  3401		for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
  3402			m = &virtio_net_stats_map[i];
  3403	
  3404			if (m->queue_type != queue_type)
  3405				continue;
  3406	
  3407			if (from_driver != m->from_driver)
  3408				goto skip;
  3409	
  3410			if (type != m->type)
  3411				goto skip;
  3412	
  3413			for (j = 0; j < m->num; ++j) {
  3414				if (!from_driver) {
  3415					v = (const u64 *)(base + m->desc[j].offset);
> 3416					ctx->data[offset + j] = virtio64_to_cpu(vi->vdev, *v);
  3417				} else {
  3418					v_stat = (const u64_stats_t *)(base + m->desc[j].offset);
  3419					ctx->data[offset + j] = u64_stats_read(v_stat);
  3420				}
  3421			}
  3422	
  3423			break;
  3424	skip:
  3425			if (virtnet_stats_valid(vi, m))
  3426				offset += m->num;
  3427		}
  3428	}
  3429	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
