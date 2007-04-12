From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: paravirt repo rebased to 2.6.21-rc6-mm1
Date: Thu, 12 Apr 2007 01:54:30 -0700
Message-ID: <20070412085430.GD10574@sequoia.sous-sol.org>
References: <461C1C7B.5080509@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <461C1C7B.5080509@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Seems to work OK for native and Xen.  I had to play a bit with the
> paravirt-sched-clock patch to deal with the VMI changes.  Zach, can you
> check that it still works?

Here's what's working for me on UP.  The boot cpu on UP is never getting
the GDT loaded.  Also __KERNEL_PERCPU is a bad selector on UP (ifdef
was Jeremy's idea, I was just hacking entry.S to get things to boot ;-).

diff -r cde7063e34bd arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	Wed Apr 11 18:07:02 2007 -0700
+++ b/arch/i386/kernel/cpu/common.c	Thu Apr 12 01:36:00 2007 -0700
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
diff -r cde7063e34bd arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Wed Apr 11 18:07:02 2007 -0700
+++ b/arch/i386/kernel/smpboot.c	Thu Apr 12 01:35:05 2007 -0700
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
diff -r cde7063e34bd include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	Wed Apr 11 18:07:02 2007 -0700
+++ b/include/asm-i386/processor.h	Thu Apr 12 01:37:44 2007 -0700
@@ -777,6 +777,7 @@ extern int sysenter_setup(void);
 extern int sysenter_setup(void);
 =

 extern void cpu_set_gdt(int);
+extern void switch_to_new_gdt(void);
 extern void cpu_init(void);
 =

 #endif /* __ASM_I386_PROCESSOR_H */
diff -r cde7063e34bd include/asm-i386/segment.h
--- a/include/asm-i386/segment.h	Wed Apr 11 18:07:02 2007 -0700
+++ b/include/asm-i386/segment.h	Thu Apr 12 01:45:24 2007 -0700
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
