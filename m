Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A849332C94B
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033418; cv=none; b=PCUFPxlcIMH7F+0wRdb8xdw/MpWjDiq224g7yY+GCLVIKftFt2e22XfGWXnUu50ug8t3Udps4yoOWyr0iWbhGbtJTkGHhVCQN09q508ssLiysqY4rTzax/qSx2jtIIs6bwck1Zh9FiuEGFj4DCqTH1owk5jZiKqbvTz+MKgVqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033418; c=relaxed/simple;
	bh=WUFJkwWWYbFxifoRQPvVcheLJebd7y0iry3JSqtNTSc=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=oa8V2JBjx1Bt2rJQQvpLeF/e6XypatHN1tSjoeXF+aPuzhPM9elY/QmgMMpnxuqMwKsJ5xFHIGGRTmw20gkFHriAJr7JR+y1WxV95n7wUDNcb2Qf7tIJI0BM1ae2AQazYGhKT9HZl+xWkZYHBYl5UdNSAJGUBLCowemL0GWPE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWv8KiuS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWv8KiuS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774033418; x=1805569418;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=WUFJkwWWYbFxifoRQPvVcheLJebd7y0iry3JSqtNTSc=;
  b=aWv8KiuSX5QSK3fcAjJQnjavYwS9VNfRJiqNrIuuasTnv9Q2awE00oWE
   Dtj2+mVtDc118Gi3QJIghkSivUCrtLO9nirSclqTpujjPalhWWY8qlBuu
   srnOMDF93PVhCg8T511Fstb9cX6CRInncxx7swvBIojmYIUbuW2p41cKP
   8RW3dUTyRpObs6IjwKsG+S6DgC/DQUuUxVblMXpDbV1N0IAlz3vjroFPV
   DNOwlZyMFI6Um5nxfAND1Zjfm2v0x60osaJ2lWpHWns5VLSV13zdEAdIw
   2AntG+jsHPOQlVo/ogT/tBQraGY7fWZKPa4iYH/ZB6ZTLrJeQKvNORmzs
   w==;
X-CSE-ConnectionGUID: mm9+U8GxQdKC7YjI0aczYg==
X-CSE-MsgGUID: T7kpHTcyRlKPRnaKMOVGvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86200661"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86200661"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:03:37 -0700
X-CSE-ConnectionGUID: Dnbh9/DmTZSesGgV5oGwOQ==
X-CSE-MsgGUID: 11xWcMSvQT+uOARD+mQpdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222597400"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 20 Mar 2026 12:03:36 -0700
Subject: [PATCH 4/8] x86/msr: Consolidate rdmsrq() implementations
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Mar 2026 12:03:36 -0700
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
In-Reply-To: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
Message-Id: <20260320190336.3577EA1C@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


From: Dave Hansen <dave.hansen@linux.intel.com>

Use the new "raw_" indirection and consolidate the two rdmsrq()
implementations down to one.

The paravirt implementation was probably better, but just stick
with the native one here for consistency.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h      |    6 +++---
 b/arch/x86/include/asm/paravirt.h |    5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-5 arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~rdmsr-dups-5	2026-03-20 11:24:19.885830584 -0700
+++ b/arch/x86/include/asm/msr.h	2026-03-20 11:24:19.892830895 -0700
@@ -194,9 +194,6 @@ static inline void wrmsr(u32 msr, u32 lo
 	raw_write_msr(msr, (u64)high << 32 | low);
 }
 
-#define rdmsrq(msr, val)			\
-	((val) = raw_read_msr((msr)))
-
 static inline void wrmsrq(u32 msr, u64 val)
 {
 	raw_write_msr(msr, val);
@@ -240,6 +237,9 @@ do {								\
 	__err;							\
 })
 
+#define rdmsrq(msr, val)			\
+	((val) = raw_read_msr((msr)))
+
 /* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
 #define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
 
diff -puN arch/x86/include/asm/paravirt.h~rdmsr-dups-5 arch/x86/include/asm/paravirt.h
--- a/arch/x86/include/asm/paravirt.h~rdmsr-dups-5	2026-03-20 11:24:19.888830717 -0700
+++ b/arch/x86/include/asm/paravirt.h	2026-03-20 11:24:19.891830851 -0700
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
