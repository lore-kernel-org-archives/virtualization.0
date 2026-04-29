Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2C2F617C
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488329; cv=none; b=Jw8/304EsNPcGh0SEjQiNwG53E0WAWZ9ACMiT0oRyBBoqXFaRX5EwTSZ8NnZcruypRTD5gZl2HaLWnCuYmePKil2Y1/g98srRVKteFeB3B7CI4plsBLVljcHc/jdLjDfmGSZxVi/JzHW3e5MZYb/4fVfEI0YBn4UjoQm6DbC66E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488329; c=relaxed/simple;
	bh=FUaipKRQWKueh5iXFUKYcBRQr8N9GLd2yCPxpyGYkAg=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=Ld1wHYFIp9kztuVu2I07XuHjkRsM4R/VwDnlpMNdQJfo+2ujGUb9Ja62ZF/1rexkTDxEHeWa5UH5W8DSxO0yHqo3Kk0lgfprDH9NRv/kf0Srr/IG53sYz52OIJK+ouK+slgHVG6Pm7pot08Mx0YI1WqYOTv412D/RvquIWXovJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etwvm7Z6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etwvm7Z6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488325; x=1809024325;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=FUaipKRQWKueh5iXFUKYcBRQr8N9GLd2yCPxpyGYkAg=;
  b=etwvm7Z69iQqp2TEvyWz6K7JpcEDaXjWRzFpWACfbYHLneUOtW+ZpUXH
   LkwG+DCzjV2CrnfFywosASIvseGP0/KM+egN3TkdKPRIS/8DXXKTXNClr
   nBXMnPLFqNtBpgA0zfQHXfM5ybQSzruEap2pjHRTqKQ75sdDSO+0jnpzg
   G6CxlBZjf46O84X0S2KHxzC+iIe+lLAS8PcMt4IK3ToDxI4z8Wj2pIBoZ
   fobS0ehKv9efcpXdra7Cg6tRbhX3Ef2BetAo/fySrKwH4yLW1xxJrdIzk
   WzyqlpNMs4jzgkGNdIVPb/st0zHnXf/OQlb6C+no41U9B4fTMWq5cjjF0
   A==;
X-CSE-ConnectionGUID: KdoKIb/mTSO0Z4iPaLBkEQ==
X-CSE-MsgGUID: OsaUMr+qT3W7qsgGmFaVmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78322272"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78322272"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:45:23 -0700
X-CSE-ConnectionGUID: koiyjVlsSlGcjLkr/xakzg==
X-CSE-MsgGUID: fPtyVoFASf2zF8Wu8+k+Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229749606"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa006.fm.intel.com with ESMTP; 29 Apr 2026 11:45:23 -0700
Subject: [PATCH v2 3/8] x86/msr: Consolidate rdmsr_safe() implementations
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Apr 2026 11:45:22 -0700
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
In-Reply-To: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
Message-Id: <20260429184522.BFBD67A7@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


From: Dave Hansen <dave.hansen@linux.intel.com>

Move the existing "native" rdmsr_safe() implementation out to common
code. Consolidate the two rdmsr_safe() implementations down to one
by removing the paravirt.h version.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h      |   20 ++++++++++----------
 b/arch/x86/include/asm/paravirt.h |   10 ----------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-4 arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~rdmsr-dups-4	2026-04-01 14:32:56.670457110 -0700
+++ b/arch/x86/include/asm/msr.h	2026-04-01 14:32:56.676457335 -0700
@@ -205,16 +205,6 @@ static inline int wrmsrq_safe(u32 msr, u
 	return paravirt_write_msr_safe(msr, val);
 }
 
-/* rdmsr with exception handling */
-#define rdmsr_safe(msr, low, high)				\
-({								\
-	u64 __val;						\
-	int __err = paravirt_read_msr_safe((msr), &__val);		\
-	(*low) = (u32)__val;					\
-	(*high) = (u32)(__val >> 32);				\
-	__err;							\
-})
-
 static inline int rdmsrq_safe(u32 msr, u64 *p)
 {
 	return paravirt_read_msr_safe(msr, p);
@@ -237,6 +227,16 @@ do {								\
 	(void)((high) = (u32)(__val >> 32));			\
 } while (0)
 
+/* rdmsr with exception handling */
+#define rdmsr_safe(msr, low, high)				\
+({								\
+	u64 __val;						\
+	int __err = paravirt_read_msr_safe((msr), &__val);		\
+	(*low) = (u32)__val;					\
+	(*high) = (u32)(__val >> 32);				\
+	__err;							\
+})
+
 /* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
 #define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
 
diff -puN arch/x86/include/asm/paravirt.h~rdmsr-dups-4 arch/x86/include/asm/paravirt.h
--- a/arch/x86/include/asm/paravirt.h~rdmsr-dups-4	2026-04-01 14:32:56.673457222 -0700
+++ b/arch/x86/include/asm/paravirt.h	2026-04-01 14:32:56.676457335 -0700
@@ -181,16 +181,6 @@ static inline int wrmsrq_safe(u32 msr, u
 	return paravirt_write_msr_safe(msr, val);
 }
 
-/* rdmsr with exception handling */
-#define rdmsr_safe(msr, a, b)				\
-({							\
-	u64 _l;						\
-	int _err = paravirt_read_msr_safe((msr), &_l);	\
-	(*a) = (u32)_l;					\
-	(*b) = (u32)(_l >> 32);				\
-	_err;						\
-})
-
 static __always_inline int rdmsrq_safe(u32 msr, u64 *p)
 {
 	return paravirt_read_msr_safe(msr, p);
_
