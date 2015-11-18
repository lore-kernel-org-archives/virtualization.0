From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 3/3] x86: usergs_sysret32 pv op is no longer needed
Date: Wed, 18 Nov 2015 15:06:19 -0500
Message-ID: <1447877179-2775-4-git-send-email-boris.ostrovsky__17275.5548767329$1447877492$gmane$org@oracle.com>
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
 arch/x86/entry/entry_64_compat.S      | 10 ++--------
 arch/x86/include/asm/paravirt.h       |  5 -----
 arch/x86/include/asm/paravirt_types.h |  8 --------
 arch/x86/kernel/asm-offsets_64.c      |  1 -
 arch/x86/kernel/paravirt.c            |  5 -----
 arch/x86/kernel/paravirt_patch_64.c   |  2 --
 arch/x86/xen/xen-asm_64.S             | 19 -------------------
 7 files changed, 2 insertions(+), 48 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 98893d9..82415dc 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -18,13 +18,6 @@
 
 	.section .entry.text, "ax"
 
-#ifdef CONFIG_PARAVIRT
-ENTRY(native_usergs_sysret32)
-	swapgs
-	sysretl
-ENDPROC(native_usergs_sysret32)
-#endif
-
 /*
  * 32-bit SYSENTER instruction entry.
  *
@@ -238,7 +231,8 @@ sysret32_from_system_call:
 	xorq	%r9, %r9
 	xorq	%r10, %r10
 	movq	RSP-ORIG_RAX(%rsp), %rsp
-        USERGS_SYSRET32
+	swapgs
+	sysretl
 END(entry_SYSCALL_compat)
 
 /*
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index c28518e..1b71c3a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -922,11 +922,6 @@ extern void default_banner(void);
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
-#define USERGS_SYSRET32							\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_usergs_sysret32),	\
-		  CLBR_NONE,						\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret32))
-
 #ifdef CONFIG_X86_32
 #define GET_CR0_INTO_EAX				\
 	push %ecx; push %edx;				\
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 608bbf3..702c8bd 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -165,14 +165,6 @@ struct pv_cpu_ops {
 	 */
 	void (*usergs_sysret64)(void);
 
-	/*
-	 * Switch to usermode gs and return to 32-bit usermode using
-	 * sysret.  Used to return to 32-on-64 compat processes.
-	 * Other usermode register state, including %esp, must already
-	 * be restored.
-	 */
-	void (*usergs_sysret32)(void);
-
 	/* Normal iret.  Jump to this with the standard iret stack
 	   frame set up. */
 	void (*iret)(void);
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index d8f42f9..f2edafb 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -23,7 +23,6 @@ int main(void)
 {
 #ifdef CONFIG_PARAVIRT
 	OFFSET(PV_IRQ_adjust_exception_frame, pv_irq_ops, adjust_exception_frame);
-	OFFSET(PV_CPU_usergs_sysret32, pv_cpu_ops, usergs_sysret32);
 	OFFSET(PV_CPU_usergs_sysret64, pv_cpu_ops, usergs_sysret64);
 	OFFSET(PV_CPU_swapgs, pv_cpu_ops, swapgs);
 	BLANK();
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c55f437..8c19b4d 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -162,7 +162,6 @@ unsigned paravirt_patch_default(u8 type, u16 clobbers, void *insnbuf,
 		ret = paravirt_patch_ident_64(insnbuf, len);
 
 	else if (type == PARAVIRT_PATCH(pv_cpu_ops.iret) ||
-		 type == PARAVIRT_PATCH(pv_cpu_ops.usergs_sysret32) ||
 		 type == PARAVIRT_PATCH(pv_cpu_ops.usergs_sysret64))
 		/* If operation requires a jmp, then jmp */
 		ret = paravirt_patch_jmp(insnbuf, opfunc, addr, len);
@@ -217,7 +216,6 @@ static u64 native_steal_clock(int cpu)
 
 /* These are in entry.S */
 extern void native_iret(void);
-extern void native_usergs_sysret32(void);
 extern void native_usergs_sysret64(void);
 
 static struct resource reserve_ioports = {
@@ -376,9 +374,6 @@ __visible struct pv_cpu_ops pv_cpu_ops = {
 	.load_sp0 = native_load_sp0,
 
 #ifdef CONFIG_X86_64
-#ifdef CONFIG_IA32_EMULATION
-	.usergs_sysret32 = native_usergs_sysret32,
-#endif
 	.usergs_sysret64 = native_usergs_sysret64,
 #endif
 	.iret = native_iret,
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 17c00f8..e70087a 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -14,7 +14,6 @@ DEF_NATIVE(pv_cpu_ops, clts, "clts");
 DEF_NATIVE(pv_cpu_ops, wbinvd, "wbinvd");
 
 DEF_NATIVE(pv_cpu_ops, usergs_sysret64, "swapgs; sysretq");
-DEF_NATIVE(pv_cpu_ops, usergs_sysret32, "swapgs; sysretl");
 DEF_NATIVE(pv_cpu_ops, swapgs, "swapgs");
 
 DEF_NATIVE(, mov32, "mov %edi, %eax");
@@ -54,7 +53,6 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		PATCH_SITE(pv_irq_ops, save_fl);
 		PATCH_SITE(pv_irq_ops, irq_enable);
 		PATCH_SITE(pv_irq_ops, irq_disable);
-		PATCH_SITE(pv_cpu_ops, usergs_sysret32);
 		PATCH_SITE(pv_cpu_ops, usergs_sysret64);
 		PATCH_SITE(pv_cpu_ops, swapgs);
 		PATCH_SITE(pv_mmu_ops, read_cr2);
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index f22667a..cc8acc4 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -68,25 +68,6 @@ ENTRY(xen_sysret64)
 ENDPATCH(xen_sysret64)
 RELOC(xen_sysret64, 1b+1)
 
-ENTRY(xen_sysret32)
-	/*
-	 * We're already on the usermode stack at this point, but
-	 * still with the kernel gs, so we can easily switch back
-	 */
-	movq %rsp, PER_CPU_VAR(rsp_scratch)
-	movq PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-
-	pushq $__USER32_DS
-	pushq PER_CPU_VAR(rsp_scratch)
-	pushq %r11
-	pushq $__USER32_CS
-	pushq %rcx
-
-	pushq $0
-1:	jmp hypercall_iret
-ENDPATCH(xen_sysret32)
-RELOC(xen_sysret32, 1b+1)
-
 /*
  * Xen handles syscall callbacks much like ordinary exceptions, which
  * means we have:
-- 
1.8.1.4
