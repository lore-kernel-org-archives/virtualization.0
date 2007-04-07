From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 2/2] x86: clean up identify_cpu
Date: Sat, 07 Apr 2007 10:23:57 -0700
Message-ID: <4617D3AD.8020904@goop.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

identify_cpu() is used to identify both the boot CPU and secondary
CPUs, but it performs some actions which only apply to the boot CPU.
Those functions are therefore really __init functions, but because
they're called by identify_cpu(), they must be marked __cpuinit.

This patch splits identify_cpu() into identify_boot_cpu() and
identify_secondary_cpu(), and calls the appropriate init functions
from each.  Also, identify_boot_cpu() and all the functions it
dominates are marked __init.

The same change applies to both i386 and x86_64, and both have to be
changed together because they share the mtrr setup code.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/cpu/common.c    |   41 +++++++++++++++++++++------------
 arch/i386/kernel/cpu/mtrr/main.c |    4 +--
 arch/i386/kernel/smpboot.c       |    2 -
 arch/i386/kernel/sysenter.c      |    2 -
 arch/x86_64/kernel/bugs.c        |    2 -
 arch/x86_64/kernel/setup.c       |   47 ++++++++++++++++++++++++++--------=
----
 arch/x86_64/kernel/smpboot.c     |    2 -
 include/asm-i386/processor.h     |    3 +-
 include/asm-x86_64/processor.h   |    3 +-
 9 files changed, 70 insertions(+), 36 deletions(-)

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

@@ -486,30 +486,43 @@ void __cpuinit identify_cpu(struct cpuin
 	for (i =3D 0; i < NCAPINTS; i++)
 		printk(" %08lx", c->x86_capability[i]);
 	printk("\n");
-
+}
+
+void __init identify_boot_cpu(void)
+{
+	identify_cpu(&boot_cpu_data);
+
+	/* Init Machine Check Exception if available. */
+	mcheck_init(&boot_cpu_data);
+
+	sysenter_setup();
+	enable_sep_cpu();
+
+	mtrr_bp_init();
+}
+
+void __cpuinit identify_secondary_cpu(struct cpuinfo_x86 *c)
+{
+	int i;
+
+	BUG_ON(c =3D=3D &boot_cpu_data);
+	identify_cpu(c);
 	/*
 	 * On SMP, boot_cpu_data holds the common feature set between
 	 * all CPUs; so make sure that we indicate which features are
 	 * common between the CPUs.  The first time this routine gets
 	 * executed, c =3D=3D &boot_cpu_data.
-	 */
-	if ( c !=3D &boot_cpu_data ) {
-		/* AND the already accumulated flags with these */
-		for ( i =3D 0 ; i < NCAPINTS ; i++ )
-			boot_cpu_data.x86_capability[i] &=3D c->x86_capability[i];
-	}
+	 * AND the already accumulated flags with these
+	 */
+	for ( i =3D 0 ; i < NCAPINTS ; i++ )
+		boot_cpu_data.x86_capability[i] &=3D c->x86_capability[i];
 =

 	/* Init Machine Check Exception if available. */
 	mcheck_init(c);
 =

-	if (c =3D=3D &boot_cpu_data)
-		sysenter_setup();
 	enable_sep_cpu();
 =

-	if (c =3D=3D &boot_cpu_data)
-		mtrr_bp_init();
-	else
-		mtrr_ap_init();
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
--- a/arch/x86_64/kernel/bugs.c
+++ b/arch/x86_64/kernel/bugs.c
@@ -19,7 +19,7 @@
 =

 void __init check_bugs(void)
 {
-	identify_cpu(&boot_cpu_data);
+	identify_boot_cpu();
 #if !defined(CONFIG_SMP)
 	printk("CPU: ");
 	print_cpu_info(&boot_cpu_data);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -814,7 +814,7 @@ void __cpuinit early_identify_cpu(struct
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
-void __cpuinit identify_cpu(struct cpuinfo_x86 *c)
+static void __cpuinit identify_cpu(struct cpuinfo_x86 *c)
 {
 	int i;
 	u32 xlvl;
@@ -870,31 +870,50 @@ void __cpuinit identify_cpu(struct cpuin
 =

 	select_idle_routine(c);
 	detect_ht(c); =

+}
+
+void __init identify_boot_cpu(void)
+{
+	identify_cpu(&boot_cpu_data);
+
+#ifdef CONFIG_X86_MCE
+	mcheck_init(&boot_cpu_data);
+#endif
+
+	mtrr_bp_init();
+
+#ifdef CONFIG_NUMA
+	numa_add_cpu(smp_processor_id());
+#endif
+}
+
+void __cpuinit identify_secondary_cpu(struct cpuinfo_x86 *c)
+{
+	int i;
+
+	BUG_ON(c =3D=3D &boot_cpu_data);
+
+	identify_cpu(c);
 =

 	/*
 	 * On SMP, boot_cpu_data holds the common feature set between
 	 * all CPUs; so make sure that we indicate which features are
-	 * common between the CPUs.  The first time this routine gets
-	 * executed, c =3D=3D &boot_cpu_data.
-	 */
-	if (c !=3D &boot_cpu_data) {
-		/* AND the already accumulated flags with these */
-		for (i =3D 0 ; i < NCAPINTS ; i++)
-			boot_cpu_data.x86_capability[i] &=3D c->x86_capability[i];
-	}
+	 * common between the CPUs.
+	 * AND the already accumulated flags with these
+	 */
+	for (i =3D 0 ; i < NCAPINTS ; i++)
+		boot_cpu_data.x86_capability[i] &=3D c->x86_capability[i];
 =

 #ifdef CONFIG_X86_MCE
 	mcheck_init(c);
 #endif
-	if (c =3D=3D &boot_cpu_data)
-		mtrr_bp_init();
-	else
-		mtrr_ap_init();
+
+	mtrr_ap_init();
+
 #ifdef CONFIG_NUMA
 	numa_add_cpu(smp_processor_id());
 #endif
 }
- =

 =

 void __cpuinit print_cpu_info(struct cpuinfo_x86 *c)
 {
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/x86_64/kernel/smpboot.c
+++ b/arch/x86_64/kernel/smpboot.c
@@ -143,7 +143,7 @@ static void __cpuinit smp_store_cpu_info
 	struct cpuinfo_x86 *c =3D cpu_data + id;
 =

 	*c =3D boot_cpu_data;
-	identify_cpu(c);
+	identify_secondary_cpu(c);
 	print_cpu_info(c);
 }
 =

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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-x86_64/processor.h
+++ b/include/asm-x86_64/processor.h
@@ -98,7 +98,8 @@ extern struct cpuinfo_x86 cpu_data[];
 =

 extern char ignore_irq13;
 =

-extern void identify_cpu(struct cpuinfo_x86 *);
+extern void identify_boot_cpu(void);
+extern void identify_secondary_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern unsigned short num_cache_leaves;
