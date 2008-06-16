From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 2 of 4] paravirt: add hooks for ptep_modify_prot_start/commit
Date: Mon, 16 Jun 2008 04:30:01 -0700
Message-ID: <2717ff42e6bf767833e0.1213615801@localhost>
References: <patchbomb.1213615799@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755193AbYFPLcc@vger.kernel.org>
In-Reply-To: <patchbomb.1213615799@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, xen-devel <xen-devel@lists.xensource.com>, Thomas Gleixner <tglx@linutronix.de>, Hugh Dickins <hugh@veritas.com>, Zachary Amsden <zach@vmware.com>, kvm-devel <kvm-devel@lists.sourceforge.net>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This patch adds paravirt-ops hooks in pv_mmu_ops for ptep_modify_prot_start and
ptep_modify_prot_commit.  This allows the hypervisor-specific backends to
implement these in some more efficient way.

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
---
 arch/x86/kernel/paravirt.c |    3 +++
 arch/x86/xen/enlighten.c   |    3 +++
 include/asm-x86/paravirt.h |   28 ++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -383,6 +383,9 @@
 	.pte_update = paravirt_nop,
 	.pte_update_defer = paravirt_nop,
 
+	.ptep_modify_prot_start = __ptep_modify_prot_start,
+	.ptep_modify_prot_commit = __ptep_modify_prot_commit,
+
 #ifdef CONFIG_HIGHPTE
 	.kmap_atomic_pte = kmap_atomic,
 #endif
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1139,6 +1139,9 @@
 	.set_pte_at = xen_set_pte_at,
 	.set_pmd = xen_set_pmd_hyper,
 
+	.ptep_modify_prot_start = __ptep_modify_prot_start,
+	.ptep_modify_prot_commit = __ptep_modify_prot_commit,
+
 	.pte_val = xen_pte_val,
 	.pte_flags = native_pte_val,
 	.pgd_val = xen_pgd_val,
diff --git a/include/asm-x86/paravirt.h b/include/asm-x86/paravirt.h
--- a/include/asm-x86/paravirt.h
+++ b/include/asm-x86/paravirt.h
@@ -238,6 +238,11 @@
 			   pte_t *ptep);
 	void (*pte_update_defer)(struct mm_struct *mm,
 				 unsigned long addr, pte_t *ptep);
+
+	pte_t (*ptep_modify_prot_start)(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep);
+	void (*ptep_modify_prot_commit)(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep, pte_t pte);
 
 	pteval_t (*pte_val)(pte_t);
 	pteval_t (*pte_flags)(pte_t);
@@ -1040,6 +1045,29 @@
 	return ret;
 }
 
+#define  __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
+static inline pte_t ptep_modify_prot_start(struct mm_struct *mm, unsigned long addr,
+					   pte_t *ptep)
+{
+	pteval_t ret;
+
+	ret = PVOP_CALL3(pteval_t, pv_mmu_ops.ptep_modify_prot_start,
+			 mm, addr, ptep);
+
+	return (pte_t) { .pte = ret };
+}
+
+static inline void ptep_modify_prot_commit(struct mm_struct *mm, unsigned long addr,
+					   pte_t *ptep, pte_t pte)
+{
+	if (sizeof(pteval_t) > sizeof(long))
+		/* 5 arg words */
+		pv_mmu_ops.ptep_modify_prot_commit(mm, addr, ptep, pte);
+	else
+		PVOP_VCALL4(pv_mmu_ops.ptep_modify_prot_commit,
+			    mm, addr, ptep, pte.pte);
+}
+
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	if (sizeof(pteval_t) > sizeof(long))
