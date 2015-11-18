From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 2/3] x86: irq_enable_sysexit pv op is no longer needed
Date: Wed, 18 Nov 2015 15:06:18 -0500
Message-ID: <1447877179-2775-3-git-send-email-boris.ostrovsky__11713.0323582844$1447877464$gmane$org@oracle.com>
References: <1447877179-2775-1-git-send-email-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447877179-2775-1-git-send-email-boris.ostrovsky@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, david.vrabel@citrix.com, konrad.wilk@oracle.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, luto@kernel.org, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, bp@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Xen PV guests have been the only ones using it and now they don't.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/entry/entry_32.S             |  8 ++------
 arch/x86/include/asm/paravirt.h       |  7 -------
 arch/x86/include/asm/paravirt_types.h |  9 ---------
 arch/x86/kernel/asm-offsets.c         |  3 ---
 arch/x86/kernel/paravirt.c            |  7 -------
 arch/x86/kernel/paravirt_patch_32.c   |  2 --
 arch/x86/kernel/paravirt_patch_64.c   |  1 -
 arch/x86/xen/enlighten.c              |  3 ---
 arch/x86/xen/xen-asm_32.S             | 14 --------------
 arch/x86/xen/xen-ops.h                |  3 ---
 10 files changed, 2 insertions(+), 55 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 901f186..e2158ae 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -329,7 +329,8 @@ sysenter_past_esp:
 	 * Return back to the vDSO, which will pop ecx and edx.
 	 * Don't bother with DS and ES (they already contain __USER_DS).
 	 */
-	ENABLE_INTERRUPTS_SYSEXIT
+	sti
+	sysexit
 
 .pushsection .fixup, "ax"
 2:	movl	$0, PT_FS(%esp)
@@ -552,11 +553,6 @@ ENTRY(native_iret)
 	iret
 	_ASM_EXTABLE(native_iret, iret_exc)
 END(native_iret)
-
-ENTRY(native_irq_enable_sysexit)
-	sti
-	sysexit
-END(native_irq_enable_sysexit)
 #endif
 
 ENTRY(overflow)
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 10d0596..c28518e 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -932,13 +932,6 @@ extern void default_banner(void);
 	push %ecx; push %edx;				\
 	call PARA_INDIRECT(pv_cpu_ops+PV_CPU_read_cr0);	\
 	pop %edx; pop %ecx
-
-#define ENABLE_INTERRUPTS_SYSEXIT					\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_irq_enable_sysexit),	\
-		  CLBR_NONE,						\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_irq_enable_sysexit))
-
-
 #else	/* !CONFIG_X86_32 */
 
 /*
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 31247b5..608bbf3 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -157,15 +157,6 @@ struct pv_cpu_ops {
 
 	u64 (*read_pmc)(int counter);
 
-#ifdef CONFIG_X86_32
-	/*
-	 * Atomically enable interrupts and return to userspace.  This
-	 * is only used in 32-bit kernels.  64-bit kernels use
-	 * usergs_sysret32 instead.
-	 */
-	void (*irq_enable_sysexit)(void);
-#endif
-
 	/*
 	 * Switch to usermode gs and return to 64-bit usermode using
 	 * sysret.  Only used in 64-bit kernels to return to 64-bit
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 439df97..84a7524 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -65,9 +65,6 @@ void common(void) {
 	OFFSET(PV_IRQ_irq_disable, pv_irq_ops, irq_disable);
 	OFFSET(PV_IRQ_irq_enable, pv_irq_ops, irq_enable);
 	OFFSET(PV_CPU_iret, pv_cpu_ops, iret);
-#ifdef CONFIG_X86_32
-	OFFSET(PV_CPU_irq_enable_sysexit, pv_cpu_ops, irq_enable_sysexit);
-#endif
 	OFFSET(PV_CPU_read_cr0, pv_cpu_ops, read_cr0);
 	OFFSET(PV_MMU_read_cr2, pv_mmu_ops, read_cr2);
 #endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c2130ae..c55f437 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -162,9 +162,6 @@ unsigned paravirt_patch_default(u8 type, u16 clobbers, void *insnbuf,
 		ret = paravirt_patch_ident_64(insnbuf, len);
 
 	else if (type == PARAVIRT_PATCH(pv_cpu_ops.iret) ||
-#ifdef CONFIG_X86_32
-		 type == PARAVIRT_PATCH(pv_cpu_ops.irq_enable_sysexit) ||
-#endif
 		 type == PARAVIRT_PATCH(pv_cpu_ops.usergs_sysret32) ||
 		 type == PARAVIRT_PATCH(pv_cpu_ops.usergs_sysret64))
 		/* If operation requires a jmp, then jmp */
@@ -220,7 +217,6 @@ static u64 native_steal_clock(int cpu)
 
 /* These are in entry.S */
 extern void native_iret(void);
-extern void native_irq_enable_sysexit(void);
 extern void native_usergs_sysret32(void);
 extern void native_usergs_sysret64(void);
 
@@ -379,9 +375,6 @@ __visible struct pv_cpu_ops pv_cpu_ops = {
 
 	.load_sp0 = native_load_sp0,
 
-#if defined(CONFIG_X86_32)
-	.irq_enable_sysexit = native_irq_enable_sysexit,
-#endif
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_IA32_EMULATION
 	.usergs_sysret32 = native_usergs_sysret32,
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index c89f50a..158dc06 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -5,7 +5,6 @@ DEF_NATIVE(pv_irq_ops, irq_enable, "sti");
 DEF_NATIVE(pv_irq_ops, restore_fl, "push %eax; popf");
 DEF_NATIVE(pv_irq_ops, save_fl, "pushf; pop %eax");
 DEF_NATIVE(pv_cpu_ops, iret, "iret");
-DEF_NATIVE(pv_cpu_ops, irq_enable_sysexit, "sti; sysexit");
 DEF_NATIVE(pv_mmu_ops, read_cr2, "mov %cr2, %eax");
 DEF_NATIVE(pv_mmu_ops, write_cr3, "mov %eax, %cr3");
 DEF_NATIVE(pv_mmu_ops, read_cr3, "mov %cr3, %eax");
@@ -46,7 +45,6 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		PATCH_SITE(pv_irq_ops, restore_fl);
 		PATCH_SITE(pv_irq_ops, save_fl);
 		PATCH_SITE(pv_cpu_ops, iret);
-		PATCH_SITE(pv_cpu_ops, irq_enable_sysexit);
 		PATCH_SITE(pv_mmu_ops, read_cr2);
 		PATCH_SITE(pv_mmu_ops, read_cr3);
 		PATCH_SITE(pv_mmu_ops, write_cr3);
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 8aa0558..17c00f8 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -13,7 +13,6 @@ DEF_NATIVE(pv_mmu_ops, flush_tlb_single, "invlpg (%rdi)");
 DEF_NATIVE(pv_cpu_ops, clts, "clts");
 DEF_NATIVE(pv_cpu_ops, wbinvd, "wbinvd");
 
-DEF_NATIVE(pv_cpu_ops, irq_enable_sysexit, "swapgs; sti; sysexit");
 DEF_NATIVE(pv_cpu_ops, usergs_sysret64, "swapgs; sysretq");
 DEF_NATIVE(pv_cpu_ops, usergs_sysret32, "swapgs; sysretl");
 DEF_NATIVE(pv_cpu_ops, swapgs, "swapgs");
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index d315151..a068e36 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1229,10 +1229,7 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 
 	.iret = xen_iret,
 #ifdef CONFIG_X86_64
-	.usergs_sysret32 = xen_sysret32,
 	.usergs_sysret64 = xen_sysret64,
-#else
-	.irq_enable_sysexit = xen_sysexit,
 #endif
 
 	.load_tr_desc = paravirt_nop,
diff --git a/arch/x86/xen/xen-asm_32.S b/arch/x86/xen/xen-asm_32.S
index fd92a64..feb6d40 100644
--- a/arch/x86/xen/xen-asm_32.S
+++ b/arch/x86/xen/xen-asm_32.S
@@ -35,20 +35,6 @@ check_events:
 	ret
 
 /*
- * We can't use sysexit directly, because we're not running in ring0.
- * But we can easily fake it up using iret.  Assuming xen_sysexit is
- * jumped to with a standard stack frame, we can just strip it back to
- * a standard iret frame and use iret.
- */
-ENTRY(xen_sysexit)
-	movl PT_EAX(%esp), %eax			/* Shouldn't be necessary? */
-	orl $X86_EFLAGS_IF, PT_EFLAGS(%esp)
-	lea PT_EIP(%esp), %esp
-
-	jmp xen_iret
-ENDPROC(xen_sysexit)
-
-/*
  * This is run where a normal iret would be run, with the same stack setup:
  *	8: eflags
  *	4: cs
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 1399423..4140b07 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -139,9 +139,6 @@ DECL_ASM(void, xen_restore_fl_direct, unsigned long);
 
 /* These are not functions, and cannot be called normally */
 __visible void xen_iret(void);
-#ifdef CONFIG_X86_32
-__visible void xen_sysexit(void);
-#endif
 __visible void xen_sysret32(void);
 __visible void xen_sysret64(void);
 __visible void xen_adjust_exception_frame(void);
-- 
1.8.1.4
