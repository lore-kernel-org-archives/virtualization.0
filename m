From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] lguest simplification: don't pin guest trap handlers
Date: Sat, 28 Apr 2007 14:52:07 +1000
Message-ID: <1177735927.30071.158.camel__40156.2504041523$1177735996$gmane$org@localhost.localdomain>
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

We don't actually need the Guest handlers mapped to avoid double
fault, just the stack pages.  Thanks to Zach for confirming.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/interrupts_and_traps.c |   26 +-------------------------
 drivers/lguest/lg.h                   |    2 +-
 drivers/lguest/page_tables.c          |    6 +++---
 3 files changed, 5 insertions(+), 29 deletions(-)

===================================================================
--- a/drivers/lguest/interrupts_and_traps.c
+++ b/drivers/lguest/interrupts_and_traps.c
@@ -138,31 +138,12 @@ static int direct_trap(const struct lgue
 	return idt_type(trap->a, trap->b) == 0xF;
 }
 
-static void pin_stack_pages(struct lguest *lg)
+void pin_stack_pages(struct lguest *lg)
 {
 	unsigned int i;
 
 	for (i = 0; i < lg->stack_pages; i++)
 		pin_page(lg, lg->esp1 - i * PAGE_SIZE);
-}
-
-/* We need to ensure all the direct trap pages are mapped after we
- * clear shadow mappings. */
-void pin_trap_pages(struct lguest *lg)
-{
-	unsigned int i;
-	struct desc_struct *trap;
-
-	for (i = 0; i < FIRST_EXTERNAL_VECTOR; i++) {
-		trap = &lg->idt[i];
-		if (direct_trap(lg, trap, i))
-			pin_page(lg, idt_address(trap->a, trap->b));
-	}
-
-	trap = &lg->syscall_idt;
-	if (direct_trap(lg, trap, SYSCALL_VECTOR))
-		pin_page(lg, idt_address(trap->a, trap->b));
-	pin_stack_pages(lg);
 }
 
 void guest_set_stack(struct lguest *lg, u32 seg, u32 esp, unsigned int pages)
@@ -194,11 +175,6 @@ static void set_trap(struct lguest *lg, 
 
 	trap->a = ((__KERNEL_CS|GUEST_PL)<<16) | (lo&0x0000FFFF);
 	trap->b = (hi&0xFFFFEF00);
-
-	/* Make sure trap address is available so we don't fault.  In
-	 * theory, it could overlap two pages, in practice it's aligned. */
-	if (direct_trap(lg, trap, num))
-		pin_page(lg, idt_address(lo, hi));
 }
 
 void load_guest_idt_entry(struct lguest *lg, unsigned int num, u32 lo, u32 hi)
===================================================================
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -190,7 +190,7 @@ int deliver_trap(struct lguest *lg, unsi
 int deliver_trap(struct lguest *lg, unsigned int num);
 void load_guest_idt_entry(struct lguest *lg, unsigned int i, u32 low, u32 hi);
 void guest_set_stack(struct lguest *lg, u32 seg, u32 esp, unsigned int pages);
-void pin_trap_pages(struct lguest *lg);
+void pin_stack_pages(struct lguest *lg);
 void setup_default_idt_entries(struct lguest_ro_state *state,
 			       const unsigned long *def);
 void copy_traps(const struct lguest *lg, struct desc_struct *idt,
===================================================================
--- a/drivers/lguest/page_tables.c
+++ b/drivers/lguest/page_tables.c
@@ -186,7 +186,7 @@ void pin_page(struct lguest *lg, unsigne
 void pin_page(struct lguest *lg, unsigned long vaddr)
 {
 	if (!page_writable(lg, vaddr) && !demand_page(lg, vaddr, 0))
-		kill_guest(lg, "bad trap page %#lx", vaddr);
+		kill_guest(lg, "bad stack page %#lx", vaddr);
 }
 
 static void release_pgd(struct lguest *lg, spgd_t *spgd)
@@ -253,7 +253,7 @@ void guest_new_pagetable(struct lguest *
 		newpgdir = new_pgdir(lg, pgtable, &repin);
 	lg->pgdidx = newpgdir;
 	if (repin)
-		pin_trap_pages(lg);
+		pin_stack_pages(lg);
 }
 
 static void release_all_pagetables(struct lguest *lg)
@@ -269,7 +269,7 @@ void guest_pagetable_clear_all(struct lg
 void guest_pagetable_clear_all(struct lguest *lg)
 {
 	release_all_pagetables(lg);
-	pin_trap_pages(lg);
+	pin_stack_pages(lg);
 }
 
 static void do_set_pte(struct lguest *lg, int idx,
