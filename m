From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/2] lguest: fix up after pda->percpu conversion
Date: Sun, 29 Apr 2007 23:34:57 +1000
Message-ID: <1177853697.30071.179.camel__25433.4189034582$1177853776$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton commented out some stuff to make lguest compile.  This
should actually make it work (in the latest -mm).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/lguest.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

===================================================================
--- a/drivers/lguest/lguest.c
+++ b/drivers/lguest/lguest.c
@@ -34,7 +34,6 @@
 #include <asm/desc.h>
 #include <asm/setup.h>
 #include <asm/e820.h>
-//#include <asm/pda.h>
 #include <asm/mce.h>
 
 /* Declarations for definitions in lguest_guest.S */
@@ -406,10 +409,6 @@ static unsigned lguest_patch(u8 type, u1
 	memcpy(insns, lguest_insns[type].start, insn_len);
 	return insn_len;
 }
-
-/* From head.S */
-//extern void setup_pda(void);
-extern struct Xgt_desc_struct early_gdt_descr;
 
 __init void lguest_init(void)
 {
@@ -466,10 +465,8 @@ __init void lguest_init(void)
 	/* We use top of mem for initial pagetables. */
 	init_pg_tables_end = __pa(pg0);
 
-	/* set up PDA descriptor */
-//	setup_pda();
-	load_gdt(&early_gdt_descr);
-//	asm volatile ("mov %0, %%fs" : : "r" (__KERNEL_PDA) : "memory");
+	/* Set up per-cpu descriptor (pointing to master area) */
+	asm volatile ("mov %0, %%fs" : : "r" (__KERNEL_DS) : "memory");
 
 	reserve_top_address(lguest_data.reserve_mem);
