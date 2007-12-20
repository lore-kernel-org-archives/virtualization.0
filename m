From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 06/15] adjust assembly macros to x86_64 as well.
Date: Thu, 20 Dec 2007 18:04:01 -0200
Message-ID: <11981812412879-git-send-email-gcosta__35143.7245066792$1198181572$gmane$org@redhat.com>
References: <11981810504172-git-send-email-gcosta@redhat.com>
	<11981811293763-git-send-email-gcosta@redhat.com>
	<11981811852758-git-send-email-gcosta@redhat.com>
	<11981812041672-git-send-email-gcosta@redhat.com>
	<1198181215625-git-send-email-gcosta@redhat.com>
	<1198181224677-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1198181224677-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This patch adjust the paravirt macros used in assembly code
to accomodate for x86_64 as well.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/paravirt.h |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

Index: linux-2.6-x86/include/asm-x86/paravirt.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/paravirt.h	2007-12-20 19:07:25.000000000 -0800
+++ linux-2.6-x86/include/asm-x86/paravirt.h	2007-12-20 19:07:27.000000000 -0800
@@ -1159,8 +1159,6 @@
 
 #else  /* __ASSEMBLY__ */
 
-#define PARA_PATCH(struct, off)	((PARAVIRT_PATCH_##struct + (off)) / 4)
-
 #define _PVSITE(ptype, clobbers, ops, word, algn)	\
 771:;						\
 	ops;					\
@@ -1175,8 +1173,14 @@
 
 
 #ifdef CONFIG_X86_64
+#define PV_SAVE_REGS   pushq %rax; pushq %rdi; pushq %rcx; pushq %rdx
+#define PV_RESTORE_REGS popq %rdx; popq %rcx; popq %rdi; popq %rax
+#define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 8)
 #define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .quad, 8)
 #else
+#define PV_SAVE_REGS   pushl %eax; pushl %edi; pushl %ecx; pushl %edx
+#define PV_RESTORE_REGS popl %edx; popl %ecx; popl %edi; popl %eax
+#define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 4)
 #define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .long, 4)
 #endif
 
@@ -1186,25 +1190,27 @@
 
 #define DISABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_disable), clobbers, \
-		  pushl %eax; pushl %ecx; pushl %edx;			\
+		  PV_SAVE_REGS;			\
 		  call *%cs:pv_irq_ops+PV_IRQ_irq_disable;		\
-		  popl %edx; popl %ecx; popl %eax)			\
+		  PV_RESTORE_REGS;)			\
 
 #define ENABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_enable), clobbers,	\
-		  pushl %eax; pushl %ecx; pushl %edx;			\
+		  PV_SAVE_REGS;			\
 		  call *%cs:pv_irq_ops+PV_IRQ_irq_enable;		\
-		  popl %edx; popl %ecx; popl %eax)
+		  PV_RESTORE_REGS;)
 
 #define ENABLE_INTERRUPTS_SYSCALL_RET					\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_irq_enable_syscall_ret),\
 		  CLBR_NONE,						\
 		  jmp *%cs:pv_cpu_ops+PV_CPU_irq_enable_syscall_ret)
 
+#ifdef CONFIG_X86_32
 #define GET_CR0_INTO_EAX			\
 	push %ecx; push %edx;			\
 	call *pv_cpu_ops+PV_CPU_read_cr0;	\
 	pop %edx; pop %ecx
+#endif
 
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_PARAVIRT */
