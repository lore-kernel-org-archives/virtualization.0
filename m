From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 12/26] x86/alternatives: Use __get_unlocked_pte() in text_poke()
Date: Tue,  7 Apr 2020 22:03:09 -0700
Message-ID: <20200408050323.4237-13-ankur.a.arora@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Sender: kvm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: peterz@infradead.org, hpa@zytor.com, jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org, jgross@suse.com, bp@alien8.de, vkuznets@redhat.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, mihai.carabas@oracle.com, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, Ankur Arora <ankur.a.arora@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

text_poke() uses get_locked_pte() to map poking_addr. However, this
introduces a dependency on locking code which precludes using
text_poke() to modify qspinlock primitives.

Accesses to this pte (and poking_addr) are protected by text_mutex
so we can safely switch to __get_unlocked_pte() here. Note that
we do need to be careful that we do not try to modify the poking_addr
from multiple contexts simultaneously (ex. INT3 or NMI context.)

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/kernel/alternative.c |  9 ++++-----
 include/linux/mm.h            | 16 ++++++++++++++--
 mm/memory.c                   |  9 ++++++---
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8c79a3dc5e72..0344e49a4ade 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -812,7 +812,6 @@ static void __text_poke(void *addr, const void *opcode, size_t len)
 	temp_mm_state_t prev;
 	unsigned long flags;
 	pte_t pte, *ptep;
-	spinlock_t *ptl;
 	pgprot_t pgprot;
 
 	/*
@@ -846,10 +845,11 @@ static void __text_poke(void *addr, const void *opcode, size_t len)
 	pgprot = __pgprot(pgprot_val(PAGE_KERNEL) & ~_PAGE_GLOBAL);
 
 	/*
-	 * The lock is not really needed, but this allows to avoid open-coding.
+	 * text_poke() might be used to poke spinlock primitives so do this
+	 * unlocked. This does mean that we need to be careful that no other
+	 * context (ex. INT3 handler) is simultaneously writing to this pte.
 	 */
-	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
-
+	ptep = __get_unlocked_pte(poking_mm, poking_addr);
 	/*
 	 * This must not fail; preallocated in poking_init().
 	 */
@@ -904,7 +904,6 @@ static void __text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	BUG_ON(memcmp(addr, opcode, len));
 
-	pte_unmap_unlock(ptep, ptl);
 	local_irq_restore(flags);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7dd5c4ccbf85..d4a652c2e269 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1895,8 +1895,20 @@ static inline int pte_devmap(pte_t pte)
 
 int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
 
-extern pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
-			       spinlock_t **ptl);
+pte_t *__get_pte(struct mm_struct *mm, unsigned long addr, spinlock_t **ptl);
+
+static inline pte_t *__get_unlocked_pte(struct mm_struct *mm,
+					unsigned long addr)
+{
+	return __get_pte(mm, addr, NULL);
+}
+
+static inline pte_t *__get_locked_pte(struct mm_struct *mm,
+				      unsigned long addr, spinlock_t **ptl)
+{
+	return __get_pte(mm, addr, ptl);
+}
+
 static inline pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
 				    spinlock_t **ptl)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 586271f3efc6..7acfe9512084 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1407,8 +1407,8 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL_GPL(zap_vma_ptes);
 
-pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
-			spinlock_t **ptl)
+pte_t *__get_pte(struct mm_struct *mm, unsigned long addr,
+		 spinlock_t **ptl)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -1427,7 +1427,10 @@ pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
 		return NULL;
 
 	VM_BUG_ON(pmd_trans_huge(*pmd));
-	return pte_alloc_map_lock(mm, pmd, addr, ptl);
+	if (likely(ptl))
+		return pte_alloc_map_lock(mm, pmd, addr, ptl);
+	else
+		return pte_alloc_map(mm, pmd, addr);
 }
 
 /*
-- 
2.20.1
