From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 09/15] adds paravirt hook for swapgs
Date: Thu, 20 Dec 2007 18:04:04 -0200
Message-ID: <11981813192341-git-send-email-gcosta__12561.1807140105$1198182030$gmane$org@redhat.com>
References: <11981810504172-git-send-email-gcosta@redhat.com>
	<11981811293763-git-send-email-gcosta@redhat.com>
	<11981811852758-git-send-email-gcosta@redhat.com>
	<11981812041672-git-send-email-gcosta@redhat.com>
	<1198181215625-git-send-email-gcosta@redhat.com>
	<1198181224677-git-send-email-gcosta@redhat.com>
	<11981812412879-git-send-email-gcosta@redhat.com>
	<11981812771615-git-send-email-gcosta@redhat.com>
	<1198181309285-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1198181309285-git-send-email-gcosta@redhat.com>
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

This patch adds paravirt hook for swapgs operation, which is a privileged
operation in x86_64.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/paravirt.c  |    1 +
 include/asm-x86/paravirt.h  |    9 +++++++++
 include/asm-x86/processor.h |    8 ++++++++
 3 files changed, 18 insertions(+), 0 deletions(-)

Index: linux-2.6-x86/arch/x86/kernel/paravirt.c
===================================================================
--- linux-2.6-x86.orig/arch/x86/kernel/paravirt.c	2007-12-20 19:07:22.000000000 -0800
+++ linux-2.6-x86/arch/x86/kernel/paravirt.c	2007-12-20 19:08:06.000000000 -0800
@@ -390,6 +390,7 @@
 
 	.irq_enable_syscall_ret = native_irq_enable_syscall_ret,
 	.iret = native_iret,
+	.swapgs = native_swapgs,
 
 	.set_iopl_mask = native_set_iopl_mask,
 	.io_delay = native_io_delay,
Index: linux-2.6-x86/include/asm-x86/paravirt.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/paravirt.h	2007-12-20 19:07:29.000000000 -0800
+++ linux-2.6-x86/include/asm-x86/paravirt.h	2007-12-20 19:08:06.000000000 -0800
@@ -127,6 +127,8 @@
 	void (*irq_enable_syscall_ret)(void);
 	void (*iret)(void);
 
+	void (*swapgs)(void);
+
 	struct pv_lazy_ops lazy_mode;
 };
 
@@ -1228,6 +1230,13 @@
 	call *pv_cpu_ops+PV_CPU_read_cr0;	\
 	pop %edx; pop %ecx
 #else
+#define SWAPGS								\
+	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
+		  PV_SAVE_REGS						\
+		  call *pv_cpu_ops+PV_CPU_swapgs;			\
+		  PV_RESTORE_REGS					\
+		 )
+
 #define GET_CR2_INTO_RCX			\
 	call *pv_mmu_ops+PV_MMU_read_cr2;	\
 	movq %rax, %rcx;			\
Index: linux-2.6-x86/include/asm-x86/processor.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor.h	2007-12-20 19:06:59.000000000 -0800
+++ linux-2.6-x86/include/asm-x86/processor.h	2007-12-20 19:08:06.000000000 -0800
@@ -435,6 +435,13 @@
 #endif
 }
 
+static inline void native_swapgs(void)
+{
+#ifdef CONFIG_X86_64
+	asm volatile("swapgs" ::: "memory");
+#endif
+}
+
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #else
@@ -456,6 +463,7 @@
 }
 
 #define set_iopl_mask native_set_iopl_mask
+#define SWAPGS	swapgs
 #endif /* CONFIG_PARAVIRT */
 
 /*
