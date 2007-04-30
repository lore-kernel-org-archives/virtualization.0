From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] lguest: properly kill guest userspace programs accessing
	kernel mem
Date: Mon, 30 Apr 2007 23:04:19 +1000
Message-ID: <1177938259.30071.219.camel@localhost.localdomain>
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

Kernel pages on x86 are protected by not having the _PAGE_USER bit
set.  When guest userspace accesses a kernel page, we didn't check
this, so we'd think we'd handled the fault and return to the guest,
causing the guest userspace program to loop instead of segfaulting.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/core.c        |    2 +-
 drivers/lguest/lg.h          |    2 +-
 drivers/lguest/page_tables.c |   12 ++++++++----
 3 files changed, 10 insertions(+), 6 deletions(-)

===================================================================
--- a/drivers/lguest/core.c
+++ b/drivers/lguest/core.c
@@ -346,7 +346,7 @@ int run_guest(struct lguest *lg, char *_
 			}
 			break;
 		case 14: /* We've intercepted a page fault. */
-			if (demand_page(lg, cr2, lg->regs->errcode & 2))
+			if (demand_page(lg, cr2, lg->regs->errcode))
 				continue;
 
 			/* If lguest_data is NULL, this won't hurt. */
===================================================================
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -216,7 +216,7 @@ void guest_set_pte(struct lguest *lg, un
 void guest_set_pte(struct lguest *lg, unsigned long cr3,
 		   unsigned long vaddr, gpte_t val);
 void map_switcher_in_guest(struct lguest *lg, struct lguest_pages *pages);
-int demand_page(struct lguest *info, unsigned long cr2, int write);
+int demand_page(struct lguest *info, unsigned long cr2, int errcode);
 void pin_page(struct lguest *lg, unsigned long vaddr);
 
 /* lguest_user.c: */
===================================================================
--- a/drivers/lguest/page_tables.c
+++ b/drivers/lguest/page_tables.c
@@ -109,7 +109,7 @@ static void check_gpgd(struct lguest *lg
 
 /* We fault pages in, which allows us to update accessed/dirty bits.
  * Return true if we got page. */
-int demand_page(struct lguest *lg, unsigned long vaddr, int write)
+int demand_page(struct lguest *lg, unsigned long vaddr, int errcode)
 {
 	gpgd_t gpgd;
 	spgd_t *spgd;
@@ -138,12 +140,16 @@ int demand_page(struct lguest *lg, unsig
 		return 0;
 
 	/* Write to read-only page? */
-	if (write && !(gpte.flags & _PAGE_RW))
+	if ((errcode & 2) && !(gpte.flags & _PAGE_RW))
 		return 0;
+
+	/* User access to a non-user page? */
+	if ((errcode & 4) && !(gpte.flags & _PAGE_USER))
+		return 0;
 
 	check_gpte(lg, gpte);
 	gpte.flags |= _PAGE_ACCESSED;
-	if (write)
+	if (errcode & 2)
 		gpte.flags |= _PAGE_DIRTY;
 
 	/* We're done with the old pte. */
@@ -185,7 +200,7 @@ static int page_writable(struct lguest *
 
 void pin_page(struct lguest *lg, unsigned long vaddr)
 {
-	if (!page_writable(lg, vaddr) && !demand_page(lg, vaddr, 0))
+	if (!page_writable(lg, vaddr) && !demand_page(lg, vaddr, 2))
 		kill_guest(lg, "bad stack page %#lx", vaddr);
 }
