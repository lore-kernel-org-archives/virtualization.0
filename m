Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED5022655B;
	Tue, 23 Sep 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636889; cv=none; b=TM3xNs9x3PLOP5/1Vg/gaE1b9C6KdJsfSc/TDXiITz2VXNMcv7NPh9GSSErQrjCbJmYAnwYeS6jEIX0ZyXa48/4FFhoUkUNmYg25AYgnyxSjjrakSp2cPsnHyibr3ytfWT1d+31pWG9xPU1k+Fh5qcZUIz1DwfDAlHxJs5nsorU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636889; c=relaxed/simple;
	bh=+H9zJ9ZnJh5XdjSEpBwdWNCOzZuIf/K/RLNBOxUxrx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGjOK7qBEUQmL/d7lEfcENrLE3qLzFvAIgU8SACxlf9OTTwJpAtfoXR7hAoM04T3VjjllRhn3xFRrA4wNydOFcSRj5zwVCFL0wlbRlpqVy3yfY49pK6GCECHk63ZsVETE6g6Z76Xf9pX+THIcmFBT52nWv626sCGT4dYmAQ1BJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d85YoT02; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d85YoT02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758636888; x=1790172888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+H9zJ9ZnJh5XdjSEpBwdWNCOzZuIf/K/RLNBOxUxrx0=;
  b=d85YoT02i3mEpfgiZBwZwIKEKdpmDoY08+8WggDX1ZBnnntu/R9o5Vvc
   jPUTR+EAJHnSu46MNbqnet4vwz0XWdkGSMo0KwfdEl8teMjIyPzuxrqo7
   hfmLpA9dAyB6i50kW29soBfjKo4hVByupzUAMzl2jMLHBBwEbNNJHP9XQ
   mCWwaZIlxeR8HoLBd4qNTi1CIBTACpOFCD8ZZGuvknfHXdjnYsAO0422j
   9N99MRvOSCT9fL80CObgHKgXoB7LNyGKXnY1otevkFgp/gcs9aMe/MdZo
   n516y7pQc1d0yU+GBOAN+0KuAMfX6qliodiTY/Os2ueBoMZXt9VWq6h53
   g==;
X-CSE-ConnectionGUID: vIKmuXq9TQSsaoVyzNUNBg==
X-CSE-MsgGUID: 0PlinG7RTNqYDtkKtsiyuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86353230"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="86353230"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 07:14:21 -0700
X-CSE-ConnectionGUID: hi4LmZPgTA2uLR2Pk1F+Zg==
X-CSE-MsgGUID: h4fxs8c9Q++r6fENoG5wpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="176369709"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 23 Sep 2025 07:14:18 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v13ma-0003Av-0n;
	Tue, 23 Sep 2025 14:14:16 +0000
Date: Tue, 23 Sep 2025 22:14:05 +0800
From: kernel test robot <lkp@intel.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	mst@redhat.com, eperezma@redhat.com, stephen@networkplumber.org,
	leiyang@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Simon Schippers <simon.schippers@tu-dortmund.de>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net-next v5 8/8] vhost_net: Replace rx_ring with calls of
 TUN/TAP wrappers
Message-ID: <202509232113.Z0qRJQHs-lkp@intel.com>
References: <20250922221553.47802-9-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922221553.47802-9-simon.schippers@tu-dortmund.de>

Hi Simon,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Simon-Schippers/__ptr_ring_full_next-Returns-if-ring-will-be-full-after-next-insertion/20250923-062130
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250922221553.47802-9-simon.schippers%40tu-dortmund.de
patch subject: [PATCH net-next v5 8/8] vhost_net: Replace rx_ring with calls of TUN/TAP wrappers
config: i386-buildonly-randconfig-003-20250923 (https://download.01.org/0day-ci/archive/20250923/202509232113.Z0qRJQHs-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250923/202509232113.Z0qRJQHs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509232113.Z0qRJQHs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/vhost/net.c:197:3: error: expected expression
     197 |                 WARN_ON_ONCE();
         |                 ^
   include/asm-generic/bug.h:111:34: note: expanded from macro 'WARN_ON_ONCE'
     111 |         int __ret_warn_on = !!(condition);                      \
         |                                         ^
   1 error generated.


vim +197 drivers/vhost/net.c

   178	
   179	static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq,
   180			struct sock *sk)
   181	{
   182		struct file *file = sk->sk_socket->file;
   183		struct vhost_net_buf *rxq = &nvq->rxq;
   184	
   185		rxq->head = 0;
   186	
   187		switch (nvq->type) {
   188		case TUN:
   189			rxq->tail = tun_ring_consume_batched(file,
   190					rxq->queue, VHOST_NET_BATCH);
   191			break;
   192		case TAP:
   193			rxq->tail = tap_ring_consume_batched(file,
   194					rxq->queue, VHOST_NET_BATCH);
   195			break;
   196		case IF_NONE:
 > 197			WARN_ON_ONCE();
   198		}
   199	
   200		return rxq->tail;
   201	}
   202	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
