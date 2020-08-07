Return-Path: <SRS0=Ra46=BR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A32C433E0
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 08:38:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7DED22CAE
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 08:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DED22CAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8737120477;
	Fri,  7 Aug 2020 08:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7lo2i+yBZkCH; Fri,  7 Aug 2020 08:38:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9512325281;
	Fri,  7 Aug 2020 08:38:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87070C0050;
	Fri,  7 Aug 2020 08:38:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ED2DC004C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 08:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0B96386B7A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 08:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c0ZpK6dFYM-Z
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 08:38:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B37C686AE2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 08:38:33 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0815AB642;
 Fri,  7 Aug 2020 08:38:50 +0000 (UTC)
From: Juergen Gross <jgross@suse.com>
To: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v3 4/7] x86/paravirt: remove 32-bit support from PARAVIRT_XXL
Date: Fri,  7 Aug 2020 10:38:23 +0200
Message-Id: <20200807083826.16794-5-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807083826.16794-1-jgross@suse.com>
References: <20200807083826.16794-1-jgross@suse.com>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The last 32-bit user of stuff under CONFIG_PARAVIRT_XXL is gone.

Remove 32-bit specific parts.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |  1 +
 arch/x86/include/asm/paravirt.h             | 92 +++------------------
 arch/x86/include/asm/paravirt_types.h       | 21 -----
 arch/x86/include/asm/pgtable-3level_types.h |  5 --
 arch/x86/include/asm/segment.h              |  4 -
 arch/x86/kernel/cpu/common.c                |  8 --
 arch/x86/kernel/kprobes/core.c              |  1 -
 arch/x86/kernel/kprobes/opt.c               |  1 -
 arch/x86/kernel/paravirt.c                  | 18 ----
 arch/x86/kernel/paravirt_patch.c            | 17 ----
 arch/x86/xen/enlighten_pv.c                 |  6 --
 11 files changed, 13 insertions(+), 161 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
index 84a4a73f77f7..283ed9d00426 100644
--- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
@@ -14,6 +14,7 @@
 #undef CONFIG_ILLEGAL_POINTER_VALUE
 #undef CONFIG_SPARSEMEM_VMEMMAP
 #undef CONFIG_NR_CPUS
+#undef CONFIG_PARAVIRT_XXL
 
 #define CONFIG_X86_32 1
 #define CONFIG_PGTABLE_LEVELS 2
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 3d2afecde50c..dedc89a07826 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -160,8 +160,6 @@ static inline void wbinvd(void)
 	PVOP_VCALL0(cpu.wbinvd);
 }
 
-#define get_kernel_rpl()  (pv_info.kernel_rpl)
-
 static inline u64 paravirt_read_msr(unsigned msr)
 {
 	return PVOP_CALL1(u64, cpu.read_msr, msr);
@@ -277,12 +275,10 @@ static inline void load_TLS(struct thread_struct *t, unsigned cpu)
 	PVOP_VCALL2(cpu.load_tls, t, cpu);
 }
 
-#ifdef CONFIG_X86_64
 static inline void load_gs_index(unsigned int gs)
 {
 	PVOP_VCALL1(cpu.load_gs_index, gs);
 }
-#endif
 
 static inline void write_ldt_entry(struct desc_struct *dt, int entry,
 				   const void *desc)
@@ -377,10 +373,7 @@ static inline pte_t __pte(pteval_t val)
 {
 	pteval_t ret;
 
-	if (sizeof(pteval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pteval_t, mmu.make_pte, val, (u64)val >> 32);
-	else
-		ret = PVOP_CALLEE1(pteval_t, mmu.make_pte, val);
+	ret = PVOP_CALLEE1(pteval_t, mmu.make_pte, val);
 
 	return (pte_t) { .pte = ret };
 }
@@ -389,11 +382,7 @@ static inline pteval_t pte_val(pte_t pte)
 {
 	pteval_t ret;
 
-	if (sizeof(pteval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pteval_t, mmu.pte_val,
-				   pte.pte, (u64)pte.pte >> 32);
-	else
-		ret = PVOP_CALLEE1(pteval_t, mmu.pte_val, pte.pte);
+	ret = PVOP_CALLEE1(pteval_t, mmu.pte_val, pte.pte);
 
 	return ret;
 }
@@ -402,10 +391,7 @@ static inline pgd_t __pgd(pgdval_t val)
 {
 	pgdval_t ret;
 
-	if (sizeof(pgdval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pgdval_t, mmu.make_pgd, val, (u64)val >> 32);
-	else
-		ret = PVOP_CALLEE1(pgdval_t, mmu.make_pgd, val);
+	ret = PVOP_CALLEE1(pgdval_t, mmu.make_pgd, val);
 
 	return (pgd_t) { ret };
 }
@@ -414,11 +400,7 @@ static inline pgdval_t pgd_val(pgd_t pgd)
 {
 	pgdval_t ret;
 
-	if (sizeof(pgdval_t) > sizeof(long))
-		ret =  PVOP_CALLEE2(pgdval_t, mmu.pgd_val,
-				    pgd.pgd, (u64)pgd.pgd >> 32);
-	else
-		ret =  PVOP_CALLEE1(pgdval_t, mmu.pgd_val, pgd.pgd);
+	ret =  PVOP_CALLEE1(pgdval_t, mmu.pgd_val, pgd.pgd);
 
 	return ret;
 }
@@ -438,51 +420,32 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned
 					   pte_t *ptep, pte_t old_pte, pte_t pte)
 {
 
-	if (sizeof(pteval_t) > sizeof(long))
-		/* 5 arg words */
-		pv_ops.mmu.ptep_modify_prot_commit(vma, addr, ptep, pte);
-	else
-		PVOP_VCALL4(mmu.ptep_modify_prot_commit,
-			    vma, addr, ptep, pte.pte);
+	PVOP_VCALL4(mmu.ptep_modify_prot_commit, vma, addr, ptep, pte.pte);
 }
 
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
-	if (sizeof(pteval_t) > sizeof(long))
-		PVOP_VCALL3(mmu.set_pte, ptep, pte.pte, (u64)pte.pte >> 32);
-	else
-		PVOP_VCALL2(mmu.set_pte, ptep, pte.pte);
+	PVOP_VCALL2(mmu.set_pte, ptep, pte.pte);
 }
 
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
-	if (sizeof(pteval_t) > sizeof(long))
-		/* 5 arg words */
-		pv_ops.mmu.set_pte_at(mm, addr, ptep, pte);
-	else
-		PVOP_VCALL4(mmu.set_pte_at, mm, addr, ptep, pte.pte);
+	PVOP_VCALL4(mmu.set_pte_at, mm, addr, ptep, pte.pte);
 }
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
 	pmdval_t val = native_pmd_val(pmd);
 
-	if (sizeof(pmdval_t) > sizeof(long))
-		PVOP_VCALL3(mmu.set_pmd, pmdp, val, (u64)val >> 32);
-	else
-		PVOP_VCALL2(mmu.set_pmd, pmdp, val);
+	PVOP_VCALL2(mmu.set_pmd, pmdp, val);
 }
 
-#if CONFIG_PGTABLE_LEVELS >= 3
 static inline pmd_t __pmd(pmdval_t val)
 {
 	pmdval_t ret;
 
-	if (sizeof(pmdval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pmdval_t, mmu.make_pmd, val, (u64)val >> 32);
-	else
-		ret = PVOP_CALLEE1(pmdval_t, mmu.make_pmd, val);
+	ret = PVOP_CALLEE1(pmdval_t, mmu.make_pmd, val);
 
 	return (pmd_t) { ret };
 }
@@ -491,11 +454,7 @@ static inline pmdval_t pmd_val(pmd_t pmd)
 {
 	pmdval_t ret;
 
-	if (sizeof(pmdval_t) > sizeof(long))
-		ret =  PVOP_CALLEE2(pmdval_t, mmu.pmd_val,
-				    pmd.pmd, (u64)pmd.pmd >> 32);
-	else
-		ret =  PVOP_CALLEE1(pmdval_t, mmu.pmd_val, pmd.pmd);
+	ret =  PVOP_CALLEE1(pmdval_t, mmu.pmd_val, pmd.pmd);
 
 	return ret;
 }
@@ -504,12 +463,9 @@ static inline void set_pud(pud_t *pudp, pud_t pud)
 {
 	pudval_t val = native_pud_val(pud);
 
-	if (sizeof(pudval_t) > sizeof(long))
-		PVOP_VCALL3(mmu.set_pud, pudp, val, (u64)val >> 32);
-	else
-		PVOP_VCALL2(mmu.set_pud, pudp, val);
+	PVOP_VCALL2(mmu.set_pud, pudp, val);
 }
-#if CONFIG_PGTABLE_LEVELS >= 4
+
 static inline pud_t __pud(pudval_t val)
 {
 	pudval_t ret;
@@ -574,29 +530,6 @@ static inline void p4d_clear(p4d_t *p4dp)
 	set_p4d(p4dp, __p4d(0));
 }
 
-#endif	/* CONFIG_PGTABLE_LEVELS == 4 */
-
-#endif	/* CONFIG_PGTABLE_LEVELS >= 3 */
-
-#ifdef CONFIG_X86_PAE
-/* Special-case pte-setting operations for PAE, which can't update a
-   64-bit pte atomically */
-static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
-{
-	PVOP_VCALL3(mmu.set_pte_atomic, ptep, pte.pte, pte.pte >> 32);
-}
-
-static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
-			     pte_t *ptep)
-{
-	PVOP_VCALL3(mmu.pte_clear, mm, addr, ptep);
-}
-
-static inline void pmd_clear(pmd_t *pmdp)
-{
-	PVOP_VCALL1(mmu.pmd_clear, pmdp);
-}
-#else  /* !CONFIG_X86_PAE */
 static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
 {
 	set_pte(ptep, pte);
@@ -612,7 +545,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 {
 	set_pmd(pmdp, __pmd(0));
 }
-#endif	/* CONFIG_X86_PAE */
 
 #define  __HAVE_ARCH_START_CONTEXT_SWITCH
 static inline void arch_start_context_switch(struct task_struct *prev)
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 8dfcb2508e6d..f27c3febaa6e 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -68,12 +68,7 @@ struct paravirt_callee_save {
 /* general info */
 struct pv_info {
 #ifdef CONFIG_PARAVIRT_XXL
-	unsigned int kernel_rpl;
-	int shared_kernel_pmd;
-
-#ifdef CONFIG_X86_64
 	u16 extra_user_64bit_cs;  /* __USER_CS if none */
-#endif
 #endif
 
 	const char *name;
@@ -126,9 +121,7 @@ struct pv_cpu_ops {
 	void (*set_ldt)(const void *desc, unsigned entries);
 	unsigned long (*store_tr)(void);
 	void (*load_tls)(struct thread_struct *t, unsigned int cpu);
-#ifdef CONFIG_X86_64
 	void (*load_gs_index)(unsigned int idx);
-#endif
 	void (*write_ldt_entry)(struct desc_struct *ldt, int entrynum,
 				const void *desc);
 	void (*write_gdt_entry)(struct desc_struct *,
@@ -264,21 +257,11 @@ struct pv_mmu_ops {
 	struct paravirt_callee_save pgd_val;
 	struct paravirt_callee_save make_pgd;
 
-#if CONFIG_PGTABLE_LEVELS >= 3
-#ifdef CONFIG_X86_PAE
-	void (*set_pte_atomic)(pte_t *ptep, pte_t pteval);
-	void (*pte_clear)(struct mm_struct *mm, unsigned long addr,
-			  pte_t *ptep);
-	void (*pmd_clear)(pmd_t *pmdp);
-
-#endif	/* CONFIG_X86_PAE */
-
 	void (*set_pud)(pud_t *pudp, pud_t pudval);
 
 	struct paravirt_callee_save pmd_val;
 	struct paravirt_callee_save make_pmd;
 
-#if CONFIG_PGTABLE_LEVELS >= 4
 	struct paravirt_callee_save pud_val;
 	struct paravirt_callee_save make_pud;
 
@@ -291,10 +274,6 @@ struct pv_mmu_ops {
 	void (*set_pgd)(pgd_t *pgdp, pgd_t pgdval);
 #endif	/* CONFIG_PGTABLE_LEVELS >= 5 */
 
-#endif	/* CONFIG_PGTABLE_LEVELS >= 4 */
-
-#endif	/* CONFIG_PGTABLE_LEVELS >= 3 */
-
 	struct pv_lazy_ops lazy_mode;
 
 	/* dom0 ops */
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 80fbb4a9ed87..56baf43befb4 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -20,12 +20,7 @@ typedef union {
 } pte_t;
 #endif	/* !__ASSEMBLY__ */
 
-#ifdef CONFIG_PARAVIRT_XXL
-#define SHARED_KERNEL_PMD	((!static_cpu_has(X86_FEATURE_PTI) &&	\
-				 (pv_info.shared_kernel_pmd)))
-#else
 #define SHARED_KERNEL_PMD	(!static_cpu_has(X86_FEATURE_PTI))
-#endif
 
 #define ARCH_PAGE_TABLE_SYNC_MASK	(SHARED_KERNEL_PMD ? 0 : PGTBL_PMD_MODIFIED)
 
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 9646c300f128..517920928989 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -222,10 +222,6 @@
 
 #endif
 
-#ifndef CONFIG_PARAVIRT_XXL
-# define get_kernel_rpl()		0
-#endif
-
 #define IDT_ENTRIES			256
 #define NUM_EXCEPTION_VECTORS		32
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 965474d78cef..ca89cea31e81 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1412,15 +1412,7 @@ static void generic_identify(struct cpuinfo_x86 *c)
 	 * ESPFIX issue, we can change this.
 	 */
 #ifdef CONFIG_X86_32
-# ifdef CONFIG_PARAVIRT_XXL
-	do {
-		extern void native_iret(void);
-		if (pv_ops.cpu.iret == native_iret)
-			set_cpu_bug(c, X86_BUG_ESPFIX);
-	} while (0);
-# else
 	set_cpu_bug(c, X86_BUG_ESPFIX);
-# endif
 #endif
 }
 
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index fdadc37d72af..2ca10b770cff 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -793,7 +793,6 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
 	/* fixup registers */
 	regs->cs = __KERNEL_CS;
 #ifdef CONFIG_X86_32
-	regs->cs |= get_kernel_rpl();
 	regs->gs = 0;
 #endif
 	/* We use pt_regs->sp for return address holder. */
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 40f380461e6d..b8dd113a1284 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -181,7 +181,6 @@ optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
 		/* Save skipped registers */
 		regs->cs = __KERNEL_CS;
 #ifdef CONFIG_X86_32
-		regs->cs |= get_kernel_rpl();
 		regs->gs = 0;
 #endif
 		regs->ip = (unsigned long)op->kp.addr + INT3_INSN_SIZE;
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index de2138ba38e5..e56a144c13b3 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -263,13 +263,8 @@ enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 struct pv_info pv_info = {
 	.name = "bare hardware",
 #ifdef CONFIG_PARAVIRT_XXL
-	.kernel_rpl = 0,
-	.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
-
-#ifdef CONFIG_X86_64
 	.extra_user_64bit_cs = __USER_CS,
 #endif
-#endif
 };
 
 /* 64-bit pagetable entries */
@@ -305,9 +300,7 @@ struct paravirt_patch_template pv_ops = {
 	.cpu.load_idt		= native_load_idt,
 	.cpu.store_tr		= native_store_tr,
 	.cpu.load_tls		= native_load_tls,
-#ifdef CONFIG_X86_64
 	.cpu.load_gs_index	= native_load_gs_index,
-#endif
 	.cpu.write_ldt_entry	= native_write_ldt_entry,
 	.cpu.write_gdt_entry	= native_write_gdt_entry,
 	.cpu.write_idt_entry	= native_write_idt_entry,
@@ -317,9 +310,7 @@ struct paravirt_patch_template pv_ops = {
 
 	.cpu.load_sp0		= native_load_sp0,
 
-#ifdef CONFIG_X86_64
 	.cpu.usergs_sysret64	= native_usergs_sysret64,
-#endif
 	.cpu.iret		= native_iret,
 	.cpu.swapgs		= native_swapgs,
 
@@ -375,18 +366,11 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.ptep_modify_prot_start	= __ptep_modify_prot_start,
 	.mmu.ptep_modify_prot_commit	= __ptep_modify_prot_commit,
 
-#if CONFIG_PGTABLE_LEVELS >= 3
-#ifdef CONFIG_X86_PAE
-	.mmu.set_pte_atomic	= native_set_pte_atomic,
-	.mmu.pte_clear		= native_pte_clear,
-	.mmu.pmd_clear		= native_pmd_clear,
-#endif
 	.mmu.set_pud		= native_set_pud,
 
 	.mmu.pmd_val		= PTE_IDENT,
 	.mmu.make_pmd		= PTE_IDENT,
 
-#if CONFIG_PGTABLE_LEVELS >= 4
 	.mmu.pud_val		= PTE_IDENT,
 	.mmu.make_pud		= PTE_IDENT,
 
@@ -398,8 +382,6 @@ struct paravirt_patch_template pv_ops = {
 
 	.mmu.set_pgd		= native_set_pgd,
 #endif /* CONFIG_PGTABLE_LEVELS >= 5 */
-#endif /* CONFIG_PGTABLE_LEVELS >= 4 */
-#endif /* CONFIG_PGTABLE_LEVELS >= 3 */
 
 	.mmu.pte_val		= PTE_IDENT,
 	.mmu.pgd_val		= PTE_IDENT,
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
index 3eff63c090d2..ace6e334cb39 100644
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -26,14 +26,10 @@ struct patch_xxl {
 	const unsigned char	mmu_read_cr3[3];
 	const unsigned char	mmu_write_cr3[3];
 	const unsigned char	irq_restore_fl[2];
-# ifdef CONFIG_X86_64
 	const unsigned char	cpu_wbinvd[2];
 	const unsigned char	cpu_usergs_sysret64[6];
 	const unsigned char	cpu_swapgs[3];
 	const unsigned char	mov64[3];
-# else
-	const unsigned char	cpu_iret[1];
-# endif
 };
 
 static const struct patch_xxl patch_data_xxl = {
@@ -42,7 +38,6 @@ static const struct patch_xxl patch_data_xxl = {
 	.irq_save_fl		= { 0x9c, 0x58 },	// pushf; pop %[re]ax
 	.mmu_read_cr2		= { 0x0f, 0x20, 0xd0 },	// mov %cr2, %[re]ax
 	.mmu_read_cr3		= { 0x0f, 0x20, 0xd8 },	// mov %cr3, %[re]ax
-# ifdef CONFIG_X86_64
 	.mmu_write_cr3		= { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
 	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
 	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
@@ -50,19 +45,11 @@ static const struct patch_xxl patch_data_xxl = {
 				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
 	.cpu_swapgs		= { 0x0f, 0x01, 0xf8 },	// swapgs
 	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
-# else
-	.mmu_write_cr3		= { 0x0f, 0x22, 0xd8 },	// mov %eax, %cr3
-	.irq_restore_fl		= { 0x50, 0x9d },	// push %eax; popf
-	.cpu_iret		= { 0xcf },		// iret
-# endif
 };
 
 unsigned int paravirt_patch_ident_64(void *insn_buff, unsigned int len)
 {
-#ifdef CONFIG_X86_64
 	return PATCH(xxl, mov64, insn_buff, len);
-#endif
-	return 0;
 }
 # endif /* CONFIG_PARAVIRT_XXL */
 
@@ -98,13 +85,9 @@ unsigned int native_patch(u8 type, void *insn_buff, unsigned long addr,
 	PATCH_CASE(mmu, read_cr3, xxl, insn_buff, len);
 	PATCH_CASE(mmu, write_cr3, xxl, insn_buff, len);
 
-# ifdef CONFIG_X86_64
 	PATCH_CASE(cpu, usergs_sysret64, xxl, insn_buff, len);
 	PATCH_CASE(cpu, swapgs, xxl, insn_buff, len);
 	PATCH_CASE(cpu, wbinvd, xxl, insn_buff, len);
-# else
-	PATCH_CASE(cpu, iret, xxl, insn_buff, len);
-# endif
 #endif
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 9fec952f84f3..b84d3d47082b 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1017,8 +1017,6 @@ void __init xen_setup_vcpu_info_placement(void)
 }
 
 static const struct pv_info xen_info __initconst = {
-	.shared_kernel_pmd = 0,
-
 	.extra_user_64bit_cs = FLAT_USER_CS64,
 	.name = "Xen",
 };
@@ -1317,10 +1315,6 @@ asmlinkage __visible void __init xen_start_kernel(void)
 				   xen_start_info->nr_pages);
 	xen_reserve_special_pages();
 
-	/* keep using Xen gdt for now; no urgent need to change it */
-
-	pv_info.kernel_rpl = 0;
-
 	/* set the limit of our address space */
 	xen_reserve_top();
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
