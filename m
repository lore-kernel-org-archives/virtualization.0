Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEADF4219FD
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488325; cv=none; b=CNSWISflOvX0pFnoQ0FAskMnwHospM+YfsWnQiSOmkQbKeaK2CMjqQEtbQYC5DcLhTXjRyn2YJZQbuD/UiG/eownDmpZgaqEEjQk9AF51686XQKc5ObS6vi7iIG0UDBSQpOSH4HvsMl5Ha0vNhS3ZWwIB+luMIrV+W2JS8f5pFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488325; c=relaxed/simple;
	bh=Y0aKY+A8WnMWRYzlnK79objhgdxMemgKOX80eTq4/K4=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=naRcHJUffbXdUsPWb6hmNxY2iUWG7EqBm4t0lJbwYdmc3htRWYriUJNPYZRBO1f+3+uikk4TvrUOk6eg4VqjU7YGs05BdxV91+mX6MaSs2IJxD3FgqfPrWGfB8fIM2GAKE6CEN45rzON9Ngp66uH28ZTeJ5Ye16QIGQr7X+eGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDztu/Ed; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDztu/Ed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488321; x=1809024321;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=Y0aKY+A8WnMWRYzlnK79objhgdxMemgKOX80eTq4/K4=;
  b=IDztu/EdHAabUPqUeintvl6tHGrAhC88q5sLzvlQWTKgNzGuVBvwmKl2
   hBCkvszvJW75YKa8ofVJpVFWz70Pe4t7sRMDQD4mJO2guft/Gg+0UkMA+
   GpkYv5Ofk4ZNZim42ejp1RrkiYrTEEi1tRYXBOdO+Dpzj7J9u9jrEntFx
   B9pM+nVQVeB1IGtO0D+F8a4mMUPJGsvIRzRQugu2n0CnOyw6Nh96hUeq1
   k8aeyosio+QP1KM1Yfn7FuWsfEoFDsb26++eTFF7xRZW1DYEAvIgfUIyD
   piQyCusXQXbZsxQp7OOfigO28S+xSe4IPTA0wuRpOc/DU7zXOKQaQEhtU
   g==;
X-CSE-ConnectionGUID: 6Z3KnTH5ThmC1YfqQPfIqw==
X-CSE-MsgGUID: akpLbG8EQIene2AGiS0kgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78322259"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78322259"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:45:20 -0700
X-CSE-ConnectionGUID: i5jP2DffS9ie4IReWIVQKg==
X-CSE-MsgGUID: /GjBj8AxTpCyuAGA9Kn77Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229749570"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa006.fm.intel.com with ESMTP; 29 Apr 2026 11:45:20 -0700
Subject: [PATCH v2 1/8] x86/msr: Use paravirt "calls" in common code
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Apr 2026 11:45:19 -0700
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
In-Reply-To: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
Message-Id: <20260429184519.A701C74E@davehans-spike.ostc.intel.com>
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

Prepare to consolidate the two copies. Have common code use the
paravirt_{rd,wr}msr*() naming and short-circuit the paravirt
infrastructure with the preprocessor to do paravirt=>native without
any paravirt overhead.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff -puN arch/x86/include/asm/msr.h~raw_msr_names arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~raw_msr_names	2026-04-01 14:32:55.572415984 -0700
+++ b/arch/x86/include/asm/msr.h	2026-04-01 14:32:55.575416096 -0700
@@ -173,6 +173,13 @@ static inline u64 native_read_pmc(int co
 #include <asm/paravirt.h>
 #else
 #include <linux/errno.h>
+
+/* Short-circuit the paravirt MSR infrastructure when it is disabled: */
+#define paravirt_read_msr	native_read_msr
+#define paravirt_read_msr_safe	native_read_msr_safe
+#define paravirt_write_msr	native_write_msr
+#define paravirt_write_msr_safe	native_write_msr_safe
+
 /*
  * Access to machine-specific registers (available on 586 and better only)
  * Note: the rd* operations modify the parameters directly (without using
@@ -181,35 +188,35 @@ static inline u64 native_read_pmc(int co
 
 #define rdmsr(msr, low, high)					\
 do {								\
-	u64 __val = native_read_msr((msr));			\
+	u64 __val = paravirt_read_msr((msr));			\
 	(void)((low) = (u32)__val);				\
 	(void)((high) = (u32)(__val >> 32));			\
 } while (0)
 
 static inline void wrmsr(u32 msr, u32 low, u32 high)
 {
-	native_write_msr(msr, (u64)high << 32 | low);
+	paravirt_write_msr(msr, (u64)high << 32 | low);
 }
 
 #define rdmsrq(msr, val)			\
-	((val) = native_read_msr((msr)))
+	((val) = paravirt_read_msr((msr)))
 
 static inline void wrmsrq(u32 msr, u64 val)
 {
-	native_write_msr(msr, val);
+	paravirt_write_msr(msr, val);
 }
 
 /* wrmsr with exception handling */
 static inline int wrmsrq_safe(u32 msr, u64 val)
 {
-	return native_write_msr_safe(msr, val);
+	return paravirt_write_msr_safe(msr, val);
 }
 
 /* rdmsr with exception handling */
 #define rdmsr_safe(msr, low, high)				\
 ({								\
 	u64 __val;						\
-	int __err = native_read_msr_safe((msr), &__val);	\
+	int __err = paravirt_read_msr_safe((msr), &__val);		\
 	(*low) = (u32)__val;					\
 	(*high) = (u32)(__val >> 32);				\
 	__err;							\
@@ -217,7 +224,7 @@ static inline int wrmsrq_safe(u32 msr, u
 
 static inline int rdmsrq_safe(u32 msr, u64 *p)
 {
-	return native_read_msr_safe(msr, p);
+	return paravirt_read_msr_safe(msr, p);
 }
 
 static __always_inline u64 rdpmc(int counter)
_
