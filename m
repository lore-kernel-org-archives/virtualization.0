From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 1/6] i386: Account for module percpu space separately from
	kernel percpu
Date: Fri, 30 Mar 2007 19:00:43 -0700
Message-ID: <20070331020054.671640854@goop.org>
References: <20070331020042.003398870@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=separate-module-percpu-space.patch
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
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Rather than using a single constant PERCPU_ENOUGH_ROOM, compute it as
the sum of kernel_percpu + PERCPU_MODULE_RESERVE.  This is now common
to all architectures; if an architecture wants to set
PERCPU_ENOUGH_ROOM to something special, then it may do so (ia64 is
the only one which does).

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>

---
 include/asm-alpha/percpu.h   |   14 --------------
 include/asm-sparc64/percpu.h |   10 ----------
 include/asm-x86_64/percpu.h  |   10 ----------
 include/linux/percpu.h       |    9 ++++++++-
 init/main.c                  |    7 ++-----
 kernel/module.c              |    2 +-
 6 files changed, 11 insertions(+), 41 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-alpha/percpu.h
+++ b/include/asm-alpha/percpu.h
@@ -1,19 +1,5 @@
 #ifndef __ALPHA_PERCPU_H
 #define __ALPHA_PERCPU_H
-
-/*
- * Increase the per cpu area for Alpha so that
- * modules using percpu area can load.
- */
-#ifdef CONFIG_MODULES
-# define PERCPU_MODULE_RESERVE 8192
-#else
-# define PERCPU_MODULE_RESERVE 0
-#endif
-
-#define PERCPU_ENOUGH_ROOM \
-	(ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES) + \
-	 PERCPU_MODULE_RESERVE)
 =

 #include <asm-generic/percpu.h>
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-sparc64/percpu.h
+++ b/include/asm-sparc64/percpu.h
@@ -4,16 +4,6 @@
 #include <linux/compiler.h>
 =

 #ifdef CONFIG_SMP
-
-#ifdef CONFIG_MODULES
-# define PERCPU_MODULE_RESERVE 8192
-#else
-# define PERCPU_MODULE_RESERVE 0
-#endif
-
-#define PERCPU_ENOUGH_ROOM \
-	(ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES) + \
-	 PERCPU_MODULE_RESERVE)
 =

 extern void setup_per_cpu_areas(void);
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-x86_64/percpu.h
+++ b/include/asm-x86_64/percpu.h
@@ -10,16 +10,6 @@
 #ifdef CONFIG_SMP
 =

 #include <asm/pda.h>
-
-#ifdef CONFIG_MODULES
-# define PERCPU_MODULE_RESERVE 8192
-#else
-# define PERCPU_MODULE_RESERVE 0
-#endif
-
-#define PERCPU_ENOUGH_ROOM \
-	(ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES) + \
-	 PERCPU_MODULE_RESERVE)
 =

 #define __per_cpu_offset(cpu) (cpu_pda(cpu)->data_offset)
 #define __my_cpu_offset() read_pda(data_offset)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -11,8 +11,15 @@
 =

 /* Enough to cover all DEFINE_PER_CPUs in kernel, including modules. */
 #ifndef PERCPU_ENOUGH_ROOM
-#define PERCPU_ENOUGH_ROOM 32768
+#ifdef CONFIG_MODULES
+#define PERCPU_MODULE_RESERVE	8192
+#else
+#define PERCPU_MODULE_RESERVE	0
 #endif
+
+#define PERCPU_ENOUGH_ROOM						\
+	(__per_cpu_end - __per_cpu_start + PERCPU_MODULE_RESERVE)
+#endif	/* PERCPU_ENOUGH_ROOM */
 =

 /*
  * Must be an lvalue. Since @var must be a simple identifier,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/init/main.c
+++ b/init/main.c
@@ -369,11 +369,8 @@ static void __init setup_per_cpu_areas(v
 	unsigned long nr_possible_cpus =3D num_possible_cpus();
 =

 	/* Copy section for each CPU (we discard the original) */
-	size =3D ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
-#ifdef CONFIG_MODULES
-	if (size < PERCPU_ENOUGH_ROOM)
-		size =3D PERCPU_ENOUGH_ROOM;
-#endif
+
+	size =3D ALIGN(PERCPU_ENOUGH_ROOM, SMP_CACHE_BYTES);
 	ptr =3D alloc_bootmem(size * nr_possible_cpus);
 =

 	for_each_possible_cpu(i) {
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -430,7 +430,7 @@ static int percpu_modinit(void)
 	pcpu_size =3D kmalloc(sizeof(pcpu_size[0]) * pcpu_num_allocated,
 			    GFP_KERNEL);
 	/* Static in-kernel percpu data (used). */
-	pcpu_size[0] =3D -ALIGN(__per_cpu_end-__per_cpu_start, SMP_CACHE_BYTES);
+	pcpu_size[0] =3D -(__per_cpu_end-__per_cpu_start);
 	/* Free room. */
 	pcpu_size[1] =3D PERCPU_ENOUGH_ROOM + pcpu_size[0];
 	if (pcpu_size[1] < 0) {

-- =
