From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH V2] x86 spinlock: Fix memory corruption on completing
	completions
Date: Mon, 9 Feb 2015 16:14:59 +0100
Message-ID: <20150209151459.GA973@redhat.com>
References: <1423485611-18369-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1423485611-18369-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: jeremy@goop.org, kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, borntraeger@de.ibm.com, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, sasha.levin@oracle.com, davej@redhat.com, tglx@linutronix.de, waiman.long@hp.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/09, Raghavendra K T wrote:
>
> +static inline void __ticket_check_and_clear_slowpath(arch_spinlock_t *lock)
> +{
> +	arch_spinlock_t old, new;
> +	__ticket_t diff;
> +
> +	old.tickets = READ_ONCE(lock->tickets);
> +	diff = (old.tickets.tail & ~TICKET_SLOWPATH_FLAG) - old.tickets.head;
> +
> +	/* try to clear slowpath flag when there are no contenders */
> +	if ((old.tickets.tail & TICKET_SLOWPATH_FLAG) &&
> +		(diff == TICKET_LOCK_INC)) {
> +		new = old;
> +		new.tickets.tail &= ~TICKET_SLOWPATH_FLAG;
> +		cmpxchg(&lock->head_tail, old.head_tail, new.head_tail);
> +	}
> +}

Can't we simplify it? We own .head, and we already know it. We only need
to clear TICKET_SLOWPATH_FLAG in .tail atomically?

IOW,

	static inline void __ticket_check_and_clear_slowpath(arch_spinlock_t *lock, __ticket_t head)
	{
		__ticket_t old_tail, new_tail;

		new_tail = head + TICKET_LOCK_INC;
		old_tail = new_tail | TICKET_SLOWPATH_FLAG;

		if (READ_ONCE(lock->tickets.tail) == old_tail)
			cmpxchg(&lock->tickets.tail, old_tail, new_tail);
	}

Plus

	-	__ticket_check_and_clear_slowpath(lock);
	+	__ticket_check_and_clear_slowpath(lock, inc.tail);

Or I missed something?

And I think it would be better to avoid ifdef(CONFIG_PARAVIRT_SPINLOCKS),
ww can just do

	if (TICKET_SLOWPATH_FLAG)
		__ticket_check_and_clear_slowpath();

Oleg.
