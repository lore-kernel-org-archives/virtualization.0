Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8526533A717
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033420; cv=none; b=ijKp5aQeG0UNZHS6k2SadXwmtptOr0hK/DSg0wm8hB3urfoJWOqgrw1DmYIfAbpXDyFF87HISgUlj2EuK8bE4QIeeE2ffnx/+YVmNyKoGp+ImzEi+F6CCmRldfrRVvL6rUUJLwYoZ6Hxs3PjhlX86TGp5ReUTWyFf8tQSVMjALM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033420; c=relaxed/simple;
	bh=z4lz4VdZ/WWI+fk+Bhk/AV/uvEQYEzpG6QNEFitmp2g=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=damGJ6eUP5X19Gx73Xtjwt4QOUsVnTg5dTxcvls+/U2bKd7C/u+wroYR72lRfV5iZA8GQTOlTCeCu6BYIO1TU4wPD1wEhRrHpPUF49GzJMVnqq+JzB3CXwixqmzhhvs1EENOxVeSwWcqvTlrC0lf2jR/Z07lrC9POO5pMpa4lnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFhr+WwX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFhr+WwX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774033420; x=1805569420;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=z4lz4VdZ/WWI+fk+Bhk/AV/uvEQYEzpG6QNEFitmp2g=;
  b=TFhr+WwXvsF10mAAqLHuBD7pOyuyv7WMdVx2fQUkSCD5y5hUetefeXUa
   +H0nFsb48kURhxAWnwpRnKufIiSAd/hcmKz50kbDNnfWGH1HhRFvcr3zw
   5PPoXHSkZJroC5K0+FeCC1txn4yZlWaKzIL8sRvE3hqp29Z9exSF4Zz2v
   ggE18Rvzc9QfdtNf7DA4Nmx1JWKoz35o96q+8r2Bz5R74ILOEgtpmoFsM
   DFGZo3+Z0zCFgOEriyGCUkRsJ4/2iJsm3vnhyfyiB8E1RJ7SmhWSUv9ut
   ldTXa46kQKX+rL/35giq2AbgHqQT+QbPHFF+ER8HtTUVBepamduPZnimo
   w==;
X-CSE-ConnectionGUID: WkbwgmSGQmeeK1G204zWXA==
X-CSE-MsgGUID: ++SPU/j3QeiREKsxe4WI3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86200680"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86200680"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:03:40 -0700
X-CSE-ConnectionGUID: gnQeG6l9QzK00ZqEhzcuUQ==
X-CSE-MsgGUID: FvxfR6bnTmavkrhSEb5IhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222597404"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 20 Mar 2026 12:03:39 -0700
Subject: [PATCH 6/8] x86/msr: Consolidate rdpmc() implementations
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Mar 2026 12:03:38 -0700
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
In-Reply-To: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
Message-Id: <20260320190338.E4E8CA9C@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


From: Dave Hansen <dave.hansen@linux.intel.com>

Doing this is debatable. It does not actually remove any code. But,
rdpmc() is the last thing left in the #ifdef CONFIG_PARAVIRT_XXL
block and this seems like nice consistency.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h      |   12 +++++++-----
 b/arch/x86/include/asm/paravirt.h |    2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-9 arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~rdmsr-dups-9	2026-03-20 11:24:21.013880656 -0700
+++ b/arch/x86/include/asm/msr.h	2026-03-20 11:24:21.020880966 -0700
@@ -176,6 +176,7 @@ static inline u64 native_read_pmc(int co
 #define raw_read_msr_safe	paravirt_read_msr_safe
 #define raw_write_msr		paravirt_write_msr
 #define raw_write_msr_safe	paravirt_write_msr_safe
+#define raw_read_pmc		paravirt_read_pmc
 
 #else
 #include <linux/errno.h>
@@ -184,6 +185,7 @@ static inline u64 native_read_pmc(int co
 #define raw_read_msr_safe	native_read_msr_safe
 #define raw_write_msr		native_write_msr
 #define raw_write_msr_safe	native_write_msr_safe
+#define raw_read_pmc		native_read_pmc
 
 /*
  * Access to machine-specific registers (available on 586 and better only)
@@ -191,11 +193,6 @@ static inline u64 native_read_pmc(int co
  * pointer indirection), this allows gcc to optimize better
  */
 
-static __always_inline u64 rdpmc(int counter)
-{
-	return native_read_pmc(counter);
-}
-
 #endif	/* !CONFIG_PARAVIRT_XXL */
 
 /*
@@ -242,6 +239,11 @@ static inline void wrmsrq(u32 msr, u64 v
 	raw_write_msr(msr, val);
 }
 
+static __always_inline u64 rdpmc(int counter)
+{
+	return raw_read_pmc(counter);
+}
+
 /* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
 #define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
 
diff -puN arch/x86/include/asm/paravirt.h~rdmsr-dups-9 arch/x86/include/asm/paravirt.h
--- a/arch/x86/include/asm/paravirt.h~rdmsr-dups-9	2026-03-20 11:24:21.017880833 -0700
+++ b/arch/x86/include/asm/paravirt.h	2026-03-20 11:24:21.020880966 -0700
@@ -161,7 +161,7 @@ static inline int paravirt_write_msr_saf
 	return PVOP_CALL2(int, pv_ops, cpu.write_msr_safe, msr, val);
 }
 
-static __always_inline u64 rdpmc(int counter)
+static __always_inline u64 paravirt_read_pmc(int counter)
 {
 	return PVOP_CALL1(u64, pv_ops, cpu.read_pmc, counter);
 }
_
