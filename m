From: Will Deacon <will@kernel.org>
Subject: [PATCH 07/18] alpha: Replace smp_read_barrier_depends() usage with smp_[r]mb()
Date: Tue, 30 Jun 2020 18:37:23 +0100
Message-ID: <20200630173734.14057-8-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.orgv
List-Id: virtualization@lists.linuxfoundation.org

In preparation for removing smp_read_barrier_depends() altogether,
move the Alpha code over to using smp_rmb() and smp_mb() directly.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/alpha/include/asm/atomic.h  | 16 ++++++++--------
 arch/alpha/include/asm/pgtable.h | 10 +++++-----
 mm/memory.c                      |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 2144530d1428..2f8f7e54792f 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -16,10 +16,10 @@
 
 /*
  * To ensure dependency ordering is preserved for the _relaxed and
- * _release atomics, an smp_read_barrier_depends() is unconditionally
- * inserted into the _relaxed variants, which are used to build the
- * barriered versions. Avoid redundant back-to-back fences in the
- * _acquire and _fence versions.
+ * _release atomics, an smp_mb() is unconditionally inserted into the
+ * _relaxed variants, which are used to build the barriered versions.
+ * Avoid redundant back-to-back fences in the _acquire and _fence
+ * versions.
  */
 #define __atomic_acquire_fence()
 #define __atomic_post_full_fence()
@@ -70,7 +70,7 @@ static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 	".previous"							\
 	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
 	:"Ir" (i), "m" (v->counter) : "memory");			\
-	smp_read_barrier_depends();					\
+	smp_mb();							\
 	return result;							\
 }
 
@@ -88,7 +88,7 @@ static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 	".previous"							\
 	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
 	:"Ir" (i), "m" (v->counter) : "memory");			\
-	smp_read_barrier_depends();					\
+	smp_mb();							\
 	return result;							\
 }
 
@@ -123,7 +123,7 @@ static __inline__ s64 atomic64_##op##_return_relaxed(s64 i, atomic64_t * v)	\
 	".previous"							\
 	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
 	:"Ir" (i), "m" (v->counter) : "memory");			\
-	smp_read_barrier_depends();					\
+	smp_mb();							\
 	return result;							\
 }
 
@@ -141,7 +141,7 @@ static __inline__ s64 atomic64_fetch_##op##_relaxed(s64 i, atomic64_t * v)	\
 	".previous"							\
 	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
 	:"Ir" (i), "m" (v->counter) : "memory");			\
-	smp_read_barrier_depends();					\
+	smp_mb();							\
 	return result;							\
 }
 
diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 162c17b2631f..660b14ce1317 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -277,9 +277,9 @@ extern inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= __DIRTY_BITS; retur
 extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= __ACCESS_BITS; return pte; }
 
 /*
- * The smp_read_barrier_depends() in the following functions are required to
- * order the load of *dir (the pointer in the top level page table) with any
- * subsequent load of the returned pmd_t *ret (ret is data dependent on *dir).
+ * The smp_rmb() in the following functions are required to order the load of
+ * *dir (the pointer in the top level page table) with any subsequent load of
+ * the returned pmd_t *ret (ret is data dependent on *dir).
  *
  * If this ordering is not enforced, the CPU might load an older value of
  * *ret, which may be uninitialized data. See mm/memory.c:__pte_alloc for
@@ -293,7 +293,7 @@ extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= __ACCESS_BITS; retu
 extern inline pmd_t * pmd_offset(pud_t * dir, unsigned long address)
 {
 	pmd_t *ret = (pmd_t *) pud_page_vaddr(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
-	smp_read_barrier_depends(); /* see above */
+	smp_rmb(); /* see above */
 	return ret;
 }
 #define pmd_offset pmd_offset
@@ -303,7 +303,7 @@ extern inline pte_t * pte_offset_kernel(pmd_t * dir, unsigned long address)
 {
 	pte_t *ret = (pte_t *) pmd_page_vaddr(*dir)
 		+ ((address >> PAGE_SHIFT) & (PTRS_PER_PAGE - 1));
-	smp_read_barrier_depends(); /* see above */
+	smp_rmb(); /* see above */
 	return ret;
 }
 #define pte_offset_kernel pte_offset_kernel
diff --git a/mm/memory.c b/mm/memory.c
index 87ec87cdc1ff..e1f2c730d8bb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -437,7 +437,7 @@ int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
 	 * of a chain of data-dependent loads, meaning most CPUs (alpha
 	 * being the notable exception) will already guarantee loads are
 	 * seen in-order. See the alpha page table accessors for the
-	 * smp_read_barrier_depends() barriers in page table walking code.
+	 * smp_rmb() barriers in page table walking code.
 	 */
 	smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
 
-- 
2.27.0.212.ge8ba1cc988-goog
