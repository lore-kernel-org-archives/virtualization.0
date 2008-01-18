From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/7] More lguest massage.
Date: Thu, 17 Jan 2008 22:35:44 -0200
Message-ID: <12006165571406-git-send-email-gcosta__15939.2256442972$1200616667$gmane$org@redhat.com>
References: <1200616550283-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1200616550283-git-send-email-gcosta@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

spte_addrdoes not depend on any guest information, so we
wipeout the lg parameter completely.

Signed-off-by:Glauber de Oliveira Costa <gcosta@redhat.com>
---
drivers/lguest/page_tables.c |    8 ++++----
1 files changed, 4 insertions(+), 4 deletions(-)

diff--git a/drivers/lguest/page_tables.c b/drivers/lguest/page_tables.c
indexfb66561..c4b8eaf 100644
---a/drivers/lguest/page_tables.c
+++b/drivers/lguest/page_tables.c
@@-84,7 +84,7 @@ static pgd_t *spgd_addr(struct lguest *lg, u32 i, unsigned long vaddr)
/* This routine then takes the page directory entry returned above, which
 * contains the address of the page table entry (PTE) page.  It then returns a
 * pointer to the PTE entry for the given address. */
-staticpte_t *spte_addr(struct lguest *lg, pgd_t spgd, unsigned long vaddr)
+staticpte_t *spte_addr(pgd_t spgd, unsigned long vaddr)
{
	pte_t *page = __va(pgd_pfn(spgd) << PAGE_SHIFT);
	/* You should never call this if the PGD entry wasn't valid */
@@-261,7 +261,7 @@ int demand_page(struct lg_cpu *cpu, unsigned long vaddr, int errcode)
		gpte = pte_mkdirty(gpte);

	/* Get the pointer to the shadow PTE entry we're going to set. */
-	spte= spte_addr(lg, *spgd, vaddr);
+	spte= spte_addr(*spgd, vaddr);
	/* If there was a valid shadow PTE entry here before, we release it.
	 * This can happen with a write to a previously read-only entry. */
	release_pte(*spte);
@@-310,7 +310,7 @@ static int page_writable(struct lg_cpu *cpu, unsigned long vaddr)

	/* Check the flags on the pte entry itself: it must be present and
	 * writable. */
-	flags= pte_flags(*(spte_addr(cpu->lg, *spgd, vaddr)));
+	flags= pte_flags(*(spte_addr(*spgd, vaddr)));

	return (flags & (_PAGE_PRESENT|_PAGE_RW)) == (_PAGE_PRESENT|_PAGE_RW);
}
@@-509,7 +509,7 @@ static void do_set_pte(struct lguest *lg, int idx,
	/* If the top level isn't present, there's no entry to update. */
	if (pgd_flags(*spgd) & _PAGE_PRESENT) {
		/* Otherwise, we start by releasing the existing entry. */
-		pte_t*spte = spte_addr(lg, *spgd, vaddr);
+		pte_t*spte = spte_addr(*spgd, vaddr);
		release_pte(*spte);

		/* If they're setting this entry as dirty or accessed, we might
--
1.5.0.6
