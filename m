From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 07/15] change irq functions to accomodate x86_64
Date: Thu, 20 Dec 2007 18:04:02 -0200
Message-ID: <11981812771615-git-send-email-gcosta__17222.7771989585$1198181726$gmane$org@redhat.com>
References: <11981810504172-git-send-email-gcosta@redhat.com>
	<11981811293763-git-send-email-gcosta@redhat.com>
	<11981811852758-git-send-email-gcosta@redhat.com>
	<11981812041672-git-send-email-gcosta@redhat.com>
	<1198181215625-git-send-email-gcosta@redhat.com>
	<1198181224677-git-send-email-gcosta@redhat.com>
	<11981812412879-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981812412879-git-send-email-gcosta@redhat.com>
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

This patch changes the irq handling function definitions
in paravirt.h (like raw_local_irq_disable) to accomodate for x86_64.
The differences are in the calling convention.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/paravirt.h |   43 ++++++++++++++++++++++++++++++-------------
 1 files changed, 30 insertions(+), 13 deletions(-)

Index: linux-2.6-x86/include/asm-x86/paravirt.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/paravirt.h	2007-12-20 19:07:27.000000000 -0800
+++ linux-2.6-x86/include/asm-x86/paravirt.h	2007-12-20 19:07:28.000000000 -0800
@@ -1085,52 +1085,68 @@
 extern struct paravirt_patch_site __parainstructions[],
 	__parainstructions_end[];
 
+#ifdef CONFIG_X86_32
+#define PV_SAVE_REGS "pushl %%ecx; pushl %%edx;"
+#define PV_RESTORE_REGS "popl %%edx; popl %%ecx"
+#define PV_FLAGS_ARG "0"
+#define PV_EXTRA_CLOBBERS
+#define PV_VEXTRA_CLOBBERS
+#else
+/* We save some registers, but all of them, that's too much. We clobber all
+ * caller saved registers but the argument parameter */
+#define PV_SAVE_REGS "pushq %%rdi;"
+#define PV_RESTORE_REGS "popq %%rdi;"
+#define PV_EXTRA_CLOBBERS EXTRA_CLOBBERS, "rcx" , "rdx"
+#define PV_VEXTRA_CLOBBERS EXTRA_CLOBBERS, "rdi", "rcx" , "rdx"
+#define PV_FLAGS_ARG "D"
+#endif
+
 static inline unsigned long __raw_local_save_flags(void)
 {
 	unsigned long f;
 
-	asm volatile(paravirt_alt("pushl %%ecx; pushl %%edx;"
+	asm volatile(paravirt_alt(PV_SAVE_REGS
 				  PARAVIRT_CALL
-				  "popl %%edx; popl %%ecx")
+				  PV_RESTORE_REGS)
 		     : "=a"(f)
 		     : paravirt_type(pv_irq_ops.save_fl),
 		       paravirt_clobber(CLBR_EAX)
-		     : "memory", "cc");
+		     : "memory", "cc" PV_VEXTRA_CLOBBERS);
 	return f;
 }
 
 static inline void raw_local_irq_restore(unsigned long f)
 {
-	asm volatile(paravirt_alt("pushl %%ecx; pushl %%edx;"
+	asm volatile(paravirt_alt(PV_SAVE_REGS
 				  PARAVIRT_CALL
-				  "popl %%edx; popl %%ecx")
+				  PV_RESTORE_REGS)
 		     : "=a"(f)
-		     : "0"(f),
+		     : PV_FLAGS_ARG(f),
 		       paravirt_type(pv_irq_ops.restore_fl),
 		       paravirt_clobber(CLBR_EAX)
-		     : "memory", "cc");
+		     : "memory", "cc" PV_EXTRA_CLOBBERS);
 }
 
 static inline void raw_local_irq_disable(void)
 {
-	asm volatile(paravirt_alt("pushl %%ecx; pushl %%edx;"
+	asm volatile(paravirt_alt(PV_SAVE_REGS
 				  PARAVIRT_CALL
-				  "popl %%edx; popl %%ecx")
+				  PV_RESTORE_REGS)
 		     :
 		     : paravirt_type(pv_irq_ops.irq_disable),
 		       paravirt_clobber(CLBR_EAX)
-		     : "memory", "eax", "cc");
+		     : "memory", "eax", "cc" PV_EXTRA_CLOBBERS);
 }
 
 static inline void raw_local_irq_enable(void)
 {
-	asm volatile(paravirt_alt("pushl %%ecx; pushl %%edx;"
+	asm volatile(paravirt_alt(PV_SAVE_REGS
 				  PARAVIRT_CALL
-				  "popl %%edx; popl %%ecx")
+				  PV_RESTORE_REGS)
 		     :
 		     : paravirt_type(pv_irq_ops.irq_enable),
 		       paravirt_clobber(CLBR_EAX)
-		     : "memory", "eax", "cc");
+		     : "memory", "eax", "cc" PV_EXTRA_CLOBBERS);
 }
 
 static inline unsigned long __raw_local_irq_save(void)
@@ -1205,6 +1221,7 @@
 		  CLBR_NONE,						\
 		  jmp *%cs:pv_cpu_ops+PV_CPU_irq_enable_syscall_ret)
 
+
 #ifdef CONFIG_X86_32
 #define GET_CR0_INTO_EAX			\
 	push %ecx; push %edx;			\
