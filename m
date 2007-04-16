From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Update lguest's patch code for new paravirt patch architecture
Date: Mon, 16 Apr 2007 12:28:56 +1000
Message-ID: <1176690536.14322.227.camel@localhost.localdomain>
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
Cc: virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The new patching code means that we don't actually have to do as much
work in lguest's patcher.

We use paravirt_patch_default() for cases we don't want to patch
inline, which automatically handles the "patch iret to use a direct
jump" case.

There's no measurable effect on lguest's virtbench scores tho.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/lguest.c     |   10 ++--------
 drivers/lguest/lguest_asm.S |    1 -
 2 files changed, 2 insertions(+), 9 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/lguest/lguest.c
+++ b/drivers/lguest/lguest.c
@@ -388,7 +388,6 @@ static const struct lguest_insns
 	[PARAVIRT_PATCH(irq_enable)] =3D { lgstart_sti, lgend_sti },
 	[PARAVIRT_PATCH(restore_fl)] =3D { lgstart_popf, lgend_popf },
 	[PARAVIRT_PATCH(save_fl)] =3D { lgstart_pushf, lgend_pushf },
-	[PARAVIRT_PATCH(iret)] =3D { lgstart_iret, lgend_iret },
 };
 static unsigned lguest_patch(u8 type, u16 clobber, void *insns, unsigned l=
en)
 {
@@ -396,20 +395,15 @@ static unsigned lguest_patch(u8 type, u1
 =

 	/* Don't touch it if we don't have a replacement */
 	if (type >=3D ARRAY_SIZE(lguest_insns) || !lguest_insns[type].start)
-		return len;
+		return paravirt_patch_default(type, clobber, insns, len);
 =

 	insn_len =3D lguest_insns[type].end - lguest_insns[type].start;
 =

 	/* Similarly if we can't fit replacement. */
 	if (len < insn_len)
-		return len;
+		return paravirt_patch_default(type, clobber, insns, len);
 =

 	memcpy(insns, lguest_insns[type].start, insn_len);
-	if (type =3D=3D PARAVIRT_PATCH(iret)) {
-		/* Jumps are relative. */
-		u32 off =3D (u32)lguest_iret - ((u32)insns + insn_len);
-		memcpy(insns+1, &off, sizeof(off));
-	}
 	return insn_len;
 }
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/lguest/lguest_asm.S
+++ b/drivers/lguest/lguest_asm.S
@@ -34,7 +34,6 @@ LGUEST_PATCH(sti, movl $X86_EFLAGS_IF, l
 LGUEST_PATCH(sti, movl $X86_EFLAGS_IF, lguest_data+LGUEST_DATA_irq_enabled)
 LGUEST_PATCH(popf, movl %eax, lguest_data+LGUEST_DATA_irq_enabled)
 LGUEST_PATCH(pushf, movl lguest_data+LGUEST_DATA_irq_enabled, %eax)
-LGUEST_PATCH(iret, .byte 0xE9,0,0,0,0) /* jmp <to-be-patched> */
 =

 .text
 /* These demark the EIP range where host should never deliver interrupts. =
*/
