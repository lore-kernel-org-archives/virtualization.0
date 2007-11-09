From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 8/24] consolidate system.h
Date: Fri,  9 Nov 2007 16:42:49 -0200
Message-ID: <1194633831882-git-send-email-gcosta__9871.48457575149$1194643908$gmane$org@redhat.com>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<11946337933104-git-send-email-gcosta@redhat.com>
	<11946337991750-git-send-email-gcosta@redhat.com>
	<11946338053158-git-send-email-gcosta@redhat.com>
	<11946338103068-git-send-email-gcosta@redhat.com>
	<1194633815833-git-send-email-gcosta@redhat.com>
	<11946338212915-git-send-email-gcosta@redhat.com>
	<11946338263902-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11946338263902-git-send-email-gcosta@redhat.com>
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
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This patch consolidates system.h header. For i386, it adds functions
read/write_cr8 that ain't really needed, but will also not hurt. If they are
used somewhere in i386 code, there's a bug anyway, and should be fixed.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 include/asm-x86/system.h    |  134 +++++++++++++++++++++++++++++++++++++++++++
 include/asm-x86/system_32.h |  102 --------------------------------
 include/asm-x86/system_64.h |   77 -------------------------
 3 files changed, 134 insertions(+), 179 deletions(-)

diff --git a/include/asm-x86/system.h b/include/asm-x86/system.h
index 692562b..ef20916 100644
--- a/include/asm-x86/system.h
+++ b/include/asm-x86/system.h
@@ -1,5 +1,139 @@
+#ifndef _X86_SYSTEM_H_
+#define _X86_SYSTEM_H_
+
+#include <linux/kernel.h>
+
+static inline void native_clts(void)
+{
+	asm volatile ("clts");
+}
+
+/*
+ * Volatile isn't enough to prevent the compiler from reordering the
+ * read/write functions for the control registers and messing everything up.
+ * A memory clobber would solve the problem, but would prevent reordering of
+ * all loads stores around it, which can hurt performance. Solution is to
+ * use a variable and mimic reads and writes to it to enforce serialization
+ */
+static unsigned long __force_order;
+
+static inline unsigned long native_read_cr0(void)
+{
+	unsigned long val;
+	asm volatile("mov %%cr0,%0\n\t" :"=r" (val), "=m" (__force_order));
+	return val;
+}
+
+static inline void native_write_cr0(unsigned long val)
+{
+	asm volatile("mov %0,%%cr0": :"r" (val), "m" (__force_order));
+}
+
+static inline unsigned long native_read_cr2(void)
+{
+	unsigned long val;
+	asm volatile("mov %%cr2,%0\n\t" :"=r" (val), "=m" (__force_order));
+	return val;
+}
+
+static inline void native_write_cr2(unsigned long val)
+{
+	asm volatile("mov %0,%%cr2": :"r" (val), "m" (__force_order));
+}
+
+static inline unsigned long native_read_cr3(void)
+{
+	unsigned long val;
+	asm volatile("mov %%cr3,%0\n\t" :"=r" (val), "=m" (__force_order));
+	return val;
+}
+
+static inline void native_write_cr3(unsigned long val)
+{
+	asm volatile("mov %0,%%cr3": :"r" (val), "m" (__force_order));
+}
+
+static inline unsigned long native_read_cr4(void)
+{
+	unsigned long val;
+	asm volatile("mov %%cr4,%0\n\t" :"=r" (val), "=m" (__force_order));
+	return val;
+}
+
+static inline unsigned long native_read_cr4_safe(void)
+{
+	unsigned long val;
+	/* This could fault if %cr4 does not exist. In x86_64, a cr4 always
+ 	 * exists, so it will never fail. */
+#ifdef CONFIG_X86_32
+	asm volatile("1: mov %%cr4, %0		\n"
+		"2:				\n"
+		".section __ex_table,\"a\"	\n"
+		".long 1b,2b			\n"
+		".previous			\n"
+		: "=r" (val), "=m" (__force_order) : "0" (0));
+#else
+	val = native_read_cr4();
+#endif
+	return val;
+}
+
+static inline void native_write_cr4(unsigned long val)
+{
+	asm volatile("mov %0,%%cr4": :"r" (val), "m" (__force_order));
+}
+
+static inline unsigned long native_read_cr8(void)
+{
+	unsigned long cr8;
+	asm volatile("mov %%cr8,%0" : "=r" (cr8), "=m" (__force_order));
+	return cr8;
+}
+
+static inline void native_write_cr8(unsigned long val)
+{
+	asm volatile("mov %0,%%cr8" : : "r" (val));
+}
+
+static inline void native_wbinvd(void)
+{
+	asm volatile("wbinvd": : :"memory");
+}
+
+static inline void clflush(volatile void *__p)
+{
+	asm volatile("clflush %0" : "+m" (*(char __force *)__p));
+}
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define read_cr0()	(native_read_cr0())
+#define write_cr0(x)	(native_write_cr0(x))
+#define read_cr2()	(native_read_cr2())
+#define write_cr2(x)	(native_write_cr2(x))
+#define read_cr3()	(native_read_cr3())
+#define write_cr3(x)	(native_write_cr3(x))
+#define read_cr4()	(native_read_cr4())
+#define read_cr4_safe()	(native_read_cr4_safe())
+#define write_cr4(x)	(native_write_cr4(x))
+#define read_cr8()	(native_read_cr8())
+#define write_cr8(x)	(native_write_cr8(x))
+#define wbinvd()	(native_wbinvd())
+
+/* Clear the 'TS' bit */
+#define clts()		(native_clts())
+
+#endif/* CONFIG_PARAVIRT */
+
+#define stts() write_cr0(8 | read_cr0())
+
+#define nop() __asm__ __volatile__ ("nop")
+
 #ifdef CONFIG_X86_32
 # include "system_32.h"
 #else
 # include "system_64.h"
 #endif
+
+#endif
diff --git a/include/asm-x86/system_32.h b/include/asm-x86/system_32.h
index db6283e..26fc8f5 100644
--- a/include/asm-x86/system_32.h
+++ b/include/asm-x86/system_32.h
@@ -1,7 +1,6 @@
 #ifndef __ASM_SYSTEM_H
 #define __ASM_SYSTEM_H
 
-#include <linux/kernel.h>
 #include <asm/segment.h>
 #include <asm/cpufeature.h>
 #include <asm/cmpxchg.h>
@@ -89,105 +88,6 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t" \
 #define savesegment(seg, value) \
 	asm volatile("mov %%" #seg ",%0":"=rm" (value))
 
-
-static inline void native_clts(void)
-{
-	asm volatile ("clts");
-}
-
-static inline unsigned long native_read_cr0(void)
-{
-	unsigned long val;
-	asm volatile("movl %%cr0,%0\n\t" :"=r" (val));
-	return val;
-}
-
-static inline void native_write_cr0(unsigned long val)
-{
-	asm volatile("movl %0,%%cr0": :"r" (val));
-}
-
-static inline unsigned long native_read_cr2(void)
-{
-	unsigned long val;
-	asm volatile("movl %%cr2,%0\n\t" :"=r" (val));
-	return val;
-}
-
-static inline void native_write_cr2(unsigned long val)
-{
-	asm volatile("movl %0,%%cr2": :"r" (val));
-}
-
-static inline unsigned long native_read_cr3(void)
-{
-	unsigned long val;
-	asm volatile("movl %%cr3,%0\n\t" :"=r" (val));
-	return val;
-}
-
-static inline void native_write_cr3(unsigned long val)
-{
-	asm volatile("movl %0,%%cr3": :"r" (val));
-}
-
-static inline unsigned long native_read_cr4(void)
-{
-	unsigned long val;
-	asm volatile("movl %%cr4,%0\n\t" :"=r" (val));
-	return val;
-}
-
-static inline unsigned long native_read_cr4_safe(void)
-{
-	unsigned long val;
-	/* This could fault if %cr4 does not exist */
-	asm volatile("1: movl %%cr4, %0		\n"
-		"2:				\n"
-		".section __ex_table,\"a\"	\n"
-		".long 1b,2b			\n"
-		".previous			\n"
-		: "=r" (val): "0" (0));
-	return val;
-}
-
-static inline void native_write_cr4(unsigned long val)
-{
-	asm volatile("movl %0,%%cr4": :"r" (val));
-}
-
-static inline void native_wbinvd(void)
-{
-	asm volatile("wbinvd": : :"memory");
-}
-
-static inline void clflush(volatile void *__p)
-{
-	asm volatile("clflush %0" : "+m" (*(char __force *)__p));
-}
-
-#ifdef CONFIG_PARAVIRT
-#include <asm/paravirt.h>
-#else
-#define read_cr0()	(native_read_cr0())
-#define write_cr0(x)	(native_write_cr0(x))
-#define read_cr2()	(native_read_cr2())
-#define write_cr2(x)	(native_write_cr2(x))
-#define read_cr3()	(native_read_cr3())
-#define write_cr3(x)	(native_write_cr3(x))
-#define read_cr4()	(native_read_cr4())
-#define read_cr4_safe()	(native_read_cr4_safe())
-#define write_cr4(x)	(native_write_cr4(x))
-#define wbinvd()	(native_wbinvd())
-
-/* Clear the 'TS' bit */
-#define clts()		(native_clts())
-
-#endif/* CONFIG_PARAVIRT */
-
-/* Set the 'TS' bit */
-#define stts() write_cr0(8 | read_cr0())
-
 #endif	/* __KERNEL__ */
 
 static inline unsigned long get_limit(unsigned long segment)
@@ -198,8 +98,6 @@ static inline unsigned long get_limit(unsigned long segment)
 	return __limit+1;
 }
 
-#define nop() __asm__ __volatile__ ("nop")
-
 /*
  * Force strict CPU ordering.
  * And yes, this is required on UP too when we're talking
diff --git a/include/asm-x86/system_64.h b/include/asm-x86/system_64.h
index 4cb2384..84a8f10 100644
--- a/include/asm-x86/system_64.h
+++ b/include/asm-x86/system_64.h
@@ -1,7 +1,6 @@
 #ifndef __ASM_SYSTEM_H
 #define __ASM_SYSTEM_H
 
-#include <linux/kernel.h>
 #include <asm/segment.h>
 #include <asm/cmpxchg.h>
 
@@ -62,85 +61,9 @@ extern void load_gs_index(unsigned);
 		".previous"			\
 		: :"r" (value), "r" (0))
 
-/*
- * Clear and set 'TS' bit respectively
- */
-#define clts() __asm__ __volatile__ ("clts")
-
-static inline unsigned long read_cr0(void)
-{ 
-	unsigned long cr0;
-	asm volatile("movq %%cr0,%0" : "=r" (cr0));
-	return cr0;
-}
-
-static inline void write_cr0(unsigned long val) 
-{ 
-	asm volatile("movq %0,%%cr0" :: "r" (val));
-}
-
-static inline unsigned long read_cr2(void)
-{
-	unsigned long cr2;
-	asm volatile("movq %%cr2,%0" : "=r" (cr2));
-	return cr2;
-}
-
-static inline void write_cr2(unsigned long val)
-{
-	asm volatile("movq %0,%%cr2" :: "r" (val));
-}
-
-static inline unsigned long read_cr3(void)
-{ 
-	unsigned long cr3;
-	asm volatile("movq %%cr3,%0" : "=r" (cr3));
-	return cr3;
-}
-
-static inline void write_cr3(unsigned long val)
-{
-	asm volatile("movq %0,%%cr3" :: "r" (val) : "memory");
-}
-
-static inline unsigned long read_cr4(void)
-{ 
-	unsigned long cr4;
-	asm volatile("movq %%cr4,%0" : "=r" (cr4));
-	return cr4;
-}
-
-static inline void write_cr4(unsigned long val)
-{ 
-	asm volatile("movq %0,%%cr4" :: "r" (val) : "memory");
-}
-
-static inline unsigned long read_cr8(void)
-{
-	unsigned long cr8;
-	asm volatile("movq %%cr8,%0" : "=r" (cr8));
-	return cr8;
-}
-
-static inline void write_cr8(unsigned long val)
-{
-	asm volatile("movq %0,%%cr8" :: "r" (val) : "memory");
-}
-
-#define stts() write_cr0(8 | read_cr0())
-
-#define wbinvd() \
-	__asm__ __volatile__ ("wbinvd": : :"memory")
 
 #endif	/* __KERNEL__ */
 
-static inline void clflush(volatile void *__p)
-{
-	asm volatile("clflush %0" : "+m" (*(char __force *)__p));
-}
-
-#define nop() __asm__ __volatile__ ("nop")
-
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	barrier()
-- 
1.4.4.2
