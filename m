Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F4E8BE3
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SM2Wu6UP"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B3477400BA
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 00:30:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3477400BA
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SM2Wu6UP
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mQs1i0pUWmgy
	for <virtualization@lists.linux-foundation.org>;
	Sat, 30 Dec 2023 00:30:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 109364010C
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 00:30:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 109364010C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703896236; x=1735432236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+qStPU0nZNPUJ75qySDvHcPxamWqfgmF4KGOB/CSmI4=;
  b=SM2Wu6UPNR//uAhLpEkpAbB5y7QY0aSL1zgmY5g5f+imBNIRVl8cNuhk
   9b88BgQ/8DDX67BEdDG8ATdMGD9wdfdzqc6eHqw9qyCKkFasfb+8U0/Pv
   AA2bJ1U3PYyRL3QP1nYieI45mT7SCcnSZOrDujNWge/C4948P5J45NoyM
   tQerc/foQ68JfOy7At7pzOvpnlrFwFiY+8fLxVvsce7NoDh1pTgZlaNZ2
   FeFqG6iU+9MaZQMFocjzhwE16M0XVCfkJK+4WCvpjgzW/yPl7eWpxp0PH
   v9Bk09/bvIpc400R3ucK7GkddivLO1VPJxOVSspFV1N8j55yJmM3UHfCc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="15326935"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="15326935"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 16:28:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="897649074"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="897649074"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 29 Dec 2023 16:28:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJNDf-000Hub-2P;
	Sat, 30 Dec 2023 00:28:51 +0000
Date: Sat, 30 Dec 2023 08:28:24 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 16/27] virtio_net: xsk: tx: support xmit xsk
 buffer
Message-ID: <202312300834.bOCLH0Mi-lkp@intel.com>
References: <20231229073108.57778-17-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229073108.57778-17-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[cannot apply to net-next/main linus/master horms-ipvs/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_net-rename-free_old_xmit_skbs-to-free_old_xmit/20231229-155253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20231229073108.57778-17-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH net-next v3 16/27] virtio_net: xsk: tx: support xmit xsk buffer
config: x86_64-randconfig-004-20231229 (https://download.01.org/0day-ci/archive/20231230/202312300834.bOCLH0Mi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231230/202312300834.bOCLH0Mi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312300834.bOCLH0Mi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'virtnet_xsk_xmit_one',
       inlined from 'virtnet_xsk_xmit_batch' at drivers/net/virtio/xsk.c:58:9,
       inlined from 'virtnet_xsk_xmit' at drivers/net/virtio/xsk.c:80:9:
>> drivers/net/virtio/xsk.c:34:16: warning: 'virtqueue_add_outbuf' accessing 32 bytes in a region of size 8 [-Wstringop-overflow=]
      34 |         return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      35 |                                     virtnet_xsk_to_ptr(desc->len), GFP_ATOMIC);
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/virtio/xsk.c:34:16: note: referencing argument 2 of type 'struct scatterlist[0]'
   In file included from include/linux/virtio_config.h:7,
                    from include/uapi/linux/virtio_net.h:30,
                    from include/linux/virtio_net.h:8,
                    from drivers/net/virtio/virtio_net.h:8,
                    from drivers/net/virtio/xsk.c:6:
   include/linux/virtio.h: In function 'virtnet_xsk_xmit':
   include/linux/virtio.h:42:5: note: in a call to function 'virtqueue_add_outbuf'
      42 | int virtqueue_add_outbuf(struct virtqueue *vq,
         |     ^~~~~~~~~~~~~~~~~~~~


vim +/virtqueue_add_outbuf +34 drivers/net/virtio/xsk.c

    16	
    17	static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
    18					struct xsk_buff_pool *pool,
    19					struct xdp_desc *desc)
    20	{
    21		struct virtnet_info *vi;
    22		dma_addr_t addr;
    23	
    24		vi = sq->vq->vdev->priv;
    25	
    26		addr = xsk_buff_raw_get_dma(pool, desc->addr);
    27		xsk_buff_raw_dma_sync_for_device(pool, addr, desc->len);
    28	
    29		sg_init_table(sq->sg, 2);
    30	
    31		sg_fill_dma(sq->sg, sq->xsk.hdr_dma_address, vi->hdr_len);
    32		sg_fill_dma(sq->sg + 1, addr, desc->len);
    33	
  > 34		return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
    35					    virtnet_xsk_to_ptr(desc->len), GFP_ATOMIC);
    36	}
    37	
    38	static int virtnet_xsk_xmit_batch(struct virtnet_sq *sq,
    39					  struct xsk_buff_pool *pool,
    40					  unsigned int budget,
    41					  u64 *kicks)
    42	{
    43		struct xdp_desc *descs = pool->tx_descs;
    44		u32 nb_pkts, max_pkts, i;
    45		bool kick = false;
    46		int err;
    47	
    48		/* Every xsk tx packet needs two desc(virtnet header and packet). So we
    49		 * use sq->vq->num_free / 2 as the limitation.
    50		 */
    51		max_pkts = min_t(u32, budget, sq->vq->num_free / 2);
    52	
    53		nb_pkts = xsk_tx_peek_release_desc_batch(pool, max_pkts);
    54		if (!nb_pkts)
    55			return 0;
    56	
    57		for (i = 0; i < nb_pkts; i++) {
  > 58			err = virtnet_xsk_xmit_one(sq, pool, &descs[i]);
    59			if (unlikely(err))
    60				break;
    61	
    62			kick = true;
    63		}
    64	
    65		if (kick && virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
    66			(*kicks)++;
    67	
    68		return i;
    69	}
    70	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
