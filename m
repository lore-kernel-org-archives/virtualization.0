From: Attilio Rao <attilio.rao@citrix.com>
Subject: Re: [PATCH RFC V6 1/11]  x86/spinlock: replace pv spinlocks with
	pv ticketlocks
Date: Wed, 21 Mar 2012 13:49:28 +0000
Message-ID: <4F69DC68.6080200__44747.7196496495$1332355462$gmane$org@citrix.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<20120321102052.473.40193.sendpatchset@codeblue.in.ibm.com>
	<4F69D1D9.9080107@citrix.com> <2425963.NBpIGX9T40@chlor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2425963.NBpIGX9T40@chlor>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Virtualization <virtualization@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On 21/03/12 13:22, Stephan Diestelhorst wrote:
> On Wednesday 21 March 2012, 13:04:25 Attilio Rao wrote:
>    
>> On 21/03/12 10:20, Raghavendra K T wrote:
>>      
>>> From: Jeremy Fitzhardinge<jeremy.fitzhardinge@citrix.com>
>>>
>>> Rather than outright replacing the entire spinlock implementation in
>>> order to paravirtualize it, keep the ticket lock implementation but add
>>> a couple of pvops hooks on the slow patch (long spin on lock, unlocking
>>> a contended lock).
>>>
>>> Ticket locks have a number of nice properties, but they also have some
>>> surprising behaviours in virtual environments.  They enforce a strict
>>> FIFO ordering on cpus trying to take a lock; however, if the hypervisor
>>> scheduler does not schedule the cpus in the correct order, the system can
>>> waste a huge amount of time spinning until the next cpu can take the lock.
>>>
>>> (See Thomas Friebel's talk "Prevent Guests from Spinning Around"
>>> http://www.xen.org/files/xensummitboston08/LHP.pdf  for more details.)
>>>
>>> To address this, we add two hooks:
>>>    - __ticket_spin_lock which is called after the cpu has been
>>>      spinning on the lock for a significant number of iterations but has
>>>      failed to take the lock (presumably because the cpu holding the lock
>>>      has been descheduled).  The lock_spinning pvop is expected to block
>>>      the cpu until it has been kicked by the current lock holder.
>>>    - __ticket_spin_unlock, which on releasing a contended lock
>>>      (there are more cpus with tail tickets), it looks to see if the next
>>>      cpu is blocked and wakes it if so.
>>>
>>> When compiled with CONFIG_PARAVIRT_SPINLOCKS disabled, a set of stub
>>> functions causes all the extra code to go away.
>>>
>>>        
>> I've made some real world benchmarks based on this serie of patches
>> applied on top of a vanilla Linux-3.3-rc6 (commit
>> 4704fe65e55fb088fbcb1dc0b15ff7cc8bff3685), with both
>> CONFIG_PARAVIRT_SPINLOCK=y and n, which means essentially 4 versions
>> compared:
>> * vanilla - CONFIG_PARAVIRT_SPINLOCK - patch
>> * vanilla + CONFIG_PARAVIRT_SPINLOCK - patch
>> * vanilla - CONFIG_PARAVIRT_SPINLOCK + patch
>> * vanilla + CONFIG_PARAVIRT_SPINLOCK + patch
>>
>>      
> [...]
>    
>> == Results
>> This test points in the direction that Jeremy's rebased patches don't
>> introduce a peformance penalty at all, but also that we could likely
>> consider CONFIG_PARAVIRT_SPINLOCK option removal, or turn it on by
>> default and suggest disabling just on very old CPUs (assuming a
>> performance regression can be proven there).
>>      
> Very interesting results, in particular knowing that in the one guest
> case things do not get (significantly) slower due to the added logic
> and LOCKed RMW in the unlock path.
>
> AFAICR, the problem really became apparent when running multiple guests
> time sharing the physical CPUs, i.e., two guests with eight vCPUs each
> on an eight core machine.  Did you look at this setup with your tests?
>
>    

Please note that my tests are made on native Linux, without XEN involvement.

You maybe meant that the spinlock paravirtualization became generally 
useful in the case you mentioned? (2 guests, 8vpcu + 8vcpu)?

Attilio
