Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FFD4218A9
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488327; cv=none; b=eXOOk5Fhld4njMVC1ks0bgdGcX5q6c3XdTIqbAZ/l5aWGU99BndqytzTRywPYoX2XK9JeJXJAAE9wP2IeJVVK6zj39lNpZPGb5RFNEwgx7Q95Dx5kf1DJpoTN0d3LVcdfrfCytA4HfI+ggNlKhft8Zdvcc1M8MnbxXduy9bfGT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488327; c=relaxed/simple;
	bh=MiD2O5l5b6bczKAjI37QxnoqTeJZdSks8jGHE8IekPU=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=DQxJ+Rro2RPMKyLXkUI1DnbrhSBbwDQ+HaZWck6RNFON+5f5/otIutWpNdHOa+xl8Z3gWQj4f1ey0B9jcxtTl2BpLUD0VL4OrdyixllMdjSrO0GXSsjiYj0UfVLclW0nki7U5x07ObaxnuLMQBJtLWJn8bnUgxiDNpqn7yyqwpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKRZY2f2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKRZY2f2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488324; x=1809024324;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=MiD2O5l5b6bczKAjI37QxnoqTeJZdSks8jGHE8IekPU=;
  b=DKRZY2f2yPqZviDao8a2lT8YvpMY93iteYF2acMw8nH/dNWwig4x3ExG
   wMf47+6RDD1HsSn+2AUZmCXF4+RczkKA7G5m7yzGeakjWMHmfONXPPgkf
   x08qXa+aJHZ4UAZNsRVrnnmtepiMPkaUPG2xgRUzR3bgomJOvqEXxZAtY
   aBUXC5M9jEZGAjI5dnP82AQhzOCoQjVq0vddIkyzFThd7Q0u7VQvOTts0
   +9vWYM33efO5e3z98/Z+wlFcpEIXl3jYZht35micuwlY5I/t1O3h7ik+M
   MTt21kA/vWKqmX2J6RNCQSyhcuAI0nUPTTO5req17SSsu7YiDeEn5og8g
   Q==;
X-CSE-ConnectionGUID: KqdbO3hrQKaCYfjFjag1Aw==
X-CSE-MsgGUID: otrMqBtfRr2YmTbK3MrOOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78322265"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78322265"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:45:21 -0700
X-CSE-ConnectionGUID: qxQvwLq2QQKzE6vbroJwEg==
X-CSE-MsgGUID: cdzhtTpMRMKbbakiFMYJfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229749591"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa006.fm.intel.com with ESMTP; 29 Apr 2026 11:45:21 -0700
Subject: [PATCH v2 2/8] x86/msr: Consolidate rdmsr() definitions
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Apr 2026 11:45:21 -0700
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
In-Reply-To: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
Message-Id: <20260429184521.7AADEE4C@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


From: Dave Hansen <dave.hansen@linux.intel.com>

The paravirt and native code define very similar rdmsr()
implementations. Move the non-paravirt one out to common code where
both the "native" and "paravirt" implementations can use it.

Remove the now duplicate paravirt rdmsr().

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h      |   17 ++++++++++-------
 b/arch/x86/include/asm/paravirt.h |    7 -------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-2 arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~rdmsr-dups-2	2026-04-01 14:32:56.105435948 -0700
+++ b/arch/x86/include/asm/msr.h	2026-04-01 14:32:56.112436210 -0700
@@ -186,13 +186,6 @@ static inline u64 native_read_pmc(int co
  * pointer indirection), this allows gcc to optimize better
  */
 
-#define rdmsr(msr, low, high)					\
-do {								\
-	u64 __val = paravirt_read_msr((msr));			\
-	(void)((low) = (u32)__val);				\
-	(void)((high) = (u32)(__val >> 32));			\
-} while (0)
-
 static inline void wrmsr(u32 msr, u32 low, u32 high)
 {
 	paravirt_write_msr(msr, (u64)high << 32 | low);
@@ -234,6 +227,16 @@ static __always_inline u64 rdpmc(int cou
 
 #endif	/* !CONFIG_PARAVIRT_XXL */
 
+/*
+ * Common paravirt and native helpers:
+ */
+#define rdmsr(msr, low, high)					\
+do {								\
+	u64 __val = paravirt_read_msr((msr));			\
+	(void)((low) = (u32)__val);				\
+	(void)((high) = (u32)(__val >> 32));			\
+} while (0)
+
 /* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
 #define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
 
diff -puN arch/x86/include/asm/paravirt.h~rdmsr-dups-2 arch/x86/include/asm/paravirt.h
--- a/arch/x86/include/asm/paravirt.h~rdmsr-dups-2	2026-04-01 14:32:56.109436097 -0700
+++ b/arch/x86/include/asm/paravirt.h	2026-04-01 14:32:56.112436210 -0700
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
