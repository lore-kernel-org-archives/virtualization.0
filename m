Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE91283FD8;
	Sat,  7 Mar 2026 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772885054; cv=none; b=XVyawxAFGRxeRrLaGCFnDQOYBw0Pv+ZTyVZ10WHNvzU8SaMyNwYovi0EInOKo+Iz6J1iOIYUOHM5VT8WikQMNPRWYOfJPIyag8rnsLkMcF0SzsnTG7D8QyxxLd+b69NhZwQN0f0SiSEj856Vxk5+CUe2abtKj352HPxClQ1E9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772885054; c=relaxed/simple;
	bh=hPiT2hlmOPrRZcFLHbykB3DKCp4lxKFhXGrMKbpOgxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5/GIfgCiOdJfKJfDG9QFFjfNhCN+/oglyxHHGQIsvdsiMhlI4/g0gmDed9GlOKki31x8gcQ+pOlKsw3nZ97Q/VT+ozx8OMbpjvjQtCQJD5TGxRa+fkHvQokqABXk+ECvUmZCbrm2b4Oo88HqWzqmV+S4zrGhepnR4W2kDoe2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYJiTPYS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYJiTPYS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772885054; x=1804421054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hPiT2hlmOPrRZcFLHbykB3DKCp4lxKFhXGrMKbpOgxA=;
  b=UYJiTPYSuw6jQ4f0iKrGojUD1IfYgYQTS6+yc3nZVbpOiXt2PEfoAwyy
   KA74OEDKdxlH/6L/LIIZthmjKv53nwSdRZhlE5RcDkDzpeJ1flL02cNw1
   XEilYvOVGHQoQ5SeMGPFb/mOvn9gkPsXe15TYqNiofYSTwjrHIs1pqUyD
   nrALp6Uf5050yoyjC0q7Xp7xvxDp5RHeik71o7lP5H2QX9c50plOqIFA6
   GNRLK8y+ELGI6Uj00qjnt29AEcxT2flTyVHubbmmJvCWa380wk5d1Nt5D
   DEuUITudTFwAr+0+7zdoCbDsfOpnqrykqmk/nRu89925AzIaM0J4VnocG
   Q==;
X-CSE-ConnectionGUID: KOAROiuXSb+UKsYd6G6yNA==
X-CSE-MsgGUID: eqnsxv/qSwmtSry6q3anSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="61551333"
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="61551333"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 04:04:13 -0800
X-CSE-ConnectionGUID: aBJqsK+xSjy2aX22xPe+7Q==
X-CSE-MsgGUID: BwogpSGBSVCd3iMI7f6xmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="223746396"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 07 Mar 2026 04:04:09 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyqO6-000000002TL-2ABS;
	Sat, 07 Mar 2026 12:04:06 +0000
Date: Sat, 7 Mar 2026 13:03:19 +0100
From: kernel test robot <lkp@intel.com>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
	virtualization@lists.linux.dev, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, mingo@redhat.com, tglx@linutronix.de
Cc: oe-kbuild-all@lists.linux.dev, ajay.kaher@broadcom.com,
	brennan.lamoreaux@broadcom.com, bo.gan@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	kas@kernel.org, rick.p.edgecombe@intel.com,
	linux-coco@lists.linux.dev,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: Re: [PATCH 2/4] x86/vmware: Log kmsg dump on panic
Message-ID: <202603071246.JbbF0Qpv-lkp@intel.com>
References: <20260307004238.1181299-3-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307004238.1181299-3-alexey.makhalov@broadcom.com>

Hi Alexey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/master]
[also build test WARNING on linus/master v7.0-rc2 next-20260306]
[cannot apply to tip/x86/vmware tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexey-Makhalov/x86-vmware-Introduce-common-vmware_hypercall/20260307-091038
base:   tip/master
patch link:    https://lore.kernel.org/r/20260307004238.1181299-3-alexey.makhalov%40broadcom.com
patch subject: [PATCH 2/4] x86/vmware: Log kmsg dump on panic
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260307/202603071246.JbbF0Qpv-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603071246.JbbF0Qpv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603071246.JbbF0Qpv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: arch/x86/kernel/cpu/vmware.c:741 function parameter 'dumper' not described in 'kmsg_dumper_vmware_log'
>> Warning: arch/x86/kernel/cpu/vmware.c:741 function parameter 'detail' not described in 'kmsg_dumper_vmware_log'
>> Warning: arch/x86/kernel/cpu/vmware.c:741 function parameter 'dumper' not described in 'kmsg_dumper_vmware_log'
>> Warning: arch/x86/kernel/cpu/vmware.c:741 function parameter 'detail' not described in 'kmsg_dumper_vmware_log'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
