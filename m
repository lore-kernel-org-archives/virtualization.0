Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE2614F9C7;
	Fri,  7 Jun 2024 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717743399; cv=none; b=LJlJzww6h8ocndFx7Lvph8A3g6s7ybZaVAYawzRHJ+Sh2hE0OQkRwUrBz8Pxx+ZZTH7M3s8LiJzBL1nkrbzDanoKWu6iy8ujFzqLuXgyAJYZV4l4FyBSVyVzE8imgAz46WlaNyMRqadoKk50P3p/hv+3Eg7Rp+qs/wb3Z+ifYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717743399; c=relaxed/simple;
	bh=AzL1BIMMWlNUGqjNBs33eGem6V4wdkSkiVAHykactYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jktuEM7YI6xWhOBPkJlhdW1mMk0ajHqzKPWk4O0dQFYmbJdEDVghGLHyV4rtTrgUp7R0DzRdSfwM1ycJ9oJ1Qkozt58CDUurICK5eyHSF9HtmTh4NuD3ZCwwluCrXnvQ54Cy7DhPUXLca/5muzjybXL3YcTqHJ2rKnSDElvk/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTNbwtY3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTNbwtY3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717743398; x=1749279398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AzL1BIMMWlNUGqjNBs33eGem6V4wdkSkiVAHykactYY=;
  b=nTNbwtY3rk3OXlHdldQHs+AkXigtxStvWW3gG13m0U/t9vFzUABoZjc3
   Xmk7Fvt+adVq9o3hjpbtaS/Wapx2UAOWBcHrwKgTawtN7qbcSk62wz7XD
   v6Z6pBbRdxSQnql1qGwrV5jXw/22pgaz6ksls7BRNYUTxauGlYvsVcFo3
   e44s5buYSSmxdiiqQIUQg/FkIVkz3Ph31+1Iq8tqUWFs3psVHDwC3BKKa
   8RL7s3pp7EWgikL6NiTRkdhhFi5zd3qpJ8ov1caAkaB1qnidzgj6U/ppT
   qjFv57AFLaZ2lS8vwJnwFAsu+BHBUyy21MSoPxQWuibg0ViKg4yXa3UbE
   g==;
X-CSE-ConnectionGUID: TE9shtsVQdK+UPp7siAlyA==
X-CSE-MsgGUID: UL0ycVM5R4yl4NoUjDZLIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14606293"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="14606293"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 23:56:38 -0700
X-CSE-ConnectionGUID: SEpao+7YTXaJn7Ko26gwzg==
X-CSE-MsgGUID: aBjPzdVIRK+RDqjqxojXIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="43167669"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 06 Jun 2024 23:56:34 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFTWa-0004Be-1y;
	Fri, 07 Jun 2024 06:56:32 +0000
Date: Fri, 7 Jun 2024 14:56:13 +0800
From: kernel test robot <lkp@intel.com>
To: Denis Arefev <arefev@swemel.ru>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: missing check
Message-ID: <202406071404.OiLHfOHM-lkp@intel.com>
References: <20240606141450.44709-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606141450.44709-1-arefev@swemel.ru>

Hi Denis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.10-rc2 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Denis-Arefev/net-missing-check/20240606-230540
base:   linus/master
patch link:    https://lore.kernel.org/r/20240606141450.44709-1-arefev%40swemel.ru
patch subject: [PATCH] net: missing check
config: x86_64-randconfig-121-20240607 (https://download.01.org/0day-ci/archive/20240607/202406071404.OiLHfOHM-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406071404.OiLHfOHM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406071404.OiLHfOHM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/virtio_net.c: note: in included file:
>> include/linux/virtio_net.h:103:58: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned long long [usertype] divisor @@     got restricted __virtio16 const [usertype] gso_size @@
   include/linux/virtio_net.h:103:58: sparse:     expected unsigned long long [usertype] divisor
   include/linux/virtio_net.h:103:58: sparse:     got restricted __virtio16 const [usertype] gso_size
>> include/linux/virtio_net.h:104:42: sparse: sparse: restricted __virtio16 degrades to integer

vim +103 include/linux/virtio_net.h

    49	
    50	static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
    51						const struct virtio_net_hdr *hdr,
    52						bool little_endian)
    53	{
    54		unsigned int nh_min_len = sizeof(struct iphdr);
    55		unsigned int gso_type = 0;
    56		unsigned int thlen = 0;
    57		unsigned int p_off = 0;
    58		unsigned int ip_proto;
    59		u64 ret, remainder;
    60	
    61		if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
    62			switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
    63			case VIRTIO_NET_HDR_GSO_TCPV4:
    64				gso_type = SKB_GSO_TCPV4;
    65				ip_proto = IPPROTO_TCP;
    66				thlen = sizeof(struct tcphdr);
    67				break;
    68			case VIRTIO_NET_HDR_GSO_TCPV6:
    69				gso_type = SKB_GSO_TCPV6;
    70				ip_proto = IPPROTO_TCP;
    71				thlen = sizeof(struct tcphdr);
    72				nh_min_len = sizeof(struct ipv6hdr);
    73				break;
    74			case VIRTIO_NET_HDR_GSO_UDP:
    75				gso_type = SKB_GSO_UDP;
    76				ip_proto = IPPROTO_UDP;
    77				thlen = sizeof(struct udphdr);
    78				break;
    79			case VIRTIO_NET_HDR_GSO_UDP_L4:
    80				gso_type = SKB_GSO_UDP_L4;
    81				ip_proto = IPPROTO_UDP;
    82				thlen = sizeof(struct udphdr);
    83				break;
    84			default:
    85				return -EINVAL;
    86			}
    87	
    88			if (hdr->gso_type & VIRTIO_NET_HDR_GSO_ECN)
    89				gso_type |= SKB_GSO_TCP_ECN;
    90	
    91			if (hdr->gso_size == 0)
    92				return -EINVAL;
    93		}
    94	
    95		skb_reset_mac_header(skb);
    96	
    97		if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
    98			u32 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
    99			u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
   100			u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
   101	
   102			if (hdr->gso_size) {
 > 103				ret = div64_u64_rem(skb->len, hdr->gso_size, &remainder);
 > 104				if (!(ret && (hdr->gso_size > needed) &&
   105							((remainder > needed) || (remainder == 0)))) {
   106					return -EINVAL;
   107				}
   108				skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
   109			}
   110	
   111			if (!pskb_may_pull(skb, needed))
   112				return -EINVAL;
   113	
   114			if (!skb_partial_csum_set(skb, start, off))
   115				return -EINVAL;
   116	
   117			nh_min_len = max_t(u32, nh_min_len, skb_transport_offset(skb));
   118			p_off = nh_min_len + thlen;
   119			if (!pskb_may_pull(skb, p_off))
   120				return -EINVAL;
   121		} else {
   122			/* gso packets without NEEDS_CSUM do not set transport_offset.
   123			 * probe and drop if does not match one of the above types.
   124			 */
   125			if (gso_type && skb->network_header) {
   126				struct flow_keys_basic keys;
   127	
   128				if (!skb->protocol) {
   129					__be16 protocol = dev_parse_header_protocol(skb);
   130	
   131					if (!protocol)
   132						virtio_net_hdr_set_proto(skb, hdr);
   133					else if (!virtio_net_hdr_match_proto(protocol, hdr->gso_type))
   134						return -EINVAL;
   135					else
   136						skb->protocol = protocol;
   137				}
   138	retry:
   139				if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
   140								      NULL, 0, 0, 0,
   141								      0)) {
   142					/* UFO does not specify ipv4 or 6: try both */
   143					if (gso_type & SKB_GSO_UDP &&
   144					    skb->protocol == htons(ETH_P_IP)) {
   145						skb->protocol = htons(ETH_P_IPV6);
   146						goto retry;
   147					}
   148					return -EINVAL;
   149				}
   150	
   151				p_off = keys.control.thoff + thlen;
   152				if (!pskb_may_pull(skb, p_off) ||
   153				    keys.basic.ip_proto != ip_proto)
   154					return -EINVAL;
   155	
   156				skb_set_transport_header(skb, keys.control.thoff);
   157			} else if (gso_type) {
   158				p_off = nh_min_len + thlen;
   159				if (!pskb_may_pull(skb, p_off))
   160					return -EINVAL;
   161			}
   162		}
   163	
   164		if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
   165			u16 gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
   166			unsigned int nh_off = p_off;
   167			struct skb_shared_info *shinfo = skb_shinfo(skb);
   168	
   169			switch (gso_type & ~SKB_GSO_TCP_ECN) {
   170			case SKB_GSO_UDP:
   171				/* UFO may not include transport header in gso_size. */
   172				nh_off -= thlen;
   173				break;
   174			case SKB_GSO_UDP_L4:
   175				if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
   176					return -EINVAL;
   177				if (skb->csum_offset != offsetof(struct udphdr, check))
   178					return -EINVAL;
   179				if (skb->len - p_off > gso_size * UDP_MAX_SEGMENTS)
   180					return -EINVAL;
   181				if (gso_type != SKB_GSO_UDP_L4)
   182					return -EINVAL;
   183				break;
   184			}
   185	
   186			/* Kernel has a special handling for GSO_BY_FRAGS. */
   187			if (gso_size == GSO_BY_FRAGS)
   188				return -EINVAL;
   189	
   190			/* Too small packets are not really GSO ones. */
   191			if (skb->len - nh_off > gso_size) {
   192				shinfo->gso_size = gso_size;
   193				shinfo->gso_type = gso_type;
   194	
   195				/* Header must be checked, and gso_segs computed. */
   196				shinfo->gso_type |= SKB_GSO_DODGY;
   197				shinfo->gso_segs = 0;
   198			}
   199		}
   200	
   201		return 0;
   202	}
   203	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
