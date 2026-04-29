Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B7421A17
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488330; cv=none; b=YIqTotXwXTvlVsp/m/12Dd+vbnSBu4vVp5cU/4OSl3A9w0OXI5nqGaOxVnubKczywy4ycQBQHP3+Y3EoWAuSBfN+xU/PS5Wb7FhF1CMAS2cAA5R6FJjZISoPALttF/kLpEBzSR9cQI8pZF82sap2pbF+r0GKgfCJMmCsWqGk+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488330; c=relaxed/simple;
	bh=0K2m7nt+yoTs2eZhzYQc6yXS7ITK7ZPIIF2gR0v/z60=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=OKXNqNuG3EMBWj3pRRPkUxTbMDnkUMSa0Iz946+0s8++AUFaoFTVJMlx+9xkYEjPVWQGNDCiOnHF38CIqvNfYtwnSMe/mYJQQyiB2SDPnWyUHFgPjI9p7/29xZshdcm0tDMae2dPjLlUPylBMYhaKO1wIv2f3wnKGe428MOkLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eg70d8MQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eg70d8MQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488325; x=1809024325;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=0K2m7nt+yoTs2eZhzYQc6yXS7ITK7ZPIIF2gR0v/z60=;
  b=Eg70d8MQZYhmTZygtXVCJy8ipSmRhHjcBa+LwYeX8pLyLGKtcMzR0+qS
   Pt5r9hx57vddx9q5w1q7GVI7jlnl/BCpJqHOg15Ep9R5+gTOyOYkB0d7w
   HKijLKQfrm1XZpGbw99LfddLn3wK5RYtxS4JSj1C3CJgV/h1YPmPyrilW
   E52L1fMFW5edZKT/vnGz/gfxuYAxmsoniHaYZP7nUNOCou7JqETN+pkPE
   mcYF71lupfiOPSbsIAyCfUEWyiKW66nRNcWXOmS4OgioPUaflQfYa/C0b
   nbQ1yf4aXoLaY0INmP5IHhO8OhIQRP8K+8BKzxCtKNiAiLO2WRWj73n4R
   g==;
X-CSE-ConnectionGUID: TFky77+lR1advrfIkxBw7w==
X-CSE-MsgGUID: oHyIiGYwQ7uJFJJuoaDwBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78322281"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78322281"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:45:24 -0700
X-CSE-ConnectionGUID: Xt1Ogyu6Qf+BdslwGVMxvA==
X-CSE-MsgGUID: LkI8SH7vS8qKy8kipvcwDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229749636"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa006.fm.intel.com with ESMTP; 29 Apr 2026 11:45:24 -0700
Subject: [PATCH v2 4/8] x86/msr: Consolidate rdmsrq() implementations
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Apr 2026 11:45:24 -0700
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
In-Reply-To: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
Message-Id: <20260429184524.17279F21@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


From: Dave Hansen <dave.hansen@linux.intel.com>

Consolidate the two rdmsrq() implementations down to one.

The paravirt.h implementation was probably better, but just stick
with the native one here for consistency.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h      |    6 +++---
 b/arch/x86/include/asm/paravirt.h |    5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-5 arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~rdmsr-dups-5	2026-04-01 14:32:57.236478310 -0700
+++ b/arch/x86/include/asm/msr.h	2026-04-01 14:32:57.242478534 -0700
@@ -191,9 +191,6 @@ static inline void wrmsr(u32 msr, u32 lo
 	paravirt_write_msr(msr, (u64)high << 32 | low);
 }
 
-#define rdmsrq(msr, val)			\
-	((val) = paravirt_read_msr((msr)))
-
 static inline void wrmsrq(u32 msr, u64 val)
 {
 	paravirt_write_msr(msr, val);
@@ -237,6 +234,9 @@ do {								\
 	__err;							\
 })
 
+#define rdmsrq(msr, val)			\
+	((val) = paravirt_read_msr((msr)))
+
 /* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
 #define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
 
diff -puN arch/x86/include/asm/paravirt.h~rdmsr-dups-5 arch/x86/include/asm/paravirt.h
--- a/arch/x86/include/asm/paravirt.h~rdmsr-dups-5	2026-04-01 14:32:57.239478422 -0700
+++ b/arch/x86/include/asm/paravirt.h	2026-04-01 14:32:57.242478534 -0700
@@ -166,11 +166,6 @@ static __always_inline void wrmsr(u32 ms
 	paravirt_write_msr(msr, (u64)high << 32 | low);
 }
 
-#define rdmsrq(msr, val)			\
-do {						\
-	val = paravirt_read_msr(msr);		\
-} while (0)
-
 static inline void wrmsrq(u32 msr, u64 val)
 {
 	paravirt_write_msr(msr, val);
_
