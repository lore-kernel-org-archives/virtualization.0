From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH RFC 2/4] paravirt: introduce a "lock-byte" spinlock
	implementation
Date: Mon, 07 Jul 2008 12:07:51 -0700
Message-ID: <20080707190838.502036239__34677.3398844109$1215458494$gmane$org@goop.org>
References: <20080707190749.299430659@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=paravirt-byte-spinlock.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jens Axboe <axboe@kernel.dk>, Xen devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Lameter <clameter@linux-foundation.org>, Petr Tesarik <ptesarik@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Thomas Friebel <thomas.friebel@amd.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Implement a version of the old spinlock algorithm, in which everyone
spins waiting for a lock byte.  In order to be compatible with the
ticket-lock's use of a zero initializer, this uses the convention of
'0' for unlocked and '1' for locked.

This algorithm is much better than ticket locks in a virtual
envionment, because it doesn't interact badly with the vcpu scheduler.
If there are multiple vcpus spinning on a lock and the lock is
released, the next vcpu to be scheduled will take the lock, rather
than cycling around until the next ticketed vcpu gets it.

To use this, you must call paravirt_use_bytelocks() very early, before
any spinlocks have been taken.

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Thomas Friebel <thomas.friebel@amd.com>
---
 arch/x86/kernel/paravirt.c |    9 ++++++
 include/asm-x86/paravirt.h |    2 +
 include/asm-x86/spinlock.h |   65 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 75 insertions(+), 1 deletion(-)

===================================================================
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -269,6 +269,15 @@
 	return __get_cpu_var(paravirt_lazy_mode);
 }
 
+void __init paravirt_use_bytelocks(void)
+{
+	pv_lock_ops.spin_is_locked = __byte_spin_is_locked;
+	pv_lock_ops.spin_is_contended = __byte_spin_is_contended;
+	pv_lock_ops.spin_lock = __byte_spin_lock;
+	pv_lock_ops.spin_trylock = __byte_spin_trylock;
+	pv_lock_ops.spin_unlock = __byte_spin_unlock;
+}
+
 struct pv_info pv_info = {
 	.name = "bare hardware",
 	.paravirt_enabled = 0,
===================================================================
--- a/include/asm-x86/paravirt.h
+++ b/include/asm-x86/paravirt.h
@@ -1388,6 +1388,8 @@
 void _paravirt_nop(void);
 #define paravirt_nop	((void *)_paravirt_nop)
 
+void paravirt_use_bytelocks(void);
+
 static inline int __raw_spin_is_locked(struct raw_spinlock *lock)
 {
 	return PVOP_CALL1(int, pv_lock_ops.spin_is_locked, lock);
===================================================================
--- a/include/asm-x86/spinlock.h
+++ b/include/asm-x86/spinlock.h
@@ -184,7 +184,70 @@
 
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
 
-#ifndef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT
+/*
+ * Define virtualization-friendly old-style lock byte lock, for use in
+ * pv_lock_ops if desired.
+ *
+ * This differs from the pre-2.6.24 spinlock by always using xchgb
+ * rather than decb to take the lock; this allows it to use a
+ * zero-initialized lock structure.  It also maintains a 1-byte
+ * contention counter, so that we can implement
+ * __byte_spin_is_contended.
+ */
+struct __byte_spinlock {
+	s8 lock;
+	s8 spinners;
+};
+
+static inline int __byte_spin_is_locked(raw_spinlock_t *lock)
+{
+	struct __byte_spinlock *bl = (struct __byte_spinlock *)lock;
+	return bl->lock != 0;
+}
+
+static inline int __byte_spin_is_contended(raw_spinlock_t *lock)
+{
+	struct __byte_spinlock *bl = (struct __byte_spinlock *)lock;
+	return bl->spinners != 0;
+}
+
+static inline void __byte_spin_lock(raw_spinlock_t *lock)
+{
+	struct __byte_spinlock *bl = (struct __byte_spinlock *)lock;
+	s8 val = 1;
+
+	asm("1: xchgb %1, %0\n"
+	    "   test %1,%1\n"
+	    "   jz 3f\n"
+	    "   " LOCK_PREFIX "incb %2\n"
+	    "2: rep;nop\n"
+	    "   cmpb $1, %0\n"
+	    "   je 2b\n"
+	    "   " LOCK_PREFIX "decb %2\n"
+	    "   jmp 1b\n"
+	    "3:"
+	    : "+m" (bl->lock), "+q" (val), "+m" (bl->spinners): : "memory");
+}
+
+static inline int __byte_spin_trylock(raw_spinlock_t *lock)
+{
+	struct __byte_spinlock *bl = (struct __byte_spinlock *)lock;
+	u8 old = 1;
+
+	asm("xchgb %1,%0"
+	    : "+m" (bl->lock), "+q" (old) : : "memory");
+
+	return old == 0;
+}
+
+static inline void __byte_spin_unlock(raw_spinlock_t *lock)
+{
+	struct __byte_spinlock *bl = (struct __byte_spinlock *)lock;
+	smp_wmb();
+	bl->lock = 0;
+}
+#else  /* !CONFIG_PARAVIRT */
 static inline int __raw_spin_is_locked(raw_spinlock_t *lock)
 {
 	return __ticket_spin_is_locked(lock);

-- 
