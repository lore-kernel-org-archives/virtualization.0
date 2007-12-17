From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 5/21] [PATCH] unify paravirt pieces of processor.h
Date: Mon, 17 Dec 2007 20:52:28 -0200
Message-ID: <11979319903443-git-send-email-gcosta__33631.630233913$1197942210$gmane$org@redhat.com>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<1197931971748-git-send-email-gcosta@redhat.com>
	<11979319763641-git-send-email-gcosta@redhat.com>
	<11979319811234-git-send-email-gcosta@redhat.com>
	<11979319853319-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11979319853319-git-send-email-gcosta@redhat.com>
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

This patch unifies the paravirt pieces of processor.h
The functionality present in 32 bit, but not (yet) in 64-bit,
like load_sp0 is _not_ done here, and let to a different patch.

With this unification, we get paravirt for free in x86_64 processor.h

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/processor.h    |   90 +++++++++++++++++++++++++++++++++++++++-
 include/asm-x86/processor_32.h |   87 --------------------------------------
 include/asm-x86/processor_64.h |   36 ----------------
 3 files changed, 89 insertions(+), 124 deletions(-)

Index: linux-2.6-x86/include/asm-x86/processor.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor.h
+++ linux-2.6-x86/include/asm-x86/processor.h
@@ -29,9 +29,97 @@ static inline void load_cr3(pgd_t *pgdir
 # include "processor_64.h"
 #endif
 
+static inline unsigned long native_get_debugreg(int regno)
+{
+	unsigned long val = 0; 	/* Damn you, gcc! */
+
+	switch (regno) {
+	case 0:
+		asm("mov %%db0, %0" :"=r" (val)); break;
+	case 1:
+		asm("mov %%db1, %0" :"=r" (val)); break;
+	case 2:
+		asm("mov %%db2, %0" :"=r" (val)); break;
+	case 3:
+		asm("mov %%db3, %0" :"=r" (val)); break;
+	case 6:
+		asm("mov %%db6, %0" :"=r" (val)); break;
+	case 7:
+		asm("mov %%db7, %0" :"=r" (val)); break;
+	default:
+		BUG();
+	}
+	return val;
+}
+
+static inline void native_set_debugreg(int regno, unsigned long value)
+{
+	switch (regno) {
+	case 0:
+		asm("mov %0,%%db0"	: /* no output */ :"r" (value));
+		break;
+	case 1:
+		asm("mov %0,%%db1"	: /* no output */ :"r" (value));
+		break;
+	case 2:
+		asm("mov %0,%%db2"	: /* no output */ :"r" (value));
+		break;
+	case 3:
+		asm("mov %0,%%db3"	: /* no output */ :"r" (value));
+		break;
+	case 6:
+		asm("mov %0,%%db6"	: /* no output */ :"r" (value));
+		break;
+	case 7:
+		asm("mov %0,%%db7"	: /* no output */ :"r" (value));
+		break;
+	default:
+		BUG();
+	}
+}
+
+
 #ifndef CONFIG_PARAVIRT
 #define __cpuid native_cpuid
-#endif
+#define paravirt_enabled() 0
+
+/*
+ * These special macros can be used to get or set a debugging register
+ */
+#define get_debugreg(var, register)				\
+	(var) = native_get_debugreg(register)
+#define set_debugreg(value, register)				\
+	native_set_debugreg(register, value)
+
+#endif /* CONFIG_PARAVIRT */
+
+/*
+ * Save the cr4 feature set we're using (ie
+ * Pentium 4MB enable and PPro Global page
+ * enable), so that any CPU's that boot up
+ * after us can get the correct flags.
+ */
+extern unsigned long mmu_cr4_features;
+
+static inline void set_in_cr4(unsigned long mask)
+{
+	unsigned cr4;
+	mmu_cr4_features |= mask;
+	cr4 = read_cr4();
+	cr4 |= mask;
+	write_cr4(cr4);
+}
+
+static inline void clear_in_cr4(unsigned long mask)
+{
+	unsigned cr4;
+	mmu_cr4_features &= ~mask;
+	cr4 = read_cr4();
+	cr4 &= ~mask;
+	write_cr4(cr4);
+}
+
+
 
 /*
  * Generic CPUID function
Index: linux-2.6-x86/include/asm-x86/processor_32.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor_32.h
+++ linux-2.6-x86/include/asm-x86/processor_32.h
@@ -120,33 +120,6 @@ extern void detect_ht(struct cpuinfo_x86
 static inline void detect_ht(struct cpuinfo_x86 *c) {}
 #endif
 
-
-/*
- * Save the cr4 feature set we're using (ie
- * Pentium 4MB enable and PPro Global page
- * enable), so that any CPU's that boot up
- * after us can get the correct flags.
- */
-extern unsigned long mmu_cr4_features;
-
-static inline void set_in_cr4 (unsigned long mask)
-{
-	unsigned cr4;
-	mmu_cr4_features |= mask;
-	cr4 = read_cr4();
-	cr4 |= mask;
-	write_cr4(cr4);
-}
-
-static inline void clear_in_cr4 (unsigned long mask)
-{
-	unsigned cr4;
-	mmu_cr4_features &= ~mask;
-	cr4 = read_cr4();
-	cr4 &= ~mask;
-	write_cr4(cr4);
-}
-
 /* Stop speculative execution */
 static inline void sync_core(void)
 {
@@ -484,57 +457,6 @@ static inline void native_load_sp0(struc
 		wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
 	}
 }
-
-
-static inline unsigned long native_get_debugreg(int regno)
-{
-	unsigned long val = 0; 	/* Damn you, gcc! */
-
-	switch (regno) {
-	case 0:
-		asm("movl %%db0, %0" :"=r" (val)); break;
-	case 1:
-		asm("movl %%db1, %0" :"=r" (val)); break;
-	case 2:
-		asm("movl %%db2, %0" :"=r" (val)); break;
-	case 3:
-		asm("movl %%db3, %0" :"=r" (val)); break;
-	case 6:
-		asm("movl %%db6, %0" :"=r" (val)); break;
-	case 7:
-		asm("movl %%db7, %0" :"=r" (val)); break;
-	default:
-		BUG();
-	}
-	return val;
-}
-
-static inline void native_set_debugreg(int regno, unsigned long value)
-{
-	switch (regno) {
-	case 0:
-		asm("movl %0,%%db0"	: /* no output */ :"r" (value));
-		break;
-	case 1:
-		asm("movl %0,%%db1"	: /* no output */ :"r" (value));
-		break;
-	case 2:
-		asm("movl %0,%%db2"	: /* no output */ :"r" (value));
-		break;
-	case 3:
-		asm("movl %0,%%db3"	: /* no output */ :"r" (value));
-		break;
-	case 6:
-		asm("movl %0,%%db6"	: /* no output */ :"r" (value));
-		break;
-	case 7:
-		asm("movl %0,%%db7"	: /* no output */ :"r" (value));
-		break;
-	default:
-		BUG();
-	}
-}
-
 /*
  * Set IOPL bits in EFLAGS from given mask
  */
@@ -554,21 +476,12 @@ static inline void native_set_iopl_mask(
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #else
-#define paravirt_enabled() 0
 
 static inline void load_sp0(struct tss_struct *tss, struct thread_struct *thread)
 {
 	native_load_sp0(tss, thread);
 }
 
-/*
- * These special macros can be used to get or set a debugging register
- */
-#define get_debugreg(var, register)				\
-	(var) = native_get_debugreg(register)
-#define set_debugreg(value, register)				\
-	native_set_debugreg(register, value)
-
 #define set_iopl_mask native_set_iopl_mask
 #endif /* CONFIG_PARAVIRT */
 
Index: linux-2.6-x86/include/asm-x86/processor_64.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/processor_64.h
+++ linux-2.6-x86/include/asm-x86/processor_64.h
@@ -88,34 +88,6 @@ extern void init_scattered_cpuid_feature
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern unsigned short num_cache_leaves;
 
-/*
- * Save the cr4 feature set we're using (ie
- * Pentium 4MB enable and PPro Global page
- * enable), so that any CPU's that boot up
- * after us can get the correct flags.
- */
-extern unsigned long mmu_cr4_features;
-
-static inline void set_in_cr4 (unsigned long mask)
-{
-	mmu_cr4_features |= mask;
-	__asm__("movq %%cr4,%%rax\n\t"
-		"orq %0,%%rax\n\t"
-		"movq %%rax,%%cr4\n"
-		: : "irg" (mask)
-		:"ax");
-}
-
-static inline void clear_in_cr4 (unsigned long mask)
-{
-	mmu_cr4_features &= ~mask;
-	__asm__("movq %%cr4,%%rax\n\t"
-		"andq %0,%%rax\n\t"
-		"movq %%rax,%%cr4\n"
-		: : "irg" (~mask)
-		:"ax");
-}
-
 
 /*
  * User space process size. 47bits minus one guard page.
@@ -254,14 +226,6 @@ struct thread_struct {
 	set_fs(USER_DS);							 \
 } while(0) 
 
-#define get_debugreg(var, register)				\
-		__asm__("movq %%db" #register ", %0"		\
-			:"=r" (var))
-#define set_debugreg(value, register)			\
-		__asm__("movq %0,%%db" #register		\
-			: /* no output */			\
-			:"r" (value))
-
 struct task_struct;
 struct mm_struct;
