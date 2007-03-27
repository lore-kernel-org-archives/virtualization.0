From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 4/5] i386-gdt-pda cleanups to help using per-cpu
	variables from asm
Date: Mon, 26 Mar 2007 17:21:33 -0700
Message-ID: <20070327002841.784320552@goop.org>
References: <20070327002129.240126099@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline;
	filename=i386-cleanups-to-help-using-per-cpu-variables-from-asm.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, xen-devel@lists.xensource.com, Linux Kernel <linux-kernel@vger.kernel.org>
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
