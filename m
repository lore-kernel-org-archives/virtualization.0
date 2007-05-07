From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/3] lguest: 2.6.21-mm1 update:
	lguest-remove-unnecessary-gdt-load.patch
Date: Mon, 07 May 2007 11:09:28 +1000
Message-ID: <1178500168.7731.23.camel__30470.3932758004$1178500226$gmane$org@localhost.localdomain>
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

Andrew did a great job of merging in the PDA->percpu changes and
lguest code for 2.6.21-mm1, but the load_gdt is now unnecessary.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/lguest.c |    4 ----
 1 file changed, 4 deletions(-)

===================================================================
--- a/drivers/lguest/lguest.c
+++ b/drivers/lguest/lguest.c
@@ -409,9 +409,6 @@ static unsigned lguest_patch(u8 type, u1
 	memcpy(insns, lguest_insns[type].start, insn_len);
 	return insn_len;
 }
-
-/* From head.S */
-extern struct Xgt_desc_struct early_gdt_descr;
 
 __init void lguest_init(void)
 {
@@ -468,7 +465,6 @@ __init void lguest_init(void)
 	/* We use top of mem for initial pagetables. */
 	init_pg_tables_end = __pa(pg0);
 
-	load_gdt(&early_gdt_descr);
 	asm volatile ("mov %0, %%fs" : : "r" (__KERNEL_DS) : "memory");
 
 	reserve_top_address(lguest_data.reserve_mem);
