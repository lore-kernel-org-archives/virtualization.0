Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50F434253C;
	Wed, 28 Jan 2026 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639032; cv=none; b=Gs+TUW4LKwE8Q3oFQ4so/E+ZZQkKwNmFSqcxSBT718Z9RM+3Gsqhv3i7DsmLkVkSD/TIfMOWFI6yJuwjWL4w/LJm1/B8AQB6R7+3TQ4F1QPfWda1Xd2YiKnh6wBdaPv8qJJ9keZkNKOXq/yI7G+YpP9Da/sPFKwkb9q/Vc/oWQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639032; c=relaxed/simple;
	bh=t6rW2qO0poIYghVFawHwv+wpbgTx39bx7DdeIpcQye8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T30cCnx15trHPIPRp5XeeisAeRgb6lOiixpgzAlifnZaz8RXssGEmE9Rj7f14FjGJOvW05Wl7te3TvxlPXQ1XHCaH5hYipIfszMdZRT86PFAhpsP63K0+qKFtH1BlnrYUJu468EHw35ChWkxG9sqyy7ldoes/AXikQw38q0LMHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6EBFORv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6EBFORv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769639031; x=1801175031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t6rW2qO0poIYghVFawHwv+wpbgTx39bx7DdeIpcQye8=;
  b=K6EBFORv+IcdZvyMPNUWTKrq8VTBtR3yHsw2/EWC9y6X1WOEcUlfhVRb
   tCOmaFfwIhVVAJG2xbqVnoa3TaP/ZQ+YC4qe/wDRIqQKTBLNFTYoLRQSy
   6u8s+PtiFgEhuBcKzIp/I0NdtgIWhheM5M5j0gzcMJkBXK/PPqj9wtPmh
   +/lAgZSEpT5AHOJOf9uAo5om6BKH+VGOHukxVoAjanN9HuI8Pvkp5Kpnu
   U1PE9SuWpKCwL2/zz2UeE5KC34BNoB1gWFkJStFxm2yBi2JKd5vBEGrlp
   C7N0m5PBk6jUFPRrM4N3jmgmhjXRTgA9w3TOt6TzHSIG4DOUa2bgpRjPf
   w==;
X-CSE-ConnectionGUID: 0iF3uDD+S+Gx+IeBK3ffew==
X-CSE-MsgGUID: eE7nNWS5RtKN5cKZHAQPrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70904782"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70904782"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:23:51 -0800
X-CSE-ConnectionGUID: eZP5evReRN+db4wyxIrqNA==
X-CSE-MsgGUID: uHlhitT3TSCv3Yy7Ac4ekg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207990109"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 28 Jan 2026 14:23:47 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlDwv-00000000as8-0Tc6;
	Wed, 28 Jan 2026 22:23:45 +0000
Date: Thu, 29 Jan 2026 06:23:20 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/2] virtio: silence KCSAN warning in
 virtqueue_kick_prepare
Message-ID: <202601290632.9LWUgtlM-lkp@intel.com>
References: <20260127152524.200465-3-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127152524.200465-3-johannes.thumshirn@wdc.com>

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.19-rc7]
[cannot apply to mst-vhost/linux-next next-20260127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Thumshirn/virtio-silence-KCSAN-warning-in-virtqueue_get_buf_ctx_split/20260127-235023
base:   linus/master
patch link:    https://lore.kernel.org/r/20260127152524.200465-3-johannes.thumshirn%40wdc.com
patch subject: [PATCH v2 2/2] virtio: silence KCSAN warning in virtqueue_kick_prepare
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260129/202601290632.9LWUgtlM-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260129/202601290632.9LWUgtlM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601290632.9LWUgtlM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/vhost/vringh.c:559:19: error: cannot take the address of an rvalue of type '__virtio16' (aka 'unsigned short')
     559 |                 if (putu16(vrh, &vring_avail_event(&vrh->vring),
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vhost/vringh.c:562:8: error: cannot take the address of an rvalue of type '__virtio16' (aka 'unsigned short')
     562 |                                    &vring_avail_event(&vrh->vring));
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +559 drivers/vhost/vringh.c

f87d0fbb579818 Rusty Russell      2013-03-20  542  
f87d0fbb579818 Rusty Russell      2013-03-20  543  static inline bool __vringh_notify_enable(struct vringh *vrh,
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  544  					  int (*getu16)(const struct vringh *vrh,
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  545  							u16 *val, const __virtio16 *p),
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  546  					  int (*putu16)(const struct vringh *vrh,
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  547  							__virtio16 *p, u16 val))
f87d0fbb579818 Rusty Russell      2013-03-20  548  {
f87d0fbb579818 Rusty Russell      2013-03-20  549  	u16 avail;
f87d0fbb579818 Rusty Russell      2013-03-20  550  
f87d0fbb579818 Rusty Russell      2013-03-20  551  	if (!vrh->event_indices) {
f87d0fbb579818 Rusty Russell      2013-03-20  552  		/* Old-school; update flags. */
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  553  		if (putu16(vrh, &vrh->vring.used->flags, 0) != 0) {
f87d0fbb579818 Rusty Russell      2013-03-20  554  			vringh_bad("Clearing used flags %p",
f87d0fbb579818 Rusty Russell      2013-03-20  555  				   &vrh->vring.used->flags);
f87d0fbb579818 Rusty Russell      2013-03-20  556  			return true;
f87d0fbb579818 Rusty Russell      2013-03-20  557  		}
f87d0fbb579818 Rusty Russell      2013-03-20  558  	} else {
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12 @559  		if (putu16(vrh, &vring_avail_event(&vrh->vring),
f87d0fbb579818 Rusty Russell      2013-03-20  560  			   vrh->last_avail_idx) != 0) {
f87d0fbb579818 Rusty Russell      2013-03-20  561  			vringh_bad("Updating avail event index %p",
f87d0fbb579818 Rusty Russell      2013-03-20  562  				   &vring_avail_event(&vrh->vring));
f87d0fbb579818 Rusty Russell      2013-03-20  563  			return true;
f87d0fbb579818 Rusty Russell      2013-03-20  564  		}
f87d0fbb579818 Rusty Russell      2013-03-20  565  	}
f87d0fbb579818 Rusty Russell      2013-03-20  566  
f87d0fbb579818 Rusty Russell      2013-03-20  567  	/* They could have slipped one in as we were doing that: make
f87d0fbb579818 Rusty Russell      2013-03-20  568  	 * sure it's written, then check again. */
f87d0fbb579818 Rusty Russell      2013-03-20  569  	virtio_mb(vrh->weak_barriers);
f87d0fbb579818 Rusty Russell      2013-03-20  570  
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  571  	if (getu16(vrh, &avail, &vrh->vring.avail->idx) != 0) {
f87d0fbb579818 Rusty Russell      2013-03-20  572  		vringh_bad("Failed to check avail idx at %p",
f87d0fbb579818 Rusty Russell      2013-03-20  573  			   &vrh->vring.avail->idx);
f87d0fbb579818 Rusty Russell      2013-03-20  574  		return true;
f87d0fbb579818 Rusty Russell      2013-03-20  575  	}
f87d0fbb579818 Rusty Russell      2013-03-20  576  
f87d0fbb579818 Rusty Russell      2013-03-20  577  	/* This is unlikely, so we just leave notifications enabled
f87d0fbb579818 Rusty Russell      2013-03-20  578  	 * (if we're using event_indices, we'll only get one
f87d0fbb579818 Rusty Russell      2013-03-20  579  	 * notification anyway). */
f87d0fbb579818 Rusty Russell      2013-03-20  580  	return avail == vrh->last_avail_idx;
f87d0fbb579818 Rusty Russell      2013-03-20  581  }
f87d0fbb579818 Rusty Russell      2013-03-20  582  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
