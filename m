From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Thu, 16 Nov 2006 00:26:21 -0800
Message-ID: <20061116082621.GZ1397@sequoia.sous-sol.org>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com>
	<20061116032702.GH9579@bingen.suse.de>
	<20061115210630.94bf8824.akpm@osdl.org>
	<200611160802.05131.ak@suse.de>
	<20061116071615.GX1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061116071615.GX1397@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

* Chris Wright (chrisw@sous-sol.org) wrote:
> Up to 'config-core2' both ff and mm are the same with these minor caveats
> below[1].  This includes the core paravirt patches.  I'm now digging
> into the last few tidy-up type of patches.

All the same on both sides, AFAICT.  There's a few more patches in
Andi's queue that aren't in Andrew's yet (totally unrelated to pv),
and there's 100's of patches in Andrew's tree that aren't related to pv
or x86 at all.  So, it's possible I've missed something since I stopped
careful inspection at the end of the pv bits.  The extra tidy-up patches
after core pv patches are:

in ff-speak
-----------
alloc_gdt-static
mmu-header-movement
cpu_detect-extraction
fix-bad-mmu-names
fix-missing-pte-update
fix-x86_64-mm-patch-inline-replacements-for

in mm-speak
-----------
pda-percpu-init-make-arch-i386-kernel-cpu-commoncalloc_gdt-static.patch
paravirt-mmu-header-movement.patch
paravirt-cpu-detect.patch
paravirt-pte-update-prep.patch
paravirt-pte-update-common.patch
fix-x86_64-mm-patch-inline-replacements-for.patch (hotfix)

Which still create identical trees.

The only patches lost bits that I've found:

1) pv queue has the two patches below which don't appear in either ff or mm:
   - 014-skip-timer-works.patch (patch is from this thread)
   - fix-modpost-warning.patch

2) ff has 'unused' in patches/ but not in series.  it is already folded in =
so
it's just a bit of noise.

thanks,
-chris
--

----- start 014-skip-timer-works.patch -----
From: Zachary Amsden <zach@vmware.com>

Add a way to disable the timer IRQ routing check via a boot option.  The
VMI timer code uses this to avoid triggering the pester Mingo code, which
probes for some very unusual and broken motherboard routings.  It fires
100% of the time when using a paravirtual delay mechanism instead of
using a realtime delay, since there is no elapsed real time, and the 4 timer
IRQs have not yet been delivered.

In addition, it is entirely possible, though improbable, that this bug
could surface on real hardware which picks a particularly bad time to enter
SMM mode, causing a long latency during one of the timer IRQs.

While here, make check_timer be __init.

Signed-off-by: Zachary Amsden <zach@vmware.com>
[chrisw: use no_timer_check to bring inline with x86_64 as per Andi's reque=
st]
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -610,8 +610,6 @@ and is between 256 and 4096 characters. =

 =

 	hugepages=3D	[HW,IA-32,IA-64] Maximal number of HugeTLB pages.
 =

-	noirqbalance	[IA-32,SMP,KNL] Disable kernel irq balancing
-
 	i8042.direct	[HW] Put keyboard port into non-translated mode
 	i8042.dumbkbd	[HW] Pretend that controller can only read data from
 			     keyboard and cannot control its state
@@ -1081,8 +1079,13 @@ and is between 256 and 4096 characters. =

 			in certain environments such as networked servers or
 			real-time systems.
 =

+	noirqbalance	[IA-32,SMP,KNL] Disable kernel irq balancing
+
 	noirqdebug	[IA-32] Disables the code which attempts to detect and
 			disable unhandled interrupt sources.
+
+	no_timer_check	[IA-32,X86_64,APIC] Disables the code which tests for
+			broken timer IRQ sources.
 =

 	noisapnp	[ISAPNP] Disables ISA PnP code.
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -1931,6 +1931,15 @@ static void __init setup_ioapic_ids_from
 static void __init setup_ioapic_ids_from_mpc(void) { }
 #endif
 =

+static int no_timer_check __initdata;
+
+static int __init notimercheck(char *s)
+{
+	no_timer_check =3D 1;
+	return 1;
+}
+__setup("no_timer_check", notimercheck);
+
 /*
  * There is a nasty bug in some older SMP boards, their mptable lies
  * about the timer IRQ. We do the following to work around the situation:
@@ -1939,9 +1948,12 @@ static void __init setup_ioapic_ids_from
  *	- if this function detects that timer IRQs are defunct, then we fall
  *	  back to ISA timer IRQs
  */
-static int __init timer_irq_works(void)
+int __init timer_irq_works(void)
 {
 	unsigned long t1 =3D jiffies;
+
+	if (no_timer_check)
+		return 1;
 =

 	local_irq_enable();
 	/* Let ten ticks pass... */
@@ -2219,7 +2231,7 @@ int timer_uses_ioapic_pin_0;
  * is so screwy.  Thanks to Brian Perkins for testing/hacking this beast
  * fanatically on his truly buggy board.
  */
-static inline void check_timer(void)
+static inline void __init check_timer(void)
 {
 	int apic1, pin1, apic2, pin2;
 	int vector;

----- end 014-skip-timer-works.patch -----

----- start fix-modpost-warning.patch -----
From: Rusty Russell <rusty@rustcorp.com.au>

modpost compains about a "section mismatch" because the
.parainstructions section sometimes refers to the .init.text section.
This is fine, put it in whitelist.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -929,6 +929,7 @@ static int init_section_ref_ok(const cha
 	const char *namelist2[] =3D {
 		".init.",
 		".altinstructions",
+		".parainstructions",
 		".eh_frame",
 		".debug",
 		".rodata",

----- end fix-modpost-warning.patch -----
