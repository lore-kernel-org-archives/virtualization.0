From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Fix 'arch/i386/kernel/alternative.c:355: warning: unused
	variable 'i''
Date: Sun, 05 Nov 2006 17:05:43 +1100
Message-ID: <1162706743.29777.37.camel@localhost.localdomain>
References: <1162706575.29777.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1162706575.29777.33.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization <virtualization@lists.osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Fix warning about "unused variable i" when CONFIG_PARAVIRT enabled and
CONFIG_DEBUG_PARAVIRT disabled.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.19-rc4-mm2/arch/i386/kernel/alternative.c working-2.=
6.19-rc4-mm2-warnings/arch/i386/kernel/alternative.c
--- linux-2.6.19-rc4-mm2/arch/i386/kernel/alternative.c	2006-11-05 15:35:24=
.000000000 +1100
+++ working-2.6.19-rc4-mm2-warnings/arch/i386/kernel/alternative.c	2006-11-=
05 16:04:38.000000000 +1100
@@ -352,7 +352,6 @@ void alternatives_smp_switch(int smp)
 void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *e=
nd)
 {
 	struct paravirt_patch *p;
-	int i;
 =

 	for (p =3D start; p < end; p++) {
 		unsigned int used;
@@ -360,6 +359,8 @@ void apply_paravirt(struct paravirt_patc
 		used =3D paravirt_ops.patch(p->instrtype, p->clobbers, p->instr,
 					  p->len);
 #ifdef CONFIG_DEBUG_PARAVIRT
+		{
+		int i;
 		/* Deliberately clobber regs using "not %reg" to find bugs. */
 		for (i =3D 0; i < 3; i++) {
 			if (p->len - used >=3D 2 && (p->clobbers & (1 << i))) {
@@ -368,6 +369,7 @@ void apply_paravirt(struct paravirt_patc
 				used +=3D 2;
 			}
 		}
+		}
 #endif
 		/* Pad the rest with nops */
 		nop_out(p->instr + used, p->len - used);
