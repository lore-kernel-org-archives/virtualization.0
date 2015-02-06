From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Fri, 06 Feb 2015 10:20:01 -0500
Message-ID: <54D4DBA1.1030905@oracle.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, torvalds@linux-foundation.org
Cc: waiman.long@hp.com, jeremy@goop.org, ak@linux.intel.com, a.ryabinin@samsung.com, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, konrad.wilk@oracle.com, riel@redhat.com, x86@kernel.org, oleg@redhat.com, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, davej@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On 02/06/2015 09:49 AM, Raghavendra K T wrote:
>  static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
>  {
>  	if (TICKET_SLOWPATH_FLAG &&
> -	    static_key_false(&paravirt_ticketlocks_enabled)) {
> -		arch_spinlock_t prev;
> +		static_key_false(&paravirt_ticketlocks_enabled)) {
> +		__ticket_t prev_head;
>  
> -		prev = *lock;
> +		prev_head = lock->tickets.head;
>  		add_smp(&lock->tickets.head, TICKET_LOCK_INC);
>  
>  		/* add_smp() is a full mb() */
>  
> -		if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG))
> -			__ticket_unlock_slowpath(lock, prev);
> +		if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG)) {
> +			BUILD_BUG_ON(((__ticket_t)NR_CPUS) != NR_CPUS);
> +			__ticket_unlock_kick(lock, prev_head);

Can we modify it slightly to avoid potentially accessing invalid memory:

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 5315887..cd22d73 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -144,13 +144,13 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock
        if (TICKET_SLOWPATH_FLAG &&
                static_key_false(&paravirt_ticketlocks_enabled)) {
                __ticket_t prev_head;
-
+               bool needs_kick = lock->tickets.tail & TICKET_SLOWPATH_FLAG;
                prev_head = lock->tickets.head;
                add_smp(&lock->tickets.head, TICKET_LOCK_INC);

                /* add_smp() is a full mb() */

-               if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG)) {
+               if (unlikely(needs_kick)) {
                        BUILD_BUG_ON(((__ticket_t)NR_CPUS) != NR_CPUS);
                        __ticket_unlock_kick(lock, prev_head);
                }


Thanks,
Sasha
