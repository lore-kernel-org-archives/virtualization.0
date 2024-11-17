Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565212E5B;
	Sun, 17 Nov 2024 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731834980; cv=none; b=Kl94ol6YxdswwLR4fQhJdzCNe/ZQCgCBtVp2vi4tqUT/c77iIpHpOxD0umWauZqSlcLs4Xt2qLsx29Lx8QJl50BYQQsqPfq5Lvt+KM7CND4K/oORHFT1T5ip15EUBmfd/0isuYjwTYbukvnkUJM6QDWnBMlh02WyDe4hWy7gU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731834980; c=relaxed/simple;
	bh=g4ehLSqsya6NJQtkjdgyvdNG0TLIzz8TwUMtsuSLxek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ai41dK1YwkZ5NBoW1W2rk8zzb9bVzNh/ksD+SHhilboUVwoSR+HzvOURAlQ4Ta0KVJ58NX2G3Z/M/vn9HpoMKVTbe0izs8Na22vcaiv1o0j8CytmoIKs5GOSYZuexwJmvXDM/KRpB8e6UBvpkvbWAwh8E5zfR0y1oEFmN4wMSyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvlUOnGQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvlUOnGQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731834978; x=1763370978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g4ehLSqsya6NJQtkjdgyvdNG0TLIzz8TwUMtsuSLxek=;
  b=nvlUOnGQFRniMBtCbZiWxcQZN7nc8DKM5MUbFqMcn2ij7fYOMHK+8qYT
   2SI4S9fFzbPQaBQ3yUF53hywP0F8RfVncc6lucBgLa31vkSPg1HQU1azA
   VRkZO1CWc8Wp3+MKayL/pcHhOfTlhbuatvOQUsGZceofIqdCEvYRyZVDR
   T7s+IIcs6nX1ZruGqwCJ5LmACx1IoJ1/QQSZcodKzRwig5aEmRubkYANu
   lSQoNuEeogj2EbMljpd9W3rVi9beOWppAJsuO3aGLwd3bVA4BsB4/AswS
   aZ9B5Bj4+L0v7R5QQx55bfD/UtF90Rk062tMw60U7HPXA7uhLmEn7UZuH
   w==;
X-CSE-ConnectionGUID: A1jjFpJTSY6jPi+hSDxzuQ==
X-CSE-MsgGUID: qHXt9IfLQG+Sy7MTliJklA==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="31739666"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="31739666"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 01:16:17 -0800
X-CSE-ConnectionGUID: jraRo+LeTxqqej/ImtU/gw==
X-CSE-MsgGUID: cqMAJ3wyScW0hGareT7SIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="112241906"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Nov 2024 01:16:14 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCbO8-0001fH-24;
	Sun, 17 Nov 2024 09:16:12 +0000
Date: Sun, 17 Nov 2024 17:15:49 +0800
From: kernel test robot <lkp@intel.com>
To: Christian =?unknown-8bit?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
	kraxel@redhat.com, airlied@redhat.com, alexander.deucher@amd.com,
	zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4/7] drm/vmwgfx: use the new drm_exec object
Message-ID: <202411171611.9LEZwWSe-lkp@intel.com>
References: <20241114153020.6209-5-christian.koenig@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114153020.6209-5-christian.koenig@amd.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-xe/drm-xe-next]
[also build test WARNING on drm/drm-next drm-exynos/exynos-drm-next linus/master drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip v6.12-rc7 next-20241115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-K-nig/drm-qxl-switch-to-using-drm_exec-v2/20241115-014610
base:   https://gitlab.freedesktop.org/drm/xe/kernel.git drm-xe-next
patch link:    https://lore.kernel.org/r/20241114153020.6209-5-christian.koenig%40amd.com
patch subject: [PATCH 4/7] drm/vmwgfx: use the new drm_exec object
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241117/202411171611.9LEZwWSe-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171611.9LEZwWSe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171611.9LEZwWSe-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/vmwgfx/vmwgfx_validation.c:861: warning: Function parameter or struct member 'fence' not described in 'vmw_validation_bo_fence'


vim +861 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c

   850	
   851	/**
   852	 * vmw_validation_bo_fence - Unreserve and fence buffer objects registered
   853	 * with a validation context
   854	 * @ctx: The validation context
   855	 *
   856	 * This function unreserves the buffer objects previously reserved using
   857	 * vmw_validation_bo_reserve, and fences them with a fence object.
   858	 */
   859	void vmw_validation_bo_fence(struct vmw_validation_context *ctx,
   860				     struct vmw_fence_obj *fence)
 > 861	{
   862		struct vmw_validation_bo_node *entry;
   863	
   864		list_for_each_entry(entry, &ctx->bo_list, base.head) {
   865			dma_resv_add_fence(entry->base.bo->base.resv, &fence->base,
   866					   DMA_RESV_USAGE_READ);
   867		}
   868		drm_exec_fini(&ctx->exec);
   869	}
   870	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
