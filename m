From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 01/10] remove dead code in pgtable_cache_init
Date: Fri, 12 Oct 2007 14:11:33 -0700
Message-ID: <20071012211147.666677000@goop.org>
References: <20071012211132.198718000@goop.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=x86-mminit-remove-dead-code.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, William Lee Irwin III <wli@holomorphy.com>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>, Ingo Molnar <mingo@elte.hu>, Christoph Lameter <clameter@sgi.com>
List-Id: virtualization@lists.linuxfoundation.org

The conversion from using a slab cache to quicklist left some residual
dead code.

I note that in the conversion it now always allocates a whole page for
the pgd, rather than the 32 bytes needed for a PAE pgd.  Was this
intended?

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>

---
 arch/i386/mm/init.c |   22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

===================================================================
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -746,24 +746,12 @@ struct kmem_cache *pmd_cache;
 
 void __init pgtable_cache_init(void)
 {
-	size_t pgd_size = PTRS_PER_PGD*sizeof(pgd_t);
-
-	if (PTRS_PER_PMD > 1) {
+	if (PTRS_PER_PMD > 1)
 		pmd_cache = kmem_cache_create("pmd",
-					PTRS_PER_PMD*sizeof(pmd_t),
-					PTRS_PER_PMD*sizeof(pmd_t),
-					SLAB_PANIC,
-					pmd_ctor);
-		if (!SHARED_KERNEL_PMD) {
-			/* If we're in PAE mode and have a non-shared
-			   kernel pmd, then the pgd size must be a
-			   page size.  This is because the pgd_list
-			   links through the page structure, so there
-			   can only be one pgd per page for this to
-			   work. */
-			pgd_size = PAGE_SIZE;
-		}
-	}
+					      PTRS_PER_PMD*sizeof(pmd_t),
+					      PTRS_PER_PMD*sizeof(pmd_t),
+					      SLAB_PANIC,
+					      pmd_ctor);
 }
 
 /*

-- 
