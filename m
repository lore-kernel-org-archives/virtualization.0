Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957324EABB
	for <virtualization@lists.linux.dev>; Sun, 27 Apr 2025 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745745682; cv=none; b=O02Z7qS9fdOtgbgQbP51KiVr/Rc1Ps4sJ0YXmZX/Piwy6Atd7O9Fb1wLMI/rO43VOiqSzUhEltvKYmlyBHgEMDHoriYX/161OjMRJTOz12Ln/omUO1KrClsUROVuOIL2ytpYbNkWldPdVuznEHffu3Hgxp1CzCxWI1qiGhMGmkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745745682; c=relaxed/simple;
	bh=StjvexCO/8zLImAhby8WhuBY7Msfnw3+TtbfmBdURq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5akVsocxVmkkR0yPdJNck2aebQmvdTkEKd652mF350aRA9EWMyZbPd/r+nbE4EdFv9Jw4hKJiJGc2WHxGGEeaGhoThWgzlxK9iXy/1vIP7StnnV5+VE91Ru3E11ngqZbkm0UrmyskMwcHJO+Kp6tw5JYTSh22JyY1xrNjvlNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+lnfL5O; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+lnfL5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745745680; x=1777281680;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=StjvexCO/8zLImAhby8WhuBY7Msfnw3+TtbfmBdURq4=;
  b=b+lnfL5Og4lALpoB7/FPnCz9mETkmhvlmNdlfktIIfOJBs7RQxmjQNBk
   TFxnkozvghxDb016zPmiGMPs5ZJc9/qBL9zfGN0Q7xO+iT88zSLnmiI8e
   5Q12lnhW+/dGwmd13oluEy+ebtd9NDYVSo406+4yTTDjO+DkFGEQOPpdh
   CiQ/ZmLy33gYU6f7o+mxp56OUHMObGyFGHWw8ELz/fpIXxewI2832jHMO
   Pw5G3xFF4jJCbZsBbio0CdTpDYDJi4OpXsXtEqkjiqvG+gihFec5/arYs
   ZmKElfxDAXELZjwoNI8RRIcfL/hrBnjfxuRVmHaAlyieaCTEd6kyfHSUq
   w==;
X-CSE-ConnectionGUID: WRejzte0Tv+LiJ3vQowkTw==
X-CSE-MsgGUID: 1u2J1QvUSfi0EtAYq9jOHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="47236475"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="47236475"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 02:21:19 -0700
X-CSE-ConnectionGUID: JeWrP7m0Q8KAGkBMWvxeDQ==
X-CSE-MsgGUID: lIrEAOnkShqHlZAf/7h3KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="133151304"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 02:21:12 -0700
Message-ID: <d2bdd61d-cab6-401f-9b6a-17b28f3cd19c@linux.intel.com>
Date: Sun, 27 Apr 2025 17:21:08 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] x86/xen/msr: Remove calling
 native_{read,write}_msr{,_safe}() in pmu_msr_{read,write}()
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
 linux-hwmon@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, acme@kernel.org,
 jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, wei.liu@kernel.org,
 ajay.kaher@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 tony.luck@intel.com, pbonzini@redhat.com, vkuznets@redhat.com,
 seanjc@google.com, luto@kernel.org, boris.ostrovsky@oracle.com,
 kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
References: <20250425083442.2390017-1-xin@zytor.com>
 <20250425083442.2390017-10-xin@zytor.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250425083442.2390017-10-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/25/2025 4:34 PM, Xin Li (Intel) wrote:
> hpa found that pmu_msr_write() is actually a completely pointless
> function [1]: all it does is shuffle some arguments, then calls
> pmu_msr_chk_emulated() and if it returns true AND the emulated flag
> is clear then does *exactly the same thing* that the calling code
> would have done if pmu_msr_write() itself had returned true.  And
> pmu_msr_read() does the equivalent stupidity.
>
> Remove the calls to native_{read,write}_msr{,_safe}() within
> pmu_msr_{read,write}().  Instead reuse the existing calling code
> that decides whether to call native_{read,write}_msr{,_safe}() based
> on the return value from pmu_msr_{read,write}().  Consequently,
> eliminate the need to pass an error pointer to pmu_msr_{read,write}().
>
> While at it, refactor pmu_msr_write() to take the MSR value as a u64
> argument, replacing the current dual u32 arguments, because the dual
> u32 arguments were only used to call native_write_msr{,_safe}(), which
> has now been removed.
>
> [1]: https://lore.kernel.org/lkml/0ec48b84-d158-47c6-b14c-3563fd14bcc4@zytor.com/
>
> Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Sign-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>
> Change in v3:
> *) Rename pmu_msr_{read,write}() to pmu_msr_{read,write}_emulated()
>    (Dapeng Mi).
> *) Fix a pmu_msr_read() callsite with wrong arguments (Dapeng Mi).
> ---
>  arch/x86/xen/enlighten_pv.c |  8 ++++++--
>  arch/x86/xen/pmu.c          | 27 ++++-----------------------
>  arch/x86/xen/xen-ops.h      |  4 ++--
>  3 files changed, 12 insertions(+), 27 deletions(-)
>
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index 846b5737d320..61e51a970f3c 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -1090,7 +1090,7 @@ static u64 xen_do_read_msr(unsigned int msr, int *err)
>  {
>  	u64 val = 0;	/* Avoid uninitialized value for safe variant. */
>  
> -	if (pmu_msr_read(msr, &val, err))
> +	if (pmu_msr_read_emulated(msr, &val))
>  		return val;
>  
>  	if (err)
> @@ -1132,6 +1132,8 @@ static void set_seg(unsigned int which, unsigned int low, unsigned int high,
>  static void xen_do_write_msr(unsigned int msr, unsigned int low,
>  			     unsigned int high, int *err)
>  {
> +	u64 val;
> +
>  	switch (msr) {
>  	case MSR_FS_BASE:
>  		set_seg(SEGBASE_FS, low, high, err);
> @@ -1158,7 +1160,9 @@ static void xen_do_write_msr(unsigned int msr, unsigned int low,
>  		break;
>  
>  	default:
> -		if (!pmu_msr_write(msr, low, high, err)) {
> +		val = (u64)high << 32 | low;
> +
> +		if (!pmu_msr_write_emulated(msr, val)) {
>  			if (err)
>  				*err = native_write_msr_safe(msr, low, high);
>  			else
> diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
> index 9c1682af620a..b6557f2d1a2e 100644
> --- a/arch/x86/xen/pmu.c
> +++ b/arch/x86/xen/pmu.c
> @@ -313,37 +313,18 @@ static bool pmu_msr_chk_emulated(unsigned int msr, uint64_t *val, bool is_read,
>  	return true;
>  }
>  
> -bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
> +bool pmu_msr_read_emulated(u32 msr, u64 *val)
>  {
>  	bool emulated;
>  
> -	if (!pmu_msr_chk_emulated(msr, val, true, &emulated))
> -		return false;
> -
> -	if (!emulated) {
> -		*val = err ? native_read_msr_safe(msr, err)
> -			   : native_read_msr(msr);
> -	}
> -
> -	return true;
> +	return pmu_msr_chk_emulated(msr, val, true, &emulated) && emulated;
>  }
>  
> -bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err)
> +bool pmu_msr_write_emulated(u32 msr, u64 val)
>  {
> -	uint64_t val = ((uint64_t)high << 32) | low;
>  	bool emulated;
>  
> -	if (!pmu_msr_chk_emulated(msr, &val, false, &emulated))
> -		return false;
> -
> -	if (!emulated) {
> -		if (err)
> -			*err = native_write_msr_safe(msr, low, high);
> -		else
> -			native_write_msr(msr, low, high);
> -	}
> -
> -	return true;
> +	return pmu_msr_chk_emulated(msr, &val, false, &emulated) && emulated;
>  }
>  
>  static u64 xen_amd_read_pmc(int counter)
> diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
> index 735f58780704..163e03e33089 100644
> --- a/arch/x86/xen/xen-ops.h
> +++ b/arch/x86/xen/xen-ops.h
> @@ -274,8 +274,8 @@ void xen_pmu_finish(int cpu);
>  static inline void xen_pmu_init(int cpu) {}
>  static inline void xen_pmu_finish(int cpu) {}
>  #endif
> -bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err);
> -bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err);
> +bool pmu_msr_read_emulated(u32 msr, u64 *val);
> +bool pmu_msr_write_emulated(u32 msr, u64 val);
>  int pmu_apic_update(uint32_t reg);
>  u64 xen_read_pmc(int counter);
>  

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


