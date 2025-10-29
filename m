Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E195337699;
	Wed, 29 Oct 2025 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752308; cv=none; b=Bu0YZEhDSK4io6tFTS892LB1I8pv+BGSbTIqlpYhvf5uh45CKJZZA4fBElSvp7wUwgT/YJxaUbkbMU/Pka6wQ88J8rHq5lvCcv/tpf5D5qCAqU6qyed6fzStssM+/0JBZAV6JiaFK5s/JQLCuNZ/M+jot9rsSGJWvXOlgNHLK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752308; c=relaxed/simple;
	bh=h0yjNbZ9rEgJMPE1DAuciMAwui8RU187z1uWv/LoOek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjNaBtDMX1ylT11nkdJwF4wiJYxoTu1oX8QTD409EILucImkMOGWLtLka3p09/E27EbxaQp3PFMv9WEoI+lX2EkDlh4sGKtu44sArqPkoRxx0E6XDixvkEEXBW9G7wprxw7uY1K4iH8MGGZXHB/2gfLppHxkNP/hgTfcCuPmoAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ax2hQ8rx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ax2hQ8rx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761752307; x=1793288307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h0yjNbZ9rEgJMPE1DAuciMAwui8RU187z1uWv/LoOek=;
  b=Ax2hQ8rxhU70mdFpiCCFfOTfwCaMX5IJy9Laq4vFLXZsLr835cszUCSX
   LJD5si3JIlKthsu3F14cKiWdWQleYjYdXTpdiqsBAaVR0zgEJtIPuL7vr
   pD88j0bzMHBT1GzoheC81oV4hQcg7t2xEZ+aIWqPhI8xlojG/Eixt8dE9
   EQn5zmLuy5YwAK/Tsse21/UpMAWXF8Ae2YehyVMAY8fqvqjaqTXJDFVPR
   ZaKTQviI/mBn51/raYo15lvUFdYYiFV+N9x1Pectmd8c0v7x3LtZEuzuA
   hJyPITKNoU9mmyx06haQFI8B6IMSvHBLgROSDhMLvYc9H53E3gxfPl6VX
   A==;
X-CSE-ConnectionGUID: jK9YjYBWTUWz9gG18ucz0g==
X-CSE-MsgGUID: x8t9as2OQu+Bxoc3RukQew==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74166880"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="74166880"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:38:27 -0700
X-CSE-ConnectionGUID: zv4HsIMeSQa/JSeFH5jq/w==
X-CSE-MsgGUID: 9Re0tlPTTPuR8lcp49lyRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184942610"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 29 Oct 2025 08:38:23 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vE8Fg-000Kjl-0b;
	Wed, 29 Oct 2025 15:38:20 +0000
Date: Wed, 29 Oct 2025 23:35:12 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] virtio_net: fix alignment for virtio_net_hdr_v1_hash
Message-ID: <202510292352.dvaYVyZt-lkp@intel.com>
References: <20251029012434.75576-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029012434.75576-1-jasowang@redhat.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Wang/virtio_net-fix-alignment-for-virtio_net_hdr_v1_hash/20251029-092814
base:   net/main
patch link:    https://lore.kernel.org/r/20251029012434.75576-1-jasowang%40redhat.com
patch subject: [PATCH net] virtio_net: fix alignment for virtio_net_hdr_v1_hash
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251029/202510292352.dvaYVyZt-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510292352.dvaYVyZt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510292352.dvaYVyZt-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/packet/af_packet.c:86:
>> include/linux/virtio_net.h:404:24: error: no member named 'hash_value' in 'struct virtio_net_hdr_v1_hash'
     404 |         vhdr->hash_hdr.hash_value = 0;
         |         ~~~~~~~~~~~~~~ ^
   1 error generated.


vim +404 include/linux/virtio_net.h

a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  376  
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  377  /*
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  378   * vlan_hlen always refers to the outermost MAC header. That also
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  379   * means it refers to the only MAC header, if the packet does not carry
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  380   * any encapsulation.
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  381   */
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  382  static inline int
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  383  virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  384  			    struct virtio_net_hdr_v1_hash_tunnel *vhdr,
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  385  			    bool tnl_hdr_negotiated,
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  386  			    bool little_endian,
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  387  			    int vlan_hlen)
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  388  {
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  389  	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  390  	unsigned int inner_nh, outer_th;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  391  	int tnl_gso_type;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  392  	int ret;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  393  
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  394  	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  395  						    SKB_GSO_UDP_TUNNEL_CSUM);
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  396  	if (!tnl_gso_type)
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  397  		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  398  					       vlan_hlen);
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  399  
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  400  	/* Tunnel support not negotiated but skb ask for it. */
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  401  	if (!tnl_hdr_negotiated)
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  402  		return -EINVAL;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  403  
b2284768c6b32a Jason Wang  2025-10-22 @404          vhdr->hash_hdr.hash_value = 0;
b2284768c6b32a Jason Wang  2025-10-22  405          vhdr->hash_hdr.hash_report = 0;
b2284768c6b32a Jason Wang  2025-10-22  406          vhdr->hash_hdr.padding = 0;
b2284768c6b32a Jason Wang  2025-10-22  407  
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  408  	/* Let the basic parsing deal with plain GSO features. */
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  409  	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  410  	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  411  	skb_shinfo(skb)->gso_type |= tnl_gso_type;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  412  	if (ret)
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  413  		return ret;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  414  
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  415  	if (skb->protocol == htons(ETH_P_IPV6))
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  416  		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  417  	else
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  418  		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  419  
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  420  	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM)
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  421  		hdr->flags |= VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  422  
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  423  	inner_nh = skb->inner_network_header - skb_headroom(skb);
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  424  	outer_th = skb->transport_header - skb_headroom(skb);
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  425  	vhdr->inner_nh_offset = cpu_to_le16(inner_nh);
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  426  	vhdr->outer_th_offset = cpu_to_le16(outer_th);
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  427  	return 0;
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  428  }
a2fb4bc4e2a6a0 Paolo Abeni 2025-07-08  429  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
