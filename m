Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258434DCD6;
	Wed, 28 Jan 2026 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603320; cv=none; b=lZ3hKFSxWMhRzQ9J6fyKQxnKwCOHGrHjgeecSTe/0mJyCy66Egl3CEZZ30Gvq5iF3yKE9dWWKvBn3FOqUKl/EVJbaz8F9ZCDGWQoxEiKiZRUfe76hkmh9nGkz0ev7jcq+GjeoVU2sJLXRNbfybsTAAdDxDldlwaHWeDknD3VtN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603320; c=relaxed/simple;
	bh=A7Xw0tl1xzvmygvyEFGIONlF/sa0tWcj9BxvNn4CISY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKYSrCnNQKfKZ91i/FuLp02sMGVHwUTWdO+7Gy7u1AR82kVmQTIMEgjftXl04X410pSsl86x7QKyzmSiPYOilpaz9RsPSiWbcm2yt1lPMOZPxt59ZMR8zvecFeD3j6vIGA8qi39SRbExWLZex0z6F8fKoyYYazyDEKSsHoJy6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvXN+gD/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvXN+gD/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769603319; x=1801139319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A7Xw0tl1xzvmygvyEFGIONlF/sa0tWcj9BxvNn4CISY=;
  b=CvXN+gD/HhLHT0VJlGW1rpq8VMuiPcLAVKL2ihNMjWZ/iQJhvvTp0hO9
   nILqkmPjQWY9I38M4r6yLuVQNAWq+U5yUzUSUjVkZb7Aq0nTPW2IBkZNw
   SrjxtVq6low0b7xRtObT7Mpc+wqwosIeaZ1KOqBEIWOhVe26PWDGfTyaL
   8EZc9kXeMcLVOm9tlej5kEbJo280fyBpxFy5Fjp54EXlpcfMagvDRKczb
   7bJJpd2aKhPfSE171YCMfTSrQH3tzKDmL8cv7lKIC47t5CE8CaikMNVvf
   a8PMc0DHleBk20t5OeaGxk8nhoLloyCORN7yroGe5BTfQUCYPC7joOJ7S
   w==;
X-CSE-ConnectionGUID: 5qS8BSSrQUqMUihDrhGTJQ==
X-CSE-MsgGUID: toFlbRRFThuVHvBXjuojNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="73407355"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="73407355"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 04:28:39 -0800
X-CSE-ConnectionGUID: qRthnxTDQ1KkXhPW5rH37g==
X-CSE-MsgGUID: eOk+ZaU3Q4GqI+WjpEs3gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207388586"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 28 Jan 2026 04:28:36 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vl4ev-00000000Zea-0ay7;
	Wed, 28 Jan 2026 12:28:33 +0000
Date: Wed, 28 Jan 2026 20:28:30 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/2] virtio: silence KCSAN warning in
 virtqueue_kick_prepare
Message-ID: <202601282030.CWdibo9B-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260128/202601282030.CWdibo9B-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260128/202601282030.CWdibo9B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601282030.CWdibo9B-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/vhost/vringh.c: In function '__vringh_notify_enable':
>> drivers/vhost/vringh.c:559:33: error: lvalue required as unary '&' operand
     559 |                 if (putu16(vrh, &vring_avail_event(&vrh->vring),
         |                                 ^
   drivers/vhost/vringh.c:562:36: error: lvalue required as unary '&' operand
     562 |                                    &vring_avail_event(&vrh->vring));
         |                                    ^


vim +559 drivers/vhost/vringh.c

f87d0fbb579818f Rusty Russell      2013-03-20  542  
f87d0fbb579818f Rusty Russell      2013-03-20  543  static inline bool __vringh_notify_enable(struct vringh *vrh,
b9f7ac8c72894c1 Michael S. Tsirkin 2014-12-12  544  					  int (*getu16)(const struct vringh *vrh,
b9f7ac8c72894c1 Michael S. Tsirkin 2014-12-12  545  							u16 *val, const __virtio16 *p),
b9f7ac8c72894c1 Michael S. Tsirkin 2014-12-12  546  					  int (*putu16)(const struct vringh *vrh,
b9f7ac8c72894c1 Michael S. Tsirkin 2014-12-12  547  							__virtio16 *p, u16 val))
f87d0fbb579818f Rusty Russell      2013-03-20  548  {
f87d0fbb579818f Rusty Russell      2013-03-20  549  	u16 avail;
f87d0fbb579818f Rusty Russell      2013-03-20  550  
f87d0fbb579818f Rusty Russell      2013-03-20  551  	if (!vrh->event_indices) {
f87d0fbb579818f Rusty Russell      2013-03-20  552  		/* Old-school; update flags. */
b9f7ac8c72894c1 Michael S. Tsirkin 2014-12-12  553  		if (putu16(vrh, &vrh->vring.used->flags, 0) != 0) {
f87d0fbb579818f Rusty Russell      2013-03-20  554  			vringh_bad("Clearing used flags %p",
f87d0fbb579818f Rusty Russell      2013-03-20  555  				   &vrh->vring.used->flags);
f87d0fbb579818f Rusty Russell      2013-03-20  556  			return true;
f87d0fbb579818f Rusty Russell      2013-03-20  557  		}
f87d0fbb579818f Rusty Russell      2013-03-20  558  	} else {
b9f7ac8c72894c1 Michael S. Tsirkin 2014-12-12 @559  		if (putu16(vrh, &vring_avail_event(&vrh->vring),
f87d0fbb579818f Rusty Russell      2013-03-20  560  			   vrh->last_avail_idx) != 0) {
f87d0fbb579818f Rusty Russell      2013-03-20  561  			vringh_bad("Updating avail event index %p",
f87d0fbb579818f Rusty Russell      2013-03-20  562  				   &vring_avail_event(&vrh->vring));
f87d0fbb579818f Rusty Russell      2013-03-20  563  			return true;
f87d0fbb579818f Rusty Russell      2013-03-20  564  		}
f87d0fbb579818f Rusty Russell      2013-03-20  565  	}
f87d0fbb579818f Rusty Russell      2013-03-20  566  
f87d0fbb579818f Rusty Russell      2013-03-20  567  	/* They could have slipped one in as we were doing that: make
f87d0fbb579818f Rusty Russell      2013-03-20  568  	 * sure it's written, then check again. */
f87d0fbb579818f Rusty Russell      2013-03-20  569  	virtio_mb(vrh->weak_barriers);
f87d0fbb579818f Rusty Russell      2013-03-20  570  
b9f7ac8c72894c1 Michael S. Tsirkin 2014-12-12  571  	if (getu16(vrh, &avail, &vrh->vring.avail->idx) != 0) {
f87d0fbb579818f Rusty Russell      2013-03-20  572  		vringh_bad("Failed to check avail idx at %p",
f87d0fbb579818f Rusty Russell      2013-03-20  573  			   &vrh->vring.avail->idx);
f87d0fbb579818f Rusty Russell      2013-03-20  574  		return true;
f87d0fbb579818f Rusty Russell      2013-03-20  575  	}
f87d0fbb579818f Rusty Russell      2013-03-20  576  
f87d0fbb579818f Rusty Russell      2013-03-20  577  	/* This is unlikely, so we just leave notifications enabled
f87d0fbb579818f Rusty Russell      2013-03-20  578  	 * (if we're using event_indices, we'll only get one
f87d0fbb579818f Rusty Russell      2013-03-20  579  	 * notification anyway). */
f87d0fbb579818f Rusty Russell      2013-03-20  580  	return avail == vrh->last_avail_idx;
f87d0fbb579818f Rusty Russell      2013-03-20  581  }
f87d0fbb579818f Rusty Russell      2013-03-20  582  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
