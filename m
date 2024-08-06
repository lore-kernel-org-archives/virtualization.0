Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A2C13B2AC
	for <virtualization@lists.linux.dev>; Tue,  6 Aug 2024 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943600; cv=none; b=IxnLADFsj36eNVF/IaD2PaH+dZRFz7NoRHaUozXVqjABteM76hfp+doHGCpGA2Y+qb2ZBSCnZZdIYMGYSqJNFHcMt8J4M4xZjXhlKvPTw9n2kSeGui75jhRask79iRYmA8BdkWBeBKjbNEGf73md69bTNYek3L3OcsoK+0bkiwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943600; c=relaxed/simple;
	bh=v/a5DFPpY0qcChhPxBd1nbKJvdBByOpbdxLltssAPYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ECDHirJC9Q1VHGvtSQaP1nVLcYOhWqS95K27SJ1cmauNn4O4OEqQIzq81wPU8jJG6z5mrSfIBNZikNkuLM9ts0nF7AJyhACUsl/l+wesUHPreLkQQI9NmeBlSL10tVYj2LldCI3ehDMHIAZ5wnO6N3xVHVMeNMD6uf+2EvOaKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHjnCtSE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHjnCtSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722943597; x=1754479597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v/a5DFPpY0qcChhPxBd1nbKJvdBByOpbdxLltssAPYE=;
  b=iHjnCtSEQMvmSlrWq21ghdi54ku/FzZHl5N8sPCdWyZe1RKsR5uexpkt
   J09MXIOTdcQHC4L1dDdXYqZq1MOqepZNRdhkw2H5FdPrftXXd5bunUeVF
   bXt+ET3xfqiI+ex/zGqMtJ3ATZvOKbdUjBbZ88u7GrVKnorLTKVcH1t51
   zXDftip7Y1J85LC/uTqf9NnNdg3B2ht1stsEkt1feqqWWu871ZvV4sDKI
   dUjbF0IRYmOAcMjdwo94y6Sebbhli6vwYOwwNQ+P/1tmOeVHpjrPjhZbA
   SSSxxior0q59i1V4QFcSM6sgJ68IyEGbJB0yem/RqduUehrMxu81KNtgM
   Q==;
X-CSE-ConnectionGUID: K13iw438Q5CPCuvDGRS6cQ==
X-CSE-MsgGUID: 5UinvVGYS9mOSRAMJmMF+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21074707"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="21074707"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 04:26:29 -0700
X-CSE-ConnectionGUID: A9Ymho5/Q2KAjDUlCp/qVg==
X-CSE-MsgGUID: D87H8QQTQ6GI9qLuzWUJgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="61353463"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orviesa005.jf.intel.com with ESMTP; 06 Aug 2024 04:26:26 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	"Nikolay Borisov" <nik.borisov@suse.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	Bibo Mao <maobibo@loongson.cn>,
	Chen Yu <yu.c.chen@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Prem Nath Dey <prem.nath.dey@intel.com>,
	Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: [PATCH v5] x86/paravirt: Fix incorrect virt spinlock setting on bare metal
Date: Tue,  6 Aug 2024 19:22:07 +0800
Message-Id: <20240806112207.29792-1-yu.c.chen@intel.com>
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

In theory, the static key is enabled by default (run in guest mode) and
should be disabled for bare metal (and in some guests that want native
behavior or paravirt spinlock).

Performance drop is reported when running encode/decode workload and
BenchSEE cache sub-workload.
Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
is disabled the virt_spin_lock_key is incorrectly set to true on bare
metal. The qspinlock degenerates to test-and-set spinlock, which
decrease the performance on bare metal.

Set the default value of virt_spin_lock_key to false. If booting in a VM,
enable this key. Later during the VM initialization, if other
high-efficient spinlock is preferred(paravirt-spinlock eg), or the user
wants the native qspinlock(via nopvspin boot commandline), the
virt_spin_lock_key is disabled accordingly.

The relation is described as below:

X86_FEATURE_HYPERVISOR         Y    Y       Y     N
CONFIG_PARAVIRT_SPINLOCKS      Y    Y       N     Y/N
PV spinlock                    Y    N       N     Y/N

virt_spin_lock_key             N    Y/N     Y     N

Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Suggested-by: Nikolay Borisov <nik.borisov@suse.com>
Reported-by: Prem Nath Dey <prem.nath.dey@intel.com>
Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v4->v5:
  Fix the comments around virt_spin_lock_key. (Thomas Gleixner)
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
 arch/x86/include/asm/qspinlock.h | 8 ++++----
 arch/x86/kernel/paravirt.c       | 7 +++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index a053c1293975..dd5b0ea4955f 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -66,13 +66,13 @@ static inline bool vcpu_is_preempted(long cpu)
 
 #ifdef CONFIG_PARAVIRT
 /*
- * virt_spin_lock_key - enables (by default) the virt_spin_lock() hijack.
+ * virt_spin_lock_key - disables (by default) the virt_spin_lock() hijack.
  *
  * Native (and PV wanting native due to vCPU pinning) should disable this key.
- * It is done in this backwards fashion to only have a single direction change,
- * which removes ordering between native_pv_spin_init() and HV setup.
+ * native_pv_lock_init() is invoked before the HV setup. The former enable
+ * the key by default on the VM guest and the latter disable it ondemand.
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

