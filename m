From: David Vrabel <dvrabel@cantab.net>
Subject: Re: [Xen-devel] [PATCH V5] x86 spinlock: Fix memory corruption on
	completing completions
Date: Mon, 16 Feb 2015 16:47:12 +0000
Message-ID: <54E21F10.1040402@cantab.net>
References: <1423979744-18320-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20150215173043.GA7471@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150215173043.GA7471@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, torvalds@linux-foundation.org, konrad.wilk@oracle.com, pbonzini@redhat.com
Cc: waiman.long@hp.com, jeremy@goop.org, ak@linux.intel.com, kvm@vger.kernel.org, paul.gortmaker@windriver.com, a.ryabinin@samsung.com, x86@kernel.org, oleg@redhat.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, dave@stgolabs.net, davej@redhat.com, xen-devel@lists.xenproject.org, akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, sasha.levin@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On 15/02/15 17:30, Raghavendra K T wrote:
> --- a/arch/x86/xen/spinlock.c
> +++ b/arch/x86/xen/spinlock.c
> @@ -41,7 +41,7 @@ static u8 zero_stats;
>  static inline void check_zero(void)
>  {
>  	u8 ret;
> -	u8 old = ACCESS_ONCE(zero_stats);
> +	u8 old = READ_ONCE(zero_stats);
>  	if (unlikely(old)) {
>  		ret = cmpxchg(&zero_stats, old, 0);
>  		/* This ensures only one fellow resets the stat */
> @@ -112,6 +112,7 @@ __visible void xen_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
>  	struct xen_lock_waiting *w = this_cpu_ptr(&lock_waiting);
>  	int cpu = smp_processor_id();
>  	u64 start;
> +	__ticket_t head;
>  	unsigned long flags;
>  
>  	/* If kicker interrupts not initialized yet, just spin */
> @@ -159,11 +160,15 @@ __visible void xen_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
>  	 */
>  	__ticket_enter_slowpath(lock);
>  
> +	/* make sure enter_slowpath, which is atomic does not cross the read */
> +	smp_mb__after_atomic();
> +
>  	/*
>  	 * check again make sure it didn't become free while
>  	 * we weren't looking
>  	 */
> -	if (ACCESS_ONCE(lock->tickets.head) == want) {
> +	head = READ_ONCE(lock->tickets.head);
> +	if (__tickets_equal(head, want)) {
>  		add_stats(TAKEN_SLOW_PICKUP, 1);
>  		goto out;
>  	}
> @@ -204,8 +209,8 @@ static void xen_unlock_kick(struct arch_spinlock *lock, __ticket_t next)
>  		const struct xen_lock_waiting *w = &per_cpu(lock_waiting, cpu);
>  
>  		/* Make sure we read lock before want */
> -		if (ACCESS_ONCE(w->lock) == lock &&
> -		    ACCESS_ONCE(w->want) == next) {
> +		if (READ_ONCE(w->lock) == lock &&
> +		    READ_ONCE(w->want) == next) {
>  			add_stats(RELEASED_SLOW_KICKED, 1);
>  			xen_send_IPI_one(cpu, XEN_SPIN_UNLOCK_VECTOR);
>  			break;

Acked-by: David Vrabel <david.vrabel@citrix.com>

Although some of the ACCESS_ONCE to READ_ONCE changes are cosmetic and
are perhaps best left out of a patch destined for stable.

David
