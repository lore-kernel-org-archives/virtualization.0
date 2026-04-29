Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B2339B2D
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488330; cv=none; b=e9t8MUSG2h/l3yPIvRcgjHXftw3gj+7WK4OZFyIllrAi9oaY4ZiYyuQWG5ID4k4MhHQ96SulRXsgpNtTg67y8p3ZfnfN94B87s0aZqiKlzieCyo3kb2mJCKBaIjSB3ZMyrHSAwPrDyMiLfPhhW0Fi65tNSkglLrgJtKPbtuFnvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488330; c=relaxed/simple;
	bh=qN/IxUpukvOt7nRSNsCCd2Nj9+wgIEzgfO2ZLjb62d0=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=asGBxcOvjs3Ei7qlvIJNbTmcdktvKwiy54BtLP/HaAur+w37cl0XhAJsC3j1HgiW9BrCywUlz3lLu7BaBdTpauZp53lqBrxkXDQATorudZI84oXR9iI9JqrujUrevcBkHcboEfP60AgzbVphCnC0j+3wo3+A2QM8SskZkwXpygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRfDPVMT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRfDPVMT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488327; x=1809024327;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=qN/IxUpukvOt7nRSNsCCd2Nj9+wgIEzgfO2ZLjb62d0=;
  b=gRfDPVMT8ZC2ucFwZGwaBNz1rFSqbPX0ng5LkTC4Cd4vA8EAnkcFKjtn
   1ll6Wqc6DPA19OqhlTIwnB04ZZoTd1L573D6mjqvjBZgKJ11zJv65WMbq
   Ck9P+bQZUkNT9gEXPuOGEQVc1WfAf5IAWVx85YKSZ5bzZjEBekmUkptmf
   TWl4X46jrL1OaJ+eVvGKbVhApFx4graB39Wq7YYZKfDUXgwH2MvKjU87J
   rCcnfkRAx/8QzXmnULBKIW0DdmfEMy1PEUNwABXxsBZxnxWP1Vp9F0XDH
   qO6PLxKdQhEpdc6tYelgH6ejoVbXQLB15S7tMkNQ9t1sDc4eVB0INBmtF
   Q==;
X-CSE-ConnectionGUID: rJ3yhTzGRC2k58LTyxxeSw==
X-CSE-MsgGUID: n3STmhYoTnCG9ly0m0hXVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78322287"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78322287"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:45:26 -0700
X-CSE-ConnectionGUID: DESRmXiJRVmCPgtb6pOtCw==
X-CSE-MsgGUID: NrMpq/CyTP649JweI2rWoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229749653"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa006.fm.intel.com with ESMTP; 29 Apr 2026 11:45:26 -0700
Subject: [PATCH v2 5/8] x86/msr: Consolidate {rd,wr}msr[q]_safe() implementations
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Apr 2026 11:45:25 -0700
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
In-Reply-To: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
Message-Id: <20260429184525.F1123DA9@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


From: Dave Hansen <dave.hansen@linux.intel.com>

These should be very familiar by now. Move the native implementations
of the "safe" MSR functions out to common code and zap the paravirt.h
version. Do four at once now because these are quite straightforward.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h      |   42 +++++++++++++++++++-------------------
 b/arch/x86/include/asm/paravirt.h |   20 ------------------
 2 files changed, 21 insertions(+), 41 deletions(-)

diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-6 arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~rdmsr-dups-6	2026-04-01 14:32:57.802499509 -0700
+++ b/arch/x86/include/asm/msr.h	2026-04-01 14:32:57.809499772 -0700
@@ -186,27 +186,6 @@ static inline u64 native_read_pmc(int co
  * pointer indirection), this allows gcc to optimize better
  */
 
-static inline void wrmsr(u32 msr, u32 low, u32 high)
-{
-	paravirt_write_msr(msr, (u64)high << 32 | low);
-}
-
-static inline void wrmsrq(u32 msr, u64 val)
-{
-	paravirt_write_msr(msr, val);
-}
-
-/* wrmsr with exception handling */
-static inline int wrmsrq_safe(u32 msr, u64 val)
-{
-	return paravirt_write_msr_safe(msr, val);
-}
-
-static inline int rdmsrq_safe(u32 msr, u64 *p)
-{
-	return paravirt_read_msr_safe(msr, p);
-}
-
 static __always_inline u64 rdpmc(int counter)
 {
 	return native_read_pmc(counter);
@@ -237,6 +216,27 @@ do {								\
 #define rdmsrq(msr, val)			\
 	((val) = paravirt_read_msr((msr)))
 
+static inline int rdmsrq_safe(u32 msr, u64 *p)
+{
+	return paravirt_read_msr_safe(msr, p);
+}
+
+/* wrmsr with exception handling */
+static inline int wrmsrq_safe(u32 msr, u64 val)
+{
+	return paravirt_write_msr_safe(msr, val);
+}
+
+static inline void wrmsr(u32 msr, u32 low, u32 high)
+{
+	paravirt_write_msr(msr, (u64)high << 32 | low);
+}
+
+static inline void wrmsrq(u32 msr, u64 val)
+{
+	paravirt_write_msr(msr, val);
+}
+
 /* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
 #define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
 
diff -puN arch/x86/include/asm/paravirt.h~rdmsr-dups-6 arch/x86/include/asm/paravirt.h
--- a/arch/x86/include/asm/paravirt.h~rdmsr-dups-6	2026-04-01 14:32:57.806499659 -0700
+++ b/arch/x86/include/asm/paravirt.h	2026-04-01 14:32:57.809499772 -0700
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
