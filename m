From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 2/6] Remove noreplacement option
Date: Tue, 03 Apr 2007 18:06:57 -0700
Message-ID: <20070404011453.344346341@goop.org>
References: <20070404010655.400913479@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=remove-noreplacement.patch
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

noreplacement is dangerous on modern systems because it will not replace the
context switch FNSAVE with SSE aware FXSAVE. But other places in the kernel=
 still assume
SSE and do FXSAVE and the CPU will then access FXSAVE information with
FNSAVE and cause corruption.

Easiest way to avoid this is to remove the option. It was mostly for parano=
ia
reasons anyways and alternative()s have been stable for some time.

Thanks to Jeremy F. for reporting and helping debug it.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 Documentation/x86_64/boot-options.txt |    4 ----
 arch/i386/kernel/alternative.c        |   21 ++-------------------
 2 files changed, 2 insertions(+), 23 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/Documentation/x86_64/boot-options.txt
+++ b/Documentation/x86_64/boot-options.txt
@@ -305,7 +305,3 @@ Debugging
 			stuck (default)
 =

 Miscellaneous
-
-  noreplacement  Don't replace instructions with more appropriate ones
-		 for the CPU. This may be useful on asymmetric MP systems
-		 where some CPUs have less capabilities than others.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -5,15 +5,9 @@
 #include <asm/alternative.h>
 #include <asm/sections.h>
 =

-static int no_replacement    =3D 0;
 static int smp_alt_once      =3D 0;
 static int debug_alternative =3D 0;
 =

-static int __init noreplacement_setup(char *s)
-{
-	no_replacement =3D 1;
-	return 1;
-}
 static int __init bootonly(char *str)
 {
 	smp_alt_once =3D 1;
@@ -25,7 +19,6 @@ static int __init debug_alt(char *str)
 	return 1;
 }
 =

-__setup("noreplacement", noreplacement_setup);
 __setup("smp-alt-boot", bootonly);
 __setup("debug-alternative", debug_alt);
 =

@@ -252,9 +245,6 @@ void alternatives_smp_module_add(struct =

 	struct smp_alt_module *smp;
 	unsigned long flags;
 =

-	if (no_replacement)
-		return;
-
 	if (smp_alt_once) {
 		if (boot_cpu_has(X86_FEATURE_UP))
 			alternatives_smp_unlock(locks, locks_end,
@@ -289,7 +279,7 @@ void alternatives_smp_module_del(struct =

 	struct smp_alt_module *item;
 	unsigned long flags;
 =

-	if (no_replacement || smp_alt_once)
+	if (smp_alt_once)
 		return;
 =

 	spin_lock_irqsave(&smp_alt, flags);
@@ -320,7 +310,7 @@ void alternatives_smp_switch(int smp)
 	return;
 #endif
 =

-	if (no_replacement || smp_alt_once)
+	if (smp_alt_once)
 		return;
 	BUG_ON(!smp && (num_online_cpus() > 1));
 =

@@ -374,13 +364,6 @@ void __init alternative_instructions(voi
 void __init alternative_instructions(void)
 {
 	unsigned long flags;
-	if (no_replacement) {
-		printk(KERN_INFO "(SMP-)alternatives turned off\n");
-		free_init_pages("SMP alternatives",
-				__pa_symbol(&__smp_alt_begin),
-				__pa_symbol(&__smp_alt_end));
-		return;
-	}
 =

 	local_irq_save(flags);
 	apply_alternatives(__alt_instructions, __alt_instructions_end);

-- =
