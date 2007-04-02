From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 09/17] rename struct paravirt_patch to paravirt_patch_site for
	clarity
Date: Sun, 01 Apr 2007 22:57:01 -0700
Message-ID: <20070402055704.747816843@goop.org>
References: <20070402055652.610711908@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=paravirt-patch-rename-paravirt_patch.patch
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

Rename struct paravirt_patch to paravirt_patch_site, so that it
clearly refers to a callsite, and not the patch which may be applied
to that callsite.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zachary Amsden <zach@vmware.com>

---
 arch/i386/kernel/alternative.c |    9 ++++-----
 arch/i386/kernel/vmi.c         |    4 ----
 include/asm-i386/alternative.h |   12 +++++++-----
 include/asm-i386/paravirt.h    |    5 ++++-
 4 files changed, 15 insertions(+), 15 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -359,9 +359,10 @@ void alternatives_smp_switch(int smp)
 #endif
 =

 #ifdef CONFIG_PARAVIRT
-void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *e=
nd)
-{
-	struct paravirt_patch *p;
+void apply_paravirt(struct paravirt_patch_site *start,
+		    struct paravirt_patch_site *end)
+{
+	struct paravirt_patch_site *p;
 =

 	for (p =3D start; p < end; p++) {
 		unsigned int used;
@@ -388,8 +389,6 @@ void apply_paravirt(struct paravirt_patc
 	/* Sync to be conservative, in case we patched following instructions */
 	sync_core();
 }
-extern struct paravirt_patch __start_parainstructions[],
-	__stop_parainstructions[];
 #endif	/* CONFIG_PARAVIRT */
 =

 void __init alternative_instructions(void)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/vmi.c
+++ b/arch/i386/kernel/vmi.c
@@ -70,10 +70,6 @@ static struct {
 	void (*set_initial_ap_state)(int, int);
 	void (*halt)(void);
 } vmi_ops;
-
-/* XXX move this to alternative.h */
-extern struct paravirt_patch __start_parainstructions[],
-	__stop_parainstructions[];
 =

 /*
  * VMI patching routines.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/alternative.h
+++ b/include/asm-i386/alternative.h
@@ -154,13 +154,15 @@ static inline void alternatives_smp_swit
 #define LOCK_PREFIX ""
 #endif
 =

-struct paravirt_patch;
+struct paravirt_patch_site;
 #ifdef CONFIG_PARAVIRT
-void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *e=
nd);
+void apply_paravirt(struct paravirt_patch_site *start,
+		    struct paravirt_patch_site *end);
 #else
-static inline void
-apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
-{}
+static inline void apply_paravirt(struct paravirt_patch_site *start,
+				  struct paravirt_patch_site *end)
+{
+}
 #define __start_parainstructions NULL
 #define __stop_parainstructions NULL
 #endif
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -502,12 +502,15 @@ void _paravirt_nop(void);
 #define paravirt_nop	((void *)_paravirt_nop)
 =

 /* These all sit in the .parainstructions section to tell us what to patch=
. */
-struct paravirt_patch {
+struct paravirt_patch_site {
 	u8 *instr; 		/* original instructions */
 	u8 instrtype;		/* type of this instruction */
 	u8 len;			/* length of original instruction */
 	u16 clobbers;		/* what registers you may clobber */
 };
+
+extern struct paravirt_patch_site __start_parainstructions[],
+	__stop_parainstructions[];
 =

 #define paravirt_alt(insn_string, typenum, clobber)	\
 	"771:\n\t" insn_string "\n" "772:\n"		\

-- =
