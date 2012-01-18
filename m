From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC V4 4/5] kvm : pv-ticketlocks support for linux guests
	running on KVM hypervisor
Date: Wed, 18 Jan 2012 12:34:42 +1100
Message-ID: <4F1621B2.3020203@goop.org>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182645.8604.68884.sendpatchset@oc5400248562.ibm.com>
	<20120117110210.GA17420@amt.cnet>
	<20120117113312.GB30398@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120117113312.GB30398@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Cc: X86 <x86@kernel.org>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 01/17/2012 10:33 PM, Srivatsa Vaddagiri wrote:
> * Marcelo Tosatti <mtosatti@redhat.com> [2012-01-17 09:02:11]:
>
>>> +/* Kick vcpu waiting on @lock->head to reach value @ticket */
>>> +static void kvm_unlock_kick(struct arch_spinlock *lock, __ticket_t ticket)
>>> +{
>>> +	int cpu;
>>> +	int apicid;
>>> +
>>> +	add_stats(RELEASED_SLOW, 1);
>>> +
>>> +	for_each_cpu(cpu, &waiting_cpus) {
>>> +		const struct kvm_lock_waiting *w = &per_cpu(lock_waiting, cpu);
>>> +		if (ACCESS_ONCE(w->lock) == lock &&
>>> +		    ACCESS_ONCE(w->want) == ticket) {
>>> +			add_stats(RELEASED_SLOW_KICKED, 1);
>>> +			apicid = per_cpu(x86_cpu_to_apicid, cpu);
>>> +			kvm_kick_cpu(apicid);
>>> +			break;
>>> +		}
>>> +	}
>> What prevents a kick from being lost here, if say, the waiter is at
>> local_irq_save in kvm_lock_spinning, before the lock/want assignments?
> The waiter does check for lock becoming available before actually
> sleeping:
>
> +	/*
> +        * check again make sure it didn't become free while
> +        * we weren't looking.
> +        */
> +	if (ACCESS_ONCE(lock->tickets.head) == want) {
> +               add_stats(TAKEN_SLOW_PICKUP, 1);
> +               goto out;
> +	}

That logic relies on the "kick" being level triggered, so that "kick"
before "block" will cause the block to fall out immediately.  If you're
using "hlt" as the block and it has the usual edge-triggered behaviour,
what stops a "kick-before-hlt" from losing the kick?

    J
