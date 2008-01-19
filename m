From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 4/6] use __PAGE_KERNEL instead of _PAGE_KERNEL
Date: Fri, 18 Jan 2008 23:59:08 -0200
Message-ID: <1200707971507-git-send-email-gcosta__42776.7087276608$1200708560$gmane$org@redhat.com>
References: <1200707950911-git-send-email-gcosta@redhat.com>
	<12007079562927-git-send-email-gcosta@redhat.com>
	<12007079613080-git-send-email-gcosta@redhat.com>
	<12007079663929-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12007079663929-git-send-email-gcosta@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

x86_64 don't expose the intermediate representation with one underline,
_PAGE_KERNEL, just the double-underlined one.

Use it, to get a common ground between 32 and 64-bit

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 drivers/lguest/page_tables.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lguest/page_tables.c b/drivers/lguest/page_tables.c
index 399c05d..fb5ebd0 100644
--- a/drivers/lguest/page_tables.c
+++ b/drivers/lguest/page_tables.c
@@ -645,7 +645,7 @@ void map_switcher_in_guest(struct lg_cpu *cpu, struct lguest_pages *pages)
 
 	/* Make the last PGD entry for this Guest point to the Switcher's PTE
 	 * page for this CPU (with appropriate flags). */
-	switcher_pgd = __pgd(__pa(switcher_pte_page) | _PAGE_KERNEL);
+	switcher_pgd = __pgd(__pa(switcher_pte_page) | __PAGE_KERNEL);
 
 	cpu->lg->pgdirs[cpu->cpu_pgd].pgdir[SWITCHER_PGD_INDEX] = switcher_pgd;
 
@@ -657,7 +657,7 @@ void map_switcher_in_guest(struct lg_cpu *cpu, struct lguest_pages *pages)
 	 * page is already mapped there, we don't have to copy them out
 	 * again. */
 	pfn = __pa(cpu->regs_page) >> PAGE_SHIFT;
-	regs_pte = pfn_pte(pfn, __pgprot(_PAGE_KERNEL));
+	regs_pte = pfn_pte(pfn, __pgprot(__PAGE_KERNEL));
 	switcher_pte_page[(unsigned long)pages/PAGE_SIZE%PTRS_PER_PTE] = regs_pte;
 }
 /*:*/
-- 
1.5.0.6
