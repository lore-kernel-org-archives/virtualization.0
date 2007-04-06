From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 1/4] Clean up asm-i386/bugs.h
Date: Fri, 06 Apr 2007 15:41:53 -0700
Message-ID: <20070406224204.596151568@goop.org>
References: <20070406224152.556848893@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=cleanup-asm-bugs_h.patch
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
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Most of asm-i386/bugs.h is code which should be in a C file, so put it ther=
e.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>

---
 arch/i386/kernel/cpu/Makefile  |    2 =

 arch/i386/kernel/cpu/bugs.c    |  191 ++++++++++++++++++++++++++++++++++++=
+++
 include/asm-i386/alternative.h |    1 =

 include/asm-i386/bugs.h        |  194 ------------------------------------=
----
 4 files changed, 197 insertions(+), 191 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/cpu/Makefile
+++ b/arch/i386/kernel/cpu/Makefile
@@ -2,7 +2,7 @@
 # Makefile for x86-compatible CPU details and quirks
 #
 =

-obj-y	:=3D	common.o proc.o
+obj-y	:=3D	common.o proc.o bugs.o
 =

 obj-y	+=3D	amd.o
 obj-y	+=3D	cyrix.o
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/arch/i386/kernel/cpu/bugs.c
@@ -0,0 +1,191 @@
+/*
+ *  arch/i386/cpu/bugs.c
+ *
+ *  Copyright (C) 1994  Linus Torvalds
+ *
+ *  Cyrix stuff, June 1998 by:
+ *	- Rafael R. Reilova (moved everything from head.S),
+ *        <rreilova@ececs.uc.edu>
+ *	- Channing Corn (tests & fixes),
+ *	- Andrew D. Balsa (code cleanup).
+ */
+#include <linux/init.h>
+#include <linux/utsname.h>
+#include <asm/processor.h>
+#include <asm/i387.h>
+#include <asm/msr.h>
+#include <asm/paravirt.h>
+#include <asm/alternative.h>
+
+static int __init no_halt(char *s)
+{
+	boot_cpu_data.hlt_works_ok =3D 0;
+	return 1;
+}
+
+__setup("no-hlt", no_halt);
+
+static int __init mca_pentium(char *s)
+{
+	mca_pentium_flag =3D 1;
+	return 1;
+}
+
+__setup("mca-pentium", mca_pentium);
+
+static int __init no_387(char *s)
+{
+	boot_cpu_data.hard_math =3D 0;
+	write_cr0(0xE | read_cr0());
+	return 1;
+}
+
+__setup("no387", no_387);
+
+static double __initdata x =3D 4195835.0;
+static double __initdata y =3D 3145727.0;
+
+/*
+ * This used to check for exceptions..
+ * However, it turns out that to support that,
+ * the XMM trap handlers basically had to
+ * be buggy. So let's have a correct XMM trap
+ * handler, and forget about printing out
+ * some status at boot.
+ *
+ * We should really only care about bugs here
+ * anyway. Not features.
+ */
+static void __init check_fpu(void)
+{
+	if (!boot_cpu_data.hard_math) {
+#ifndef CONFIG_MATH_EMULATION
+		printk(KERN_EMERG "No coprocessor found and no math emulation present.\n=
");
+		printk(KERN_EMERG "Giving up.\n");
+		for (;;) ;
+#endif
+		return;
+	}
+
+/* trap_init() enabled FXSR and company _before_ testing for FP problems h=
ere. */
+	/* Test for the divl bug.. */
+	__asm__("fninit\n\t"
+		"fldl %1\n\t"
+		"fdivl %2\n\t"
+		"fmull %2\n\t"
+		"fldl %1\n\t"
+		"fsubp %%st,%%st(1)\n\t"
+		"fistpl %0\n\t"
+		"fwait\n\t"
+		"fninit"
+		: "=3Dm" (*&boot_cpu_data.fdiv_bug)
+		: "m" (*&x), "m" (*&y));
+	if (boot_cpu_data.fdiv_bug)
+		printk("Hmm, FPU with FDIV bug.\n");
+}
+
+static void __init check_hlt(void)
+{
+	if (paravirt_enabled())
+		return;
+
+	printk(KERN_INFO "Checking 'hlt' instruction... ");
+	if (!boot_cpu_data.hlt_works_ok) {
+		printk("disabled\n");
+		return;
+	}
+	halt();
+	halt();
+	halt();
+	halt();
+	printk("OK.\n");
+}
+
+/*
+ *	Most 386 processors have a bug where a POPAD can lock the
+ *	machine even from user space.
+ */
+
+static void __init check_popad(void)
+{
+#ifndef CONFIG_X86_POPAD_OK
+	int res, inp =3D (int) &res;
+
+	printk(KERN_INFO "Checking for popad bug... ");
+	__asm__ __volatile__(
+	  "movl $12345678,%%eax; movl $0,%%edi; pusha; popa; movl (%%edx,%%edi),%=
%ecx "
+	  : "=3D&a" (res)
+	  : "d" (inp)
+	  : "ecx", "edi" );
+	/* If this fails, it means that any user program may lock the CPU hard. T=
oo bad. */
+	if (res !=3D 12345678) printk( "Buggy.\n" );
+		        else printk( "OK.\n" );
+#endif
+}
+
+/*
+ * Check whether we are able to run this kernel safely on SMP.
+ *
+ * - In order to run on a i386, we need to be compiled for i386
+ *   (for due to lack of "invlpg" and working WP on a i386)
+ * - In order to run on anything without a TSC, we need to be
+ *   compiled for a i486.
+ * - In order to support the local APIC on a buggy Pentium machine,
+ *   we need to be compiled with CONFIG_X86_GOOD_APIC disabled,
+ *   which happens implicitly if compiled for a Pentium or lower
+ *   (unless an advanced selection of CPU features is used) as an
+ *   otherwise config implies a properly working local APIC without
+ *   the need to do extra reads from the APIC.
+*/
+
+static void __init check_config(void)
+{
+/*
+ * We'd better not be a i386 if we're configured to use some
+ * i486+ only features! (WP works in supervisor mode and the
+ * new "invlpg" and "bswap" instructions)
+ */
+#if defined(CONFIG_X86_WP_WORKS_OK) || defined(CONFIG_X86_INVLPG) || defin=
ed(CONFIG_X86_BSWAP)
+	if (boot_cpu_data.x86 =3D=3D 3)
+		panic("Kernel requires i486+ for 'invlpg' and other features");
+#endif
+
+/*
+ * If we configured ourselves for a TSC, we'd better have one!
+ */
+#ifdef CONFIG_X86_TSC
+	if (!cpu_has_tsc && !tsc_disable)
+		panic("Kernel compiled for Pentium+, requires TSC feature!");
+#endif
+
+/*
+ * If we were told we had a good local APIC, check for buggy Pentia,
+ * i.e. all B steppings and the C2 stepping of P54C when using their
+ * integrated APIC (see 11AP erratum in "Pentium Processor
+ * Specification Update").
+ */
+#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_GOOD_APIC)
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL
+	    && cpu_has_apic
+	    && boot_cpu_data.x86 =3D=3D 5
+	    && boot_cpu_data.x86_model =3D=3D 2
+	    && (boot_cpu_data.x86_mask < 6 || boot_cpu_data.x86_mask =3D=3D 11))
+		panic("Kernel compiled for PMMX+, assumes a local APIC without the read-=
before-write bug!");
+#endif
+}
+
+
+void __init check_bugs(void)
+{
+	identify_boot_cpu();
+#ifndef CONFIG_SMP
+	printk("CPU: ");
+	print_cpu_info(&boot_cpu_data);
+#endif
+	check_config();
+	check_fpu();
+	check_hlt();
+	check_popad();
+	init_utsname()->machine[1] =3D '0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cp=
u_data.x86);
+	alternative_instructions();
+}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/alternative.h
+++ b/include/asm-i386/alternative.h
@@ -14,6 +14,7 @@ struct alt_instr {
 	u8  pad;
 };
 =

+extern void alternative_instructions(void);
 extern void apply_alternatives(struct alt_instr *start, struct alt_instr *=
end);
 =

 struct module;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/bugs.h
+++ b/include/asm-i386/bugs.h
@@ -1,198 +1,12 @@
-/*
- *  include/asm-i386/bugs.h
- *
- *  Copyright (C) 1994  Linus Torvalds
- *
- *  Cyrix stuff, June 1998 by:
- *	- Rafael R. Reilova (moved everything from head.S),
- *        <rreilova@ececs.uc.edu>
- *	- Channing Corn (tests & fixes),
- *	- Andrew D. Balsa (code cleanup).
- */
-
 /*
  * This is included by init/main.c to check for architecture-dependent bug=
s.
  *
  * Needs:
  *	void check_bugs(void);
  */
+#ifndef _ASM_I386_BUG_H
+#define _ASM_I386_BUG_H
 =

-#include <linux/init.h>
-#include <asm/processor.h>
-#include <asm/i387.h>
-#include <asm/msr.h>
-#include <asm/paravirt.h>
+extern void __init check_bugs(void);
 =

-static int __init no_halt(char *s)
-{
-	boot_cpu_data.hlt_works_ok =3D 0;
-	return 1;
-}
-
-__setup("no-hlt", no_halt);
-
-static int __init mca_pentium(char *s)
-{
-	mca_pentium_flag =3D 1;
-	return 1;
-}
-
-__setup("mca-pentium", mca_pentium);
-
-static int __init no_387(char *s)
-{
-	boot_cpu_data.hard_math =3D 0;
-	write_cr0(0xE | read_cr0());
-	return 1;
-}
-
-__setup("no387", no_387);
-
-static double __initdata x =3D 4195835.0;
-static double __initdata y =3D 3145727.0;
-
-/*
- * This used to check for exceptions.. =

- * However, it turns out that to support that,
- * the XMM trap handlers basically had to
- * be buggy. So let's have a correct XMM trap
- * handler, and forget about printing out
- * some status at boot.
- *
- * We should really only care about bugs here
- * anyway. Not features.
- */
-static void __init check_fpu(void)
-{
-	if (!boot_cpu_data.hard_math) {
-#ifndef CONFIG_MATH_EMULATION
-		printk(KERN_EMERG "No coprocessor found and no math emulation present.\n=
");
-		printk(KERN_EMERG "Giving up.\n");
-		for (;;) ;
-#endif
-		return;
-	}
-
-/* trap_init() enabled FXSR and company _before_ testing for FP problems h=
ere. */
-	/* Test for the divl bug.. */
-	__asm__("fninit\n\t"
-		"fldl %1\n\t"
-		"fdivl %2\n\t"
-		"fmull %2\n\t"
-		"fldl %1\n\t"
-		"fsubp %%st,%%st(1)\n\t"
-		"fistpl %0\n\t"
-		"fwait\n\t"
-		"fninit"
-		: "=3Dm" (*&boot_cpu_data.fdiv_bug)
-		: "m" (*&x), "m" (*&y));
-	if (boot_cpu_data.fdiv_bug)
-		printk("Hmm, FPU with FDIV bug.\n");
-}
-
-static void __init check_hlt(void)
-{
-	if (paravirt_enabled())
-		return;
-
-	printk(KERN_INFO "Checking 'hlt' instruction... ");
-	if (!boot_cpu_data.hlt_works_ok) {
-		printk("disabled\n");
-		return;
-	}
-	halt();
-	halt();
-	halt();
-	halt();
-	printk("OK.\n");
-}
-
-/*
- *	Most 386 processors have a bug where a POPAD can lock the =

- *	machine even from user space.
- */
- =

-static void __init check_popad(void)
-{
-#ifndef CONFIG_X86_POPAD_OK
-	int res, inp =3D (int) &res;
-
-	printk(KERN_INFO "Checking for popad bug... ");
-	__asm__ __volatile__( =

-	  "movl $12345678,%%eax; movl $0,%%edi; pusha; popa; movl (%%edx,%%edi),%=
%ecx "
-	  : "=3D&a" (res)
-	  : "d" (inp)
-	  : "ecx", "edi" );
-	/* If this fails, it means that any user program may lock the CPU hard. T=
oo bad. */
-	if (res !=3D 12345678) printk( "Buggy.\n" );
-		        else printk( "OK.\n" );
-#endif
-}
-
-/*
- * Check whether we are able to run this kernel safely on SMP.
- *
- * - In order to run on a i386, we need to be compiled for i386
- *   (for due to lack of "invlpg" and working WP on a i386)
- * - In order to run on anything without a TSC, we need to be
- *   compiled for a i486.
- * - In order to support the local APIC on a buggy Pentium machine,
- *   we need to be compiled with CONFIG_X86_GOOD_APIC disabled,
- *   which happens implicitly if compiled for a Pentium or lower
- *   (unless an advanced selection of CPU features is used) as an
- *   otherwise config implies a properly working local APIC without
- *   the need to do extra reads from the APIC.
-*/
-
-static void __init check_config(void)
-{
-/*
- * We'd better not be a i386 if we're configured to use some
- * i486+ only features! (WP works in supervisor mode and the
- * new "invlpg" and "bswap" instructions)
- */
-#if defined(CONFIG_X86_WP_WORKS_OK) || defined(CONFIG_X86_INVLPG) || defin=
ed(CONFIG_X86_BSWAP)
-	if (boot_cpu_data.x86 =3D=3D 3)
-		panic("Kernel requires i486+ for 'invlpg' and other features");
-#endif
-
-/*
- * If we configured ourselves for a TSC, we'd better have one!
- */
-#ifdef CONFIG_X86_TSC
-	if (!cpu_has_tsc && !tsc_disable)
-		panic("Kernel compiled for Pentium+, requires TSC feature!");
-#endif
-
-/*
- * If we were told we had a good local APIC, check for buggy Pentia,
- * i.e. all B steppings and the C2 stepping of P54C when using their
- * integrated APIC (see 11AP erratum in "Pentium Processor
- * Specification Update").
- */
-#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_GOOD_APIC)
-	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL
-	    && cpu_has_apic
-	    && boot_cpu_data.x86 =3D=3D 5
-	    && boot_cpu_data.x86_model =3D=3D 2
-	    && (boot_cpu_data.x86_mask < 6 || boot_cpu_data.x86_mask =3D=3D 11))
-		panic("Kernel compiled for PMMX+, assumes a local APIC without the read-=
before-write bug!");
-#endif
-}
-
-extern void alternative_instructions(void);
-
-static void __init check_bugs(void)
-{
-	identify_cpu(&boot_cpu_data);
-#ifndef CONFIG_SMP
-	printk("CPU: ");
-	print_cpu_info(&boot_cpu_data);
-#endif
-	check_config();
-	check_fpu();
-	check_hlt();
-	check_popad();
-	init_utsname()->machine[1] =3D '0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cp=
u_data.x86);
-	alternative_instructions(); =

-}
+#endif	/* _ASM_I386_BUG_H */

-- =
