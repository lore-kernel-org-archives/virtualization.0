Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51DD35B63D;
	Thu, 12 Mar 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325782; cv=none; b=GAmdbDykb4+rKPfBOUi49Sytm4935mRt8Ml2U7qOWBO2Ew9NNJpPPn0OW583ghGVRYRd4aWSr2HAoYMlVuolr3rw0R88EqYkHN9sxpzXG/JUC+CB+Co6iiOB9F90yIULgTxN+x2k0qAaGtLskwny2KIBroX5ZOdKdFMIxPRjaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325782; c=relaxed/simple;
	bh=Y0+sYgTWA2dV+l0uHQP9RWviBqnC7bXHitpIc8NuJ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dl0qjPAkoxrcUDBVuYUGUyhsBMlifP57EjylIsuDk1z1i0NwbMPERqQt4WJ8/28SH3Pjmu+TgBjDyIO5OhY06khTnOSyWOtzLUWlgpTuQI5JnwEIO3pD/VFxlrCqAEKsBGGVpcJNjyLYtyzp3jdvvKQMLQlS7mdPI9YzE5OWO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+Y9EVw/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+Y9EVw/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773325781; x=1804861781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y0+sYgTWA2dV+l0uHQP9RWviBqnC7bXHitpIc8NuJ/w=;
  b=Q+Y9EVw/oq05E5CFLpe6VERnWbt7eB5WImpbstuGsxwTARTwdpaBD9to
   FeXqr8pdvfNHg754dfOPOpVitHqEf4+LWAkMnTGuUXEcDvEFDXEam0dFb
   lugFC954R7mL9oSGwbGthUHlP36/sDOSWijJ+kXNdNqHgJMvDbTLDdECq
   7Zn+jxfwgUk9Ch/C8S8hrGlUiWb8WlEs5pHSjIqJRuwsM97AjgsoIl6jb
   3kUMFVYyBR3YdDyZEzgHRTy1N8eJfmo2LQps48LTNF+xokfqxaZeP23k0
   gb8kiS/ThAu/oP4UHC19Ng6qmZR/V46/2RLuVFSaJLBe0/Z56k3qbbJsz
   g==;
X-CSE-ConnectionGUID: gcyCoLrES+6YoG6vPVF19A==
X-CSE-MsgGUID: qXqTwYjDS4uO2KTdz54ejw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85773967"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85773967"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:29:40 -0700
X-CSE-ConnectionGUID: ISAwfUKDQKmCZFh6mr3uqg==
X-CSE-MsgGUID: mm9DTY2bRh+1JemURCzhvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="218641907"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 Mar 2026 07:29:37 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0h2c-000000002Yh-1IpV;
	Thu, 12 Mar 2026 14:29:34 +0000
Date: Thu, 12 Mar 2026 22:28:34 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v9 2/2] virtio-net: correct hdr_len handling for
 tunnel gso
Message-ID: <202603122214.8Anoxrmq-lkp@intel.com>
References: <20260311115414.31243-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311115414.31243-3-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio-net-correct-hdr_len-handling-for-VIRTIO_NET_F_GUEST_HDRLEN/20260311-200042
base:   net/main
patch link:    https://lore.kernel.org/r/20260311115414.31243-3-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH net v9 2/2] virtio-net: correct hdr_len handling for tunnel gso
config: i386-randconfig-061-20260312 (https://download.01.org/0day-ci/archive/20260312/202603122214.8Anoxrmq-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260312/202603122214.8Anoxrmq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603122214.8Anoxrmq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/virtio_net.c: note: in included file:
>> include/linux/virtio_net.h:238:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __virtio16 [usertype] hdr_len @@     got restricted __le16 [usertype] @@
   include/linux/virtio_net.h:238:22: sparse:     expected restricted __virtio16 [usertype] hdr_len
   include/linux/virtio_net.h:238:22: sparse:     got restricted __le16 [usertype]

vim +238 include/linux/virtio_net.h

   225	
   226	static inline void virtio_net_set_tnl_hdrlen(const struct sk_buff *skb,
   227						     struct virtio_net_hdr *hdr)
   228	{
   229		u16 hdr_len;
   230	
   231		hdr_len = skb_inner_transport_offset(skb);
   232	
   233		if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
   234			hdr_len += sizeof(struct udphdr);
   235		else
   236			hdr_len += inner_tcp_hdrlen(skb);
   237	
 > 238		hdr->hdr_len = cpu_to_le16(hdr_len);
   239	}
   240	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
