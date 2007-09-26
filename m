From: rusty@rustcorp.com.au
Subject: [patch 43/43] lguest: generalize lgread_u32/lgwrite_u32.
Date: Wed, 26 Sep 2007 16:37:01 +1000
Message-ID: <20070926063652.917809564@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=generic-lgread-lgwrite.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: Jes Sorensen <jes@sgi.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jes complains that page table code still uses lgread_u32 even though
it now uses general kernel pte types.  The best thing to do is to
generalize lgread_u32 and lgwrite_u32.

This means we lose the efficiency of getuser().  We could potentially
regain it if we used __copy_from_user instead of copy_from_user, but
I'm not certain that our range check is equivalent to access_ok() on
all platforms.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jes Sorensen <jes@sgi.com>
---
 drivers/lguest/core.c                 |   39 ++++++---------------------------
 drivers/lguest/hypercalls.c           |    2 -
 drivers/lguest/i386_core.c            |    4 +--
 drivers/lguest/interrupts_and_traps.c |    2 -
 drivers/lguest/lg.h                   |   23 ++++++++++++++++---
 drivers/lguest/page_tables.c          |   10 ++++----
 drivers/lguest/segments.c             |    4 +--
 7 files changed, 38 insertions(+), 46 deletions(-)

===================================================================
--- a/drivers/lguest/core.c
+++ b/drivers/lguest/core.c
@@ -145,33 +145,10 @@ int lguest_address_ok(const struct lgues
 	return (addr+len) / PAGE_SIZE < lg->pfn_limit && (addr+len >= addr);
 }
 
-/* This is a convenient routine to get a 32-bit value from the Guest (a very
- * common operation).  Here we can see how useful the kill_lguest() routine we
- * met in the Launcher can be: we return a random value (0) instead of needing
- * to return an error. */
-u32 lgread_u32(struct lguest *lg, unsigned long addr)
-{
-	u32 val = 0;
-
-	/* Don't let them access lguest binary. */
-	if (!lguest_address_ok(lg, addr, sizeof(val))
-	    || get_user(val, (u32 *)(lg->mem_base + addr)) != 0)
-		kill_guest(lg, "bad read address %#lx: pfn_limit=%u membase=%p", addr, lg->pfn_limit, lg->mem_base);
-	return val;
-}
-
-/* Same thing for writing a value. */
-void lgwrite_u32(struct lguest *lg, unsigned long addr, u32 val)
-{
-	if (!lguest_address_ok(lg, addr, sizeof(val))
-	    || put_user(val, (u32 *)(lg->mem_base + addr)) != 0)
-		kill_guest(lg, "bad write address %#lx", addr);
-}
-
-/* This routine is more generic, and copies a range of Guest bytes into a
- * buffer.  If the copy_from_user() fails, we fill the buffer with zeroes, so
- * the caller doesn't end up using uninitialized kernel memory. */
-void lgread(struct lguest *lg, void *b, unsigned long addr, unsigned bytes)
+/* This routine copies memory from the Guest.  Here we can see how useful the
+ * kill_lguest() routine we met in the Launcher can be: we return a random
+ * value (all zeroes) instead of needing to return an error. */
+void __lgread(struct lguest *lg, void *b, unsigned long addr, unsigned bytes)
 {
 	if (!lguest_address_ok(lg, addr, bytes)
 	    || copy_from_user(b, lg->mem_base + addr, bytes) != 0) {
@@ -181,15 +158,15 @@ void lgread(struct lguest *lg, void *b, 
 	}
 }
 
-/* Similarly, our generic routine to copy into a range of Guest bytes. */
-void lgwrite(struct lguest *lg, unsigned long addr, const void *b,
-	     unsigned bytes)
+/* This is the write (copy into guest) version. */
+void __lgwrite(struct lguest *lg, unsigned long addr, const void *b,
+	       unsigned bytes)
 {
 	if (!lguest_address_ok(lg, addr, bytes)
 	    || copy_to_user(lg->mem_base + addr, b, bytes) != 0)
 		kill_guest(lg, "bad write address %#lx len %u", addr, bytes);
 }
-/* (end of memory access helper routines) :*/
+/*:*/
 
 /*H:030 Let's jump straight to the the main loop which runs the Guest.
  * Remember, this is called by the Launcher reading /dev/lguest, and we keep
===================================================================
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -47,7 +47,7 @@ static void do_hcall(struct lguest *lg, 
 		char msg[128];
 		/* If the lgread fails, it will call kill_guest() itself; the
 		 * kill_guest() with the message will be ignored. */
-		lgread(lg, msg, args->arg1, sizeof(msg));
+		__lgread(lg, msg, args->arg1, sizeof(msg));
 		msg[sizeof(msg)-1] = '\0';
 		kill_guest(lg, "CRASH: %s", msg);
 		break;
===================================================================
--- a/drivers/lguest/i386_core.c
+++ b/drivers/lguest/i386_core.c
@@ -222,7 +222,7 @@ static int emulate_insn(struct lguest *l
 		return 0;
 
 	/* Decoding x86 instructions is icky. */
-	lgread(lg, &insn, physaddr, 1);
+	insn = lgread(lg, &insn, u8);
 
 	/* 0x66 is an "operand prefix".  It means it's using the upper 16 bits
 	   of the eax register. */
@@ -230,7 +230,7 @@ static int emulate_insn(struct lguest *l
 		shift = 16;
 		/* The instruction is 1 byte so far, read the next byte. */
 		insnlen = 1;
-		lgread(lg, &insn, physaddr + insnlen, 1);
+		insn = lgread(lg, physaddr + insnlen, u8);
 	}
 
 	/* We can ignore the lower bit for the moment and decode the 4 opcodes
===================================================================
--- a/drivers/lguest/interrupts_and_traps.c
+++ b/drivers/lguest/interrupts_and_traps.c
@@ -45,7 +45,7 @@ static void push_guest_stack(struct lgue
 {
 	/* Stack grows upwards: move stack then write value. */
 	*gstack -= 4;
-	lgwrite_u32(lg, *gstack, val);
+	lgwrite(lg, *gstack, u32, val);
 }
 
 /*H:210 The set_guest_interrupt() routine actually delivers the interrupt or
===================================================================
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -99,12 +99,27 @@ extern struct mutex lguest_lock;
 extern struct mutex lguest_lock;
 
 /* core.c: */
-u32 lgread_u32(struct lguest *lg, unsigned long addr);
-void lgwrite_u32(struct lguest *lg, unsigned long addr, u32 val);
-void lgread(struct lguest *lg, void *buf, unsigned long addr, unsigned len);
-void lgwrite(struct lguest *lg, unsigned long, const void *buf, unsigned len);
 int lguest_address_ok(const struct lguest *lg,
 		      unsigned long addr, unsigned long len);
+void __lgread(struct lguest *, void *, unsigned long, unsigned);
+void __lgwrite(struct lguest *, unsigned long, const void *, unsigned);
+
+/*L:306 Using memory-copy operations like that is usually inconvient, so we
+ * have the following helper macros which read and write a specific type (often
+ * an unsigned long).
+ *
+ * This reads into a variable of the given type then returns that. */
+#define lgread(lg, addr, type)						\
+	{( type _v; __lgread((lg), &_v, (addr), sizeof(_v)); _v; )}
+
+/* This checks that the variable is of the given type, then writes it out. */
+#define lgwrite(lg, addr, type, val)				\
+	do {							\
+		typecheck(type, v);				\
+		__lgwrite((lg), &(v), (addr), sizeof(v));	\
+	} while(0)
+/* (end of memory access helper routines) :*/
+
 int run_guest(struct lguest *lg, unsigned long __user *user);
 
 /* Helper macros to obtain the first 12 or the last 20 bits, this is only the
===================================================================
--- a/drivers/lguest/page_tables.c
+++ b/drivers/lguest/page_tables.c
@@ -209,7 +209,7 @@ int demand_page(struct lguest *lg, unsig
 	pte_t *spte;
 
 	/* First step: get the top-level Guest page table entry. */
-	gpgd = __pgd(lgread_u32(lg, gpgd_addr(lg, vaddr)));
+	gpgd = lgread(lg, gpgd_addr(lg, vaddr), pgd_t);
 	/* Toplevel not present?  We can't map it in. */
 	if (!(pgd_flags(gpgd) & _PAGE_PRESENT))
 		return 0;
@@ -235,7 +235,7 @@ int demand_page(struct lguest *lg, unsig
 	/* OK, now we look at the lower level in the Guest page table: keep its
 	 * address, because we might update it later. */
 	gpte_ptr = gpte_addr(lg, gpgd, vaddr);
-	gpte = __pte(lgread_u32(lg, gpte_ptr));
+	gpte = lgread(lg, gpte_ptr, pte_t);
 
 	/* If this page isn't in the Guest page tables, we can't page it in. */
 	if (!(pte_flags(gpte) & _PAGE_PRESENT))
@@ -281,7 +281,7 @@ int demand_page(struct lguest *lg, unsig
 
 	/* Finally, we write the Guest PTE entry back: we've set the
 	 * _PAGE_ACCESSED and maybe the _PAGE_DIRTY flags. */
-	lgwrite_u32(lg, gpte_ptr, pte_val(gpte));
+	lgwrite(lg, gpte_ptr, pte_t, gpte);
 
 	/* We succeeded in mapping the page! */
 	return 1;
@@ -369,12 +369,12 @@ unsigned long guest_pa(struct lguest *lg
 	pte_t gpte;
 
 	/* First step: get the top-level Guest page table entry. */
-	gpgd = __pgd(lgread_u32(lg, gpgd_addr(lg, vaddr)));
+	gpgd = lgread(lg, gpgd_addr(lg, vaddr), pgd_t);
 	/* Toplevel not present?  We can't map it in. */
 	if (!(pgd_flags(gpgd) & _PAGE_PRESENT))
 		kill_guest(lg, "Bad address %#lx", vaddr);
 
-	gpte = __pte(lgread_u32(lg, gpte_addr(lg, gpgd, vaddr)));
+	gpte = lgread(lg, gpte_addr(lg, gpgd, vaddr), pte_t);
 	if (!(pte_flags(gpte) & _PAGE_PRESENT))
 		kill_guest(lg, "Bad address %#lx", vaddr);
 
===================================================================
--- a/drivers/lguest/segments.c
+++ b/drivers/lguest/segments.c
@@ -150,7 +150,7 @@ void load_guest_gdt(struct lguest *lg, u
 		kill_guest(lg, "too many gdt entries %i", num);
 
 	/* We read the whole thing in, then fix it up. */
-	lgread(lg, lg->arch.gdt, table, num * sizeof(lg->arch.gdt[0]));
+	__lgread(lg, lg->arch.gdt, table, num * sizeof(lg->arch.gdt[0]));
 	fixup_gdt_table(lg, 0, ARRAY_SIZE(lg->arch.gdt));
 	/* Mark that the GDT changed so the core knows it has to copy it again,
 	 * even if the Guest is run on the same CPU. */
@@ -161,7 +161,7 @@ void guest_load_tls(struct lguest *lg, u
 {
 	struct desc_struct *tls = &lg->arch.gdt[GDT_ENTRY_TLS_MIN];
 
-	lgread(lg, tls, gtls, sizeof(*tls)*GDT_ENTRY_TLS_ENTRIES);
+	__lgread(lg, tls, gtls, sizeof(*tls)*GDT_ENTRY_TLS_ENTRIES);
 	fixup_gdt_table(lg, GDT_ENTRY_TLS_MIN, GDT_ENTRY_TLS_MAX+1);
 	lg->changed |= CHANGED_GDT_TLS;
 }

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
