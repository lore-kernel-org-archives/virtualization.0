From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/3] lguest: more lazy_hcalls
Date: Thu, 31 May 2007 17:24:13 +1000
Message-ID: <1180596254.11133.24.camel__5143.66021748192$1180596332$gmane$org@localhost.localdomain>
References: <1180596191.11133.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1180596191.11133.22.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Some hypercalls can be batched: lazy_hcall is the wrapper which
determines this, so it's pretty harmless to use lazy_hcall() instead of
hcall().

Before:
Time for one context switch via pipe: 6745 (6521 - 13966)

After:
Time for one context switch via pipe: 5406 (5170 - 7467)

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/lguest.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

===================================================================
--- a/drivers/lguest/lguest.c
+++ b/drivers/lguest/lguest.c
@@ -225,7 +225,7 @@ static unsigned long current_cr0, curren
 static unsigned long current_cr0, current_cr3;
 static void lguest_write_cr0(unsigned long val)
 {
-	hcall(LHCALL_TS, val & 8, 0, 0);
+	lazy_hcall(LHCALL_TS, val & 8, 0, 0);
 	current_cr0 = val;
 }
 
@@ -247,7 +247,7 @@ static unsigned long lguest_read_cr2(voi
 
 static void lguest_write_cr3(unsigned long cr3)
 {
-	hcall(LHCALL_NEW_PGTABLE, cr3, 0, 0);
+	lazy_hcall(LHCALL_NEW_PGTABLE, cr3, 0, 0);
 	current_cr3 = cr3;
 }
 
@@ -287,7 +287,7 @@ static void lguest_set_pte(pte_t *ptep, 
 	*ptep = pteval;
 	/* Don't bother with hypercall before initial setup. */
 	if (current_cr3)
-		hcall(LHCALL_FLUSH_TLB, 1, 0, 0);
+		lazy_hcall(LHCALL_FLUSH_TLB, 1, 0, 0);
 }
 
 static void lguest_flush_tlb_single(unsigned long addr)
