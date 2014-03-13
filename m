From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH RFC v6 09/11] pvqspinlock,
	x86: Add qspinlock para-virtualization support
Date: Thu, 13 Mar 2014 15:49:16 -0400
Message-ID: <53220BBC.4040608__42164.3482325182$1394740203$gmane$org@hp.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>	<1394650498-30118-10-git-send-email-Waiman.Long@hp.com>
	<5321949F.1010103@citrix.com> <5321B959.5050305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5321B959.5050305@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>Oleg Nesterov <ol>
List-Id: virtualization@lists.linuxfoundation.org

On 03/13/2014 09:57 AM, Paolo Bonzini wrote:
> Il 13/03/2014 12:21, David Vrabel ha scritto:
>> On 12/03/14 18:54, Waiman Long wrote:
>>> This patch adds para-virtualization support to the queue spinlock in
>>> the same way as was done in the PV ticket lock code. In essence, the
>>> lock waiters will spin for a specified number of times (QSPIN_THRESHOLD
>>> = 2^14) and then halted itself. The queue head waiter will spins
>>> 2*QSPIN_THRESHOLD times before halting itself. When it has spinned
>>> QSPIN_THRESHOLD times, the queue head will assume that the lock
>>> holder may be scheduled out and attempt to kick the lock holder CPU
>>> if it has the CPU number on hand.
>>
>> I don't really understand the reasoning for kicking the lock holder.
>
> I agree.  If the lock holder isn't running, there's probably a good 
> reason for that and going to sleep will not necessarily convince the 
> scheduler to give more CPU to the lock holder.  I think there are two 
> choices:
>
> 1) use yield_to to donate part of the waiter's quantum to the lock 
> holder?    For this we probably need a new, separate hypercall 
> interface.  For KVM it would be the same as hlt in the guest but with 
> an additional yield_to in the host.
>
> 2) do nothing, just go to sleep.
>
> Could you get (or do you have) numbers for (2)?

I will take out the lock holder kick portion from the patch. I will also 
try to collect more test data.

>
> More important, I think a barrier is missing:
>
>     Lock holder ---------------------------------------
>
>     // queue_spin_unlock
>     barrier();
>     ACCESS_ONCE(qlock->lock) = 0;
>     barrier();
>

This is not the unlock code that is used when PV spinlock is enabled. 
The right unlock code is

         if (static_key_false(&paravirt_spinlocks_enabled)) {
                 /*
                  * Need to atomically clear the lock byte to avoid 
racing with
                  * queue head waiter trying to set 
_QSPINLOCK_LOCKED_SLOWPATH.
                  */
                 if (likely(cmpxchg(&qlock->lock, _QSPINLOCK_LOCKED, 0)
                                 == _QSPINLOCK_LOCKED))
                         return;
                 else
                         queue_spin_unlock_slowpath(lock);

         } else {
                 __queue_spin_unlock(lock);
         }

>     // pv_kick_node:
>     if (pv->cpustate != PV_CPU_HALTED)
>         return;
>     ACCESS_ONCE(pv->cpustate) = PV_CPU_KICKED;
>     __queue_kick_cpu(pv->mycpu, PV_KICK_QUEUE_HEAD);
>
>         Waiter -------------------------------------------
>
>         // pv_head_spin_check
>         ACCESS_ONCE(pv->cpustate) = PV_CPU_HALTED;
>         lockval = cmpxchg(&qlock->lock,
>                   _QSPINLOCK_LOCKED,
>                   _QSPINLOCK_LOCKED_SLOWPATH);
>         if (lockval == 0) {
>             /*
>              * Can exit now as the lock is free
>              */
>             ACCESS_ONCE(pv->cpustate) = PV_CPU_ACTIVE;
>             *count = 0;
>             return;
>         }
>         __queue_hibernate();
>
> Nothing protects from writing qlock->lock before pv->cpustate is read, 
> leading to this:
>
>     Lock holder            Waiter
>     ---------------------------------------------------------------
>     read pv->cpustate
>         (it is PV_CPU_ACTIVE)
>                     pv->cpustate = PV_CPU_HALTED
>                     lockval = cmpxchg(...)
>                     hibernate()
>     qlock->lock = 0
>     if (pv->cpustate != PV_CPU_HALTED)
>         return;
>

The lock holder will read cpustate only if the lock byte has been 
changed to _QSPINLOCK_LOCKED_SLOWPATH. So the setting of the lock byte 
synchronize the 2 threads. The only thing that I am not certain is when 
the waiter is trying to go to sleep while, at the same time, the lock 
holder is trying to kick it. Will there be a missed wakeup because of 
this timing issue?

-Longman
