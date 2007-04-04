From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 02/20] Remove CONFIG_DEBUG_PARAVIRT
Date: Wed, 04 Apr 2007 12:11:53 -0700
Message-ID: <20070404191204.813957928@goop.org>
References: <20070404191151.009821039@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=remove-CONFIG_DEBUG_PARAVIRT.patch
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

Remove CONFIG_DEBUG_PARAVIRT.  When inlining code, this option
attempts to trash registers in the patch-site's "clobber" field, on
the grounds that this should find bugs with incorrect clobbers.
Unfortunately, the clobber field really means "registers modified by
this patch site", which includes return values.

Because of this, this option has outlived its usefulness, so remove
it.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>

---
 arch/i386/Kconfig.debug        |   10 ----------
 arch/i386/kernel/alternative.c |   14 +-------------
 2 files changed, 1 insertion(+), 23 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/Kconfig.debug
+++ b/arch/i386/Kconfig.debug
@@ -85,14 +85,4 @@ config DOUBLEFAULT
           option saves about 4k and might cause you much additional grey
           hair.
 =

-config DEBUG_PARAVIRT
-	bool "Enable some paravirtualization debugging"
-	default n
-	depends on PARAVIRT && DEBUG_KERNEL
-	help
-	  Currently deliberately clobbers regs which are allowed to be
-	  clobbered in inlined paravirt hooks, even in native mode.
-	  If turning this off solves a problem, then DISABLE_INTERRUPTS() or
-	  ENABLE_INTERRUPTS() is lying about what registers can be clobbered.
-
 endmenu
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -359,19 +359,7 @@ void apply_paravirt(struct paravirt_patc
 =

 		used =3D paravirt_ops.patch(p->instrtype, p->clobbers, p->instr,
 					  p->len);
-#ifdef CONFIG_DEBUG_PARAVIRT
-		{
-		int i;
-		/* Deliberately clobber regs using "not %reg" to find bugs. */
-		for (i =3D 0; i < 3; i++) {
-			if (p->len - used >=3D 2 && (p->clobbers & (1 << i))) {
-				memcpy(p->instr + used, "\xf7\xd0", 2);
-				p->instr[used+1] |=3D i;
-				used +=3D 2;
-			}
-		}
-		}
-#endif
+
 		/* Pad the rest with nops */
 		nop_out(p->instr + used, p->len - used);
 	}

-- =
