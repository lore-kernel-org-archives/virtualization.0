From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 3/6] x86: introduce new pvops function clear_slowpath
Date: Thu, 30 Apr 2015 12:54:00 +0200
Message-ID: <1430391243-7112-4-git-send-email-jgross__15777.2308019505$1430453258$gmane$org@suse.com>
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

To speed up paravirtualized spinlock handling when running on bare
metal introduce a new pvops function "clear_slowpath". This is a nop
when the kernel is running on bare metal.

As the clear_slowpath function is common for all users add a new
initialization function to set the pvops function pointer in order
to avoid spreading the knowledge which function to use.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h       |  7 +++++++
 arch/x86/include/asm/paravirt_types.h |  1 +
 arch/x86/include/asm/spinlock.h       | 18 ++++--------------
 arch/x86/kernel/kvm.c                 |  2 ++
 arch/x86/kernel/paravirt-spinlocks.c  | 22 ++++++++++++++++++++++
 arch/x86/xen/spinlock.c               |  2 ++
 6 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 8957810..318f077 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -724,6 +724,13 @@ static __always_inline void __ticket_unlock_kick(struct arch_spinlock *lock,
 	PVOP_VCALL2(pv_lock_ops.unlock_kick, lock, ticket);
 }
 
+static __always_inline void __ticket_clear_slowpath(arch_spinlock_t *lock,
+						    __ticket_t head)
+{
+	PVOP_VCALL2(pv_lock_ops.clear_slowpath, lock, head);
+}
+
+void pv_lock_activate(void);
 #endif
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index f7b0b5c..3432713 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -336,6 +336,7 @@ typedef u16 __ticket_t;
 struct pv_lock_ops {
 	struct paravirt_callee_save lock_spinning;
 	void (*unlock_kick)(struct arch_spinlock *lock, __ticket_t ticket);
+	void (*clear_slowpath)(arch_spinlock_t *lock, __ticket_t head);
 };
 
 /* This contains all the paravirt structures: we get a convenient
diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 268b9da..ab76c3e 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -60,26 +60,16 @@ static inline void __ticket_unlock_kick(arch_spinlock_t *lock,
 {
 }
 
+static inline void __ticket_clear_slowpath(arch_spinlock_t *lock,
+					   __ticket_t head)
+{
+}
 #endif /* CONFIG_PARAVIRT_SPINLOCKS */
 static inline int  __tickets_equal(__ticket_t one, __ticket_t two)
 {
 	return !((one ^ two) & ~TICKET_SLOWPATH_FLAG);
 }
 
-static inline void __ticket_clear_slowpath(arch_spinlock_t *lock,
-					   __ticket_t head)
-{
-	arch_spinlock_t old, new;
-
-	old.tickets.head = head;
-	new.tickets.head = head & ~TICKET_SLOWPATH_FLAG;
-	old.tickets.tail = new.tickets.head + TICKET_LOCK_INC;
-	new.tickets.tail = old.tickets.tail;
-
-	/* try to clear slowpath flag when there are no contenders */
-	cmpxchg(&lock->head_tail, old.head_tail, new.head_tail);
-}
-
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
 	return __tickets_equal(lock.tickets.head, lock.tickets.tail);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 9435620..c3b4b43 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -830,6 +830,8 @@ void __init kvm_spinlock_init(void)
 
 	pv_lock_ops.lock_spinning = PV_CALLEE_SAVE(kvm_lock_spinning);
 	pv_lock_ops.unlock_kick = kvm_unlock_kick;
+
+	pv_lock_activate();
 }
 
 static __init int kvm_spinlock_init_jump(void)
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index bbb6c73..5ece813 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -8,10 +8,32 @@
 
 #include <asm/paravirt.h>
 
+#ifdef CONFIG_SMP
+static void pv_ticket_clear_slowpath(arch_spinlock_t *lock, __ticket_t head)
+{
+	arch_spinlock_t old, new;
+
+	old.tickets.head = head;
+	new.tickets.head = head & ~TICKET_SLOWPATH_FLAG;
+	old.tickets.tail = new.tickets.head + TICKET_LOCK_INC;
+	new.tickets.tail = old.tickets.tail;
+
+	/* try to clear slowpath flag when there are no contenders */
+	cmpxchg(&lock->head_tail, old.head_tail, new.head_tail);
+}
+
+void pv_lock_activate(void)
+{
+	pv_lock_ops.clear_slowpath = pv_ticket_clear_slowpath;
+}
+EXPORT_SYMBOL_GPL(pv_lock_activate);
+#endif
+
 struct pv_lock_ops pv_lock_ops = {
 #ifdef CONFIG_SMP
 	.lock_spinning = __PV_IS_CALLEE_SAVE(paravirt_nop),
 	.unlock_kick = paravirt_nop,
+	.clear_slowpath = paravirt_nop,
 #endif
 };
 EXPORT_SYMBOL(pv_lock_ops);
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 956374c..988c895 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -282,6 +282,8 @@ void __init xen_init_spinlocks(void)
 	printk(KERN_DEBUG "xen: PV spinlocks enabled\n");
 	pv_lock_ops.lock_spinning = PV_CALLEE_SAVE(xen_lock_spinning);
 	pv_lock_ops.unlock_kick = xen_unlock_kick;
+
+	pv_lock_activate();
 }
 
 /*
-- 
2.1.4
