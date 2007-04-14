From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 07/28] cleanups to help using per-cpu variables from asm
Date: Sat, 14 Apr 2007 13:42:01 -0700
Message-ID: <20070414204923.899605718@goop.org>
References: <20070414204154.871250608@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753908AbXDNVVn@vger.kernel.org>
Content-Disposition: inline; filename=i386-cleanups-to-help-using-per-cpu-variables-from-asm.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

This patch does a few small cleanups:
 - use PER_CPU_NAME to generate the names of per-cpu variables
 - use lea to add the per_cpu offset in PER_CPU(), because it doesn't
   affect condition flags
 - add PER_CPU_VAR which allows direct access to pre-cpu variables
   with the %fs: prefix on SMP.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>

---
 include/asm-i386/percpu.h |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

===================================================================
--- a/include/asm-i386/percpu.h
+++ b/include/asm-i386/percpu.h
@@ -16,12 +16,14 @@
  *    PER_CPU(cpu_gdt_descr, %ebx)
  */
 #ifdef CONFIG_SMP
+#define PER_CPU(var, reg)				\
+	movl %fs:per_cpu__##this_cpu_off, reg;		\
+	lea per_cpu__##var(reg), reg
+#define PER_CPU_VAR(var)	%fs:per_cpu__##var
+#else /* ! SMP */
 #define PER_CPU(var, reg)			\
-	movl %fs:per_cpu__this_cpu_off, reg;		\
-	addl $per_cpu__##var, reg
-#else /* ! SMP */
-#define PER_CPU(var, reg) \
-	movl $per_cpu__##var, reg;
+	movl $per_cpu__##var, reg
+#define PER_CPU_VAR(var)	per_cpu__##var
 #endif	/* SMP */
 
 #else /* ...!ASSEMBLY */

-- 
