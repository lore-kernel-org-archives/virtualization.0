From: rusty@rustcorp.com.au
Subject: [patch 28/43] lguest: Rename "cr3" to "gpgdir" to avoid
	x86-specific naming.
Date: Wed, 26 Sep 2007 16:36:46 +1000
Message-ID: <20070926063650.184405943@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lg-cr3-to-gpgdir.patch
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

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/lg.h          |    6 +++---
 drivers/lguest/page_tables.c |   18 +++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

===================================================================
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -35,7 +35,7 @@ struct lguest_dma_info
 
 struct pgdir
 {
-	unsigned long cr3;
+	unsigned long gpgdir;
 	pgd_t *pgdir;
 };
 
@@ -159,10 +159,10 @@ int init_guest_pagetable(struct lguest *
 int init_guest_pagetable(struct lguest *lg, unsigned long pgtable);
 void free_guest_pagetable(struct lguest *lg);
 void guest_new_pagetable(struct lguest *lg, unsigned long pgtable);
-void guest_set_pmd(struct lguest *lg, unsigned long cr3, u32 i);
+void guest_set_pmd(struct lguest *lg, unsigned long gpgdir, u32 i);
 void guest_pagetable_clear_all(struct lguest *lg);
 void guest_pagetable_flush_user(struct lguest *lg);
-void guest_set_pte(struct lguest *lg, unsigned long cr3,
+void guest_set_pte(struct lguest *lg, unsigned long gpgdir,
 		   unsigned long vaddr, pte_t val);
 void map_switcher_in_guest(struct lguest *lg, struct lguest_pages *pages);
 int demand_page(struct lguest *info, unsigned long cr2, int errcode);
===================================================================
--- a/drivers/lguest/page_tables.c
+++ b/drivers/lguest/page_tables.c
@@ -96,7 +96,7 @@ static unsigned long gpgd_addr(struct lg
 static unsigned long gpgd_addr(struct lguest *lg, unsigned long vaddr)
 {
 	unsigned int index = vaddr >> (PGDIR_SHIFT);
-	return lg->pgdirs[lg->pgdidx].cr3 + index * sizeof(pgd_t);
+	return lg->pgdirs[lg->pgdidx].gpgdir + index * sizeof(pgd_t);
 }
 
 static unsigned long gpte_addr(struct lguest *lg,
@@ -369,7 +369,7 @@ static unsigned int find_pgdir(struct lg
 {
 	unsigned int i;
 	for (i = 0; i < ARRAY_SIZE(lg->pgdirs); i++)
-		if (lg->pgdirs[i].cr3 == pgtable)
+		if (lg->pgdirs[i].gpgdir == pgtable)
 			break;
 	return i;
 }
@@ -378,7 +378,7 @@ static unsigned int find_pgdir(struct lg
  * allocate a new one (and so the kernel parts are not there), we set
  * blank_pgdir. */
 static unsigned int new_pgdir(struct lguest *lg,
-			      unsigned long cr3,
+			      unsigned long gpgdir,
 			      int *blank_pgdir)
 {
 	unsigned int next;
@@ -398,7 +398,7 @@ static unsigned int new_pgdir(struct lgu
 			*blank_pgdir = 1;
 	}
 	/* Record which Guest toplevel this shadows. */
-	lg->pgdirs[next].cr3 = cr3;
+	lg->pgdirs[next].gpgdir = gpgdir;
 	/* Release all the non-kernel mappings. */
 	flush_user_mappings(lg, next);
 
@@ -499,7 +499,7 @@ static void do_set_pte(struct lguest *lg
  * The benefit is that when we have to track a new page table, we can copy keep
  * all the kernel mappings.  This speeds up context switch immensely. */
 void guest_set_pte(struct lguest *lg,
-		   unsigned long cr3, unsigned long vaddr, pte_t gpte)
+		   unsigned long gpgdir, unsigned long vaddr, pte_t gpte)
 {
 	/* Kernel mappings must be changed on all top levels.  Slow, but
 	 * doesn't happen often. */
@@ -510,7 +510,7 @@ void guest_set_pte(struct lguest *lg,
 				do_set_pte(lg, i, vaddr, gpte);
 	} else {
 		/* Is this page table one we have a shadow for? */
-		int pgdir = find_pgdir(lg, cr3);
+		int pgdir = find_pgdir(lg, gpgdir);
 		if (pgdir != ARRAY_SIZE(lg->pgdirs))
 			/* If so, do the update. */
 			do_set_pte(lg, pgdir, vaddr, gpte);
@@ -531,7 +531,7 @@ void guest_set_pte(struct lguest *lg,
  *
  * So with that in mind here's our code to to update a (top-level) PGD entry:
  */
-void guest_set_pmd(struct lguest *lg, unsigned long cr3, u32 idx)
+void guest_set_pmd(struct lguest *lg, unsigned long gpgdir, u32 idx)
 {
 	int pgdir;
 
@@ -541,7 +541,7 @@ void guest_set_pmd(struct lguest *lg, un
 		return;
 
 	/* If they're talking about a page table we have a shadow for... */
-	pgdir = find_pgdir(lg, cr3);
+	pgdir = find_pgdir(lg, gpgdir);
 	if (pgdir < ARRAY_SIZE(lg->pgdirs))
 		/* ... throw it away. */
 		release_pgd(lg, lg->pgdirs[pgdir].pgdir + idx);
@@ -561,7 +561,7 @@ int init_guest_pagetable(struct lguest *
 	/* We start on the first shadow page table, and give it a blank PGD
 	 * page. */
 	lg->pgdidx = 0;
-	lg->pgdirs[lg->pgdidx].cr3 = pgtable;
+	lg->pgdirs[lg->pgdidx].gpgdir = pgtable;
 	lg->pgdirs[lg->pgdidx].pgdir = (pgd_t*)get_zeroed_page(GFP_KERNEL);
 	if (!lg->pgdirs[lg->pgdidx].pgdir)
 		return -ENOMEM;

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
