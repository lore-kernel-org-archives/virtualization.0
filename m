Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7181AC7
	for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236141; cv=none; b=jqRc3d55vTpI73ylA97yC9hYTlFaSyBwZ+zVwDQJT9wsbI5S1dlV/3AN9gCLGsLLP9COYpRNWFP8KSvnlwzMzAUDLbADYE97psPfUpnzNer3c3Ic5+SToE9rG7bInehbMucn8a0LtdPdyNNxScO4AXKom9OSR9oBfkyXOi4F1XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236141; c=relaxed/simple;
	bh=t9WFIarv73AZEvBKbhxzMcs+pS7bmSdYAtdum2xSX3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QGMJoTpwJcUyd5v+sKaDrs+odA3dirpxtbvXDhmAAakzkHz6VFzmRsjR3ku0YBzvP+DmAePftwMhBJrrOB/3tc8sOK7W+dU0lhkcSwOHKHPA39bhM+kB7nrNqoTEETb4s1w51JbNHlrIYwIJ6LudRaSA5Gw5sVqj+SkCHHIxWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQASMdqF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQASMdqF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722236139; x=1753772139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t9WFIarv73AZEvBKbhxzMcs+pS7bmSdYAtdum2xSX3s=;
  b=QQASMdqFytu2OgMuWed7fEGEn7gxihZ5lzZVW3+tmogAdOba6go0zypy
   dq3KgMStGBoKjZ9eTUh6VJNnNQrXMCeCi12ZbOMt6ocW9H1YxsmD5yhPJ
   FxVQwTQVE9hDeCYCPFTOOyBE9l729VWJgZLN1GDNpQBQOyUpeDVa0wTTf
   +w+rcOwPDyTckT4eOJfuPiRW1KwABlR7UA53/OMDBJWfrMiC90Cy0sAOt
   vwqBSk+VOenCWLeV/qcjZOqgJky6NnMuql1/mQmpMBYjWObqKr5v4Qnm7
   VV7KY/8iERHr4fKHNssjEvdmhhlzbQXs74T4jCrMPIGGBfaW5iT8bK3Qz
   A==;
X-CSE-ConnectionGUID: +VOEb1S0QdW3cQkr2dgDJw==
X-CSE-MsgGUID: KLggv1C4SCWf+kBuXB3bkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="12761494"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="12761494"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 23:55:38 -0700
X-CSE-ConnectionGUID: UMLHWNZQQHSj58Y/F6dpQg==
X-CSE-MsgGUID: OwZd8RdyS+eHATiRHxBPCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="54120129"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orviesa006.jf.intel.com with ESMTP; 28 Jul 2024 23:55:35 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	"Nikolay Borisov" <nik.borisov@suse.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Prem Nath Dey <prem.nath.dey@intel.com>,
	Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: [PATCH v4] x86/paravirt: Disable virt spinlock on bare metal
Date: Mon, 29 Jul 2024 14:52:36 +0800
Message-Id: <20240729065236.407758-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel can change spinlock behavior when running as a guest. But
this guest-friendly behavior causes performance problems on bare metal.
So there's a 'virt_spin_lock_key' static key to switch between the two
modes.

In current code, the static key is always enabled by default when
running in guest mode. The key is disabled for bare metal (and in
some guests that want native behavior).

Large performance regression is reported when running encode/decode
workload and BenchSEE cache sub-workload on the bare metal.
Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
is disabled, the virt_spin_lock_key is incorrectly set to true on bare
metal. The qspinlock degenerates to test-and-set spinlock, which
decrease the performance on bare metal.

Set the default value of virt_spin_lock_key to false. If booting in
a VM, enable this key. Later during the VM initialization, if other
high-efficient spinlock is detected(paravirt-spinlock eg), the
virt_spin_lock_key is disabled. According to the description above,
the final effect will be as followed:

X86_FEATURE_HYPERVISOR         Y    Y    Y     N
CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
PV spinlock                    Y    N    N     Y/N

virt_spin_lock_key             N    N    Y     N

To summarize, the virt_spin_lock_key is disabled on the bare metal
no matter what other condidtion is. And the virt_spin_lock_key is
also disabled when other spinlock mechanism is detected in the VM
guest.

Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Suggested-by: Nikolay Borisov <nik.borisov@suse.com>
Reported-by: Prem Nath Dey <prem.nath.dey@intel.com>
Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v3->v4:
  Refine the commit log.
  Added Reviewed-by tag from Nikolay.
v2->v3:
  Change the default value of virt_spin_lock_key from true to false.
  Enable this key when it is in the VM, and disable it when needed.
  This makes the code more readable. (Nikolay Borisov)
  Dropped Reviewed-by because the code has been changed.
v1->v2:
  Refine the commit log per Dave's suggestion.
  Simplify the fix by directly disabling the virt_spin_lock_key on bare metal.
  Collect Reviewed-by from Juergen.
---
 arch/x86/include/asm/qspinlock.h | 4 ++--
 arch/x86/kernel/paravirt.c       | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index a053c1293975..a32bd2aabdf9 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -66,13 +66,13 @@ static inline bool vcpu_is_preempted(long cpu)
 
 #ifdef CONFIG_PARAVIRT
 /*
- * virt_spin_lock_key - enables (by default) the virt_spin_lock() hijack.
+ * virt_spin_lock_key - disables (by default) the virt_spin_lock() hijack.
  *
  * Native (and PV wanting native due to vCPU pinning) should disable this key.
  * It is done in this backwards fashion to only have a single direction change,
  * which removes ordering between native_pv_spin_init() and HV setup.
  */
-DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
+DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
 
 /*
  * Shortcut for the queued_spin_lock_slowpath() function that allows
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5358d43886ad..fec381533555 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -51,13 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
 DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
 #endif
 
-DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
+DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
 
 void __init native_pv_lock_init(void)
 {
-	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
-	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		static_branch_disable(&virt_spin_lock_key);
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		static_branch_enable(&virt_spin_lock_key);
 }
 
 static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
-- 
2.25.1

