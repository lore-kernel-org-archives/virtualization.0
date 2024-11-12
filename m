Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E79A21A6F3;
	Tue, 12 Nov 2024 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731449309; cv=none; b=eHKKPYRE3rFzx+538M79rTT79BaFOVUbbEdCuDJe36hyP6g5GkaNj3llwcARqyf+R9MTCGhJg0s0JGajKiEy+EWqvJkBQeEHo9VySJpgnVfgxjL7OLFIBR1c4t6IGJuWXW+i5VbhWfJsw0PRbj8tO0MNGzW33Z3GhsL8+yWgFh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731449309; c=relaxed/simple;
	bh=bwOLoyFxYfjUqtJNi/9ZCqz09dTnm3t/9bGtqoLlI8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKHQfcGLgRyBxi1H+LMZzAaZzRLPQuqMv9nj0jGyc1fPaW298/9lKcMiz0ugYrRvDTgNZJj5Ix4XaprLMBhbbzUz93aVgYRwjPUn+M+GTL7m9XXFYvnpI9fY13yzKblwBUI7FPOGpGBBMGsVy9fFd5K9dXlcLzqNQGy/zdP0NBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBWf8euF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBWf8euF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731449307; x=1762985307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bwOLoyFxYfjUqtJNi/9ZCqz09dTnm3t/9bGtqoLlI8U=;
  b=aBWf8euFQz8tfOd07uClcsqePuVHvR7//RFIYqYdqHUfxJN+3ngwCqOO
   HiPkYMaZHRrVrcLG5swxtVxM9KEy4Rksrm2QHSkIZOdfC8+BrANHQ/DQq
   E1OHqCWHMly1prxt0ZtMsiWFeRr3w/0Bi5IU7M6lwuwNASdD/QjGOKzgg
   SRxV824CddIQa/tE6/rovl+O0mhCVzXl/Cu0pR9ONuQu+yAOZGtep/XxC
   Cc8oBanvcD69QJzgstIPFcT50XKI3qKkiwm64+OIG8Ctq9jWyTeloBV2+
   nhUnn7QS9+OVw4k/PPnLVGpOxXP+eKCd1pCP2tBMiqGO7Pv9b9Hch+4Oz
   g==;
X-CSE-ConnectionGUID: CkVMRlVVSLOkf34HiCUurQ==
X-CSE-MsgGUID: RcUYskraTk6+oAX3OALa5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42722544"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="42722544"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 14:08:27 -0800
X-CSE-ConnectionGUID: QGh9vjHLSpKorf74bKXSXg==
X-CSE-MsgGUID: sKP0TcqbSXmgHwe8OkVCnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="91712794"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 Nov 2024 14:08:16 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAz3W-0001lf-1j;
	Tue, 12 Nov 2024 22:08:14 +0000
Date: Wed, 13 Nov 2024 06:07:51 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v3 3/8] virtio: hookup irq_get_affinity callback
Message-ID: <202411130521.UOBdW8Rv-lkp@intel.com>
References: <20241112-refactor-blk-affinity-helpers-v3-3-573bfca0cbd8@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-3-573bfca0cbd8@kernel.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c9af98a7e8af266bae73e9d662b8341da1ec5824]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/driver-core-bus-add-irq_get_affinity-callback-to-bus_type/20241112-213257
base:   c9af98a7e8af266bae73e9d662b8341da1ec5824
patch link:    https://lore.kernel.org/r/20241112-refactor-blk-affinity-helpers-v3-3-573bfca0cbd8%40kernel.org
patch subject: [PATCH v3 3/8] virtio: hookup irq_get_affinity callback
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241113/202411130521.UOBdW8Rv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241113/202411130521.UOBdW8Rv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411130521.UOBdW8Rv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/virtio/virtio.c:389: warning: Function parameter or struct member 'irq_veq' not described in 'virtio_irq_get_affinity'
>> drivers/virtio/virtio.c:389: warning: Excess function parameter 'irq_vec' description in 'virtio_irq_get_affinity'


vim +389 drivers/virtio/virtio.c

   379	
   380	/**
   381	 * virtio_irq_get_affinity - get IRQ affinity mask for device
   382	 * @_d: ptr to dev structure
   383	 * @irq_vec: interrupt vector number
   384	 *
   385	 * Return the CPU affinity mask for @_d and @irq_vec.
   386	 */
   387	static const struct cpumask *virtio_irq_get_affinity(struct device *_d,
   388							     unsigned int irq_veq)
 > 389	{
   390		struct virtio_device *dev = dev_to_virtio(_d);
   391	
   392		if (!dev->config->get_vq_affinity)
   393			return NULL;
   394	
   395		return dev->config->get_vq_affinity(dev, irq_veq);
   396	}
   397	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
