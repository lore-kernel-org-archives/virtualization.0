Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136D189F5A;
	Thu, 29 Aug 2024 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724963862; cv=none; b=iUbnjTdgjez5lFn75lrAwyclnAxxrqfsXYrT0Df3e/MhHqvngWmyrRhr1nEXipTzkp8JwKfS7L3AKyMW5VOoNTuITqJAcAKIjX7iY+LvES3nQZmB5ubHqzctRZMG7BhOZJKtZcnz6JUfBR12otLoypZ7ui4Oi5SDFffjF+rMiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724963862; c=relaxed/simple;
	bh=fxcB938H0LwYyhyqYxB2W8ezRIsDKqhYiX4GXWISLk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQFRi7xcoMcmQNttuMDFRV/2xSn5vHUvleph/tt+SzT7PlUtjXfDcgmSA/Ryp3VzTg5w/Gk0RF/9vJsGvOI/ABGeYuwUce2rVRl98ruYeFkwGTj1hiE8sTgVxnRrluREZcwrPiirI074QN4PXFvA+564LYs2soO/xSbsjDjleUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PY8wxSRD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PY8wxSRD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724963861; x=1756499861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fxcB938H0LwYyhyqYxB2W8ezRIsDKqhYiX4GXWISLk8=;
  b=PY8wxSRDX3hwoty5OKauFwOJ1SRIdK/XhQwDmrrg+LkDe2aVQkoJHljx
   RUnMzA9TjOip04xBax7coeHWN8wbsT1b/2gVQnOkGfzYJMPFdpiRcPUY1
   ztzC0G3Y1YsWKNGkyKb/xONSXoE/VK7TYUnXQiw6fRvYYsd4jIpCMknoX
   NASFwuC+a52Ehxp7Sl58Zoef8z5+iNaNF8teVwUaydgDHR+fsRUeA1gWs
   EtJ4L/PmenjZTpeXXBkU29JCOJh0aSfqTvpSAq7TXMjWucm25d4UKadPy
   xBD2zXbB3Bh46wlngdRj56tFUu/SCKJ6VF1hL5SfK3Yd0OuZJVS1d9cRW
   Q==;
X-CSE-ConnectionGUID: V+xvrtAuQ4C0L0fO73OEgg==
X-CSE-MsgGUID: uWu1SJlsQ7WuVt+9tCyXxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23103020"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23103020"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 13:37:40 -0700
X-CSE-ConnectionGUID: qiDW+UmLSGyady4YGGMzhQ==
X-CSE-MsgGUID: f+GjeGLQTM21nR3e8uBXjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="68082240"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Aug 2024 13:37:39 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjltg-0000iQ-0A;
	Thu, 29 Aug 2024 20:37:36 +0000
Date: Fri, 30 Aug 2024 04:37:34 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, kraxel@redhat.com,
	daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 09/10] drm/bochs: Validate display modes against
 available video memory
Message-ID: <202408300420.qcGOiIM6-lkp@intel.com>
References: <20240823124422.286989-10-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823124422.286989-10-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v6.11-rc5 next-20240829]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/drm-bochs-Remove-manual-format-test-from-fb_create/20240826-131701
base:   git://anongit.freedesktop.org/drm/drm drm-next
patch link:    https://lore.kernel.org/r/20240823124422.286989-10-tzimmermann%40suse.de
patch subject: [PATCH 09/10] drm/bochs: Validate display modes against available video memory
config: i386-randconfig-006-20240829 (https://download.01.org/0day-ci/archive/20240830/202408300420.qcGOiIM6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408300420.qcGOiIM6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408300420.qcGOiIM6-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/gpu/drm/tiny/bochs.o: in function `bochs_mode_config_mode_valid':
>> drivers/gpu/drm/tiny/bochs.c:574: undefined reference to `__udivdi3'


vim +574 drivers/gpu/drm/tiny/bochs.c

   560	
   561	static enum drm_mode_status bochs_mode_config_mode_valid(struct drm_device *dev,
   562								 const struct drm_display_mode *mode)
   563	{
   564		struct bochs_device *bochs = to_bochs_device(dev);
   565		const struct drm_format_info *format = drm_format_info(DRM_FORMAT_XRGB8888);
   566		uint64_t pitch;
   567	
   568		if (drm_WARN_ON(dev, !format))
   569			return MODE_ERROR;
   570	
   571		pitch = drm_format_info_min_pitch(format, 0, mode->vdisplay);
   572		if (!pitch)
   573			return MODE_BAD_WIDTH;
 > 574		if (bochs->fb_size / pitch < mode->hdisplay)
   575			return MODE_MEM;
   576	
   577		return MODE_OK;
   578	}
   579	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
