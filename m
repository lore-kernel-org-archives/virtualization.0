From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 5/6] cleanups to help using per-cpu variables from asm
Date: Fri, 30 Mar 2007 19:00:47 -0700
Message-ID: <20070331020055.235511601@goop.org>
References: <20070331020042.003398870@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=i386-cleanups-to-help-using-per-cpu-variables-from-asm.patch
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
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
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

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
 =

 #else /* ...!ASSEMBLY */

-- =
