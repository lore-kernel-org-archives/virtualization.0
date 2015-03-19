From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH 0/9] qspinlock stuff -v15
Date: Thu, 19 Mar 2015 18:01:34 +0000
Message-ID: <550B0EFE.1040309__22283.3320418887$1426788126$gmane$org@citrix.com>
References: <20150316131613.720617163@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150316131613.720617163@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>, Waiman.Long@hp.com
Cc: linux-arch@vger.kernel.org, riel@redhat.com, x86@kernel.org, kvm@vger.kernel.org, oleg@redhat.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, doug.hatch@hp.com, hpa@zytor.com, luto@amacapital.net, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, tglx@linutronix.de, david.vrabel@citrix.com
List-Id: virtualization@lists.linuxfoundation.org

On 16/03/15 13:16, Peter Zijlstra wrote:
> 
> I feel that if someone were to do a Xen patch we can go ahead and merge this
> stuff (finally!).

This seems work for me, but I've not got time to give it a more thorough
testing.

You can fold this into your series.

There doesn't seem to be a way to disable QUEUE_SPINLOCKS when supported by
the arch, is this intentional?  If so, the existing ticketlock code could go.

David

8<------------------------------
x86/xen: paravirt support for qspinlocks

Provide the wait and kick ops necessary for paravirt-aware queue
spinlocks.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 arch/x86/xen/spinlock.c |   40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 956374c..b019b2a 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -95,17 +95,43 @@ static inline void spin_time_accum_blocked(u64 start)
 }
 #endif  /* CONFIG_XEN_DEBUG_FS */
 
+static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
+static DEFINE_PER_CPU(char *, irq_name);
+static bool xen_pvspin = true;
+
+#ifdef CONFIG_QUEUE_SPINLOCK
+
+#include <asm/qspinlock.h>
+
+PV_CALLEE_SAVE_REGS_THUNK(__pv_queue_spin_unlock);
+
+static void xen_qlock_wait(u8 *ptr, u8 val)
+{
+	int irq = __this_cpu_read(lock_kicker_irq);
+
+	xen_clear_irq_pending(irq);
+
+	barrier();
+
+	if (READ_ONCE(*ptr) == val)
+		xen_poll_irq(irq);
+}
+
+static void xen_qlock_kick(int cpu)
+{
+	xen_send_IPI_one(cpu, XEN_SPIN_UNLOCK_VECTOR);
+}
+
+#else
+
 struct xen_lock_waiting {
 	struct arch_spinlock *lock;
 	__ticket_t want;
 };
 
-static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
-static DEFINE_PER_CPU(char *, irq_name);
 static DEFINE_PER_CPU(struct xen_lock_waiting, lock_waiting);
 static cpumask_t waiting_cpus;
 
-static bool xen_pvspin = true;
 __visible void xen_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
 {
 	int irq = __this_cpu_read(lock_kicker_irq);
@@ -217,6 +243,7 @@ static void xen_unlock_kick(struct arch_spinlock *lock, __ticket_t next)
 		}
 	}
 }
+#endif /* !QUEUE_SPINLOCK */
 
 static irqreturn_t dummy_handler(int irq, void *dev_id)
 {
@@ -280,8 +307,15 @@ void __init xen_init_spinlocks(void)
 		return;
 	}
 	printk(KERN_DEBUG "xen: PV spinlocks enabled\n");
+#ifdef CONFIG_QUEUE_SPINLOCK
+	pv_lock_ops.queue_spin_lock_slowpath = __pv_queue_spin_lock_slowpath;
+	pv_lock_ops.queue_spin_unlock = PV_CALLEE_SAVE(__pv_queue_spin_unlock);
+	pv_lock_ops.wait = xen_qlock_wait;
+	pv_lock_ops.kick = xen_qlock_kick;
+#else
 	pv_lock_ops.lock_spinning = PV_CALLEE_SAVE(xen_lock_spinning);
 	pv_lock_ops.unlock_kick = xen_unlock_kick;
+#endif
 }
 
 /*
-- 
1.7.10.4
