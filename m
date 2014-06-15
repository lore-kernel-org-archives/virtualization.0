From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v11 06/16] qspinlock: prolong the stay in the pending bit
	path
Date: Sun, 15 Jun 2014 15:12:55 +0200
Message-ID: <20140615131255.GH11371__29073.945436585$1402838034$gmane$org@laptop.programming.kicks-ass.net>
References: <1401464642-33890-1-git-send-email-Waiman.Long@hp.com>
	<1401464642-33890-7-git-send-email-Waiman.Long@hp.com>
	<20140611102606.GK3213@twins.programming.kicks-ass.net>
	<5398C894.6040808@hp.com>
	<20140612060032.GQ6758@twins.programming.kicks-ass.net>
	<539A139C.50400@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <539A139C.50400@hp.com>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 12, 2014 at 04:54:52PM -0400, Waiman Long wrote:
> If two tasks see the pending bit goes away and try to grab it with cmpxchg,
> there is no way we can avoid the contention. However, if some how the
> pending bit holder get the lock and another task set the pending bit before
> the current task, the spinlock value will become
> _Q_PENDING_VAL|_Q_LOCKED_VAL. The while loop will end and the code will
> blindly try to do a cmpxchg unless we check for this case before hand. This
> is what my code does by going back to the beginning of the for loop.

There is already a test for that; see the goto queue;

---

	/*
	 * wait for in-progress pending->locked hand-overs
	 *
	 * 0,1,0 -> 0,0,1
	 */
	if (val == _Q_PENDING_VAL) {
		while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL)
			cpu_relax();
	}

	/*
	 * trylock || pending
	 *
	 * 0,0,0 -> 0,0,1 ; trylock
	 * 0,0,1 -> 0,1,1 ; pending
	 */
	for (;;) {
		/*
		 * If we observe any contention; queue.
		 */
		if (val & ~_Q_LOCKED_MASK)
			goto queue;

		new = _Q_LOCKED_VAL;
		if (val == new)
			new |= _Q_PENDING_VAL;

		old = atomic_cmpxchg(&lock->val, val, new);
		if (old == val)
			break;

		val = old;
	}
