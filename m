From: Will Deacon <will@kernel.org>
Subject: [PATCH v3 08/19] alpha: Replace smp_read_barrier_depends() usage with
 smp_[r]mb()
Date: Fri, 10 Jul 2020 17:51:52 +0100
Message-ID: <20200710165203.31284-9-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>, Mark Rutland <mark.rutland@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alan Stern <stern@rowland.harvard.edu>, Sami Tolvanen <samitolvanen@google.com>, Matt Turner <mattst88@gmail.com>, kernel-team@android.com, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, Nick Desaulniers <ndesaulniers@google.com>, linux-alpha@vger.kernel.org
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
2.27.0.383.g050319c2ae-goog
