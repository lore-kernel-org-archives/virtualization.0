From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 5/6] Allow boot-time disable of SMP altinstructions
Date: Tue, 03 Apr 2007 18:07:00 -0700
Message-ID: <20070404011453.778754570@goop.org>
References: <20070404010655.400913479@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=disable-smp-alternatives.patch
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

Add "noreplace-smp" to disable SMP instruction replacement.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
 =

---
 Documentation/kernel-parameters.txt |    6 ++++++
 arch/i386/kernel/alternative.c      |   23 +++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1134,6 +1134,9 @@ and is between 256 and 4096 characters. =

 	nomca		[IA-64] Disable machine check abort handling
 =

 	nomce		[IA-32] Machine Check Exception
+
+	noreplace-smp	[IA-32,SMP] Don't replace SMP instructions
+			with UP alternatives
 =

 	noresidual	[PPC] Don't use residual data on PReP machines.
 =

@@ -1540,6 +1543,9 @@ and is between 256 and 4096 characters. =

 	smart2=3D		[HW]
 			Format: <io1>[,<io2>[,...,<io8>]]
 =

+	smp-alt-once	[IA-32,SMP] On a hotplug CPU system, only
+			attempt to substitute SMP alternatives once at boot.
+
 	snd-ad1816a=3D	[HW,ALSA]
 =

 	snd-ad1848=3D	[HW,ALSA]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -5,6 +5,7 @@
 #include <asm/alternative.h>
 #include <asm/sections.h>
 =

+static int noreplace_smp     =3D 0;
 static int smp_alt_once      =3D 0;
 static int debug_alternative =3D 0;
 =

@@ -13,14 +14,22 @@ static int __init bootonly(char *str)
 	smp_alt_once =3D 1;
 	return 1;
 }
+__setup("smp-alt-boot", bootonly);
+
 static int __init debug_alt(char *str)
 {
 	debug_alternative =3D 1;
 	return 1;
 }
-
-__setup("smp-alt-boot", bootonly);
 __setup("debug-alternative", debug_alt);
+
+static int __init setup_noreplace_smp(char *str)
+{
+	noreplace_smp =3D 1;
+	return 1;
+}
+__setup("noreplace-smp", setup_noreplace_smp);
+
 =

 #define DPRINTK(fmt, args...) if (debug_alternative) \
 	printk(KERN_DEBUG fmt, args)
@@ -185,6 +194,9 @@ static void alternatives_smp_unlock(u8 *
 {
 	u8 **ptr;
 =

+	if (noreplace_smp)
+		return;
+
 	for (ptr =3D start; ptr < end; ptr++) {
 		if (*ptr < text)
 			continue;
@@ -218,6 +230,9 @@ void alternatives_smp_module_add(struct =

 {
 	struct smp_alt_module *smp;
 	unsigned long flags;
+
+	if (noreplace_smp)
+		return;
 =

 	if (smp_alt_once) {
 		if (boot_cpu_has(X86_FEATURE_UP))
@@ -253,7 +268,7 @@ void alternatives_smp_module_del(struct =

 	struct smp_alt_module *item;
 	unsigned long flags;
 =

-	if (smp_alt_once)
+	if (smp_alt_once || noreplace_smp)
 		return;
 =

 	spin_lock_irqsave(&smp_alt, flags);
@@ -284,7 +299,7 @@ void alternatives_smp_switch(int smp)
 	return;
 #endif
 =

-	if (smp_alt_once)
+	if (noreplace_smp || smp_alt_once)
 		return;
 	BUG_ON(!smp && (num_online_cpus() > 1));
 =


-- =
