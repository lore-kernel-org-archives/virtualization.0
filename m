From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 3/5] i386-gdt-pda Update lguest to initialize gdt without pda
Date: Mon, 26 Mar 2007 17:21:32 -0700
Message-ID: <20070327002841.672969672@goop.org>
References: <20070327002129.240126099@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lguest-use-percpu.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>
---
 arch/i386/lguest/lguest.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/lguest/lguest.c
+++ b/arch/i386/lguest/lguest.c
@@ -34,7 +34,6 @@
 #include <asm/desc.h>
 #include <asm/setup.h>
 #include <asm/e820.h>
-#include <asm/pda.h>
 #include <asm/asm-offsets.h>
 #include <asm/mce.h>
 =

@@ -449,12 +448,10 @@ static void lguest_power_off(void)
 	hcall(LHCALL_CRASH, __pa("Power down"), 0, 0);
 }
 =

-/* From head.S */
-extern void setup_pda(void);
-extern struct Xgt_desc_struct early_gdt_descr;
-
 static __attribute_used__ __init void lguest_init(void)
 {
+	struct Xgt_desc_struct gdt_desc;
+
 	paravirt_ops.name =3D "lguest";
 	paravirt_ops.paravirt_enabled =3D 1;
 	paravirt_ops.kernel_rpl =3D 1;
@@ -513,10 +510,10 @@ static __attribute_used__ __init void lg
 	/* We use top of mem for initial pagetables. */
 	init_pg_tables_end =3D __pa(pg0);
 =

-	/* set up PDA descriptor */
-	setup_pda();
-	load_gdt(&early_gdt_descr);
-	asm volatile ("mov %0, %%fs" : : "r" (__KERNEL_PDA) : "memory");
+	/* set up gdt */
+	gdt_desc.address =3D (unsigned long)per_cpu__gdt_page.gdt;
+	gdt_desc.size =3D sizeof(struct gdt_page)-1;
+	load_gdt(&gdt_desc);
 =

 	reserve_top_address(lguest_data.reserve_mem);
 =


-- =
