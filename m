Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F62EA485;
	Thu, 20 Nov 2025 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763607136; cv=none; b=MUomgYD3DCjFfAxD1nWdsAkRSH/MLt3WSHfqPQzlptGL3tA5oLF78aPL82MGhDSYFjrGOqcqGehqIf4jE0U42CxsOZdTkfXGGrGoKFepCuYIg7xJ8WanRmNPQFowVfgZ9nFHuVx/JSWwm8aYPsiAZWw9vRQ0ytdJTwyKXZ2glyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763607136; c=relaxed/simple;
	bh=8LiRFCIrRrKHg+0I0NZU28Hv8xDScXSujB+5bD6/+Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnJcZz0aduyIjddE7bDKumggkmP8rtGgw2TFNwKu/9YAairmOAwl4zy91cQA6SaQ8XkvBR3wfiZsURCysduBc29lO+vNoo5dxeh3gdYbXUgO5jakJSxO3/s/vnWaIj8yALmRuS85dWtXSh60ejCRxfs0MmxidaU779ygxnQkreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFRf/D+q; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFRf/D+q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763607135; x=1795143135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8LiRFCIrRrKHg+0I0NZU28Hv8xDScXSujB+5bD6/+Xs=;
  b=XFRf/D+q7QwOK6NiWQ57NL+PXlmRl2jaLljQ+olHYEiCk813VRt3XBsP
   fFZpLROC3CPZomab/ThzZ4GfSt9JFgaRyCQ+Cm+Lj6lpLYOVxLl+tbvjc
   o7YayHM0B1aGB0NeNwFdr3I8KepUvIffni/4yG0tfSgsVUCP8zQyPvRqh
   pNHdl11RqfPCeanReZ1TCb+Fc6PQI3QLaOxGwfV2oB4dPDBdNgMoVEKF9
   /MoJquzT8tYJRjJ8i8dhawvm/vieJgi2w6Pp4HB2vo2oK6c6yopIgduhz
   1BWFI7Fibmuy532lrQttS9IrXTWvZxJCcLuueorQXPboJqnlVzIt4+vCZ
   A==;
X-CSE-ConnectionGUID: I+HoliWkRRizTsPVU3uDVQ==
X-CSE-MsgGUID: KFkquT6CRO6DjCtcqgvM7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="88321347"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="88321347"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 18:52:14 -0800
X-CSE-ConnectionGUID: CWBNGojCRMOnXSHF6LW5xg==
X-CSE-MsgGUID: lcNSHRC5RCSqKCzgJeRr6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="222164003"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Nov 2025 18:52:09 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLumF-0003Y7-0q;
	Thu, 20 Nov 2025 02:52:07 +0000
Date: Thu, 20 Nov 2025 10:51:50 +0800
From: kernel test robot <lkp@intel.com>
To: Bibo Mao <maobibo@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH 2/3] LoongArch: Add paravirt support with
 vcpu_is_preempted()
Message-ID: <202511201009.WLpYNMAM-lkp@intel.com>
References: <20251118080656.2012805-3-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118080656.2012805-3-maobibo@loongson.cn>

Hi Bibo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6a23ae0a96a600d1d12557add110e0bb6e32730c]

url:    https://github.com/intel-lab-lkp/linux/commits/Bibo-Mao/LoongArch-KVM-Add-preempt-hint-feature-in-hypervisor-side/20251118-161212
base:   6a23ae0a96a600d1d12557add110e0bb6e32730c
patch link:    https://lore.kernel.org/r/20251118080656.2012805-3-maobibo%40loongson.cn
patch subject: [PATCH 2/3] LoongArch: Add paravirt support with vcpu_is_preempted()
config: loongarch-randconfig-r052-20251120 (https://download.01.org/0day-ci/archive/20251120/202511201009.WLpYNMAM-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511201009.WLpYNMAM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511201009.WLpYNMAM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/loongarch/kernel/paravirt.c:346:14: error: redefinition of 'vcpu_is_preempted'
     346 | bool notrace vcpu_is_preempted(int cpu)
         |              ^
   include/linux/sched.h:2263:20: note: previous definition is here
    2263 | static inline bool vcpu_is_preempted(int cpu)
         |                    ^
>> arch/loongarch/kernel/paravirt.c:348:9: error: use of undeclared identifier 'mp_ops'
     348 |         return mp_ops.vcpu_is_preempted(cpu);
         |                ^
   2 errors generated.


vim +/vcpu_is_preempted +346 arch/loongarch/kernel/paravirt.c

   345	
 > 346	bool notrace vcpu_is_preempted(int cpu)
   347	{
 > 348		return mp_ops.vcpu_is_preempted(cpu);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
