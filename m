From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 03/17] use paravirt_nop to consistently mark no-op operations
Date: Sun, 01 Apr 2007 22:56:55 -0700
Message-ID: <20070402055704.150850580@goop.org>
References: <20070402055652.610711908@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=paravirt-nop.patch
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
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Add a _paravirt_nop function for use as a stub for no-op operations,
and paravirt_nop #defined void * version to make using it easier
(since all its uses are as a void *).

This is useful to allow the patcher to automatically identify noop
operations so it can simply nop out the callsite.


Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
[mingo] but only as a cleanup of the current open-coded (void *) casts.
My problem with this is that it loses the types. Not that there is much
to check for, but still, this adds some assumptions about how function
calls look like

---
 arch/i386/kernel/paravirt.c |   26 +++++++++++++-------------
 include/asm-i386/paravirt.h |    3 +++
 2 files changed, 16 insertions(+), 13 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -35,7 +35,7 @@
 #include <asm/timer.h>
 =

 /* nop stub */
-static void native_nop(void)
+void _paravirt_nop(void)
 {
 }
 =

@@ -490,7 +490,7 @@ struct paravirt_ops paravirt_ops =3D {
 =

  	.patch =3D native_patch,
 	.banner =3D default_banner,
-	.arch_setup =3D native_nop,
+	.arch_setup =3D paravirt_nop,
 	.memory_setup =3D machine_specific_memory_setup,
 	.get_wallclock =3D native_get_wallclock,
 	.set_wallclock =3D native_set_wallclock,
@@ -546,25 +546,25 @@ struct paravirt_ops paravirt_ops =3D {
 	.setup_boot_clock =3D setup_boot_APIC_clock,
 	.setup_secondary_clock =3D setup_secondary_APIC_clock,
 #endif
-	.set_lazy_mode =3D (void *)native_nop,
+	.set_lazy_mode =3D paravirt_nop,
 =

 	.flush_tlb_user =3D native_flush_tlb,
 	.flush_tlb_kernel =3D native_flush_tlb_global,
 	.flush_tlb_single =3D native_flush_tlb_single,
 =

-	.map_pt_hook =3D (void *)native_nop,
-
-	.alloc_pt =3D (void *)native_nop,
-	.alloc_pd =3D (void *)native_nop,
-	.alloc_pd_clone =3D (void *)native_nop,
-	.release_pt =3D (void *)native_nop,
-	.release_pd =3D (void *)native_nop,
+	.map_pt_hook =3D paravirt_nop,
+
+	.alloc_pt =3D paravirt_nop,
+	.alloc_pd =3D paravirt_nop,
+	.alloc_pd_clone =3D paravirt_nop,
+	.release_pt =3D paravirt_nop,
+	.release_pd =3D paravirt_nop,
 =

 	.set_pte =3D native_set_pte,
 	.set_pte_at =3D native_set_pte_at,
 	.set_pmd =3D native_set_pmd,
-	.pte_update =3D (void *)native_nop,
-	.pte_update_defer =3D (void *)native_nop,
+	.pte_update =3D paravirt_nop,
+	.pte_update_defer =3D paravirt_nop,
 #ifdef CONFIG_X86_PAE
 	.set_pte_atomic =3D native_set_pte_atomic,
 	.set_pte_present =3D native_set_pte_present,
@@ -576,7 +576,7 @@ struct paravirt_ops paravirt_ops =3D {
 	.irq_enable_sysexit =3D native_irq_enable_sysexit,
 	.iret =3D native_iret,
 =

-	.startup_ipi_hook =3D (void *)native_nop,
+	.startup_ipi_hook =3D paravirt_nop,
 };
 =

 /*
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -430,6 +430,9 @@ static inline void pmd_clear(pmd_t *pmdp
 #define arch_enter_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZ=
Y_MMU)
 #define arch_leave_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZ=
Y_NONE)
 =

+void _paravirt_nop(void);
+#define paravirt_nop	((void *)_paravirt_nop)
+
 /* These all sit in the .parainstructions section to tell us what to patch=
. */
 struct paravirt_patch {
 	u8 *instr; 		/* original instructions */

-- =
