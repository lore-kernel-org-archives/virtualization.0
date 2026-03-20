Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36002D97AA
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033418; cv=none; b=S9xJnYG+HqSiXoh/LiK21PNaVpacjx8yTE3eEUfat9JzQiNO4EjXmJSLe10R4p30ymktaPjyFY1wMktEL055/WHrQl2oOLRg2tSwz8jjHVuEzrmvKDnoaOeQo4X9jyvlYILrlLzXKxUBqElKefNsOr3WIejyhkoKpG3jNIGPdro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033418; c=relaxed/simple;
	bh=QWVKTdMCAIbNnmk3dOIJM1brn39TTZL6c+I8yvapoQs=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=fGupUNkyXR3lMSmf7dhb6D+B2X4yPfJOtx0aE1fGNqA+OAmHsNeQTNRTB/2eoan6lvG10YcQBzlBrvmSVWOmCGWmZcOC02pjakW8v6rK0npB0XXRUzXHftQhif7Gx4Z4OvJrhMtsJB96/KUTpH4pS57oSbgdq0KuG59zRIFb9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jByG1c3G; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jByG1c3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774033417; x=1805569417;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=QWVKTdMCAIbNnmk3dOIJM1brn39TTZL6c+I8yvapoQs=;
  b=jByG1c3G1dJrooXzI3kYtNkesdylOWGNrsS+ZpHxWkU4UIahqNxWN9ZA
   yFmDnuYZ25+MhIF20KkxcBjAlXLmL0p57haMJB+5l3fUiO4hk8FePo/IZ
   2GCCfxkf1vIG8DQPPxJjGkmi1g/eMtOXElfnBqnTbHimasaaij0v6ERxp
   rej/QHY/5wQRUcTsxovc0YarvpkqdeI3kttd9wY5UYNSOQugJeftpgmAz
   VUjH4gmZ/W3mV5lsb9ZhFfoGwhqvmMKCKYxBR6qnLPRYVogegtlK/KruP
   4jCjA1AA9AXQK26HJYl3EfsGq2Mf+UepNUEA4fHvCCZCwEYbvVtoTKJ8C
   w==;
X-CSE-ConnectionGUID: ov4LbXQ8R+SlWQzhvAwm6Q==
X-CSE-MsgGUID: 0Up25PdWR0a43IkGJ+44Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86200643"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86200643"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:03:36 -0700
X-CSE-ConnectionGUID: UUGms6zIQyWmgSGUW1KsMw==
X-CSE-MsgGUID: zTN8FeRqTjih0vfjcVVjvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222597397"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 20 Mar 2026 12:03:35 -0700
Subject: [PATCH 3/8] x86/msr: Consolidate rdmsr_safe() implementations
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Mar 2026 12:03:34 -0700
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
In-Reply-To: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
Message-Id: <20260320190334.85A60DAD@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


From: Dave Hansen <dave.hansen@linux.intel.com>

Use the new "raw_" indirection and consolidate the two rdmsr_safe()
implementations down to one.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h      |   21 +++++++++++----------
 b/arch/x86/include/asm/paravirt.h |   10 ----------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-4 arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~rdmsr-dups-4	2026-03-20 11:24:19.323805632 -0700
+++ b/arch/x86/include/asm/msr.h	2026-03-20 11:24:19.330805942 -0700
@@ -173,6 +173,7 @@ static inline u64 native_read_pmc(int co
 #include <asm/paravirt.h>
 
 #define raw_read_msr		paravirt_read_msr
+#define raw_read_msr_safe	paravirt_read_msr_safe
 
 #else
 #include <linux/errno.h>
@@ -207,16 +208,6 @@ static inline int wrmsrq_safe(u32 msr, u
 	return raw_write_msr_safe(msr, val);
 }
 
-/* rdmsr with exception handling */
-#define rdmsr_safe(msr, low, high)				\
-({								\
-	u64 __val;						\
-	int __err = raw_read_msr_safe((msr), &__val);		\
-	(*low) = (u32)__val;					\
-	(*high) = (u32)(__val >> 32);				\
-	__err;							\
-})
-
 static inline int rdmsrq_safe(u32 msr, u64 *p)
 {
 	return raw_read_msr_safe(msr, p);
@@ -239,6 +230,16 @@ do {								\
 	(void)((high) = (u32)(__val >> 32));			\
 } while (0)
 
+/* rdmsr with exception handling */
+#define rdmsr_safe(msr, low, high)				\
+({								\
+	u64 __val;						\
+	int __err = raw_read_msr_safe((msr), &__val);		\
+	(*low) = (u32)__val;					\
+	(*high) = (u32)(__val >> 32);				\
+	__err;							\
+})
+
 /* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
 #define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
 
diff -puN arch/x86/include/asm/paravirt.h~rdmsr-dups-4 arch/x86/include/asm/paravirt.h
--- a/arch/x86/include/asm/paravirt.h~rdmsr-dups-4	2026-03-20 11:24:19.327805809 -0700
+++ b/arch/x86/include/asm/paravirt.h	2026-03-20 11:24:19.330805942 -0700
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
