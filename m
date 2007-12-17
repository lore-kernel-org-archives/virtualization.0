From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 6/21] [PATCH] move the definition of set_iopl_mask to common
	header
Date: Mon, 17 Dec 2007 20:52:29 -0200
Message-ID: <11979319953427-git-send-email-gcosta__30128.4724766903$1197942402$gmane$org@redhat.com>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<1197931971748-git-send-email-gcosta@redhat.com>
	<11979319763641-git-send-email-gcosta@redhat.com>
	<11979319811234-git-send-email-gcosta@redhat.com>
	<11979319853319-git-send-email-gcosta@redhat.com>
	<11979319903443-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11979319903443-git-send-email-gcosta@redhat.com>
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

This patch moves the definition of set_iopl_mask to processor.h,
instead of letting it at processor_32.h.
For x86_64, nothing is done, as we don't really need such a function.
However, having it on both arches saves us from putting an ifdef in the
pv_cpu_ops struct.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/processor.h    |   19 +++++++++++++++++++
 include/asm-x86/processor_32.h |   17 -----------------
 2 files changed, 19 insertions(+), 17 deletions(-)

Index: linux-2.6-x86/include/asm-x86/processor.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor.h
+++ linux-2.6-x86/include/asm-x86/processor.h
@@ -78,6 +78,24 @@ static inline void native_set_debugreg(i
 	}
 }
 
+/*
+ * Set IOPL bits in EFLAGS from given mask
+ */
+static inline void native_set_iopl_mask(unsigned mask)
+{
+#ifdef CONFIG_X86_32
+	unsigned int reg;
+	__asm__ __volatile__ ("pushfl;"
+			      "popl %0;"
+			      "andl %1, %0;"
+			      "orl %2, %0;"
+			      "pushl %0;"
+			      "popfl"
+				: "=&r" (reg)
+				: "i" (~X86_EFLAGS_IOPL), "r" (mask));
+#endif
+}
+
 
 #ifndef CONFIG_PARAVIRT
 #define __cpuid native_cpuid
@@ -91,6 +109,7 @@ static inline void native_set_debugreg(i
 #define set_debugreg(value, register)				\
 	native_set_debugreg(register, value)
 
+#define set_iopl_mask native_set_iopl_mask
 #endif /* CONFIG_PARAVIRT */
 
 /*
Index: linux-2.6-x86/include/asm-x86/processor_32.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor_32.h
+++ linux-2.6-x86/include/asm-x86/processor_32.h
@@ -455,21 +455,6 @@ static inline void native_load_sp0(struc
 		wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
 	}
 }
-/*
- * Set IOPL bits in EFLAGS from given mask
- */
-static inline void native_set_iopl_mask(unsigned mask)
-{
-	unsigned int reg;
-	__asm__ __volatile__ ("pushfl;"
-			      "popl %0;"
-			      "andl %1, %0;"
-			      "orl %2, %0;"
-			      "pushl %0;"
-			      "popfl"
-				: "=&r" (reg)
-				: "i" (~X86_EFLAGS_IOPL), "r" (mask));
-}
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
@@ -479,8 +464,6 @@ static inline void load_sp0(struct tss_s
 {
 	native_load_sp0(tss, thread);
 }
-
-#define set_iopl_mask native_set_iopl_mask
 #endif /* CONFIG_PARAVIRT */
 
 /* generic versions from gas */
