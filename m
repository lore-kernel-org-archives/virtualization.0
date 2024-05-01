Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97DD3BBCC;
	Wed,  1 May 2024 05:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714539661; cv=none; b=WeqkrGksvbcXj1HE/V/j0jNsVnjLr9XeFZXkVHwNYHK8k4roL09GnRAQVV2YXa5PHNGxWI4Pbh2AF1JNfYMW5zvFKzAwF9tbniYMWjESAxVkALiDq3v10GT1mTmf0EGJStCYt6Atw7HK8Q6takoxSifPOd8vwsWptyr5pXLISkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714539661; c=relaxed/simple;
	bh=miWs99Epddpe6a0GfJt/m+3g6k8nD6+NqM7GbVTSFMw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=FT677wqy2DFu0+KW2sDO8K+UNPgfw3LJl+OIJSiJ+JSGXrV2p9uDTRQLJWpkfU0AlDD/N8hF5n0EaPB6MfxcQ+t2f3YD42NyvPhH6Ly+dJ7t6QU+aOx7htYD2Uf3rVMeQxbHCnk7Shv0xN7IVkIJvEJE8bz88ft/1bTWPDZfbHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G0nZiHl2; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G0nZiHl2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714539651; h=Message-ID:Subject:Date:From:To;
	bh=4C/1NzvqCqNJq8eCu1ckrt3sxtc3J1q3uMIkt9wzWqw=;
	b=G0nZiHl2SrIsphHEBHHaCNx59bDPmksLf6aPb0Weok0dFFRHH+6LspoRT0Z6Lu6Cp4QLQMCtx4ViCENZCiKilYOxQ4aNKxq7ijduHfc2JxliSr8rRi9yGspaD4is3m6rAI77eNxu1eTQ7dWsw6rPvzUnlwSMv3crrCoCcBQPb6A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W5dyPyR_1714539647;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5dyPyR_1714539647)
          by smtp.aliyun-inc.com;
          Wed, 01 May 2024 13:00:48 +0800
Message-ID: <1714538736.2472136-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v11 2/4] ethtool: provide customized dim profile management
Date: Wed, 1 May 2024 12:45:36 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240430173136.15807-1-hengqi@linux.alibaba.com>
 <20240430173136.15807-3-hengqi@linux.alibaba.com>
 <202405011004.Rkw6IrSl-lkp@intel.com>
In-Reply-To: <202405011004.Rkw6IrSl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 1 May 2024 10:36:03 +0800, kernel test robot <lkp@intel.com> wrote:
> Hi Heng,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/linux-dim-move-useful-macros-to-h-file/20240501-013413
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240430173136.15807-3-hengqi%40linux.alibaba.com
> patch subject: [PATCH net-next v11 2/4] ethtool: provide customized dim profile management
> config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240501/202405011004.Rkw6IrSl-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405011004.Rkw6IrSl-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405011004.Rkw6IrSl-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    net/ethtool/coalesce.c: In function 'ethnl_update_profile':
>    net/ethtool/coalesce.c:453:46: error: 'struct net_device' has no member named 'irq_moder'
>      453 |         struct dim_irq_moder *irq_moder = dev->irq_moder;
>          |                                              ^~
>    net/ethtool/coalesce.c: At top level:
> >> net/ethtool/coalesce.c:446:12: warning: 'ethnl_update_profile' defined but not used [-Wunused-function]
>      446 | static int ethnl_update_profile(struct net_device *dev,
>          |            ^~~~~~~~~~~~~~~~~~~~
> >> net/ethtool/coalesce.c:151:12: warning: 'coalesce_put_profile' defined but not used [-Wunused-function]
>      151 | static int coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
>          |            ^~~~~~~~~~~~~~~~~~~~
> 

This is a known minor issue, to reduce the use of 'IS_ENABLED(CONFIG_DIMLIB)'
mentioned in v10. Since the calls of ethnl_update_profile() and
coalesce_put_profile() will only occur when IS_ENABLED(CONFIG_DIMLIB) returns
true, the robot's warning can be ignored the code is safe.

All NIPA test cases running on my local pass successfully on V11.

Alternatively, I remake the series to have IS_ENABLED(CONFIG_DIMLIB) back,
up to Kuba (and others). :)

Thanks.

> 
> vim +/ethnl_update_profile +446 net/ethtool/coalesce.c
> 
>    424	
>    425	/**
>    426	 * ethnl_update_profile - get a profile nest with child nests from userspace.
>    427	 * @dev: netdevice to update the profile
>    428	 * @dst: profile get from the driver and modified by ethnl_update_profile.
>    429	 * @nests: nest attr ETHTOOL_A_COALESCE_*X_PROFILE to set profile.
>    430	 * @extack: Netlink extended ack
>    431	 *
>    432	 * Layout of nests:
>    433	 *   Nested ETHTOOL_A_COALESCE_*X_PROFILE attr
>    434	 *     Nested ETHTOOL_A_PROFILE_IRQ_MODERATION attr
>    435	 *       ETHTOOL_A_IRQ_MODERATION_USEC attr
>    436	 *       ETHTOOL_A_IRQ_MODERATION_PKTS attr
>    437	 *       ETHTOOL_A_IRQ_MODERATION_COMPS attr
>    438	 *     ...
>    439	 *     Nested ETHTOOL_A_PROFILE_IRQ_MODERATION attr
>    440	 *       ETHTOOL_A_IRQ_MODERATION_USEC attr
>    441	 *       ETHTOOL_A_IRQ_MODERATION_PKTS attr
>    442	 *       ETHTOOL_A_IRQ_MODERATION_COMPS attr
>    443	 *
>    444	 * Return: 0 on success or a negative error code.
>    445	 */
>  > 446	static int ethnl_update_profile(struct net_device *dev,
>    447					struct dim_cq_moder __rcu **dst,
>    448					const struct nlattr *nests,
>    449					struct netlink_ext_ack *extack)
>    450	{
>    451		int len_irq_moder = ARRAY_SIZE(coalesce_irq_moderation_policy);
>    452		struct nlattr *tb[ARRAY_SIZE(coalesce_irq_moderation_policy)];
>  > 453		struct dim_irq_moder *irq_moder = dev->irq_moder;
>    454		struct dim_cq_moder *new_profile, *old_profile;
>    455		int ret, rem, i = 0, len;
>    456		struct nlattr *nest;
>    457	
>    458		if (!nests)
>    459			return 0;
>    460	
>    461		if (!*dst)
>    462			return -EOPNOTSUPP;
>    463	
>    464		old_profile = rtnl_dereference(*dst);
>    465		len = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*old_profile);
>    466		new_profile = kmemdup(old_profile, len, GFP_KERNEL);
>    467		if (!new_profile)
>    468			return -ENOMEM;
>    469	
>    470		nla_for_each_nested_type(nest, ETHTOOL_A_PROFILE_IRQ_MODERATION,
>    471					 nests, rem) {
>    472			ret = nla_parse_nested(tb, len_irq_moder - 1, nest,
>    473					       coalesce_irq_moderation_policy,
>    474					       extack);
>    475			if (ret)
>    476				goto err_out;
>    477	
>    478			ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].usec,
>    479						     ETHTOOL_A_IRQ_MODERATION_USEC,
>    480						     tb, DIM_COALESCE_USEC,
>    481						     extack);
>    482			if (ret)
>    483				goto err_out;
>    484	
>    485			ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].pkts,
>    486						     ETHTOOL_A_IRQ_MODERATION_PKTS,
>    487						     tb, DIM_COALESCE_PKTS,
>    488						     extack);
>    489			if (ret)
>    490				goto err_out;
>    491	
>    492			ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].comps,
>    493						     ETHTOOL_A_IRQ_MODERATION_COMPS,
>    494						     tb, DIM_COALESCE_COMPS,
>    495						     extack);
>    496			if (ret)
>    497				goto err_out;
>    498	
>    499			i++;
>    500		}
>    501	
>    502		rcu_assign_pointer(*dst, new_profile);
>    503		kfree_rcu(old_profile, rcu);
>    504	
>    505		return 0;
>    506	
>    507	err_out:
>    508		kfree(new_profile);
>    509		return ret;
>    510	}
>    511	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
