From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 19/20] x86/ticketlocks: use overlapping read to eliminate mb()
Date: Wed,  3 Nov 2010 11:00:00 -0400
Message-ID: <5cae33878054a27869fdaa20f1265226be9d8c1b.1288794124.git.jeremy.fitzhardinge__33686.223315499$1288797720$gmane$org@citrix.com>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
In-Reply-To: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
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
Cc: Nick Piggin <npiggin@suse.de>, Xen-devel <xen-devel@lists.xensource.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

When reading the 'waiting' counter, use a longer-than-necessary read
which also overlaps 'head'.  This read is guaranteed to be in-order
with respect to and unlock writes to 'head', thereby eliminating the
need for an explicit mb() to enforce the read-after-write ordering.

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
---
 arch/x86/include/asm/spinlock.h       |   14 +++++++-------
 arch/x86/include/asm/spinlock_types.h |   24 ++++++++++++++++++++----
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index c7455e1..a16b6e4 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -86,14 +86,14 @@ static inline void __ticket_sub_waiting(struct arch_spinlock *lock)
 
 static __always_inline bool __ticket_lock_waiters(const struct arch_spinlock *lock)
 {
-	/*
-	 * Make sure everyone sees the unlock write before we check the
-	 * waiting count.  The processor ordering doesn't guarantee this
-	 * because they're different memory locations.
+	/* 
+	 * lock->waiting_head is a union element which aliases both
+	 * 'waiting' and 'head'.  Since the memory access overlaps
+	 * 'head', the read is forced to be in-order with respect to
+	 * unlock writes to 'head', eliminating the need for an
+	 * explicit mb(). (Intel memory ordering rules.)
 	 */
-	mb();
-
-	return ACCESS_ONCE(lock->waiting) != 0;
+	return ((__ticket_t)ACCESS_ONCE(lock->waiting_head)) != 0;
 }
 #endif	/* CONFIG_PARAVIRT_SPINLOCKS */
 
diff --git a/arch/x86/include/asm/spinlock_types.h b/arch/x86/include/asm/spinlock_types.h
index def8010..307ef0b 100644
--- a/arch/x86/include/asm/spinlock_types.h
+++ b/arch/x86/include/asm/spinlock_types.h
@@ -18,6 +18,24 @@ typedef u32 __ticketpair_t;
 #define TICKET_SHIFT	(sizeof(__ticket_t) * 8)
 #define TICKET_MASK	((1 << TICKET_SHIFT) - 1)
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+typedef struct arch_spinlock {
+	union {
+		struct {
+			__ticket_t waiting;
+			union {
+				__ticketpair_t ticketpair;
+				struct __raw_tickets {
+					__ticket_t head, tail;
+				} tickets;
+			};
+		};
+		__ticketpair_t waiting_head; /* aliases waiting and head */
+	};
+} arch_spinlock_t;
+
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ { { 0, { 0 } } } }
+#else
 typedef struct arch_spinlock {
 	union {
 		__ticketpair_t ticketpair;
@@ -25,12 +43,10 @@ typedef struct arch_spinlock {
 			__ticket_t head, tail;
 		} tickets;
 	};
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-	__ticket_t waiting;
-#endif
 } arch_spinlock_t;
 
-#define __ARCH_SPIN_LOCK_UNLOCKED	{ { .tickets = {0, 0} } }
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
+#endif
 
 typedef struct {
 	unsigned int lock;
-- 
1.7.2.3
