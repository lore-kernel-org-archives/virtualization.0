From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 25/28] From: Jeremy Fitzhardinge <jeremy@goop.org>
Date: Sat, 14 Apr 2007 13:42:19 -0700
Message-ID: <20070414204925.262100710@goop.org>
References: <20070414204154.871250608@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=rename-the-parainstructions-symbols-to-be-consistent-with-the-others.patch
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

The other symbols used to delineate the alt-instructions sections have the
form __foo/__foo_end.  Rename parainstructions to match.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Andi Kleen <ak@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/i386/kernel/alternative.c |    2 +-
 arch/i386/kernel/vmi.c         |    6 +++---
 arch/i386/kernel/vmlinux.lds.S |    4 ++--
 include/asm-i386/alternative.h |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -386,6 +386,6 @@ void __init alternative_instructions(voi
 		alternatives_smp_switch(0);
 	}
 #endif
- 	apply_paravirt(__start_parainstructions, __stop_parainstructions);
+ 	apply_paravirt(__parainstructions, __parainstructions_end);
 	local_irq_restore(flags);
 }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/vmi.c
+++ b/arch/i386/kernel/vmi.c
@@ -74,8 +74,8 @@ static struct {
 } vmi_ops;
 =

 /* XXX move this to alternative.h */
-extern struct paravirt_patch __start_parainstructions[],
-	__stop_parainstructions[];
+extern struct paravirt_patch __parainstructions[],
+	__parainstructions_end[];
 =

 /* Cached VMI operations */
 struct vmi_timer_ops vmi_timer_ops;
@@ -909,7 +909,7 @@ static inline int __init activate_vmi(vo
 	 * to do this before IRQs get reenabled.  Fortunately, it is
 	 * idempotent.
 	 */
-	apply_paravirt(__start_parainstructions, __stop_parainstructions);
+	apply_paravirt(__parainstructions, __parainstructions_end);
 =

 	vmi_bringup();
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -166,9 +166,9 @@ SECTIONS
   }
   . =3D ALIGN(4);
   .parainstructions : AT(ADDR(.parainstructions) - LOAD_OFFSET) {
-  	__start_parainstructions =3D .;
+  	__parainstructions =3D .;
 	*(.parainstructions)
-  	__stop_parainstructions =3D .;
+  	__parainstructions_end =3D .;
   }
   /* .exit.text is discard at runtime, not link time, to deal with referen=
ces
      from .altinstructions and .eh_frame */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/alternative.h
+++ b/include/asm-i386/alternative.h
@@ -124,8 +124,8 @@ apply_paravirt(struct paravirt_patch_sit
 apply_paravirt(struct paravirt_patch_site *start,
 	       struct paravirt_patch_site *end)
 {}
-#define __start_parainstructions NULL
-#define __stop_parainstructions NULL
+#define __parainstructions	NULL
+#define __parainstructions_end	NULL
 #endif
 =

 #endif /* _I386_ALTERNATIVE_H */

-- =
