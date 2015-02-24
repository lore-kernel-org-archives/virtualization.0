From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH for stable] x86/spinlocks/paravirt: Fix memory corruption on
	unlock
Date: Tue, 24 Feb 2015 14:54:59 +0530
Message-ID: <1424769899-14158-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc: jeremy@goop.org, raghavendra.kt@linux.vnet.ibm.com, kvm@vger.kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, borntraeger@de.ibm.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, dave@stgolabs.net, sasha.levin@oracle.com, davej@redhat.com, virtualization@lists.linux-foundation.org, waiman.long@hp.com, oleg@redhat.com, stable@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Paravirt spinlock clears slowpath flag after doing unlock.
As explained by Linus currently it does:
                prev = *lock;
                add_smp(&lock->tickets.head, TICKET_LOCK_INC);

                /* add_smp() is a full mb() */

                if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG))
                        __ticket_unlock_slowpath(lock, prev);

which is *exactly* the kind of things you cannot do with spinlocks,
because after you've done the "add_smp()" and released the spinlock
for the fast-path, you can't access the spinlock any more.  Exactly
because a fast-path lock might come in, and release the whole data
structure.

Linus suggested that we should not do any writes to lock after unlock(),
and we can move slowpath clearing to fastpath lock.

So this patch implements the fix with:
1. Moving slowpath flag to head (Oleg):
Unlocked locks don't care about the slowpath flag; therefore we can keep
it set after the last unlock, and clear it again on the first (try)lock.
-- this removes the write after unlock. note that keeping slowpath flag would
result in unnecessary kicks.
By moving the slowpath flag from the tail to the head ticket we also avoid
the need to access both the head and tail tickets on unlock.

2. use xadd to avoid read/write after unlock that checks the need for
unlock_kick (Linus):
We further avoid the need for a read-after-release by using xadd;
the prev head value will include the slowpath flag and indicate if we
need to do PV kicking of suspended spinners -- on modern chips xadd
isn't (much) more expensive than an add + load.

Result:
 setup: 16core (32 cpu +ht sandy bridge 8GB 16vcpu guest)
 benchmark overcommit %improve
 kernbench  1x           -0.13
 kernbench  2x            0.02
 dbench     1x           -1.77
 dbench     2x           -0.63

[Jeremy: hinted missing TICKET_LOCK_INC for kick]
[Oleg: Moving slowpath flag to head, ticket_equals idea]
[PeterZ: Detailed changelog]

Reported-by: Sasha Levin <sasha.levin@oracle.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: David Vrabel <david.vrabel@citrix.com>
---
 arch/x86/include/asm/spinlock.h | 94 ++++++++++++++++++++---------------------
 arch/x86/kernel/kvm.c           |  7 ++-
 arch/x86/xen/spinlock.c         |  7 ++-
 3 files changed, 58 insertions(+), 50 deletions(-)

Changes for stable:
  - Don't replace the ACCESS_ONCE to READ_ONCE which would cause horraneous
    Compiler warnings (Linus, David Vbriel, PeterZ, Ingo)

Changes since V4:
  - one more usage of tickets_equal() (Oleg)
  - head > tail situation can lead to false contended check (Oleg)
  - smp_mb__after_atomic() added after slowptha_enter (Oleg)

Changes since V3:
  - Detailed changelog (PeterZ)
  - Replace ACCESS_ONCE with READ_ONCE (oleg)
  - Add xen changes (Oleg)
  - Correct break logic in unlock_wait() (Oleg)

Changes since V2:
  - Move the slowpath flag to head, this enables xadd usage in unlock code
    and inturn we can get rid of read/write after  unlock (Oleg)
  - usage of ticket_equals (Oleg)

Changes since V1:
  - Add missing TICKET_LOCK_INC before unlock kick (fixes hang in overcommit: Jeremy).
  - Remove SLOWPATH_FLAG clearing in fast lock. (Jeremy)
  - clear SLOWPATH_FLAG in arch_spin_value_unlocked during comparison.

 Result:
 setup: 16core (32 cpu +ht sandy bridge 8GB 16vcpu guest)
base = 3_19_rc7

3_19_rc7_spinfix_v3
+-----------+-----------+-----------+------------+-----------+
     kernbench (Time taken in sec lower is better)
+-----------+-----------+-----------+------------+-----------+
     base       %stdev    patched      %stdev      %improve
+-----------+-----------+-----------+------------+-----------+
1x   54.2300     3.0652     54.3008     4.0366    -0.13056
2x   90.1883     5.5509     90.1650     6.4336     0.02583
+-----------+-----------+-----------+------------+-----------+
+-----------+-----------+-----------+------------+-----------+
    dbench (Throughput higher is better)
+-----------+-----------+-----------+------------+-----------+
     base       %stdev    patched      %stdev      %improve
+-----------+-----------+-----------+------------+-----------+
1x 7029.9188     2.5952   6905.0712     4.4737    -1.77595
2x 3254.2075    14.8291   3233.7137    26.8784    -0.62976
+-----------+-----------+-----------+------------+-----------+

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 625660f..cf87de3 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -46,7 +46,7 @@ static __always_inline bool static_key_false(struct static_key *key);
 
 static inline void __ticket_enter_slowpath(arch_spinlock_t *lock)
 {
-	set_bit(0, (volatile unsigned long *)&lock->tickets.tail);
+	set_bit(0, (volatile unsigned long *)&lock->tickets.head);
 }
 
 #else  /* !CONFIG_PARAVIRT_SPINLOCKS */
@@ -60,10 +60,30 @@ static inline void __ticket_unlock_kick(arch_spinlock_t *lock,
 }
 
 #endif /* CONFIG_PARAVIRT_SPINLOCKS */
+static inline int  __tickets_equal(__ticket_t one, __ticket_t two)
+{
+	return !((one ^ two) & ~TICKET_SLOWPATH_FLAG);
+}
+
+static inline void __ticket_check_and_clear_slowpath(arch_spinlock_t *lock,
+							__ticket_t head)
+{
+	if (head & TICKET_SLOWPATH_FLAG) {
+		arch_spinlock_t old, new;
+
+		old.tickets.head = head;
+		new.tickets.head = head & ~TICKET_SLOWPATH_FLAG;
+		old.tickets.tail = new.tickets.head + TICKET_LOCK_INC;
+		new.tickets.tail = old.tickets.tail;
+
+		/* try to clear slowpath flag when there are no contenders */
+		cmpxchg(&lock->head_tail, old.head_tail, new.head_tail);
+	}
+}
 
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
-	return lock.tickets.head == lock.tickets.tail;
+	return __tickets_equal(lock.tickets.head, lock.tickets.tail);
 }
 
 /*
@@ -87,18 +107,21 @@ static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
 	if (likely(inc.head == inc.tail))
 		goto out;
 
-	inc.tail &= ~TICKET_SLOWPATH_FLAG;
 	for (;;) {
 		unsigned count = SPIN_THRESHOLD;
 
 		do {
-			if (READ_ONCE(lock->tickets.head) == inc.tail)
-				goto out;
+			inc.head = READ_ONCE(lock->tickets.head);
+			if (__tickets_equal(inc.head, inc.tail))
+				goto clear_slowpath;
 			cpu_relax();
 		} while (--count);
 		__ticket_lock_spinning(lock, inc.tail);
 	}
-out:	barrier();	/* make sure nothing creeps before the lock is taken */
+clear_slowpath:
+	__ticket_check_and_clear_slowpath(lock, inc.head);
+out:
+	barrier();	/* make sure nothing creeps before the lock is taken */
 }
 
 static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
@@ -106,56 +129,30 @@ static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
 	arch_spinlock_t old, new;
 
 	old.tickets = READ_ONCE(lock->tickets);
-	if (old.tickets.head != (old.tickets.tail & ~TICKET_SLOWPATH_FLAG))
+	if (!__tickets_equal(old.tickets.head, old.tickets.tail))
 		return 0;
 
 	new.head_tail = old.head_tail + (TICKET_LOCK_INC << TICKET_SHIFT);
+	new.head_tail &= ~TICKET_SLOWPATH_FLAG;
 
 	/* cmpxchg is a full barrier, so nothing can move before it */
 	return cmpxchg(&lock->head_tail, old.head_tail, new.head_tail) == old.head_tail;
 }
 
-static inline void __ticket_unlock_slowpath(arch_spinlock_t *lock,
-					    arch_spinlock_t old)
-{
-	arch_spinlock_t new;
-
-	BUILD_BUG_ON(((__ticket_t)NR_CPUS) != NR_CPUS);
-
-	/* Perform the unlock on the "before" copy */
-	old.tickets.head += TICKET_LOCK_INC;
-
-	/* Clear the slowpath flag */
-	new.head_tail = old.head_tail & ~(TICKET_SLOWPATH_FLAG << TICKET_SHIFT);
-
-	/*
-	 * If the lock is uncontended, clear the flag - use cmpxchg in
-	 * case it changes behind our back though.
-	 */
-	if (new.tickets.head != new.tickets.tail ||
-	    cmpxchg(&lock->head_tail, old.head_tail,
-					new.head_tail) != old.head_tail) {
-		/*
-		 * Lock still has someone queued for it, so wake up an
-		 * appropriate waiter.
-		 */
-		__ticket_unlock_kick(lock, old.tickets.head);
-	}
-}
-
 static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	if (TICKET_SLOWPATH_FLAG &&
-	    static_key_false(&paravirt_ticketlocks_enabled)) {
-		arch_spinlock_t prev;
+		static_key_false(&paravirt_ticketlocks_enabled)) {
+		__ticket_t head;
 
-		prev = *lock;
-		add_smp(&lock->tickets.head, TICKET_LOCK_INC);
+		BUILD_BUG_ON(((__ticket_t)NR_CPUS) != NR_CPUS);
 
-		/* add_smp() is a full mb() */
+		head = xadd(&lock->tickets.head, TICKET_LOCK_INC);
 
-		if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG))
-			__ticket_unlock_slowpath(lock, prev);
+		if (unlikely(head & TICKET_SLOWPATH_FLAG)) {
+			head &= ~TICKET_SLOWPATH_FLAG;
+			__ticket_unlock_kick(lock, (head + TICKET_LOCK_INC));
+		}
 	} else
 		__add(&lock->tickets.head, TICKET_LOCK_INC, UNLOCK_LOCK_PREFIX);
 }
@@ -164,14 +161,15 @@ static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
 	struct __raw_tickets tmp = READ_ONCE(lock->tickets);
 
-	return tmp.tail != tmp.head;
+	return !__tickets_equal(tmp.tail, tmp.head);
 }
 
 static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 {
 	struct __raw_tickets tmp = READ_ONCE(lock->tickets);
 
-	return (__ticket_t)(tmp.tail - tmp.head) > TICKET_LOCK_INC;
+	tmp.head &= ~TICKET_SLOWPATH_FLAG;
+	return (tmp.tail - tmp.head) > TICKET_LOCK_INC;
 }
 #define arch_spin_is_contended	arch_spin_is_contended
 
@@ -183,16 +181,16 @@ static __always_inline void arch_spin_lock_flags(arch_spinlock_t *lock,
 
 static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
 {
-	__ticket_t head = ACCESS_ONCE(lock->tickets.head);
+	__ticket_t head = READ_ONCE(lock->tickets.head);
 
 	for (;;) {
-		struct __raw_tickets tmp = ACCESS_ONCE(lock->tickets);
+		struct __raw_tickets tmp = READ_ONCE(lock->tickets);
 		/*
 		 * We need to check "unlocked" in a loop, tmp.head == head
 		 * can be false positive because of overflow.
 		 */
-		if (tmp.head == (tmp.tail & ~TICKET_SLOWPATH_FLAG) ||
-		    tmp.head != head)
+		if (__tickets_equal(tmp.head, tmp.tail) ||
+				!__tickets_equal(tmp.head, head))
 			break;
 
 		cpu_relax();
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 94f6434..c9ccfcf 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -727,6 +727,7 @@ __visible void kvm_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
 	int cpu;
 	u64 start;
 	unsigned long flags;
+	__ticket_t head;
 
 	if (in_nmi())
 		return;
@@ -768,11 +769,15 @@ __visible void kvm_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
 	 */
 	__ticket_enter_slowpath(lock);
 
+	/* make sure enter_slowpath, which is atomic does not cross the read */
+	smp_mb__after_atomic();
+
 	/*
 	 * check again make sure it didn't become free while
 	 * we weren't looking.
 	 */
-	if (ACCESS_ONCE(lock->tickets.head) == want) {
+	head = READ_ONCE(lock->tickets.head);
+	if (__tickets_equal(head, want)) {
 		add_stats(TAKEN_SLOW_PICKUP, 1);
 		goto out;
 	}
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 23b45eb..4ab725c 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -112,6 +112,7 @@ __visible void xen_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
 	struct xen_lock_waiting *w = this_cpu_ptr(&lock_waiting);
 	int cpu = smp_processor_id();
 	u64 start;
+	__ticket_t head;
 	unsigned long flags;
 
 	/* If kicker interrupts not initialized yet, just spin */
@@ -159,11 +160,15 @@ __visible void xen_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
 	 */
 	__ticket_enter_slowpath(lock);
 
+	/* make sure enter_slowpath, which is atomic does not cross the read */
+	smp_mb__after_atomic();
+
 	/*
 	 * check again make sure it didn't become free while
 	 * we weren't looking
 	 */
-	if (ACCESS_ONCE(lock->tickets.head) == want) {
+	head = READ_ONCE(lock->tickets.head);
+	if (__tickets_equal(head, want)) {
 		add_stats(TAKEN_SLOW_PICKUP, 1);
 		goto out;
 	}
-- 
1.7.11.7
