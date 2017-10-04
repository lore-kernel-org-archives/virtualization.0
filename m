From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 06/13] x86/paravirt: Clean up paravirt-asm.h
Date: Wed,  4 Oct 2017 10:58:27 -0500
Message-ID: <d76cfb9e80bc974fe24f88098f1aecd8c11fdf29.1507128293.git.jpoimboe__5616.80129399082$1509079635$gmane$org@redhat.com>
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

Some cleanup to make the code easier to read and understand:

- Use the common "PV_" prefix
- Simplify the PV_SITE macro interface
- Improve whitespace

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/paravirt-asm.h | 95 +++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/paravirt-asm.h b/arch/x86/include/asm/paravirt-asm.h
index add8a190fdac..8bdd50ee4bf3 100644
--- a/arch/x86/include/asm/paravirt-asm.h
+++ b/arch/x86/include/asm/paravirt-asm.h
@@ -7,16 +7,18 @@
 #include <asm/asm.h>
 #include <asm/paravirt_types.h>
 
-#define _PVSITE(ptype, clobbers, ops, word, algn)	\
-771:;						\
-	ops;					\
-772:;						\
-	.pushsection .parainstructions,"a";	\
-	 .align	algn;				\
-	 word 771b;				\
-	 .byte ptype;				\
-	 .byte 772b-771b;			\
-	 .short clobbers;			\
+#define PV_TYPE(ops, off) ((PARAVIRT_PATCH_##ops + (off)) / __ASM_SEL(4, 8))
+
+#define PV_SITE(insns, ops, off, clobbers)				\
+771:;									\
+	insns;								\
+772:;									\
+	.pushsection .parainstructions, "a";				\
+	 _ASM_ALIGN;							\
+	 _ASM_PTR 771b;							\
+	 .byte PV_TYPE(ops, off);					\
+	 .byte 772b-771b;						\
+	 .short clobbers;						\
 	.popsection
 
 
@@ -33,62 +35,65 @@
 	COND_PUSH(set, CLBR_RDX, rdx);		\
 	COND_PUSH(set, CLBR_RSI, rsi);		\
 	COND_PUSH(set, CLBR_RDI, rdi);		\
-	COND_PUSH(set, CLBR_R8, r8);		\
-	COND_PUSH(set, CLBR_R9, r9);		\
+	COND_PUSH(set, CLBR_R8,  r8);		\
+	COND_PUSH(set, CLBR_R9,  r9);		\
 	COND_PUSH(set, CLBR_R10, r10);		\
 	COND_PUSH(set, CLBR_R11, r11)
+
 #define PV_RESTORE_REGS(set)			\
 	COND_POP(set, CLBR_R11, r11);		\
 	COND_POP(set, CLBR_R10, r10);		\
-	COND_POP(set, CLBR_R9, r9);		\
-	COND_POP(set, CLBR_R8, r8);		\
+	COND_POP(set, CLBR_R9,  r9);		\
+	COND_POP(set, CLBR_R8,  r8);		\
 	COND_POP(set, CLBR_RDI, rdi);		\
 	COND_POP(set, CLBR_RSI, rsi);		\
 	COND_POP(set, CLBR_RDX, rdx);		\
 	COND_POP(set, CLBR_RCX, rcx);		\
 	COND_POP(set, CLBR_RAX, rax)
 
-#define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 8)
-#define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .quad, 8)
-#define PARA_INDIRECT(addr)	*addr(%rip)
-#else
+#define PV_INDIRECT(addr)	*addr(%rip)
+
+#else /* !CONFIG_X86_64 */
+
 #define PV_SAVE_REGS(set)			\
 	COND_PUSH(set, CLBR_EAX, eax);		\
 	COND_PUSH(set, CLBR_EDI, edi);		\
 	COND_PUSH(set, CLBR_ECX, ecx);		\
 	COND_PUSH(set, CLBR_EDX, edx)
+
 #define PV_RESTORE_REGS(set)			\
 	COND_POP(set, CLBR_EDX, edx);		\
 	COND_POP(set, CLBR_ECX, ecx);		\
 	COND_POP(set, CLBR_EDI, edi);		\
 	COND_POP(set, CLBR_EAX, eax)
 
-#define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 4)
-#define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .long, 4)
-#define PARA_INDIRECT(addr)	*%cs:addr
-#endif
+#define PV_INDIRECT(addr)	*%cs:addr
+
+#endif /* !CONFIG_X86_64 */
 
 #define INTERRUPT_RETURN						\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_iret), CLBR_NONE,	\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_iret))
+	PV_SITE(jmp PV_INDIRECT(pv_cpu_ops+PV_CPU_iret),		\
+		pv_cpu_ops, PV_CPU_iret, CLBR_NONE)
 
 #define DISABLE_INTERRUPTS(clobbers)					\
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_disable), clobbers, \
-		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
-		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_disable);	\
-		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
+	PV_SITE(PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
+		call PV_INDIRECT(pv_irq_ops+PV_IRQ_irq_disable);	\
+		PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE),		\
+		pv_irq_ops, PV_IRQ_irq_disable, clobbers)
 
 #define ENABLE_INTERRUPTS(clobbers)					\
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_enable), clobbers,	\
-		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
-		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);	\
-		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
+	PV_SITE(PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
+		call PV_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);		\
+		PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE),		\
+		pv_irq_ops, PV_IRQ_irq_enable, clobbers)
 
 #ifdef CONFIG_X86_32
-#define GET_CR0_INTO_EAX				\
-	push %ecx; push %edx;				\
-	call PARA_INDIRECT(pv_cpu_ops+PV_CPU_read_cr0);	\
+
+#define GET_CR0_INTO_EAX						\
+	push %ecx; push %edx;						\
+	call PV_INDIRECT(pv_cpu_ops+PV_CPU_read_cr0);			\
 	pop %edx; pop %ecx
+
 #else	/* !CONFIG_X86_32 */
 
 /*
@@ -97,8 +102,7 @@
  * inlined, or the swapgs instruction must be trapped and emulated.
  */
 #define SWAPGS_UNSAFE_STACK						\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  swapgs)
+	PV_SITE(swapgs, pv_cpu_ops, PV_CPU_swapgs, CLBR_NONE)
 
 /*
  * Note: swapgs is very special, and in practise is either going to be
@@ -107,18 +111,17 @@
  * it.
  */
 #define SWAPGS								\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  call PARA_INDIRECT(pv_cpu_ops+PV_CPU_swapgs)		\
-		 )
+	PV_SITE(call PV_INDIRECT(pv_cpu_ops+PV_CPU_swapgs),		\
+		pv_cpu_ops, PV_CPU_swapgs, CLBR_NONE)
 
-#define GET_CR2_INTO_RAX				\
-	call PARA_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2)
+#define GET_CR2_INTO_RAX						\
+	call PV_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2)
 
 #define USERGS_SYSRET64							\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_usergs_sysret64),	\
-		  CLBR_NONE,						\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64))
-#endif	/* CONFIG_X86_32 */
+	PV_SITE(jmp PV_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64),	\
+		pv_cpu_ops, PV_CPU_usergs_sysret64, CLBR_NONE)
+
+#endif	/* !CONFIG_X86_32 */
 
 #endif  /*  __ASSEMBLY__  */
 #endif /* CONFIG_PARAVIRT */
-- 
2.13.6
