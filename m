From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 2/6] x86: move decision about clearing slowpath flag into
	arch_spin_lock()
Date: Thu, 30 Apr 2015 12:53:59 +0200
Message-ID: <1430391243-7112-3-git-send-email-jgross__11447.2438618124$1430453279$gmane$org@suse.com>
References: <1430391243-7112-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1430391243-7112-1-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com, jeremy@goop.org, chrisw@sous-sol.org, akataria@vmware.com, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, gleb@kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

The decision whether the slowpath flag is to be cleared for
paravirtualized spinlocks is located in
__ticket_check_and_clear_slowpath() today.

Move that decision into arch_spin_lock() and add an unlikely attribute
to it to avoid calling a function in case the compiler chooses not to
inline __ticket_check_and_clear_slowpath() and the slowpath flag isn't
set.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/spinlock.h | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 8ceec8d..268b9da 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -66,20 +66,18 @@ static inline int  __tickets_equal(__ticket_t one, __ticket_t two)
 	return !((one ^ two) & ~TICKET_SLOWPATH_FLAG);
 }
 
-static inline void __ticket_check_and_clear_slowpath(arch_spinlock_t *lock,
-							__ticket_t head)
+static inline void __ticket_clear_slowpath(arch_spinlock_t *lock,
+					   __ticket_t head)
 {
-	if (head & TICKET_SLOWPATH_FLAG) {
-		arch_spinlock_t old, new;
+	arch_spinlock_t old, new;
 
-		old.tickets.head = head;
-		new.tickets.head = head & ~TICKET_SLOWPATH_FLAG;
-		old.tickets.tail = new.tickets.head + TICKET_LOCK_INC;
-		new.tickets.tail = old.tickets.tail;
+	old.tickets.head = head;
+	new.tickets.head = head & ~TICKET_SLOWPATH_FLAG;
+	old.tickets.tail = new.tickets.head + TICKET_LOCK_INC;
+	new.tickets.tail = old.tickets.tail;
 
-		/* try to clear slowpath flag when there are no contenders */
-		cmpxchg(&lock->head_tail, old.head_tail, new.head_tail);
-	}
+	/* try to clear slowpath flag when there are no contenders */
+	cmpxchg(&lock->head_tail, old.head_tail, new.head_tail);
 }
 
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
@@ -120,7 +118,8 @@ static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
 		__ticket_lock_spinning(lock, inc.tail);
 	}
 clear_slowpath:
-	__ticket_check_and_clear_slowpath(lock, inc.head);
+	if (unlikely(inc.head & TICKET_SLOWPATH_FLAG))
+		__ticket_clear_slowpath(lock, inc.head);
 out:
 	barrier();	/* make sure nothing creeps before the lock is taken */
 }
-- 
2.1.4
