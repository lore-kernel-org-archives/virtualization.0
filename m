Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F27A1922EF;
	Wed, 29 Jan 2025 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135536; cv=none; b=IzD8xn3cmKFKMTYug41RlvwfAh2o1R4vQiIkqZA+oSaAKL0EwB7M9s5KL5gQbA8cNOqaAhjICs8TJwXKGTudnNVrqtVT+Lo3DbrnvIZkwcJL+7U+LTyIU4BlH5lrw0rp6/VJiNA5IQsq055IxliSK9uo30m52w0tfh0LAsvbzSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135536; c=relaxed/simple;
	bh=4JhhaiOSfKv/9QtoX0GXdIoRjRjs5CHPfXgA4e217p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRbibFD1Znl5JNpUX3fuq72EOeOvEK2H6htW8YaCx6j6s1fNZvrNcmR5Ru+rCllXkku1V3G7ndUIZ5dKIkXZgzdwQKEo9vf7eTv8EwcHnUcY2DIFbh6fK/6DQkZA0xN3vnIMRhKkb3BU68qK/QkR76xPoteU7R1FKJv+TgK3rBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+jlZ4/D; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+jlZ4/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738135533; x=1769671533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4JhhaiOSfKv/9QtoX0GXdIoRjRjs5CHPfXgA4e217p8=;
  b=J+jlZ4/DJAxZ4vYycJtT3pSTuOx3jTYGNOev7ij9keBmOFqs2RY0yBv2
   hVFn0bJJWxJTx/HhTwxF52YidnJmeuWKjOVZ88YgrK0PZXkML3y5Z97BK
   WWyGSliZNv1Lz02zG36FIvbxYJdKGPO1/jUXkhHgcwWfb+I/p4o3GNhRJ
   V5n2bTAtnrt/F2xRRE/mEDdmxV2Qp3Dp1tonK77Zgvsl/sp2Jy5bo27GJ
   PwJ6xBOnDLJ7U7uDcVmuM982zgJP9EFTEKRoPS86FjA6iL65zb25nuzUI
   fMeeB4q1yXzmkP2lqszi+/m30W8KRyNAFNqsfwtJXYzYl07josJ2XV62J
   w==;
X-CSE-ConnectionGUID: JcAqf9KNSLihuvBHhO+idg==
X-CSE-MsgGUID: TDAo93dSSKKbNi0FhCNW/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="49226123"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="49226123"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 23:25:32 -0800
X-CSE-ConnectionGUID: o78LRIskTwG0lZYErfUPjA==
X-CSE-MsgGUID: 7UJgoUlrQp2D2BjBlFvbYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="139845463"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Jan 2025 23:25:28 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1td2Ry-000iil-1L;
	Wed, 29 Jan 2025 07:25:26 +0000
Date: Wed, 29 Jan 2025 15:24:55 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Courbot <gnurou@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Albert Esteve <aesteve@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	gurchetansingh@google.com, daniel.almeida@collabora.com,
	changyeon@google.com, nicolas.dufresne@collabora.com,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Alexandre Courbot <acourbot@google.com>
Subject: Re: [PATCH] media: add virtio-media driver
Message-ID: <202501291558.lEyjPgBm-lkp@intel.com>
References: <20250123-virtio-media-v1-1-81e2549b86b9@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123-virtio-media-v1-1-81e2549b86b9@gmail.com>

Hi Alexandre,

kernel test robot noticed the following build errors:

[auto build test ERROR on ffd294d346d185b70e28b1a28abe367bbfe53c04]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Courbot/media-add-virtio-media-driver/20250123-085559
base:   ffd294d346d185b70e28b1a28abe367bbfe53c04
patch link:    https://lore.kernel.org/r/20250123-virtio-media-v1-1-81e2549b86b9%40gmail.com
patch subject: [PATCH] media: add virtio-media driver
config: x86_64-randconfig-r071-20250126 (https://download.01.org/0day-ci/archive/20250129/202501291558.lEyjPgBm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250129/202501291558.lEyjPgBm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501291558.lEyjPgBm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld: drivers/staging/gpib/agilent_82350b/agilent_82350b.o:drivers/staging/gpib/agilent_82350b/agilent_82350b.c:306: multiple definition of `driver_name'; drivers/media/virtio/virtio_media_driver.o:drivers/media/virtio/virtio_media_driver.c:50: first defined here

smatch warnings:
drivers/media/virtio/virtio_media_driver.c:896 virtio_media_probe() warn: missing unwind goto?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
