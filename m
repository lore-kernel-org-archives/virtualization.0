From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 12/14] x86/ticketlocks: when paravirtualizing ticket locks,
	increment by 2
Date: Tue, 16 Nov 2010 13:08:43 -0800
Message-ID: <75f11d2bdabf99a17811e8b352595d69d19be3db.1289940821.git.jeremy.fitzhardinge__9719.34799240462$1289944557$gmane$org@citrix.com>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
In-Reply-To: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Eric Dumazet <dada1@cosmosbay.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?q?Am=C3=A9rico=20Wang?= <xiyou.wangcong@gmail.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

Increment ticket head/tails by 2 rather than 1 to leave the LSB free
to store a "is in slowpath state" bit.  This halves the number
of possible CPUs for a given ticket size, but this shouldn't matter
in practice - kernels built for 32k+ CPU systems are probably
specially built for the hardware rather than a generic distro
kernel.

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
---
 arch/x86/include/asm/spinlock.h       |   18 +++++++++---------
 arch/x86/include/asm/spinlock_types.h |   10 +++++++++-
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index cfa80b5..9e1c7ce 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -36,17 +36,17 @@
 static __always_inline void __ticket_unlock_release(struct arch_spinlock *lock)
 {
 	if (sizeof(lock->tickets.head) == sizeof(u8))
-		asm (LOCK_PREFIX "incb %0"
-		     : "+m" (lock->tickets.head) : : "memory");
+		asm (LOCK_PREFIX "addb %1, %0"
+		     : "+m" (lock->tickets.head) : "i" (TICKET_LOCK_INC) : "memory");
 	else
-		asm (LOCK_PREFIX "incw %0"
-		     : "+m" (lock->tickets.head) : : "memory");
+		asm (LOCK_PREFIX "addw %1, %0"
+		     : "+m" (lock->tickets.head) : "i" (TICKET_LOCK_INC) : "memory");
 
 }
 #else
 static __always_inline void __ticket_unlock_release(struct arch_spinlock *lock)
 {
-	lock->tickets.head++;
+	lock->tickets.head += TICKET_LOCK_INC;
 }
 #endif
 
@@ -84,7 +84,7 @@ static __always_inline void ____ticket_unlock_kick(struct arch_spinlock *lock, u
  */
 static __always_inline struct __raw_tickets __ticket_spin_claim(struct arch_spinlock *lock)
 {
-	register struct __raw_tickets tickets = { .tail = 1 };
+	register struct __raw_tickets tickets = { .tail = TICKET_LOCK_INC };
 
 	if (sizeof(lock->tickets.head) == sizeof(u8))
 		asm volatile (LOCK_PREFIX "xaddw %w0, %1\n"
@@ -136,7 +136,7 @@ static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
 	if (old.tickets.head != old.tickets.tail)
 		return 0;
 
-	new.head_tail = old.head_tail + (1 << TICKET_SHIFT);
+	new.head_tail = old.head_tail + (TICKET_LOCK_INC << TICKET_SHIFT);
 
 	/* cmpxchg is a full barrier, so nothing can move before it */
 	return cmpxchg(&lock->head_tail, old.head_tail, new.head_tail) == old.head_tail;
@@ -144,7 +144,7 @@ static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
 
 static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
-	__ticket_t next = lock->tickets.head + 1;
+	__ticket_t next = lock->tickets.head + TICKET_LOCK_INC;
 	__ticket_unlock_release(lock);
 	__ticket_unlock_kick(lock, next);
 	barrier();		/* prevent reordering into locked region */
@@ -161,7 +161,7 @@ static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 {
 	struct __raw_tickets tmp = ACCESS_ONCE(lock->tickets);
 
-	return ((tmp.tail - tmp.head) & TICKET_MASK) > 1;
+	return ((tmp.tail - tmp.head) & TICKET_MASK) > TICKET_LOCK_INC;
 }
 #define arch_spin_is_contended	arch_spin_is_contended
 
diff --git a/arch/x86/include/asm/spinlock_types.h b/arch/x86/include/asm/spinlock_types.h
index 72e154e..0553c0b 100644
--- a/arch/x86/include/asm/spinlock_types.h
+++ b/arch/x86/include/asm/spinlock_types.h
@@ -7,7 +7,13 @@
 
 #include <linux/types.h>
 
-#if (CONFIG_NR_CPUS < 256)
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#define __TICKET_LOCK_INC	2
+#else
+#define __TICKET_LOCK_INC	1
+#endif
+
+#if (CONFIG_NR_CPUS < (256 / __TICKET_LOCK_INC))
 typedef u8  __ticket_t;
 typedef u16 __ticketpair_t;
 #else
@@ -15,6 +21,8 @@ typedef u16 __ticket_t;
 typedef u32 __ticketpair_t;
 #endif
 
+#define TICKET_LOCK_INC	((__ticket_t)__TICKET_LOCK_INC)
+
 #define TICKET_SHIFT	(sizeof(__ticket_t) * 8)
 #define TICKET_MASK	((__ticket_t)((1 << TICKET_SHIFT) - 1))
 
-- 
1.7.2.3
