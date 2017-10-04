From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 13/13] x86/paravirt: Convert natively patched pv ops to use
	paravirt alternatives
Date: Wed,  4 Oct 2017 10:58:34 -0500
Message-ID: <2540b103663d5038035e4df731b85c4f5094f431.1507128293.git.jpoimboe__16725.5103741356$1509079707$gmane$org@redhat.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1507128293.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Now that the paravirt alternatives infrastructure is in place, use it
for all natively patched pv ops.

This fixes KASAN warnings in the ORC unwinder like the following:

  BUG: KASAN: stack-out-of-bounds in deref_stack_reg+0x123/0x140

This also improves debuggability by making vmlinux more likely to match
reality.

Reported-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/paravirt-asm.h | 23 +++++++++++++----------
 arch/x86/include/asm/paravirt.h     | 37 +++++++++++++++++++++----------------
 2 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/paravirt-asm.h b/arch/x86/include/asm/paravirt-asm.h
index a8139ea27cc1..b051f9254ace 100644
--- a/arch/x86/include/asm/paravirt-asm.h
+++ b/arch/x86/include/asm/paravirt-asm.h
@@ -86,16 +86,18 @@
 		pv_cpu_ops, PV_CPU_iret, CLBR_NONE)
 
 #define DISABLE_INTERRUPTS(clobbers)					\
-	PV_SITE(PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
-		call PV_INDIRECT(pv_irq_ops+PV_IRQ_irq_disable);	\
-		PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE),		\
-		pv_irq_ops, PV_IRQ_irq_disable, clobbers)
+	PV_ALT_SITE(cli,						\
+		    PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
+		    call PV_INDIRECT(pv_irq_ops+PV_IRQ_irq_disable);	\
+		    PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE),	\
+		    pv_irq_ops, PV_IRQ_irq_disable, clobbers)
 
 #define ENABLE_INTERRUPTS(clobbers)					\
-	PV_SITE(PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
-		call PV_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);		\
-		PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE),		\
-		pv_irq_ops, PV_IRQ_irq_enable, clobbers)
+	PV_ALT_SITE(sti,						\
+		    PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
+		    call PV_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);	\
+		    PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE),	\
+		    pv_irq_ops, PV_IRQ_irq_enable, clobbers)
 
 #ifdef CONFIG_X86_32
 
@@ -128,8 +130,9 @@
 	call PV_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2)
 
 #define USERGS_SYSRET64							\
-	PV_SITE(jmp PV_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64),	\
-		pv_cpu_ops, PV_CPU_usergs_sysret64, CLBR_NONE)
+	PV_ALT_SITE(swapgs; sysret,					\
+		    jmp PV_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64),	\
+		    pv_cpu_ops, PV_CPU_usergs_sysret64, CLBR_NONE)
 
 #endif	/* !CONFIG_X86_32 */
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index bfd02c3335cb..4216a3b02832 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -13,6 +13,7 @@
 #include <asm/frame.h>
 #include <asm/pgtable_types.h>
 #include <asm/paravirt_types.h>
+#include <asm/special_insns.h>
 
 static inline void load_sp0(struct tss_struct *tss,
 			     struct thread_struct *thread)
@@ -50,9 +51,10 @@ static inline void write_cr0(unsigned long x)
 	PVOP_VCALL1(pv_cpu_ops.write_cr0, x);
 }
 
-static inline unsigned long read_cr2(void)
+static __always_inline unsigned long read_cr2(void)
 {
-	return PVOP_CALL0(unsigned long, pv_mmu_ops.read_cr2);
+	return PVOP_ALT_CALL0(unsigned long, NATIVE_READ_CR2,
+			      pv_mmu_ops.read_cr2);
 }
 
 static inline void write_cr2(unsigned long x)
@@ -60,14 +62,15 @@ static inline void write_cr2(unsigned long x)
 	PVOP_VCALL1(pv_mmu_ops.write_cr2, x);
 }
 
-static inline unsigned long __read_cr3(void)
+static __always_inline unsigned long __read_cr3(void)
 {
-	return PVOP_CALL0(unsigned long, pv_mmu_ops.read_cr3);
+	return PVOP_ALT_CALL0(unsigned long, NATIVE_READ_CR3,
+			      pv_mmu_ops.read_cr3);
 }
 
-static inline void write_cr3(unsigned long x)
+static __always_inline void write_cr3(unsigned long x)
 {
-	PVOP_VCALL1(pv_mmu_ops.write_cr3, x);
+	PVOP_ALT_VCALL1(NATIVE_WRITE_CR3, pv_mmu_ops.write_cr3, x);
 }
 
 static inline void __write_cr4(unsigned long x)
@@ -291,9 +294,10 @@ static inline void __flush_tlb_global(void)
 {
 	PVOP_VCALL0(pv_mmu_ops.flush_tlb_kernel);
 }
-static inline void __flush_tlb_single(unsigned long addr)
+static __always_inline void __flush_tlb_single(unsigned long addr)
 {
-	PVOP_VCALL1(pv_mmu_ops.flush_tlb_single, addr);
+	PVOP_ALT_VCALL1(NATIVE_FLUSH_TLB_SINGLE, pv_mmu_ops.flush_tlb_single,
+			addr);
 }
 
 static inline void flush_tlb_others(const struct cpumask *cpumask,
@@ -761,24 +765,25 @@ static __always_inline bool pv_vcpu_is_preempted(long cpu)
 #define __PV_IS_CALLEE_SAVE(func)			\
 	((struct paravirt_callee_save) { func })
 
-static inline notrace unsigned long arch_local_save_flags(void)
+static __always_inline unsigned long arch_local_save_flags(void)
 {
-	return PVOP_CALLEE0(unsigned long, pv_irq_ops.save_fl);
+	return PVOP_ALT_CALLEE0(unsigned long, NATIVE_SAVE_FL,
+				pv_irq_ops.save_fl);
 }
 
-static inline notrace void arch_local_irq_restore(unsigned long f)
+static __always_inline void arch_local_irq_restore(unsigned long f)
 {
-	PVOP_VCALLEE1(pv_irq_ops.restore_fl, f);
+	PVOP_ALT_VCALLEE1(NATIVE_RESTORE_FL, pv_irq_ops.restore_fl, f);
 }
 
-static inline notrace void arch_local_irq_disable(void)
+static __always_inline void arch_local_irq_disable(void)
 {
-	PVOP_VCALLEE0(pv_irq_ops.irq_disable);
+	PVOP_ALT_VCALLEE0(NATIVE_IRQ_DISABLE, pv_irq_ops.irq_disable);
 }
 
-static inline notrace void arch_local_irq_enable(void)
+static __always_inline void arch_local_irq_enable(void)
 {
-	PVOP_VCALLEE0(pv_irq_ops.irq_enable);
+	PVOP_ALT_VCALLEE0(NATIVE_IRQ_ENABLE, pv_irq_ops.irq_enable);
 }
 
 static inline notrace unsigned long arch_local_irq_save(void)
-- 
2.13.6
