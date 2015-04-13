From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v15 09/15] pvqspinlock: Implement simple paravirt support
	for the qspinlock
Date: Mon, 13 Apr 2015 17:08:32 +0200
Message-ID: <20150413150832.GH5029__3859.18058823354$1428937748$gmane$org@twins.programming.kicks-ass.net>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
	<1428375350-9213-10-git-send-email-Waiman.Long@hp.com>
	<20150409181327.GY5029@twins.programming.kicks-ass.net>
	<5526F218.2070909@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5526F218.2070909@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 09, 2015 at 05:41:44PM -0400, Waiman Long wrote:

> >>+static void pv_wait_head(struct qspinlock *lock, struct mcs_spinlock *node)
> >>+{
> >>+	struct __qspinlock *l = (void *)lock;
> >>+	struct qspinlock **lp = NULL;
> >>+	struct pv_node *pn = (struct pv_node *)node;
> >>+	int slow_set = false;
> >>+	int loop;
> >>+
> >>+	for (;;) {
> >>+		for (loop = SPIN_THRESHOLD; loop; loop--) {
> >>+			if (!READ_ONCE(l->locked))
> >>+				return;
> >>+
> >>+			cpu_relax();
> >>+		}
> >>+
> >>+		WRITE_ONCE(pn->state, vcpu_halted);
> >>+		if (!lp)
> >>+			lp = pv_hash(lock, pn);
> >>+		/*
> >>+		 * lp must be set before setting _Q_SLOW_VAL
> >>+		 *
> >>+		 * [S] lp = lock                [RmW] l = l->locked = 0
> >>+		 *     MB                             MB
> >>+		 * [S] l->locked = _Q_SLOW_VAL  [L]   lp
> >>+		 *
> >>+		 * Matches the cmpxchg() in pv_queue_spin_unlock().
> >>+		 */
> >>+		if (!slow_set&&
> >>+		    !cmpxchg(&l->locked, _Q_LOCKED_VAL, _Q_SLOW_VAL)) {
> >>+			/*
> >>+			 * The lock is free and _Q_SLOW_VAL has never been
> >>+			 * set. Need to clear the hash bucket before getting
> >>+			 * the lock.
> >>+			 */
> >>+			WRITE_ONCE(*lp, NULL);
> >>+			return;
> >>+		} else if (slow_set&&  !READ_ONCE(l->locked))
> >>+			return;
> >>+		slow_set = true;

> >I'm somewhat puzzled by the slow_set thing; what is wrong with the thing
> >I had, namely:
> >
> >		if (!lp) {
> >			lp = pv_hash(lock, pn);
> >
> >			/*
> >			 * comment
> >			 */
> >			lv = cmpxchg(&l->locked, _Q_LOCKED_VAL, _Q_SLOW_VAL);
> >			if (lv != _Q_LOCKED_VAL) {
> >				/* we're woken, unhash and return */
> >				WRITE_ONCE(*lp, NULL);
> >				return;
> >			}
> >		}
> >>+
> >>+		pv_wait(&l->locked, _Q_SLOW_VAL);
> >
> >If we get a spurious wakeup (due to device interrupts or random kick)
> >we'll loop around but ->locked will remain _Q_SLOW_VAL.
> 
> The purpose of the slow_set flag is not about the lock value. It is to make
> sure that pv_hash_find() will always find a match. Consider the following
> scenario:
> 
> cpu1            cpu2                    cpu3
> ----            ----                    ----
> pv_wait
> spurious wakeup
> loop l->locked
> 
>                 read _Q_SLOW_VAL
>                 pv_hash_find()
>                 unlock
> 
>                                         pv_hash() <- same entry
> 
> cmpxchg(&l->locked)
> clear hash (?)
> 
> Here, the entry for cpu3 will be removed leading to panic when
> pv_hash_find() can find the entry. So the hash entry can only be
> removed if the other cpu has no chance to see _Q_SLOW_VAL.

Still confused. Afaict that cannot happen with my code. We only do the
cmpxchg(, _Q_SLOW_VAL) _once_.

Only on the first time around that loop will we hash the lock and set
the slow flag. And cpu3 cannot come in on the same entry because we've
not yet released the lock when we find and unhash.
