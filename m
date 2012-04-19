From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC V7 11/12] xen/pvticketlock: allow interrupts to be enabled
	while blocking
Date: Fri, 20 Apr 2012 01:46:34 +0530
Message-ID: <20120419201631.5411.15263.sendpatchset__10008.7925013669$1334866656$gmane$org@codeblue>
References: <20120419201209.5411.43877.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120419201209.5411.43877.sendpatchset@codeblue>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
Cc: Andrew Jones <drjones@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Attilio Rao <attilio.rao@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

If interrupts were enabled when taking the spinlock, we can leave them
enabled while blocking to get the lock.

If we can enable interrupts while waiting for the lock to become
available, and we take an interrupt before entering the poll,
and the handler takes a spinlock which ends up going into
the slow state (invalidating the per-cpu "lock" and "want" values),
then when the interrupt handler returns the event channel will
remain pending so the poll will return immediately, causing it to
return out to the main spinlock loop.

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/x86/xen/spinlock.c |   46 ++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 40 insertions(+), 6 deletions(-)
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index e2f312f..d2ab57a 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -142,7 +142,20 @@ static void xen_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
 	 * partially setup state.
 	 */
 	local_irq_save(flags);
-
+	/*
+	 * We don't really care if we're overwriting some other
+	 * (lock,want) pair, as that would mean that we're currently
+	 * in an interrupt context, and the outer context had
+	 * interrupts enabled.  That has already kicked the VCPU out
+	 * of xen_poll_irq(), so it will just return spuriously and
+	 * retry with newly setup (lock,want).
+	 *
+	 * The ordering protocol on this is that the "lock" pointer
+	 * may only be set non-NULL if the "want" ticket is correct.
+	 * If we're updating "want", we must first clear "lock".
+	 */
+	w->lock = NULL;
+	smp_wmb();
 	w->want = want;
 	smp_wmb();
 	w->lock = lock;
@@ -157,24 +170,43 @@ static void xen_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
 	/* Only check lock once pending cleared */
 	barrier();
 
-	/* Mark entry to slowpath before doing the pickup test to make
-	   sure we don't deadlock with an unlocker. */
+	/*
+	 * Mark entry to slowpath before doing the pickup test to make
+	 * sure we don't deadlock with an unlocker.
+	 */
 	__ticket_enter_slowpath(lock);
 
-	/* check again make sure it didn't become free while
-	   we weren't looking  */
+	/*
+	 * check again make sure it didn't become free while
+	 * we weren't looking
+	 */
 	if (ACCESS_ONCE(lock->tickets.head) == want) {
 		add_stats(TAKEN_SLOW_PICKUP, 1);
 		goto out;
 	}
+
+	/* Allow interrupts while blocked */
+	local_irq_restore(flags);
+
+	/*
+	 * If an interrupt happens here, it will leave the wakeup irq
+	 * pending, which will cause xen_poll_irq() to return
+	 * immediately.
+	 */
+
 	/* Block until irq becomes pending (or perhaps a spurious wakeup) */
 	xen_poll_irq(irq);
 	add_stats(TAKEN_SLOW_SPURIOUS, !xen_test_irq_pending(irq));
+
+	local_irq_save(flags);
+
 	kstat_incr_irqs_this_cpu(irq, irq_to_desc(irq));
 out:
 	cpumask_clear_cpu(cpu, &waiting_cpus);
 	w->lock = NULL;
+
 	local_irq_restore(flags);
+
 	spin_time_accum_blocked(start);
 }
 PV_CALLEE_SAVE_REGS_THUNK(xen_lock_spinning);
@@ -188,7 +220,9 @@ static void xen_unlock_kick(struct arch_spinlock *lock, __ticket_t next)
 	for_each_cpu(cpu, &waiting_cpus) {
 		const struct xen_lock_waiting *w = &per_cpu(lock_waiting, cpu);
 
-		if (w->lock == lock && w->want == next) {
+		/* Make sure we read lock before want */
+		if (ACCESS_ONCE(w->lock) == lock &&
+		    ACCESS_ONCE(w->want) == next) {
 			add_stats(RELEASED_SLOW_KICKED, 1);
 			xen_send_IPI_one(cpu, XEN_SPIN_UNLOCK_VECTOR);
 			break;
