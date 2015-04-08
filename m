From: Waiman Long <waiman.long@hp.com>
Subject: Re: [Xen-devel] [PATCH v15 12/15] pvqspinlock,
	x86: Enable PV qspinlock for Xen
Date: Wed, 08 Apr 2015 13:42:49 -0400
Message-ID: <55256899.4040603__38717.211111407$1428515001$gmane$org@hp.com>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
	<1428375350-9213-13-git-send-email-Waiman.Long@hp.com>
	<552518A0.10205@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <552518A0.10205@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, x86@kernel.org, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Daniel J Blueman <daniel@numascale.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, Ingo Molnar <mingo@redhat.com>, Douglas Hatch <doug.hatch@hp.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/08/2015 08:01 AM, David Vrabel wrote:
> On 07/04/15 03:55, Waiman Long wrote:
>> This patch adds the necessary Xen specific code to allow Xen to
>> support the CPU halting and kicking operations needed by the queue
>> spinlock PV code.
> This basically looks the same as the version I wrote, except I think you
> broke it.
>
>> +static void xen_qlock_wait(u8 *byte, u8 val)
>> +{
>> +	int irq = __this_cpu_read(lock_kicker_irq);
>> +
>> +	/* If kicker interrupts not initialized yet, just spin */
>> +	if (irq == -1)
>> +		return;
>> +
>> +	/* clear pending */
>> +	xen_clear_irq_pending(irq);
>> +
>> +	/*
>> +	 * We check the byte value after clearing pending IRQ to make sure
>> +	 * that we won't miss a wakeup event because of the clearing.
> My version had a barrier() here to ensure this.  The documentation of
> READ_ONCE() suggests that it is not sufficient to meet this requirement
> (and a READ_ONCE() here is not required anyway).

I have the misconception that a READ_ONCE/WRITE_ONCE() implies a 
compiler barrier. You are right that it may not be the case. I will add 
back the missing barrier when I update the patch and add you as the 
author of this patch if you don't mind.

Cheers,
Longman
