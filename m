From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 18/28] Copying of the pgd range must happen under the pgd_lock
Date: Sat, 14 Apr 2007 13:42:12 -0700
Message-ID: <20070414204924.724969434@goop.org>
References: <20070414204154.871250608@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752308AbXDNVYF@vger.kernel.org>
Content-Disposition: inline; filename=i386-pgd-clone-under-lock-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>, William Lee Irwin III <wli@holomorphy.com>
List-Id: virtualization@lists.linuxfoundation.org

Copying of the pgd range must happen under the pgd_lock.  This got broken by
the paravirt changes in the -mm tree.  Badness can result if you copy the pgd
before being added to the list when splitting or rejoining large pages.

From: Zachary Amsden <zach@vmware.com>
Signed-off-by: Zachary Amsden <zach@vmware.com>
Acked-by: William Lee Irwin III <wli@holomorphy.com>
---
 arch/i386/mm/pgtable.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

===================================================================
--- a/arch/i386/mm/pgtable.c
+++ b/arch/i386/mm/pgtable.c
@@ -241,18 +241,16 @@ void pgd_ctor(void *pgd, struct kmem_cac
 	/* !PAE, no pagetable sharing */
 	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
 
+	spin_lock_irqsave(&pgd_lock, flags);
+
+	/* must happen under lock */
 	clone_pgd_range((pgd_t *)pgd + USER_PTRS_PER_PGD,
 			swapper_pg_dir + USER_PTRS_PER_PGD,
 			KERNEL_PGD_PTRS);
-
-	spin_lock_irqsave(&pgd_lock, flags);
-
-	/* must happen under lock */
 	paravirt_alloc_pd_clone(__pa(pgd) >> PAGE_SHIFT,
 				__pa(swapper_pg_dir) >> PAGE_SHIFT,
 				USER_PTRS_PER_PGD,
 				KERNEL_PGD_PTRS);
-
 	pgd_list_add(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }

-- 
