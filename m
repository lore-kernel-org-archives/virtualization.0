From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
Date: Fri, 30 Sep 2016 11:08:10 +0200
Message-ID: <f0e8b549-e647-6a01-a93d-9f192adc70c6__30832.6691658751$1475226525$gmane$org@redhat.com>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20160929101040.GV5016@twins.programming.kicks-ass.net>
	<166f3bad-f700-4624-6c1c-996f90ad609c@de.ibm.com>
	<20160929103133.GW5016@twins.programming.kicks-ass.net>
	<496ba299-1f1d-e98b-7827-f861eeea5558@linux.vnet.ibm.com>
	<2136938368.606190.1475218738567.JavaMail.zimbra@redhat.com>
	<caabadb6-fe62-aaf7-260f-79f230d03a1c@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <caabadb6-fe62-aaf7-260f-79f230d03a1c@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, benh@kernel.crashing.org, jgross@suse.com, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, will deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, xen-devel-request@lists.xenproject.org, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org



On 30/09/2016 10:52, Pan Xinhui wrote:
>> x86 has no hypervisor support, and I'd like to understand the desired
>> semantics first, so I don't think it should block this series.  In
> 
> Once a guest do a hypercall or something similar, IOW, there is a
> kvm_guest_exit. we think this is a lock holder preemption.
> Adn PPC implement it in this way.

Ok, good.

>> particular, there are at least the following choices:
>>
>> 1) exit to userspace (5-10.000 clock cycles best case) counts as
>> lock holder preemption
>>
>> 2) any time the vCPU thread not running counts as lock holder
>> preemption
>>
>> To implement the latter you'd need a hypercall or MSR (at least as
>> a slow path), because the KVM preempt notifier is only active
>> during the KVM_RUN ioctl.
>
> seems a little expensive. :(
> How many clock cycles it might cost.

An MSR read is about 1500 clock cycles, but it need not be the fast path
(e.g. use a bit to check if the CPU is running, if not use the MSR to
check if the CPU is in userspace but the CPU thread is scheduled).  But
it's not necessary if you are just matching PPC semantics.

Then the simplest thing is to use the kvm_steal_time struct, and add a
new field to it that replaces pad[0].  You can write a 0 to the flag in
record_steal_time (not preempted) and a 1 in kvm_arch_vcpu_put
(preempted).  record_steal_time is called before the VM starts running,
immediately after KVM_RUN and also after every sched_in.

If KVM doesn't implement the flag, it won't touch that field at all.  So
the kernel can write a 0, meaning "not preempted", and not care if the
hypervisor implements the flag or not: the answer will always be safe.

The pointer to the flag can be placed in a per-cpu u32*, and again if
the u32* is NULL that means "not preempted".

Paolo


> I am still looking for one shared struct between kvm and guest kernel on
> x86.
> and every time kvm_guest_exit/enter called, we store some info in it. So
> guest kernel can check one vcpu is running or not quickly.
> 
> thanks
> xinhui
> 
>> Paolo
>>
> 
