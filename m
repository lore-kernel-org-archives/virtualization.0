From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: [PATCH 2/5] lguest: use set_pte/set_pmd uniformly for real
	page table entries
Date: Mon, 21 Sep 2009 16:52:21 +0930
Message-ID: <20090921072350.72D83B7BA5@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/lguest>,
	<mailto:lguest-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:lguest-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/lguest>,
	<mailto:lguest-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Cc: lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Matias Zabaljauregui <zabaljauregui-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamalesh Babulal <kamalesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org


If we're building a pte, we can use simple assigment; only use set_pte
etc. when we're actually going to use that destination as a PTE.  I
don't know that we'll ever run under Xen, but it's neater.

And use set_pte/set_pmd rather than assuming native_ versions, even
though that's probably true for most people.

(Includes compile fix by Kamalesh Babulal <kamalesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>)
Signed-off-by: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Cc: Matias Zabaljauregui <zabaljauregui-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kamalesh Babulal <kamalesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 drivers/lguest/page_tables.c |   39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/lguest/page_tables.c b/drivers/lguest/page_tables.c
--- a/drivers/lguest/page_tables.c
+++ b/drivers/lguest/page_tables.c
@@ -380,7 +380,7 @@ bool demand_page(struct lg_cpu *cpu, uns
 		 * And we copy the flags to the shadow PMD entry.  The page
 		 * number in the shadow PMD is the page we just allocated.
 		 */
-		native_set_pmd(spmd, __pmd(__pa(ptepage) | pmd_flags(gpmd)));
+		set_pmd(spmd, __pmd(__pa(ptepage) | pmd_flags(gpmd)));
 	}
 
 	/*
@@ -447,7 +447,7 @@ bool demand_page(struct lg_cpu *cpu, uns
 		 * we will come back here when a write does actually occur, so
 		 * we can update the Guest's _PAGE_DIRTY flag.
 		 */
-		native_set_pte(spte, gpte_to_spte(cpu, pte_wrprotect(gpte), 0));
+		set_pte(spte, gpte_to_spte(cpu, pte_wrprotect(gpte), 0));
 
 	/*
 	 * Finally, we write the Guest PTE entry back: we've set the
@@ -528,7 +528,7 @@ static void release_pmd(pmd_t *spmd)
 		/* Now we can free the page of PTEs */
 		free_page((long)ptepage);
 		/* And zero out the PMD entry so we never release it twice. */
-		native_set_pmd(spmd, __pmd(0));
+		set_pmd(spmd, __pmd(0));
 	}
 }
 
@@ -833,15 +833,15 @@ static void do_set_pte(struct lg_cpu *cp
 			 */
 			if (pte_flags(gpte) & (_PAGE_DIRTY | _PAGE_ACCESSED)) {
 				check_gpte(cpu, gpte);
-				native_set_pte(spte,
-						gpte_to_spte(cpu, gpte,
+				set_pte(spte,
+					gpte_to_spte(cpu, gpte,
 						pte_flags(gpte) & _PAGE_DIRTY));
 			} else {
 				/*
 				 * Otherwise kill it and we can demand_page()
 				 * it in later.
 				 */
-				native_set_pte(spte, __pte(0));
+				set_pte(spte, __pte(0));
 			}
 #ifdef CONFIG_X86_PAE
 		}
@@ -983,16 +983,15 @@ static unsigned long setup_pagetables(st
 	 */
 	for (i = j = 0; i < mapped_pages && j < PTRS_PER_PMD;
 	     i += PTRS_PER_PTE, j++) {
-		/* FIXME: native_set_pmd is overkill here. */
-		native_set_pmd(&pmd, __pmd(((unsigned long)(linear + i)
-		- mem_base) | _PAGE_PRESENT | _PAGE_RW | _PAGE_USER));
+		pmd = pfn_pmd(((unsigned long)&linear[i] - mem_base)/PAGE_SIZE,
+			      __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER));
 
 		if (copy_to_user(&pmds[j], &pmd, sizeof(pmd)) != 0)
 			return -EFAULT;
 	}
 
 	/* One PGD entry, pointing to that PMD page. */
-	set_pgd(&pgd, __pgd(((u32)pmds - mem_base) | _PAGE_PRESENT));
+	pgd = __pgd(((unsigned long)pmds - mem_base) | _PAGE_PRESENT);
 	/* Copy it in as the first PGD entry (ie. addresses 0-1G). */
 	if (copy_to_user(&pgdir[0], &pgd, sizeof(pgd)) != 0)
 		return -EFAULT;
@@ -1141,15 +1140,13 @@ void map_switcher_in_guest(struct lg_cpu
 {
 	pte_t *switcher_pte_page = __get_cpu_var(switcher_pte_pages);
 	pte_t regs_pte;
-	unsigned long pfn;
 
 #ifdef CONFIG_X86_PAE
 	pmd_t switcher_pmd;
 	pmd_t *pmd_table;
 
-	/* FIXME: native_set_pmd is overkill here. */
-	native_set_pmd(&switcher_pmd, pfn_pmd(__pa(switcher_pte_page) >>
-		       PAGE_SHIFT, PAGE_KERNEL_EXEC));
+	switcher_pmd = pfn_pmd(__pa(switcher_pte_page) >> PAGE_SHIFT,
+			       PAGE_KERNEL_EXEC);
 
 	/* Figure out where the pmd page is, by reading the PGD, and converting
 	 * it to a virtual address. */
@@ -1157,7 +1154,7 @@ void map_switcher_in_guest(struct lg_cpu
 			pgdirs[cpu->cpu_pgd].pgdir[SWITCHER_PGD_INDEX])
 								<< PAGE_SHIFT);
 	/* Now write it into the shadow page table. */
-	native_set_pmd(&pmd_table[SWITCHER_PMD_INDEX], switcher_pmd);
+	set_pmd(&pmd_table[SWITCHER_PMD_INDEX], switcher_pmd);
 #else
 	pgd_t switcher_pgd;
 
@@ -1179,10 +1176,8 @@ void map_switcher_in_guest(struct lg_cpu
 	 * page is already mapped there, we don't have to copy them out
 	 * again.
 	 */
-	pfn = __pa(cpu->regs_page) >> PAGE_SHIFT;
-	native_set_pte(&regs_pte, pfn_pte(pfn, PAGE_KERNEL));
-	native_set_pte(&switcher_pte_page[pte_index((unsigned long)pages)],
-			regs_pte);
+	regs_pte = pfn_pte(__pa(cpu->regs_page) >> PAGE_SHIFT, PAGE_KERNEL);
+	set_pte(&switcher_pte_page[pte_index((unsigned long)pages)], regs_pte);
 }
 /*:*/
 
@@ -1209,7 +1204,7 @@ static __init void populate_switcher_pte
 
 	/* The first entries are easy: they map the Switcher code. */
 	for (i = 0; i < pages; i++) {
-		native_set_pte(&pte[i], mk_pte(switcher_page[i],
+		set_pte(&pte[i], mk_pte(switcher_page[i],
 				__pgprot(_PAGE_PRESENT|_PAGE_ACCESSED)));
 	}
 
@@ -1217,14 +1212,14 @@ static __init void populate_switcher_pte
 	i = pages + cpu*2;
 
 	/* First page (Guest registers) is writable from the Guest */
-	native_set_pte(&pte[i], pfn_pte(page_to_pfn(switcher_page[i]),
+	set_pte(&pte[i], pfn_pte(page_to_pfn(switcher_page[i]),
 			 __pgprot(_PAGE_PRESENT|_PAGE_ACCESSED|_PAGE_RW)));
 
 	/*
 	 * The second page contains the "struct lguest_ro_state", and is
 	 * read-only.
 	 */
-	native_set_pte(&pte[i+1], pfn_pte(page_to_pfn(switcher_page[i+1]),
+	set_pte(&pte[i+1], pfn_pte(page_to_pfn(switcher_page[i+1]),
 			   __pgprot(_PAGE_PRESENT|_PAGE_ACCESSED)));
 }
