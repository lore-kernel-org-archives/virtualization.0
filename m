From: rusty@rustcorp.com.au
Subject: [patch 27/43] lguest: Pagetables to use normal kernel types
Date: Wed, 26 Sep 2007 16:36:45 +1000
Message-ID: <20070926063649.986036932@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lg-page-table-normalize.diff
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is my first step in the migration of page_tables.c to the kernel
types and functions/macros (2.6.23-rc3).  Seems to be working OK.

---
 drivers/lguest/hypercalls.c  |    2 
 drivers/lguest/lg.h          |   45 +--------
 drivers/lguest/page_tables.c |  203 +++++++++++++++++++-----------------------
 3 files changed, 105 insertions(+), 145 deletions(-)

===================================================================
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -83,7 +83,7 @@ static void do_hcall(struct lguest *lg, 
 		guest_set_stack(lg, args->arg1, args->arg2, args->arg3);
 		break;
 	case LHCALL_SET_PTE:
-		guest_set_pte(lg, args->arg1, args->arg2, mkgpte(args->arg3));
+		guest_set_pte(lg, args->arg1, args->arg2, __pte(args->arg3));
 		break;
 	case LHCALL_SET_PMD:
 		guest_set_pmd(lg, args->arg1, args->arg2);
===================================================================
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -29,45 +29,10 @@ struct lguest_dma_info
 	u8 interrupt; 	/* 0 when not registered */
 };
 
-/*H:310 The page-table code owes a great debt of gratitude to Andi Kleen.  He
- * reviewed the original code which used "u32" for all page table entries, and
- * insisted that it would be far clearer with explicit typing.  I thought it
- * was overkill, but he was right: it is much clearer than it was before.
- *
- * We have separate types for the Guest's ptes & pgds and the shadow ptes &
- * pgds.  There's already a Linux type for these (pte_t and pgd_t) but they
- * change depending on kernel config options (PAE). */
-
-/* Each entry is identical: lower 12 bits of flags and upper 20 bits for the
- * "page frame number" (0 == first physical page, etc).  They are different
- * types so the compiler will warn us if we mix them improperly. */
-typedef union {
-	struct { unsigned flags:12, pfn:20; };
-	struct { unsigned long val; } raw;
-} spgd_t;
-typedef union {
-	struct { unsigned flags:12, pfn:20; };
-	struct { unsigned long val; } raw;
-} spte_t;
-typedef union {
-	struct { unsigned flags:12, pfn:20; };
-	struct { unsigned long val; } raw;
-} gpgd_t;
-typedef union {
-	struct { unsigned flags:12, pfn:20; };
-	struct { unsigned long val; } raw;
-} gpte_t;
-
-/* We have two convenient macros to convert a "raw" value as handed to us by
- * the Guest into the correct Guest PGD or PTE type. */
-#define mkgpte(_val) ((gpte_t){.raw.val = _val})
-#define mkgpgd(_val) ((gpgd_t){.raw.val = _val})
-/*:*/
-
 struct pgdir
 {
 	unsigned long cr3;
-	spgd_t *pgdir;
+	pgd_t *pgdir;
 };
 
 /* We have two pages shared with guests, per cpu.  */
@@ -158,6 +123,12 @@ int lguest_address_ok(const struct lgues
 		      unsigned long addr, unsigned long len);
 int run_guest(struct lguest *lg, unsigned long __user *user);
 
+/* Helper macros to obtain the first 12 or the last 20 bits, this is only the
+ * first step in the migration to the kernel types.  pte_pfn is already defined
+ * in the kernel. */
+#define pgd_flags(x)	(pgd_val(x) & ~PAGE_MASK)
+#define pte_flags(x)	(pte_val(x) & ~PAGE_MASK)
+#define pgd_pfn(x)	(pgd_val(x) >> PAGE_SHIFT)
 
 /* interrupts_and_traps.c: */
 void maybe_do_interrupt(struct lguest *lg);
@@ -188,7 +159,7 @@ void guest_pagetable_clear_all(struct lg
 void guest_pagetable_clear_all(struct lguest *lg);
 void guest_pagetable_flush_user(struct lguest *lg);
 void guest_set_pte(struct lguest *lg, unsigned long cr3,
-		   unsigned long vaddr, gpte_t val);
+		   unsigned long vaddr, pte_t val);
 void map_switcher_in_guest(struct lguest *lg, struct lguest_pages *pages);
 int demand_page(struct lguest *info, unsigned long cr2, int errcode);
 void pin_page(struct lguest *lg, unsigned long vaddr);
===================================================================
--- a/drivers/lguest/page_tables.c
+++ b/drivers/lguest/page_tables.c
@@ -44,44 +44,32 @@
  *  (vii) Setting up the page tables initially.
  :*/
 
-/* Pages a 4k long, and each page table entry is 4 bytes long, giving us 1024
- * (or 2^10) entries per page. */
-#define PTES_PER_PAGE_SHIFT 10
-#define PTES_PER_PAGE (1 << PTES_PER_PAGE_SHIFT)
 
 /* 1024 entries in a page table page maps 1024 pages: 4MB.  The Switcher is
  * conveniently placed at the top 4MB, so it uses a separate, complete PTE
  * page.  */
-#define SWITCHER_PGD_INDEX (PTES_PER_PAGE - 1)
+#define SWITCHER_PGD_INDEX (PTRS_PER_PGD - 1)
 
 /* We actually need a separate PTE page for each CPU.  Remember that after the
  * Switcher code itself comes two pages for each CPU, and we don't want this
  * CPU's guest to see the pages of any other CPU. */
-static DEFINE_PER_CPU(spte_t *, switcher_pte_pages);
+static DEFINE_PER_CPU(pte_t *, switcher_pte_pages);
 #define switcher_pte_page(cpu) per_cpu(switcher_pte_pages, cpu)
 
 /*H:320 With our shadow and Guest types established, we need to deal with
  * them: the page table code is curly enough to need helper functions to keep
  * it clear and clean.
  *
- * The first helper takes a virtual address, and says which entry in the top
- * level page table deals with that address.  Since each top level entry deals
- * with 4M, this effectively divides by 4M. */
-static unsigned vaddr_to_pgd_index(unsigned long vaddr)
-{
-	return vaddr >> (PAGE_SHIFT + PTES_PER_PAGE_SHIFT);
-}
-
-/* There are two functions which return pointers to the shadow (aka "real")
+ * There are two functions which return pointers to the shadow (aka "real")
  * page tables.
  *
  * spgd_addr() takes the virtual address and returns a pointer to the top-level
  * page directory entry for that address.  Since we keep track of several page
  * tables, the "i" argument tells us which one we're interested in (it's
  * usually the current one). */
-static spgd_t *spgd_addr(struct lguest *lg, u32 i, unsigned long vaddr)
-{
-	unsigned int index = vaddr_to_pgd_index(vaddr);
+static pgd_t *spgd_addr(struct lguest *lg, u32 i, unsigned long vaddr)
+{
+	unsigned int index = pgd_index(vaddr);
 
 	/* We kill any Guest trying to touch the Switcher addresses. */
 	if (index >= SWITCHER_PGD_INDEX) {
@@ -95,28 +83,28 @@ static spgd_t *spgd_addr(struct lguest *
 /* This routine then takes the PGD entry given above, which contains the
  * address of the PTE page.  It then returns a pointer to the PTE entry for the
  * given address. */
-static spte_t *spte_addr(struct lguest *lg, spgd_t spgd, unsigned long vaddr)
-{
-	spte_t *page = __va(spgd.pfn << PAGE_SHIFT);
+static pte_t *spte_addr(struct lguest *lg, pgd_t spgd, unsigned long vaddr)
+{
+	pte_t *page = __va(pgd_pfn(spgd) << PAGE_SHIFT);
 	/* You should never call this if the PGD entry wasn't valid */
-	BUG_ON(!(spgd.flags & _PAGE_PRESENT));
-	return &page[(vaddr >> PAGE_SHIFT) % PTES_PER_PAGE];
+	BUG_ON(!(pgd_flags(spgd) & _PAGE_PRESENT));
+	return &page[(vaddr >> PAGE_SHIFT) % PTRS_PER_PTE];
 }
 
 /* These two functions just like the above two, except they access the Guest
  * page tables.  Hence they return a Guest address. */
 static unsigned long gpgd_addr(struct lguest *lg, unsigned long vaddr)
 {
-	unsigned int index = vaddr >> (PAGE_SHIFT + PTES_PER_PAGE_SHIFT);
-	return lg->pgdirs[lg->pgdidx].cr3 + index * sizeof(gpgd_t);
+	unsigned int index = vaddr >> (PGDIR_SHIFT);
+	return lg->pgdirs[lg->pgdidx].cr3 + index * sizeof(pgd_t);
 }
 
 static unsigned long gpte_addr(struct lguest *lg,
-			       gpgd_t gpgd, unsigned long vaddr)
-{
-	unsigned long gpage = gpgd.pfn << PAGE_SHIFT;
-	BUG_ON(!(gpgd.flags & _PAGE_PRESENT));
-	return gpage + ((vaddr>>PAGE_SHIFT) % PTES_PER_PAGE) * sizeof(gpte_t);
+			       pgd_t gpgd, unsigned long vaddr)
+{
+	unsigned long gpage = pgd_pfn(gpgd) << PAGE_SHIFT;
+	BUG_ON(!(pgd_flags(gpgd) & _PAGE_PRESENT));
+	return gpage + ((vaddr>>PAGE_SHIFT) % PTRS_PER_PTE) * sizeof(pte_t);
 }
 
 /*H:350 This routine takes a page number given by the Guest and converts it to
@@ -149,16 +137,15 @@ static unsigned long get_pfn(unsigned lo
  * entry can be a little tricky.  The flags are (almost) the same, but the
  * Guest PTE contains a virtual page number: the CPU needs the real page
  * number. */
-static spte_t gpte_to_spte(struct lguest *lg, gpte_t gpte, int write)
-{
-	spte_t spte;
-	unsigned long pfn, base;
+static pte_t gpte_to_spte(struct lguest *lg, pte_t gpte, int write)
+{
+	unsigned long pfn, base, flags;
 
 	/* The Guest sets the global flag, because it thinks that it is using
 	 * PGE.  We only told it to use PGE so it would tell us whether it was
 	 * flushing a kernel mapping or a userspace mapping.  We don't actually
 	 * use the global bit, so throw it away. */
-	spte.flags = (gpte.flags & ~_PAGE_GLOBAL);
+	flags = (pte_flags(gpte) & ~_PAGE_GLOBAL);
 
 	/* The Guest's pages are offset inside the Launcher. */
 	base = (unsigned long)lg->mem_base / PAGE_SIZE;
@@ -167,38 +154,38 @@ static spte_t gpte_to_spte(struct lguest
 	 * get_pfn(), because it returns 0xFFFFFFFF on failure, which wouldn't
 	 * fit in spte.pfn.  get_pfn() finds the real physical number of the
 	 * page, given the virtual number. */
-	pfn = get_pfn(base + gpte.pfn, write);
+	pfn = get_pfn(base + pte_pfn(gpte), write);
 	if (pfn == -1UL) {
-		kill_guest(lg, "failed to get page %u", gpte.pfn);
+		kill_guest(lg, "failed to get page %lu", pte_pfn(gpte));
 		/* When we destroy the Guest, we'll go through the shadow page
 		 * tables and release_pte() them.  Make sure we don't think
 		 * this one is valid! */
-		spte.flags = 0;
-	}
-	/* Now we assign the page number, and our shadow PTE is complete. */
-	spte.pfn = pfn;
-	return spte;
+		flags = 0;
+	}
+	/* Now we assemble our shadow PTE from the page number and flags. */
+	return pfn_pte(pfn, __pgprot(flags));
 }
 
 /*H:460 And to complete the chain, release_pte() looks like this: */
-static void release_pte(spte_t pte)
+static void release_pte(pte_t pte)
 {
 	/* Remember that get_user_pages() took a reference to the page, in
 	 * get_pfn()?  We have to put it back now. */
-	if (pte.flags & _PAGE_PRESENT)
-		put_page(pfn_to_page(pte.pfn));
+	if (pte_flags(pte) & _PAGE_PRESENT)
+		put_page(pfn_to_page(pte_pfn(pte)));
 }
 /*:*/
 
-static void check_gpte(struct lguest *lg, gpte_t gpte)
-{
-	if ((gpte.flags & (_PAGE_PWT|_PAGE_PSE)) || gpte.pfn >= lg->pfn_limit)
+static void check_gpte(struct lguest *lg, pte_t gpte)
+{
+	if ((pte_flags(gpte) & (_PAGE_PWT|_PAGE_PSE))
+	    || pte_pfn(gpte) >= lg->pfn_limit)
 		kill_guest(lg, "bad page table entry");
 }
 
-static void check_gpgd(struct lguest *lg, gpgd_t gpgd)
-{
-	if ((gpgd.flags & ~_PAGE_TABLE) || gpgd.pfn >= lg->pfn_limit)
+static void check_gpgd(struct lguest *lg, pgd_t gpgd)
+{
+	if ((pgd_flags(gpgd) & ~_PAGE_TABLE) || pgd_pfn(gpgd) >= lg->pfn_limit)
 		kill_guest(lg, "bad page directory entry");
 }
 
@@ -214,21 +201,21 @@ static void check_gpgd(struct lguest *lg
  * true. */
 int demand_page(struct lguest *lg, unsigned long vaddr, int errcode)
 {
-	gpgd_t gpgd;
-	spgd_t *spgd;
+	pgd_t gpgd;
+	pgd_t *spgd;
 	unsigned long gpte_ptr;
-	gpte_t gpte;
-	spte_t *spte;
+	pte_t gpte;
+	pte_t *spte;
 
 	/* First step: get the top-level Guest page table entry. */
-	gpgd = mkgpgd(lgread_u32(lg, gpgd_addr(lg, vaddr)));
+	gpgd = __pgd(lgread_u32(lg, gpgd_addr(lg, vaddr)));
 	/* Toplevel not present?  We can't map it in. */
-	if (!(gpgd.flags & _PAGE_PRESENT))
+	if (!(pgd_flags(gpgd) & _PAGE_PRESENT))
 		return 0;
 
 	/* Now look at the matching shadow entry. */
 	spgd = spgd_addr(lg, lg->pgdidx, vaddr);
-	if (!(spgd->flags & _PAGE_PRESENT)) {
+	if (!(pgd_flags(*spgd) & _PAGE_PRESENT)) {
 		/* No shadow entry: allocate a new shadow PTE page. */
 		unsigned long ptepage = get_zeroed_page(GFP_KERNEL);
 		/* This is not really the Guest's fault, but killing it is
@@ -241,34 +228,35 @@ int demand_page(struct lguest *lg, unsig
 		check_gpgd(lg, gpgd);
 		/* And we copy the flags to the shadow PGD entry.  The page
 		 * number in the shadow PGD is the page we just allocated. */
-		spgd->raw.val = (__pa(ptepage) | gpgd.flags);
+		*spgd = __pgd(__pa(ptepage) | pgd_flags(gpgd));
 	}
 
 	/* OK, now we look at the lower level in the Guest page table: keep its
 	 * address, because we might update it later. */
 	gpte_ptr = gpte_addr(lg, gpgd, vaddr);
-	gpte = mkgpte(lgread_u32(lg, gpte_ptr));
+	gpte = __pte(lgread_u32(lg, gpte_ptr));
 
 	/* If this page isn't in the Guest page tables, we can't page it in. */
-	if (!(gpte.flags & _PAGE_PRESENT))
+	if (!(pte_flags(gpte) & _PAGE_PRESENT))
 		return 0;
 
 	/* Check they're not trying to write to a page the Guest wants
 	 * read-only (bit 2 of errcode == write). */
-	if ((errcode & 2) && !(gpte.flags & _PAGE_RW))
+	if ((errcode & 2) && !(pte_flags(gpte) & _PAGE_RW))
 		return 0;
 
 	/* User access to a kernel page? (bit 3 == user access) */
-	if ((errcode & 4) && !(gpte.flags & _PAGE_USER))
+	if ((errcode & 4) && !(pte_flags(gpte) & _PAGE_USER))
 		return 0;
 
 	/* Check that the Guest PTE flags are OK, and the page number is below
 	 * the pfn_limit (ie. not mapping the Launcher binary). */
 	check_gpte(lg, gpte);
 	/* Add the _PAGE_ACCESSED and (for a write) _PAGE_DIRTY flag */
-	gpte.flags |= _PAGE_ACCESSED;
+	gpte = pte_mkyoung(gpte);
+
 	if (errcode & 2)
-		gpte.flags |= _PAGE_DIRTY;
+		gpte = pte_mkdirty(gpte);
 
 	/* Get the pointer to the shadow PTE entry we're going to set. */
 	spte = spte_addr(lg, *spgd, vaddr);
@@ -278,21 +266,21 @@ int demand_page(struct lguest *lg, unsig
 
 	/* If this is a write, we insist that the Guest page is writable (the
 	 * final arg to gpte_to_spte()). */
-	if (gpte.flags & _PAGE_DIRTY)
+	if (pte_dirty(gpte))
 		*spte = gpte_to_spte(lg, gpte, 1);
 	else {
 		/* If this is a read, don't set the "writable" bit in the page
 		 * table entry, even if the Guest says it's writable.  That way
 		 * we come back here when a write does actually ocur, so we can
 		 * update the Guest's _PAGE_DIRTY flag. */
-		gpte_t ro_gpte = gpte;
-		ro_gpte.flags &= ~_PAGE_RW;
+		pte_t ro_gpte = gpte;
+		pte_wrprotect(ro_gpte);
 		*spte = gpte_to_spte(lg, ro_gpte, 0);
 	}
 
 	/* Finally, we write the Guest PTE entry back: we've set the
 	 * _PAGE_ACCESSED and maybe the _PAGE_DIRTY flags. */
-	lgwrite_u32(lg, gpte_ptr, gpte.raw.val);
+	lgwrite_u32(lg, gpte_ptr, pte_val(gpte));
 
 	/* We succeeded in mapping the page! */
 	return 1;
@@ -308,17 +296,18 @@ int demand_page(struct lguest *lg, unsig
  * mapped by the shadow page tables, and is it writable? */
 static int page_writable(struct lguest *lg, unsigned long vaddr)
 {
-	spgd_t *spgd;
+	pgd_t *spgd;
 	unsigned long flags;
 
 	/* Look at the top level entry: is it present? */
 	spgd = spgd_addr(lg, lg->pgdidx, vaddr);
-	if (!(spgd->flags & _PAGE_PRESENT))
+	if (!(pgd_flags(*spgd) & _PAGE_PRESENT))
 		return 0;
 
 	/* Check the flags on the pte entry itself: it must be present and
 	 * writable. */
-	flags = spte_addr(lg, *spgd, vaddr)->flags;
+	flags = pte_flags(*(spte_addr(lg, *spgd, vaddr)));
+
 	return (flags & (_PAGE_PRESENT|_PAGE_RW)) == (_PAGE_PRESENT|_PAGE_RW);
 }
 
@@ -332,22 +321,22 @@ void pin_page(struct lguest *lg, unsigne
 }
 
 /*H:450 If we chase down the release_pgd() code, it looks like this: */
-static void release_pgd(struct lguest *lg, spgd_t *spgd)
+static void release_pgd(struct lguest *lg, pgd_t *spgd)
 {
 	/* If the entry's not present, there's nothing to release. */
-	if (spgd->flags & _PAGE_PRESENT) {
+	if (pgd_flags(*spgd) & _PAGE_PRESENT) {
 		unsigned int i;
 		/* Converting the pfn to find the actual PTE page is easy: turn
 		 * the page number into a physical address, then convert to a
 		 * virtual address (easy for kernel pages like this one). */
-		spte_t *ptepage = __va(spgd->pfn << PAGE_SHIFT);
+		pte_t *ptepage = __va(pgd_pfn(*spgd) << PAGE_SHIFT);
 		/* For each entry in the page, we might need to release it. */
-		for (i = 0; i < PTES_PER_PAGE; i++)
+		for (i = 0; i < PTRS_PER_PTE; i++)
 			release_pte(ptepage[i]);
 		/* Now we can free the page of PTEs */
 		free_page((long)ptepage);
 		/* And zero out the PGD entry we we never release it twice. */
-		spgd->raw.val = 0;
+		*spgd = __pgd(0);
 	}
 }
 
@@ -359,7 +348,7 @@ static void flush_user_mappings(struct l
 {
 	unsigned int i;
 	/* Release every pgd entry up to the kernel's address. */
-	for (i = 0; i < vaddr_to_pgd_index(lg->page_offset); i++)
+	for (i = 0; i < pgd_index(lg->page_offset); i++)
 		release_pgd(lg, lg->pgdirs[idx].pgdir + i);
 }
 
@@ -398,7 +387,7 @@ static unsigned int new_pgdir(struct lgu
 	next = random32() % ARRAY_SIZE(lg->pgdirs);
 	/* If it's never been allocated at all before, try now. */
 	if (!lg->pgdirs[next].pgdir) {
-		lg->pgdirs[next].pgdir = (spgd_t *)get_zeroed_page(GFP_KERNEL);
+		lg->pgdirs[next].pgdir = (pgd_t *)get_zeroed_page(GFP_KERNEL);
 		/* If the allocation fails, just keep using the one we have */
 		if (!lg->pgdirs[next].pgdir)
 			next = lg->pgdidx;
@@ -475,26 +464,27 @@ void guest_pagetable_clear_all(struct lg
  * they set _PAGE_DIRTY then we can put a writable PTE entry in immediately.
  */
 static void do_set_pte(struct lguest *lg, int idx,
-		       unsigned long vaddr, gpte_t gpte)
+		       unsigned long vaddr, pte_t gpte)
 {
 	/* Look up the matching shadow page directot entry. */
-	spgd_t *spgd = spgd_addr(lg, idx, vaddr);
+	pgd_t *spgd = spgd_addr(lg, idx, vaddr);
 
 	/* If the top level isn't present, there's no entry to update. */
-	if (spgd->flags & _PAGE_PRESENT) {
+	if (pgd_flags(*spgd) & _PAGE_PRESENT) {
 		/* Otherwise, we start by releasing the existing entry. */
-		spte_t *spte = spte_addr(lg, *spgd, vaddr);
+		pte_t *spte = spte_addr(lg, *spgd, vaddr);
 		release_pte(*spte);
 
 		/* If they're setting this entry as dirty or accessed, we might
 		 * as well put that entry they've given us in now.  This shaves
 		 * 10% off a copy-on-write micro-benchmark. */
-		if (gpte.flags & (_PAGE_DIRTY | _PAGE_ACCESSED)) {
+		if (pte_flags(gpte) & (_PAGE_DIRTY | _PAGE_ACCESSED)) {
 			check_gpte(lg, gpte);
-			*spte = gpte_to_spte(lg, gpte, gpte.flags&_PAGE_DIRTY);
+			*spte = gpte_to_spte(lg, gpte,
+					     pte_flags(gpte) & _PAGE_DIRTY);
 		} else
 			/* Otherwise we can demand_page() it in later. */
-			spte->raw.val = 0;
+			*spte = __pte(0);
 	}
 }
 
@@ -509,7 +499,7 @@ static void do_set_pte(struct lguest *lg
  * The benefit is that when we have to track a new page table, we can copy keep
  * all the kernel mappings.  This speeds up context switch immensely. */
 void guest_set_pte(struct lguest *lg,
-		   unsigned long cr3, unsigned long vaddr, gpte_t gpte)
+		   unsigned long cr3, unsigned long vaddr, pte_t gpte)
 {
 	/* Kernel mappings must be changed on all top levels.  Slow, but
 	 * doesn't happen often. */
@@ -564,15 +554,15 @@ int init_guest_pagetable(struct lguest *
 int init_guest_pagetable(struct lguest *lg, unsigned long pgtable)
 {
 	/* In flush_user_mappings() we loop from 0 to
-	 * "vaddr_to_pgd_index(lg->page_offset)".  This assumes it won't hit
+	 * "pgd_index(lg->page_offset)".  This assumes it won't hit
 	 * the Switcher mappings, so check that now. */
-	if (vaddr_to_pgd_index(lg->page_offset) >= SWITCHER_PGD_INDEX)
+	if (pgd_index(lg->page_offset) >= SWITCHER_PGD_INDEX)
 		return -EINVAL;
 	/* We start on the first shadow page table, and give it a blank PGD
 	 * page. */
 	lg->pgdidx = 0;
 	lg->pgdirs[lg->pgdidx].cr3 = pgtable;
-	lg->pgdirs[lg->pgdidx].pgdir = (spgd_t*)get_zeroed_page(GFP_KERNEL);
+	lg->pgdirs[lg->pgdidx].pgdir = (pgd_t*)get_zeroed_page(GFP_KERNEL);
 	if (!lg->pgdirs[lg->pgdidx].pgdir)
 		return -ENOMEM;
 	return 0;
@@ -597,14 +587,14 @@ void free_guest_pagetable(struct lguest 
  * for each CPU already set up, we just need to hook them in. */
 void map_switcher_in_guest(struct lguest *lg, struct lguest_pages *pages)
 {
-	spte_t *switcher_pte_page = __get_cpu_var(switcher_pte_pages);
-	spgd_t switcher_pgd;
-	spte_t regs_pte;
+	pte_t *switcher_pte_page = __get_cpu_var(switcher_pte_pages);
+	pgd_t switcher_pgd;
+	pte_t regs_pte;
 
 	/* Make the last PGD entry for this Guest point to the Switcher's PTE
 	 * page for this CPU (with appropriate flags). */
-	switcher_pgd.pfn = __pa(switcher_pte_page) >> PAGE_SHIFT;
-	switcher_pgd.flags = _PAGE_KERNEL;
+	switcher_pgd = __pgd(__pa(switcher_pte_page) | _PAGE_KERNEL);
+
 	lg->pgdirs[lg->pgdidx].pgdir[SWITCHER_PGD_INDEX] = switcher_pgd;
 
 	/* We also change the Switcher PTE page.  When we're running the Guest,
@@ -614,10 +604,8 @@ void map_switcher_in_guest(struct lguest
 	 * CPU's "struct lguest_pages": if we make sure the Guest's register
 	 * page is already mapped there, we don't have to copy them out
 	 * again. */
-	regs_pte.pfn = __pa(lg->regs_page) >> PAGE_SHIFT;
-	regs_pte.flags = _PAGE_KERNEL;
-	switcher_pte_page[(unsigned long)pages/PAGE_SIZE%PTES_PER_PAGE]
-		= regs_pte;
+	regs_pte = pfn_pte (__pa(lg->regs_page) >> PAGE_SHIFT, __pgprot(_PAGE_KERNEL));
+	switcher_pte_page[(unsigned long)pages/PAGE_SIZE%PTRS_PER_PTE] = regs_pte;
 }
 /*:*/
 
@@ -638,24 +626,25 @@ static __init void populate_switcher_pte
 					      unsigned int pages)
 {
 	unsigned int i;
-	spte_t *pte = switcher_pte_page(cpu);
+	pte_t *pte = switcher_pte_page(cpu);
 
 	/* The first entries are easy: they map the Switcher code. */
 	for (i = 0; i < pages; i++) {
-		pte[i].pfn = page_to_pfn(switcher_page[i]);
-		pte[i].flags = _PAGE_PRESENT|_PAGE_ACCESSED;
+		pte[i] = mk_pte(switcher_page[i],
+				__pgprot(_PAGE_PRESENT|_PAGE_ACCESSED));
 	}
 
 	/* The only other thing we map is this CPU's pair of pages. */
 	i = pages + cpu*2;
 
 	/* First page (Guest registers) is writable from the Guest */
-	pte[i].pfn = page_to_pfn(switcher_page[i]);
-	pte[i].flags = _PAGE_PRESENT|_PAGE_ACCESSED|_PAGE_RW;
+	pte[i] = pfn_pte(page_to_pfn(switcher_page[i]),
+			 __pgprot(_PAGE_PRESENT|_PAGE_ACCESSED|_PAGE_RW));
+
 	/* The second page contains the "struct lguest_ro_state", and is
 	 * read-only. */
-	pte[i+1].pfn = page_to_pfn(switcher_page[i+1]);
-	pte[i+1].flags = _PAGE_PRESENT|_PAGE_ACCESSED;
+	pte[i+1] = pfn_pte(page_to_pfn(switcher_page[i+1]),
+			   __pgprot(_PAGE_PRESENT|_PAGE_ACCESSED));
 }
 
 /*H:510 At boot or module load time, init_pagetables() allocates and populates
@@ -665,7 +654,7 @@ __init int init_pagetables(struct page *
 	unsigned int i;
 
 	for_each_possible_cpu(i) {
-		switcher_pte_page(i) = (spte_t *)get_zeroed_page(GFP_KERNEL);
+		switcher_pte_page(i) = (pte_t *)get_zeroed_page(GFP_KERNEL);
 		if (!switcher_pte_page(i)) {
 			free_switcher_pte_pages();
 			return -ENOMEM;

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
