Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94962882CD
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488333; cv=none; b=Y3WwsghHZk/kwfcpDLLe8fn/xl4wiNp3nO5dgU+P33XmECqazZGNSZg+0Dxez643UvmfICj8/m1KuLvnWQcFiwq+/CBJ/He//m0OOgytrWk/5676io/FkOTCFMst9EjBGGheDAekDthfHQCFrJT8eEJpyClvEukSklDMioir0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488333; c=relaxed/simple;
	bh=Y9FnifN/Dg8WbTkmF30oCE5fyUvQsfM3WhCb8J5tuFg=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=elp7e4s/ZgSSdYNDuCE4A+03nrtVBMV4mTPZhTWpxmaDVhcREfTRwtVHDrStyMhEAkIhQjvDcEmzY5IPvQYxcmhutqmIbzGb7/nxjFTnqGdfZNq0IJsacgsI9SZi3tDKtYRoTOqx9T6tttsA00ypSECaGFOmxV2m9OIDGrH+Wks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/41oVVt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/41oVVt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488329; x=1809024329;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=Y9FnifN/Dg8WbTkmF30oCE5fyUvQsfM3WhCb8J5tuFg=;
  b=b/41oVVtJjs1sJOgnuI+22+/8iZEs0EG79fM3ecYerLU2tu+eXxxCTLz
   CHVqeZWDrG3vFUaLYg0kCjLK+W57vqEbMPzSVF7EB2yR6PSWQBCGIv13K
   qg5/4q1i9bcBcFGijNJRy2QKTtrjAeqtopgwlE+zm94xFzbbxnvWS0A+X
   xiyEbRBnf4eTmxZccFdOjG/Bj2xVA2yg7DjGa8na96QWXS4hFUlxBpWO+
   zlv21qo04OFd+7+6ISA1PtjyN2Uenxw4cLWI93I4n+1E5ITHNWqc55RxG
   H7+4ZHG88PB0Yt7LOS8BMt1psteD4AZrBDwnRMdfZDJe4wCGs+5wunwEu
   w==;
X-CSE-ConnectionGUID: LHntGaUaQj6PkFz8S64bPg==
X-CSE-MsgGUID: /eMCZ1M+RnKMgwc+zRE4mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78322294"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78322294"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:45:27 -0700
X-CSE-ConnectionGUID: NDrQs57ZS7yPmkdZezNOgw==
X-CSE-MsgGUID: Sfx8e8iXQviZ1fUoWXs+yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229749671"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa006.fm.intel.com with ESMTP; 29 Apr 2026 11:45:27 -0700
Subject: [PATCH v2 6/8] x86/msr: Consolidate rdpmc() implementations
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Apr 2026 11:45:27 -0700
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
In-Reply-To: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
Message-Id: <20260429184527.E9C6895C@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


From: Dave Hansen <dave.hansen@linux.intel.com>

Doing this is debatable. It does not actually remove any code. But,
this makes rdpmc() follow the same pattern as all of the MSR functions
where paravirt.h defines a paravirt_foo() function and then msr.h
uses that function in common code.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h      |   11 ++++++-----
 b/arch/x86/include/asm/paravirt.h |    2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-9 arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~rdmsr-dups-9	2026-04-01 14:32:58.366520634 -0700
+++ b/arch/x86/include/asm/msr.h	2026-04-01 14:32:58.373520897 -0700
@@ -179,6 +179,7 @@ static inline u64 native_read_pmc(int co
 #define paravirt_read_msr_safe	native_read_msr_safe
 #define paravirt_write_msr	native_write_msr
 #define paravirt_write_msr_safe	native_write_msr_safe
+#define paravirt_read_pmc		native_read_pmc
 
 /*
  * Access to machine-specific registers (available on 586 and better only)
@@ -186,11 +187,6 @@ static inline u64 native_read_pmc(int co
  * pointer indirection), this allows gcc to optimize better
  */
 
-static __always_inline u64 rdpmc(int counter)
-{
-	return native_read_pmc(counter);
-}
-
 #endif	/* !CONFIG_PARAVIRT_XXL */
 
 /*
@@ -237,6 +233,11 @@ static inline void wrmsrq(u32 msr, u64 v
 	paravirt_write_msr(msr, val);
 }
 
+static __always_inline u64 rdpmc(int counter)
+{
+	return paravirt_read_pmc(counter);
+}
+
 /* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
 #define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
 
diff -puN arch/x86/include/asm/paravirt.h~rdmsr-dups-9 arch/x86/include/asm/paravirt.h
--- a/arch/x86/include/asm/paravirt.h~rdmsr-dups-9	2026-04-01 14:32:58.370520784 -0700
+++ b/arch/x86/include/asm/paravirt.h	2026-04-01 14:32:58.373520897 -0700
@@ -161,7 +161,7 @@ static inline int paravirt_write_msr_saf
 	return PVOP_CALL2(int, pv_ops, cpu.write_msr_safe, msr, val);
 }
 
-static __always_inline u64 rdpmc(int counter)
+static __always_inline u64 paravirt_read_pmc(int counter)
 {
 	return PVOP_CALL1(u64, pv_ops, cpu.read_pmc, counter);
 }
_
