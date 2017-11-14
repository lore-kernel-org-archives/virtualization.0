From: Quan Xu <quan.xu0@gmail.com>
Subject: Re: [PATCH RFC v3 1/6] x86/paravirt: Add pv_idle_ops to paravirt ops
Date: Tue, 14 Nov 2017 18:23:30 +0800
Message-ID: <a3e93939-0458-5182-464e-3de788f448d4__16979.3117013343$1511414871$gmane$org@gmail.com>
References: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
	<1510567565-5118-2-git-send-email-quan.xu0@gmail.com>
	<07fac696-e3d4-8f35-8f3d-764d7ab41204@suse.com>
	<902da704-1e4f-583b-91c3-1a62ccd6e73d@gmail.com>
	<CANRm+CxirO0aSAQnOfPG0+KPCOnXf3SEASwBiprLmtncZE53pA@mail.gmail.com>
	<d233b179-9815-0134-ef04-c492f9523121@gmail.com>
	<CANRm+Cycx3ewegOXR7c70kpdsaJA-=M5QztDt4J2L=VqpeCsfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CANRm+Cycx3ewegOXR7c70kpdsaJA-=M5QztDt4J2L=VqpeCsfQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, Yang Zhang <yang.zhang.wz@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, kvm <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Quan Xu <quan.xu03@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org



On 2017/11/14 16:22, Wanpeng Li wrote:
> 2017-11-14 16:15 GMT+08:00 Quan Xu <quan.xu0@gmail.com>:
>>
>> On 2017/11/14 15:12, Wanpeng Li wrote:
>>> 2017-11-14 15:02 GMT+08:00 Quan Xu <quan.xu0@gmail.com>:
>>>>
>>>> On 2017/11/13 18:53, Juergen Gross wrote:
>>>>> On 13/11/17 11:06, Quan Xu wrote:
>>>>>> From: Quan Xu <quan.xu0@gmail.com>
>>>>>>
>>>>>> So far, pv_idle_ops.poll is the only ops for pv_idle. .poll is called
>>>>>> in idle path which will poll for a while before we enter the real idle
>>>>>> state.
>>>>>>
>>>>>> In virtualization, idle path includes several heavy operations
>>>>>> includes timer access(LAPIC timer or TSC deadline timer) which will
>>>>>> hurt performance especially for latency intensive workload like message
>>>>>> passing task. The cost is mainly from the vmexit which is a hardware
>>>>>> context switch between virtual machine and hypervisor. Our solution is
>>>>>> to poll for a while and do not enter real idle path if we can get the
>>>>>> schedule event during polling.
>>>>>>
>>>>>> Poll may cause the CPU waste so we adopt a smart polling mechanism to
>>>>>> reduce the useless poll.
>>>>>>
>>>>>> Signed-off-by: Yang Zhang <yang.zhang.wz@gmail.com>
>>>>>> Signed-off-by: Quan Xu <quan.xu0@gmail.com>
>>>>>> Cc: Juergen Gross <jgross@suse.com>
>>>>>> Cc: Alok Kataria <akataria@vmware.com>
>>>>>> Cc: Rusty Russell <rusty@rustcorp.com.au>
>>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>>>>> Cc: x86@kernel.org
>>>>>> Cc: virtualization@lists.linux-foundation.org
>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>> Cc: xen-devel@lists.xenproject.org
>>>>> Hmm, is the idle entry path really so critical to performance that a new
>>>>> pvops function is necessary?
>>>> Juergen, Here is the data we get when running benchmark netperf:
>>>>    1. w/o patch and disable kvm dynamic poll (halt_poll_ns=0):
>>>>       29031.6 bit/s -- 76.1 %CPU
>>>>
>>>>    2. w/ patch and disable kvm dynamic poll (halt_poll_ns=0):
>>>>       35787.7 bit/s -- 129.4 %CPU
>>>>
>>>>    3. w/ kvm dynamic poll:
>>>>       35735.6 bit/s -- 200.0 %CPU
>>> Actually we can reduce the CPU utilization by sleeping a period of
>>> time as what has already been done in the poll logic of IO subsystem,
>>> then we can improve the algorithm in kvm instead of introduing another
>>> duplicate one in the kvm guest.
>> We really appreciate upstream's kvm dynamic poll mechanism, which is
>> really helpful for a lot of scenario..
>>
>> However, as description said, in virtualization, idle path includes
>> several heavy operations includes timer access (LAPIC timer or TSC
>> deadline timer) which will hurt performance especially for latency
>> intensive workload like message passing task. The cost is mainly from
>> the vmexit which is a hardware context switch between virtual machine
>> and hypervisor.
>>
>> for upstream's kvm dynamic poll mechanism, even you could provide a
>> better algorism, how could you bypass timer access (LAPIC timer or TSC
>> deadline timer), or a hardware context switch between virtual machine
>> and hypervisor. I know these is a tradeoff.
>>
>> Furthermore, here is the data we get when running benchmark contextswitch
>> to measure the latency(lower is better):
>>
>> 1. w/o patch and disable kvm dynamic poll (halt_poll_ns=0):
>>    3402.9 ns/ctxsw -- 199.8 %CPU
>>
>> 2. w/ patch and disable kvm dynamic poll:
>>    1163.5 ns/ctxsw -- 205.5 %CPU
>>
>> 3. w/ kvm dynamic poll:
>>    2280.6 ns/ctxsw -- 199.5 %CPU
>>
>> so, these tow solution are quite similar, but not duplicate..
>>
>> that's also why to add a generic idle poll before enter real idle path.
>> When a reschedule event is pending, we can bypass the real idle path.
>>
> There is a similar logic in the idle governor/driver, so how this
> patchset influence the decision in the idle governor/driver when
> running on bare-metal(power managment is not exposed to the guest so
> we will not enter into idle driver in the guest)?
>

This is expected to take effect only when running as a virtual machine with
proper CONFIG_* enabled. This can not work on bare mental even with proper
CONFIG_* enabled.

Quan
Alibaba Cloud
