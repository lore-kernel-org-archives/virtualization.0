From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
Date: Wed, 6 Jul 2016 20:08:00 +0800
Message-ID: <CANRm+CwXLsNrC59g6tZk=U+T0Scn_O=b60NPESJXU6uaP7-AsA@mail.gmail.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20160706065255.GH30909@twins.programming.kicks-ass.net>
	<14a24854-9787-e4a1-c9a8-76eba4e97301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <14a24854-9787-e4a1-c9a8-76eba4e97301@redhat.com>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, benh@kernel.crashing.org, kvm <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, boqun.feng@gmail.com, will.deacon@arm.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Waiman Long <waiman.long@hpe.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, mpe@ellerman.id.au, schwidefsky@de.ibm.com, Paul McKenney <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

2016-07-06 18:44 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>
>
> On 06/07/2016 08:52, Peter Zijlstra wrote:
>> On Tue, Jun 28, 2016 at 10:43:07AM -0400, Pan Xinhui wrote:
>>> change fomr v1:
>>>      a simplier definition of default vcpu_is_preempted
>>>      skip mahcine type check on ppc, and add config. remove dedicated macro.
>>>      add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner.
>>>      add more comments
>>>      thanks boqun and Peter's suggestion.
>>>
>>> This patch set aims to fix lock holder preemption issues.
>>>
>>> test-case:
>>> perf record -a perf bench sched messaging -g 400 -p && perf report
>>>
>>> 18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
>>> 12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
>>>  5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
>>>  3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
>>>  3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
>>>  3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
>>>  2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call
>>>
>>> We introduce interface bool vcpu_is_preempted(int cpu) and use it in some spin
>>> loops of osq_lock, rwsem_spin_on_owner and mutex_spin_on_owner.
>>> These spin_on_onwer variant also cause rcu stall before we apply this patch set
>>>
>>
>> Paolo, could you help out with an (x86) KVM interface for this?
>
> If it's just for spin loops, you can check if the version field in the
> steal time structure has changed.

Steal time will not be updated until ahead of next vmentry except
wrmsr MSR_KVM_STEAL_TIME. So it can't represent it is preempted
currently, right?

Regards,
Wanpeng Li
