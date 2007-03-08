From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 03/17] paravirt_ops - system routines
Date: Thu, 08 Mar 2007 01:01:59 -0500
Message-ID: <1173333719.25848.4.camel@localhost.localdomain>
References: <20070308054422.820010000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (xx-paravirt-processor-header.patch)
System routine updates for the paravirt_ops interface.

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>


Index: clean-start/include/asm-x86_64/processor.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/processor.h
+++ clean-start/include/asm-x86_64/processor.h
@@ -139,35 +139,6 @@ extern unsigned short num_cache_leaves;
 #define X86_CR4_OSXMMEXCPT	0x0400	/* enable unmasked SSE exceptions */
 =

 /*
- * Save the cr4 feature set we're using (ie
- * Pentium 4MB enable and PPro Global page
- * enable), so that any CPU's that boot up
- * after us can get the correct flags.
- */
-extern unsigned long mmu_cr4_features;
-
-static inline void set_in_cr4 (unsigned long mask)
-{
-	mmu_cr4_features |=3D mask;
-	__asm__("movq %%cr4,%%rax\n\t"
-		"orq %0,%%rax\n\t"
-		"movq %%rax,%%cr4\n"
-		: : "irg" (mask)
-		:"ax");
-}
-
-static inline void clear_in_cr4 (unsigned long mask)
-{
-	mmu_cr4_features &=3D ~mask;
-	__asm__("movq %%cr4,%%rax\n\t"
-		"andq %0,%%rax\n\t"
-		"movq %%rax,%%cr4\n"
-		: : "irg" (~mask)
-		:"ax");
-}
-
-
-/*
  * User space process size. 47bits minus one guard page.
  */
 #define TASK_SIZE64	(0x800000000000UL - 4096)
@@ -299,6 +270,10 @@ struct thread_struct {
 	set_fs(USER_DS);							 \
 } while(0) =

 =

+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define paravirt_enabled() 0
 #define get_debugreg(var, register)				\
 		__asm__("movq %%db" #register ", %0"		\
 			:"=3Dr" (var))
@@ -306,6 +281,31 @@ struct thread_struct {
 		__asm__("movq %0,%%db" #register		\
 			: /* no output */			\
 			:"r" (value))
+#define load_rsp0(tss, thread)				\
+	do { (tss)->rsp0 =3D (thread)->rsp0; } while(0)
+#endif
+
+/*
+ * Save the cr4 feature set we're using (ie
+ * Pentium 4MB enable and PPro Global page
+ * enable), so that any CPU's that boot up
+ * after us can get the correct flags.
+ */
+extern unsigned long mmu_cr4_features;
+
+static inline void set_in_cr4 (unsigned long mask)
+{
+	mmu_cr4_features |=3D mask;
+	write_cr4(read_cr4() | mask);
+}
+
+static inline void clear_in_cr4 (unsigned long mask)
+{
+	mmu_cr4_features &=3D ~mask;
+	write_cr4(read_cr4() & ~mask);
+}
+
+
 =

 struct task_struct;
 struct mm_struct;
Index: clean-start/include/asm-x86_64/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/system.h
+++ clean-start/include/asm-x86_64/system.h
@@ -65,46 +65,84 @@ extern void load_gs_index(unsigned); =

 		".previous"			\
 		: :"r" (value), "r" (0))
 =

+static inline void native_clts(void)
+{
+	asm volatile ("clts");
+}
+
+static inline unsigned long native_read_cr0(void)
+{
+	unsigned long val;
+	asm volatile("movq %%cr0,%0\n\t" :"=3Dr" (val));
+	return val;
+}
+
+static inline void native_write_cr0(unsigned long val)
+{
+	asm volatile("movq %0,%%cr0": :"r" (val));
+}
+
+static inline unsigned long native_read_cr2(void)
+{
+	unsigned long val;
+	asm volatile("movq %%cr2,%0\n\t" :"=3Dr" (val));
+	return val;
+}
+
+static inline void native_write_cr2(unsigned long val)
+{
+	asm volatile("movq %0,%%cr2": :"r" (val));
+}
+
+static inline unsigned long native_read_cr3(void)
+{
+	unsigned long val;
+	asm volatile("movq %%cr3,%0\n\t" :"=3Dr" (val));
+	return val;
+}
+
+static inline void native_write_cr3(unsigned long val)
+{
+	asm volatile("movq %0,%%cr3": :"r" (val));
+}
+
+static inline unsigned long native_read_cr4(void)
+{
+	unsigned long val;
+	asm volatile("movq %%cr4,%0\n\t" :"=3Dr" (val));
+	return val;
+}
+
+static inline void native_write_cr4(unsigned long val)
+{
+	asm volatile("movq %0,%%cr4": :"r" (val));
+}
+
+static inline void native_wbinvd(void)
+{
+	asm volatile("wbinvd": : :"memory");
+}
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
 /*
  * Clear and set 'TS' bit respectively
  */
-#define clts() __asm__ __volatile__ ("clts")
-
-static inline unsigned long read_cr0(void)
-{ =

-	unsigned long cr0;
-	asm volatile("movq %%cr0,%0" : "=3Dr" (cr0));
-	return cr0;
-} =

-
-static inline void write_cr0(unsigned long val) =

-{ =

-	asm volatile("movq %0,%%cr0" :: "r" (val));
-} =

-
-static inline unsigned long read_cr3(void)
-{ =

-	unsigned long cr3;
-	asm("movq %%cr3,%0" : "=3Dr" (cr3));
-	return cr3;
-} =

-
-static inline unsigned long read_cr4(void)
-{ =

-	unsigned long cr4;
-	asm("movq %%cr4,%0" : "=3Dr" (cr4));
-	return cr4;
-} =

-
-static inline void write_cr4(unsigned long val)
-{ =

-	asm volatile("movq %0,%%cr4" :: "r" (val));
-} =

+#define clts	 native_clts
+#define read_cr0 native_read_cr0
+#define write_cr0 native_write_cr0
+#define read_cr2 native_read_cr2
+#define write_cr2 native_write_cr2
+#define read_cr3 native_read_cr3
+#define write_cr3 native_write_cr3
+#define read_cr4 native_read_cr4
+#define write_cr4 native_write_cr4
+#define wbinvd	native_wbinvd
+#endif /* CONFIG_PARAVIRT */
 =

 #define stts() write_cr0(8 | read_cr0())
 =

-#define wbinvd() \
-	__asm__ __volatile__ ("wbinvd": : :"memory");
 =

 /*
  * On SMP systems, when the scheduler does migration-cost autodetection,

--
