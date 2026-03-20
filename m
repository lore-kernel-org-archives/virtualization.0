Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B52032E6BD
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033419; cv=none; b=iloa3ki5KwJbpqc+u3Dcxr0Qp71hPOndTJ8565UnX6m5sjXJ+vrx2OKqKphVqRDalcckG4pyH7myKiXfbdDNsF6/PtoWrjMqQ4HqLS7bcpwmtLOPVJefh/kXZdYMAkG7iW2+AVCr+1HkrEFI3yLfDqFpmVWUU1IMVzfHYigTUxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033419; c=relaxed/simple;
	bh=5Nywb1A4D0DNJERpn+D3VtiY6dkhu5dHX5C1KkM7qSs=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=bfYx2fVkLYeYCCIeW12wrDZE3ukStul5dkKH8EAurzv3Wd++RdeEwagU5uub9elQbe/2ufR2hRMFlnE4N6nFWk24qOVIBrz8lXvrnGjEV9A3CZpGfWfBwUWKgGCg7BQUt4+tpOyIDcjb0sKdLNuVWEci0h7C+mUme9P0oGkpbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEWvvTR2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEWvvTR2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774033419; x=1805569419;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=5Nywb1A4D0DNJERpn+D3VtiY6dkhu5dHX5C1KkM7qSs=;
  b=QEWvvTR2gP+egijnakEyhxYZ56DeSh+3qIU8C+3A8i6nVHZUZlNLbazc
   +2Z3y8AzhlmmvT28tezHW+XEvXXsUmZacsTOAj28Phhq0AAodz/+rT9Bn
   /USWWyc+J9Ig/+70qFBX3sG2hrWu6QHW7kgY8V3L20zNeLtEfDc2+XpMM
   z8FiIuIJ6UCagVCmEhOcuSZLUxycDccTL7Wl/EMqiQzl/G27JM5ZR9lwp
   bg9CkBAXifQ/ZLKbfykPWSlAEstghBdtDp9yFWYVOpc4zuhmsUUKF3MPj
   ll6YpN1p/sAWbvKdWejnDCf/AbYvb9Y6yWwaVuMDvka8BCnJQ9spLce6d
   w==;
X-CSE-ConnectionGUID: eL9+euEsQKy05fKhAVPZeg==
X-CSE-MsgGUID: p2ef1UQZSJqbDigvqPrlXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86200670"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86200670"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:03:38 -0700
X-CSE-ConnectionGUID: 75Q9fnvXSBybv3NZ1sA9sA==
X-CSE-MsgGUID: ngZmChCHTVO5gENH+ryrRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222597401"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 20 Mar 2026 12:03:38 -0700
Subject: [PATCH 5/8] x86/msr: Consolidate {rd,wr}msr[q]_safe() implementations
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Mar 2026 12:03:37 -0700
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
In-Reply-To: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
Message-Id: <20260320190337.9AB0C060@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


From: Dave Hansen <dave.hansen@linux.intel.com>

These should be very familiar by now. Use the "raw_" indirection
to consolidate the duplicate implementations. Do four at once now
because these are quite straightforward.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h      |   44 +++++++++++++++++++-------------------
 b/arch/x86/include/asm/paravirt.h |   20 -----------------
 2 files changed, 23 insertions(+), 41 deletions(-)

diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-6 arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~rdmsr-dups-6	2026-03-20 11:24:20.448855576 -0700
+++ b/arch/x86/include/asm/msr.h	2026-03-20 11:24:20.455855887 -0700
@@ -174,6 +174,8 @@ static inline u64 native_read_pmc(int co
 
 #define raw_read_msr		paravirt_read_msr
 #define raw_read_msr_safe	paravirt_read_msr_safe
+#define raw_write_msr		paravirt_write_msr
+#define raw_write_msr_safe	paravirt_write_msr_safe
 
 #else
 #include <linux/errno.h>
@@ -189,27 +191,6 @@ static inline u64 native_read_pmc(int co
  * pointer indirection), this allows gcc to optimize better
  */
 
-static inline void wrmsr(u32 msr, u32 low, u32 high)
-{
-	raw_write_msr(msr, (u64)high << 32 | low);
-}
-
-static inline void wrmsrq(u32 msr, u64 val)
-{
-	raw_write_msr(msr, val);
-}
-
-/* wrmsr with exception handling */
-static inline int wrmsrq_safe(u32 msr, u64 val)
-{
-	return raw_write_msr_safe(msr, val);
-}
-
-static inline int rdmsrq_safe(u32 msr, u64 *p)
-{
-	return raw_read_msr_safe(msr, p);
-}
-
 static __always_inline u64 rdpmc(int counter)
 {
 	return native_read_pmc(counter);
@@ -240,6 +221,27 @@ do {								\
 #define rdmsrq(msr, val)			\
 	((val) = raw_read_msr((msr)))
 
+static inline int rdmsrq_safe(u32 msr, u64 *p)
+{
+	return raw_read_msr_safe(msr, p);
+}
+
+/* wrmsr with exception handling */
+static inline int wrmsrq_safe(u32 msr, u64 val)
+{
+	return raw_write_msr_safe(msr, val);
+}
+
+static inline void wrmsr(u32 msr, u32 low, u32 high)
+{
+	raw_write_msr(msr, (u64)high << 32 | low);
+}
+
+static inline void wrmsrq(u32 msr, u64 val)
+{
+	raw_write_msr(msr, val);
+}
+
 /* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
 #define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
 
diff -puN arch/x86/include/asm/paravirt.h~rdmsr-dups-6 arch/x86/include/asm/paravirt.h
--- a/arch/x86/include/asm/paravirt.h~rdmsr-dups-6	2026-03-20 11:24:20.452855754 -0700
+++ b/arch/x86/include/asm/paravirt.h	2026-03-20 11:24:20.455855887 -0700
@@ -161,26 +161,6 @@ static inline int paravirt_write_msr_saf
 	return PVOP_CALL2(int, pv_ops, cpu.write_msr_safe, msr, val);
 }
 
-static __always_inline void wrmsr(u32 msr, u32 low, u32 high)
-{
-	paravirt_write_msr(msr, (u64)high << 32 | low);
-}
-
-static inline void wrmsrq(u32 msr, u64 val)
-{
-	paravirt_write_msr(msr, val);
-}
-
-static inline int wrmsrq_safe(u32 msr, u64 val)
-{
-	return paravirt_write_msr_safe(msr, val);
-}
-
-static __always_inline int rdmsrq_safe(u32 msr, u64 *p)
-{
-	return paravirt_read_msr_safe(msr, p);
-}
-
 static __always_inline u64 rdpmc(int counter)
 {
 	return PVOP_CALL1(u64, pv_ops, cpu.read_pmc, counter);
_
