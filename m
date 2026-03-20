Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61D4303A01
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033414; cv=none; b=axaXKzJimwx6peOILK2Sw3V5cQnTeP6JfcP1AOofaebgDefGAmf1bnvkk2PiyJIn1Vz1+Dy47UCK4q819bjbxg8jECMsopZFOiSBNNy1slTyQAbxFS4y+uWfhuU20PyPkdBnlcnk1JRmRG1vpmCUqiox466lES1AXJ598O4QLH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033414; c=relaxed/simple;
	bh=ssZZR5NQEwQd0eC7noZlcIf2z1AJvKSvPlgDEqtjUqA=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=t04Wv2H++C927QhyquN8tEVkM7abYuo/AGYc+Wj9gL2Z41A1AHsYO3BdDFOgTyrESbpHJs8VbkvHkd72dAwkjq8JxXnxILgJZ14LXRBgrzKIjIa3EywkEhJZQ0oIxJIKYAqSnFcLmb3ywPH3tyZJloVUOSdJLnacEmwPkr1jKAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GykDLxD3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GykDLxD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774033413; x=1805569413;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=ssZZR5NQEwQd0eC7noZlcIf2z1AJvKSvPlgDEqtjUqA=;
  b=GykDLxD39AXW86X4vmcGErCX9vufQEQ0Xn8vLFNvLhR6L8wlG4oYg7b7
   8UZtHncFRC2cGlwGJlsbDw8k0G/a8o1nnlrcHzGbITMiwIgf69pRGyjE+
   yYKYrMn8GKh6HL/neTVvYbbJdcu0kUq5WQ3ym4b/cuRMsQFDe8fLrHm8B
   U3WgkATLT1PBtMcsKCV0gWRgMj6f/PZkV/JVVMyVtEW8JTtPpdJspIt0J
   +Nic/yGbvjEdwrpKv2A5XqvXs/x8YBmBlhSFvVC9FhVqEXNVS6ZIlLRP6
   QtVhjR2tDEIgkbCB+qEFRcdMwKsVP0hYTZlj1p0dO0vD0D++QDl1pj+Yn
   Q==;
X-CSE-ConnectionGUID: 8+ccACp0Sxu+BNytMwff1A==
X-CSE-MsgGUID: qnJhaj+/SP23zabDpTLKvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86200618"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86200618"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:03:33 -0700
X-CSE-ConnectionGUID: Bl7WBjTCR0a8/e4Ssmxo3g==
X-CSE-MsgGUID: O+bdJ2ZnTbuMwavnKeP2Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222597395"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 20 Mar 2026 12:03:32 -0700
Subject: [PATCH 1/8] x86/msr: Use "raw_" names for calls to native_* functions
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Mar 2026 12:03:32 -0700
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
In-Reply-To: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
Message-Id: <20260320190332.DF9F7A9B@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


From: Dave Hansen <dave.hansen@linux.intel.com>

Currently, the paravirt and native code define a common set of MSR
functions. But, some of the code is duplicated between the two. For
instance, the packing and unpacking of the 64-bit MSR value into two
32-bit values is done in both.

Introduce a new abstraction layer: "raw" calls. For now, define and
use them only in the native case. This lays the foundation of
having the paravirt code also defined "raw" calls.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff -puN arch/x86/include/asm/msr.h~raw_msr_names arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~raw_msr_names	2026-03-20 11:24:18.217756517 -0700
+++ b/arch/x86/include/asm/msr.h	2026-03-20 11:24:18.220756650 -0700
@@ -173,6 +173,12 @@ static inline u64 native_read_pmc(int co
 #include <asm/paravirt.h>
 #else
 #include <linux/errno.h>
+
+#define raw_read_msr		native_read_msr
+#define raw_read_msr_safe	native_read_msr_safe
+#define raw_write_msr		native_write_msr
+#define raw_write_msr_safe	native_write_msr_safe
+
 /*
  * Access to machine-specific registers (available on 586 and better only)
  * Note: the rd* operations modify the parameters directly (without using
@@ -181,35 +187,35 @@ static inline u64 native_read_pmc(int co
 
 #define rdmsr(msr, low, high)					\
 do {								\
-	u64 __val = native_read_msr((msr));			\
+	u64 __val = raw_read_msr((msr));			\
 	(void)((low) = (u32)__val);				\
 	(void)((high) = (u32)(__val >> 32));			\
 } while (0)
 
 static inline void wrmsr(u32 msr, u32 low, u32 high)
 {
-	native_write_msr(msr, (u64)high << 32 | low);
+	raw_write_msr(msr, (u64)high << 32 | low);
 }
 
 #define rdmsrq(msr, val)			\
-	((val) = native_read_msr((msr)))
+	((val) = raw_read_msr((msr)))
 
 static inline void wrmsrq(u32 msr, u64 val)
 {
-	native_write_msr(msr, val);
+	raw_write_msr(msr, val);
 }
 
 /* wrmsr with exception handling */
 static inline int wrmsrq_safe(u32 msr, u64 val)
 {
-	return native_write_msr_safe(msr, val);
+	return raw_write_msr_safe(msr, val);
 }
 
 /* rdmsr with exception handling */
 #define rdmsr_safe(msr, low, high)				\
 ({								\
 	u64 __val;						\
-	int __err = native_read_msr_safe((msr), &__val);	\
+	int __err = raw_read_msr_safe((msr), &__val);		\
 	(*low) = (u32)__val;					\
 	(*high) = (u32)(__val >> 32);				\
 	__err;							\
@@ -217,7 +223,7 @@ static inline int wrmsrq_safe(u32 msr, u
 
 static inline int rdmsrq_safe(u32 msr, u64 *p)
 {
-	return native_read_msr_safe(msr, p);
+	return raw_read_msr_safe(msr, p);
 }
 
 static __always_inline u64 rdpmc(int counter)
_
