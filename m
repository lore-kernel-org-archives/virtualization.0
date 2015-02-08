From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Sun, 8 Feb 2015 18:14:57 +0100
Message-ID: <20150208171457.GA18766@redhat.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<54D4DBA1.1030905@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <54D4DBA1.1030905@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <sasha.levin@oracle.com>
Cc: jeremy@goop.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, borntraeger@de.ibm.com, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, davej@redhat.com, tglx@linutronix.de, waiman.long@hp.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/06, Sasha Levin wrote:
>
> Can we modify it slightly to avoid potentially accessing invalid memory:
> 
> diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
> index 5315887..cd22d73 100644
> --- a/arch/x86/include/asm/spinlock.h
> +++ b/arch/x86/include/asm/spinlock.h
> @@ -144,13 +144,13 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock
>         if (TICKET_SLOWPATH_FLAG &&
>                 static_key_false(&paravirt_ticketlocks_enabled)) {
>                 __ticket_t prev_head;
> -
> +               bool needs_kick = lock->tickets.tail & TICKET_SLOWPATH_FLAG;
>                 prev_head = lock->tickets.head;
>                 add_smp(&lock->tickets.head, TICKET_LOCK_INC);
> 
>                 /* add_smp() is a full mb() */
> 
> -               if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG)) {
> +               if (unlikely(needs_kick)) {

This doesn't look right too...

We need to guarantee that either unlock() sees TICKET_SLOWPATH_FLAG, or
the calller of __ticket_enter_slowpath() sees the result of add_smp().

Suppose that kvm_lock_spinning() is called right before add_smp() and it
sets SLOWPATH. It will block then because .head != want, and it needs
__ticket_unlock_kick().

Oleg.
