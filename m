From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 2/4] clean up identify_cpu
Date: Fri, 06 Apr 2007 15:41:54 -0700
Message-ID: <20070406224204.782242327@goop.org>
References: <20070406224152.556848893@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=cleanup-identify_cpu.patch
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

identify_cpu() is used to identify both the boot CPU and secondary
CPUs, but it performs some actions which only apply to the boot CPU.
Those functions are therefore really __init functions, but because
they're called by identify_cpu(), they must be marked __cpuinit.

This patch splits identify_cpu() into identify_boot_cpu() and
identify_secondary_cpu(), and calls the appropriate init functions
from each.  Also, identify_boot_cpu() and all the functions it
dominates are marked __init.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/cpu/common.c    |   25 ++++++++++++++++---------
 arch/i386/kernel/cpu/mtrr/main.c |    4 ++--
 arch/i386/kernel/smpboot.c       |    2 +-
 arch/i386/kernel/sysenter.c      |    2 +-
 include/asm-i386/processor.h     |    3 ++-
 5 files changed, 22 insertions(+), 14 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -390,7 +390,7 @@ __setup("serialnumber", x86_serial_nr_se
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
-void __cpuinit identify_cpu(struct cpuinfo_x86 *c)
+static void __cpuinit identify_cpu(struct cpuinfo_x86 *c)
 {
 	int i;
 =

@@ -501,15 +501,22 @@ void __cpuinit identify_cpu(struct cpuin
 =

 	/* Init Machine Check Exception if available. */
 	mcheck_init(c);
-
-	if (c =3D=3D &boot_cpu_data)
-		sysenter_setup();
+}
+
+void __init identify_boot_cpu(void)
+{
+	identify_cpu(&boot_cpu_data);
+	sysenter_setup();
 	enable_sep_cpu();
-
-	if (c =3D=3D &boot_cpu_data)
-		mtrr_bp_init();
-	else
-		mtrr_ap_init();
+	mtrr_bp_init();
+}
+
+void __cpuinit identify_secondary_cpu(struct cpuinfo_x86 *c)
+{
+	BUG_ON(c =3D=3D &boot_cpu_data);
+	identify_cpu(c);
+	enable_sep_cpu();
+	mtrr_ap_init();
 }
 =

 #ifdef CONFIG_X86_HT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/cpu/mtrr/main.c
+++ b/arch/i386/kernel/cpu/mtrr/main.c
@@ -571,7 +571,7 @@ extern void cyrix_init_mtrr(void);
 extern void cyrix_init_mtrr(void);
 extern void centaur_init_mtrr(void);
 =

-static void __cpuinit init_ifs(void)
+static void __init init_ifs(void)
 {
 #ifndef CONFIG_X86_64
 	amd_init_mtrr();
@@ -639,7 +639,7 @@ static struct sysdev_driver mtrr_sysdev_
  * initialized (i.e. before smp_init()).
  * =

  */
-void __cpuinit mtrr_bp_init(void)
+void __init mtrr_bp_init(void)
 {
 	init_ifs();
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -157,7 +157,7 @@ static void __cpuinit smp_store_cpu_info
 =

 	*c =3D boot_cpu_data;
 	if (id!=3D0)
-		identify_cpu(c);
+		identify_secondary_cpu(c);
 	/*
 	 * Mask B, Pentium, but not Pentium MMX
 	 */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/sysenter.c
+++ b/arch/i386/kernel/sysenter.c
@@ -68,7 +68,7 @@ extern const char vsyscall_sysenter_star
 extern const char vsyscall_sysenter_start, vsyscall_sysenter_end;
 static struct page *syscall_pages[1];
 =

-int __cpuinit sysenter_setup(void)
+int __init sysenter_setup(void)
 {
 	void *syscall_page =3D (void *)get_zeroed_page(GFP_ATOMIC);
 	syscall_pages[0] =3D virt_to_page(syscall_page);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -116,7 +116,8 @@ extern char ignore_fpu_irq;
 =

 void __init cpu_detect(struct cpuinfo_x86 *c);
 =

-extern void identify_cpu(struct cpuinfo_x86 *);
+extern void identify_boot_cpu(void);
+extern void identify_secondary_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern unsigned short num_cache_leaves;

-- =
