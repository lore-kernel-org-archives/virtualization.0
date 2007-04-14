From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 09/28] Fix UP gdt bugs
Date: Sat, 14 Apr 2007 13:42:03 -0700
Message-ID: <20070414204924.051019372@goop.org>
References: <20070414204154.871250608@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=fix-uniproc-gdt-bugs.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Fixes two problems with the GDT when compiling for uniprocessor:
 - There's no percpu segment, so trying to load its selector into %fs fails.
   Use a null selector instead.
 - The real gdt needs to be loaded at some point.  Do it in cpu_init().

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>

---
 arch/i386/kernel/cpu/common.c |   13 +++++++++++++
 arch/i386/kernel/smpboot.c    |   12 ------------
 include/asm-i386/processor.h  |    1 +
 include/asm-i386/segment.h    |    4 ++++
 4 files changed, 18 insertions(+), 12 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -644,6 +644,18 @@ struct pt_regs * __devinit idle_regs(str
 	return regs;
 }
 =

+/* Current gdt points %fs at the "master" per-cpu area: after this,
+ * it's on the real one. */
+void switch_to_new_gdt(void)
+{
+	struct Xgt_desc_struct gdt_descr;
+
+	gdt_descr.address =3D (long)get_cpu_gdt_table(smp_processor_id());
+	gdt_descr.size =3D GDT_SIZE - 1;
+	load_gdt(&gdt_descr);
+	asm("mov %0, %%fs" : : "r" (__KERNEL_PERCPU) : "memory");
+}
+
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT
@@ -674,6 +688,7 @@ void __cpuinit cpu_init(void)
 	}
 =

 	load_idt(&idt_descr);
+	switch_to_new_gdt();
 =

 	/*
 	 * Set up and load the per-CPU TSS and LDT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -1176,18 +1176,6 @@ void __init native_smp_prepare_cpus(unsi
 	smp_boot_cpus(max_cpus);
 }
 =

-/* Current gdt points %fs at the "master" per-cpu area: after this,
- * it's on the real one. */
-static inline void switch_to_new_gdt(void)
-{
-	struct Xgt_desc_struct gdt_descr;
-
-	gdt_descr.address =3D (long)get_cpu_gdt_table(smp_processor_id());
-	gdt_descr.size =3D GDT_SIZE - 1;
-	load_gdt(&gdt_descr);
-	asm("mov %0, %%fs" : : "r" (__KERNEL_PERCPU) : "memory");
-}
-
 void __init native_smp_prepare_boot_cpu(void)
 {
 	unsigned int cpu =3D smp_processor_id();
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -777,6 +777,7 @@ extern int sysenter_setup(void);
 extern int sysenter_setup(void);
 =

 extern void cpu_set_gdt(int);
+extern void switch_to_new_gdt(void);
 extern void cpu_init(void);
 =

 #endif /* __ASM_I386_PROCESSOR_H */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/segment.h
+++ b/include/asm-i386/segment.h
@@ -75,7 +75,11 @@
 #define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8)
 =

 #define GDT_ENTRY_PERCPU			(GDT_ENTRY_KERNEL_BASE + 15)
+#ifdef CONFIG_SMP
 #define __KERNEL_PERCPU (GDT_ENTRY_PERCPU * 8)
+#else
+#define __KERNEL_PERCPU 0
+#endif
 =

 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 =


-- =
