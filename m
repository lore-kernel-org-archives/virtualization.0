From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH] x86 spinlock: Fix memory corruption on completing completions
Date: Fri,  6 Feb 2015 20:19:08 +0530
Message-ID: <1423234148-13886-1-git-send-email-raghavendra.kt__25580.5922359743$1423234683$gmane$org@linux.vnet.ibm.com>
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
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, torvalds@linux-foundation.org
Cc: waiman.long@hp.com, jeremy@goop.org, ak@linux.intel.com, a.ryabinin@samsung.com, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, konrad.wilk@oracle.com, riel@redhat.com, x86@kernel.org, oleg@redhat.com, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, raghavendra.kt@linux.vnet.ibm.com, davej@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, sasha.levin@oracle.com
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

However it brings additional case to be handled, viz., slowpath still
could be set when somebody does arch_trylock. Handle that too by ignoring
slowpath flag during lock availability check.

Reported-by: Sasha Levin <sasha.levin@oracle.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/x86/include/asm/spinlock.h | 70 ++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 625660f..0829f86 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -49,6 +49,23 @@ static inline void __ticket_enter_slowpath(arch_spinlock_t *lock)
 	set_bit(0, (volatile unsigned long *)&lock->tickets.tail);
 }
 
+static inline void __ticket_check_and_clear_slowpath(arch_spinlock_t *lock)
+{
+	arch_spinlock_t old, new;
+	__ticket_t diff;
+
+	old.tickets = READ_ONCE(lock->tickets);
+	diff = (old.tickets.tail & ~TICKET_SLOWPATH_FLAG) - old.tickets.head;
+
+	/* try to clear slowpath flag when there are no contenders */
+	if ((old.tickets.tail & TICKET_SLOWPATH_FLAG) &&
+		(diff == TICKET_LOCK_INC)) {
+		new = old;
+		new.tickets.tail &= ~TICKET_SLOWPATH_FLAG;
+		cmpxchg(&lock->head_tail, old.head_tail, new.head_tail);
+	}
+}
+
 #else  /* !CONFIG_PARAVIRT_SPINLOCKS */
 static __always_inline void __ticket_lock_spinning(arch_spinlock_t *lock,
 							__ticket_t ticket)
@@ -59,6 +76,10 @@ static inline void __ticket_unlock_kick(arch_spinlock_t *lock,
 {
 }
 
+static inline void __ticket_check_and_clear_slowpath(arch_spinlock_t *lock)
+{
+}
+
 #endif /* CONFIG_PARAVIRT_SPINLOCKS */
 
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
@@ -84,7 +105,7 @@ static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
 	register struct __raw_tickets inc = { .tail = TICKET_LOCK_INC };
 
 	inc = xadd(&lock->tickets, inc);
-	if (likely(inc.head == inc.tail))
+	if (likely(inc.head == (inc.tail & ~TICKET_SLOWPATH_FLAG)))
 		goto out;
 
 	inc.tail &= ~TICKET_SLOWPATH_FLAG;
@@ -98,7 +119,10 @@ static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
 		} while (--count);
 		__ticket_lock_spinning(lock, inc.tail);
 	}
-out:	barrier();	/* make sure nothing creeps before the lock is taken */
+out:
+	__ticket_check_and_clear_slowpath(lock);
+
+	barrier();	/* make sure nothing creeps before the lock is taken */
 }
 
 static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
@@ -115,47 +139,21 @@ static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
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
+		__ticket_t prev_head;
 
-		prev = *lock;
+		prev_head = lock->tickets.head;
 		add_smp(&lock->tickets.head, TICKET_LOCK_INC);
 
 		/* add_smp() is a full mb() */
 
-		if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG))
-			__ticket_unlock_slowpath(lock, prev);
+		if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG)) {
+			BUILD_BUG_ON(((__ticket_t)NR_CPUS) != NR_CPUS);
+			__ticket_unlock_kick(lock, prev_head);
+		}
 	} else
 		__add(&lock->tickets.head, TICKET_LOCK_INC, UNLOCK_LOCK_PREFIX);
 }
@@ -164,7 +162,7 @@ static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
 	struct __raw_tickets tmp = READ_ONCE(lock->tickets);
 
-	return tmp.tail != tmp.head;
+	return (tmp.tail & ~TICKET_SLOWPATH_FLAG) != tmp.head;
 }
 
 static inline int arch_spin_is_contended(arch_spinlock_t *lock)
-- 
1.7.11.7
