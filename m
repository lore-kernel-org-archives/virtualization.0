Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E31D86C4;
	Mon,  2 Dec 2024 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142059; cv=none; b=GP5F8YL0mp2VaBTnutp6+IN1g8V2V05vQirxb4bk6tpeJhIgtpTg5PQ5zAX5foL6bXnSO/CJwT1qOxtrlfJpZOpGhr9RL/KjFuqglw74RDfjJZssApF6pnve1+geqd71CvXulw8wnKuoyCo/jb3NPc6NIMUVrOfS4Xk6Oygg8EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142059; c=relaxed/simple;
	bh=M9jrGH7mf0KPVz/vzoJ7jmtDIAbubSGjZKxT5qvrcdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLUSw9WVcBJB9UtB3zxbj/IpWi/ZP7ckcJGtvvwaR6/7Sy+IINrTydPowxsvYUnOX8X9ORRO0NEOYuJ1EyWTn4ZVVC1Uzbm03eDBvJeoYms9vQzNBYWOgdDA9bSYF/dRqRksZpWA2IZleInSBTmodrFier8dGCYD8HIdhHr4dFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQazveK4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQazveK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733142057; x=1764678057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M9jrGH7mf0KPVz/vzoJ7jmtDIAbubSGjZKxT5qvrcdg=;
  b=PQazveK449e2bxYbRfGIlUa1I9xCIdbfNg1yiUF/RyPfMUNjA+DFIVhc
   6QBxmnef41GPkRmC97QMwsKsxGymcL8lmjr+BIY+L9RmHnGz1LztNntRc
   aUx220R9pRRXdJ11a73SskirtE7I2iDcnOPg77BonGdNaW1AhNITUYKNL
   0uRdWTJkGYKAaOh3C7rBALdqBXt0s1HR+fIq+mtRcnrpXyoN8q3SBghuV
   BmNqjCUMLAHPmTFoaSl8+2I5DmszTCcTIVWXnjiUnKzrN+aYCapv9N6vi
   jorWU9KYlbr0jPihpyqAXvTAnVn4oLkMnplOGyk0RngpSiL3I/JRpR99o
   w==;
X-CSE-ConnectionGUID: cS0mM+acSPKV5oBCSkYCrg==
X-CSE-MsgGUID: ysiXF89DRxWpGXVspnnkRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33435386"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="33435386"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 04:20:56 -0800
X-CSE-ConnectionGUID: 9tHCy+sMSIeQw0RvfqmjRQ==
X-CSE-MsgGUID: Uaw84SIISKObS45VYFAo2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="93263235"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 02 Dec 2024 04:20:55 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tI5Q4-0002Of-21;
	Mon, 02 Dec 2024 12:20:52 +0000
Date: Mon, 2 Dec 2024 20:20:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Yuxue Liu yuxue.liu@jaguarmicro.com" <yuxue.liu@jaguarmicro.com>,
	jasowang@redhat.com, mst@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	yuxue.liu@jaguarmicro.com, angus.chen@jaguarmicro.com
Subject: Re: [PATCH] vdpa/vp_vdpa: implement kick_vq_with_data callback
Message-ID: <202412021926.Sg38msHn-lkp@intel.com>
References: <20241202033611.1374-1-yuxue.liu@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202033611.1374-1-yuxue.liu@jaguarmicro.com>

Hi Yuxue,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.13-rc1 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuxue-Liu-yuxue-liu-jaguarmicro-com/vdpa-vp_vdpa-implement-kick_vq_with_data-callback/20241202-114053
base:   linus/master
patch link:    https://lore.kernel.org/r/20241202033611.1374-1-yuxue.liu%40jaguarmicro.com
patch subject: [PATCH] vdpa/vp_vdpa: implement kick_vq_with_data callback
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20241202/202412021926.Sg38msHn-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241202/202412021926.Sg38msHn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412021926.Sg38msHn-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/vdpa/virtio_pci/vp_vdpa.c: In function 'vp_vdpa_kick_vq_with_data':
>> drivers/vdpa/virtio_pci/vp_vdpa.c:372:46: error: 'vdpa' undeclared (first use in this function)
     372 |         struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
         |                                              ^~~~
   drivers/vdpa/virtio_pci/vp_vdpa.c:372:46: note: each undeclared identifier is reported only once for each function it appears in


vim +/vdpa +372 drivers/vdpa/virtio_pci/vp_vdpa.c

   369	
   370	static void vp_vdpa_kick_vq_with_data(struct vdpa_device *vdpa_dev, u32 data)
   371	{
 > 372		struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
   373		u16 qid = data & 0xFFFF;
   374	
   375		vp_iowrite32(data, vp_vdpa->vring[qid].notify);
   376	}
   377	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
