Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6512B8C
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6EzOKEo"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDB1B40968
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 21:03:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDB1B40968
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z6EzOKEo
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VWwp6HlvUx04
	for <virtualization@lists.linux-foundation.org>;
	Fri, 29 Dec 2023 21:03:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CD3A74093E
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 21:03:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD3A74093E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703883830; x=1735419830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+izWk5xu+lIGF06WtqPEf5Zuf5OC+evaUFTMbMp8EHQ=;
  b=Z6EzOKEo5YgYhnzdeQcuu4fzfmIz5yq8f2gy5twwfuqhpTp7PZoxuKmi
   Kv3kB9opsxI+SYN4/o7wwm4u7EeHy6ECVM7Yt/Ogr8Rx4N5B5bhZQEEkx
   7cHO2x44jNVSqpDQ719M1zzIaAnKnpxlvu44XE0Jqb3d/fcgUmlx5D2p+
   moqAmfHoEaE8v8C9jOfk6vtnEf/aKBn8F5Z/t36+d59wC6nVl+LrwlUIh
   kmxzCbHIJRJQt/4i3rTMIJUTUMDn8ciGOusaHMkszJR1Y2PqH5SwlH40y
   fpuSUf6yZXtJwslnmUK+tfHSN+Aa81CN9dzFCCOj/MRZRLsNm0KkT+qnE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="376154927"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="376154927"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 13:03:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="1110251621"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="1110251621"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 29 Dec 2023 13:03:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJK19-000Hof-2X;
	Fri, 29 Dec 2023 21:03:43 +0000
Date: Sat, 30 Dec 2023 05:03:30 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 23/27] virtio_net: xsk: rx: support recv
 merge mode
Message-ID: <202312300404.1R72Ssbh-lkp@intel.com>
References: <20231229073108.57778-24-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229073108.57778-24-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[cannot apply to net-next/main linus/master horms-ipvs/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_net-rename-free_old_xmit_skbs-to-free_old_xmit/20231229-155253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20231229073108.57778-24-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH net-next v3 23/27] virtio_net: xsk: rx: support recv merge mode
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231230/202312300404.1R72Ssbh-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231230/202312300404.1R72Ssbh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312300404.1R72Ssbh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/virtio/xsk.c:216:17: warning: variable 'xdp' is uninitialized when used here [-Wuninitialized]
     216 |                 xsk_buff_free(xdp);
         |                               ^~~
   drivers/net/virtio/xsk.c:210:22: note: initialize the variable 'xdp' to silence this warning
     210 |         struct xdp_buff *xdp;
         |                             ^
         |                              = NULL
   1 warning generated.


vim +/xdp +216 drivers/net/virtio/xsk.c

   202	
   203	struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
   204						void *buf, u32 len,
   205						unsigned int *xdp_xmit,
   206						struct virtnet_rq_stats *stats)
   207	{
   208		struct net_device *dev = vi->dev;
   209		struct sk_buff *skb = NULL;
   210		struct xdp_buff *xdp;
   211	
   212		if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
   213			pr_debug("%s: short packet %i\n", dev->name, len);
   214			DEV_STATS_INC(dev, rx_length_errors);
   215	
 > 216			xsk_buff_free(xdp);
   217			return NULL;
   218		}
   219	
   220		len -= vi->hdr_len;
   221	
   222		u64_stats_add(&stats->bytes, len);
   223	
   224		xdp = buf_to_xdp(vi, rq, buf, len);
   225		if (!xdp)
   226			return NULL;
   227	
   228		if (vi->mergeable_rx_bufs)
   229			skb = virtnet_receive_xsk_merge(dev, vi, rq, xdp, xdp_xmit, stats);
   230	
   231		return skb;
   232	}
   233	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
