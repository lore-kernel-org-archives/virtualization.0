From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 1/2] Clean up asm-x86_64/bugs.h
Date: Sat, 07 Apr 2007 10:22:01 -0700
Message-ID: <4617D339.3080801@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@osdl.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Most of asm-x86_64/bugs.h is code which should be in a C file, so put it th=
ere.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>

---
 arch/x86_64/kernel/Makefile      |    3 ++-
 arch/x86_64/kernel/bugs.c        |   28 ++++++++++++++++++++++++++++
 include/asm-x86_64/alternative.h |    1 +
 include/asm-x86_64/bugs.h        |   30 ++++--------------------------
 4 files changed, 35 insertions(+), 27 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/x86_64/kernel/Makefile
+++ b/arch/x86_64/kernel/Makefile
@@ -8,7 +8,8 @@ obj-y	:=3D process.o signal.o entry.o trap
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
 		setup64.o bootflag.o e820.o reboot.o quirks.o i8237.o \
-		pci-dma.o pci-nommu.o alternative.o hpet.o tsc.o sched-clock.o
+		pci-dma.o pci-nommu.o alternative.o hpet.o tsc.o sched-clock.o \
+		bugs.o
 =

 obj-$(CONFIG_STACKTRACE)	+=3D stacktrace.o
 obj-$(CONFIG_X86_MCE)		+=3D mce.o therm_throt.o
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/arch/x86_64/kernel/bugs.c
@@ -0,0 +1,28 @@
+/*
+ *  arch/x86_64/kernel/bugs.c
+ *
+ *  Copyright (C) 1994  Linus Torvalds
+ *  Copyright (C) 2000  SuSE
+ *
+ * This is included by init/main.c to check for architecture-dependent bug=
s.
+ *
+ * Needs:
+ *	void check_bugs(void);
+ */
+
+#include <linux/kernel.h>
+#include <asm/alternative.h>
+#include <asm/processor.h>
+#include <asm/i387.h>
+#include <asm/msr.h>
+#include <asm/pda.h>
+
+void __init check_bugs(void)
+{
+	identify_cpu(&boot_cpu_data);
+#if !defined(CONFIG_SMP)
+	printk("CPU: ");
+	print_cpu_info(&boot_cpu_data);
+#endif
+	alternative_instructions();
+}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-x86_64/alternative.h
+++ b/include/asm-x86_64/alternative.h
@@ -16,6 +16,7 @@ struct alt_instr {
 	u8  pad[5];
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
--- a/include/asm-x86_64/bugs.h
+++ b/include/asm-x86_64/bugs.h
@@ -1,28 +1,6 @@
-/*
- *  include/asm-x86_64/bugs.h
- *
- *  Copyright (C) 1994  Linus Torvalds
- *  Copyright (C) 2000  SuSE
- *
- * This is included by init/main.c to check for architecture-dependent bug=
s.
- *
- * Needs:
- *	void check_bugs(void);
- */
+#ifndef _ASM_X86_64_BUGS_H
+#define _ASM_X86_64_BUGS_H
 =

-#include <asm/processor.h>
-#include <asm/i387.h>
-#include <asm/msr.h>
-#include <asm/pda.h>
+void check_bugs(void);
 =

-extern void alternative_instructions(void);
-
-static void __init check_bugs(void)
-{
-	identify_cpu(&boot_cpu_data);
-#if !defined(CONFIG_SMP)
-	printk("CPU: ");
-	print_cpu_info(&boot_cpu_data);
-#endif
-	alternative_instructions(); =

-}
+#endif	/* _ASM_X86_64_BUGS_H */
