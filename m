From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 05/11] x86/paravirt: remove unused paravirt bits
Date: Mon, 13 Aug 2018 09:37:33 +0200
Message-ID: <20180813073739.26108-6-jgross__42754.9948370599$1534146781$gmane$org@suse.com>
References: <20180813073739.26108-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180813073739.26108-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, peterz@infradead.org, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

The macros ENABLE_INTERRUPTS_SYSEXIT, GET_CR0_INTO_EAX and
PARAVIRT_ADJUST_EXCEPTION_FRAME are used nowhere. Remove their
definitions.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/irqflags.h | 4 ----
 arch/x86/include/asm/paravirt.h | 9 +--------
 arch/x86/kernel/asm-offsets.c   | 1 -
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index c4fc17220df9..b7a790d03229 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -132,8 +132,6 @@ static inline notrace unsigned long arch_local_irq_save(void)
  */
 #define SWAPGS_UNSAFE_STACK	swapgs
 
-#define PARAVIRT_ADJUST_EXCEPTION_FRAME	/*  */
-
 #define INTERRUPT_RETURN	jmp native_iret
 #define USERGS_SYSRET64				\
 	swapgs;					\
@@ -147,8 +145,6 @@ static inline notrace unsigned long arch_local_irq_save(void)
 #endif
 #else
 #define INTERRUPT_RETURN		iret
-#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
-#define GET_CR0_INTO_EAX		movl %cr0, %eax
 #endif
 
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index de840095fd64..be5b610d255e 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -882,14 +882,7 @@ extern void default_banner(void);
 		  call PARA_INDIRECT(pv_ops+PV_IRQ_irq_enable);		\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
-#ifdef CONFIG_X86_32
-#define GET_CR0_INTO_EAX				\
-	push %ecx; push %edx;				\
-	ANNOTATE_RETPOLINE_SAFE;				\
-	call PARA_INDIRECT(pv_ops+PV_CPU_read_cr0);	\
-	pop %edx; pop %ecx
-#else	/* !CONFIG_X86_32 */
-
+#ifdef CONFIG_X86_64
 /*
  * If swapgs is used while the userspace stack is still current,
  * there's no way to call a pvop.  The PV replacement *must* be
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 48595caab705..395253f582a5 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -69,7 +69,6 @@ void common(void) {
 	OFFSET(PV_IRQ_irq_disable, paravirt_patch_template, irq.irq_disable);
 	OFFSET(PV_IRQ_irq_enable, paravirt_patch_template, irq.irq_enable);
 	OFFSET(PV_CPU_iret, paravirt_patch_template, cpu.iret);
-	OFFSET(PV_CPU_read_cr0, paravirt_patch_template, cpu.read_cr0);
 	OFFSET(PV_MMU_read_cr2, paravirt_patch_template, mmu.read_cr2);
 #endif
 
-- 
2.13.7
