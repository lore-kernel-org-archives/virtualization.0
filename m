Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B53F18040;
	Wed, 24 Jul 2024 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721789587; cv=none; b=Z5XUNi21ox0gsWAMsw9MYcSzy2AeLljEF5RwHwd1C+IoMYi2aoksgFPOEWVndRTYvAhg3FwMOR/kspsuQx4+uJqn9kpKaUQ6/amU0Z17EQEcvrhU+8cuAkcaQ5R4LdJdiyDz460LYSGoQqKRmlUfNdRk3Lb07cnqejGcs6QF79M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721789587; c=relaxed/simple;
	bh=TN3jp9z/GxFmUrzd9XWw0Y0s+Blfp+n8KcnOoYKxXdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNEcPk6d9JYi1qMwtm4wcs2MASiU8bo9WEmyGMwsL95j8mHJVSJUFjH7wyPl6+bzVE+iTeIVHcJkk6tmLQEOBnAe0xmaKLzMppJtw95USWECNIxGC0q/DeZCzDeJBbmxjlZEY//frrZXrdy2nJeEbGN5hVlAv0KFNLDoUaIz48M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEQNZ4l8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEQNZ4l8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721789586; x=1753325586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TN3jp9z/GxFmUrzd9XWw0Y0s+Blfp+n8KcnOoYKxXdU=;
  b=XEQNZ4l8OvHETAigdUPu88gCB0NJuSFiyFXxLxMR89/ex5Jm9KS9fXvr
   ERWV8lq4IC+rfDbll0MIErf0be7n2dlKdTcZ1l6XrNtTJ0QDzhgMp9hXu
   j2u5fKNl+dAzl9gquqMRrzOr2UGnAE1i3yq5/cjsO9U7nAXDoJti81wT7
   3VEAZ61exwcX2nfp3eUKykFUY7xp0gvBGGfg8vRqFu2XFLqH4JOzSxgwL
   VNtUo6IlGh4Hb3ieeTBlox2jSXe0elSpjh+4zTHOBzW0MVUVWY5xDSoBP
   RnuEJdY5CMwJjp1gG+WkbznWgOXjDNqJRbfqOK1Bxzut41OyOmAazzkSC
   A==;
X-CSE-ConnectionGUID: uTTTa8cJRJiMjIFwfPWY3A==
X-CSE-MsgGUID: CCdOhsC0RQ+GryyxGf3FQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19592961"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19592961"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 19:53:05 -0700
X-CSE-ConnectionGUID: 0VIpVzQYRVGNiRGe/rwxMA==
X-CSE-MsgGUID: e6glXE6yRBCV8lEnlVPLuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="52498938"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 23 Jul 2024 19:53:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWS7g-000mao-1U;
	Wed, 24 Jul 2024 02:53:00 +0000
Date: Wed, 24 Jul 2024 10:52:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 2/2] LoongArch: KVM: Add paravirt qspinlock in guest side
Message-ID: <202407241016.NtaMVEAg-lkp@intel.com>
References: <20240723073825.1811600-3-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723073825.1811600-3-maobibo@loongson.cn>

Hi Bibo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7846b618e0a4c3e08888099d1d4512722b39ca99]

url:    https://github.com/intel-lab-lkp/linux/commits/Bibo-Mao/LoongArch-KVM-Add-paravirt-qspinlock-in-kvm-side/20240723-160536
base:   7846b618e0a4c3e08888099d1d4512722b39ca99
patch link:    https://lore.kernel.org/r/20240723073825.1811600-3-maobibo%40loongson.cn
patch subject: [PATCH 2/2] LoongArch: KVM: Add paravirt qspinlock in guest side
config: loongarch-kismet-CONFIG_PARAVIRT-CONFIG_PARAVIRT_SPINLOCKS-0-0 (https://download.01.org/0day-ci/archive/20240724/202407241016.NtaMVEAg-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240724/202407241016.NtaMVEAg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407241016.NtaMVEAg-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PARAVIRT when selected by PARAVIRT_SPINLOCKS
   

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
