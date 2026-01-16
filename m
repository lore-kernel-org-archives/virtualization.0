Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0034DB4F;
	Fri, 16 Jan 2026 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768545648; cv=none; b=uDpNLCUsEVXQ0YVSDVg1KlOQ2z0gHu5y1m1Q7bd5aQUkJWG8m+SxC4sHaYFsW9Wb6/LCbkecn4DPXEoZjshwYQMPvF2+X7LUSRWWEQhbjKqsZ1x15reI6G36DPJzM1wg0ZI4ZMRxmijP01nglDA6XoaP4VG93bQv18IbQly9w70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768545648; c=relaxed/simple;
	bh=sULTRp7KP3NGwvDeWMct7Pa425LalcDkcDY9zHO7pxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh7gQYuHzp84IMfhjrJCMfqNzN6W2/iwjEuoP0tvUWCgcWXKI8jB1/iUVIVYRuTyPaHcSsJKS++QQRVhKVuU07rNyMwxWc+nMbZjx73rx9TBzOFuiaCpCm5jRKUBj2yAkAfRe9Tr3pOawwgJRCMVW8AaAnOwKII22H+rYhSKOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hkj8HIxX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hkj8HIxX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768545647; x=1800081647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sULTRp7KP3NGwvDeWMct7Pa425LalcDkcDY9zHO7pxQ=;
  b=Hkj8HIxXQEAMgVaTj37cK4cRcZmKZwCnUBi2UtjaJQH0wU4TH5LsgFoP
   4gpCB6xNvgHMfxSooXSFka35g7x5T2K8AHPj/xFRAgHpTCX2cNd77lXLw
   ZwF5o01YJjidMod0VLhRd7R2IT5FK8XZ81F+wh5Oz3H0Fr2O+0ILWpjjz
   bpUiLunvVJYvHUFAQox7Q38wgndl95UNGBOcUZPabj11KZ/OGb4WHa9Ta
   pGZ5ndTl4fGPPR1MvPdX5nWyS4D8/HpbkPIbdFOUagacA/SFEkT8ouQ4G
   sxmSD+U0hiuZgmDehjR//fx5enXL2t2ZlOHNk5CMGizymKGkpCOAfatTa
   A==;
X-CSE-ConnectionGUID: 5qdezdXOSYu9AaYWg28Lzw==
X-CSE-MsgGUID: 08gtL4hwRiivkJDIFdhXWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="80972715"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="80972715"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 22:40:47 -0800
X-CSE-ConnectionGUID: C3id5IQxQCeHno4LkDvBOQ==
X-CSE-MsgGUID: SbIfDfKJRb+5iG9FqRAlcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="209307719"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 15 Jan 2026 22:40:43 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgdVg-00000000KUe-1B2Z;
	Fri, 16 Jan 2026 06:40:40 +0000
Date: Fri, 16 Jan 2026 14:40:02 +0800
From: kernel test robot <lkp@intel.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v11 10/12] vduse: merge tree search logic of IOTLB_GET_FD
 and IOTLB_GET_INFO ioctls
Message-ID: <202601161430.lDfgRE4U-lkp@intel.com>
References: <20260109152430.512923-11-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109152430.512923-11-eperezma@redhat.com>

Hi Eugenio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.19-rc5 next-20260115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eugenio-P-rez/vduse-add-v1-API-definition/20260109-233435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20260109152430.512923-11-eperezma%40redhat.com
patch subject: [PATCH v11 10/12] vduse: merge tree search logic of IOTLB_GET_FD and IOTLB_GET_INFO ioctls
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260116/202601161430.lDfgRE4U-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260116/202601161430.lDfgRE4U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601161430.lDfgRE4U-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/vdpa/vdpa_user/vduse_dev.c:1269:7: warning: variable 'map_file' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1269 |                 if (f) {
         |                     ^
   drivers/vdpa/vdpa_user/vduse_dev.c:1273:19: note: uninitialized use occurs here
    1273 |                 entry->offset = map_file->offset;
         |                                 ^~~~~~~~
   drivers/vdpa/vdpa_user/vduse_dev.c:1269:3: note: remove the 'if' if its condition is always true
    1269 |                 if (f) {
         |                 ^~~~~~
   drivers/vdpa/vdpa_user/vduse_dev.c:1256:38: note: initialize the variable 'map_file' to silence this warning
    1256 |         const struct vdpa_map_file *map_file;
         |                                             ^
         |                                              = NULL
   1 warning generated.


vim +1269 drivers/vdpa/vdpa_user/vduse_dev.c

  1249	
  1250	static int vduse_dev_iotlb_entry(struct vduse_dev *dev,
  1251					 struct vduse_iotlb_entry *entry,
  1252					 struct file **f, uint64_t *capability)
  1253	{
  1254		int r = -EINVAL;
  1255		struct vhost_iotlb_map *map;
  1256		const struct vdpa_map_file *map_file;
  1257	
  1258		if (entry->start > entry->last)
  1259			return -EINVAL;
  1260	
  1261		mutex_lock(&dev->domain_lock);
  1262		if (!dev->domain)
  1263			goto out;
  1264	
  1265		spin_lock(&dev->domain->iotlb_lock);
  1266		map = vhost_iotlb_itree_first(dev->domain->iotlb, entry->start,
  1267					      entry->last);
  1268		if (map) {
> 1269			if (f) {
  1270				map_file = (struct vdpa_map_file *)map->opaque;
  1271				*f = get_file(map_file->file);
  1272			}
  1273			entry->offset = map_file->offset;
  1274			entry->start = map->start;
  1275			entry->last = map->last;
  1276			entry->perm = map->perm;
  1277			if (capability) {
  1278				*capability = 0;
  1279	
  1280				if (dev->domain->bounce_map && map->start == 0 &&
  1281				    map->last == dev->domain->bounce_size - 1)
  1282					*capability |= VDUSE_IOVA_CAP_UMEM;
  1283			}
  1284	
  1285			r = 0;
  1286		}
  1287		spin_unlock(&dev->domain->iotlb_lock);
  1288	
  1289	out:
  1290		mutex_unlock(&dev->domain_lock);
  1291		return r;
  1292	}
  1293	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
