Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4C13635F
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058818; cv=none; b=lYaoteLvQk6xsz1JR3lYOSHw+J4JfQ4VO9S6iLtKj2etIaMcM4oOUiJkuBrttLCEuUB2kSwg01NQ9qoiqkyipmCsiXAA/uMG0Kb0olvdNcJ4xGTij1I3mwU+hi7Ks8ONDwXQlKSK3Tjihp1U5fLUKhayI1oCSf/mZ+/Czf8vc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058818; c=relaxed/simple;
	bh=fNEw9q5L02wFt/SbtQ2tsftoa1czNPsPbeHhsyx+RmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJqvnbARlzprxUTQbje/0bMid6tKttmEKTEPD+oJwIKh3aOT9CXY4QzU5BylFOtBgMsTxQJJ7cfd9c9QZwPVnWv11pJ6KjDWonNU1WYPhB8Z/IUg+y+g3rDYSN6OzY4uc/2lE+rz3zfCJ/lgeVuBPJgXqAqULehYtmdTRHN4D0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkbIAJnf; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkbIAJnf"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE5F240C47
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 12:46:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3dgLUucm0Qas for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Sep 2024 12:46:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 19BF640BFF
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19BF640BFF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fkbIAJnf
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 19BF640BFF
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726058815; x=1757594815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fNEw9q5L02wFt/SbtQ2tsftoa1czNPsPbeHhsyx+RmE=;
  b=fkbIAJnfUWXjdhmRXKHp7cbWh6FENEJPFuUQ1HeKwlYj+vPJJftP1teU
   v/SEuoxvucQgVDLOLUTsnTk7mbC1l1ep97phBVFFUcOP9J+zo5xTNuGm+
   lEnQXhty7+qrLmZrQ2oFnU+C5NoxNw+tdJIpSoBt05l8ei+6BJCwlsfOx
   jfc2SLI5ug8U1g36/6qCqpV+pG2ZTLXsPCbR5QeUMDyPh0OCB95hAQFlx
   EgiG+qGXapPlrJh0n8hm6yYFOEqMRUQ3nfNovz9L4xCgeAHk29lvsG5SV
   PgpM3N9gD2c220eTKtcItCrmmGx1IHGdDRZMr/W0G2ctxDTJ2PH4NULpq
   A==;
X-CSE-ConnectionGUID: 85GbhExHQ9CpeHD/VdMA3Q==
X-CSE-MsgGUID: hxBpC197S8yac3fNpD6nQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35447098"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="35447098"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 05:46:53 -0700
X-CSE-ConnectionGUID: 59EqOoXQTnCHSJmxUJHkng==
X-CSE-MsgGUID: lMreyNQYRj2UT0Z0kddTEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="71494827"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Sep 2024 05:46:52 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soMkD-0003ZC-2c;
	Wed, 11 Sep 2024 12:46:49 +0000
Date: Wed, 11 Sep 2024 20:46:19 +0800
From: kernel test robot <lkp@intel.com>
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
	michael.christie@oracle.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 6/7] vhost: Add kthread support in function
 vhost_worker_create
Message-ID: <202409112050.3zbvpbyT-lkp@intel.com>
References: <20240909013531.1243525-7-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909013531.1243525-7-lulu@redhat.com>

Hi Cindy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.11-rc7 next-20240910]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vhost-Add-a-new-module_param-for-enable-kthread/20240909-093852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20240909013531.1243525-7-lulu%40redhat.com
patch subject: [PATCH v1 6/7] vhost: Add kthread support in function vhost_worker_create
config: arc-randconfig-001-20240911 (https://download.01.org/0day-ci/archive/20240911/202409112050.3zbvpbyT-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240911/202409112050.3zbvpbyT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409112050.3zbvpbyT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/vhost/vhost.c: In function 'vhost_worker_queue':
   drivers/vhost/vhost.c:273:13: error: 'use_kthread' undeclared (first use in this function)
     273 |         if (use_kthread) {
         |             ^~~~~~~~~~~
   drivers/vhost/vhost.c:273:13: note: each undeclared identifier is reported only once for each function it appears in
   drivers/vhost/vhost.c: In function 'vhost_workers_free':
   drivers/vhost/vhost.c:805:13: error: 'use_kthread' undeclared (first use in this function)
     805 |         if (use_kthread)
         |             ^~~~~~~~~~~
   drivers/vhost/vhost.c: In function 'vhost_worker_create':
   drivers/vhost/vhost.c:986:13: error: 'use_kthread' undeclared (first use in this function)
     986 |         if (use_kthread)
         |             ^~~~~~~~~~~
   drivers/vhost/vhost.c: In function 'vhost_free_worker':
   drivers/vhost/vhost.c:1030:13: error: 'use_kthread' undeclared (first use in this function)
    1030 |         if (use_kthread)
         |             ^~~~~~~~~~~
   drivers/vhost/vhost.c: In function 'vhost_worker_create':
>> drivers/vhost/vhost.c:990:1: warning: control reaches end of non-void function [-Wreturn-type]
     990 | }
         | ^


vim +990 drivers/vhost/vhost.c

   983	
   984	static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
   985	{
   986		if (use_kthread)
   987			return vhost_worker_create_kthread(dev);
   988		else
   989			return vhost_worker_create_task(dev);
 > 990	}
   991	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
