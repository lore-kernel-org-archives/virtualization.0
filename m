Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130B837E30C;
	Fri,  9 Oct 2026 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561001; cv=none; b=HM5DP/H+mip+DuRspRDycSjq37S8W2tFg9tnEP0f2N1vKmnJgYRIEy1RQRXN1uMY2nTiPVIuNzBgTLISc9pAh1FxRSTtxAC86hJSdwG+6uq3Oocwbn6Mn9hCqDBB3u/AgE6DA0f7ytWSQgOdWkTNmbcM99hdI3OeXJXhN5XizcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561001; c=relaxed/simple;
	bh=KA76ESxM8lCnsXfxSBELhVXIMrRIa1cTrHeMm5DtMDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKkBigqSolYsA0G7se8oWENkbQI8MqXMA0CbV0Os1+AOh0QwmmJuMY/WHlrznvQn6U1pvHFtyN0BmuPkTBAH0mZpKpg1PT8unvzvbBDt0WgV1qc/oO0IaEbUr2/ocV/aubrDJKW4mmBubhL46hZJJVeb+aJSo+f60AkkOEtBqrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lT7qZutG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lT7qZutG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791560999; x=1823096999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KA76ESxM8lCnsXfxSBELhVXIMrRIa1cTrHeMm5DtMDI=;
  b=lT7qZutGnlMWoUQVQ2GtEGln6EphEAnnXeu60KpMOJA0wlkEz4OQV5fv
   qOWy6K6UjCaJoDRumSbLubMkkWjic6/flwf9j9f2JtcSGK1TEVntZTe5/
   2g3d+In6/rcEOgeK56tEZ8EFbDwZ0bZRMZT1lqzRSu6spMlA7hBlh5IPL
   hhZ1UgTKCxyRvyF8USIU0zVcl6r0w97O/I1EPDkoYYghE7Cu6oJCO3XbT
   S7O6A7UECkJb8gGYXlkXKgyuhh6Vd9fsyobiVtPInD7UM+Il105ore719
   IPeyS8VsDqnv4teNWXuBmYgRXBY/CbOfaL1c2+6eHE5G+CR/pCEL/sxnS
   w==;
X-CSE-ConnectionGUID: CQcibg3ERPGS7BJEc/XDGw==
X-CSE-MsgGUID: AST7Mo7UTdi8CwLHj5Oa/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="365744"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="365744"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 08:49:59 -0700
X-CSE-ConnectionGUID: UWXxgW8GTLmWpRwxnnwZmA==
X-CSE-MsgGUID: 5xcecb1lRXusBDDXrBFxdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="796335"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 Oct 2026 08:49:55 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFCr2-000000005wy-0Ous;
	Fri, 09 Oct 2026 15:49:52 +0000
Date: Fri, 9 Oct 2026 23:48:56 +0800
From: kernel test robot <lkp@intel.com>
To: Julio Faracco <jcfaracco@gmail.com>, Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V2] drm/qxl: Fix out-of-bounds read in client monitors
 head access
Message-ID: <202610092302.Y90qfnp6-lkp@intel.com>
References: <20261008155034.55688-1-jcfaracco@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008155034.55688-1-jcfaracco@gmail.com>

Hi Julio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm/drm-next linus/master v7.3-rc6 next-20261008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julio-Faracco/drm-qxl-Fix-out-of-bounds-read-in-client-monitors-head-access/20261008-125034
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20261008155034.55688-1-jcfaracco%40gmail.com
patch subject: [PATCH V2] drm/qxl: Fix out-of-bounds read in client monitors head access
config: x86_64-randconfig-1017-20261009 (https://download.01.org/0day-ci/archive/20261009/202610092302.Y90qfnp6-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610092302.Y90qfnp6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610092302.Y90qfnp6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/qxl/qxl_display.c: In function 'qxl_conn_get_modes':
>> drivers/gpu/drm/qxl/qxl_display.c:1069:28: warning: unused variable 'qdev' [-Wunused-variable]
    1069 |         struct qxl_device *qdev = to_qxl(dev);
         |                            ^~~~


vim +/qdev +1069 drivers/gpu/drm/qxl/qxl_display.c

f64122c1f6ade30 Dave Airlie           2013-02-25  1065  
f64122c1f6ade30 Dave Airlie           2013-02-25  1066  static int qxl_conn_get_modes(struct drm_connector *connector)
f64122c1f6ade30 Dave Airlie           2013-02-25  1067  {
1b043677d4be206 Gerd Hoffmann         2019-01-18  1068  	struct drm_device *dev = connector->dev;
e304f8a0513b830 Simona Vetter         2020-04-15 @1069  	struct qxl_device *qdev = to_qxl(dev);
1b043677d4be206 Gerd Hoffmann         2019-01-18  1070  	struct qxl_output *output = drm_connector_to_qxl_output(connector);
1b000494978d2f3 Shayenne da Luz Moura 2018-10-26  1071  	unsigned int pwidth = 1024;
1b000494978d2f3 Shayenne da Luz Moura 2018-10-26  1072  	unsigned int pheight = 768;
bf72b40d47f83ac Julio Faracco         2026-10-08  1073  	struct qxl_head *head;
2d856f94e6d2532 Gerd Hoffmann         2017-03-01  1074  	int ret = 0;
f64122c1f6ade30 Dave Airlie           2013-02-25  1075  
bf72b40d47f83ac Julio Faracco         2026-10-08  1076  	head = qxl_output_get_client_head(output);
bf72b40d47f83ac Julio Faracco         2026-10-08  1077  	if (head) {
1b043677d4be206 Gerd Hoffmann         2019-01-18  1078  		if (head->width)
1b043677d4be206 Gerd Hoffmann         2019-01-18  1079  			pwidth = head->width;
1b043677d4be206 Gerd Hoffmann         2019-01-18  1080  		if (head->height)
1b043677d4be206 Gerd Hoffmann         2019-01-18  1081  			pheight = head->height;
1b043677d4be206 Gerd Hoffmann         2019-01-18  1082  	}
1b043677d4be206 Gerd Hoffmann         2019-01-18  1083  
b5f030b7b4a5c8e Gerd Hoffmann         2019-01-18  1084  	ret += drm_add_modes_noedid(connector, 8192, 8192);
b5f030b7b4a5c8e Gerd Hoffmann         2019-01-18  1085  	ret += qxl_add_extra_modes(connector);
1b043677d4be206 Gerd Hoffmann         2019-01-18  1086  	ret += qxl_add_monitors_config_modes(connector);
1b043677d4be206 Gerd Hoffmann         2019-01-18  1087  	drm_set_preferred_mode(connector, pwidth, pheight);
f64122c1f6ade30 Dave Airlie           2013-02-25  1088  	return ret;
f64122c1f6ade30 Dave Airlie           2013-02-25  1089  }
f64122c1f6ade30 Dave Airlie           2013-02-25  1090  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
