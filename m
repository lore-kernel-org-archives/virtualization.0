Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F92E54AA
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033415; cv=none; b=SJPQj1qrrae7VdXSiMxj9et3/Z4nnyyJdia8snICDu9ivQ5O4wWdlS8W0qgqheEOO9jUBRhT+4WzuFsCODh/wWV3jOf3iQ5UacV0mOHAdr1e58B4IG6wstw+VjCsDT2pOAluPV/ILtA0jMaBoXQt73cuNKZTSOBra9t0jNbCL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033415; c=relaxed/simple;
	bh=9ISTsenTYWVlPRS3URy3VkQJK84BuXlX5yklXUs1MGQ=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=XgeJYQ586YbCgwRPjuLC8DAie2d/5JIMXVUw66SnISnyja7xifu7XNv8Xt9dKw3r8yHyAGMSM1qNgacgGDdLdahRBCEugu4Q3SvyUpHhhyX9UIHJO2hOaoMqJU5FtldwkufNsrHBYvvZCIzFouy7uYdlJoqOV6s3wppoGJeynaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gG7Ipz8f; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gG7Ipz8f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774033415; x=1805569415;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=9ISTsenTYWVlPRS3URy3VkQJK84BuXlX5yklXUs1MGQ=;
  b=gG7Ipz8faHg8XR7f9bTkxVkqmoFLsXsCtveDagCnsROrwvfj+9yUp2aO
   AKXegINhtqmHE4UYQChEqKwr7hHXCRdem1g4KPycWAo3fI21k3vH3fTvt
   AFw5gBozLVGp5wNzoMhNK+rTrrjkTGOqvED3vrGohEctR76zzIszRGjL3
   SHAwO2QKoFkja39OFlenttE36BuAMcAVu+cVqCjuCyXsR0G6VKy5BNR9O
   hx2HgTth+6swPIgU45uoUFeZZYNVI0LMTFKsGMVaYxnLeEZHuEidMqbIE
   LJC29ZOSWSMvKnFn75LGaQatnSxz9Zi3j67WnIetsYcXbcN5Njxb2oNun
   Q==;
X-CSE-ConnectionGUID: P04raOQSQpS2gWuBg7K5wA==
X-CSE-MsgGUID: TTDlT95xTku4Vdod3r9vlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86200627"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86200627"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:03:35 -0700
X-CSE-ConnectionGUID: g/MvaDdJRG6ZOj/Emfojlw==
X-CSE-MsgGUID: I+izdsCETm2F3FOwZ6jrcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222597396"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 20 Mar 2026 12:03:34 -0700
Subject: [PATCH 2/8] x86/msr: Consolidate rdmsr() definitions
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Mar 2026 12:03:33 -0700
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
In-Reply-To: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
Message-Id: <20260320190333.80DD0ACD@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


From: Dave Hansen <dave.hansen@linux.intel.com>

The paravirt and native code define very similar rdmsr()
implementations. Move the native one out to common code
and ensure it can find the paravirt implementation by
defining raw_read_msr() there.

Remove the now duplicate paravirt rdmsr().

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h      |   20 +++++++++++++-------
 b/arch/x86/include/asm/paravirt.h |    7 -------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-2 arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~rdmsr-dups-2	2026-03-20 11:24:18.760780632 -0700
+++ b/arch/x86/include/asm/msr.h	2026-03-20 11:24:18.767780943 -0700
@@ -171,6 +171,9 @@ static inline u64 native_read_pmc(int co
 
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
+
+#define raw_read_msr		paravirt_read_msr
+
 #else
 #include <linux/errno.h>
 
@@ -185,13 +188,6 @@ static inline u64 native_read_pmc(int co
  * pointer indirection), this allows gcc to optimize better
  */
 
-#define rdmsr(msr, low, high)					\
-do {								\
-	u64 __val = raw_read_msr((msr));			\
-	(void)((low) = (u32)__val);				\
-	(void)((high) = (u32)(__val >> 32));			\
-} while (0)
-
 static inline void wrmsr(u32 msr, u32 low, u32 high)
 {
 	raw_write_msr(msr, (u64)high << 32 | low);
@@ -233,6 +229,16 @@ static __always_inline u64 rdpmc(int cou
 
 #endif	/* !CONFIG_PARAVIRT_XXL */
 
+/*
+ * Common paravirt and native helpers:
+ */
+#define rdmsr(msr, low, high)					\
+do {								\
+	u64 __val = raw_read_msr((msr));			\
+	(void)((low) = (u32)__val);				\
+	(void)((high) = (u32)(__val >> 32));			\
+} while (0)
+
 /* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
 #define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
 
diff -puN arch/x86/include/asm/paravirt.h~rdmsr-dups-2 arch/x86/include/asm/paravirt.h
--- a/arch/x86/include/asm/paravirt.h~rdmsr-dups-2	2026-03-20 11:24:18.764780810 -0700
+++ b/arch/x86/include/asm/paravirt.h	2026-03-20 11:24:18.767780943 -0700
@@ -161,13 +161,6 @@ static inline int paravirt_write_msr_saf
 	return PVOP_CALL2(int, pv_ops, cpu.write_msr_safe, msr, val);
 }
 
-#define rdmsr(msr, val1, val2)			\
-do {						\
-	u64 _l = paravirt_read_msr(msr);	\
-	val1 = (u32)_l;				\
-	val2 = _l >> 32;			\
-} while (0)
-
 static __always_inline void wrmsr(u32 msr, u32 low, u32 high)
 {
 	paravirt_write_msr(msr, (u64)high << 32 | low);
_
