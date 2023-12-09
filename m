Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0410F6
	for <virtualization@lists.linux-foundation.org>; Sat,  9 Dec 2023 03:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngNQEzPN"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C5FA428D5
	for <virtualization@lists.linux-foundation.org>; Sat,  9 Dec 2023 03:30:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C5FA428D5
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ngNQEzPN
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ejbXcPr9wlNu
	for <virtualization@lists.linux-foundation.org>;
	Sat,  9 Dec 2023 03:30:02 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.37 at util1.osuosl.org; Sat, 09 Dec 2023 03:30:02 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 76EC4428D4
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 76EC4428D4
	for <virtualization@lists.linux-foundation.org>; Sat,  9 Dec 2023 03:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702092602; x=1733628602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FB550rS7SzktM31mvewWBadcGwe+2j2mfx8+REMTGMI=;
  b=ngNQEzPNjs+Mln30+p5rpg/ZisBrAqPVT4e9/Lj5X1xhmMkO/vrX2zO4
   jYxHbgV5iDo1luEF0g/j8UdKzci5aJ959lmfjikbQSOhDHyhoHMZOeK48
   8BxKmoONbuyyd+XwFwlkzoW96yxM/DT5E/IpO3j86tPbDKy5hlLs+nF+M
   Xo6PIDbqApebKcUTpWTGNcW7O/X147fkeIRmA10SXlQIDfc5xFUu/X2Sh
   GQa4F44kZezEYUOsKcHI007kqAqLVkGqndP9azaDYd30KZzu07Qx7jFnY
   VD4XaKuo1wBQp/Gcg7gvdjqUwqNPfgM4/n5w4a0Uz04o0z3evZ/JNyGx2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1310536"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="1310536"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 19:22:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1103780107"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="1103780107"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Dec 2023 19:22:49 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBnvS-000El6-0P;
	Sat, 09 Dec 2023 03:22:46 +0000
Date: Sat, 9 Dec 2023 11:22:11 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, jasowang@redhat.com, mst@redhat.com,
	pabeni@redhat.com, kuba@kernel.org, yinjun.zhang@corigine.com,
	edumazet@google.com, davem@davemloft.net, hawk@kernel.org,
	john.fastabend@gmail.com, ast@kernel.org, horms@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v7 4/4] virtio-net: support rx netdim
Message-ID: <202312091132.7eR6Cbs9-lkp@intel.com>
References: <9be20d1e86bea91b373f28401a96401b640ef4d1.1701929854.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9be20d1e86bea91b373f28401a96401b640ef4d1.1701929854.git.hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/virtio-net-returns-whether-napi-is-complete/20231207-143044
base:   net-next/main
patch link:    https://lore.kernel.org/r/9be20d1e86bea91b373f28401a96401b640ef4d1.1701929854.git.hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v7 4/4] virtio-net: support rx netdim
config: nios2-randconfig-r064-20231209 (https://download.01.org/0day-ci/archive/20231209/202312091132.7eR6Cbs9-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091132.7eR6Cbs9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312091132.7eR6Cbs9-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/net/virtio_net.o: in function `virtnet_rx_dim_work':
   virtio_net.c:(.text+0x21dc): undefined reference to `net_dim_get_rx_moderation'
>> virtio_net.c:(.text+0x21dc): relocation truncated to fit: R_NIOS2_CALL26 against `net_dim_get_rx_moderation'
   nios2-linux-ld: drivers/net/virtio_net.o: in function `virtnet_poll':
   virtio_net.c:(.text+0x97bc): undefined reference to `net_dim'
>> virtio_net.c:(.text+0x97bc): relocation truncated to fit: R_NIOS2_CALL26 against `net_dim'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
