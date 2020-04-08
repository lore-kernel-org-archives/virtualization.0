From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 13/26] x86/alternatives: Split __text_poke()
Date: Tue,  7 Apr 2020 22:03:10 -0700
Message-ID: <20200408050323.4237-14-ankur.a.arora@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: peterz@infradead.org, hpa@zytor.com, jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org, jgross@suse.com, bp@alien8.de, vkuznets@redhat.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, mihai.carabas@oracle.com, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, Ankur Arora <ankur.a.arora@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Separate __text_poke() into map, memcpy and unmap portions,
(__text_poke_map(), __text_do_poke() and __text_poke_unmap().)

Do this to separate the non-reentrant bits from the reentrant
__text_do_poke(). __text_poke_map()/_unmap() modify poking_mm,
poking_addr and do the pte-mapping and thus are non-reentrant.

This allows __text_do_poke() to be safely called from an INT3
context with __text_poke_map()/_unmap() being called at the
start and the end of the patching of a call-site instead of
doing that for each stage of the three patching stages.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/kernel/alternative.c | 46 +++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 0344e49a4ade..337aad8c2521 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -805,13 +805,12 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 __ro_after_init struct mm_struct *poking_mm;
 __ro_after_init unsigned long poking_addr;
 
-static void __text_poke(void *addr, const void *opcode, size_t len)
+static void __text_poke_map(void *addr, size_t len,
+			    temp_mm_state_t *prev_mm, pte_t **ptep)
 {
 	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
 	struct page *pages[2] = {NULL};
-	temp_mm_state_t prev;
-	unsigned long flags;
-	pte_t pte, *ptep;
+	pte_t pte;
 	pgprot_t pgprot;
 
 	/*
@@ -836,8 +835,6 @@ static void __text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
 
-	local_irq_save(flags);
-
 	/*
 	 * Map the page without the global bit, as TLB flushing is done with
 	 * flush_tlb_mm_range(), which is intended for non-global PTEs.
@@ -849,30 +846,42 @@ static void __text_poke(void *addr, const void *opcode, size_t len)
 	 * unlocked. This does mean that we need to be careful that no other
 	 * context (ex. INT3 handler) is simultaneously writing to this pte.
 	 */
-	ptep = __get_unlocked_pte(poking_mm, poking_addr);
+	*ptep = __get_unlocked_pte(poking_mm, poking_addr);
 	/*
 	 * This must not fail; preallocated in poking_init().
 	 */
-	VM_BUG_ON(!ptep);
+	VM_BUG_ON(!*ptep);
 
 	pte = mk_pte(pages[0], pgprot);
-	set_pte_at(poking_mm, poking_addr, ptep, pte);
+	set_pte_at(poking_mm, poking_addr, *ptep, pte);
 
 	if (cross_page_boundary) {
 		pte = mk_pte(pages[1], pgprot);
-		set_pte_at(poking_mm, poking_addr + PAGE_SIZE, ptep + 1, pte);
+		set_pte_at(poking_mm, poking_addr + PAGE_SIZE, *ptep + 1, pte);
 	}
 
 	/*
 	 * Loading the temporary mm behaves as a compiler barrier, which
 	 * guarantees that the PTE will be set at the time memcpy() is done.
 	 */
-	prev = use_temporary_mm(poking_mm);
+	*prev_mm = use_temporary_mm(poking_mm);
+}
 
+/*
+ * Do the actual poke. Needs to be re-entrant as this can be called
+ * via INT3 context as well.
+ */
+static void __text_do_poke(unsigned long offset, const void *opcode, size_t len)
+{
 	kasan_disable_current();
-	memcpy((u8 *)poking_addr + offset_in_page(addr), opcode, len);
+	memcpy((u8 *)poking_addr + offset, opcode, len);
 	kasan_enable_current();
+}
 
+static void __text_poke_unmap(void *addr, const void *opcode, size_t len,
+			      temp_mm_state_t *prev_mm, pte_t *ptep)
+{
+	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
 	/*
 	 * Ensure that the PTE is only cleared after the instructions of memcpy
 	 * were issued by using a compiler barrier.
@@ -888,7 +897,7 @@ static void __text_poke(void *addr, const void *opcode, size_t len)
 	 * instruction that already allows the core to see the updated version.
 	 * Xen-PV is assumed to serialize execution in a similar manner.
 	 */
-	unuse_temporary_mm(prev);
+	unuse_temporary_mm(*prev_mm);
 
 	/*
 	 * Flushing the TLB might involve IPIs, which would require enabled
@@ -903,7 +912,18 @@ static void __text_poke(void *addr, const void *opcode, size_t len)
 	 * fundamentally screwy; there's nothing we can really do about that.
 	 */
 	BUG_ON(memcmp(addr, opcode, len));
+}
 
+static void __text_poke(void *addr, const void *opcode, size_t len)
+{
+	temp_mm_state_t prev_mm;
+	unsigned long flags;
+	pte_t *ptep;
+
+	local_irq_save(flags);
+	__text_poke_map(addr, len, &prev_mm, &ptep);
+	__text_do_poke(offset_in_page(addr), opcode, len);
+	__text_poke_unmap(addr, opcode, len, &prev_mm, ptep);
 	local_irq_restore(flags);
 }
 
-- 
2.20.1
