Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AAC421F1C
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488333; cv=none; b=N7cL+0CZErShshRxB8gAv4r2NoctFEYy5/6bd1UQQZ/ZyatOXTcu+DIUwKRllqvrCOltES+Sdjb+p2Elal5pA89X6nVDDmc0UxyzVgZi9fZDtJlY/KyBNSHx0+MkOEF53SGyT02A4LTE2sBQg1Owi8wwMvO0zze5MjQQN+y6z8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488333; c=relaxed/simple;
	bh=fFnkiRKhpPvI79OMwQDp/19tTpyIVHqHdLV8/saCv/8=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=Xpbt3WVs+UbnOSKj+OjEn0Dcf3+te4iK/pRTF6AWRXHWyRSU9pud/Q6yWnVK6UvQCtNCSjW27XJPygofnyRv7+zYJKckXZp9OSjGMpt80Bovoz2yilF2gKPlsli6RHyznIWeqZIIoGTGtpi/QfdXMA9/s9Pr01ENOJIWzcSKqco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOqbLND6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOqbLND6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488330; x=1809024330;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=fFnkiRKhpPvI79OMwQDp/19tTpyIVHqHdLV8/saCv/8=;
  b=nOqbLND6yAvRRSnp7B3qeoOm5IhR2D6rJI/F/rLZp0ubacbmWDR0GobX
   H9Dqs9BelD3H5PMUq/ycEgWVtwJRqC3anHoIso0F6APjLLtq9KVdYi/t2
   q/oqyw/WbqPaeQ3GbiZqj3QB++LxhTUF0eSuyEM7A+XOgEqj3UDohLadQ
   IecVz+69CBlnKfXEP4wtWovr3XpKQvUdWxJgwR/vbX+3jwk3iYLemo2nD
   Uq/uNdP1vruXtT6l2DepCDGUb8y+UtXM5VbLntHfcdqjJYt/qIsYx+Rph
   00HX4Q+SgJbT15Tx7aGzOHB3HIOaA8OvPzsAlwa+A9v3snYUgqcqcdD7Q
   A==;
X-CSE-ConnectionGUID: 0pZWLE5fSd+zlaLTNpr/OQ==
X-CSE-MsgGUID: KAldvdDpTF2MZf3bVOEUfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78322303"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78322303"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:45:29 -0700
X-CSE-ConnectionGUID: 6Qow8+KvTjm06VZPyiAV8A==
X-CSE-MsgGUID: L0BhKFkmRd67NAbxadZLzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229749678"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa006.fm.intel.com with ESMTP; 29 Apr 2026 11:45:29 -0700
Subject: [PATCH v2 7/8] x86/msr: Remove old crusty comment
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Apr 2026 11:45:28 -0700
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
In-Reply-To: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
Message-Id: <20260429184528.8BB32EAC@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


From: Dave Hansen <dave.hansen@linux.intel.com>

I'm not sure any of this makes sense any more. The kernel only
runs on "586 and better". The comment about gcc optimization is
hopefully decades out of date too.

Really, the only reason to keep the wonky semantics where the
parameters get modified is to avoid all the churn to make them sane.
Not gcc. gcc was probably a bad reason, even back in the day because
MSRs are mostly very slow and have always been very slow. A few
extra bytes of register shuffling was probably never measurable.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h |    6 ------
 1 file changed, 6 deletions(-)

diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-10 arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~rdmsr-dups-10	2026-04-01 14:32:58.971543295 -0700
+++ b/arch/x86/include/asm/msr.h	2026-04-01 14:32:58.974543407 -0700
@@ -181,12 +181,6 @@ static inline u64 native_read_pmc(int co
 #define paravirt_write_msr_safe	native_write_msr_safe
 #define paravirt_read_pmc		native_read_pmc
 
-/*
- * Access to machine-specific registers (available on 586 and better only)
- * Note: the rd* operations modify the parameters directly (without using
- * pointer indirection), this allows gcc to optimize better
- */
-
 #endif	/* !CONFIG_PARAVIRT_XXL */
 
 /*
_
