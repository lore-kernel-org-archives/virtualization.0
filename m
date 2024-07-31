Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B0539A;
	Wed, 31 Jul 2024 00:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722386532; cv=none; b=d2STT6pR46drAmh1MexU1NK94j5cv/JvsAfiJ7qZRcKdmTVwjrMf7VxUIM7inKbd/qip/GmLmaEIGFFCwNBaClbD/mc9zfVi9/4+5FP6J4EpKaa0Oq7l0aD1uqDtBOF4pK4DwP6nFnIcdyuey+xU3MM+DY+PtiOgWJlE5cvoJhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722386532; c=relaxed/simple;
	bh=O4xKrZS0mD61y2mmy9XSZokqEuXtHHJywllfTfjU1Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3XJwU1mkw4wf2ETAdTvFUdB3XKSulXH1No3uO14R1CumTkv8LHyN/acl+LEB40SbhMxqzLa5QNv4bEtmzwg/hX9kZCH0USK8t9wAZR1TZuUta3Jb3KuMsGTwIk1oR5dSk929CzDQXZ3okhNz7UdNvtBAMJyXsPhfcHe+Dpfzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OvEHpz9l; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OvEHpz9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722386531; x=1753922531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O4xKrZS0mD61y2mmy9XSZokqEuXtHHJywllfTfjU1Qs=;
  b=OvEHpz9lVDjKx+RNEG82MpAGmKOhszSBLEHuGYW7kjd2bsUsspoqS/nm
   hLpUSoM0CiImBWWI/yAC/HUPkEZsQqvrZrO9EOsTcsDtxB+XtNk4VsYCh
   b3k4aisBONIE1mQCEEOvUHZUV01fxOncagSsO3VJx38E7y2JeP2l8fTel
   pCHrFNMSMH+rEuDN1XGjT4uz1lq3dlZjgljZ1LLyF8COzm0SFSeKsk8tX
   NlZr5GHXW3PmmVXiTf2IvIVmYXFBS/9xHvAk6Cn7F7GpZPQjGS2IBmXNk
   2g3uYaBMW/Xl5vuuEmKZjmgRzt2BoGfBFNTLsMNoCLswTpeBRLoFqxc/5
   Q==;
X-CSE-ConnectionGUID: nO+yuO9rS2Wnh21DtUIZUQ==
X-CSE-MsgGUID: N/vrqWQES7q1sX9se92fgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20366625"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="20366625"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 17:42:09 -0700
X-CSE-ConnectionGUID: bnJBAGRGRsuyS6UmKTgdCA==
X-CSE-MsgGUID: Oi3+YHQ+RA2GPR1+qmLOoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54205829"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 30 Jul 2024 17:42:08 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYxPo-000tXp-0g;
	Wed, 31 Jul 2024 00:42:04 +0000
Date: Wed, 31 Jul 2024 08:41:18 +0800
From: kernel test robot <lkp@intel.com>
To: Bibo Mao <maobibo@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	x86@kernel.org, Song Gao <gaosong@loongson.cn>
Subject: Re: [PATCH v4 1/3] LoongArch: KVM: Enable paravirt feature control
 from VMM
Message-ID: <202407310823.RbRdbUkV-lkp@intel.com>
References: <20240730075344.1215681-2-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730075344.1215681-2-maobibo@loongson.cn>

Hi Bibo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8400291e289ee6b2bf9779ff1c83a291501f017b]

url:    https://github.com/intel-lab-lkp/linux/commits/Bibo-Mao/LoongArch-KVM-Enable-paravirt-feature-control-from-VMM/20240730-155814
base:   8400291e289ee6b2bf9779ff1c83a291501f017b
patch link:    https://lore.kernel.org/r/20240730075344.1215681-2-maobibo%40loongson.cn
patch subject: [PATCH v4 1/3] LoongArch: KVM: Enable paravirt feature control from VMM
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20240731/202407310823.RbRdbUkV-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240731/202407310823.RbRdbUkV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407310823.RbRdbUkV-lkp@intel.com/

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> error: arch/loongarch/include/uapi/asm/kvm_para.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
   make[3]: *** [scripts/Makefile.headersinst:63: usr/include/asm/kvm_para.h] Error 1
   make[3]: Target '__headers' not remade because of errors.
   make[2]: *** [Makefile:1290: headers] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
