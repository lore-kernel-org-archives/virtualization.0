From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 06/11] qspinlock: Optimize pending bit
Date: Sun, 15 Jun 2014 14:47:03 +0200
Message-ID: <20140615130153.638054585__38776.8593304374$1402837975$gmane$org@chello.nl>
References: <20140615124657.264658593@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=peterz-prolong-pending.patch
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman.Long@hp.com, tglx@linutronix.de, mingo@kernel.org
Cc: linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

XXX: merge into the pending bit patch..

It is possible so observe the pending bit without the locked bit when
the last owner has just released but the pending owner has not yet
taken ownership.

In this case we would normally queue -- because the pending bit is
already taken. However, in this case the pending bit is guaranteed to
be released 'soon', therefore wait for it and avoid queueing.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/qspinlock.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-2.6/kernel/locking/qspinlock.c
===================================================================
--- linux-2.6.orig/kernel/locking/qspinlock.c
+++ linux-2.6/kernel/locking/qspinlock.c
@@ -226,6 +226,16 @@ void queue_spin_lock_slowpath(struct qsp
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
 	/*
+	 * wait for in-progress pending->locked hand-overs
+	 *
+	 * 0,1,0 -> 0,0,1
+	 */
+	if (val == _Q_PENDING_VAL) {
+		while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL)
+			cpu_relax();
+	}
+
+	/*
 	 * trylock || pending
 	 *
 	 * 0,0,0 -> 0,0,1 ; trylock
