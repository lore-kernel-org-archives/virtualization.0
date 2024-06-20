Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46BD3BBED;
	Thu, 20 Jun 2024 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865642; cv=none; b=B7Ry/Z895klbEdqtYkIXKmkpiaylGjlY+riZGtCBllTGeomVeiKW/7+rYX0nOhrpWOm0QkPcQEaOHagADdop2yZ4FhkkU0D2e9nE3D0j/zS/RWmqhE7O7jlR7kQUD9qHgacfHOTdEqc1qph88JJ99s/pHmLxtTLtE+7G7G+ZqGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865642; c=relaxed/simple;
	bh=HGIUdK74KQ1gCGAEZoHH0bCMvkFSbrAsO+df+QMfBiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asoKvzqgSjFHLsam1b9ejkbEwLL4wBT9LNxdjXV/3IeCyIYy80Fcz8xTn0hHSyi2zQuw3IuXVmuTltJoBtZKDHCdiZPinFmNn1e6xz1Eka3zpKvt5glm54FkfMnFgE/3lrXmOvAJzP933mj0N7fb/e8cWuCd0hsMiAoNJyVOfxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BtUez9R3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtUez9R3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718865641; x=1750401641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HGIUdK74KQ1gCGAEZoHH0bCMvkFSbrAsO+df+QMfBiY=;
  b=BtUez9R3ehJLcRXUqawo8HmD9AKuJBBDQDoCXfhk4E8r6XWIDb4m4USy
   vCJIpWaU/1zCVAehamvzM2SIHC+Wp1kEHjfJcQockhWRxIZsrx64dJbjy
   l7xqOmy09Mhy+AKYl2h68D4wFLcKYNtJvQ+n8aRwYlio/+eNY+HjugYu1
   D19DyCeh7zm8+yBQJdBvC2gVF5r6UaEZD0NfzyfK2ckUCAUYfqH5IbQ+1
   p8UGFneaGxKby9joLMKPebS8h7ZNyKbAW+7YXroThEvh9HH5nM1ceROdm
   iFEflDoM2TlEpEYSGHSbvnvIlr7SP/GY34KD/SY3IAwNBg8K1jfcaVyEi
   A==;
X-CSE-ConnectionGUID: 3oNwF0W6SxudMQL54H4V1g==
X-CSE-MsgGUID: 4fafvWc6ROazDwrCDAqqhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15962744"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15962744"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 23:40:39 -0700
X-CSE-ConnectionGUID: pyan0ASjQpC+QPVR7chFXg==
X-CSE-MsgGUID: jRYMQxTHQ3qD3wFmesO+1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="79615107"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Jun 2024 23:40:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKBTG-0007Oe-1Q;
	Thu, 20 Jun 2024 06:40:34 +0000
Date: Thu, 20 Jun 2024 14:40:03 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 5/5] virtio_net: improve dim command request
 efficiency
Message-ID: <202406201437.JuUEpbZL-lkp@intel.com>
References: <20240619161908.82348-6-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619161908.82348-6-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/virtio_net-passing-control_buf-explicitly/20240620-002212
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240619161908.82348-6-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v4 5/5] virtio_net: improve dim command request efficiency
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240620/202406201437.JuUEpbZL-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406201437.JuUEpbZL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406201437.JuUEpbZL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/virtio_net.c: In function 'virtnet_wait_command_response':
>> drivers/net/virtio_net.c:2771:22: warning: unused variable 'tmp' [-Wunused-variable]
    2771 |         unsigned int tmp;
         |                      ^~~


vim +/tmp +2771 drivers/net/virtio_net.c

2bef89a476bb44 Heng Qi   2024-06-20  2767  
2bef89a476bb44 Heng Qi   2024-06-20  2768  static bool virtnet_wait_command_response(struct virtnet_info *vi,
2bef89a476bb44 Heng Qi   2024-06-20  2769  					  struct control_buf *ctrl)
2bef89a476bb44 Heng Qi   2024-06-20  2770  {
2bef89a476bb44 Heng Qi   2024-06-20 @2771  	unsigned int tmp;
2bef89a476bb44 Heng Qi   2024-06-20  2772  	bool ok;
40cbfc37075a2a Amos Kong 2013-01-21  2773  
ff0de8d3002c75 Heng Qi   2024-06-20  2774  	wait_for_completion(&ctrl->completion);
40cbfc37075a2a Amos Kong 2013-01-21  2775  
74b2bc860d5cb5 Heng Qi   2024-06-20  2776  	ok = ctrl->status == VIRTIO_NET_OK;
30636258a7c917 Heng Qi   2024-05-30  2777  	return ok;
40cbfc37075a2a Amos Kong 2013-01-21  2778  }
40cbfc37075a2a Amos Kong 2013-01-21  2779  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
