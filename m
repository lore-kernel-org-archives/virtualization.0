From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v9 1/6] powerpc/qspinlock: powerpc support qspinlock
Date: Tue,  6 Dec 2016 13:09:22 -0500
Message-ID: <1481047767-60255-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1481047767-60255-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481047767-60255-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: xinhui.pan@linux.vnet.ibm.com, peterz@infradead.org, benh@kernel.crashing.org, boqun.feng@gmail.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, longman@redhat.com, paulmck@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

This patch add basic code to enable qspinlock on powerpc. qspinlock is
one kind of fairlock implementation. And seen some performance improvement
under some scenarios.

queued_spin_unlock() release the lock by just one write of NULL to the
::locked field which sits at different places in the two endianness
system.

We override some arch_spin_XXX as powerpc has io_sync stuff which makes
sure the io operations are protected by the lock correctly.

There is another special case, see commit
2c610022711 ("locking/qspinlock: Fix spin_unlock_wait() some more")

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/qspinlock.h      | 66 +++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/spinlock.h       | 31 +++++++++------
 arch/powerpc/include/asm/spinlock_types.h |  4 ++
 arch/powerpc/lib/locks.c                  | 62 +++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+), 13 deletions(-)
 create mode 100644 arch/powerpc/include/asm/qspinlock.h

diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
new file mode 100644
index 0000000..4c89256
--- /dev/null
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -0,0 +1,66 @@
+#ifndef _ASM_POWERPC_QSPINLOCK_H
+#define _ASM_POWERPC_QSPINLOCK_H
+
+#include <asm-generic/qspinlock_types.h>
+
+#define SPIN_THRESHOLD (1 << 15)
+#define queued_spin_unlock queued_spin_unlock
+#define queued_spin_is_locked queued_spin_is_locked
+#define queued_spin_unlock_wait queued_spin_unlock_wait
+
+extern void queued_spin_unlock_wait(struct qspinlock *lock);
+
+static inline u8 *__qspinlock_lock_byte(struct qspinlock *lock)
+{
+	return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
+}
+
+static inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	/* release semantics is required */
+	smp_store_release(__qspinlock_lock_byte(lock), 0);
+}
+
+static inline int queued_spin_is_locked(struct qspinlock *lock)
+{
+	smp_mb();
+	return atomic_read(&lock->val);
+}
+
+#include <asm-generic/qspinlock.h>
+
+/* we need override it as ppc has io_sync stuff */
+#undef arch_spin_trylock
+#undef arch_spin_lock
+#undef arch_spin_lock_flags
+#undef arch_spin_unlock
+#define arch_spin_trylock arch_spin_trylock
+#define arch_spin_lock arch_spin_lock
+#define arch_spin_lock_flags arch_spin_lock_flags
+#define arch_spin_unlock arch_spin_unlock
+
+static inline int arch_spin_trylock(arch_spinlock_t *lock)
+{
+	CLEAR_IO_SYNC;
+	return queued_spin_trylock(lock);
+}
+
+static inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	CLEAR_IO_SYNC;
+	queued_spin_lock(lock);
+}
+
+static inline
+void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
+{
+	CLEAR_IO_SYNC;
+	queued_spin_lock(lock);
+}
+
+static inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+	SYNC_IO;
+	queued_spin_unlock(lock);
+}
+#endif /* _ASM_POWERPC_QSPINLOCK_H */
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 8c1b913..954099e 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -60,6 +60,23 @@ static inline bool vcpu_is_preempted(int cpu)
 }
 #endif
 
+#if defined(CONFIG_PPC_SPLPAR)
+/* We only yield to the hypervisor if we are in shared processor mode */
+#define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
+extern void __spin_yield(arch_spinlock_t *lock);
+extern void __rw_yield(arch_rwlock_t *lock);
+#else /* SPLPAR */
+#define __spin_yield(x)        barrier()
+#define __rw_yield(x)  barrier()
+#define SHARED_PROCESSOR       0
+#endif
+
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm/qspinlock.h>
+#else
+
+#define arch_spin_relax(lock)  __spin_yield(lock)
+
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
 	return lock.slock == 0;
@@ -114,18 +131,6 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
  * held.  Conveniently, we have a word in the paca that holds this
  * value.
  */
-
-#if defined(CONFIG_PPC_SPLPAR)
-/* We only yield to the hypervisor if we are in shared processor mode */
-#define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
-extern void __spin_yield(arch_spinlock_t *lock);
-extern void __rw_yield(arch_rwlock_t *lock);
-#else /* SPLPAR */
-#define __spin_yield(x)	barrier()
-#define __rw_yield(x)	barrier()
-#define SHARED_PROCESSOR	0
-#endif
-
 static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	CLEAR_IO_SYNC;
@@ -203,6 +208,7 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
 	smp_mb();
 }
 
+#endif /* !CONFIG_QUEUED_SPINLOCKS */
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
@@ -338,7 +344,6 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
 
-#define arch_spin_relax(lock)	__spin_yield(lock)
 #define arch_read_relax(lock)	__rw_yield(lock)
 #define arch_write_relax(lock)	__rw_yield(lock)
 
diff --git a/arch/powerpc/include/asm/spinlock_types.h b/arch/powerpc/include/asm/spinlock_types.h
index 2351adc..bd7144e 100644
--- a/arch/powerpc/include/asm/spinlock_types.h
+++ b/arch/powerpc/include/asm/spinlock_types.h
@@ -5,11 +5,15 @@
 # error "please don't include this file directly"
 #endif
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm-generic/qspinlock_types.h>
+#else
 typedef struct {
 	volatile unsigned int slock;
 } arch_spinlock_t;
 
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+#endif
 
 typedef struct {
 	volatile signed int lock;
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index b7b1237..8f6dbb0 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -23,6 +23,7 @@
 #include <asm/hvcall.h>
 #include <asm/smp.h>
 
+#ifndef CONFIG_QUEUED_SPINLOCKS
 void __spin_yield(arch_spinlock_t *lock)
 {
 	unsigned int lock_value, holder_cpu, yield_count;
@@ -42,6 +43,7 @@ void __spin_yield(arch_spinlock_t *lock)
 		get_hard_smp_processor_id(holder_cpu), yield_count);
 }
 EXPORT_SYMBOL_GPL(__spin_yield);
+#endif
 
 /*
  * Waiting for a read lock or a write lock on a rwlock...
@@ -68,3 +70,63 @@ void __rw_yield(arch_rwlock_t *rw)
 		get_hard_smp_processor_id(holder_cpu), yield_count);
 }
 #endif
+
+#ifdef CONFIG_QUEUED_SPINLOCKS
+/*
+ * This forbid we load an old value in another LL/SC. Because the SC here force
+ * another LL/SC repeat. So we guarantee all loads in another LL and SC will
+ * read correct value.
+ */
+static inline u32 atomic_read_sync(atomic_t *v)
+{
+	u32 val;
+
+	__asm__ __volatile__(
+"1:	" PPC_LWARX(%0, 0, %2, 0) "\n"
+"	stwcx. %0, 0, %2\n"
+"	bne- 1b\n"
+	: "=&r" (val), "+m" (*v)
+	: "r" (v)
+	: "cr0", "xer");
+
+	return val;
+}
+
+void queued_spin_unlock_wait(struct qspinlock *lock)
+{
+
+	u32 val;
+
+	smp_mb();
+
+	/*
+	 * copied from generic queue_spin_unlock_wait with little modification
+	 */
+	for (;;) {
+		/* need _sync, as we might race with another LL/SC in lock()*/
+		val = atomic_read_sync(&lock->val);
+
+		if (!val) /* not locked, we're done */
+			goto done;
+
+		if (val & _Q_LOCKED_MASK) /* locked, go wait for unlock */
+			break;
+
+		/* not locked, but pending, wait until we observe the lock */
+		cpu_relax();
+	}
+
+	/*
+	 * any unlock is good.
+	 * And _sync() is not needed here, because once we got here, we must
+	 * already read the ->val as LOCKED via a _sync(). Combining the
+	 * smp_mb() before, we guarantee that all the memory accesses before
+	 * unlock_wait() must be observed by the next lock critical section.
+	 */
+	while (atomic_read(&lock->val) & _Q_LOCKED_MASK)
+		cpu_relax();
+done:
+	smp_mb();
+}
+EXPORT_SYMBOL(queued_spin_unlock_wait);
+#endif
-- 
2.4.11
