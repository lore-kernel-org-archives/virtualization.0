Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E9C13C673;
	Thu,  6 Jun 2024 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669572; cv=none; b=TljD5nbk+mynPIclg1msMuTIsqzZZCbwg2yHCY5/ytJd0K8+r2UdF9YyB6o8ZkByJnwsq15QOEdu5qenco8J9IWoU4ydqf5i9ZDif+EJz1ZQlHZFmt6fgEfk9mTrqC+TaOidB3Ruqhh7TTCJA5FO/Qil56pLa93RpkkC2+i5cr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669572; c=relaxed/simple;
	bh=XtmlM9TlqX08cpeM2q1IwikRYJEqGVTehuNCWzJukak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBtwbo/UgRcp60XlGf5Lp9UCQ8qG00Brer/vFrXYjUXa7ZF70IUcMVvrxpwn7cN5NYb+y9eMjh1bjQjm4EJmKCVC3xiDAtQelhgr41TU752Rm4IXRLqwWV623TYWh4uO3IAptD1HSeYxBVRziy5i4BbJ3fPkW1ddjPt4x1izKHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5LlIQAc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5LlIQAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717669571; x=1749205571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XtmlM9TlqX08cpeM2q1IwikRYJEqGVTehuNCWzJukak=;
  b=f5LlIQAcOzXoRedCb4E9uYdEuXnosA8RGgQMkhajJAi+lLE6LzE54iq9
   Z+l7aoTeKlZQ3Zb1c0KkMKJMUbXsD4fHMiYH2FyNu7dYYPnBn0b9Wd++k
   AwQigMJKHN/6J9DmkvEHtGKnyorb1/HL9OiXt25rPR9CmfFYmeWCS0W4B
   cQKlzwx/PS8fryBUwa/n2UEXUZsff5K6OukLkfIlwqtL5GdABQgIysLd3
   Yo3jKsOWp+6suN7LjMkJqaQr37N6RDAe90BrMGRZR7kOcx5TkLteqpYSj
   hE1mNMLeccYmF4+kORq16GWixLXqb/40QmucO0QHD3+FZXvqvbHRp4Idx
   Q==;
X-CSE-ConnectionGUID: 6Dpv+8T3Rh6/SjvsxAagvg==
X-CSE-MsgGUID: jfolwBPwSi+zEeq6pWqwsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24960729"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="24960729"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:26:05 -0700
X-CSE-ConnectionGUID: tNcXLHLNQhWdQ1Z8gJpGvQ==
X-CSE-MsgGUID: JyJrvGNhT1SP9xWkJNur6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="37985146"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 06 Jun 2024 03:26:02 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFAJj-0002yo-03;
	Thu, 06 Jun 2024 10:25:59 +0000
Date: Thu, 6 Jun 2024 18:25:04 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 4/4] virtio_net: improve dim command request
 efficiency
Message-ID: <202406061803.R48FH9c8-lkp@intel.com>
References: <20240606061446.127802-5-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606061446.127802-5-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/virtio_net-passing-control_buf-explicitly/20240606-141748
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240606061446.127802-5-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v3 4/4] virtio_net: improve dim command request efficiency
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240606/202406061803.R48FH9c8-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240606/202406061803.R48FH9c8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406061803.R48FH9c8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/virtio_net.c:7:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/riscv/include/asm/cacheflush.h:9:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/virtio_net.c:2844:3: warning: add explicit braces to avoid dangling else [-Wdangling-else]
    2844 |                 else
         |                 ^
   2 warnings generated.


vim +2844 drivers/net/virtio_net.c

  2813	
  2814	static void virtnet_get_cvq_work(struct work_struct *work)
  2815	{
  2816		struct virtnet_info *vi =
  2817			container_of(work, struct virtnet_info, get_cvq);
  2818		struct virtnet_coal_node *wait_coal;
  2819		bool valid = false;
  2820		unsigned int tmp;
  2821		void *res;
  2822	
  2823		mutex_lock(&vi->cvq_lock);
  2824		while ((res = virtqueue_get_buf(vi->cvq, &tmp)) != NULL) {
  2825			complete((struct completion *)res);
  2826			valid = true;
  2827		}
  2828		mutex_unlock(&vi->cvq_lock);
  2829	
  2830		if (!valid)
  2831			return;
  2832	
  2833		while (true) {
  2834			wait_coal = NULL;
  2835			mutex_lock(&vi->coal_wait_lock);
  2836			if (!list_empty(&vi->coal_wait_list))
  2837				wait_coal = list_first_entry(&vi->coal_wait_list,
  2838							     struct virtnet_coal_node,
  2839							     list);
  2840			mutex_unlock(&vi->coal_wait_lock);
  2841			if (wait_coal)
  2842				if (virtnet_add_dim_command(vi, wait_coal))
  2843					break;
> 2844			else
  2845				break;
  2846		}
  2847	}
  2848	static int virtnet_set_mac_address(struct net_device *dev, void *p)
  2849	{
  2850		struct virtnet_info *vi = netdev_priv(dev);
  2851		struct virtio_device *vdev = vi->vdev;
  2852		int ret;
  2853		struct sockaddr *addr;
  2854		struct scatterlist sg;
  2855	
  2856		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STANDBY))
  2857			return -EOPNOTSUPP;
  2858	
  2859		addr = kmemdup(p, sizeof(*addr), GFP_KERNEL);
  2860		if (!addr)
  2861			return -ENOMEM;
  2862	
  2863		ret = eth_prepare_mac_addr_change(dev, addr);
  2864		if (ret)
  2865			goto out;
  2866	
  2867		if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
  2868			sg_init_one(&sg, addr->sa_data, dev->addr_len);
  2869			if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
  2870						  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
  2871				dev_warn(&vdev->dev,
  2872					 "Failed to set mac address by vq command.\n");
  2873				ret = -EINVAL;
  2874				goto out;
  2875			}
  2876		} else if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
  2877			   !virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
  2878			unsigned int i;
  2879	
  2880			/* Naturally, this has an atomicity problem. */
  2881			for (i = 0; i < dev->addr_len; i++)
  2882				virtio_cwrite8(vdev,
  2883					       offsetof(struct virtio_net_config, mac) +
  2884					       i, addr->sa_data[i]);
  2885		}
  2886	
  2887		eth_commit_mac_addr_change(dev, p);
  2888		ret = 0;
  2889	
  2890	out:
  2891		kfree(addr);
  2892		return ret;
  2893	}
  2894	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
